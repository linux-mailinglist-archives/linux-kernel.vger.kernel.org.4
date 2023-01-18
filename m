Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3928671B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjARMJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjARMHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:07:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D1279A5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:25:39 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so1168804wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9S8ByPT+cY6acXLQiIcdNeZj1HoatdZe/caRBhsxuvQ=;
        b=LQWSOv3YQ2h5aKJS4y8NJjzjDQiY/Fck2pr/3Gu2YJkTEVEKXF9o7PHxgFzW91V3mx
         emFkQVe0kEcO/f5nmTsfo9esCNJ9q8czxRQncOOVxyCogxufPgDTXslRu4zK3iCId6Y/
         HoxATEEYMqK8H2F2picHLhAVqGodKyvfh8k10HICSoNwLfwZO9t2AxAvmJxZR0QSarjO
         HOPxViL9D74ANNY1Xu0CtKMdF5G+UpKb9fAVKpPBXHLaB1vv4MINK/lgKezSU4wnbR6/
         fMDVXsQe/CUEEqbf7Ua5iRiOnFbLoIJgSVJP3t0rAekAYF2lft9mOF4762qSNKClKaPa
         bRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9S8ByPT+cY6acXLQiIcdNeZj1HoatdZe/caRBhsxuvQ=;
        b=qAMAaRGtwx1wc+pXcdGsxWzGX3GGXVXYpYg4gBzfr0lAQeXCdGTc79WndYvS0FLD3s
         w0qSb9nVqlPfg+f08q31xoLxWUvEdlAQ1FedoUn3VATjwP3dcz4xktm15D8cegTslyOA
         /VqVsoufUHsAN5Uk/JHVRcKuhVS5oAhvzV//eiGLtZfDOzVTvZctmr6Pj1LBgbh3kh7n
         nzCdaNRORzK6uNk9OKM2o/CLdLJR5sjMSwLckTKma2etmgq+z6Ph66j7d4cfSj5FKL+k
         QPth88qhMTp0rVOwg0h3ksvlgRyCI09tKXEPU3Eikdk80QLMumUE/VCz56ozVzkQG8ms
         11hg==
X-Gm-Message-State: AFqh2krFyWPO0hl0edCma+P9B/7VGIj0Rh9T0LVv8sVJZZy2AglJI5DH
        +RyS22WgJu3vedbuXan2xm9Plg==
X-Google-Smtp-Source: AMrXdXvHoKu8bsx3tz1pLpniDjLrdVUdOpfIyyOb9hCGG1RqYdqx09IsxRagPtPlOw41/A8sDx+tJw==
X-Received: by 2002:a05:600c:19cd:b0:3d9:922b:b148 with SMTP id u13-20020a05600c19cd00b003d9922bb148mr6527526wmq.27.1674041138553;
        Wed, 18 Jan 2023 03:25:38 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdd4e000000b002366e3f1497sm31460441wrm.6.2023.01.18.03.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 03:25:37 -0800 (PST)
Message-ID: <331eed95-eaf7-5c5a-86c1-0ee7b5591b9a@linaro.org>
Date:   Wed, 18 Jan 2023 12:25:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: qcom,wcd934x: Describe
 slim-ifc-dev
To:     Rob Herring <robh@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230113162214.117261-1-krzysztof.kozlowski@linaro.org>
 <20230113162214.117261-2-krzysztof.kozlowski@linaro.org>
 <20230117192724.GA3489389-robh@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230117192724.GA3489389-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 20:27, Rob Herring wrote:
> On Fri, Jan 13, 2023 at 05:22:13PM +0100, Krzysztof Kozlowski wrote:
>> The "slim-ifc-dev" property should not be just "true", because it allows
>> any type.
> 
> Yes, but it is common, so it should be in a common schema. Though 
> there's only one other binding using it (wcd9335.txt).

This is still wcd9335 and wcd934x specific, not really common. Maybe
next Qualcomm codec would also bring it so then we can define common
schema for the codecs. But so far I think it is not really a common
property.

Best regards,
Krzysztof

