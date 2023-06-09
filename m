Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E333672968B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbjFIKO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbjFIKNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:13:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93854449C;
        Fri,  9 Jun 2023 03:03:34 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 976646606F2A;
        Fri,  9 Jun 2023 11:03:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686305013;
        bh=khZyG/R8U1t7JEcowzVSPSrEZtbLOgq9/SS+pXH+uAE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bAnPi8rYRzm0Ov9Y6DWS8snsDPf0Qahbsn674loqZ2n0U4SBUppDPGuTV90PM9hrF
         0SiX2kE8I1Y9jNEWll3wnk0Or5NK5tIMOTAERHl/dtdQ17U9iBVJ8nkD3pqQuCUkeI
         gz5le12kx1WV0FQus/OP/VUFeTUL+TApa7ATkerY2XtmztGY9WFCrI3XARfR94MZcO
         AL1487JBw8tHFdAMN5JVSji487xbbvcN8wogMNuAbWOgBFHPXtWdAJPlQwNq7RW3Vt
         uxCDFBhyL2kagMwXCJSQ0gKZ4BtV/HIxxjET/5ztrRX2HA+7hIYiLqk9/HOYm9TbLx
         1pXoJC51DPSFw==
Message-ID: <4c22be0f-7368-1a49-d5fe-a6e1c27bd662@collabora.com>
Date:   Fri, 9 Jun 2023 12:03:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 7/9] regulator: mt6358: Add output voltage fine tuning to
 fixed regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-8-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230609083009.2822259-8-wenst@chromium.org>
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

Il 09/06/23 10:30, Chen-Yu Tsai ha scritto:
> The "fixed" LDO regulators found on the MT6358 and MT6366 PMICs have
> either no voltage selection register, or only one valid setting.
> However these do have a fine voltage calibration setting that can
> slightly boost the output voltage from 0 mV to 100 mV, in 10 mV
> increments.
> 
> Add support for this by changing these into linear range regulators.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

