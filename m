Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D6691EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjBJL7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjBJL7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:59:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A2834C2C;
        Fri, 10 Feb 2023 03:59:36 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 30C0066020E2;
        Fri, 10 Feb 2023 11:59:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676030375;
        bh=W2w7G0CFz52SMRlmsVCgP3JC3dX/JJaZNMtkuS6CvU8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A1sEgloRL5M/48bHPh/GK4wMo5fXBgGN8SJWR5vJr4CNmxXAlL5ywkwML9Pl6ugY9
         OhPxYBa4sP0XcGnXbZ+8EUMSYb1dJ0Z/AJQXjfPlw+TIkwynL785ya+U7XzX/vnDSl
         FHyqlp0YkxTt7lYKkhEEGEIqLTlxLcDGPrxs5PjVC5QNShQAiRKoEuYaowBGbCZzHJ
         ETn8sRp1GYv1xeIZ2ON0Ea1W19MOvGdftYm3QqZSeZnFVKUd9/VsNbCTGPqZxW9QUR
         ISu/DGSoB+EHsrkpv4nzh1sxy+nYkhrgv99t35Er6ocLeC/jyfF3aB/IPNKScW71t4
         EZcZPg8g7q2cg==
Message-ID: <2b9471b8-1797-4190-e2ff-641f0e926fa7@collabora.com>
Date:   Fri, 10 Feb 2023 12:59:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v1 3/4] arm64: dts: mt8195: Align vppsys node to dtschema
Content-Language: en-US
To:     matthias.bgg@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230209160357.19307-1-matthias.bgg@kernel.org>
 <20230209160357.19307-3-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230209160357.19307-3-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/02/23 17:03, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> As the node is a syscon, this has to be reflected in the compatible and
> the node name.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


