Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E568C65B1CE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjABMKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjABMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:10:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FAE5FFA;
        Mon,  2 Jan 2023 04:10:03 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA1466600366;
        Mon,  2 Jan 2023 12:09:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672661401;
        bh=lkCFrmVPcGTYnst/KLtb52ilxI3n8W6fyPATphFVFjE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=iQ3dezdKStkSTY+iDw+xekNjCw3j3xjK3tqs70Oo5qVwqy2dSdMI6oi2ZIrMr+lt6
         YdX4RLq+QvpLyoZLnDLmPl7eWWdRrEoH6fIK1dw+pUFSN9t8XO9QatAV4MctnpBSJv
         2NG9bt26Ny0miIfMAKsRdmUIZarphEuG8URGcMp7tE0E/IPd/1fcxWnixOvPFLLKdu
         vf10Ij/rMjxoXgG2qNCai3WBjrSmMlkgI7Gb2aN9sWrV9qG23xBvgPtZQLR5c9wp1r
         Kcfj/ejgzmIvgnyFaMdKnjkwZSfioly4z44CxQXtJ72olnVXBDr/vdoQl76n2Vai7O
         1RTBaQ3vX3UNg==
Message-ID: <54e09399-6ad9-42ca-fc4a-0ff4723f0ab2@collabora.com>
Date:   Mon, 2 Jan 2023 13:09:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 3/7] dt-bindings: mfd: syscon: Add mt8365-syscfg
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        linus.walleij@linaro.org, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com
References: <20230101220149.3035048-1-bero@baylibre.com>
 <20230101220149.3035048-4-bero@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230101220149.3035048-4-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/01/23 23:01, Bernhard Rosenkränzer ha scritto:
> Document Mediatek mt8365-syscfg
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


