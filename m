Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6773C638CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiKYOr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiKYOrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:47:24 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65AE5F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:47:22 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id c1so7223194lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osoEBytHjlQAPUyZve5rkRqahTmWVeqKGttLOtMjR3Y=;
        b=usClvSs3mC6FvIhfguF/sEt/gkxumcuZsEzXV26BLwCRWyr07wpUDcacmF61zVLKPR
         4b46+DrsjeGTpJs4Rz6cKLkXOJNviO0ZeBoqcGZGt6PWmxFN+kR+a96LaG8VwLpSqDkx
         goU+yxqpDJ/wWC5qZvAINZkaHs5Yqu6Dyn/gkN36gYSpsynBgMP78DiVuICmU5IoYSDu
         ZSN5X5Za9PqaptEEca8OmXdQ9gvV5B+AF+roHy6kclTYwEc+dAsg6/RiBrprc8VtRRtb
         ue6EdI+9kSpsFmIkikRBiN+RbXp81fj4XYloUMa16gJjB+8ssQrKA0NK0EVWlEfJjx5e
         wKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osoEBytHjlQAPUyZve5rkRqahTmWVeqKGttLOtMjR3Y=;
        b=nt5YDLd4TgAPEAVuxyE0zGsgwgvaKVAeIzqPanCMD4XL0gkCFIW1wp8d4+MPdShy4s
         lBDYidFYcFuf1laTdwsfkHgpcgiH5LFFa7o7YsiKsMl64JGzeWoYhHcg6I7mH6sj1GYG
         hbLaYUPjPKAgHgPk+DXGLrTpyJYGFd9aEJogcw+INverGbRlKIx5GYgVx6KYUT9mukFk
         KEpHnN4ls/9sht/QZoGo1uZY2LBY2tsmsp8FJb4gWSTYDFDaipviY1wqJ578ajo/Oc/1
         y0IeuNg1qtaOBmmZyjy5KmPK8E4YCNAhV4Jxp4pvzpQqEVsglfMYkdBshF12yi4lj4Iv
         aJJQ==
X-Gm-Message-State: ANoB5pnrTN//fsc1G3964qwzmeJXQeUvx+yx+hFNgL7obESYDNdkcNqB
        IUtBBqkV5NkD4zaDgq7HHTKrJQ==
X-Google-Smtp-Source: AA0mqf4JdsPg2OacWHAZHBS95kHhrvSJgsXU9oA5FBTdtRat1RDp/3S8jHWNMMuKkVsrI0TT4mXz8A==
X-Received: by 2002:ac2:4843:0:b0:4a2:1169:3934 with SMTP id 3-20020ac24843000000b004a211693934mr13530237lfy.279.1669387640881;
        Fri, 25 Nov 2022 06:47:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w10-20020a05651234ca00b00494942bec60sm557057lfr.17.2022.11.25.06.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 06:47:20 -0800 (PST)
Message-ID: <dfd956d5-d62d-52ac-c485-afc71c441df5@linaro.org>
Date:   Fri, 25 Nov 2022 15:47:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos5433
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
 <20221125112201.240178-3-krzysztof.kozlowski@linaro.org>
 <CAPLW+4kwFCLaiowajdCnA09eT4emOB-3d-6cbA=ZYyRLwYuCxw@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPLW+4kwFCLaiowajdCnA09eT4emOB-3d-6cbA=ZYyRLwYuCxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 15:22, Sam Protsenko wrote:
> On Fri, 25 Nov 2022 at 05:22, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Exynos5433 has several different SYSREGs, so use dedicated compatibles
>> for them.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Cc: Sriranjani P <sriranjani.p@samsung.com>
>> Cc: Chanho Park <chanho61.park@samsung.com>
>> Cc: Sam Protsenko <semen.protsenko@linaro.org>
>> ---
> 
> Hi Krzysztof,
> 
> Just curious: what is the rationale for adding those more specific
> sysregs? AFAIR, e.g. in Exynos850, different SysReg instances have
> pretty much the same register layout.
> 

On Exynos5433 all these blocks have different registers. Are you saying
that Exynos850 has four (or more) sysregs which are exactly the same?
Same registers? Why would they duplicate it?

Best regards,
Krzysztof

