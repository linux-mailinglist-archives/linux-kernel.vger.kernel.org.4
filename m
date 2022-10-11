Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF3D5FB02C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJKKJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJKKJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:09:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5606B8E2;
        Tue, 11 Oct 2022 03:09:16 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 261396602343;
        Tue, 11 Oct 2022 11:09:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665482954;
        bh=yD8MLwnbAclDp4Xewj3VH7u3nJk3rGu6f0uvojTff9U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lIR3NbrWRKiboMxa7QgYSmIAwvzIcuhmHUZUOACLQL+lp2jigo9Dy3SMgBC4TLlDb
         ZT8VUMMxXsdRI8YGBJ+rVZ6w6NP6De9oCDnlosjA6Fl8wWNNzTv65b9XaWpfEuv41d
         vYqe2RIh68Xp0NBWnlUXIU8jrkY1K3jNglTUY8kuq07w5jmcr8+of8ulW9I81T3ukA
         2wSVezx42KfRxlovWL38YicXRj5IgtFIz7I8Uhhgo1oCXgFx1VLVCUQA5wpQrUR2w5
         YTJF4YTI0j/01GZVPgcLyQhNhm4fbWXxQnD81bj4n43mzhLWR4grNXWVAOkYhLMkxL
         uNtWMojfnDkbw==
Message-ID: <25e0318d-b114-5158-25c0-83453993a639@collabora.com>
Date:   Tue, 11 Oct 2022 12:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 7/7] soc: mediatek: mutex: support MT8195 VPPSYS
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
References: <20221011070356.682-1-moudy.ho@mediatek.com>
 <20221011070356.682-8-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221011070356.682-8-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/10/22 09:03, Moudy Ho ha scritto:
> From: "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
> 
> Add MT8195 VPPSYS0 and VPPSYS1 mutex info to driver data
> 
> Signed-off-by: Roy-CW.Yeh <roy-cw.yeh@mediatek.com>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

