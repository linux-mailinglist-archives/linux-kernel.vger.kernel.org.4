Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554D25FD8AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJMMAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJMMAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:00:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0602D1F2D7;
        Thu, 13 Oct 2022 05:00:08 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A0686602365;
        Thu, 13 Oct 2022 13:00:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665662406;
        bh=8i7vdv//BJKK0S1wRFfGIN/8B9XDWEMWI/LVdDLpwDA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U+mzLfjraQ/CX+Hn/X//dazUYZlz8ll7EN+npmpTR1JCftljrqhIwr0zsQHoPl/k7
         ycNI8mSwZ7d1ypgkB8CggoSAbj6d7eP1lIWfycnCuenzANzhzcRt0EjbXcfr02nFNi
         K215KnAtGMt4oyfp4MG0auMebqPWX90ek5+czVWOucJeE8Af+J9X24cpE+t40uqT2e
         cYufECGaWF3I69R/4uTx0W5WGh1XeksxScyTsKcBxJRECjRi+3A7s77TQJkh/mg0gm
         pA7+k+2qy0kNckETpDm1GSgOGc1BvXC1pBosZVVG6WOHKB9qwBQeFNvyifRNg8k0tP
         DhaONbSKsFHig==
Message-ID: <98d2ac4b-5b87-d22f-8929-4392b43d51a8@collabora.com>
Date:   Thu, 13 Oct 2022 14:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 4/4] clk: mediatek: Change PLL register API for MT8186
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        kuan-hsin.lee@mediatek.com, yu-chang.wang@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
References: <20221013112336.15438-1-johnson.wang@mediatek.com>
 <20221013112336.15438-5-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221013112336.15438-5-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/10/22 13:23, Johnson Wang ha scritto:
> Use mtk_clk_register_pllfhs() to enhance frequency hopping and
> spread spectrum clocking control for MT8186.
> 
> Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


