Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EB263D473
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiK3L1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiK3L1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:27:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25575182;
        Wed, 30 Nov 2022 03:27:33 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 44A386602B30;
        Wed, 30 Nov 2022 11:27:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669807651;
        bh=9w7RebUsRY6IbaChOF9zwL4tdgr8VzcUyERVRfWcQ0w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i/jpibuq9rcWceRQjqfhGOY4WgPlkcDczB9Yt0n3xCNOkcRAWuqDZhNPyC2q7gi8t
         C6SyV4pwXynlM9Quy8WBDYYiNjQyhNqcUkQZvs+Ioy+EazZraoq52LyGbfNrahwf0E
         peewq8Oq5T9oqI1GVIApu6+FyJ7AcsivttderROfCFBRvHPgvgXviNpjjNSYLiUpmS
         k6v9khJJH5OVXZ9DSN3l1YeyWhKv5WoxvWEpJBX+v4/ygN3NWPKGZWS295vN8b+hbo
         ZcvGLJqGT2D/Xs37PwYw8xQIgjlug5qf/xaNVpZM0ZBQnJXRKyzPPLj8fUWjYgzIXF
         qtLMOZgsbPttQ==
Message-ID: <0f82b5d1-4fcc-4e32-c446-6b903a566b9a@collabora.com>
Date:   Wed, 30 Nov 2022 12:27:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 2/3] media: dt-bindings: media: mediatek: Remove
 "dma-ranges" property for decoder
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yunfei.dong@mediatek.com
References: <20221128143832.25584-1-allen-kh.cheng@mediatek.com>
 <20221128143832.25584-3-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221128143832.25584-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/11/22 15:38, Allen-KH Cheng ha scritto:
> Since commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
> controllers") was merge, we don't need a dma-ranges property for IOMMU
> in mediatek video codec.
> 
> We remove the dma-ranges property and fix the example in
> mediatek,vcodec-subdev-decoder.yaml
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

