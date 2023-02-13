Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA176942D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjBMK1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjBMK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:26:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF0810246
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:26:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m10so2689678wrn.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCtRivtyLD5PL89Zh2EBT2LOrAr6GvapiKcy2GIcX+8=;
        b=lr5nbhCUF4uM3OlE9eggIUcvgxQghlKll+E9g9u7tk/uMN0ukMGttHx3aOVrnCAXao
         /mFLUlg/ihbBnyMt1prkAJXPyAe1jZnWyspdjM6yY0aQYvZXy9KNBDbJRAtYz3dVY1r9
         qbIQURT4qUmEtGliMQ8qtmk4UTW81YGfEBBceBWLOjm9EwJM6XmlrWzdh06piCVnQZ4B
         l5ujKz6kIdgLmjW+nVVM74QAGrzf6hbre1gQrjJV4SFokNORB9EvKorWwXvuE9dr4ozL
         2OZJEdKPWaje6F02WNO0NbOu5sflsAzmOYFOt2Vn8YdQZsk3L0OxyktTj0UrQHwYYSGZ
         lfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCtRivtyLD5PL89Zh2EBT2LOrAr6GvapiKcy2GIcX+8=;
        b=mUO4elX2lIyCe5vwiSILrKcmBgk8iSfAJWyrwfXYxz5w/JwVggNUul6jcqOF9gtnfd
         WKFGWSyXWWpH796Gk0nTGchUKe7HYFNVCzMGE5TN/g4pUvJs+DwTS5dY7Zkg1i+SekDH
         G0l+e5Pv+tk/fE6S8R2J5oMdkdvPFMgEZPq8HoS6TUyM5Ocogfjtvj6suLjHOfdzyrf9
         FCpJibmhtvl34OA8p1AT66fWBJjPyNMbu0T/wXf0m928ikzogM9hJXDQ19miMt7bFmc9
         EGzSygIbfaDFXFe0a1Q/0jzPLcZboCGjhc5901F9P4Wdwp7eAfmjWxtyvxAeP2QXIS6Q
         pfbQ==
X-Gm-Message-State: AO0yUKXpRuQ+MsKHZNTLY2Yd1YSbX0Iwj6NBm66RpWReRxhayUZik2Yw
        V73htPOYgRn6wkEazSgI0tFq4Q==
X-Google-Smtp-Source: AK7set/vbpzeaopemh/cNf3rjPOvlWuviif+jwmrf6PmQTqSGMHrUDhv413WMAiTcJ9clAdTEURR4g==
X-Received: by 2002:adf:e852:0:b0:2c5:4680:7d17 with SMTP id d18-20020adfe852000000b002c546807d17mr9047826wrn.17.1676284014798;
        Mon, 13 Feb 2023 02:26:54 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q14-20020a5d574e000000b002bfb02153d1sm10241248wrw.45.2023.02.13.02.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:26:54 -0800 (PST)
Message-ID: <1f387cb5-2ed7-5001-d846-d059499b1347@linaro.org>
Date:   Mon, 13 Feb 2023 11:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 2/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr
 bindings optional
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230208153913.24436-1-ansuelsmth@gmail.com>
 <20230208153913.24436-2-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208153913.24436-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 16:39, Christian Marangi wrote:
> The qcom-cpufreq-nvmem driver supports 2 kind of devices:
> - pre-cpr that doesn't have power-domains and base everything on nvmem
>   cells and multiple named microvolt bindings.
>   Doesn't need required-opp binding in the opp nodes as they are only
>   used for genpd based devices.
> - cpr-based that require power-domain in the cpu nodes and use various
>   source to decide the correct voltage and freq
>   Require required-opp binding since they need to be linked to the
>   related opp-level.
> 
> When the schema was introduced, it was wrongly set to always require these
> binding but this is not the case for pre-cpr devices.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

