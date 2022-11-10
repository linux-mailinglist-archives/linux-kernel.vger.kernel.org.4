Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD991623E30
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiKJJBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiKJJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:01:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB1B1DB;
        Thu, 10 Nov 2022 01:01:08 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 863E7660296E;
        Thu, 10 Nov 2022 09:01:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668070866;
        bh=V3LxIHxrigauZUZ1sN9cfEsRLLqICxP6H8hCpXI+0S8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aOQPCbm9zRqrdI5uRlt2A1HHmDuFG1r7ITm3kIr2EVw1xgIwT4cMuO+czifU7qSLB
         orFCzor+dFH2YcfclZxAXJZbiEShr6lRb0KtrXpYrcAiYSrM8QqHTLvqJTmNj+NeUz
         ArhfcwqZeEdIOuGzv3zVtvV8vZve9PBzl9yyLvkTJ0fcGkeSwgmMsOSz1DLzQv9gb5
         IzP/xXjdB5RNVzyuci49a3zNEqrCLTYDJoZ3t5uTGAQfevfv9F+bLToky8BgAXd5Lh
         y0hkXM2rcTPVSR4Mwk0SxcoBsbED4XLdwRJd++VOpq/gyFNEq2sjTsTBLxAqdgrgfi
         yRU1WE/eJHctg==
Message-ID: <0fc25cbd-6a4c-18e3-510e-a9cb1d394915@collabora.com>
Date:   Thu, 10 Nov 2022 10:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] spi: mediatek: Fix DEVAPC Violation at KO Remove
Content-Language: en-US
To:     Zhichao Liu <zhichao.liu@mediatek.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com
References: <20221110072839.30961-1-zhichao.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221110072839.30961-1-zhichao.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/11/22 08:28, Zhichao Liu ha scritto:
> A DEVAPC violation occurs when removing the module
> due to accessing HW registers without base clock.
> To fix this bug, the correct method is:
> 1. Call the runtime resume function to enable the
>     clock;
> 2. Operate the registers to reset the HW;
> 3. Turn off the clocks and disable the device
>     RPM mechanism.
> 
> Signed-off-by: Zhichao Liu <zhichao.liu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


