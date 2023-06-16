Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6A2733786
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjFPRg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjFPRgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:36:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630E226A1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 10:36:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5187aa18410so1206874a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686936970; x=1689528970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HD+KUO8gGiub5XefT2UWijfTQbimFI/ieVQFXgYHnZ4=;
        b=NIELEaa4KLYPRap52X2bgsqLdJTLqA6KJIkQNUGj9ZlBpvwqH8/JGsYETTRHTWyzmy
         cHcIKmsuMllSrpCdEAx/XyQeUDh2346XIMfy6z71kV/RN6FdHadMDEqnJ63isKkkv5x5
         2gr4zCiQXyE9jzzCn2FfoVtv6wpTbJz2bQdUcEo8O4wDofRpNAuSdH8c5qP94/prQyJC
         Zp5qSJfcTG7nPVY2n7LkPgcpQ8ifJ97fr498Muz80xnk1C8g2wA1Gx2KLrXogp2Oa5HB
         4LjOo2F6WONKvqqWO56L8XY0UR+5hdbxwDiQIltlbkB4/Cwn8kwc4bqYV1rVPEggtuGY
         HXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686936970; x=1689528970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HD+KUO8gGiub5XefT2UWijfTQbimFI/ieVQFXgYHnZ4=;
        b=eSVQQ5tGs0xFCXR531i3OrjbIqOUn4hgnwJJvM0z7nCLz3uD9Y3IZRIvKmigFU21Ks
         3FKCOraD4nwU416mSl6bXOQYTYS44vBPdrA8HWr+IYHhekBD2s7+9VCiuEsy+Ln1wlbD
         e/JJ8TmWfafO/wHj218FHuPCy21fKBTM5tKGfYGZXkWtHZylw3mXfYwPFvFX+LQCxRHv
         PTcMibIltw9lUazlytM9tj3oBhlNRbctTH5SwuN9KerGCoV1gY80Vr12U7b8nHiXe9Dl
         4SIv397P5OakPWLm2TuGIFjoEu8TSF+t/bZmbQnv/HoihCbmBXFivY7A6LqjFJoWYrlB
         L+ng==
X-Gm-Message-State: AC+VfDwELPp7MBa9BeZyrFCmdAZdJjDKxzofrcVe3mH29TgvBNC4vbEy
        DoVkAncPtti+vHN0bJ+Es+bOkg==
X-Google-Smtp-Source: ACHHUZ7jQk/KIU+7R23RqyFTBEqCKwkT4bdNIjjTOmICI0KKAp5gNEFBVUctXvBtIoqNiZWl1MwoEQ==
X-Received: by 2002:a17:907:7255:b0:987:1d27:61e4 with SMTP id ds21-20020a170907725500b009871d2761e4mr190425ejc.26.1686936969862;
        Fri, 16 Jun 2023 10:36:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k19-20020a170906129300b0097381fe7aaasm10959445ejb.180.2023.06.16.10.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 10:36:09 -0700 (PDT)
Message-ID: <d239ad07-fbdd-16fa-3555-5bcf33c67059@linaro.org>
Date:   Fri, 16 Jun 2023 19:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 10/11] arm64: dts: qcom: sm8350: Add Crypto Engine
 support
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
 <20230526192210.3146896-11-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230526192210.3146896-11-bhupesh.sharma@linaro.org>
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

On 26/05/2023 21:22, Bhupesh Sharma wrote:
> Add crypto engine (CE) and CE BAM related nodes and definitions to
> 'sm8350.dtsi'.
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Co-developed-by and Signed-off-by: Robert Foss <rfoss@kernel.org>
> [Bhupesh: Switch to '#interconnect-cells = <2>', available since commit 4f287e31ff5f]
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---

#regzbot introduced: f1040a7fe8f069d2259ab3dab9190210005ceb33
#regzbot title: HDK8350 silently crashes early on boot

Hi, this landed in the next but unfortunately it causes silent crash
(and reboot) of HDK8350. Reverting this commit helps.

Log is more or less like:

[    1.359340] Bluetooth: HCI UART driver ver 2.3
[    1.363929] Bluetooth: HCI UART protocol H4 registered
[    1.369243] Bluetooth: HCI UART protocol LL registered
[    1.374639] Bluetooth: HCI UART protocol Broadcom registered
[    1.380476] Bluetooth: HCI UART protocol QCA registered
[    1.385868] Bluetooth: HCI UART protocol Marvell registered
[    1.391623] usbcore: registered new interface driver btusb
[    1.397273] ghes_edac: GHES probing device list is empty
[    1.400305] sdhci: Secure Digital Host Controller Interface driver
[    1.412124] sdhci: Copyright(c) Pierre Ossman
[    1.417494] Synopsys Designware Multimedia Card Interface Driver
[    1.424823] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.433783] ledtrig-cpu: registered to indicate activity on CPUs
[    1.442236] usbcore: registered new interface driver usbhid
[    1.447982] usbhid: USB HID core driver
[    1.457065] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7
counters available
[    1.473760] NET: Registered PF_PACKET protocol family
[    1.479044] 9pnet: Installing 9P2000 support
[    1.483491] Key type dns_resolver registered
[    1.496583] registered taskstats version 1
[    1.500951] Loading compiled-in X.509 certificates
[    1.519456] platform 18200000.rsc:regulators-0: Fixed dependency
cycle(s) with /soc@0/rsc@18200000/regulators-0/smps11
[    1.530916] platform 18200000.rsc:regulators-1: Fixed dependency
cycle(s) with /soc@0/rsc@18200000/regulators-0/smps12
[    1.541906] platform 18200000.rsc:regulators-1: Fixed dependency
cycle(s) with /soc@0/rsc@18200000/regulators-1/bob
[    1.552625] platform 18200000.rsc:regulators-1: Fixed dependency
cycle(s) with /soc@0/rsc@18200000/regulators-1/smps1
[    1.563730] vreg_s10b_1p8: Setting 1800000-1800000uV
[    1.564861] vreg_s1c_1p86: Setting 1856000-1880000uV
[    1.569411] vreg_s11b_0p95: Setting 952000-952000uV
[    1.574304] vreg_bob: Setting 3008000-3960000uV
[    1.576918] bam-dFormat: Log Type - Time(microsec) - Message -
Optional Info
Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
S - QC_IMAGE_VERSION_STRING=BOOT.MXF.1.0-00637.1-LAHAINA-1
S - IMAGE_VARIANT_STRING=SocLahainaLAA
S - OEM_IMAGE_VERSION_STRING=crm-ubuntu77
S - Boot Interface: UFS
S - Secure Boot: Off

defconfig with builtin INTERCONNECT_QCOM_SM8350 and several other options.

Can it be that some dependency is missing in linux-next or Bjorn's tree?
Shall we revert it?

Best regards,
Krzysztof

