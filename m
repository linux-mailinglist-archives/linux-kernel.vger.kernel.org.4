Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D5468E961
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjBHH4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBHH4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:56:22 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131E1F4AD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:56:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q8so12700113wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 23:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETxDvVj98k7PU9AtIH67/6OJT7NKyjfCHV6l1l+MNQQ=;
        b=JYXVjCxpNpr225kycoOKCpYUv9d7TUOsBrEU89nBfVKya6Dua1U16VPiPJ+uJfN4en
         AWSKutDat+UFJUxzYXSE8VwBtHCFQB4TTMYKrLFcfpluBgJmKU+RFFJ7UpvgtzC+iajr
         JIvfz50BvS4N8o3NNxc4LZ3Ml6IWlJqgxTn9GfkuL8Rpvz+OarEcBGjAtGa7hPh3lrit
         3Cv+S2ov7vm80nv+NmAjxTaUJ+u/lv1h5az4msh01dBrx6HDpPtavEXy9jod1UgboOdK
         LSdREKHCZFuacyIbvWoUOHSJwpvioc1k2jFMC5f/d+53erhNUTHyiAA1uZ5X2YM6tE/X
         oeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETxDvVj98k7PU9AtIH67/6OJT7NKyjfCHV6l1l+MNQQ=;
        b=40bp+nnrEmDbUlhX92TSLNo+th2zHdhxaN/s3NJ+g7k9OUoJiidey2zLXA5bZ2SaQc
         0XTtiMgzgWsPTjT/GvpTWSFPJhej57S3apxzxhY2MX5ME+etB6qV42wE9kjCZL28bTxy
         IgVFKpuk4DwLoa8JrR0lcoVrHiKgq5KqKaSJH0RzsGnkbmibe+If0bCUQOt5byHako7A
         Elc+uFcrrx0aRSqxy6AU0PJE52NdCtue+qfCCZx4XQRBkXwR0hjbe6BcP/2x78Oyrztg
         Jx8KWpDO5LIDRvmACXX9ue1Q+d5rb6g15nhabnn6o/+PHN3PEtiBiyV61YBR9FM2HRBH
         nXBg==
X-Gm-Message-State: AO0yUKV5jBW1luSLdrsW7MHltZtTj0AnOJRFp9mc433dLKNOn58LGeBp
        Mf59rtvB3EreKfmC8lvsEsxkow==
X-Google-Smtp-Source: AK7set/nmPCad66nOdzB/ATnH2t6UekYKNilUC2JCRegAFqTQjcMwBcwNJH1PAkPH6wxUnVbqd+KHg==
X-Received: by 2002:a05:600c:2e96:b0:3df:7948:886b with SMTP id p22-20020a05600c2e9600b003df7948886bmr5383344wmn.31.1675842980005;
        Tue, 07 Feb 2023 23:56:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b003dc521f336esm1062428wmo.14.2023.02.07.23.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 23:56:19 -0800 (PST)
Message-ID: <f80c617c-f595-bdc3-44d0-d29b3fff989e@linaro.org>
Date:   Wed, 8 Feb 2023 08:56:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 2/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr
 bindings optional
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230131151819.16612-1-ansuelsmth@gmail.com>
 <20230131151819.16612-2-ansuelsmth@gmail.com>
 <1670489b-e4f0-7328-3dbb-d849d1d6bd7e@linaro.org>
 <63e2e854.df0a0220.52915.56aa@mx.google.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <63e2e854.df0a0220.52915.56aa@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 01:09, Christian Marangi wrote:
> On Wed, Feb 01, 2023 at 09:20:39AM +0100, Krzysztof Kozlowski wrote:
>> On 31/01/2023 16:18, Christian Marangi wrote:
>>> The qcom-cpufreq-nvmem driver supports 2 kind of devices:
>>> - pre-cpr that doesn't have power-domains and base everything on nvmem
>>>   cells and multiple named microvolt bindings.
>>>   Doesn't need required-opp binding in the opp nodes as they are only
>>>   used for genpd based devices.
>>> - cpr-based that require power-domain in the cpu nodes and use various
>>>   source to decide the correct voltage and freq
>>>   Require required-opp binding since they need to be linked to the
>>>   related opp-level.
>>>
>>> When the schema was introduced, it was wrongly set to always require these
>>> binding but this is not the case for pre-cpr devices.
>>>
>>> Make the power-domain and the required-opp optional and set them required
>>> only for qcs404 based devices.
>>>
>>> Fixes: ec24d1d55469 ("dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema")
>>
>> Fixes go as first patches in the series.
>>
> 
> Hi,
> this is problematic. This documentation is a bit special.
> 
> v4 had this patch as first but this cause error with make
> dt_binding_check as the schema will be effectively empty (as it will
> have only if condition)
> 
> This is why I pushed v5 that swap this with the second patch and first
> add non conditional stuff to the schema and only with the second patch
> makes them conditional.
> 
> Any hint to handle this corner case? I'm having some diffiulties due to
> how special this is but we really need this fix since it's blocking the
> introduction of opp table for ipq806x and ipq807x (as the schema is
> currently flawed)

Let's then drop fixes tag, because it will only confuse any backporters.

Best regards,
Krzysztof

