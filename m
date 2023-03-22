Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDE66C535B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCVSMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjCVSMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:12:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4FB64B2C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:12:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b20so43555535edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679508730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=puINCtdjibA0BYbSrHoIfwhwVYXsutPsDY4I7ib4bzM=;
        b=J7Ks+YQakaDhUbwe8fWKUNhebNRsFdwb/Lt2TOCFMNg+p9GiUx1mGrdm+ePPnPiToA
         joVvFXZ9IRD5fpifPU4c6U+tOqPfs4b5/hFXOUQXGaHUMdrpDnzHgUfsLtoggBWT7Xzw
         kmaFq+69ED1xC9xB5ZfCJha8yF5WS0xB1wIu9u74lHB0WBIRKArwWjkMY627UXPANUU1
         uP8HarJiZUN1dCQqJoR+JCZ26kewvnKyt+h1HlQKFxeH5+SHm71Gdcsao96kZGCJ+d3Y
         nI00zCQ86niFQuFoR/A54EHftmRZ4p7/FmMiiEStiSS+lFIH+6h35+46PBejBJJrwfGJ
         g3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679508730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puINCtdjibA0BYbSrHoIfwhwVYXsutPsDY4I7ib4bzM=;
        b=2jlNY3b8XvvRW2NYCViFtvPPtN2CbN9/M3EVn/M350tqcYLjo+0TtFnweRymZx9HLC
         +C/GMlOFYW2p+eaO3AtexdTWgOSEqtyMblVcaHcyeA6taR4w44N1SUXpA/4OYvjfB2Wf
         XFFSQUGYhG6x5Is/UFXo6qY++C5YpbMEGQnaT7fnylx/y4eiiSDX5feTVrN/52E+K1Gh
         ynI/yI3Ybv93nGLhKv92C7KqSWp0sT2C4HRq1v5IDtkSq/XfG4CxywyRpSfoI50nW87P
         qbu/ge61BwzQfuMNKhv6rtEcuQo0elyyuhZY9j3p6DOoZ1wtNSqUsRTR1jQ09wW8Bw2Y
         TWdg==
X-Gm-Message-State: AO0yUKVBO3DbeNlzPi7LJvdC/0YTPphoOtHmrhAOiUi/w2jc44b72Rdo
        2V3Vgg+2yq4A+nLDeANdaJs19g==
X-Google-Smtp-Source: AK7set+vT8b6vldZsA+TIPblzpsRJ83hqYXESjC2wwa3hOGcErQIr0FtnbAyQvVwSpd8ejjf0q1adQ==
X-Received: by 2002:a17:906:720f:b0:8b1:2bde:5c70 with SMTP id m15-20020a170906720f00b008b12bde5c70mr7719669ejk.2.1679508730430;
        Wed, 22 Mar 2023 11:12:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id a27-20020a509b5b000000b00501dd53dbfbsm2681070edj.75.2023.03.22.11.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 11:12:09 -0700 (PDT)
Message-ID: <74309bed-e46c-69fc-e0c7-6d06c30fbc4f@linaro.org>
Date:   Wed, 22 Mar 2023 19:12:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] pwm: rcar: drop of_match_ptr for ID table
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230312135120.357713-1-krzysztof.kozlowski@linaro.org>
 <20230312154210.ovm54x2qtcv7fp7r@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312154210.ovm54x2qtcv7fp7r@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 16:42, Uwe Kleine-König wrote:
> Hello,
> 
> On Sun, Mar 12, 2023 at 02:51:19PM +0100, Krzysztof Kozlowski wrote:
>> The driver can match only via the DT table so the table should be always
>> used and the of_match_ptr does not have any sense (this also allows ACPI
>> matching via PRP0001, even though it might not be relevant here).  This
>> also fixes !CONFIG_OF error:
>>
>>   drivers/pwm/pwm-rcar.c:252:34: error: ‘rcar_pwm_of_table’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hmm, I wonder what else is required here to trigger that warning. On
> amd64 I also disabled CONFIG_MODULES as otherwise rcar_pwm_of_table is
> used by
> 
> 	MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);

1. x86_64 allyesconfig, remove CONFIG_OF
2. Build with W=1 (this was GCC)

Best regards,
Krzysztof

