Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1B06960B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjBNK0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjBNK0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:26:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0188023DB7;
        Tue, 14 Feb 2023 02:26:47 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C89E6600013;
        Tue, 14 Feb 2023 10:26:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676370405;
        bh=XwDKmNn28mBHiDmFHlKFhPUeK5/LAwt06zJ6rA1eP/o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kUhQXF5idxG7uO8tqNbGYuHGJywLVyA0J3evJX07xvRnAC1TFNYj8B71p4ypBkh0V
         ZqArOrM2wBJTL+ZgS6SO2tt/DjnRSD9W0GqD3TjJezDr9RQ8/3qg0dIJMIpyYIVO5L
         BLj6nAFYJ0IEwN0KNONYwdnytQO+LCbtdEKQJDiCuIqATJBEVlgrvAaEgfdwE2IcfY
         MMIXQE0G+QjTgEx2lgkQRxBkfZD72xIKzDUsc8rh0JhK6+7LCqx/H/bT/hWd9RrS/+
         k2Xkhi6UFaKUU1KbStKj/hgS2B28A1RlOFUPTOufBUBQeBA/ECE1pxTB5IFYpl1JkN
         K80VyIOjJOFtQ==
Message-ID: <6a7ac68c-5dcf-7049-8f73-aaa40479de18@collabora.com>
Date:   Tue, 14 Feb 2023 11:26:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/5] dt-bindings: arm64: dts: mediatek: Add rev4 of
 spherion
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230211002626.454844-1-nfraprado@collabora.com>
 <20230211002626.454844-3-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230211002626.454844-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/02/23 01:26, Nícolas F. R. A. Prado ha scritto:
> Add binding for newer version of Google Spherion (Acer Chromebook 514):
> rev4.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


