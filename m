Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC6B7107B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbjEYIhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240053AbjEYIhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:37:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BE11B0;
        Thu, 25 May 2023 01:36:47 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4DAD166003B2;
        Thu, 25 May 2023 09:35:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685003757;
        bh=7pF03sbG1gQpLZsg2RNInxN2LKYtcdzK6QIsJAMXv/g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=or4b+YjlguD+Ok8qKhnFHdwGckQy6NcTWyl01QRaSVz0hqajX2Uei8j6Yns//ujKW
         JtFxYL/WKar+cBspEuFGgzToY8YdeTujFWpiRseDSGoAmCHdYQHpu2W5CxXaiIvNyZ
         7/YEFPtbco30/XIbLIZNJN9ZXfbThXZcbKFKgthwLK5Md6lvBN23wyN2LhJzwFv9YN
         jSmN818wUcAIRwNi2cCtWwnvV7fc8EI3WwuyOj3b7gvcSEFLWheMaU3H6/N0VoEnYe
         VOB1s7NJN4qQZ1y70xHK8a9ySGP2liHWCvMqvTUkzsQ2/WgrPFm8ZPUW+KZ5+M4Fx2
         DSHa/Bugl1hvg==
Message-ID: <b732cc5d-f982-dff9-db4c-70bd401d5796@collabora.com>
Date:   Thu, 25 May 2023 10:35:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 1/2] dt-bindings: reset: mt8188: add thermal reset
 control bit
Content-Language: en-US
To:     Runyang Chen <runyang.chen@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20230525075011.7032-1-runyang.chen@mediatek.com>
 <20230525075011.7032-2-runyang.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230525075011.7032-2-runyang.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/05/23 09:50, Runyang Chen ha scritto:
> To support reset of infra_ao, add the index of infra_ao reset of thermal
> for MT8188.
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


