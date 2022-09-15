Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09995B98BA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiIOK1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIOK1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:27:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CCC97D44;
        Thu, 15 Sep 2022 03:27:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D14926600371;
        Thu, 15 Sep 2022 11:27:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663237668;
        bh=fAUuUgx4PgoGY4gQr2IMZ6T5dmjhyUOc5bLVNivN6Hw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F1u56N8hpZ6Wj9eJLKmb5gV7fbGagzJGPWqNq5+8fgV1a6ywMivyOUUL8W2NY9pyK
         e3j5+7TiGTtSZGTJCEfDrqaVBGUXfTESjB2sgilXKHEy5LQfw7jQIfIvBA/09nJilk
         zFMIfsL18TJhR92Gpklq8oQjvKuhPJE43GI2gV8fhoKSqSIZ9LAZrbxN/Jv/TuZDIx
         hJfIR0m6a+Ip2noRgymPu5toXMFG45nAgqmKJgeYwXXuFL0G2vEQ3OmWNplvZNYmHk
         Vy4svP4ulR0n1ydL10x6/RhoxjsObt0dd5QWPcpGthMq6OvjpDcDsKV231cjh6yABu
         PHkyc5+zKjBIA==
Message-ID: <ad21638e-f233-2bf0-ca62-72228ff04ff7@collabora.com>
Date:   Thu, 15 Sep 2022 12:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: cherry: Add edptx and dptx
 support
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220915094640.5571-1-rex-bc.chen@mediatek.com>
 <20220915094640.5571-5-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915094640.5571-5-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/22 11:46, Bo-Chen Chen ha scritto:
> In cherry projects, we use edptx as the internal display interface
> and use dptx as the external display interface. To support this, we
> need to add more properties.
> 
> - Add pinctrls for edptx and dptx.
> - Add ports for edptx and dptx.
> 
> The port connections for the internal and external display:
> dp-intf0 -> edptx -> panel
> dp-intf1 -> dptx
> 
> Because it lacks port of panel, so we keep empty remote-endpoint for
> port1@edptx.

Better wording:

The eDP TX endpoint is kept empty for now, as the panel addition will come
in a later commit.

> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

...after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


