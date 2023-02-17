Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EDC69B4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjBQVoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjBQVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:44:07 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4718A42BE5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:44:05 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bi36so3108927lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9whoLgYkr95I0qmzXxoT8Zd23sf4lcMepCK7U4SK1Ys=;
        b=uuhvqZnn4VGWdAwMrVDsiJOb+OngVD49lR7BaqumkAZlmSVVZ+bO1BBC1XshQ3i/Ng
         sLkP966ekriU9WGhjdx43i41ZaKO1qzKRYu7z7LK8uqj20q3l9/hV2sWGK8zAVdQCTcj
         6MoSJ57P0YrGj56XmL/WU5Zxv6yJriy/YhQDCYnd8ljvl9s2x41tyu4LdD7Zz/xEhSzn
         /TPVgIedtB6M8THj+z1p64u7fHvHXTOtubWu9eRBt1/bYf6/5oAIuC2GftNZ+zSmwXiq
         Z55Gx2OX9yXui6OAappzqczS0ubsq2LJbe8G7fgCzTe4YUU12gu6x8dk+myZVC+MQNTW
         /RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9whoLgYkr95I0qmzXxoT8Zd23sf4lcMepCK7U4SK1Ys=;
        b=FaLVt/StyHTpVWTyBVO5oEnf5DXdh2rhJjvh97TdVvCzmZoBExwNDqXXZLIxQolKiu
         c5Ffp33Fd4btfGDnBPIESYN8vCLfZYVPHQJpO83LSuPe32S9bB2coZldLz4aKVLJzm5L
         dR7rWniELrZcuB1QAA/3S8PJDtX4H/6Fng21yfP/adIVvn+rNYaxRc18tqnmRX3LRMGQ
         990SsN9T4xLEjIZHg0p4ZX4QsNYBBVQcmDebICmP3j1jtpNQBf1jaK52oQF55CYnJ8mX
         t/N8PKaeBlZFgXeWYmjk5Xs23+j7ntH4EyGafR2ylikTyBWzDIbFPOqud7+qylugSL+4
         sidQ==
X-Gm-Message-State: AO0yUKW6YRLg6U27AfDcj4aymKBkQ2KqqE3kmn+vys9ejM1K1J6CVEB9
        J9R1Zl5/0MBJ2mC64e2W+Vebig==
X-Google-Smtp-Source: AK7set9P7pckgC1TAH5/lIS/YQtMX5b7b17rnIuijGqF+/f/RFGYFN1NPluvCm3J/1jazGtHEUduuw==
X-Received: by 2002:ac2:51c7:0:b0:4d8:82d9:3c10 with SMTP id u7-20020ac251c7000000b004d882d93c10mr454459lfm.63.1676670243521;
        Fri, 17 Feb 2023 13:44:03 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v12-20020ac2592c000000b004db4b7ad6d1sm788429lfi.31.2023.02.17.13.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 13:44:03 -0800 (PST)
Message-ID: <aba38acf-d68f-27a8-eccc-f4a7b3b3535d@linaro.org>
Date:   Fri, 17 Feb 2023 23:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 03/14] drm/msm/a6xx: Introduce GMU wrapper support
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Douglas Anderson <dianders@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
 <20230214173145.2482651-4-konrad.dybcio@linaro.org>
 <caae5c4b-4aa6-5219-3278-92c3bed7868d@linaro.org>
 <1c2f6e03-8b16-1ee2-bdbd-8f84219acb36@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1c2f6e03-8b16-1ee2-bdbd-8f84219acb36@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 17/02/2023 23:41, Konrad Dybcio wrote:
> 
> 
> On 17.02.2023 22:37, Dmitry Baryshkov wrote:
>> On 14/02/2023 19:31, Konrad Dybcio wrote:
>>> Some (particularly SMD_RPM, a.k.a non-RPMh) SoCs implement A6XX GPUs
>>> but don't implement the associated GMUs. This is due to the fact that
>>> the GMU directly pokes at RPMh. Sadly, this means we have to take care
>>> of enabling & scaling power rails, clocks and bandwidth ourselves.
>>>
>>> Reuse existing Adreno-common code and modify the deeply-GMU-infused
>>> A6XX code to facilitate these GPUs. This involves if-ing out lots
>>> of GMU callbacks and introducing a new type of GMU - GMU wrapper.
>>> This is essentially a register region which is convenient to model
>>> as a device. We'll use it for managing the GDSCs.
>>
>> Why do you call it a wrapper?
> That's what Qualcomm calls it.. The GMU-less GPUs have (almost) all the
> same GMU GX/CX registers as the real GMUs in this 'wrapper' region, so
> that lets us reuse some code with gmu_(read/write/rmw) calls.
> 

Ack. If you can add this to the commit message, it would be great.

-- 
With best wishes
Dmitry

