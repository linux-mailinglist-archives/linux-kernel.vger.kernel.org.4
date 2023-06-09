Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D227291D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbjFIH4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbjFIH4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:56:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7586A2D7B;
        Fri,  9 Jun 2023 00:55:34 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7590B6606F2A;
        Fri,  9 Jun 2023 08:54:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686297274;
        bh=WvoQ5fSc/arxh16nNxWQGL4QwSs0B0MbeYryT7Ue+W4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TXcDzsQ6e4zpSq+Y958OCxtvDUNwabFEG8ODtlN2eIzH4NwmjGlqS11fHAq2FhC+K
         QPaM2D3KoG7wbsjEQ3TqimrtSEyrJFt0gHvj5t/Xs9JvXxyAL8ORIllIXv9Cm0tewI
         ebOdMZ7KduRyJqrFXuO8JJ/x6Q4jzndYjsfIp5rlqMNM9j0fOsVvxwjNJLMLQtjqeD
         ejPLTl8kOA8btRDiX5cd7wpUlWrtS4myyMTn6ubB0nCQWey2mN0IkCw+cRFOMxVZrU
         DXm6UpUe7lXPoeAbJfHPisYMEjw7pTZr6IVHs2MHKFRM/k9gqt66YkyK4q37Qs29n9
         LlP1Juj3eZ95w==
Message-ID: <0a3b6f84-cc24-fb52-e2cf-14f6fd7b8e20@collabora.com>
Date:   Fri, 9 Jun 2023 09:54:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/4] arm64: dts: mediatek: mt8186: Wire up CPU
 frequency/voltage scaling
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
 <20230609072906.2784594-3-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230609072906.2784594-3-wenst@chromium.org>
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
> This adds clocks, dynamic power coefficients, and OPP tables for the CPU
> cores, so that everything required at the SoC level for CPU freqency and
> voltage scaling is available.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


