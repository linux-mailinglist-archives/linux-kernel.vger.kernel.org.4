Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28B5648476
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiLIPAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiLIO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:59:57 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD36C85D32
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:59:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g7so7432080lfv.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmUjgK6FRZP94VzXlEtRsOKP6XhurDo3G4diN6JCplI=;
        b=P8OnmuYZn6zJLbKrlsyvKSV9tB35MUH5ctJxAmFnSNvn0KUTWbxJdmhVBTw1BgS93i
         x770KSz59P6Uo/5f8buDoSrOejFOOoBC5waY9P/hnB+BZtwZqNlbG46/0srjzEQEZMZW
         vHiX0HTGon/Z0tgiO52+J2gSp9DhIZQGSA50DBdeCkQ0wp2MKYgk+cv6Y6iEdaMSjIDI
         eU95bFy3CO9Wjwh+XzE2+wPw9NegXtBmxw71hp9yVQpEOVkHARivNXgl+EK2YaYRSubY
         fBt6PaInWybgAgqa3YzEk3grxkTSnoi4olLnlhKbrgwjtcWloZ2kLes9mK40we0kvByZ
         c5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmUjgK6FRZP94VzXlEtRsOKP6XhurDo3G4diN6JCplI=;
        b=TYtSVKiLTjX87h6d4DNa0L2ucVxxgtaNMovMTu2CIYcCCQorbNstfqKPgD852yldy4
         CKBs9kVvoMyY3wR2gEaAwZMWED1HaiRR43sOjsE8EuYf9oaoV0kLnzP9QbId5gRKppcL
         1NDN4Zo7sAGQxm91w+tg9XEpN9FWZlTklmeGnZkIfXn79tV7Lrj0pEOI+jgM+t5KxYis
         6m2Jei69f2ccTXGHll4J2eorK6sNHHgGIsw6l6zxl4poWj30mdXK16DoYRenArx4wKGA
         qcAFNl53YPvTAEP5DHBuXMbzS+qR/+5GxrtajqYO1VpofS7fNmbRLBau5XUNfWXVXn9+
         u26g==
X-Gm-Message-State: ANoB5pnbKYNn3WaR3e3WA1Xp3WguT0d+mkV+nAct16JPzk+ZyER5XWUZ
        WC43nWT9NOMcD+lzTvv/3OW9Dg==
X-Google-Smtp-Source: AA0mqf6EqdK2TYO+O/G2pbCffiYehV+tErEFWtMasQhx6QhqtEcO7WPCkUlL0TWrsKOSCnZJv+emBA==
X-Received: by 2002:a05:6512:ba0:b0:4b1:44a4:a717 with SMTP id b32-20020a0565120ba000b004b144a4a717mr2003791lfv.61.1670597971148;
        Fri, 09 Dec 2022 06:59:31 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512348c00b004b5b4126237sm154851lfr.67.2022.12.09.06.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 06:59:30 -0800 (PST)
Message-ID: <0fb1b2e4-6e07-f976-0103-d04d89677576@linaro.org>
Date:   Fri, 9 Dec 2022 15:59:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v11 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
Content-Language: en-US
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        airlied@gmail.com
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1670539015-11808-1-git-send-email-quic_khsieh@quicinc.com>
 <1670539015-11808-3-git-send-email-quic_khsieh@quicinc.com>
 <5a3865ed-8847-db04-3d60-f35438250bef@linaro.org>
 <5aa16223-dbf6-996c-1985-794302dcce91@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5aa16223-dbf6-996c-1985-794302dcce91@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 09/12/2022 00:38, Kuogee Hsieh wrote:
> 
> On 12/8/2022 3:33 PM, Dmitry Baryshkov wrote:
>> On 09/12/2022 00:36, Kuogee Hsieh wrote:
>>> Add both data-lanes and link-frequencies property into endpoint
>>>
>>> Changes in v7:
>>> -- split yaml out of dtsi patch
>>> -- link-frequencies from link rate to symbol rate
>>> -- deprecation of old data-lanes property
>>>
>>> Changes in v8:
>>> -- correct Bjorn mail address to kernel.org
>>>
>>> Changes in v10:
>>> -- add menu item to data-lanes and link-frequecnis
>>>
>>> Changes in v11:
>>> -- add endpoint property at port@1
>>>
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>`
>>
>> Applying: dt-bindings: msm/dp: add data-lanes and link-frequencies 
>> property
>> .git/rebase-apply/patch:47: trailing whitespace.
>>
>> .git/rebase-apply/patch:51: trailing whitespace.
>>
>>
>> Also the dt_binding_check fails with an error for this schema. And 
>> after fixing the error in the schema I faced an example validation 
>> error. Did you check that the schema is correct and that the example 
>> validates against the schema?
> 
> yes, but i run "make dt_binding_check 
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/msm/dp-controller.yaml" 
> at mu v5.15 branch since

v5.15 branch is not correct branch to work on a kernel. Please do not
send patches based on this. You must work on mainline, maintainer's next
branch or linux-next.

> 
> "make dt_binding_check" does not work at msm-next branch.

Why would it not work there? I doubt that msm-next broke anything...


Best regards,
Krzysztof

