Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0650E5B98B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIOKYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIOKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:24:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC56C140B3;
        Thu, 15 Sep 2022 03:24:46 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E17EE660159F;
        Thu, 15 Sep 2022 11:24:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663237484;
        bh=HDcKpztFgW4JjS7pab1Fzd5dwgcS0z5gxyoB+VISHjw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JM8xNPPxNw7LgMzRh3TcUWEAOGC+nccV0z1x4jFgZ8hBwoIpXJO1xRs7SJo1QzhuM
         9EJA85oqEFa4oVlfJZweqzQGaio31p4HUMy10rCu47eI4eWZ0KLXQEAk95tEwlbgya
         RESktb4WCjU4OiWJySpK5fhvBJ74VjyU6SP0tula13tHSbpv0iiWlkOwx9DoAVd7Cf
         VMjKlF4f4J8ata/B9yN7FnGUPUnoI0dAaVzmbaegZUdbzM2eXG1nFLM+GgTMqcG/1L
         lvM8lT87LOCaEX31uCETUtJue33yBEnpiGrlQNCm0u24xbFvueyDiKR9kefcIqyEdb
         j8VUXPDk287Ew==
Message-ID: <d644bdfe-2b9f-97a6-ae77-088983a42fe2@collabora.com>
Date:   Thu, 15 Sep 2022 12:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/4] arm64: dts: mt8195: Add dp-intf nodes
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220915094640.5571-1-rex-bc.chen@mediatek.com>
 <20220915094640.5571-2-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915094640.5571-2-rex-bc.chen@mediatek.com>
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
> Dp-intfs provide the pixel data to edptx and dptx. To support edptx
> and dptx, we need to add dp-intf0 and dp-intf1 nodes.
> 
> Dp-intf0 is for edptx and dp-intf1 is for dptx.
> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


