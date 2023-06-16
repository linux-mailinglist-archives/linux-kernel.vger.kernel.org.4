Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5153B733CED
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345627AbjFPXdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjFPXdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:33:45 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ABE3AA2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:33:43 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b4544200dcso18065231fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686958421; x=1689550421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfePwsPEiksir752A0V39sm1MCUeFvKJlSE9qmBhmvg=;
        b=adw3al64rzfyQK3VZCZ3t1CLbjFVA7OEFI0TGi8pGpbe2F8+bZ3eIxZRgzl4CZz29m
         zC3pC3qvmKqsP5H1aIEmVQJG4j0c6mQpaFDU7QDzkc/HLrPkFPTXS0dtFHBKTJDTZ3ir
         bqb+4csLCv/0idOOI9++kqrjBHgsJ/+ZUkjsz/00gdOGfFwwLPPnw62JB6qrfK0apTKo
         +0gFpZOvX8IBFX+axjLVK4QlhRP0pzT9M32lqYfpNqi5zRG3+YP9fqepnMzoziNmZ+Mh
         CEnKIXtZCZqc+ZxIy1bxv7UJo0Rl3aH7i0lZGh6Gx6Oo8QyNrFHG/9MAWxmf3FfToSCE
         OfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686958421; x=1689550421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfePwsPEiksir752A0V39sm1MCUeFvKJlSE9qmBhmvg=;
        b=UkcdlzOuQVbb/TkoRFKFbDbYFyR9yE6R4BJXjFr40uZed425pKUdhgRkXBlqWmunW5
         ardHAyREWucyil2tIh97bSWAkSYKSsFqUSrBF/q1QY/xoE0dxOmfRoTxGfWAkgMU65z6
         9Q/zZaQoW1SuBiXWU444Diis1ODXtzi6lCpN8vkGvFCp/Lap4qzUJZUtJqMPL8Y4OVIn
         qFcTUesFaZIJDY/94j7cWO337Q/eBELhLWmRgpCJPlbKXQBUQ1FQhvMT4sGlFMF2zwK8
         zyXipm6MN3HKFAh0x14J5oPoOn/esFZZyCvnJJnmiFru3o9djZEtGEADYv3iwy6YZPSw
         bUdQ==
X-Gm-Message-State: AC+VfDzpM3yTZqnw2W7Wg5TzwWZyuR5mfKVgOV1jU07eNUtgD+jkXK17
        GwYlophNgN3qijtawuCuXZAZSQ==
X-Google-Smtp-Source: ACHHUZ4MnC8Pu7PtacLtYbKgADdswVF1x1aWXzUKnMMyGac55pcm4YFsUoJgvGykho5ay+StRH47yw==
X-Received: by 2002:a2e:9e44:0:b0:2b3:4cff:60ce with SMTP id g4-20020a2e9e44000000b002b34cff60cemr2765983ljk.0.1686958421207;
        Fri, 16 Jun 2023 16:33:41 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id g5-20020a2eb0c5000000b002b447b154a4sm1025607ljl.121.2023.06.16.16.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 16:33:40 -0700 (PDT)
Message-ID: <11c3eb6c-823d-9688-ec53-e05c7bb557c5@linaro.org>
Date:   Sat, 17 Jun 2023 01:33:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 10/11] arm64: dts: qcom: sm8350: Add Crypto Engine
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org,
        neil.armstrong@linaro.org, djakov@kernel.org, stephan@gerhold.net,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
 <20230526192210.3146896-11-bhupesh.sharma@linaro.org>
 <d239ad07-fbdd-16fa-3555-5bcf33c67059@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <d239ad07-fbdd-16fa-3555-5bcf33c67059@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.2023 19:36, Krzysztof Kozlowski wrote:
> On 26/05/2023 21:22, Bhupesh Sharma wrote:
>> Add crypto engine (CE) and CE BAM related nodes and definitions to
>> 'sm8350.dtsi'.
>>
>> Tested-by: Anders Roxell <anders.roxell@linaro.org>
>> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> Co-developed-by and Signed-off-by: Robert Foss <rfoss@kernel.org>
>> [Bhupesh: Switch to '#interconnect-cells = <2>', available since commit 4f287e31ff5f]
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
> 
> #regzbot introduced: f1040a7fe8f069d2259ab3dab9190210005ceb33
> #regzbot title: HDK8350 silently crashes early on boot
> 
> Hi, this landed in the next but unfortunately it causes silent crash
> (and reboot) of HDK8350. Reverting this commit helps.
Downstream also references the following SIDs:

iommus = <&apps_smmu 0x592 0>,
	 <&apps_smmu 0x598 0>,
	 <&apps_smmu 0x599 0>,
	 <&apps_smmu 0x59F 0>;

that might be the culprit

Konrad
> 
> Log is more or less like:
> 
> [    1.359340] Bluetooth: HCI UART driver ver 2.3
> [    1.363929] Bluetooth: HCI UART protocol H4 registered
> [    1.369243] Bluetooth: HCI UART protocol LL registered
> [    1.374639] Bluetooth: HCI UART protocol Broadcom registered
> [    1.380476] Bluetooth: HCI UART protocol QCA registered
> [    1.385868] Bluetooth: HCI UART protocol Marvell registered
> [    1.391623] usbcore: registered new interface driver btusb
> [    1.397273] ghes_edac: GHES probing device list is empty
> [    1.400305] sdhci: Secure Digital Host Controller Interface driver
> [    1.412124] sdhci: Copyright(c) Pierre Ossman
> [    1.417494] Synopsys Designware Multimedia Card Interface Driver
> [    1.424823] sdhci-pltfm: SDHCI platform and OF driver helper
> [    1.433783] ledtrig-cpu: registered to indicate activity on CPUs
> [    1.442236] usbcore: registered new interface driver usbhid
> [    1.447982] usbhid: USB HID core driver
> [    1.457065] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7
> counters available
> [    1.473760] NET: Registered PF_PACKET protocol family
> [    1.479044] 9pnet: Installing 9P2000 support
> [    1.483491] Key type dns_resolver registered
> [    1.496583] registered taskstats version 1
> [    1.500951] Loading compiled-in X.509 certificates
> [    1.519456] platform 18200000.rsc:regulators-0: Fixed dependency
> cycle(s) with /soc@0/rsc@18200000/regulators-0/smps11
> [    1.530916] platform 18200000.rsc:regulators-1: Fixed dependency
> cycle(s) with /soc@0/rsc@18200000/regulators-0/smps12
> [    1.541906] platform 18200000.rsc:regulators-1: Fixed dependency
> cycle(s) with /soc@0/rsc@18200000/regulators-1/bob
> [    1.552625] platform 18200000.rsc:regulators-1: Fixed dependency
> cycle(s) with /soc@0/rsc@18200000/regulators-1/smps1
> [    1.563730] vreg_s10b_1p8: Setting 1800000-1800000uV
> [    1.564861] vreg_s1c_1p86: Setting 1856000-1880000uV
> [    1.569411] vreg_s11b_0p95: Setting 952000-952000uV
> [    1.574304] vreg_bob: Setting 3008000-3960000uV
> [    1.576918] bam-dFormat: Log Type - Time(microsec) - Message -
> Optional Info
> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> S - QC_IMAGE_VERSION_STRING=BOOT.MXF.1.0-00637.1-LAHAINA-1
> S - IMAGE_VARIANT_STRING=SocLahainaLAA
> S - OEM_IMAGE_VERSION_STRING=crm-ubuntu77
> S - Boot Interface: UFS
> S - Secure Boot: Off
> 
> defconfig with builtin INTERCONNECT_QCOM_SM8350 and several other options.
> 
> Can it be that some dependency is missing in linux-next or Bjorn's tree?
> Shall we revert it?
> 
> Best regards,
> Krzysztof
> 
