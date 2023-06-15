Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB6731168
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244407AbjFOHwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbjFOHwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:52:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D96726AF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:52:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f74cda5f1dso5590626e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686815529; x=1689407529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnLAb/o5l2EuhHYqpE8y7BrnGhDNpYQ/A+Vx7BWAr88=;
        b=wp56Ds3X9nkSr0F9ISHqBFM4O4uRWA1NeoaGxPwb6kiQi+kk/eQZdCCTtv3Nsm1OSB
         6sUSNcaqWAmbQO6qBPjhrlbTIhIVOnOdsdscPQD7utiRhUsQktfmZmsJ4a52zMWauGX2
         zgghpDCVOZDmQOs2TVaW3irBNAbVz+tErqkdOvYu0/pHwviwCdcJsHbTf21gd1/JyPPR
         fkxUPmXDEVjk4bjx+tlRH3+sgrOY7L5x+Xu23R44MwyWa+Dt/yEYCwOH6Ie3uP2GfZeY
         y/vxaIj/CtXOIEoGzjaUJ/UiJexwcqhdzmB+XwPMQjeFbKMSyyuBCXFDV/9bJnq4CJuh
         XbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686815529; x=1689407529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnLAb/o5l2EuhHYqpE8y7BrnGhDNpYQ/A+Vx7BWAr88=;
        b=Crol+q4upw626gJJyCgJHj21dwbi9EOLF9JKVkKOO935wYLRueN9be03kHEaanG5Zz
         4EPxEVzpZIRMbw7rGnM5cMlEVdH3q/h5BRlPpksrMyUv1lYo6Zs4MlyyMCUCm8obua7m
         KbWyeiLyZ/ZPTZC7lFs96lH0vkUFxrbhjzPrsJ00YQD9sOkS/UHBhZbJT60XeghR1o7u
         T5xFe15W4FA0YapMy/bU24Bz57qya92+yDPDOFdrt+tTTHj8Md5SqZxaPZT0Qal1Upb2
         gEgI1FFKdBhaG4Fo2UlRX7pz0FRuLY9CJ7b1URM1Tv2tknN6IrnNrQb+rEkrcZPK/Hmg
         4oDw==
X-Gm-Message-State: AC+VfDzsQAJceGtDlegVY7ojzI2cMQtd0yvutCsLCVePZskPmGBIwiij
        HuSnut+Pa22uQRnwRkItXr5+Jg==
X-Google-Smtp-Source: ACHHUZ6byeATepKDfRbb48D1WYuexmYDvekDU3GjrZKiJbCCViAjaUqDxWYYkI3TFgnr+axOqZQCiw==
X-Received: by 2002:a05:6512:1cd:b0:4f4:dd51:aec7 with SMTP id f13-20020a05651201cd00b004f4dd51aec7mr8412115lfp.54.1686815529466;
        Thu, 15 Jun 2023 00:52:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id w15-20020ac2598f000000b004f138ecab11sm2482805lfn.24.2023.06.15.00.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 00:52:09 -0700 (PDT)
Message-ID: <8568eead-90f6-ce15-d483-4d72dbab6294@linaro.org>
Date:   Thu, 15 Jun 2023 09:52:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v6 00/22] Restructure RPM SMD ICC
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
 <0764b5fda92acb995ffbd05c4b3d2b2f.sboyd@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <0764b5fda92acb995ffbd05c4b3d2b2f.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.2023 02:49, Stephen Boyd wrote:
> Quoting Konrad Dybcio (2023-06-14 11:04:19)
>> This series reshuffles things around, moving the management of SMD RPM
>> bus clocks to the interconnect framework where they belong. This helps
>> us solve a couple of issues:
>>
>> 1. We can work towards unused clk cleanup of RPMCC without worrying
>>    about it killing some NoC bus, resulting in the SoC dying.
>>    Deasserting actually unused RPM clocks (among other things) will
>>    let us achieve "true SoC-wide power collapse states", also known as
>>    VDD_LOW and VDD_MIN.
>>
>> 2. We no longer have to keep tons of quirky bus clock ifs in the icc
>>    driver. You either have a RPM clock and call "rpm set rate" or you
>>    have a single non-RPM clock (like AHB_CLK_SRC) or you don't have any.
>>
>> 3. There's less overhead - instead of going through layers and layers of
>>    the CCF, ratesetting comes down to calling max() and sending a single
>>    RPM message. ICC is very very dynamic so that's a big plus.
>>
>> The clocks still need to be vaguely described in the clk-smd-rpm driver,
>> as it gives them an initial kickoff, before actually telling RPM to
>> enable DVFS scaling.  After RPM receives that command, all clocks that
>> have not been assigned a rate are considered unused and are shut down
>> in hardware, leading to the same issue as described in point 1.
> 
> Why can't we move the enable of DVFS scaling call to the interconnect
> driver as well? We want the clk driver to not reference the interconnect
> resources at all.
That would result in no rpmcc ratesetting on platforms without a functional
interconnect driver. The DVFS call concerns both bus and !bus clocks.

Konrad
