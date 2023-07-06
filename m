Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2C474992A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjGFKPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjGFKOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:14:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570B21FFC;
        Thu,  6 Jul 2023 03:14:20 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ADA64660585C;
        Thu,  6 Jul 2023 11:14:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688638455;
        bh=teT1OjiRap+HP8iW1Gyu0lP/v4LyjAIlwMT2n0OqG7I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cbyxQ6WTKY1badRoEB1wFosnFnBlNUnVPcAW/Ug+3b9HVwuVLEO1+MIwGTzZHMlau
         siOHhUYJ/CFlxV8dr1CLwEEMX+XB/SRWHM9/jD04AaCyMRxd1A3ULaSosbZC0gtj+d
         5dpOQKYoE7fjHPIsWNKr6Isi2+RUKCO6npXO6GvCssvbjrFL+3S5FbV2yT+PAtjIkg
         5Bqm8uLNA97URsEk6ZEC8rVAK9XR6LyouDTXpW9RdplQ5xfZ+626HpHiQRniFtJIzL
         LBrjuNJPuQiUGCq8lUOa9x29i/3U2CutNjGoZ5y5Ey6JVbD7yOzE3Y6EDWF+U6GHL6
         ROznf7K+VDymQ==
Message-ID: <25d2f4ce-8c95-56ff-eb5a-9cf19532d1bc@collabora.com>
Date:   Thu, 6 Jul 2023 12:14:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2,1/2] dt-bindings: display: mediatek: dp: Add compatible
 for MediaTek MT8188
To:     Shuijing Li <shuijing.li@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230706021425.31735-1-shuijing.li@mediatek.com>
 <20230706021425.31735-2-shuijing.li@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230706021425.31735-2-shuijing.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/07/23 04:14, Shuijing Li ha scritto:
> Add dt-binding documentation of dp-tx for MediaTek MT8188 SoC.
> 
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


