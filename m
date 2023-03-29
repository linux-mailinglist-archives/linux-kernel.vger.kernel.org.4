Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200356CD98D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjC2Mro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjC2Mrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:47:40 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751B140CE;
        Wed, 29 Mar 2023 05:47:37 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f188so660166ybb.3;
        Wed, 29 Mar 2023 05:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680094056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xb99Pt1hWl4SYTj2pTt8Ket8kJPM1kuDudhRju4oMSo=;
        b=lI1jIvz1wOnUinOR2XKz81YqAn/LewjZQIdo6TayUXQ2JWK9zZ7GyaQ3prfQpUNSZM
         tweWuGKncTlhlL/I6jjyyBf52a5l8tSYgCXxlibfVEkyz+5iQG5WFua1qY3ImLmT8jNW
         HkJ3nz5Ql74zz3ABgv6LrsjPlUc70WFywxVDBMyio9LL/H1KVQa+QwIl+eKYbqK9a+9x
         yWSYAFm1JKqKB0N10aKibTw64LT4cAcOUwAUplZ346OzDKdXXenv4nHM8EDEXO01789B
         yt8r2JptMfJc6SJsPDdf7jnNSWaa2OcTPrxeqFBVSH6kAxqmnuxYx/YtP1rxtiieVtRc
         70kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680094056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xb99Pt1hWl4SYTj2pTt8Ket8kJPM1kuDudhRju4oMSo=;
        b=qJj/5mEWkmdStTgBudzjkQ7oKBc5Kh0KMx5F9WJymownl9Ir4YwzOJX17CVyvbinoV
         NIX1oAjNO3z+mArdZeRwkvxIi1UbT3yGwQZ0E+8jPYcc0rNYJYN5pf7Rna43/5OTI84w
         xDSIpOQ07Kay05/c4cSA88f6N9Ld/egRv4D5kE47tL+1WMR+8aYmepS/D1MvWkVKpoxk
         bPcn21eUa5Q44oByhC6fl78Fy+qASqz6WA+38ExoOCFHJNnIYJy/zxBce+Q1Xa4WhxKh
         hUwlsT8b9C6opIzKO1XaDrZcvSNGEKWCacTPdL1prAMZu4qkhZlCGSBTb/mTfCw8nVB0
         lWng==
X-Gm-Message-State: AAQBX9cuKG3fsp3mrpxAEZvEbCBARo13qgC5d8HQDrFENpVjsiOLdmWY
        tOyA+MpLx3QGuChvrMZlI2w=
X-Google-Smtp-Source: AKy350bdEGZMDJpYSMuq9BOMZO56hoZIdt+J3okid1AES5sc6vMNacBimV7YbYHIobiway90BPZy7g==
X-Received: by 2002:a05:6902:1201:b0:b72:4127:68a with SMTP id s1-20020a056902120100b00b724127068amr24732924ybu.19.1680094056338;
        Wed, 29 Mar 2023 05:47:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p142-20020a25d894000000b00b7767ca746fsm3454472ybg.12.2023.03.29.05.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 05:47:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 29 Mar 2023 05:47:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jamie@jamieiles.com,
        heiko@sntech.de, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: rockchip: Add
 rockchip,rk3588-wdt string
Message-ID: <157937fd-0af7-4ff5-8430-2f956c7aafba@roeck-us.net>
References: <20230328210048.195124-1-shreeya.patel@collabora.com>
 <20230328210048.195124-3-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328210048.195124-3-shreeya.patel@collabora.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 02:30:48AM +0530, Shreeya Patel wrote:
> Add rockchip,rk3588-wdt compatible string.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> index 92df6e453f64..e7a87ce94772 100644
> --- a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> @@ -29,6 +29,7 @@ properties:
>                - rockchip,rk3368-wdt
>                - rockchip,rk3399-wdt
>                - rockchip,rk3568-wdt
> +              - rockchip,rk3588-wdt
>                - rockchip,rv1108-wdt
>            - const: snps,dw-wdt
>  
> -- 
> 2.30.2
> 
