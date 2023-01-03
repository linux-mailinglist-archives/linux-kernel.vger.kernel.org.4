Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7465BD24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbjACJ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjACJ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:26:55 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD375FB0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:26:54 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m6so34484439lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/w/HVtfVylFb92xZ3cLJHBmfw9Fvd9M+61nNyBqRlQw=;
        b=RTLhoxkH+nPWqbV4+/wsP1hbkiXd+l89odwyVICOIKfv0tv3vI2z2vgSLpeWzbdf/4
         7jmOlUMawjAT4OY3fnJMT1/gokohqPxF7zEav5Jw3V6G8/EP990p8jd8ZvQ+YHSZ5SNu
         P8jEtL4VPSoLQsiAcAe1GWE9XzBjGqJuFCsyeUd7axrIgN0MQ+JGCea0Z/9wjFJOXdFq
         tuw+RRIckHLwm6UCUUoP/YLPr+ZSdEFmbqPcx2X4vjjk5c24bUQmsGxqIOfoPsY/jE51
         e0cDJjFz9L+WEY61i+G38N6ICgYtH+c6tQZ1RpyPDYgDRZu4GzhBL7AOC/6Hr5jRbh9o
         RMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/w/HVtfVylFb92xZ3cLJHBmfw9Fvd9M+61nNyBqRlQw=;
        b=V6edb8UMtgh850Z2xE/mSQw9EJxspCbf4fzGToqtVakJaBYwVUtWaI8ecXGA1uGMAy
         nD+hDSti6pQjm/uFGo7sX1ifq1ms9Idrdc6H1iAtdNbgP94LqgHwUgMKvLZfJaNhZSZv
         s1fOb36i6EN/CLBu7VgjHOnJrNK6XXdMR2lpe0A0WKE8JOBckuIWSK9ab7hei6mPb5bw
         1vWt6Xo9n9WC0YuaFmKCWZ7z33ipx725RIfinmkkD8DWAVQSy7Tv7Nr2MkkSSj8hJAmL
         lt2ETrdZvLJXmPilLKhrD1yVs8QzSBruNBOGh9xW0FBDGff/l+iJ1R7dyq1kX5n+/+HW
         bDuw==
X-Gm-Message-State: AFqh2koYiEVWT3RUaY8akUJ/Z5Z4Uhx61n+czJbl7b0uTloFG6EDpXlQ
        084Hz+fzmmCG0lfs7KILijX2jg==
X-Google-Smtp-Source: AMrXdXtxBjEkK70iD51Dp0X3k5oQpocNZh8ibg9YbJMfLNtcc4svtr8iSFKyEPRp4WwGOQw+jjzdVA==
X-Received: by 2002:a05:6512:1116:b0:4a4:68b7:dee8 with SMTP id l22-20020a056512111600b004a468b7dee8mr15192136lfg.68.1672738012533;
        Tue, 03 Jan 2023 01:26:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24351000000b0048a934168c0sm4768418lfl.35.2023.01.03.01.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:26:52 -0800 (PST)
Message-ID: <207b6699-fe4f-8ab7-5ddb-4eb2e4183c88@linaro.org>
Date:   Tue, 3 Jan 2023 10:26:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 08/11] arm64: dts: qcom: sm8350: Use 2 interconnect
 cells
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        quic_jesszhan@quicinc.com,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        vkoul@kernel.org, a39.skl@gmail.com, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, swboyd@chromium.org,
        dianders@chromium.org, liushixin2@huawei.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20221230153554.105856-1-robert.foss@linaro.org>
 <20221230153554.105856-9-robert.foss@linaro.org>
 <deb17787-1a5a-89a3-3ecf-7690b4149f5c@linaro.org>
 <CAG3jFysU84LRcqQOspub+9vtsP3syiksrGX6D7i3ff+X6+mbTA@mail.gmail.com>
 <b8a0d9c5-eb26-c41c-1190-2628977bc582@linaro.org>
 <CAG3jFyuUV79nyjnqNysDKQSyYb4HUSWu-BvxG6LAz1Uavmvkbg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAG3jFyuUV79nyjnqNysDKQSyYb4HUSWu-BvxG6LAz1Uavmvkbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 10:24, Robert Foss wrote:
>>>> On which tree/revision did you base this?
>>>
>>> msm/drm-msm-display-for-6.2
>>
>> Then it is not a proper base for DTS changes - you will miss quite some
>> commits. The DTS patches should be based on Bjorn's SoC tree or
>> linux-next (although the latter sometimes can lead to conflicts).
> 
> Alright, then in that case this series needs to be split into 3 parts.
> 
> The dts fixes, remaining dts changes & the remainder of code.

The split of any fixes (or unrelated cleanups) is good idea anyway.
However code can go with DTS - just base on linux-next. If you do not
want to base on linux-next then splitting code from DTS is indeed one
more good way to send it.

> 
> Is this what you'd like to see?

Best regards,
Krzysztof

