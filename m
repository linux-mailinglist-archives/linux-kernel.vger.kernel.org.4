Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196D96C6944
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCWNNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCWNNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:13:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372862105
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:13:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso1801933wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679577183;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=juhp9OBUsPann54i4wUeJoNbrt/MgaPH7KWeZa71+xE=;
        b=jNzxhh+kAMOJUnJAJiZlm8CqqNjJB84FeneV/bsFBFNkwsv5ewzKW99RwM/+yo+dWD
         O5M7PoVQ+HmSm0Fp7TUSM4WUmaCD/M9RquYD/SYCw+xZ3DF85LQBhq6DffN9QsAzPSiz
         +SXGeH8zvrCymDFBZtcQHoWfSF5M0GCyh2Yk8xunJZ3oUEoj5sOSwvola6tWm9KPAExx
         wppVx0YrDi/ArfaymWwbqT75kwaGW9d3Z9Vn8zQPyMtL5GoGAHwYOoySoOmjx3hdS1VP
         UJk4RORne+G8ZcUQqELIerD3KaGhrzSzjw76MslFrWinmJXZ+hINTJ/vsGD5S7LbjbfF
         VXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679577183;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juhp9OBUsPann54i4wUeJoNbrt/MgaPH7KWeZa71+xE=;
        b=K14qQBM72ZRQQUG++ZGEBZf/memGJLHoZjlIo1SCGIs8bMXx6lUBKREMVghoqdaXm/
         6N1OOvK2YprjjDRrtBMNvJQA+SMqlIKPkG9r6cef4EZtpJZMpmjiGVSHg43zEW1GnxIy
         VGXW/3VN2yzSDMKkfzfXayaechpNQu8CzZyeiGWddRkMGv8bDZ+lz/KhPKCjbhcUDoLK
         51MOfDxyZtaGobIX4egw2TW/2uPimT1Dh7TkIoniB23/AsmURQggtlIqv1MJNS6Rf1um
         IpItwQVPFqX6qSTXX/lSWqcR/21Xj0DDXnDRaqRMEXMtrpinm5Kd9vJXFd0svTwX6OBz
         h28w==
X-Gm-Message-State: AO0yUKVQqbJI+Hr58zptoHVlPX7yaOAW9Gy3u5atQAaTL8BrLajtMzCM
        j8ZHN5yq7TOJrK3HAv5zVZ7vOIoODGQewkJY2v/6WQ==
X-Google-Smtp-Source: AK7set9AOlKnA/7JArDu4NZy/tacv+1Jc1By+62lRGQ2qjTDOfxTCEOmbDcLbYSrwaVOaWhWVZPiKA==
X-Received: by 2002:a1c:f709:0:b0:3ed:c763:2765 with SMTP id v9-20020a1cf709000000b003edc7632765mr2405501wmh.7.1679577183642;
        Thu, 23 Mar 2023 06:13:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e25a:65de:379a:3899? ([2a01:e0a:982:cbb0:e25a:65de:379a:3899])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b003ee8ab8d6cfsm1825918wmo.21.2023.03.23.06.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 06:13:03 -0700 (PDT)
Message-ID: <006bf3bf-ab9a-4a08-3ba5-fa23ff4ea05a@linaro.org>
Date:   Thu, 23 Mar 2023 14:13:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 6/8] arm64: dts: qcom: sm8450: remove invalid npl clock in
 vamacro node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-scsi@vger.kernel.org
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-0-3ead1e418fe4@linaro.org>
 <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-6-3ead1e418fe4@linaro.org>
 <35e3aa8b-ccff-25fa-42da-d8934ef366c6@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <35e3aa8b-ccff-25fa-42da-d8934ef366c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 11:47, Krzysztof Kozlowski wrote:
> On 23/03/2023 11:25, Neil Armstrong wrote:
>> Fixes the following DT bindings check error:
>> codec@33f0000: clocks: [[137, 57, 1], [137, 102, 1], [137, 103, 1], [137, 70, 1]] is too long
>> codec@33f0000: clock-names: 'oneOf' conditional failed, one must be fixed:
>> 	        ['mclk', 'macro', 'dcodec', 'npl'] is too long
>>
>> The implementation was checked and this npl clock isn't used for the VA macro.
>>
> 
> This does not look correct. DTS looks good, you miss some patches in
> your tree.

I'm based on today's linux-next, while the other lpass macros uses the npl clock,
the lpass vamacro bindings doesn't document the npl clock.

And I found no fixes whatsover to add the npl clock to bindings.

Neil

> 
> Best regards,
> Krzysztof
> 

