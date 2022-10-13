Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D45FD8B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJMMAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJMMAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:00:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B71B3D599;
        Thu, 13 Oct 2022 05:00:10 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4944A6602366;
        Thu, 13 Oct 2022 13:00:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665662409;
        bh=BuP37ujugDL4eXcg1n35rpEUIKWBeXdRBR/wQ/WaBxQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WtUyd1KplznsnnNON9603d186CHop4XLxOd5D8YXPxsEERWbG1IaUI0lSnkIk53Az
         Ft5HLXPDPdgpqPDwjpmx+5X4bhZZIbWg2lbWBPlS27nqvubABGwz+q0Qf/7l2HIkJn
         3654mvVPctAEBumsx1wjIYdWTd6l79FNo7JC9VJpiwk41f0HaGQglT/VV00wOFqpZT
         SQufjN7azaGUGRiHyM5BuQ3y42Qi1lBtQl20l9QYYj7hj5zsBxjctlB99k1XjdKEUb
         smrbF3bMGJ++L/5oU8Ptv8d8NiUJj5U0VrFwCHLEDiR1LbQJc2PLYhpLRTpocmF79f
         qR7/7jNwuRALg==
Message-ID: <b074f586-2e51-4060-203f-e91f20cb57e8@collabora.com>
Date:   Thu, 13 Oct 2022 14:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/4] clk: mediatek: Export PLL operations symbols
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
 <20221013112336.15438-2-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221013112336.15438-2-johnson.wang@mediatek.com>
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
> Export PLL operations and register functions for different type
> of clock driver used.
> 
> Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

