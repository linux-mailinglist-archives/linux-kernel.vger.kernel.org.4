Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB145EDE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiI1OO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiI1OOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:14:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DF92F3A8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:14:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d42so20676017lfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OTPmRt98xA3kHqeuFiou7zsehbKe+hz1Lsg8cgktI8o=;
        b=eI5zqZ9oj34395/K1AVbL/BpEEe+nM2dwo69rVgoNqazUG1qU3VSaaNeSoXAxY1/RV
         dUN/tDClhDq1K5yFurg93Lke3olHKxUihimISCxd2KiZA8tNqBGMKy8yZmLUADVvdR9W
         +cUHxcoWH9lmcDPYNHoQrhXHqztJqdpk5hbgdzf3lCJGW2Jdkt9jF7rEX1jtBrOmIOPk
         CbDBZpYFI/rkotKemeBGyrGmg8MjKwzQtkgi0bGzn4RbDvgtDSMMCVGcSgpFeUl7IbAL
         UwrtnhCZK9nN0d+FcLnGpCCQyabMJQ9yuSsqa1uymZkP+SiEZ4Qjf+PVFcLZECTzXIzR
         z7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OTPmRt98xA3kHqeuFiou7zsehbKe+hz1Lsg8cgktI8o=;
        b=Mf1nYbGlr1KUjHgjiykWhrj3kf/wM1QziKMuvk733F2HST2ioGJX2Y5clNRM4NQyR/
         IeHp/EdT5vysMeBLT3gSXBM6efa2Ya/33nr/hb9P5gmz5FcECJw+Q0bPsuuktEo/+YNs
         4OWIRBW14R1yGHqvyVImnpN6gb8RYCym3oBG/+dmCmLfweJZcS0/RISjNwFi7Y0UAaYP
         53QjKQoHrI+MxbZIqoMsBcodEtdl5Ji2l9BvKClc1jQ8TLbHdBmQGhlSMbrlmzOrMSe1
         i2AZLmgIRco5Y1aCLdXQkorGcPZsAH9pkXg8FeRQuuYR8Jb5U4bzK+gqXoak6mxfGiRB
         xxFg==
X-Gm-Message-State: ACrzQf051mTssA6UeS0AUhGRh3N+8ZK7WCxgm4H/9pX+f/yvmJ2zHdlt
        33hq9+UueVKKC13cbhW6yn9pJw==
X-Google-Smtp-Source: AMsMyM4Rd9kNIwum5szSAw6ZmVI6A0QszE+VdTWlDnD0Ivs7fHdME9wOBCJMfDBmxqT7cAOv2/8N1w==
X-Received: by 2002:a05:6512:3e17:b0:49d:9fd5:da61 with SMTP id i23-20020a0565123e1700b0049d9fd5da61mr14295963lfv.270.1664374490428;
        Wed, 28 Sep 2022 07:14:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b00498f32ae907sm487217lfc.95.2022.09.28.07.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:14:49 -0700 (PDT)
Message-ID: <1292244e-6e7f-4402-6418-add40772f5bc@linaro.org>
Date:   Wed, 28 Sep 2022 16:14:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 0/4] arm64: dts: qcom: msm8916-samsung-j5: Use common
 device tree
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        devicetree@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Julian Ribbeck <julian.ribbeck@gmx.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220928110049.96047-1-linmengbo0689@protonmail.com>
 <20220928121717.102402-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928121717.102402-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 14:19, Lin, Meng-Bo wrote:
> v2: Reword and resend. Split common dtsi patch.
> Add missing suffix state in pinctrl.
> 
> The smartphones below are using the MSM8916 SoC,
> which are released in 2015-2016:

Thanks for the changes. Do not attach further versions to some other
threads, because it messes up with our inboxes. Each patchset is a
separate thread.

Best regards,
Krzysztof

