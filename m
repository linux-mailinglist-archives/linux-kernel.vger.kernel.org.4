Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3B9642A1B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiLEOK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiLEOKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:10:22 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C63E0A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:10:21 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id AFEEC3200786;
        Mon,  5 Dec 2022 09:10:17 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Mon, 05 Dec 2022 09:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1670249417; x=1670335817; bh=bt
        GKhUlRGY3jXbTqKD73A4EUWOQuAtAdZD1CjIfn2R4=; b=BgqPQTw96yTBA3Mpax
        eSY30GEHREAyOUQP4cqKCh0UgUoA+ediz0fqQPZEREHIw7XcIB2z5aRmgLr+yDTy
        5dEEUTpRq7lGP2fSSF44ZNBtQPvtp6SCDhzIhYYD2BHJGQqjFYtlVhN9Ojljn72D
        o5SwZyRW2iHLR7k+rmb8NfEf3MMy5xR5VSY/vN6Obk+Sfq7b9u6PkNtInLFnqzZa
        94sD+ybPRuK5JpOSUZRXClUb0Mvx6yCdaZyq0SgffMU/9uzJrocgDO/xA2UpCBYw
        ed6lCa7eKsXS4o6DDfygVkLR6vRMmDmmMVa6qarKvbHtnolRF/CIWNuNNcVkjalK
        pDtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670249417; x=1670335817; bh=btGKhUlRGY3jXbTqKD73A4EUWOQu
        AtAdZD1CjIfn2R4=; b=TYGO3A52kmWPsWuNZ/gjZbNG2eNe04xQ36t6tJix9kDm
        WMfi6oO2BcsNzf9Tj0s6FhRKKsvF6qrTvZwdqIFwoclKMglnGwWLY7uFaTiLRWyR
        zPfnGoKkfBIG/047Azi0a3n25tkJ/oE0NnKUgxhUw5kwd4Crr5TKlRATONv4gEVC
        bNaw+ZMXQO76Ug3Xlc5wYajOX/d7CLnrTCbRCHyiiOSy6PXg2eqSqt1jehvaCBjQ
        UgHeYcetVYYy05whsQjdluvQC2ICEgOrQtKPDlX5mgW6hrNUExNU6Ypv4aSlvs6C
        zKNf9c9+f1iEHElcEgKaBGG7UmMzj+OY3rCeJE95Lw==
X-ME-Sender: <xms:yPuNYyaMwzap5C0AG9SD-e8AexiV_0orBo6Pr8mAb66xhqGaK3cxlg>
    <xme:yPuNY1bsKnCOXjuGENCFKqgQSmM77XO3URgNiLDQ9fl2JMMdCRh-MyGFdtVM1S2_z
    CcJIgphh_l1Bdtw47g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:yPuNY888RL3K-OwUgc58k7yRvCOfvI6XKgOYBCvtDLP0RxFt1v6BEg>
    <xmx:yPuNY0pKZ7qMbqaTL9suG43SjI79scjE0C0YWM0AtJoo0pHpCvz_Yw>
    <xmx:yPuNY9rhNA-lJs_-aRV13JgAiYiYJSaB78E998WMb49s7fSFKLWPww>
    <xmx:yfuNY2DJ6ANL5Cl3Jx0keswlGGt7gi0DFvgBvqgbZzaTHdd_fo7HUg>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 573D8A6007C; Mon,  5 Dec 2022 09:10:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <b02fdcce-b2cf-466e-83df-688f35348b86@app.fastmail.com>
In-Reply-To: <20221205100907.10230-1-marcan@marcan.st>
References: <20221205100907.10230-1-marcan@marcan.st>
Date:   Mon, 05 Dec 2022 15:09:56 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: dart: Add suspend/resume support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 5, 2022, at 11:09, Hector Martin wrote:
> We need to save/restore the TCR/TTBR registers, since they are lost
> on power gate.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/iommu/apple-dart.c | 50 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 4f4a323be0d0..ed524765ad87 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -121,6 +121,9 @@ struct apple_dart {
> 
>  	struct iommu_group *sid2group[DART_MAX_STREAMS];
>  	struct iommu_device iommu;
> +
> +	u32 save_tcr[DART_MAX_STREAMS];
> +	u32 save_ttbr[DART_MAX_STREAMS][DART_MAX_TTBR];
>  };
> 
>  /*
> @@ -932,6 +935,50 @@ static const struct apple_dart_hw apple_dart_hw_t6000 = {
>  	.fmt = APPLE_DART2,
>  };
> 
> +#ifdef CONFIG_PM_SLEEP
> +static int apple_dart_suspend(struct device *dev)
> +{
> +	struct apple_dart *dart = dev_get_drvdata(dev);
> +	unsigned int sid, idx;
> +
> +	for (sid = 0; sid < DART_MAX_STREAMS; sid++) {
> +		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(sid));
> +		for (idx = 0; idx < DART_MAX_TTBR; idx++)
> +			dart->save_ttbr[sid][idx] =
> +				readl_relaxed(dart->regs + DART_TTBR(sid, idx));

The rest of the driver uses the non-relaxed variants and I'd use the
same here (and further below) to be consistent.


> +	}
> +
> +	return 0;
> +}
> +
> +static int apple_dart_resume(struct device *dev)
> +{
> +	struct apple_dart *dart = dev_get_drvdata(dev);
> +	unsigned int sid, idx;
> +	int ret;
> +
> +	ret = apple_dart_hw_reset(dart);
> +	if (ret) {
> +		dev_err(dev, "Failed to reset DART on resume\n");
> +		return ret;
> +	}
> +
> +	for (sid = 0; sid < DART_MAX_STREAMS; sid++) {
> +		for (idx = 0; idx < DART_MAX_TTBR; idx++)
> +			writel_relaxed(dart->save_ttbr[sid][idx],
> +				       dart->regs + DART_TTBR(sid, idx));
> +		writel_relaxed(dart->save_tcr[sid], dart->regs + DART_TCR(sid));
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops apple_dart_pm_ops = {
> +	.suspend	= apple_dart_suspend,
> +	.resume		= apple_dart_resume,
> +};
> +#endif

You can use DEFINE_SIMPLE_DEV_PM_OPS here and then ...

> +
>  static const struct of_device_id apple_dart_of_match[] = {
>  	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
>  	{ .compatible = "apple,t6000-dart", .data = &apple_dart_hw_t6000 },
> @@ -944,6 +991,9 @@ static struct platform_driver apple_dart_driver = {
>  		.name			= "apple-dart",
>  		.of_match_table		= apple_dart_of_match,
>  		.suppress_bind_attrs    = true,
> +#ifdef CONFIG_PM_SLEEP
> +		.pm			= &apple_dart_pm_ops,

... pm_sleep_ptr() here to get rid of these #ifdefs like e.g. in our nvme
driver.


With those things addressed:

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Sven
