Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF55F0691
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiI3Ier (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiI3Iel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:34:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A3638E;
        Fri, 30 Sep 2022 01:34:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE99D66022C7;
        Fri, 30 Sep 2022 09:34:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664526873;
        bh=9eWFbwDttTEa2f7UeZOgWcaEHQPOEJ/G5ia0l+QXprE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ie3b4ifyK44UNVbz3GwiBV3b1jgXjrIAn5at4UtYJX+nyINa1ufdrsHNDNKx+5ZqK
         Vl6AOJ2hHXoJOQBVGyRVCGovCI6hlWzolmk4atsvLHl1YK8QUsCsQZaOIPGiGPLEWM
         y1t2b9bhLFbAcUv/wCLGTFC8/lAueFFDLtzQso+drK5Hw4pyd0/Tmrj//q/wi7HKiZ
         A5t/h7fpzMx9/0vywOfTGNMw6OYEwc5Ga4cbbiYJei1jCnfNz00r+mHLRACHh/4nMM
         nEsecc7juymxqZTiD2FH/NZvk66KTyxVgO1waTesQ6vXFjD7vXTme+swciqoyH+/R5
         fxtuZpbWO4/iQ==
Message-ID: <b5443902-ce49-10df-600b-ff3112f183ff@collabora.com>
Date:   Fri, 30 Sep 2022 10:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 1/2] media: dt-bindings: mediatek: Rename child node
 names for decoder
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220929131309.18337-1-allen-kh.cheng@mediatek.com>
 <20220929131309.18337-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220929131309.18337-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/09/22 15:13, Allen-KH Cheng ha scritto:
> In order to make the names of the child nodes more generic, we rename
> "vcodec" to "video-codec" for decoder in patternProperties and example.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Many thanks for doing this, Allen.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


