Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877FB5BE5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiITM0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiITM0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:26:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD1175391;
        Tue, 20 Sep 2022 05:26:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D1D0D6601F6E;
        Tue, 20 Sep 2022 13:26:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663676772;
        bh=0Xo+03ki+KHlNAja6+LcklniT2jv2/zVi1do5nkFLsY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aREvFl1d38iihES0n54eMVA8YHqHT/CBMOuetK3YBw0pYnWE//RHVqwqb7jJkgGWY
         2von4x7hkslUWx9CCjlBXsuz0gD+5MSzSYNCzGLqKSzALB1ahwN5MaC4Ay2K9RUFph
         PIlMhQvuab5QlUxZQVOkKFndKcLGMVybBxzdXZ4Herlnk6+9S3JhlxDT969tnJ4EK1
         R5ES10/lmbLD70loahLuW//P0pMY3G5fM50qRfG/24CpF7oTGZ9IVPuEFyKL1r0JdE
         6a8ranT2REK8FH1R4y3vkX0I+NQYwzZHGp0nTrhH2Lmc/RuqFeSbqm9Cg4nWIArc66
         ajtfyZMUV1NxA==
Message-ID: <0e470e92-924f-a664-0ec1-b11ce76c8e77@collabora.com>
Date:   Tue, 20 Sep 2022 14:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 2/3] dt-bindings: reset: mt8188: add toprgu
 reset-controller header file
Content-Language: en-US
To:     Runyang Chen <Runyang.Chen@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220920105622.25666-1-Runyang.Chen@mediatek.com>
 <20220920105622.25666-3-Runyang.Chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220920105622.25666-3-Runyang.Chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/09/22 12:56, Runyang Chen ha scritto:
> From: Runyang Chen <runyang.chen@mediatek.com>
> 
> Add toprgu reset-controller header file for MT8188
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

