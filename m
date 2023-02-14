Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B009695CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjBNIWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjBNIWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:22:08 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D56206BF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:22:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso10899161wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSMRtKLXg3ZdMa2S1Nyuy48lVNBmym6/uNjNme3x3vU=;
        b=cvC0d3Wzfl/m8ZNCju4O8AOg8/aaWwlGB+Ii05laxRBb1N2pXoIYODtbeD4dCVhwFI
         BXLCWYeVR+RSETvuwHyRBV5K1MtKqpRSf2VIJNHu42KetC+wCMFI1/s5cM5Gqv16Suol
         dNmm+IJEnnz9gmZRAnbrrAfG5k2b+doeM3PPMMGRdxkKxwDHjx+ZNZApv7IW/CKfByvS
         0uRnpyJ2d+6Pwxqb7jrrRJdbWFo7umWjlBkg2b8ua+xyamIc8F4DrQr4yx3VPVv1evTn
         cbBgFfFL0LmmmWLoqTUg/sLhRiVpdwC9jMAMw8dj0HDEeKnjwvH1wfD4MlTjNejYR+dl
         +Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSMRtKLXg3ZdMa2S1Nyuy48lVNBmym6/uNjNme3x3vU=;
        b=CLj0az9m74dd/JFES0XINlDVNfWRbUay1xD44YWa2ui8Auzy/DOXHKiJwa/MY8kr+T
         6iZq9kZtxYQPxSpJ+z+X8zv0SQRh+Nd24o+CLslA7C4Ylw802AT7weOR9rGNswvuVhqH
         lNeevvSDRKmw/EqRkjqO+shfXL5KImYjIY0vcF9LRxUjF1zNy1KvaVkBxdhPyUNt20G9
         jIILDoEHjiiZ4RLJvT02r5GWrsopcd3IsNTSUx2UrA64pVHLeXf8hQizLTls2c4T6/V/
         af609uqKZc1yUMacdFWkk8h8fCHivGpQkOsivIKxcGyyXCIHG6kZo5njvcV9NsiMEJB4
         u93Q==
X-Gm-Message-State: AO0yUKX1QkFHEd4QvArqxiAhXKhLIwXU8kJ4uSiJ5uRMJ3+0KAqsfihm
        N5pGormEvXgmCqHrQ2cgFYy5kg==
X-Google-Smtp-Source: AK7set+ETfJcExOmEk6Cz1+al2ANXe0Uqq1jtmt78KD1iPvv7qAtQgSqrB+VO+Z/++3vAMuM1UNkoA==
X-Received: by 2002:a05:600c:44c8:b0:3df:30c9:4865 with SMTP id f8-20020a05600c44c800b003df30c94865mr1374945wmo.26.1676362924697;
        Tue, 14 Feb 2023 00:22:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600c364600b003df7b40f99fsm18708753wmq.11.2023.02.14.00.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:22:03 -0800 (PST)
Message-ID: <d2e20336-b4b1-0eb7-5667-ef98420a3629@linaro.org>
Date:   Tue, 14 Feb 2023 09:22:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] dt-bindings: i2c: i2c-st: convert to DT schema
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230213191608.16503-1-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213191608.16503-1-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 20:16, Alain Volmat wrote:
> Convert i2c-st.txt into st,sti-i2c.yaml for the i2c-st driver.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v2: correct subject / commit log
>     add default clock-frequency
>     remove maxItems for st,i2c-min-scl-pulse-width-us &
>                         st,i2c-min-sda-pulse-width-us
>     remove extra spaces within example
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

