Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6CD63D472
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiK3L1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK3L1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:27:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C938B29;
        Wed, 30 Nov 2022 03:27:35 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C8F16602B54;
        Wed, 30 Nov 2022 11:27:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669807654;
        bh=kWjNWvSSWzmMWFlVFsu7JLK0HHOMIvZT6PtRFM1iPPY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n06qiu0wTRMYK0ayVkLisLO4lHylw8YLI9bcrNnrn62e48f9rST8I0TSHWbLTBb79
         MEtMaa4S/dKv1Oc4h8BTqTV6pTbW4k4vBt5wrA8V9W23J8cjoyTMQjNeNRdIvpsXLv
         f1BMly73nthosBDqCpYoriQTE3LcN/ya5j/GV7ZWExTmvezYOeWtGbkiT6azXMtSCL
         DppGfPtR+/BWd1v8ovi5v7yjgwr9Uehf+f+U4wM0t0tmeKQ4dbAZ8Uv/K0HDxbJyVU
         4EvGYmasu3oXZEFLOyNQpZzT0Zu4DLPdQ8RHJLeORMlbz92vTpWPX+D01xXF3aRNBr
         1r7hyd09xu5Pw==
Message-ID: <d97d1fb3-3fa1-beaf-a351-3cc8ded2ca5f@collabora.com>
Date:   Wed, 30 Nov 2022 12:27:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 3/3] arm64: dts: mt8192: Add video-codec nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yunfei.dong@mediatek.com
References: <20221128143832.25584-1-allen-kh.cheng@mediatek.com>
 <20221128143832.25584-4-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221128143832.25584-4-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/11/22 15:38, Allen-KH Cheng ha scritto:
> Add video-codec lat and core nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

