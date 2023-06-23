Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798D073ADEA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFWAlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjFWAlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:41:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F381FC2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:41:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f955850e30so1552911e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687480908; x=1690072908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FnBlHYwMZ9lJep8bxCghDkQQW2uToj06bE3oV1fX/ZA=;
        b=EC5a6JU+v7Zbpm70kJjSs2tawiTV4zC1FWSIGTv0q4pPIyNEF4J46LsGErGMoe4k//
         eq9t2hdhkWWSR0jUXfxoOYQ7ca3VtFktY0RV9IUgzpF5eNIg0R0UsClKV5TcNu3gj7/p
         MGMs+8i2SmhYCo9qbK7Fgj4pMR2Pq1z/Cx/oCcftj95rtSttLAyPZhtmko7ez/TWCyMI
         kHY6+0AjnOsjDpyJDvfLxa9ISRJwlgUPHFi30u3WtEIrx+2W2gyHkIVkqAtoVELTeh6D
         siylrR8sLVRB0ZkXlGxY8XGLqfK//rhHEoCrKBv1xZr49+f/uGFAYxwhhfwUi2jU9/Z7
         i6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687480908; x=1690072908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FnBlHYwMZ9lJep8bxCghDkQQW2uToj06bE3oV1fX/ZA=;
        b=dIv5L8vV6TCfnjqLHHWUXkhrvaoW006OXcr4ym38XWDlgi24Y6xv4ZuQQyQtXXvvGI
         0z45aNBv6j+r5zFJcOeQzD2xtVf35bFY6OWq6qk4y8zN6Sx3mypR/pAN+hjr5Z5PWZeb
         6KGVqF2LDrKClSzd1cHorpVGqqrpAqfH/VH/ZI0cKjmQ7HOfRu2FYH+PMzaLwSZq1fsC
         V05AK8vMmy4z+g1z65ih2DuTBjH4ndyvYJ0YaSPH92aPCadHulmCtWyNAs7FpntZBOfV
         xolm3sFNUZMZw6owWSr+EHnL9NxLygtXGnzT5YAp+NMJ0C6gl+pt7WxNVSy2SN4E10hJ
         4lQQ==
X-Gm-Message-State: AC+VfDzkkdEyUXZ1Jo0kHIFFNPMeGSe/qdkpbU5XBhFpwmMDziSVrjb7
        YwhCSwkxcwht72uclG+AX4rbPw==
X-Google-Smtp-Source: ACHHUZ6YvyXVM4V18WeBDx3J5dkaKy+DyzMZeq7Hohys+X32z96d0MrmRQwCYRYslyfv0Cfubs2Klg==
X-Received: by 2002:a05:6512:1590:b0:4f8:70d2:672c with SMTP id bp16-20020a056512159000b004f870d2672cmr4529327lfb.17.1687480907934;
        Thu, 22 Jun 2023 17:41:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056512480f00b004f875356ab8sm1278005lfb.153.2023.06.22.17.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 17:41:47 -0700 (PDT)
Message-ID: <81866240-260b-0891-36ea-34676674c9b3@linaro.org>
Date:   Fri, 23 Jun 2023 03:41:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Freedreno] [PATCH 3/3] drm/msm/dsi: Enable DATABUS_WIDEN for DSI
 command mode
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        David Airlie <airlied@gmail.com>
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-3-c7069f2efca1@quicinc.com>
 <ky7sgsaohak2pcdf6pbhedfyrwk4ea7y3ekfqlw7rn6cpk4rhe@rjuhb23n37oz>
 <cf968ab4-e4c4-dcad-f7d1-4edff6f08147@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <cf968ab4-e4c4-dcad-f7d1-4edff6f08147@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 03:01, Abhinav Kumar wrote:
> 
> 
> On 6/14/2023 2:56 AM, Marijn Suijten wrote:
>> On 2023-06-13 18:57:13, Jessica Zhang wrote:
>>> DSI 6G v2.5.x+ supports a data-bus widen mode that allows DSI to send
>>> 48 bits of compressed data per pclk instead of 24.
>>>
>>> For all chipsets that support this mode, enable it whenever DSC is
>>> enabled as recommend by the hardware programming guide.
>>>
>>> Only enable this for command mode as we are currently unable to validate
>>> it for video mode.
>>>
>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>> ---
>>>
>>> Note: The dsi.xml.h changes were generated using the headergen2 
>>> script in
>>> envytools [1], but the changes to the copyright and rules-ng-ng 
>>> source file
>>> paths were dropped.
>>>
>>> [1] https://github.com/freedreno/envytools/
>>
>> More interesting would be a link to the Mesa MR upstreaming this
>> bitfield to dsi.xml [2] (which I have not found on my own yet).
>>
>> [2]: 
>> https://gitlab.freedesktop.org/mesa/mesa/-/blame/main/src/freedreno/registers/dsi/dsi.xml
>>
> 
> Thats because we havent submitted a MR yet for this on mesa.
> 
> Generally, our team does not have legal permissions yet for mesa MRs 
> other than mesa drm because we got permissions for the modetest.
> 
> Rob/Dmitry, can one of you pls help with the corresponding mesa MR for 
> this?
> 
> The xml file change was autogenerated so this patch can go in.

Ack, I'll handle it.


-- 
With best wishes
Dmitry

