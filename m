Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E427621B72
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiKHSIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiKHSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:08:43 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFEF1C423
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:08:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p8so22289236lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ocux0pp1E+FeRNpO7DTAPUYF97MyHzA2fZ5zmFok8Rc=;
        b=TMHCOOqAcUzN3uR5F/zXXSbAwfZe7p1vuuhaYPiH66PD/EYb/Oh2mlqn3d6KwNwE2/
         3IgsCyGEJ5ZLc1iPGgvtLw3gWv9oFQEqgUsu0ElSBVMGjFoDnqGm2y+H44XZaYLvlIHw
         N+yRPAY60wiBHLRdaXnOPMG0djnnGAx50eqFQ4NQjzLIGeeM9mnFagcGIkFkbodFKppw
         wh1J4ANE9EBUtEIKl3OiLGIrXB37hhOnf9J4MG0HDH+1mtdvWcbypgCmMYClm60F8RSA
         E9LWFcJSpwncuzZUK+w3JHHDnKpnq9jw8ay5Vxqred1nXcixIBGO1M7oMWXDeayCWuPo
         jgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ocux0pp1E+FeRNpO7DTAPUYF97MyHzA2fZ5zmFok8Rc=;
        b=K6NwOTcytt0CzouOFV9gdKRfV0cjO6WDqvFsIAulMKBojqqyFdJBbsf6DLxn+SW/54
         4APmEnE8Uc0KL/MbZERgTMXXAhlxt3nf4EOKoK6Qz55fLUy9aRkWGPz9wK9FcjTSk4Y+
         +SEUPJEMb1rUfZgfu8OwSoJA48TF52TD7x2N9MyEdF63ra6eBwSSXDQZsS7DaOGir1fU
         wQwqFRSlGD6oKJIzdRQe5ucMLB2Fugwz+dTqsO1DAbl7ZTvEmGYSsHKgBxkAfKmfarKj
         sx4jS1+yeccRT8EZfn7+Mc5Q758AzLzfYdMcwzyb77K8+90mIWirHC1IzRXq49OsuF69
         DhmQ==
X-Gm-Message-State: ACrzQf3xSCGg32mT+G/krkik/k2qpe0cRR4EhJQdSzScKsCFKXiHrtdG
        mY7VyfqwixwpJsdeL/i3EbfGYQ==
X-Google-Smtp-Source: AMsMyM6DPRsbvcl+c7foHNWB2NPljcYmU4yf5sCU5gzjt2FmWq8Bl8Kr8HiQ8Xe/E0FiBDDBlaqtDw==
X-Received: by 2002:a19:7009:0:b0:4b1:11a3:789e with SMTP id h9-20020a197009000000b004b111a3789emr14342630lfc.39.1667930920698;
        Tue, 08 Nov 2022 10:08:40 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id p15-20020ac24ecf000000b0049adf925d00sm1882779lfr.1.2022.11.08.10.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:08:40 -0800 (PST)
Message-ID: <c28e0c1e-3aba-7c80-baa5-7f8925dea7c8@linaro.org>
Date:   Tue, 8 Nov 2022 19:08:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 4/4] dt-bindings: soundwire: Convert text bindings to
 DT Schema
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org
Cc:     Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
References: <1667918763-32445-1-git-send-email-quic_srivasam@quicinc.com>
 <1667918763-32445-5-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1667918763-32445-5-git-send-email-quic_srivasam@quicinc.com>
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

On 08/11/2022 15:46, Srinivasa Rao Mandadapu wrote:
> Convert soundwire text bindings to DT Schema format.
> 
> Update interrupt property items as per device tree, as it is not
> appropriately described in text file.
> Update some of the properties description with minimum and maximum range.
> Update secondary node info which is used to describe slave devices.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

