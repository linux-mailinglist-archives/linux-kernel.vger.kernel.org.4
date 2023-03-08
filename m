Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC40F6B02AE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCHJSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCHJRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:17:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC3BB79D3;
        Wed,  8 Mar 2023 01:17:31 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 17B946602FE7;
        Wed,  8 Mar 2023 09:17:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678267050;
        bh=7CthwUYZWwI26oi5ci4iad7NhcobXUwsiHbgXRCKMaE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dd/8bSV8L/ApStx6zaCqY1vsUbxan/m6w/4ZEuSB1oWwoWucZRZhOTJ7+mR0Y8ilA
         vWo/V8x8/Rum5972/abhAnxzI6KoW06Wz7hTPoZVTJQP0zLP6xh6+Z48gFG7tazMsi
         HCM34qdTGRIPhdoItDrL4xsSsjhhZPidAO+q69u/QuIADFAjulhGDNFkqsR+Loy7nf
         oPsA5L42D9dkb0ohRuA6Net0gKCoSRFZJNBU5IRfVgZyalhdKknxxuKyVjSZE2LWWP
         JJA1gevsEt9oPW6cVuPYAK81cYkfRawWPYx6qnzMyUMi+PZTk4iurjsFPemLs/Y4Fe
         oHE7zGxBlfwKQ==
Message-ID: <5f980c7d-1bc4-cfdf-9392-70626317ca54@collabora.com>
Date:   Wed, 8 Mar 2023 10:17:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: mt8195: Add AP domain
 temperature thresholds
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230307154524.118541-1-bchihi@baylibre.com>
 <20230307154524.118541-5-bchihi@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230307154524.118541-5-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/03/23 16:45, bchihi@baylibre.com ha scritto:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Specify the targeted temperature thresholds.

You're introducing the thermal zones and *then* fixing them in this commit.
To be honest, this doesn't make a lot of sense...

Please squash this commit with
arm64: dts: mediatek: mt8195: Add AP domain thermal zones

P.S.: After squashing.. looks good.

Thanks,
Angelo

