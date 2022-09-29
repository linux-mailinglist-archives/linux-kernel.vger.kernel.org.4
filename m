Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D745EF05C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiI2I0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiI2IZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:25:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3286A1C910
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:25:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C9616601EB5;
        Thu, 29 Sep 2022 09:25:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664439945;
        bh=M1ejyyP+F3UGL2mKEn6fPWzn52mMqLU2pFQdANC8c9I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RBQ2tdGaxwIAK9hUNmD+6qiTOiD3gQdIYWg53c6P1UmvLC2NVa8CPsY6p1TbEvcVJ
         FoHH02MzyWxHIrnyAYeN9+k6IKAvByYr8kMVcfHgtdxEJgh1AYNTAgqi3GSdgpR+7y
         rDAGrl675e7IxANVI6n1IwHaCtjPF9Mx8AvL4ZaZqBSziAB1QscDHM4GD65PZG0mAF
         arSyqMDLJM4yiACesy86i4+FgCkM52TlMCHeWwgL0BJcImDbJUyekCgAj3a1P+VOZa
         Q3uvGb0qopKHEbKusoZ5jppl1IuBjqEorVcwHkXY7Wh1txe4b1uU+sxvyrPwNZQIaY
         PhbTwZoaVJpvw==
Message-ID: <c6a9a22e-87fe-6426-b028-3937de206037@collabora.com>
Date:   Thu, 29 Sep 2022 10:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 4/8] soc: mediatek: mtk-svs: delete superfluous platform
 data entries
Content-Language: en-US
To:     matthias.bgg@kernel.org, roger.lu@mediatek.com,
        jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
 <20220928155519.31977-5-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220928155519.31977-5-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/09/22 17:55, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> The platform name and efuse parsing function pointer are only used while
> probing the device. Use them from the svs_platform_data struct instead.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


