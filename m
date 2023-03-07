Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C916AD770
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjCGGcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjCGGcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:32:04 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879E7515C3;
        Mon,  6 Mar 2023 22:32:03 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EA5675C0524;
        Tue,  7 Mar 2023 01:32:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 07 Mar 2023 01:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678170721; x=1678257121; bh=JN
        NUYCnkXweyF5D43Jgpx00DAkQIyN+bBZ5xRNByPbw=; b=hhC07T/R3EcIqvvwgO
        QgpfqL8WBEBf4nvuFx34osznklLBKLAzpQRIOEL+pjc6KAOYl25YJZy7LNZx+fIT
        LkBCkN/2NKD0H0lZdPB7Siv4lqR4UJBuBge1UWxg/quaS8PFzpFh6KnKpg938wiF
        Em+A2HJwJErcaD4cf1Z4Wcxmc3xY/139QhlqriyXNHoXt3CnIYLfH92fwxigt4qW
        bQ2o/hJ2RnbG69FrqaP1pATivKG7ai2B1eur3MrqmjL9i6wprpuUcbXXafDdSVGs
        4Piip54pS18Xtjmw5DhDzxyvJDLfooSD/tddcDTTkkJ2fvwozZt0NDd8zbDhYg/u
        65jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678170721; x=1678257121; bh=JNNUYCnkXweyF
        5D43Jgpx00DAkQIyN+bBZ5xRNByPbw=; b=QDZLX95UdgLVEslW0xYtV+fttAPGN
        pxAu+ELUXUjEqA7PmylTWA8p9v7gCaE1w8HZkpFv1uDcQWMPURjy9efLCJPzhzwu
        qAjx0MM/yEpkmCi5VReRx7WHICBjSiBl2j6i5JT+pHwxVVI7dYvN/0iZll7clzUZ
        xaiH0Vf287lClgl2e7kEx0+qvPE58kSDRYMniThImwcVMpSHW46JBcIGEqKJ6lwK
        M2uGlGVMFKe4OhIHE4odNB0oyO/jkD3GDcir/cS0HWd/+w00SxeKtlgUnCmF2tK+
        k82QGaCPzw6qfHcJxovUmxUPq8WCCBiEzzRY+Atw5EhEJ8lUtJr/vFCWw==
X-ME-Sender: <xms:YdoGZFOXkndFfI5XOZFCmdJ5cdIOCD__XgyRTR4ErHYWesOS5b7saw>
    <xme:YdoGZH8c2V9cE9HRgExBqRYkE_DKmncD0AJVayykqSlscoh1QLVYlPqv4nYKTsIcH
    ybwpLEoB86H4g>
X-ME-Received: <xmr:YdoGZESUfz2BblFIIwVNvXr6Oaw0wjVssx83xH8xJf0Dt11sFYmXHN9nTlAnKIBnOPqsEBTu9C-EuAcbQk57RRwN6EFWu_CBTrERfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtledgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:YdoGZBulGrpwWISrH1cW0HeoeqV_SSkLDOG_4aDr-_BiSEtnm1b6Jw>
    <xmx:YdoGZNdS1gjoz1FyuA5FJJDeC-c9-t21gLTJP-PaPPiaNr6nXngX3g>
    <xmx:YdoGZN0LyaJpe3pr09wxqCQOmuNHVzpxvyz3Vrsuk5z2g6QzWoWDTQ>
    <xmx:YdoGZE4QxZSdpo13LKkesvkqnzRyBnpsdoJunUp8Q4W1WpECTY-Ovg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Mar 2023 01:32:00 -0500 (EST)
Date:   Tue, 7 Mar 2023 07:31:57 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warning after merge of the driver-core tree
Message-ID: <ZAbaXeEKfUJY+hYx@kroah.com>
References: <20230307134313.1b2aa555@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307134313.1b2aa555@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 01:43:13PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next qemu boot
> (powerpc pseries_le_defconfig) produced this boot time warning:
> 
> HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
> sysfs: cannot create duplicate filename '//block'

That is odd.  What type of userspace are you running this with?  And is
there a pointer to the .config anywhere?  No one should be needing this
old config option anymore, but maybe I messed something up in removing
it...

thanks,

greg k-h
