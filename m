Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6984A6388EB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKYLkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKYLkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:40:02 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDBE2C7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:40:01 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id l8so4838677ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcxKmdgfbTSuheVeGfm/PoNcm+leI0rQn6Dvc+YG4IU=;
        b=Btc1dn+ZPK0HG7fEhp5685GlTMRNUegVEoscY23y3dUbaul91asXd7VS7qEugobiyq
         OCvYYiRwF0a2NF6mztYSkOE4JhyhOLr5zeALQCWDKXj+AdspmOU35NPUF37/CIluIP9C
         E8d5ofBgSzrEaeMU0kFWLnf1pjZKW1NSExFdmQx5vQ640krj617uD4IHd5J+iL4w2p7p
         g5h1zNb++Opn4bNqlaSQylMubnFWTPBLHYm8r1NVSdoH5/CZRCwiJ4QoBeIMzM2R0Fed
         pKaOQMz16xWw/7SuP4c2BpHET+Tkj0W8G67M8/tTBZmyxB5PRk6bNOvXnZhaIcvwd6sV
         Kb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcxKmdgfbTSuheVeGfm/PoNcm+leI0rQn6Dvc+YG4IU=;
        b=kjQgJMWRwxvq5YhFQAbkPUYCDLg/X7E7oT5PmS3IvVsOJ1Ivb6jGgEfS9bCKrJre5D
         3eup6Q/phvy3mSvPh2TJqGp5dFSMWzzquJ2b+J33E/ErCKFXeWqKacZpr1Nn7UhZj5hn
         IO5gm12j/Mj9EF8UDALVXDRqdk21hPWP8ZYzZ80nbQEDUActrjY93Rch9VRFbQAo8oK+
         F2RvF8Ek26MH385Iyn9nZVFdnP47miryTKsEYDkqGWH8ctSCFgTNk5Rk6EuR8VsMeeBm
         BemVxELHUjamdfnkTSkjOEW8b4Z7qJJubA/fhYEbjRRYn+vnXvmhodmCNrHqUDCja695
         KZvQ==
X-Gm-Message-State: ANoB5pmu/zOEf61KceW07XnvFN/DI/fFo6SGvykjpihZC340AA3zfvRv
        rfBvOSXknUW0se1DbTSC3c/SoA==
X-Google-Smtp-Source: AA0mqf42gPN0aOYhoRB5SGHodZN1bdXWDz5VDkbuhxfJBJscmj2VEzq31L6Ul02ldcVvfe9xAVInQw==
X-Received: by 2002:a2e:8891:0:b0:277:a4e:98f2 with SMTP id k17-20020a2e8891000000b002770a4e98f2mr12451980lji.358.1669376399755;
        Fri, 25 Nov 2022 03:39:59 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c28-20020ac25f7c000000b0049478cc4eb9sm487347lfc.230.2022.11.25.03.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:39:59 -0800 (PST)
Message-ID: <8cd6fc0f-0824-46e3-2b4a-aca5d968c6a7@linaro.org>
Date:   Fri, 25 Nov 2022 12:39:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: syscon: Add tesla compatibles
 found on FSD SoC
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sriranjani P <sriranjani.p@samsung.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>
Cc:     linux-kernel@vger.kernel.org
References: <20221125070657.28335-1-sriranjani.p@samsung.com>
 <CGME20221125070709epcas5p329c4a6d9caf4e9903b60f2e6624fb7b3@epcas5p3.samsung.com>
 <20221125070657.28335-2-sriranjani.p@samsung.com>
 <13a33962-ac55-e3f1-933a-a9addf9bc10d@linaro.org>
In-Reply-To: <13a33962-ac55-e3f1-933a-a9addf9bc10d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 12:29, Krzysztof Kozlowski wrote:
> On 25/11/2022 08:06, Sriranjani P wrote:
>> Add compatible for Tesla SYSREG controllers found on FSD SoC.
>>
>> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
>> ---
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> index 4e4baf53796d..8c3334999bec 100644
>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> @@ -69,6 +69,7 @@ properties:
>>                - samsung,exynos5433-sysreg
>>                - samsung,exynos850-sysreg
>>                - samsung,exynosautov9-sysreg
>> +              - tesla,fsd-sysreg
> 
> I think we made mistake starting from 5433. Before (Exynos3/4/5) there
> was only one block called actually SYSREG. For example on Exynos5433 we
> have SYSREG_DISP, SYSREG_CAM1 and so on. These are different so we
> should have dedicated compatibles. The same for Tesla - please provide
> dedicated compatibles per each block.
> 
> I'll fix Exynos5433. Maybe someone can also fix Exynos850 and Autov9.

To clarify - in case of Tesla, you do not need the fallbacks, so you
just add few of:
   - tesla,fsd-xxx-sysreg
within the enum.

For Exynos850 and Autov9, just like for Exynso5433, we should keep it
backwards compatible, so we need fallbacks.

Best regards,
Krzysztof

