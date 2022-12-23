Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605A5654F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbiLWKRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiLWKRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:17:13 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD971BEB2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:17:11 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s25so4560636lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1u6P5JmEdjjPFnpioMwRM3NzE+xz8lzObWqbInEr8s4=;
        b=jXAsYxD559/NjQFfafcFTttoHR6Ys1BrWj+r8tOjiWjfeeK8HPAjRUhRYgVBnavd2r
         4qg7/Dwcn+2Jw1gjrwWJ8df4HhUAJW09R0FrBo/wt8ITYtQWRkffj7WZ37QiWX0zHXNB
         dYXLSiAcLkfw73tgitA4z93l6cKJTkb6JF72vKL3Rk1se6q/2/z/w3duWUIuPmMPQMmO
         evpIwuNdQ2W+91f27nPkMYUZUWRB0t912Wk9T7Il3aTJ5c6WIG5fSmbiEcwVNZ3Zqa9V
         G+u1XKjKiE2GIi6IEm2Kgx/aoHVIfg5KxcIsb5NYF8tSV7Bl9Ph68PIpmvrCBNHchbF7
         o5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1u6P5JmEdjjPFnpioMwRM3NzE+xz8lzObWqbInEr8s4=;
        b=4fKRXYAX/qrqr2tlTGigKQupA48hZmVDoQFvjTl1HsVRIHo4gSNDmRKSqlV4LxEmBJ
         2RxmtdWLuDNfeIgqm3oxtxJTysmuua2vyMBtZoOwzIUPggXV7CKV2fzl9uVlRQShZ1iq
         GocXXckGMpGCG+I/89O7yu1pHXaC6WXo9e4yHG9yNrMI/F/WybG6C9IOMYk3Ftv67M12
         spxrJr1ni5RTszAqOAVWTJa8Q8cdEDQlb9aaqCrODHCP6O2wu8UP/x0MY//7TFKBlVcq
         iT+mTQu4NsjKEl5XgkhYBRTxkk6FONWOAqfywJWW17MYGir/6O4GhMrjPHqVXxU8mpnI
         dgqQ==
X-Gm-Message-State: AFqh2koxnBUr6jc+v5q78dim00/yqJAyIGLA0Pq6OzsTvgzDfY8beUuS
        j+fNsZvIMPFMS2RnbSft3xv19g==
X-Google-Smtp-Source: AMrXdXsAL9I5ivFgD05+3G4gmxiAbxxri3dP5ysr4h1VzcC1Q6dsVmI2cXuMZ+hLJph2sh341cwtKw==
X-Received: by 2002:a2e:a376:0:b0:27b:620e:3dd with SMTP id i22-20020a2ea376000000b0027b620e03ddmr3093949ljn.13.1671790629798;
        Fri, 23 Dec 2022 02:17:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k6-20020a2ea266000000b00279e618444dsm359194ljm.122.2022.12.23.02.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 02:17:09 -0800 (PST)
Message-ID: <1f2901e3-c527-5528-9103-c722e56d046a@linaro.org>
Date:   Fri, 23 Dec 2022 11:17:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 4/5] ARM: dts: qcom: fix various wrong definition for
 kpss-gcc node
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Marc Herbert <marc.herbert@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220914142256.28775-1-ansuelsmth@gmail.com>
 <20220914142256.28775-5-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220914142256.28775-5-ansuelsmth@gmail.com>
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

On 14/09/2022 16:22, Christian Marangi wrote:
> Fix dtbs_check warning now that we have a correct kpss-gcc yaml
> schema. Add additional qcom,kpss-gcc compatible to differentiate
> devices where kpss-gcc should provide a clk and where kpss-gcc should
> just provide the registers and the syscon phandle.
> Add missing #clock-cells and remove useless clock-output-names for
> ipq806x.
> Add missing bindings for msm8960 and apq8064 kpss-gcc node.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 5 ++++-
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
>  arch/arm/boot/dts/qcom-mdm9615.dtsi | 2 +-
>  arch/arm/boot/dts/qcom-msm8660.dtsi | 2 +-
>  arch/arm/boot/dts/qcom-msm8960.dtsi | 7 +++++--
>  5 files changed, 13 insertions(+), 7 deletions(-)


warning: 1 line adds whitespace errors.
error: patch failed: arch/arm/boot/dts/qcom-apq8064.dtsi:845
error: arch/arm/boot/dts/qcom-apq8064.dtsi: patch does not apply
error: patch failed: arch/arm/boot/dts/qcom-ipq8064.dtsi:917
error: arch/arm/boot/dts/qcom-ipq8064.dtsi: patch does not apply
error: patch failed: arch/arm/boot/dts/qcom-msm8960.dtsi:63
error: arch/arm/boot/dts/qcom-msm8960.dtsi: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch


Best regards,
Krzysztof

