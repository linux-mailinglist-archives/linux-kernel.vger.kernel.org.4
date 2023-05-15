Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66019702BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbjEOLj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbjEOLhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:37:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D060C1BE9;
        Mon, 15 May 2023 04:35:43 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C232A66058D2;
        Mon, 15 May 2023 12:35:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684150542;
        bh=CoVmOGnZnhGZ+HBuANfDBQiUGvmHxOM62UqpRM52qwE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Lq0llcnh5lVf9KC+UPEru9iK3dGpTBhV++7MnW3w8b7NsKdoUuyzMFVbLtGGA6CcL
         NYqeTVX69lKHwuSfLBY0PMZOwtrL0l/pDT3llUG6JMw41mW0X/sNBUQhE9nyh7pw8I
         BW6eR5SrDAbEqy86VcRmpeIvkvLb/GJXgpPSsQXMq9xSMZWrBpO6sHtpynt5XV9zsk
         fWO51+Dlw2VFS9ajWkCIN3DjwZO8G2MG4CayJD8vhNibhrQmKIGlkvdDvB35GB/0MD
         rk4e8I+cC6UsKIysgpAJ2Muzsp/3lG205Wmi/9qnvdjuTjm+uhE+NfvgvGKUQHidtP
         fppBV8d4sIxCA==
Message-ID: <5b972568-133c-b5b7-c87e-06f3e8b0432f@collabora.com>
Date:   Mon, 15 May 2023 13:35:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v7 02/11] arm64: defconfig: enable Mediatek PMIC key
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
References: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
 <20230203-evk-board-support-v7-2-98cbdfac656e@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230203-evk-board-support-v7-2-98cbdfac656e@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/05/23 18:29, Alexandre Mergnat ha scritto:
> Some Mediatek PMIC devices can manage Power and Home keys (buttons).
> This patch enable the driver which handle the 2 keys managed by the
> Mediatek PMIC.
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Having this at least as a module helps CIs, so:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

