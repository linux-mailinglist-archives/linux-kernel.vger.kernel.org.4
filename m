Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB54E6E3007
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 11:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDOJQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 05:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDOJQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:16:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA657DA3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:16:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id xi5so51541726ejb.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681550191; x=1684142191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ug2NJoEjqHGINDCh57IhGrA5Av2op4wiMxKQgC2t58c=;
        b=gTC2VAOAMt0JAgxL72V+XYd7PM7WG/RujPbsXSC9vjpjxto1G4lgil5SHh1yhqivGh
         XB11lrbgPZwKRMm0ndPOGiWPadzM4BTdK4az1LZ1gEav1Vxis6FeOKe6NOCADUDUZOie
         pN9uweM9knWvTDFHajv1rX+wov/Ece6OB01aVt2Wmd24gKR91hR4ha79rlthMOMiXqX2
         JlOrWiR5iH2JlgLEVBwik4IArASXgViIGxNPl/KQSNzp894LdgfY9kduEunb2E9MAmib
         l1OI5WfzEGd0ZkYcS9NlY91IRbIkFOLgLvld9St/6Y/ozgv+quTUSSqMECfRIFUuQ4jA
         U4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681550191; x=1684142191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ug2NJoEjqHGINDCh57IhGrA5Av2op4wiMxKQgC2t58c=;
        b=K7fGyoOUMxtqTb9s9GN7ZCfRqPAOeaKKfzUrmvN4J++sj70IJYjbAzPtOhs+dDH91j
         M1H2SDuWKzQ3v3znFDlpIabstlQDz7F66cZk/HLIobf5WqUlTHkChorsDvme5PmCGdIg
         jjlN8WD2tWR6x1bQuJAvdDM0UQRVQvGVd/uTKdvwrthMqa0lpwpEsd/kI+0ENrak/dix
         As8+zTDa+w3TB7+qiaKN8HKPVBYHUhdX7rD6yjnaVzVL+pkH8D9X//93ZmqC0pr1e5lC
         ZSJpUp1h0GxXyoYrR9oEdTl+PupW4AmUO7xvL71ktuRtB2hL1SqMJS8ALm8VSf5hMpUo
         GsUw==
X-Gm-Message-State: AAQBX9c16uGgRUeHDNd1Ku030s6tez6FFf4rsrkupzQ2lCqrTAAslbEL
        bpCm9WYeOriq3VCPAXblqQ5NEg==
X-Google-Smtp-Source: AKy350Y8+Qc6oXBx/IQ+MO8Kl1T172h9QalkKMqsO2ifw2MIg8hUr7uZskN7yBhOKS/sWk37OgqSVg==
X-Received: by 2002:a17:906:38cc:b0:889:5686:486a with SMTP id r12-20020a17090638cc00b008895686486amr1385723ejd.30.1681550191493;
        Sat, 15 Apr 2023 02:16:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a3bf:4ed:6c53:2a36? ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id h3-20020a170906530300b0093a0e5977e2sm3503998ejo.225.2023.04.15.02.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 02:16:31 -0700 (PDT)
Message-ID: <5d629ff3-c5ae-bd00-e70d-8c0d58365ce3@linaro.org>
Date:   Sat, 15 Apr 2023 11:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ASoC: dt-bindings: wm8753: Convert to dtschema
Content-Language: en-US
To:     Saalim Quadri <danascape@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414223801.1106550-1-danascape@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414223801.1106550-1-danascape@gmail.com>
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

On 15/04/2023 00:38, Saalim Quadri wrote:
> Convert the WM8753 audio codec bindings to DT schema.
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
>  .../devicetree/bindings/sound/wlf,wm8753.yaml | 62 +++++++++++++++++++
>  .../devicetree/bindings/sound/wm8753.txt      | 40 ------------

Guys,

You choose unusual bindings to convert to DT schema. It is fine but
honestly, less useful, with limited impact. This is an old, 12 year old
binding without users. Maybe it would be even removed by now...

I suggest converting ones which have a real impact - have users in DTS.
Otherwise you will be putting quite a lot of effort for no real gains...
because what is the difference between this binding being TXT and DT schema?

>  2 files changed, 62 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8753.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8753.txt
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

