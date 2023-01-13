Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AB166986A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbjAMNWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbjAMNVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:21:47 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2395F93C;
        Fri, 13 Jan 2023 05:13:37 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q8so3442653wmo.5;
        Fri, 13 Jan 2023 05:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6Sfv3GzCAn5QrrBImbkAkIsyNCdyXbe2wptVAXtxE8=;
        b=mEjxQu5xNEJXSIjn7Gw/9XTq7+F4SJA697N5ndHL5HEfIF6EvBweh2FGJk4jcSqDBW
         tQOClYxi6kB9gLtETqfTr+oOURZiVexae//HuMiH1dUYZlQXkifJRHdzZlvKbYqf6FRL
         JNoCXbTQVF5kolOjAg8r+eZXD+1Y/UB/PRPt5sZxJXJmOSXRiWxIGC2GCdTr76+0hoLq
         2A0Xv6YSH19JvvfhVlrsXOz/cAzUfwOlpatMI3VNCUc0Vzh7+hFTgzuttV2VCgKQStme
         RnEYovaCkdclkTT+znCwsBNPuLxrMsmI2QRSGmvpqvPcH5bv3l6cOSFrgRXXJF1ahvUR
         /mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6Sfv3GzCAn5QrrBImbkAkIsyNCdyXbe2wptVAXtxE8=;
        b=VC/75K/QPMjVA17dUVAAMyD7D8h//odNFmuSgbRsgH6q6D9U6sBKDyoWsUO4XsD26x
         x5sk7j4+yElx7cQgrEAk7pcMmxznogEO59KN50SSTta8035UF0QnTKx8ZefxMXPINaEd
         +glE13FAUvTlbAMg9Bh+IDmoIvsCb+y1kJVPhqU+zHTCHn/VssmZLylarTinbMlGvz1I
         /qVyXAlCzpkvUbjVhFkZ3iKWsSBUu5UqyUq6OYHAhKn7INze15cnOIsGSrcJ/D/jPbW9
         1l5YjE/J4TtGCWtXJ1YQVUF7/BtmfGZ/e72ic/TD/ZTPlDccsGMEDQimHQh5KXuL92nt
         XiRw==
X-Gm-Message-State: AFqh2krG9t3/vca0GTAQJovq9EHa2tW2ehZjTTi7PAfb7i3kxGMuSZNX
        SaMy6IB+/cDx9SHdxQUQCZo=
X-Google-Smtp-Source: AMrXdXvLVIxqSzD18MgX3l3OlYJF5CvyJ3znHiB469r4ldiU7TKcm5zbYT3oyuirc1nRYXo/fO/1Iw==
X-Received: by 2002:a05:600c:3b82:b0:3cf:900c:de6b with SMTP id n2-20020a05600c3b8200b003cf900cde6bmr58678762wms.15.1673615616233;
        Fri, 13 Jan 2023 05:13:36 -0800 (PST)
Received: from [192.168.0.30] ([37.222.254.155])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c228200b003d9e00dfccfsm21796387wmf.8.2023.01.13.05.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 05:13:35 -0800 (PST)
Message-ID: <0054c6aa-da0d-ecb3-47a9-ef99caec0da3@gmail.com>
Date:   Fri, 13 Jan 2023 14:13:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 0/5] Add BananaPi R3
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106152845.88717-1-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230106152845.88717-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 2-5 applied!

Thanks!

On 06/01/2023 16:28, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This Series adds some Nodes to mt7986 devicetree and the BananaPi R3
> 
> This version is rebased on linux 6.2-rc1 and i dropped already applied
> Patches from v7.
> 
> i had run full dtbs-check but i end up with some strange warnings in
> ethernet-node that should not come up as phy-handle and sfp/managed
> properties are already defined. These errors also came up for mt7986a-rfb.
> 
> phy-handle made optional
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/mediatek,net.yaml#n265
> 
> property sfp/managed (which is included for mac subnode in yaml above):
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/ethernet-controller.yaml#n137
> 
> changes:
> v9:
> - drop model string override in sd-dtso
> 
> v8:
> - drop model string override in emmc-dtso
> - drop cs-gpios from spi-nodes
> - add interrupt-settings for mt7531 switch
> 
> v7:
> - rebase on next so dropped already applied patches
> - squashed overlay-patch into the bpi-r3 base support
> - moved regulators from mmc-dts to common dtsi
> - changed dtsi to dts (as board base dtb) and mmc-dts to overlays
> - renamed overlays to dtso
> - removed angelos RB because of changes in bpi-r3 patch
> 
> v6:
> - dropped regulators from usb-patch as suggested by chunfeng yun
> - moved 3v3 regulator to mmc-patch as it is needed for emmc to work
>    rfbs were tested by sam shih, r3 by me
> - dropped RB from AngeloGioacchino from mmc-patch due to this change
> - fixed links in coverletter which were broken in v5
> - i hope this series is sent without errors now (my mailprovider limited
>    mails last 2 times while sending part 10)
> 
> v5:
> - changed usb ranges/reg/unit-adress
> - added reviewd-by's except usb-part due to changes
> 
> v4:
> - dropped RFC prefix
> - rebase on matthias' mtk dts-next (for 6.2) branch
> - added author information to overlays
> - fixed sfp binding error
> - added fix for moving wed_pcie node
> - readded missing compatible patches
> 
> v3:
> - changed mmc pull-ups
> - added patch for board binding (sent separately before)
> - added pcie node in mt7986 (not yet again in r3)
> - added dt overlays
> 
> Frank Wunderlich (2):
>    dt-bindings: phy: mediatek,tphy: add support for mt7986
>    arm64: dts: mt7986: add Bananapi R3
> 
> Sam Shih (3):
>    arm64: dts: mt7986: add usb related device nodes
>    arm64: dts: mt7986: add mmc related device nodes
>    arm64: dts: mt7986: add pcie related device nodes
> 
>   .../bindings/phy/mediatek,tphy.yaml           |   1 +
>   arch/arm64/boot/dts/mediatek/Makefile         |   5 +
>   .../mt7986a-bananapi-bpi-r3-emmc.dtso         |  29 ++
>   .../mt7986a-bananapi-bpi-r3-nand.dtso         |  55 +++
>   .../mediatek/mt7986a-bananapi-bpi-r3-nor.dtso |  68 +++
>   .../mediatek/mt7986a-bananapi-bpi-r3-sd.dtso  |  23 +
>   .../dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 450 ++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts  | 120 +++++
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 122 +++++
>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts  |   8 +
>   10 files changed, 881 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> 
