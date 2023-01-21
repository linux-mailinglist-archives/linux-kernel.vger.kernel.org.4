Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372BD67659E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 11:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjAUKQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 05:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAUKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 05:16:26 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A63E3D906
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 02:16:24 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e16so8170669ljn.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+Pyl+joRSSSHYvf7WpDkCWmQvZq+W+aRVbNCqAWyN0=;
        b=aw4vZZx4wkPSHemLhBCOWKkcGKy2I6AvBjN7UL/hvRcVPDSIlGrklw2jTtkH/RvGZb
         uueF5MZpeSFKiA06BhrDArxQaLgpWridTlFnBJcqHTMEN8Es+P7RiSkewrQNPSK/4g3K
         eqf2aNalnUtTCszMbvy4i2lDVXJUE56aCvqtzCQPf/d2rREW9rsLlnb3NRwtpkvW+0rg
         ZW19EDyGbGyLGScXmsOmfTRVSVKLQoSZJnVmY+4+H99Ueooe6NqfOPkITPYRuAhx4Rxi
         3NibyE+BBWFbhVxIs01RoDCYx7jr/UkqI8VdnfrR9x8kU3kL3uPF5LxS/Sv6NCiAZa2w
         IdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+Pyl+joRSSSHYvf7WpDkCWmQvZq+W+aRVbNCqAWyN0=;
        b=jWCaUWEY1/nXTZoY6AJILyckw/IL06hvzfQPIunWfhpMeyRjLGRtK3Q7y+b/nG1s/V
         CpKBglSStLGwRDAaAheMl0Blb650GwcSVKV8Gie/K42ioda9IJ6Hf7ZAQwAxUqv+/oyB
         D9mFzl0dPyG6EsFlM26BH/9//2gXhsW9oDUmqE1KPo0aeiAoupZS8SBOuouu6x0v+KH7
         7ZjZfjoRlBFJ0zDzf6Kxj8ZFU0OlXtXM/PEhyFNJuTHDdUUTEyxtlTywvveTlHrBtxrx
         7Zpcv26j2hUXn+PsmrkjX7+yRXWPq8uYyEmSncdzEoBmBVFIgup/To66Ljf0wurzm5BW
         Tx/A==
X-Gm-Message-State: AFqh2kpsXc8h0Wkc9F6mmwAZh2iJ2gZysl6LyPW1Tt1mzANw8cxAmUba
        XBk3KGLpiP788OrR1itUpyVNJg==
X-Google-Smtp-Source: AMrXdXsmnMg48aeBhogSIz+DbIJdUnf4nEqxin4EPTgBYOA8j6w8atXnnKg+jW8ZCAvlcIjIEdWAAg==
X-Received: by 2002:a2e:3807:0:b0:276:dc01:8058 with SMTP id f7-20020a2e3807000000b00276dc018058mr4630164lja.1.1674296182695;
        Sat, 21 Jan 2023 02:16:22 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p19-20020a2ea4d3000000b0028a4a907a33sm3023710ljm.84.2023.01.21.02.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 02:16:22 -0800 (PST)
Message-ID: <7116584e-f5a1-f404-8cfc-d1d159a4d647@linaro.org>
Date:   Sat, 21 Jan 2023 12:16:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 09/10] arm64: dts: qcom: sc7180: Add support for HDCP
 in dp-controller
Content-Language: en-GB
To:     Sean Paul <sean@poorly.run>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Yacoub <markyacoub@chromium.org>, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        robdclark@gmail.com, quic_abhinavk@quicinc.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        tzimmermann@suse.de, ville.syrjala@linux.intel.com,
        stanislav.lisovskiy@intel.com, matthew.d.roper@intel.com,
        imre.deak@intel.com, lucas.demarchi@intel.com,
        manasi.d.navare@intel.com, swati2.sharma@intel.com,
        bhanuprakash.modem@intel.com, javierm@redhat.com,
        jose.souza@intel.com, lyude@redhat.com, hbh25y@gmail.com,
        arun.r.murthy@intel.com, ashutosh.dixit@intel.com,
        ankit.k.nautiyal@intel.com, maxime@cerno.tech, swboyd@chromium.org,
        christophe.jaillet@wanadoo.fr, quic_sbillaka@quicinc.com,
        johan+linaro@kernel.org, dianders@chromium.org, marex@denx.de,
        quic_jesszhan@quicinc.com, bjorn.andersson@linaro.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org
References: <20230118193015.911074-1-markyacoub@google.com>
 <20230118193015.911074-10-markyacoub@google.com>
 <aee03688-54b6-ed9f-e32c-b46e31d72198@linaro.org>
 <Y8q5UfpIg0+qnAuG@art_vandelay>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y8q5UfpIg0+qnAuG@art_vandelay>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 17:54, Sean Paul wrote:
> On Thu, Jan 19, 2023 at 11:35:32AM +0100, Krzysztof Kozlowski wrote:
>> On 18/01/2023 20:30, Mark Yacoub wrote:
>>> From: Sean Paul <seanpaul@chromium.org>
>>>
>>> This patch adds the register ranges required for HDCP key injection and
>>
>> Do not use "This commit/patch".
>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>>
>> This applies to all your patches. Fix it everywhere.
> 
> My goodness, this is peak bikeshedding. Surely we have better things to do with
> our time?

While I would not enforce this rule if there were no other issues with 
the commits, Mark will have to cleanup/rework commits anyway, see other 
review comments. Thus removing/slightly rephrasing a commit message 
sounds like a minor issue to me.

>>>
>>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>>> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
>>> Link: https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-15-sean@poorly.run #v1
>>> Link: https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-14-sean@poorly.run #v2
>>> Link: https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-14-sean@poorly.run #v3
>>> Link: https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-14-sean@poorly.run #v4
>>> Link: https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-10-sean@poorly.run #v5
>>
>> Drop the links.
> 
> Why? I've always done this, it seems helpful to me?
> 

I'd say, if you wish to include them, they belong to the cover letter, 
not to the per-commit message. Once landed, they will serve no purpose.

-- 
With best wishes
Dmitry

