Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925BB6BA036
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCNT6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCNT6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:58:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B404BBBD;
        Tue, 14 Mar 2023 12:58:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x13so19462253edd.1;
        Tue, 14 Mar 2023 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678823907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqwHb3pl10s7quxiCLdge3d3HiQ2kieNQ2q19oo8kDs=;
        b=kCsABlT+HkwgRsyKMRlCb41qMBQ1GsJeb1u/zUZGfUsAzgBXSebzj7zTIdHOMUZ4hm
         Jddh/W1F1qfjhpUOo0OHPBm+37Xkubd46bVkGO+nzkvBHmgWXgYJxLvi2CIGm3NkwLtt
         kTUFSwRuOG4YU3Y11mcrYUcfx9+a1mAo3RXJ4kCw3cmIAjNz7A4g6IB638HJRaArVmGZ
         FkELAXbvLbkwoqaBGrGROnDFSrfeEb/heIyC0YFgIstC2AE3Yw9l6BDMbblzJgcit2De
         eaOyNCNGLDVUabserU/ISATGn9ccpbBAh0xp94IoBx925GjvIaAd//hykfRIi5NliUk6
         SMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqwHb3pl10s7quxiCLdge3d3HiQ2kieNQ2q19oo8kDs=;
        b=o7+Eqv8HzKAuwLFYq/Xim1V9Hm5XrovjXVSQaalLoGdy7qvVHro4sRIImE3FqltYas
         kpdFqEBfWu4qHR16vqZwJRgDwTDaSwBgl86jLTQjnDMhcBnGJQBupK+5o1LCW48BlXw2
         NwHMT1/0pH7GN0U89CRs515TYUFQQbX1FvgIE3VlH3gU9fiMDjKUTL7fkNKySWBugo0s
         r537rEHrrEZg7xUBvATTLLSyQNYqxjqfFs/leyRW54Ve7O3uS8NxRmQ+tdcZCxI5jMU3
         GHuK1+ufUoRnr9/U51of39hGbyZc5JLu7nGoWBjXho0WOTiio9VWYPbIHh7iNI/FzrC7
         hDyQ==
X-Gm-Message-State: AO0yUKVCxuOMvicGHALocg2gAScDSzPJzscbae78zWXLZsprnsu0L4O/
        B+b+UKfytI6Hxph18K0mAv0=
X-Google-Smtp-Source: AK7set+c9gXFRmjVi6fFDbFdISN4aKZTF0Ediiw5KyDrz4H9I2ZmJcurfv6q47uliZL8XXT7wR5jVQ==
X-Received: by 2002:a17:906:6b0c:b0:8aa:be5c:b7c5 with SMTP id q12-20020a1709066b0c00b008aabe5cb7c5mr3670395ejr.41.1678823906634;
        Tue, 14 Mar 2023 12:58:26 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id de11-20020a1709069bcb00b008d1dc5f5692sm1514491ejc.76.2023.03.14.12.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:58:26 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sun6i: Use of_property_present() for testing DT property
 presence
Date:   Tue, 14 Mar 2023 20:58:25 +0100
Message-ID: <1845104.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20230310144736.1547041-1-robh@kernel.org>
References: <20230310144736.1547041-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 10. marec 2023 ob 15:47:36 CET je Rob Herring napisal(a):
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/rtc/rtc-sun6i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 7038f47d77ff..dc76537f1b62 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -260,7 +260,7 @@ static void __init sun6i_rtc_clk_init(struct device_node
> *node, }
> 
>  	/* Switch to the external, more precise, oscillator, if present */
> -	if (of_get_property(node, "clocks", NULL)) {
> +	if (of_property_present(node, "clocks")) {
>  		reg |= SUN6I_LOSC_CTRL_EXT_OSC;
>  		if (rtc->data->has_losc_en)
>  			reg |= SUN6I_LOSC_CTRL_EXT_LOSC_EN;




