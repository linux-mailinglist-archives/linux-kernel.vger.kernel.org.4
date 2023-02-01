Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7A3686179
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBAITu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjBAITr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:19:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997C85D132
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:19:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso730616wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 00:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvoNTnMSUBG9rGEWOXzGw8leDVKkmxXHRdw/8wBL9Pk=;
        b=X70q4EIFe04waZs3aJ9oYudxeE97R4ccQO4nlrT+6KySZJAHmydxTTYbEQ+mg0PSPK
         tE6ymg6C5SrWtA2eOnH9MIoLkKwtZ25YEH3CRAoxfEdqS2Rlxx2c/KMdkeQldRF6UT9g
         i6FlMGcNUvrVudXubJoBlQWwBM5oHPS6X+bsymzCg7OTsJBYUntR9j0qDN0sZYe+rzcK
         9WFbqiDXzUzCZKdnLWgc+3DNCuyP72ISb9kh1/r7Qt4i6pwr7SAsoFR6JO9BnD4Wb4JS
         NWSy2T1CUXCdc1dji4GHqDilbC20qIt3Gd2fYaK3SKI8W9l9BkbfVl/Rg4ZpjcxOK8bB
         vHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvoNTnMSUBG9rGEWOXzGw8leDVKkmxXHRdw/8wBL9Pk=;
        b=JpE9AGqcAKo0qpcZEHmykhs8puZOSjJKuQP0LFkkuquzxDyXivV1eksGgWXAxSw/PF
         Xu1VqyulDs/Ldnu35t7NSLIpJOmVI3pRU+OQjbK6kKMKHe6s4PMg93yd1wXN5cqL4KNP
         rrgOtP33BRSNwpK8e3BThb/ENE+qZlNnz3Y/YXp9tGT4sFLjY1nW/JITkBLnOBry1N4h
         yfCZT+DUt4Wl3Dfv8CTMx7KZ/jZOJ7iToi0wyxAD+RN6zNGmEhVgATi+ypsCTKwjPcHX
         dQYA8L9rVcs+VeorkhJ89nchQc8h4DxnIx519ayQbD/qw9Ewv1HrtBQ5CVD3hI9RJDn4
         jF+A==
X-Gm-Message-State: AO0yUKVS0Py/IDK5a8m6V1havA/URcjmmSMucwCmqLZuSpxXX7/JDZkT
        SYQq+JiMYuZn74v1VhbNx0sY3w==
X-Google-Smtp-Source: AK7set8iji9QZ9s4X+GxpH1QSjtynCBbdorxCE0bUw3yPC/dlwz0uArXguJ0sbG8mdGj7TyYbOFyaQ==
X-Received: by 2002:a05:600c:3caa:b0:3da:270b:ba6b with SMTP id bg42-20020a05600c3caa00b003da270bba6bmr1057745wmb.41.1675239585174;
        Wed, 01 Feb 2023 00:19:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003dc4050c97bsm1785889wmo.3.2023.02.01.00.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 00:19:44 -0800 (PST)
Message-ID: <44d94a1d-47d6-f93e-4a20-d9d83375398d@linaro.org>
Date:   Wed, 1 Feb 2023 09:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: specify
 supported opp tables
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230131151819.16612-1-ansuelsmth@gmail.com>
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

On 31/01/2023 16:18, Christian Marangi wrote:
> Add additional info on what opp tables the defined devices in this schema
> supports (operating-points-v2-kryo-cpu and operating-points-v2-qcom-level)
> and reference them.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v5:
> - Swap patch 1 and patch 2 to fix dt_check_warning on single
>   patch bisecting 
> Changes v4:
> - Add patch split from patch 1
> 
>  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 35 ++++++++++++++-----

This patch causes new warnings:

arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb: /: opp-table-cluster0:
Unevaluated properties are not allowed ('compatible', 'nvmem-cells',
'opp-1036800000', 'opp-1113600000', 'opp-1190400000', 'opp-1228800000',
'opp-1324800000', 'opp-1363200000', 'opp-1401600000', 'opp-1478400000',
'opp-1497600000', 'opp-1593600000', 'opp-307200000', 'opp-422400000',
'opp-480000000', 'opp-556800000', 'opp-652800000', 'opp-729600000',
'opp-844800000', 'opp-960000000', 'opp-shared' were unexpected)


Best regards,
Krzysztof

