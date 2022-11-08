Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D5662099C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiKHGjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiKHGjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:39:02 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D561AD9E;
        Mon,  7 Nov 2022 22:39:01 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 175173200955;
        Tue,  8 Nov 2022 01:38:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 08 Nov 2022 01:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667889538; x=1667975938; bh=gA9fsyjBPj
        RHdKmfjlhpRrepPj4+JdSQ+31PMTfZEn4=; b=riixV1saCnuncTA2Vy9m/OAcX1
        +l6aF1ZwXfLx1Hxg84LORKPP27a3AWLQg3vQ4LqbfYdD3GlvQjv4LJqYYNc0HfSt
        Nc81msQk4Ugvz4ivkSVvZyUEIlEFASoKzUidTjybxt1qY7KyZGTYf2aShNbz2RQE
        HDVniaY0l+7WUkDKOHPCcErJkDT99M+PGDWB0211atKZgsfEsbXavI8Hw6XmfCGq
        S2kT2DVVRgVIg88Fg0roFLGgtcaurTaA4m2BztPU6+VTYyxWRj13eQeJjdOTttU8
        uuTHhsLclLTd7MW3Yt7gFxibt/h5l73b15jZ3bDY8O5lbs87cXyn/8GbHCNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667889538; x=1667975938; bh=gA9fsyjBPjRHdKmfjlhpRrepPj4+
        JdSQ+31PMTfZEn4=; b=MZ2B1AwKIO1+ne1WpWa46OAV1OD4rjd50MQfZK2L0JzK
        Ym6LysEtMwYrLvTgnP+kkUTiFvmPmEy1ZbERVcxKakLnsoTfgLMs0++ViV3gY5vP
        UJr6gpEha2aSIMP1Z7XoZvk+wXnB3CTQKScfAKrdhkQI+095WKke2/i69ITfjh1A
        TeSieOpUoJacdH50tfL239o13AGCXuSyq2FIbNHsFW2ENBxJji+k3IfhMtaTW0tK
        NyqeyU7Jw7Ll3vUTCtWvACEc1o+OiZAkFNaEOJIxhSMQANnI+LZW60E3wnn2MRe2
        3VVYeJ3g4+qRc3u0mYmCm8hhLDpZlkO75HOi2uJNFw==
X-ME-Sender: <xms:gvlpY5nySF8BbD7tl-fAJyuq4DWFHPmJ9DvGOJICJHBVY2-fpTvpkQ>
    <xme:gvlpY03dBrfRiVymEef_2vJ_hCN8ISP4JuFIgTJGYR692-gVcnNJlf-FymFgie2YQ
    PU67Lmzw_e2AQ>
X-ME-Received: <xmr:gvlpY_q_G9mvZjZx-y5jH5MfkbRdDHDNquvzxc4fr54bD5h_rkZsCFk-sa6s3DCJArCG-ZLo0pMieQqZIlsr-X9EenO18ygg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdelgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejue
    fhtdeufefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:gvlpY5nFpmqqP8HwkUwB3JaCF0c3EInSyQowD2XdGM-3ZPOMpB03Pw>
    <xmx:gvlpY31c2VFbO5E-qHqwMXZYQ-ZDVUAgJebIzt9IYj-eHGKSmMdY5A>
    <xmx:gvlpY4tLx0xakFn5diq2-iA0LIGCu3lYtD12j20Xy2aeeTTfNFClXw>
    <xmx:gvlpY1N1TjLSXa2mnmGD34skNk3Ww59Yrn67tTH7_09ghhmS4lj-DA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 01:38:57 -0500 (EST)
Date:   Tue, 8 Nov 2022 07:38:54 +0100
From:   Greg KH <greg@kroah.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     vincent.sunplus@gmail.com, vkoul@kernel.org, kishon@kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: usb: sunplus: Fix memleak in update_disc_vol()
Message-ID: <Y2n5fhFq4ozEzlBL@kroah.com>
References: <20221108061113.35964-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108061113.35964-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 02:11:13PM +0800, YueHaibing wrote:
> 'otp_v' is allocated in nvmem_cell_read(), it should be freed
> before return.
> 
> Fixes: 99d9ccd97385 ("phy: usb: Add USB2.0 phy driver for Sunplus SP7021")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/phy/sunplus/phy-sunplus-usb2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunplus/phy-sunplus-usb2.c
> index e827b79f6d49..450cf8e6d7fb 100644
> --- a/drivers/phy/sunplus/phy-sunplus-usb2.c
> +++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
> @@ -96,6 +96,7 @@ static int update_disc_vol(struct sp_usbphy *usbphy)
>  		set = *(otp_v + 1);
>  		set = (set << (sizeof(char) * 8)) | *otp_v;
>  		set = (set >> usbphy->disc_vol_addr_off) & J_DISC;
> +		kfree(otp_v);
>  	}
>  
>  	if (IS_ERR(otp_v) || set == 0)

How did you test this?

Just by looking at this tiny diff, this seems to be wrong, please fix
your tools and your review process to catch errors like this.

thanks,

greg k-h
