Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C24D5B30EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiIIHv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiIIHvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:51:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24BA12D182;
        Fri,  9 Sep 2022 00:46:29 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 479E36601F9B;
        Fri,  9 Sep 2022 08:46:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662709587;
        bh=btuOYk8Yksu/mrbm/ksppF4pLolIdwf7c7FNNubU8tY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ER9D9KgU4DiM/CrXc531i54AIBoZ+wfDxtiZMsWtHmFOLLB9UxakfunXndj3dEMjz
         f9x5HT7A7lt+2PtIGlOjL7gB/802NDc2XpMUKuhnBLYpMMttOkGycGC4SumkCVwf7r
         IjzEZlpiy9BAYOaf2Qqi8RNyY3PG43Z707ctgTsDDTSgEPrFdmaybQk/dgDhZ4e6er
         Y4BjND23ymZ3IXthUfcIUQmrv4x+a8havLKYYPsHz1pycRqpbrmpa+4f4MWmgg7+KF
         bUQuS4jP9uIldU3LhB7Lu4RdOgbYEFNjgt4ppmxMWl2g3mZO7rtvE+I0kI85Rnjy9m
         fEQKZKqYdaAfw==
Message-ID: <a8474650-3083-837e-9f0d-590b025978b5@collabora.com>
Date:   Fri, 9 Sep 2022 09:46:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/3] arm64: dts: mediatek: asurada: Add display backlight
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220908171153.670762-1-nfraprado@collabora.com>
 <20220908171153.670762-3-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220908171153.670762-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/09/22 19:11, Nícolas F. R. A. Prado ha scritto:
> Add the display backlight for the Asurada platform. It relies on the
> display PWM controller, so also enable and configure this component.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


