Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85E72FC65
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbjFNL2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244005AbjFNL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:28:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68A11FCC;
        Wed, 14 Jun 2023 04:28:36 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA3DB6606F13;
        Wed, 14 Jun 2023 12:28:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686742115;
        bh=fkrE5Of992m10Vkun1aGB8HdC//z3kh+8lPF7Qeb2s8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OFQYsWJoTsjSpV+LtZudg2bSBOaso1iRfPsKRLkssfedpbD4gMCh5viSJyB2aq1LL
         iA6h6EuvDMjNI5rj8OAKPkYA93tdsA7pXRDZmE1rE2/Ba4yUC0NsYByRyCLHNRziQw
         CNrpDwJY1NugsfgJs4p7wpscD3lXiiKoBLmvFNonQZO3lyg/q4SakhYgeJ15I6+rVr
         eYG0IcB8Y4klpjdF3+lgx/BnWe2Ayf5Qw+TcGP6ETiX9fDbjrRPKDjkqb2E1ddjaDQ
         JuzAbYDYvSohEGyaY/uttcwFB8X/zuIeQv4KHkwAtm3KeTiDc8W7ylhjL8Q5wxnk4a
         iiafja4Qz7LzA==
Message-ID: <d2d2c421-e7e6-bd80-2a72-fa7139898cdc@collabora.com>
Date:   Wed, 14 Jun 2023 13:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 10/15] soc: mediatek: Support reset bit mapping in
 mmsys driver
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-11-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230614073125.17958-11-shawn.sung@mediatek.com>
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

Il 14/06/23 09:31, Hsiao Chien Sung ha scritto:
> - Reset ID must starts from 0 and be consecutive, but
>    the reset bits in our hardware design is not continuous,
>    some bits are left unused, we need a map to solve the problem
> - Use old style 1-to-1 mapping if .rst_tb is not defined
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


