Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FB966B0E0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 13:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjAOMLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 07:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjAOMLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 07:11:21 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B8E2733;
        Sun, 15 Jan 2023 04:11:20 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ss4so54882175ejb.11;
        Sun, 15 Jan 2023 04:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OaBjbLT8Yixt+k8nB/dptFNhIIGxHMHB0aguu9SPL7M=;
        b=VLKXZ0yiBvIzaXy2ogq+/3Azcy16L7j5WnIxQ/AMsED9Yuz61y3JhF945JIJeQJX8F
         nGOIsR9ezdOjKsR3UxAMDdIBPJGlTIRvypJqjAo0AH9vVIOfBVLz4l6d1WsMu48FE3jD
         xGo4ux3dCzfM1ETfXvXJZjmwV30B6yilbIrkNFLDWPxfiaDjer62uMXXJIHSD3rns/KR
         wB6qdiMdWrXvsBxvS7d1MXBVWpEWFN59fm53yh4F3PoIwRP11GQDR5kfHpnKePhaby4U
         YeeW49Z7BcAsYoHegVtniVwMqBIKgVXSjFsYwqBOomMYDlfETiHEX91H22tRAVwMcOFQ
         W7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaBjbLT8Yixt+k8nB/dptFNhIIGxHMHB0aguu9SPL7M=;
        b=u2mRqU6scg1vkJrAFADlk64ZXkmP0DMO86t+X4+SWi/uRt22uODpdcllm2A9eOgZN9
         vpQOM1T1appSE2jBe48GRST5DEkWUYQUwsluIkPkRnBEDpQ2MvzgwbKez78Gcr+LkOML
         CteC92Wg/soOrL6fPC1LOP6jneKs/wE4Ddmq054+QncuUlGJaChrV6+lJ5nzoWyR8s6u
         tLxklcayVuBXe/dDnb7+eAVwzWgIYypmehMkNsfR0VmUsH2+72ALuKuudxtqRqyrLZFE
         v+4J+Qi9PohzsKMNs5jOhQp2QcG4wpLmUpnmxcjtHB4QKLtB7WkYMk9UDgedzMI6Hh3g
         jo/w==
X-Gm-Message-State: AFqh2koithnMoqTGyA4lywbuiE+okSg22wf8Q1x3eN4ZYZRapm2kBPTw
        XibSnG+eyumC+eNHjozi8XrB0KyyWqMwAx/L61M=
X-Google-Smtp-Source: AMrXdXs3Rnc/QVw5omTzAyafKji3Fek/u4ImtQk7luTAvq6b4ghKF/L4DySDplW6Sg0JKw2I1e4x2TGaA9mjMjONty0=
X-Received: by 2002:a17:906:c0c6:b0:7c1:a0b:c0a2 with SMTP id
 bn6-20020a170906c0c600b007c10a0bc0a2mr6751356ejb.568.1673784679262; Sun, 15
 Jan 2023 04:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20230114162236.22615-1-johan+linaro@kernel.org>
In-Reply-To: <20230114162236.22615-1-johan+linaro@kernel.org>
From:   Daniele Palmas <dnlplm@gmail.com>
Date:   Sun, 15 Jan 2023 13:11:08 +0100
Message-ID: <CAGRyCJHcbc3kad=8ugpo+hF9TGQZv2akzrYXa175HwCM7kVb9w@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable Qualcomm PCIe modem drivers
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Johan,

Il giorno sab 14 gen 2023 alle ore 17:23 Johan Hovold
<johan+linaro@kernel.org> ha scritto:
>
> Enable the MHI PCI controller driver and MHI WWAN drivers for Qualcomm
> based PCIe modems such as the ones found on the SC8280XP Compute
> Reference Design (CRD) and Lenovo Thinkpad X13s.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>
> Bjorn,
>
> Perhaps you can take this through your tree?
>
> Johan
>
>
>  arch/arm64/configs/defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 86aa3730a8b6..117b49f3f1c1 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -250,6 +250,7 @@ CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_FW_LOADER_USER_HELPER=y
>  CONFIG_HISILICON_LPC=y
>  CONFIG_TEGRA_ACONNECT=m
> +CONFIG_MHI_BUS_PCI_GENERIC=m
>  CONFIG_ARM_SCMI_PROTOCOL=y
>  CONFIG_ARM_SCPI_PROTOCOL=y
>  CONFIG_RASPBERRYPI_FIRMWARE=y
> @@ -405,6 +406,9 @@ CONFIG_MWIFIEX_SDIO=m
>  CONFIG_MWIFIEX_PCIE=m
>  CONFIG_WL18XX=m
>  CONFIG_WLCORE_SDIO=m
> +CONFIG_WWAN=m
> +CONFIG_MHI_WWAN_CTRL=m
> +CONFIG_MHI_WWAN_MBIM=m

wondering if it could make sense to also enable CONFIG_MHI_NET, since
in mhi_pci_generic there are also modems bound to that driver and, if
not enabled, those would show just the control device, but not the
netdevice.

Regards,
Daniele

>  CONFIG_INPUT_EVDEV=y
>  CONFIG_KEYBOARD_ADC=m
>  CONFIG_KEYBOARD_GPIO=y
> --
> 2.38.2
>
