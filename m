Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C9A5F23C1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJBPDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJBPDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 11:03:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAC72B63A;
        Sun,  2 Oct 2022 08:03:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y9-20020a17090a474900b0020a765b5d39so2252027pjg.3;
        Sun, 02 Oct 2022 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=VYo38vs7YNezoR40xchDftBz5uoIkW9uy3klw2aQRiE=;
        b=le5Ch+6IvUQDHM92zK/s+3t6wbJkUVXRy0PBHU+4QqECBtin5v2e189b9+eD3aQPdL
         MWNA6X7uYUCXnhNM2jsrRiU5Okk/7Cg4UkTNJXTncdUWWbQJ6dSf0dNx5NdWlifHfy2u
         Xr6ksR9Bz9+RdScPITwsIlzSaBgHRuiToxQ77XCop4hwbI9hP0Un4N3JRfD0y7fWrQDk
         tfiisObonwUoBID456//fRvSeX303MxlVmnEoApkYrjztZmyhcWdJf56RTcpvUezPNJx
         gQgJh6up+Xu+Bt7JmzRvcyNojbZ3Novg+pTNJMTx0ZNdMsXPxcSIaGJQ4KfZu9KzKr0I
         PoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VYo38vs7YNezoR40xchDftBz5uoIkW9uy3klw2aQRiE=;
        b=asfprMVch2Ekg87TgJkRfaYLeXjc3/liPFn1EUmh3sfamaqHI/Wh/Rsu8bCt9ZsRZs
         Yh2jz4pvtFSSu3mRzQw8d5oDTjmwl3IYFOmuH+tegDYDY3wO1Rgew6B5qgIqovHfxT5G
         jvfVsjqDEG3Z6eDjhLVGvMBO+ir/zeZCrEtv0mKdUk2qJXLmBNyDzb2B/592XUErKSOq
         UFrbwQNBQSYAiNhKsDk5fDKgxRNcGJ++3/DAQVDgKDVPO3W3Cq/Cnau2+gS+33TtCvg9
         9TPuI39Wc4F4BeTlHPL7I/20Z70yHmDqn+/Z2+XjcCNlbQZfNtWyaLpoWSdwAiiEnp0R
         RkBQ==
X-Gm-Message-State: ACrzQf3Rb3/pcjbHS5tJK6EsjAq6UOuXpECDeBGYlNk/BqpUcyOqSsd+
        2C2KUymJ8H5VZ/5ksXzf3jM=
X-Google-Smtp-Source: AMsMyM55t21WxrUgQuftrgKy5pa26M8T48wXLmndYkxxApzYa1Lcv1F2d7UTIvwh6tdn59zlf/h/qQ==
X-Received: by 2002:a17:902:cecc:b0:177:f3f4:cc90 with SMTP id d12-20020a170902cecc00b00177f3f4cc90mr18087546plg.83.1664722998710;
        Sun, 02 Oct 2022 08:03:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 135-20020a62148d000000b00540c8ed61ddsm1104680pfu.150.2022.10.02.08.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 08:03:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 2 Oct 2022 08:03:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christopher Ruehl <chris.ruehl@gtsys.com.hk>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devicetree: hwmon: shtc1: Clean up spelling mistakes and
 grammar
Message-ID: <20221002150316.GA2895993@roeck-us.net>
References: <20220928213139.63819-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928213139.63819-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:31:39PM +0100, Colin Ian King wrote:
> The yaml text contains some minor spelling mistakes and grammar issues,
> clean these up.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied (after changing subject as requested)

Thanks,
Guenter

> ---
>  .../devicetree/bindings/hwmon/sensirion,shtc1.yaml        | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> index 7d49478d9668..159238efa9ed 100644
> --- a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Christopher Ruehl chris.ruehl@gtsys.com.hk
>  
>  description: |
> -  The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensor
> +  The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensors
>    designed especially for battery-driven high-volume consumer electronics
>    applications.
>    For further information refere to Documentation/hwmon/shtc1.rst
> @@ -31,13 +31,13 @@ properties:
>    sensirion,blocking-io:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> -      If set, the driver hold the i2c bus until measurement is finished.
> +      If set, the driver holds the i2c bus until the measurement is finished.
>  
>    sensirion,low-precision:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> -      If set, the sensor aquire data with low precision (not recommended).
> -      The driver aquire data with high precision by default.
> +      If set, the sensor acquires data with low precision (not recommended).
> +      The driver acquires data with high precision by default.
>  
>  required:
>    - compatible
