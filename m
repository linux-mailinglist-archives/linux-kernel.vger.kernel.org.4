Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A01698427
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBOTJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBOTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:09:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61BD32CEF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:09:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id he5so6272011wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+RZTmWd7u5WQWkzFMPa+KxElUM1QLR/4kOd49BVhns=;
        b=DzrftypQWqJ2I+cM5brMYDser82T47lkagxcYKjVPWCk0LihiDvTBh+Ar7MK2rYnA5
         LHhWe1zpICsnmKJaxuDDnIiANxsn+RGaTL9N86IL6gmmYL6LYe/PlT+XsuxxGCHau3e2
         jSCrrGv/gUqNBMpdSZ/8haX4ib5iPRDima3Ue7lXfEE/5QL9tz3YdsCDBxsGRVN/Ctrj
         UOn5ex6fIyPBy7jXhRrSMRYRulHOhKk6saiMVLrNxuVL9YobbA+jdC3CJsm8cCaJvJMB
         8zAEX7E0nxz56vnsRpZsSSA87NXq1oVVGJwQYJKf4flB+Ptdnvcx1ghuK6nzVKBKhQBL
         1qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+RZTmWd7u5WQWkzFMPa+KxElUM1QLR/4kOd49BVhns=;
        b=t1oJcH/NBPB4ALeXIjVv6DVVaUrLFpt04jeYKKdY5Jvm3JXKY6HsB1WeR1oDFQ9wbi
         3QHJ26trNivBQeXCm7R2eqN0bdd5eBefCBXakY8NpMOdeNBRvDcAwdayYZ9vZvuPq0CS
         1q+SFofnRucAX4xs8DSGeTPaylk1Ikt2K6L7Cd92Hl2+Mrs5MkSwLfnzEZuHeHps2HHm
         R3ioE6a4ZJRJ7RP1pWy3wJ6JWwTc3rxl31BRXg3j+WpVvEqsFMmSz3cxRu5ZFYOo/C4q
         12XjMYeVRDyzAeUJ1D6Id71uKjt+DOxbJs8irSjVU2wH5kd+DwcTYBZHzO9MxqIvr2hR
         52wA==
X-Gm-Message-State: AO0yUKXmfagfrnAjPXr0wim3xqWHOyuQh+3p/oiJ562VCBDtdMy5i7HN
        QKDJ0R2KP+MSbjonCMeu+Y4uXQ==
X-Google-Smtp-Source: AK7set8WrxhjECCiJgFeFpXFwJhkNfXLtyqWxPp7ZXxzdG2j+FL4rPxH4J8jcXdyPzCVUYsxIZTSBQ==
X-Received: by 2002:a05:600c:4747:b0:3dc:4042:5c21 with SMTP id w7-20020a05600c474700b003dc40425c21mr2909301wmo.6.1676488153377;
        Wed, 15 Feb 2023 11:09:13 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003e00c9888besm3286963wmo.30.2023.02.15.11.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 11:09:12 -0800 (PST)
Message-ID: <af2ee77b-a16d-d8f0-a5d5-814e1882f7db@linaro.org>
Date:   Wed, 15 Feb 2023 20:09:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: (subset) [PATCH v2 1/7] arm64: dts: qcom: ipq6018: align RPM
 G-Link node with bindings
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
 <167639581474.996065.4144950480631659648.b4-ty@kernel.org>
 <CAL_JsqLpsiermwLON5B8Z99XQMAaK36Nv_GKLvRFQQokEwKY0w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqLpsiermwLON5B8Z99XQMAaK36Nv_GKLvRFQQokEwKY0w@mail.gmail.com>
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

On 15/02/2023 15:10, Rob Herring wrote:
> On Tue, Feb 14, 2023 at 11:28 AM Bjorn Andersson <andersson@kernel.org> wrote:
>>
>> On Wed, 8 Feb 2023 11:15:39 +0100, Krzysztof Kozlowski wrote:
>>> Bindings expect (and most of DTS use) the RPM G-Link node name to be
>>> "rpm-requests".
>>>
>>>
>>
>> Applied, thanks!
>>
>> [6/7] dt-bindings: remoteproc: qcom,glink-rpm-edge: convert to DT schema
>>       commit: fdafdddf7b2f5cab8d233ef97f1fad8ec7d2e7a0
>> [7/7] dt-bindings: remoteproc: qcom,glink-edge: correct label description
>>       commit: 6f9c2f19a8743c880903a031c7f3f3c534d4b813
> 
> You need to apply patch 4 too. There's a warning in linux-next now without it.

Bjorn, can you grab patch 4 as well?

Best regards,
Krzysztof

