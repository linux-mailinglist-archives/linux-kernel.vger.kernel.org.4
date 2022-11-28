Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4380363B441
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiK1Vak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiK1Vah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:30:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B87F29832
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:30:36 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p8so19473760lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpNzOzzeSzSz5Lpt0YOVKX6gNs5WRFH8qIASGutCJEo=;
        b=t9F15Xgsl5stkVjhc6GgEi+mHn9pN/VUTaXPtnHu38nBPDpCnmjT5+PVQ1rIMSNSWG
         AxW0luCdVxThuxMYiUEZP3tCnXLbrdNRi1CjuShAKu4EPWkqOXjNKMkEBa+KWlCkyDXo
         EMrMt+VkFt2E+Jdpj+i9o9SCfFZHIScI6T7ttZLJ9sKPgUxPDpGgzOQmBdBSyuiSkSSj
         iqd6zA/RWkPkaZtR0EU1sMBBK+bswgHfv1NIhAWWFbU8Mrz6lTtVHTv4j6cyds/GthyO
         mSdyiucoSAQhbXRHUXk5uGvD4d/G/6hYMWYNBTTae+bO8eURrdTYfqWx/iJ31nsJA3gr
         RWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpNzOzzeSzSz5Lpt0YOVKX6gNs5WRFH8qIASGutCJEo=;
        b=X+PStJ5bSncN4rQpIriv3HmmJPrf3kiYauQTO7mGp4pLRB92ibXUXdvcJfRRnb0y0T
         mqNTbD/cHwKYvvczCueKJqaOevfH9GF3eBOzvBlEmK6fSSRCidbm7wuILWH8Lai+9fil
         bxJhj45ZNfnnjBcZkBLIbCCVSi7q9hcotYVvp3bS707f5dGnN3JE4cpdv6r254RRxsqX
         kSn6Pz2K1662FnMre/P46Xifvs6RmzBjzPVVEyfYxYeQDNDO6pNdPZJt8NpzjL2DUoLY
         a+qKvblsIeN6RY4nvmMB6AJBrxGvaFWvFamRsPucwY/g92NmObMO+ye4yEZ7peT/ONRS
         33TQ==
X-Gm-Message-State: ANoB5pnlBb53e19WGvtCHn6dGDrjOMPVV8QW4XAQRDiAAkhDxLhaJwMA
        oiHJ1O1iDMjzLR8i+lOt/rN2gA==
X-Google-Smtp-Source: AA0mqf4/PvECqdGjn5wrGV+kPTAeoMIK5FcQS0ssPQfJNl9ppl0/rWupE6rv6toiU91tCEx9wF8H3w==
X-Received: by 2002:a19:ca1b:0:b0:4a7:7d62:2807 with SMTP id a27-20020a19ca1b000000b004a77d622807mr20621721lfg.77.1669671034576;
        Mon, 28 Nov 2022 13:30:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z2-20020a056512370200b004b4a0482a53sm1871576lfr.231.2022.11.28.13.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 13:30:34 -0800 (PST)
Message-ID: <b24e9763-23e9-0d23-b22e-5806a1406782@linaro.org>
Date:   Mon, 28 Nov 2022 22:30:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-wingtech-wt88047: Add flash LED
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221128051512.125148-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128051512.125148-1-linmengbo0689@protonmail.com>
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

On 28/11/2022 06:16, Lin, Meng-Bo wrote:
> WT88047 uses OCP 8110 Flash LED driver. Add it to the device tree.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

