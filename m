Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44F55EE341
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiI1RhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiI1RhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:37:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7380BF3937
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:37:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a8so21403004lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xPQofGed90iO+gm3rPfpn4HjMVR8sRimVhlTWHeCc8o=;
        b=YJDTaZj11PRKw0G9RVhytpLOp64mCO7gERE6JwM8Mmv5TusN8Ps62TQuNc8q8/e0nA
         SIpRFsEzFfYfPX0jXCiOo6P7c4VkjonZpSGoUV8kPgRvGuytKDO0lrdeuCGTc+yRms5H
         p8C0qDiH6hMAPcpC3lBWOyePD3y5LIVDFnA+XAtJDaA+4HdJ/szh2QZYqb8QFOMERlo7
         /TVd+Zv9HQ07/yzYg3XD5nhn5yg62ueYj1JwatnPAPSqAF43CcOV09a3w1TuhHweNOs+
         SKx0IDs7x+oCMC/sNhKH+mjSDxdOXAha462eBeTfmZAoyzwQBDh7q1FogSsURYySYuH2
         Xnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xPQofGed90iO+gm3rPfpn4HjMVR8sRimVhlTWHeCc8o=;
        b=aArqokpumCvXuIQuBc+09SVaEKifKAPxrykc1G/WyE6KfuOyxPqaHWycpIKbMiUYu8
         o0AcxxdFMRwuP9HUK/exmi2e3sZ27r9khNYAAz4b00R00UM+kScXQmzA6R0WBtvqR5mJ
         ChigTMxxUksnZPHHxjJvANN3m7vXHL0Hneol4SGgpYQtofkiEmgkHo8hIm1ItCwfTTsq
         N98jAyWwiG3/QiEXHQ4kqfKyviPIOgydKDBCG7IrcQKUsrmTb0XTsN/TlmnGlP/7RR4A
         ol0rN216MMH4oCSwxWlhtD1KJFv5rn+o8H17Y5HV4hQHoCmufY82M/++N/HO+Ye5TDlx
         SXcQ==
X-Gm-Message-State: ACrzQf1WIGQsjVXhx4gpbMmJ4Gd2MKNpiKnTx0yqk87RmjwbYek6TSm9
        FTSy2WkhIQu/xeW4fSWwbtClaQ==
X-Google-Smtp-Source: AMsMyM4W4xXxnFsat1b8Tn0zaog2Ppw8HkIxTuxgSXOtiOtUjpSMVn7XL9D//0qGXfozFiDboPWdBw==
X-Received: by 2002:ac2:5e69:0:b0:497:a698:1acc with SMTP id a9-20020ac25e69000000b00497a6981accmr14490402lfr.316.1664386620666;
        Wed, 28 Sep 2022 10:37:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z19-20020a056512371300b00497a3e2a191sm531231lfr.112.2022.09.28.10.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:36:59 -0700 (PDT)
Message-ID: <d54c7a94-f68b-b1a9-681f-d01b186de57e@linaro.org>
Date:   Wed, 28 Sep 2022 19:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 1/5] dt-bindings: mfd: qcom-spmi-pmic: Add pm6125
 compatible
Content-Language: en-US
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926190148.283805-1-marijn.suijten@somainline.org>
 <20220926190148.283805-2-marijn.suijten@somainline.org>
 <052630d0-299e-e468-b2dd-266d371e2b0f@linaro.org>
 <20220928081055.p66huqct2wnrsrdx@SoMainline.org>
 <3f2e62f5-a6e4-7011-3f5b-29a6657eae79@linaro.org>
 <20220928082340.mkn23ersrtzb5oth@SoMainline.org>
 <2bd60261-a977-3225-8d41-4987252e6abb@linaro.org>
 <20220928154437.if3x2zf5yozhy5kt@meerkat.local>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928154437.if3x2zf5yozhy5kt@meerkat.local>
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

On 28/09/2022 17:44, Konstantin Ryabitsev wrote:
> On Wed, Sep 28, 2022 at 10:30:00AM +0200, Krzysztof Kozlowski wrote:
>>> (Side-note: I should get accustomed to `b4 shazam` to automatically pick
>>>  this up from the list, instead of rebasing / re-applying local patches)
>>
>> Would be nice if b4 could update patches in current branch adding the
>> tags... but git reset --hard && b4 shazam should work as well.
> 
> FYI, it can do just that using "b4 trailers -uF [msgid]". See:
> https://b4.docs.kernel.org/en/stable-0.10.y/contributor/trailers.html


Wow, that's cool! Thanks!

Best regards,
Krzysztof

