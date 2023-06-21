Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F24737D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjFUIGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjFUIGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:06:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D4219A5;
        Wed, 21 Jun 2023 01:06:27 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2EB5C6602242;
        Wed, 21 Jun 2023 09:06:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687334785;
        bh=lDaSGOcg8ns1EbtxPac3/9WFmeHFmEUq7GZ6ofeptps=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EtYfPH8tliNYlt/bpxB1dFR5TUuc37v5REV4DRMmMh2UWWrWqtbBsDnJ9y27F5xhd
         oZx3HcxWazfPZWz7ix7z/6mGmicNqLge/sM/EO/96SoBkA1aIgrAEhYNn4zVYnNMgU
         Z83pbbQiYGMuUfim6AV0LmckKogf5hrUe5d6meF4+eW9HdY66i3d94bZOB9noAvWKj
         PtgfRJQfDSAdbE6RxJae2yBzwylHyy+UAnFmQEhSmuV7eUZ2cynaLFL+PS/dKIgCii
         Vja1InN+9jI4ofRZxEzBi9f4qD3/s+STkvk9Kprn0eHvxQmyeJkQsTlKVhi/bXWW6m
         0QLVVimfVQLmQ==
Message-ID: <3b68d53e-d5a0-62d6-f32d-799470703c76@collabora.com>
Date:   Wed, 21 Jun 2023 10:06:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 10/14] soc: mediatek: Add MT8188 VDOSYS reset bit map
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230621031938.5884-1-shawn.sung@mediatek.com>
 <20230621031938.5884-11-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230621031938.5884-11-shawn.sung@mediatek.com>
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

Il 21/06/23 05:19, Hsiao Chien Sung ha scritto:
> Add MT8188 reset bit map for VDOSYS0 and VDOSYS1.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


