Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305B3714602
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjE2IHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjE2IG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:06:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1420B5;
        Mon, 29 May 2023 01:06:52 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7C48E6605961;
        Mon, 29 May 2023 09:06:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685347611;
        bh=v2GRVQsX6vUBhhSCAfCqx8p4bua6KbUrCIbagxRlt9U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lzqdZiBcZ1UJsdSZ1VMAanlxCw+qUvn0AUsoe7y6ciE3CPoOHH0PXE3boL85ZHDZQ
         1mEZ4mqGeAnA2Uk1QU2fonFGMihEs9S4ery53LZI76qB1OY5HoPA8dzQsJAI8jO1ju
         lhyBCjxSvLj0JM9epRQSHuN2e7Xc4fhjaH7Ak61YBXjAYMwA1Zmh4WyQyEs6rhQKmx
         TcdRruoTQBwTbiqP1ykCOyblpBaA14AMRk6YmXTTHlpXCSXvyhhu6eyMd+SC+mASXq
         cFXCIhTWcLpLCvTLRrricflxRuUSsC2xLXmHwfm5xpshohEI6yoQ3btfOsy49OW8mZ
         kGvHq0BM3r1hg==
Message-ID: <f6617221-33d1-915d-6daf-0bf73b22758e@collabora.com>
Date:   Mon, 29 May 2023 10:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] arm64: dts: mt7986: use size of reserved partition for
 bl2
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20230528113343.7649-1-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230528113343.7649-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/05/23 13:33, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> To store uncompressed bl2 more space is required than partition is
> actually defined.
> 
> There is currently no known usage of this reserved partition.
> Openwrt uses same partition layout.
> 
> We added same change to u-boot with commit d7bb1099 [1].
> 
> [1] https://source.denx.de/u-boot/u-boot/-/commit/d7bb109900c1ca754a0198b9afb50e3161ffc21e
> 
> Cc: stable@vger.kernel.org
> Fixes: 8e01fb15b815 ("arm64: dts: mt7986: add Bananapi R3")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Since you're not changing the start address for the first partition, but
only extending it, this will not break anything, so

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


