Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEFA6E2FD7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjDOI7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 04:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 04:59:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5F1131
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 01:59:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dx24so7455251ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681549147; x=1684141147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Med8MNi8DSncJEWPZ8pMWBDtWOVLQvgNcdZTfLmu3P8=;
        b=w2dcG33ez1MdQud4+IHT0fWHUqpw/R409tq0LyQXnt0QjHDLNP49U3XFuTOtYTM2V7
         rz85pI0Tk0CiSGvRTnrRgi/h8bNyywqkgMSJv/cN67QefTsyY7DqvkqVDh7PC0VMqNL1
         vod/dlIkQ5vFwd29EyKd5qBdHdhXdq5638BYAgMoEQRoPxyy17YmPv2htqcwvRsaCOD4
         tBcbwwH74Jb9JqWOBgob4Dri6Ck04o71SlVtX2y7coImyuf+MC1arqLHVEx/Hy6AMAut
         f251Kpw4TgnTUN57GRIRQ9T+c1TRUu9ufSwDLgdjltEopyrMTbt0fEFi2QKA7bx+pQab
         RZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681549147; x=1684141147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Med8MNi8DSncJEWPZ8pMWBDtWOVLQvgNcdZTfLmu3P8=;
        b=DB+FEDVL3u5GCMidvfY0GSe6wAxg62MXYtaoqM1Hfp30JJlrgIHzxEaR6cZ1mjof2w
         fQ9nDJJhRL/l7dSqiOqRre2HcvYn59x3ktqujrKW87xUR9Xb94QUq33pCp/shyTf/S5t
         2+vboho5AiC70yNR6TzevjPUD7MdlfksU+xJfQYMg21E1xdn66e80GbRTGG63Q/Ygsi0
         3HijfCV9nIBj7MaCRHjK6bc64HZ1Ax08wGicROajMf1YpqijhOHWGxIu10jIIJQ6gBh/
         mNCKP66IIhJokdufGnul4Hwnzmg/5MC0mY/HGrTyDG9Y18KJ0O0eShdwGrQfahA9Zzoi
         WEVA==
X-Gm-Message-State: AAQBX9eKjZadns6EHimox/t/8ET1LdheHxGX24IacI+lKV6muGBCNVvS
        LMktEC5L3LPmoZ6ZQT0dfask7g==
X-Google-Smtp-Source: AKy350bi+DUYyH9UZ4AdhS/7htgoHTSJhb6dVUrQycsSJfFQZCP1PpSuhd0WIoLMh2dVyUKqY32vWg==
X-Received: by 2002:a17:906:4ed5:b0:94f:f6e:fdb4 with SMTP id i21-20020a1709064ed500b0094f0f6efdb4mr1680089ejv.42.1681549147434;
        Sat, 15 Apr 2023 01:59:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a3bf:4ed:6c53:2a36? ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id ov5-20020a170906fc0500b00931baabe36csm3509441ejb.63.2023.04.15.01.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 01:59:06 -0700 (PDT)
Message-ID: <f8681075-30c8-5cda-6e1c-ddb80c052e50@linaro.org>
Date:   Sat, 15 Apr 2023 10:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 6/8] media: dt-bindings: Add bindings for JH7110 Camera
 Subsystem
Content-Language: en-US
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230413035541.62129-1-jack.zhu@starfivetech.com>
 <20230413035541.62129-7-jack.zhu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230413035541.62129-7-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 05:55, Jack Zhu wrote:
> Add the bindings documentation for Starfive JH7110 Camera Subsystem
> which is used for handing image sensor data.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>

Subject: drop second/last, redundant "bindings for". The "dt-bindings"
prefix is already stating that these are bindings.

> ---
>  .../bindings/media/starfive,jh7110-camss.yaml | 164 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> new file mode 100644
> index 000000000000..4cd144f1b845
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> @@ -0,0 +1,164 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +

No need for blank line.

With two fixes above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

