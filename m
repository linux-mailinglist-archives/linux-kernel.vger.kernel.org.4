Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09257291CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbjFIHzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbjFIHzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:55:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F328235B0;
        Fri,  9 Jun 2023 00:55:11 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D9CC36606F22;
        Fri,  9 Jun 2023 08:54:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686297258;
        bh=+WarAkzWy9Ktd1ZrhRkJE7FE8ELCJmTdSpaNjpQPmws=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WEYWQ7LUaoW/6krtkLWsSIhJPLyJPBrYpoVG+jhB2bOjJ12Yn8rpfiXz14shlzUs4
         t4aNPXkxMpGIKkl02SqA2PLMoB/BpC6tAc9Is/d7DBsjsBP8KbBAt0kgdNmh/C2lU1
         lugaK6LMF/YR5r32CUOD6lz+asxW4IdhNo26Gk5x3M4SfXikyo2riTtkeLI7LnZK5/
         XhO6wjSOw8oapkH+92xKoJN3Gw3lDxD0+EBzaaqRPRO1f8SYWKc1CD4PgDIa4LgTUA
         ONBEZ1i7rdF6J4qYwgHtUQZ+W9wHcL11K7aPG6Q+OmoTrXeBCWj2h9IAcOfwLz6mjp
         sjBoPcHn5ipLA==
Message-ID: <cedbbdfd-9c21-c134-f41a-f391b6454bd1@collabora.com>
Date:   Fri, 9 Jun 2023 09:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/4] arm64: dts: mediatek: mt8186: Add CCI node and CCI
 OPP table
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230609072906.2784594-1-wenst@chromium.org>
 <20230609072906.2784594-2-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230609072906.2784594-2-wenst@chromium.org>
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

Il 09/06/23 09:29, Chen-Yu Tsai ha scritto:
> Add a device node for the CCI (cache coherent interconnect) and an OPP
> table for it. The OPP table was taken from the downstream ChromeOS
> kernel.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Angelo, I didn't pick up your Reviewed-by since I dropped the
> "opp-level" properties.

No worries, I asked you to do that so in that case it would've been safe to
keep the R-b tag ;-)

Anyway...................

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


