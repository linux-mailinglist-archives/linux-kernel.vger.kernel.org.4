Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435EB704F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjEPNSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjEPNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:18:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C7E30E8;
        Tue, 16 May 2023 06:18:32 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E9C0766058B4;
        Tue, 16 May 2023 14:18:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684243111;
        bh=t9Kdd+ftrVf+98JRQ5scJajdzMyG4EsoKDWUzsOSgkk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aV4WHRkBVAax9gXKnxurhQbdZsJaCgGIKpXiomK1PTiEQcDAXUov7urX3I/d5UEi+
         UH79OhgDZKTd7GPWCRDvU+E1YvGTAEKX7egE8BxXhd32zhZLMESmjdB+FJjgpwXfHS
         ZZ+zuPtPF9n3T4QFYK1BdPaBvGm3R3mUwO5ViGgM9JpxjqDMKrtMWbngEj5+Pky6gm
         nv0/Fdp8rrMyTJ7CEjUpMUsHWH70+OYsdSJ6ft+QjDROFTNDG1ibaeWrIrYRzkkUEx
         d3ed0jOlbuBvjpnJ/dqxkJ2Oxkkgpl1dkB+ZX8Z6HbjlT8l4LUBqRsLCq37jW0QiVD
         CzirzyXEFG1wA==
Message-ID: <eba30975-16b5-f30f-d4a2-253f41688000@collabora.com>
Date:   Tue, 16 May 2023 15:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 4/5] arm64: dts: mediatek: mt8192: Add
 mediatek,broken-save-restore-fw to asurada
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        wenst@chromium.org, yidilin@chromium.org,
        Tinghan Shen <tinghan.shen@mediatek.com>, jwerner@chromium.org,
        Weiyi Lu <weiyi.lu@mediatek.com>, Ben Ho <Ben.Ho@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org
References: <20230515131353.v2.cover@dianders>
 <20230515131353.v2.4.Ie7e600278ffbed55a1e5a58178203787b1449b35@changeid>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230515131353.v2.4.Ie7e600278ffbed55a1e5a58178203787b1449b35@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/05/23 22:13, Douglas Anderson ha scritto:
> Firmware shipped on mt8192 Chromebooks is affected by the GICR
> save/restore issue as described by the patch ("dt-bindings:
> interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/
> broken FW"). Add the quirk property.
> 
> Fixes: 331fae2fc922 ("arm64: dts: mediatek: Introduce MT8192-based Asurada board family")
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


