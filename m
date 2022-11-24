Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EC2637653
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiKXK0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXK0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:26:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E1325D7;
        Thu, 24 Nov 2022 02:26:41 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D8B76602B19;
        Thu, 24 Nov 2022 10:26:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669285600;
        bh=PChGdOWAoNKksgA8NZOc4zxK48bZvzgVM9A/WgO63hk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m50AbPXuJ29d0RegtXzvcO+KHByBGglehrVS3d3Q9bQmWIU2LIg+mU01nnmNTfycn
         wxAOvjuMo9nRDkZtCmHd70nsQu8mKVqoYw1EBGT9Xc60F754tQNj8ocXpQ+lIbxrep
         0fkgLDhTbxRpxHlS1GERfUJfjjgcOWXPOrjmzdx/9Pqm8f5+vOjODOpJqgq71/Yu9l
         XVV2iDLzwPhggvn9hbZlx0JoUCAa7VDImXniHl3+Y6EHu8rTIHovX92i9ZSuw24VPa
         UqxV/8gdZH6vlIsPl60p7R2uWA5JYSdsTQVCwkR2bjpwhItc4oUbTDGWDWXllTDCzY
         QEgLom6SAXaVA==
Message-ID: <7e864137-1427-f66d-8ea2-a54bff358903@collabora.com>
Date:   Thu, 24 Nov 2022 11:26:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 1/2] dt-bindings: gce: add gce header file for mt8188
Content-Language: en-US
To:     "Elvis.Wang" <Elvis.Wang@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221124075516.1669-1-Elvis.Wang@mediatek.com>
 <20221124075516.1669-2-Elvis.Wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221124075516.1669-2-Elvis.Wang@mediatek.com>
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

Il 24/11/22 08:55, Elvis.Wang ha scritto:
> From: Elvis Wang <Elvis.Wang@mediatek.com>
> 
> add gce header file to define the gce thread priority, gce subsys id,
> event and constant for mt8188.
> 
> Signed-off-by: Elvis Wang <Elvis.Wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


