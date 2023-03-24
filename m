Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA126C79F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjCXIiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCXIiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:38:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BD51166F;
        Fri, 24 Mar 2023 01:38:01 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AF9CC66030AA;
        Fri, 24 Mar 2023 08:37:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679647080;
        bh=leUkIfYHsV7YSnV9uYcacAILh9PlFS9yw7oLnYyzBZk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YM36CPg3tx9GWc9j6w8ZllGxCQEngD+c15etZO4mZbNg0VZBSL+0UGXta0bloiDL+
         OONOa/97wu2hlYB93PA6FPDUnij7iz1cZkVjgmyBj1ee8yBBuyHbxUpBiG69bulGin
         9dd6v5nDtiOyzjs5szA+3AbzTZJb5pSVsdWSql0sxNHw+qeyQnUlelkhSXeWDHYKAd
         BXTT8hDlLF9gsqYiVzChYl4RnhKfrdY07RCUdE4yrqIKLx/XYsPRmxPtJmD/434GvE
         2yOw6yZYQ1IW/lvT/Bi2E49UdnfR9WNU+IX4nEpDiBGVUZnbiV1Sjplm7hmUmIgiLf
         2ljUSwxxqBguw==
Message-ID: <97a5f383-38f5-e8ea-e1d8-489b690e4521@collabora.com>
Date:   Fri, 24 Mar 2023 09:37:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v30 0/7] Add MediaTek SoC DRM (vdosys1) support for mt8195
Content-Language: en-US
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org, Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        CK Hu <ck.hu@mediatek.com>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        singo.chang@mediatek.com
References: <20230321121859.2355-1-nancy.lin@mediatek.com>
 <17831605-5c9d-9c92-d190-04f91060ace4@collabora.com>
 <CAAOTY_8ZAxVSLnJ1u5snsRgkszV7ixwhjUS2nDimE_Lpj=cUCA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAAOTY_8ZAxVSLnJ1u5snsRgkszV7ixwhjUS2nDimE_Lpj=cUCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/03/23 00:25, Chun-Kuang Hu ha scritto:
> Hi, Angelo:
> 
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> 於
> 2023年3月23日 週四 下午4:58寫道：
>>
>> Il 21/03/23 13:18, Nancy.Lin ha scritto:
>>> The hardware path of vdosys1 with DPTx output need to go through by several modules, such as, OVL_ADAPTOR and MERGE.
>>>
>>> Add DRM and these modules support by the patches below:
>>>
>>
>> I've tested v30 again on MT8173, MT8192 and MT8195 based Chromebooks.
>> Green light from me.
> 
> I'm curious about how you build code and test on Chromebooks. Do you
> build in cros environment or pure linux
> (https://archlinuxarm.org/platforms/armv8/mediatek/acer-chromebook-r13).
> I've a MT8183 based Chromebook (HP 11a) and I've tried to run a
> upstream kernel on it. cros is too heavy for me and I doubt I could
> use it. I've tried the pure linux and could boot up with console, but
> display does not work. If you use the pure linux environment, could
> you share how it works?
> 

I haven't tested MT8183 (I don't actually have any 8183 machine in my hands)... but
yes, I can share my test environment.

I have one MicroSD that I use either in the MicroSD slot of the target machine, or
in a USB reader; this *single* system is what I boot on *all* Chromebooks that I
have: one kernel, multiple devicetrees, same Debian-based userspace.

What we have to prepare this bootable media can be found at [1], but beware that
it currently uses an outdated kernel, so, what I have locally is a symlink to my
kernel tree.
You can change/add/remove the devicetree blobs that will get added to the image
by modifying `chromebook-setup.sh`; before tampering with kernel tree symlink,
please run that script for the first time, as it will download a cross-compiler,
a kernel tree (that you will replace for sure) and the (very old) Debian rootfs
that you can update with `apt-get dist-upgrade` after booting the Chromebook.

If you want to check about possible kernel configuration differences, what I use
is at [2], so that you can compare.

[1]: https://gitlab.collabora.com/google/chromebooks/-/tree/mtk-av1
[2]: 
https://gitlab.collabora.com/google/chromeos-kernel/-/blob/mt8195-tracking-master-rolling/arch/arm64/configs/defconfig

Regards,
Angelo
