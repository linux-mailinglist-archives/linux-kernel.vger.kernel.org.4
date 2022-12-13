Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177164B5D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiLMNNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiLMNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:13:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AA39584
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:13:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x28so4821973lfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vd3T8ah0dWWDH2U5v0IMPHsJRf7PThuVXGlxa+Fk7UM=;
        b=V1fR4x97oaWfy1VMojxg6M8O2dPqeQVawUxtzpzfwbxeCJOzWCJmgQcNe8l22OI1k9
         UaJ06VWqGFv8hCDEuZth1+8OH+LI5MeQ1oK+ZdqHZ2dDwj3DZoumzNSLSu/m/7O6u5Z0
         tRDwRsta6XHOMSBHDue+xmitUdWdjlUYvLKE3aBX+gFymGdKjiJ+5xLke/pqW0Ayn/Lo
         SZ6vDRn4XE5bL1WcmnFRlMyuiAIIv2UHBig4XRzBv4vdDd2JGwA2cZik9/iHF91X/XWy
         q2OepdSYTD629UA1O7uWAQ0KOa+xHKscbiiTm6fegvMtXfJm/yn06Qs6oFQZ/oPMIWNq
         6yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vd3T8ah0dWWDH2U5v0IMPHsJRf7PThuVXGlxa+Fk7UM=;
        b=V7Y82l5wPGP8D6kX0Dd4n46kolQXKtSQjDoutQq98U1RxGW04MD7PEBAGetJzrUo61
         4X7rIoozbDpT0GQU3r7sz54sl3k1rlsgZQ7YLC71ThKCEHGhXSD/u8dsJS6Tc/B9BaYg
         nPYya0vdzUvTYUTH6qeh0X55YEAkPvi55TRsAfu3PZigbWsUcn4NWtsK6gNUP3+d2RuE
         UX67HdoJt+8hPS27cNHYpt1MOEz9eH+IlgEB2EgdnmWNwsgIicywGu/SxDX3mvOCDx9Z
         RwF8RjXkf0ULQqYOMp7k/jvyQAwoUTiFmuSmEZvGaOJcfEw7aV0i7YvkUpe3LmtgTIX0
         tswg==
X-Gm-Message-State: ANoB5pmx8PTDiKPLgaWrlEiOeArYRpvyp8outUlbcGC0UOkItDzUVhDy
        7feZL8EaVY5BrK9E5Xc4bjkZqg==
X-Google-Smtp-Source: AA0mqf5wXBdUAnvmZIvysTHRCIWUkZNsPqVOmaLbYbtInVwUKBFj2syz/R6zVfkeLETTtp1+isewQQ==
X-Received: by 2002:a05:6512:6d1:b0:4b4:91e2:7864 with SMTP id u17-20020a05651206d100b004b491e27864mr6016763lff.26.1670937219058;
        Tue, 13 Dec 2022 05:13:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 25-20020ac24839000000b004b5979f9ba8sm360705lft.210.2022.12.13.05.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 05:13:38 -0800 (PST)
Message-ID: <bca77270-f3ac-f23f-ef96-43f9f7d574c4@linaro.org>
Date:   Tue, 13 Dec 2022 14:13:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v11 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
Content-Language: en-US
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, airlied@gmail.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1670539015-11808-1-git-send-email-quic_khsieh@quicinc.com>
 <1670539015-11808-3-git-send-email-quic_khsieh@quicinc.com>
 <5a3865ed-8847-db04-3d60-f35438250bef@linaro.org>
 <5aa16223-dbf6-996c-1985-794302dcce91@quicinc.com>
 <be1411e8-1d07-7643-977c-a306016fd660@linaro.org>
 <b6d90c1f-5365-7197-be63-96c3d8cf0746@quicinc.com>
 <e53844b7-601b-f355-302b-cc871962a446@linaro.org>
 <8b306c8f-3089-4aaf-7fc1-038a8330c89a@quicinc.com>
 <CAA8EJpr5RYyQa7xu1_xJ0F-dn-H9aOf0KE-CDgDCwnZu3HPgXg@mail.gmail.com>
 <a9e2f269-b9df-814f-adcd-f5577f590fa7@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a9e2f269-b9df-814f-adcd-f5577f590fa7@quicinc.com>
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

On 13/12/2022 00:41, Abhinav Kumar wrote:
>>>
>>> besides, i think i have to sent the whole series patches include this
>>> one to address your new comments on other patch.
>>>
>>> is this correct?
>>
>> No. Please fix your system first, validate your patches and send them
>> afterwards. You can not expect others to do your job.
>>
> 
> Just finished working with kuogee on this. This issue had been reported 
> by few others earlier (example 
> https://lore.kernel.org/lkml/bc9be279-a130-d5e7-4397-bbb389d14403@intel.com/T/).

This report says:
"Sorry for the inconvenience, please ignore this false positive."

Best regards,
Krzysztof

