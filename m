Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B535FA37A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJJSki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJJSkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:40:35 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB2BE093
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:40:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y1so7178743qky.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5H4Tybt7voQk6I4jd5s7+XDeC0MpH0YdPGAT0/eukg=;
        b=PW5tCE4kZWjLiyXULBfOzB5YU3cJnUv581TVAH6WcYnWmuogsNKfrr6vgsBgBmHw2+
         aytYCOaBEAzBXJGv1UB3VTn0HsUpHG1EDLAksyHZtQUA2XsJs/FWty36VVH5UdMkf9DG
         G599R0QJD8kswNbHyR++HmREbi9azt107dFrrZLvPbp40UI1DykrniLnBzVAOkhNhve/
         9HP5zaExvQtEevsCfPBNCD0SoRJhsoGYBgDCxDbZr9RSS5X3xtc8idI3B+IzjudSrRgB
         h/ukvyzAx0yhyGNY/tFomDkjp5xbDwTrTmD8dcohMQ2TwMw3O6yy+o3mk2ASnUNW11UC
         +MFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5H4Tybt7voQk6I4jd5s7+XDeC0MpH0YdPGAT0/eukg=;
        b=h4v98DvLA1NNHY9QEVJEVFPXoRZcVQptxEqtVmEDS9mYhXx+P/xKcXsa6Ppj8/cN0x
         wYCIfKGRFTTQre0WLbtincl2KLI0Iy2P5oF9NY6UW1GPLiJWyRmP6/VSy/ZsskQYjDVy
         GJasWxjYFGIgpkJzxBvURruPZg1b6Zy95yfjI8XR/S2Xe+8b6PiOqlp6slRsfU8y/EYW
         F0K1jqtK54hZyq8Onb/UEtnlnwpv7lMNxkiDDauvRB7Yr2OKtVLEDmzrtTz9AeHHb/ZR
         06nugIfEc5Za1A6QJGS1TEoBf3NDAxyQ5vSchh5Frmo3XwvHhXtGFprx1puAu6k8Fkma
         iK2Q==
X-Gm-Message-State: ACrzQf1/VSK6ENVUVDpWXopAKTNKDE7BByFPRCtfYk4Om3QBr2UcltsM
        Kf4ALqant0DYFt1wzLtYsQqBcQ==
X-Google-Smtp-Source: AMsMyM4u7unzRGjVZTOAjRBEMbAI2WE3RMnv0NfrdFSAS9xO4agO23/UIoBoWuaaHMP/MmAFEeal3A==
X-Received: by 2002:ae9:f205:0:b0:6bc:2d40:2f3d with SMTP id m5-20020ae9f205000000b006bc2d402f3dmr13536175qkg.448.1665427229152;
        Mon, 10 Oct 2022 11:40:29 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id f11-20020ac8068b000000b0039853b7b771sm5642156qth.80.2022.10.10.11.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 11:40:27 -0700 (PDT)
Message-ID: <7a71aad9-9e4f-b314-9ae8-7f478aeae53d@linaro.org>
Date:   Mon, 10 Oct 2022 14:38:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] Change the I2C slave address for ds4422/4424 to its
 correct value
Content-Language: en-US
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ihkose@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajat.khandelwal@intel.com
References: <20221011182437.662719-1-rajat.khandelwal@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011182437.662719-1-rajat.khandelwal@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 14:24, Rajat Khandelwal wrote:
> The datasheet states that the slave address for the device is 0x20
> when the pins A0 and A1 are ground. The DT binding has been using
> 0x10 as the value and I think it should be 0x20 as per datasheet.

Use subject prefixes matching the subsystem (git log --oneline -- ...).


> 
> Let me know if I am wrong about this.

This does not belong to the commit msg.

> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> index 264fa7c5fe3a..1955b1a97cd6 100644
> --- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> @@ -38,7 +38,7 @@ examples:
>  
>          dac@10 {
>              compatible = "maxim,ds4424";
> -            reg = <0x10>; /* When A0, A1 pins are ground */
> +            reg = <0x20>; /* When A0, A1 pins are ground */

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

>              vcc-supply = <&vcc_3v3>;
>          };
>      };

Best regards,
Krzysztof

