Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDA4715C19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjE3Kou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjE3Ko3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:44:29 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061A010A;
        Tue, 30 May 2023 03:44:28 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5D7DA32009AD;
        Tue, 30 May 2023 06:44:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 30 May 2023 06:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685443466; x=
        1685529866; bh=F9HHXS8arUxmMbXgD4lYlBzAc+chtX514eHYBrsMzyo=; b=w
        E/3M6d0O08oSBIYei3v4glgVwk31lLfd+GodhsaVRtTLhDKiiVtBERUk0UeqTs0N
        5GSODAdQBzsNX0JhjTd7M3ZiY7sJRDpvguUE4j4zuhJKT0Tn4SWTfnGBAwo1k8d+
        krueGBL0b9M+3X4WiY9rANk5NfJ9ggUgRf4zf1pTIPMa43KwS5ylX8OvemyRSSyg
        9Yhr01K93Je2+9NX2EyKumHM8/F77F8kwc4HhMxHR8b+vytC+1KD0x7+RMQDYJ1n
        5KSBNoKXomJdhAZ3/4ywYJyzJydDmRfbvy0EV36AwryD/quTKibfDvAbhlNS1q9S
        V7mPUsAhY5V1Dx69Eqs/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685443466; x=1685529866; bh=F9HHXS8arUxmM
        bXgD4lYlBzAc+chtX514eHYBrsMzyo=; b=VOLcq1yDzwTj6hG6ZnlYWuyWB3lBO
        iCTxuZM9IGHSbKmizYnSEjFj22OnHOZ82vch66GHLc1g88fKCPXq5o+vCVwIQu6G
        JEutSEHjCtih3c83q0YEw0jZ7iabeEtWLXoGm3XMr/F9uz8XnaFGW5vgandjzLKg
        rFjTb9oYeFEep0LtFKpYWokhffr5Xe9trcQUwYHK7H7Io0pBJl5Oa/3gIRqY+5kZ
        UaGR6Ixy4PT73jRH/LhEh+O2oY+nBBsFgsAs67t7nb+749RyByga9yYhFOVWx+A7
        EpjPck/4vQvxdMNnqE6ShhkzmLbNh0OMb4FbaSKq/d14g/fhyXAIqtSdg==
X-ME-Sender: <xms:itN1ZCkNs8RYQWKmdNqdZnHRAwXASMLgreylPNGcu87NmoybKhUxYw>
    <xme:itN1ZJ2M0ZXj2bbaTkVO1cYYGXOq86l0s41QnQDIovsB8cNW_y_BghsXzYpm7RpLE
    q7zXOaw67qQMo7wJOU>
X-ME-Received: <xmr:itN1ZApFqswFH5j8pMS5q8l9bFkxDVkPMTymQubyyOuOztbz_XeZbrPEb4vN0vssvjQdQzSZ-uS4TQlWTJl1PwbzDCEDQ-yICSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:itN1ZGnNobT0lywopmNXBOz75G6eBCiNX52VgagrDxlEoZ1gOIeDtw>
    <xmx:itN1ZA2QgO6MU0oNQgTyyIB50jc7O_-dSTM5MlK1BFcBIOMS3Q5_1Q>
    <xmx:itN1ZNufC6GpFkNIARXCIOi_hAWNnNuGe1Rq7lCzEBTePCfR4tma-w>
    <xmx:itN1ZN-888nehCAkD472JgcrlI5riHgsMSJaxHZ7bybKQSjmPFimDQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 06:44:25 -0400 (EDT)
Date:   Tue, 30 May 2023 19:44:23 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ieee1394 tree
Message-ID: <20230530104423.GA67264@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230530122450.1603af75@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530122450.1603af75@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, May 30, 2023 at 12:24:50PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the ieee1394 tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: missing MODULE_LICENSE() in drivers/firewire/firewire-uapi-test.o
> 
> Caused by commit
> 
>   dc7c51638f46 ("firewire: add KUnit test to check layout of UAPI structures")
> 
> I have used the ieee1394 tree from next-20230525 for today.
> 
> -- 
> Cheers,
> Stephen Rothwell

Indeed. I overlooked that the code can be configured for tristate.
I posted a patch to fix it and applied it to my for-next branch.

* https://git.kernel.org/ieee1394/linux1394/c/e003498ec055

I'm sorry to interrupt your work flow.


Thanks

Takashi Sakamoto
