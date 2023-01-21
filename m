Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C55567683C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjAUTGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAUTGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:06:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A491F23650
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:06:49 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so5879903wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8DfHo6+2cR5G36izj5IdbaMWn0yli9T2fcLAtdygnkg=;
        b=nNVAF8Ai2srOYxgHMMSLcjMfMSJIaJKtNn8mahBIbadysRz6/1IaIYPCZc9fNT76X0
         /ld71XvhCdIoYYwg5Ip5ZweklxTNm/nIpdTF1HP/RSyhfC/kVrx3pbCWZ9+SjNuejh7l
         LFJjRISn7PlBP1HQEf4Bntv1ye+dlOM1fnoF9gIzimWx2Onki6KJn8IpvVriXVb5DipA
         W1zVr6hX8itcxEypRI4OR4t8FQH13XFCM2lHhED4F7mjnhCjhSCGpWb5Smc17w8qfmou
         CAeBQVgY657JeupI7OhXooH33r25EnulJ53FhTSFA+phOz2Ds+aaPR0YKIW24AEiwcuA
         xCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DfHo6+2cR5G36izj5IdbaMWn0yli9T2fcLAtdygnkg=;
        b=mWYaMqJjqOg9CgXo9n5lXCI6XVTRvxZetZNBvY2eJyn7sriZgwfn19NchTKAA/ddoB
         /sN3Cegb7Pz8gTKAqhWTKq4WPSLuxbSlOBXKxO8g2EizbfRjY9yHAEV2dpDXyIotOlvc
         suhJdst/1Oupm39M2jQo20KM3LV3SrQwBXhaQqbdqmkpKwr0KrUjS0e2raWiJFI6zNle
         nzcVT2JSiEIOrcmUp3yxxAgJ+IOwc1fWanO2HIBrZFLAsimMABxt4yqHlsFmvUgRl60f
         U8jd9fLbfi4P1j+Hut0FVVmJI03mRDN5I22WJ9X3X2uZH2MeuBP5fnMcJpdMC6VupaZ5
         tH4A==
X-Gm-Message-State: AFqh2kqAboQ0XIVwo02qxfUHv4ZHvF8ETlvvmDoFafYjZD2OtLOugyo6
        HpsP9VmMkIL+oi5Zq/qqPHc9wA==
X-Google-Smtp-Source: AMrXdXs35m2RpMWRgaSk7+Xj1XDLefPiYN4z7MFYdzeMJV+rnK5EyVmWU+xxPWKMXb+fv0qYvz5pmw==
X-Received: by 2002:a05:600c:5021:b0:3d9:9755:d659 with SMTP id n33-20020a05600c502100b003d99755d659mr18386535wmr.22.1674328008214;
        Sat, 21 Jan 2023 11:06:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bcb9a000000b003db2dede1a2sm5858414wmi.26.2023.01.21.11.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 11:06:47 -0800 (PST)
Message-ID: <3865e4ae-99e9-bba7-6abf-76d92e79b178@linaro.org>
Date:   Sat, 21 Jan 2023 20:06:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 09/10] arm64: dts: qcom: sc7180: Add support for HDCP
 in dp-controller
Content-Language: en-US
To:     Sean Paul <sean@poorly.run>
Cc:     Mark Yacoub <markyacoub@chromium.org>, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, tzimmermann@suse.de,
        ville.syrjala@linux.intel.com, stanislav.lisovskiy@intel.com,
        matthew.d.roper@intel.com, imre.deak@intel.com,
        lucas.demarchi@intel.com, manasi.d.navare@intel.com,
        swati2.sharma@intel.com, bhanuprakash.modem@intel.com,
        javierm@redhat.com, jose.souza@intel.com, lyude@redhat.com,
        hbh25y@gmail.com, arun.r.murthy@intel.com,
        ashutosh.dixit@intel.com, ankit.k.nautiyal@intel.com,
        maxime@cerno.tech, swboyd@chromium.org,
        christophe.jaillet@wanadoo.fr, quic_sbillaka@quicinc.com,
        johan+linaro@kernel.org, dianders@chromium.org, marex@denx.de,
        quic_jesszhan@quicinc.com, bjorn.andersson@linaro.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org
References: <20230118193015.911074-1-markyacoub@google.com>
 <20230118193015.911074-10-markyacoub@google.com>
 <aee03688-54b6-ed9f-e32c-b46e31d72198@linaro.org>
 <Y8q5UfpIg0+qnAuG@art_vandelay>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y8q5UfpIg0+qnAuG@art_vandelay>
Content-Type: text/plain; charset=UTF-8
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

On 20/01/2023 16:54, Sean Paul wrote:
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

What do you mean "better things to do"? I review the patches as that's
expected from maintainer. I spend a lot of time on so indeed I could
find some other ways to use it.

I spot something which is obvious mistake, although trivial and not
important, but clicking automated answer is also trivial for me and
fast. And yes. 90% of my reviews answers are automated because people
cannot learn to test before sending, cannot learn to read Submitting
Patches and many other trivial things. Clicking this automated answer
was also trivial from my point, but entire discussion including your
disagreement about incorrect title (read Submitting Patches) instead of
just implementing it - is waste of time.

I'll then consider not wasting time on your patches.

Best regards,
Krzysztof

