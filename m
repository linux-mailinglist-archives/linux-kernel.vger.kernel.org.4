Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EEA652F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiLUKWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiLUKVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:21:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E20205F4;
        Wed, 21 Dec 2022 02:21:18 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E93D16602CBF;
        Wed, 21 Dec 2022 10:21:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671618077;
        bh=9XetkCTtF6ckMwoVbeLdJ6HVv33hp/u5TeeEORSL7cQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cpDtg4obq/fxFMnsFDSGSkpTsT9nXQa740njL6vVX4JoXbYkCpj2XgtRe5FIBpcH0
         UDhlMcoZoeU3UnDVEIHh4ZB8GNcI1wTorVi+zzvD9ipoe/aonF39Dl6nD5f2LkVJEJ
         JphQ6d3Tw9GVvaDnabpmMpP13vnz8VMzG4LW0wwWmBjeyI+7BReSfYS4hc6sA9HtNZ
         KOXeRODHLudlRBeCLbG56yRSl0LuSus76H57xABUDa+nS6lgsrAZo6gQLgX1yYanXP
         yzEsoYCovGOe30aI1HmhLQT+xcXizj1S1+kHqdvWWxolEgi9q8BZydTZ4i4npec6AN
         AXUZ5VmKb78tQ==
Message-ID: <8dc6fd60-4f45-c191-70ba-41e7cbf81090@collabora.com>
Date:   Wed, 21 Dec 2022 11:21:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/6] dt-bindings: power: Add MT8192 ADSP power domain
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20221221034407.19605-1-allen-kh.cheng@mediatek.com>
 <20221221034407.19605-4-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221221034407.19605-4-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/12/22 04:44, Allen-KH Cheng ha scritto:
> Add power domain ID for the ADSP power partition found on MT8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


