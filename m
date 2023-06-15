Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15D7730FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbjFOGuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244452AbjFOGtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:50 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87DB4204;
        Wed, 14 Jun 2023 23:48:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9BC5332009F9;
        Thu, 15 Jun 2023 02:48:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Jun 2023 02:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686811716; x=1686898116; bh=g5
        P+F4WPLTq7am0FNx519f1VIiU+iFLrOmjrcmEUm4I=; b=RkgUcIOo/uA+ucHijs
        qM4QhihSHunjSQcUtJJJydJp4PLK9B4kJSIiBGWek5wfDN2E7agy7nM3zKiZo/Bz
        IAR4k7hNPkRx2BdzoXYIIPN9UfELVEEz+o0HzJnsh6JMp3dNYkOKIPiu4qj4HmkX
        b5d2khQTE2ZDeExBAqq34SGaX58g3ukxZ4mOxVFGvewqhB/BA1N4OUxCm1r9Q94+
        z54EWKLzKoCtFQ8CIzejSBprgz8exqqh3gDWY9ANVb/6MPj8hsmv76vy2w144+Fm
        b6ftRDxre4gAvd16mb2KB7xXGRhevYHOuklNgLOR7WNY2tv/ADNGf92ICbgXth8J
        t9+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686811716; x=1686898116; bh=g5P+F4WPLTq7a
        m0FNx519f1VIiU+iFLrOmjrcmEUm4I=; b=MuKWzWmGUFIANSxXmFYmiou9CTwqF
        vfYC2/koCrWBLsKc4K3hZ5//GNDHJEg52yHcXd4ghWSSpKxSxMNB8zm9bmO++Q1C
        XQzTEePNtpgiOejESrlTETjTmtYql7UT1Sw4BYH0Fje/eD+C5wFUgG0tFyOwJ9dp
        K3xCr2RJivlfUVDTc2oRBXkKb3yNHxUxOUfcxGzOXeLHXK4UrasBtTwGxt0aNXEx
        KqxYtNnINbTp264Az92ahkiDSpncFabMw/7b4silKJuGxkrvjNpcUYWuchEdHTHB
        fDdDl3N7743U+l96N3f+eaSVz+L69dmAgpgjwjfQMwVPrbnXRRr7p08bw==
X-ME-Sender: <xms:Q7SKZPMuJkaLI5Y-d_7mvY3ZzbbT0FEEuwPtSl9JgPhGt90x94zHoA>
    <xme:Q7SKZJ9ranbNFjcNVZvpMXW4u7abOOtP1EQzXRtepgXWYeyfqXKGk-BUgG63fy4zW
    WASrb0up6auYA>
X-ME-Received: <xmr:Q7SKZOQE9ReEJtOd-OoSfyoPUFoTbM-JU9ReynN6CFl8Ury6NsxONCz2J3cFmGSNozI5gnITGm79BBVoCdtio4b4udtjtLrn1iN16Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvuddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuhe
    ejgfffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:Q7SKZDtZy9RwnYqJ6T_bmizwe9qh0chtn2uRUdgRZNt_PwGI4lIpXg>
    <xmx:Q7SKZHfEZ_UvK2jZnrv2cQL2JtQ2TcqBBL03d45TEcN8KKa9PSmWXw>
    <xmx:Q7SKZP0sTIgJrm0zmLF01qxhRURTYDq3T1kUCu69KCJ9StPEfTI-OA>
    <xmx:RLSKZGzuPu5zcOujzhQb_WzvIRwUOQ75OUrjQLumlUPYutoQc5dV8w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 02:48:35 -0400 (EDT)
Date:   Thu, 15 Jun 2023 08:48:32 +0200
From:   Greg KH <greg@kroah.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the usb tree
Message-ID: <2023061513-savings-legwarmer-17eb@gregkh>
References: <20230615151958.46746fe8@canb.auug.org.au>
 <ZIqy0mLPipq2p/N8@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIqy0mLPipq2p/N8@ninjato>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 08:42:26AM +0200, Wolfram Sang wrote:
> Hi,
> 
> > The following commit is also in the i2c tree as a different commit
> > (but the same patch):
> 
> thank you for the pointer!
> 
> > 
> >   7b7efc925042 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")
> > 
> > This is commit
> > 
> >   a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")
> > 
> > in the ic2 tree.
> 
> Oh, sorry, I didn't get a mail that it was already applied to the
> usb-tree. Maybe I accidently erased it. What is the procedure now? I
> guess I revert the version in the i2c tree?

We can leave both, merges should be simple.

thanks,

greg k-h
