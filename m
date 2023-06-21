Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08AE737D11
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjFUIGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjFUIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:06:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD02199A;
        Wed, 21 Jun 2023 01:06:05 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4DC7D6602242;
        Wed, 21 Jun 2023 09:06:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687334764;
        bh=ydVa0OJTkAFyPTmPWHYs9HFEjte8tovDBD4Np4zYHt8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Iioy2NChcdbx1E6PQ4Mpz8mw/H5jQssUOpz6/xvablYnHReF2nC+IIS469GkhNoAi
         waMUD3QSkjhtmqvRGTAQVhVPsmg41F23wy49heyaf+HjvJj2625DYTGyE7v4ZdawB1
         DLtnLYg0Fvcorj9Fo7j7PVTvjYn8slb1fL3/uZp6Vx/gHvliDAdokH2GhbW2ZeDxWe
         8jw+LRpKFWkeDT/bQXdGG7P3e3+rTYJSe0WOpNrB0ftiPUsXnED87OEPMcH9gPk2Je
         EF7KpCitzWYC2Lo/YZxDlOy4FG1aBAxXpm8C5ya/C+CibhHzpw4G8zIOh2u9T8L+/U
         eKKMxYNaj0z6Q==
Message-ID: <27242bc0-d3df-3af7-7a12-ec1f83b5f639@collabora.com>
Date:   Wed, 21 Jun 2023 10:06:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 09/14] soc: mediatek: Support reset bit mapping in
 mmsys driver
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
 <20230621031938.5884-10-shawn.sung@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230621031938.5884-10-shawn.sung@mediatek.com>
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
> - Reset ID must starts from 0 and be consecutive, but
>    the reset bits in our hardware design is not continuous,
>    some bits are left unused, we need a map to solve the problem
> - Use old style 1-to-1 mapping if .rst_tb is not defined
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


