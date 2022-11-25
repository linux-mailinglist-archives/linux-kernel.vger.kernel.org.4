Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FABE638F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKYRbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYRbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:31:37 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D6751C1E;
        Fri, 25 Nov 2022 09:31:36 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E4C9132000CC;
        Fri, 25 Nov 2022 12:31:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 25 Nov 2022 12:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669397491; x=1669483891; bh=+leDIuPs7f
        QXw329RvJWgef6ZwT3WBuLmTH9nW4gLAk=; b=ShILbuhBCZgaHKv7ZfKA+JbS07
        hrl/E8Y8C4XwssWYaa1/x2GShXoOqzEBMZhLwKMQQiMzqrcVKthKn/9D9VCo4d31
        jeAASbrjthQnxzGeJc/1vD/DKFxmRjnHf9+IjLUeH5nhRFA1igUAmpOag/5Aw3VN
        m1zOnVfMBLUAlqbexvfar2V7CF01bF13HsnAIXV4IADqX4RYcVw2eWZ9ApIRtsdR
        AtqVi4+owhgURcmrlvXFXHMntYanjV7CJNHjKFyOfmZEDdEH8zacEB+0okw9Iswf
        CuQFcTKP/x8kOUkr//6FZ3Bl4THf4nvN4bc00akLRSXmEkGVeotswYJFGQ9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669397491; x=1669483891; bh=+leDIuPs7fQXw329RvJWgef6ZwT3
        WBuLmTH9nW4gLAk=; b=Kyf6sxOUmnRFRbeU2ALr0Hi1AU6i9LOKZl2/B32RZ/K0
        jSlUM18EDFNux6X8MpPk8xY7mD9jNZUs8rvfxuU/8eUFPCCjDbaUkwH4Yc6aNYMx
        CJap43/+crz0PlBKkeSXAy217DiSPSypsWo2mhwL88uRyC1Sc0fQikjzib4Opxk7
        ujRy6jkdn4CAhDXrg11m4Gqax/m/MypAWNsP1vDZXVp0pDq9SiEnUh1xNLgzTW4b
        TKMJ4jNIxVOGu/0MjqyA66fRgI/EvoRWmOvlz5hjQoMgcJn1niXEtS0vvcX6PXuX
        /UURyqMQHEWLIwZpPwu84caVFOLnXHMlTGEzdHGO4g==
X-ME-Sender: <xms:8vuAYx8vDIV9p14-hyiURNEXaQ5c0qCloxOSdMhczLGT3GVhLNvrpw>
    <xme:8vuAY1sGEDPBPT5iAmRbn1rvzCY-AizovfJASD6rJMJqK4s9wUrXIzgJoygvRzarE
    X-MfBRihdsj1Q>
X-ME-Received: <xmr:8vuAY_DOzOD4QJT8ah2YzjvVS05hMYKqg6G_IeQ9_rrep0GhCi0g1nZ2NAMSdxacIbrwzCAiVWyiB03wEvHquut6VDzWwsJ7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieehgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:8vuAY1coQ-Pw1f3lE81xBbfHteTxQs-ovVuEvs0kICB5kQ0FKcqyBQ>
    <xmx:8vuAY2MbTvgDnEbEEUkev5fgCnqA5jxlP_3xLV2OfeL2pEBoBgzsNQ>
    <xmx:8vuAY3k3B4C2ZqVYKeiI_VlhR96mqOpGzwK8aK0YhA6hVmecYpi9gw>
    <xmx:8_uAYyl_QHHqHRKizaeleJfNMjproDzlBI8iJUtVvllocuySJrN74Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 12:31:29 -0500 (EST)
Date:   Fri, 25 Nov 2022 18:31:26 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Yuan Can <yuancan@huawei.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the broadcom
 tree
Message-ID: <Y4D77ktgpDOLggM4@kroah.com>
References: <20221125112542.466ebc42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125112542.466ebc42@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:25:42AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/firmware/raspberrypi.c
> 
> between commit:
> 
>   117bd98daca0 ("firmware: raspberrypi: Use dev_err_probe() to simplify code")
> 
> from the broadcom tree and commit:
> 
>   7b51161696e8 ("firmware: raspberrypi: fix possible memory leak in rpi_firmware_probe()")
> 
> from the char-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/firmware/raspberrypi.c
> index ec07bf26e5eb,dba315f675bc..000000000000
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@@ -288,9 -268,13 +288,11 @@@ static int rpi_firmware_probe(struct pl
>   	fw->cl.tx_block = true;
>   
>   	fw->chan = mbox_request_channel(&fw->cl, 0);
> - 	if (IS_ERR(fw->chan))
> - 		return dev_err_probe(dev, PTR_ERR(fw->chan),
> - 				     "Failed to get mbox channel\n");
> + 	if (IS_ERR(fw->chan)) {
> + 		int ret = PTR_ERR(fw->chan);
>  -		if (ret != -EPROBE_DEFER)
>  -			dev_err(dev, "Failed to get mbox channel: %d\n", ret);
> + 		kfree(fw);
>  -		return ret;
> ++		return dev_err_probe(dev, ret, "Failed to get mbox channel\n");
> + 	}
>   
>   	init_completion(&fw->c);
>   	kref_init(&fw->consumers);

Looks good to me, thanks!

greg k-h

