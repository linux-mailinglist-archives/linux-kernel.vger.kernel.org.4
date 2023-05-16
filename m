Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F51704F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjEPNSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjEPNSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:18:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0611BCA;
        Tue, 16 May 2023 06:18:31 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D148866056FF;
        Tue, 16 May 2023 14:18:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684243109;
        bh=w/ACPYPClgMV0n2ZBBqGv3rjEfAKIsaw1K9m6yZKhI0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RFwSTdSD+UP3b6jxWCclnczShVZiBWC1Tz+rVhwxwA++3/UBVpw9CIQzWpDqo8DK0
         bRfm7TI99Rl1byR+OS7ut3GvePajjPr+NJoQOqdR8b7D33Bi0dRkpFdXst1nHkL0gI
         6YpzJc+dcrUgriTex6wod48HXH2039oqfaXO1cg17kfSOcFCn6KrQgaQrF/Qvw1Rfm
         OgUxEXEmR1GCPRFSmAJVlc3QHC6BntWJQvLxiEw2aPyrTKkKP0d2MFwEmbpSDQPMPe
         V9Av5w4SlTFoM19iaBSxxkKEiRrnVc781rTndS/1KKUK5zuI3S0Y47BM1CH20+gokT
         vJQGzjgy4Dy5g==
Message-ID: <863513c4-c772-6083-b5af-e80c10a9173b@collabora.com>
Date:   Tue, 16 May 2023 15:18:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 5/5] arm64: dts: mediatek: mt8195: Add
 mediatek,broken-save-restore-fw to cherry
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
        linux-kernel@vger.kernel.org
References: <20230515131353.v2.cover@dianders>
 <20230515131353.v2.5.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230515131353.v2.5.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
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
> Firmware shipped on mt8195 Chromebooks is affected by the GICR
> save/restore issue as described by the patch ("dt-bindings:
> interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/
> broken FW"). Add the quirk property.
> 
> Fixes: 5eb2e303ec6b ("arm64: dts: mediatek: Introduce MT8195 Cherry platform's Tomato")
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


