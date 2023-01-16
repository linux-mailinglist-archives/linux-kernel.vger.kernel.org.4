Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B1D66BD7B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjAPMHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjAPMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:06:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B621ABFE;
        Mon, 16 Jan 2023 04:06:56 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D6EE660035A;
        Mon, 16 Jan 2023 12:06:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673870814;
        bh=ZaBlGRRy0FiA9ociHJtulXryHKF8KYSJW4u+p7j0/44=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BrNVFrMeB9Ey9jNLd7osHBpnzp3Xa40ySk0/OepdHSQtrnc6Rch31wCeNWCklpJPB
         +iiIG6L+P8RfaRGjfoTkruajeByVkcFr0n300ySQdFObdcKMS7S9gqAD1mFB1ydsxv
         6h0+c9Cvt7Ekd+r7+x008fMQ2dLQcjsTpzKgJMA8vLfcUJ85oEaKFOmTRhxMYMEUds
         kIJv0EER3V+wpPz2a58iqpRVt+3mg+IWO4w38RVctuaahyp0Ona25iIISlo8esurV5
         HNtguY9yXuEle6No+iM/KZ4dlem/jnDayItlR3ZvaVi84i1J5pzQK8ucETmEdLiIGe
         s54D/K9z9OZmQ==
Message-ID: <6d78fcb6-c975-8a4c-787f-19f83fef2bd7@collabora.com>
Date:   Mon, 16 Jan 2023 13:06:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] watchdog: mtk_wdt: Add reset_by_toprgu support
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230116105305.31818-1-allen-kh.cheng@mediatek.com>
 <20230116105305.31818-3-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230116105305.31818-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/01/23 11:53, Allen-KH Cheng ha scritto:
> In some cases, the MediaTek watchdog requires the toprgu to reset
> timer after system resets.
> 
> Provide a reset_by_toprgu parameter for configuration.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

