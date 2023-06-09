Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F223B7291D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbjFIH43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239455AbjFIH4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:56:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8063ABF;
        Fri,  9 Jun 2023 00:55:38 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3ACA96606F2B;
        Fri,  9 Jun 2023 08:54:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686297289;
        bh=bpMn9lfOL4y09bIl92ILoe63oT1tgZKbLZ2lvHszCiQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gbX+ijwaus0CfX1VP7ozuH0RqedefzjhNp7sdD9CxyjNsabGond9Af1aMe8oiUZgI
         DOKH2hi7wsc80A06CdwcwKGNjbVm30gtFCEHdOKg7gq3Y13mnHvJk9KB1MWq4hlnMo
         0ZVGkphvKeJOS8EU3z17zkRzJe9L3jyqAWvQLpbpe7uBmh/l+6p87GG78SHpRygouZ
         xksBeQrx6RHSON2kvOLnJ4tgJUtPcI1ZzZYMVOL+2d9qgs01qTUCGJk9JTaFuFj3ou
         o/9PLHwvQpCbWd7qlKcnLuQzzeQW6AoERTHTEEZXTUYVVnUdeWL/HreX6GtHwuyxcJ
         RsKqrgkrlGwpw==
Message-ID: <9773dcd5-54bd-3b36-1107-89f6585b60db@collabora.com>
Date:   Fri, 9 Jun 2023 09:54:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: mt8186: Wire up GPU
 voltage/frequency scaling
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
 <20230609072906.2784594-5-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230609072906.2784594-5-wenst@chromium.org>
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
> Add the GPU's OPP table. This is from the downstream ChromeOS kernel,
> adapted to the new upstream opp-supported-hw binning format. Also add
> dynamic-power-coefficient for the GPU.
> 
> Also add label for mfg1 power domain. This is to be used at the board
> level to add a regulator supply for the power domain.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


