Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A56567F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiL0HuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiL0HuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:50:18 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C3EE26
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:50:17 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bf43so18611300lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzXsYCwMTv/IXyBUyGK/jvkgx7DUqvPKPo9aKzdn+YQ=;
        b=M7q4WYjuG/Nc8kH8QWTCRMCJaioC6DMORZxU3UxY+flf61tk1lqDfCQhZ/paTlGQ9t
         nvHfhgoXjuSB2NctVns7gqs/dlG8eWLfdHnvOTkbOluSm+80iFIDRdtc8GABSzIk6sVo
         aEPF4gkkLX/JVqHb3KsOugo3W14hFwfpJMtcuMnJSelHdlUPOw4Ai6Ik8QK57febc01R
         +A5hmw7/9BGAnLOSwK4uOTux858Ttnkngu887yuAa8LkCFgGegY3eSYfC7lD3Bxdriko
         924M7HZkTgdNMjpXjW2PQLPTHx4RGmDPPclYuwCk6p3Ehffc71AZdlLkEyKXpQGs1KmH
         e/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzXsYCwMTv/IXyBUyGK/jvkgx7DUqvPKPo9aKzdn+YQ=;
        b=UkFyHKi+NjxcwaaA+VaK7rE+X2eBZfEvhDLx3RZ/Ptj/W0xmj7wxzgFvJzDoQGymYW
         DxS7O90OZ9nBbSOEcvaajapUyv77xoORC+3UGS1QB4fjdk9qUs0tnLbmxgkMrUrgVNAC
         mFN/O6yW+rmDBC+vG1PimcmjqhLkPoXoJdvyQzQcshXrukivsmYcbPyDhgQHUnHGsICu
         TrH2+1ZMuSsG9qwT2ykqJkSyTHAUD5A1vgFpe99xAFnNXh8Fp2ndI9wc2cJUUaRijrmb
         29Sf9kQ79Up61PKfG1lKAIwYPvU8+Up6vBEpfyS32D9ZuJ0RChdSMKz5AhuSQ8Jyw0b9
         r2kA==
X-Gm-Message-State: AFqh2krt6PJ0qxa/ZuuVPC9zEA4EtXNEZ6sH00oCLo1OLLS4X7ZShQ8b
        c/1xFHEJod7vDYoQKyLIBiECCg==
X-Google-Smtp-Source: AMrXdXu2X8V66vkMys4iSbPakcSEtq7XPjdJ8Z+Sz5gZDOgytIkYQE590cD1S4YJH4SRplT/hjWBUw==
X-Received: by 2002:a05:6512:2255:b0:4a4:68b8:c2ad with SMTP id i21-20020a056512225500b004a468b8c2admr6511068lfu.4.1672127415594;
        Mon, 26 Dec 2022 23:50:15 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s20-20020a195e14000000b004b0b2212315sm2160253lfb.121.2022.12.26.23.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 23:50:14 -0800 (PST)
Message-ID: <5801b0ed-282e-331f-00cf-fdce1adcda31@linaro.org>
Date:   Tue, 27 Dec 2022 08:50:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/5] Add MAX77541/MAX77540 PMIC Support
Content-Language: en-US
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221226225123.105907-1-okan.sahin@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221226225123.105907-1-okan.sahin@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/12/2022 23:51, Okan Sahin wrote:
> MFD, regulator and ADC driver and related bindings for MAX77540/MAX77541.
> The patches are requeired to be applied in sequence.
> 

I got two cover letters, with nothing attached, sent to different people
yet still both of them sent to incomplete list.

Make a RESEND or send a v3 to all necessary people, not some subset.
Properly thread your patchset so it comes as one thread, not just one
cover letter.

Best regards,
Krzysztof

