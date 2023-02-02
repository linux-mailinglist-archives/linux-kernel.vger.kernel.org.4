Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDD4688480
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjBBQds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjBBQdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:33:46 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2973768AD2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:33:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y1so2250938wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELhAk9cmPsEFAZpdfPOCHRf6Rnr5gKS4WgJbFOoKs04=;
        b=Ops8gJoXuzFr1QL91bR08/jWApYqV65k1CXQwmYeh1wfsrjCyt7uSHgnq/FWhLImmg
         Y9d/mFMdkI/nEs47hsoIKYRXxyWomze8NDn2zzxQ8TurA60Mp5dETyIp/EZVa5+ShsEF
         QDtHflsj4lzBLaVrQ1UETUbVuEEuzNZRH35AOGGWcUV3asFKc2saDDVx8jtWh5zjjhZZ
         ylr6iup02ZEQHQCRsdZKYWweOsKygP+YhK9WK4O3nYOTtUVF6kVPAi6vEBBTHVT15SBI
         sLxg6JAls+67Gy6R1T2gZ0cqPgeIQJz0nDtKvPpkhpMYXMAwrVpSZmyySa+wD1y617yB
         gldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELhAk9cmPsEFAZpdfPOCHRf6Rnr5gKS4WgJbFOoKs04=;
        b=WrwmGM/h92svqWJpBBJKL3vJnPGzqKetHMu51xVU1s4lbKz6ZuhhzJ/xwVDvUfLGV3
         vnp80BptTqmzY+vNhoGQpC6z5MliVGKkg2JNnPIUXPn0G+3LsiuoD9eGNxRQvupQJohS
         rok3F5QakMKRmhUlYIZybT0o3R+54shdkM+KMZ0pA2x8SOukKkNLG7YDSvTMjwQoq0Oy
         Et1Lh8i9wilW+e+joiFETVn6RCq4IZ4NlExvpOadd7LLnloov2a4EBGSm5mGQF5SlEkg
         Q7n/gH83EBHWMOQKvRg74fXxJkTY8qRHKqJj5AQt3AZysalPM6pSRixa5r+PTttdC8Rs
         HfcQ==
X-Gm-Message-State: AO0yUKU7Wh27cooyxRwvmzdfytUU0cD1exxY1TNDRxGoDJsDNf3meZ3K
        Q3q/tQi+EvCmV1wCKSN5gHFxxklFmvJRmmUY
X-Google-Smtp-Source: AK7set8Kr1+4XSAPiGPRYfumuWZuFHg32pJQbheua8CIT1j8p0VuhRy0BL287FCD6xQHjlmbhHELQA==
X-Received: by 2002:a05:6000:151:b0:2bf:ec0f:af79 with SMTP id r17-20020a056000015100b002bfec0faf79mr6357504wrx.63.1675355620765;
        Thu, 02 Feb 2023 08:33:40 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b003dc434b39c2sm5599993wmq.26.2023.02.02.08.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 08:33:40 -0800 (PST)
Message-ID: <fa6dc60c-3799-d384-da24-f282b7cbd3ef@linaro.org>
Date:   Thu, 2 Feb 2023 17:33:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 00/13] mailbox/arm64/ qcom: rework compatibles for
 fallback
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 17:18, Krzysztof Kozlowski wrote:
> Hi,
> 
> If entire approach is accepted (and correct), there are no dependencies and
> patches can be picked independently.  Although the best in the same cycle, so
> there will be no new `dtbs_check` warnings.
> 

This patchset will conflict with:
https://lore.kernel.org/all/20230126230319.3977109-2-dmitry.baryshkov@linaro.org/

In few places it actually re-does Dmitry's patch, so probably we should
both come with unified solution.

Best regards,
Krzysztof

