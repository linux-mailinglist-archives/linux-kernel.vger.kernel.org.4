Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F29B74CEC1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjGJHoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjGJHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:43:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA1D12E;
        Mon, 10 Jul 2023 00:43:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D77176606FF3;
        Mon, 10 Jul 2023 08:43:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688975016;
        bh=RSNmmnHziTlDAgu8JEig41GnRrvBNbskDgsAtQQf8+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hFGNfK9TNWyWktDhE5Gu+sDu37Xp/SX097k01OprOFLhkjIwwLny4u2dCKzqH57lN
         3zxcXBOi8BnkYWYnLpICsp4tlkvSppwuEiZvvuEeErHtJrv9jpOVn2sRLwegECGC2n
         72/DduMIMO68/K72A1DttBi2yTZ5Nf2BOydWy5Y9pg4PGhfzUTZr49KPDuOBb4zoQw
         HULSeJ0y01wBZehJlFFllV3hWpi12/Ln8i96DCmhZu5bpRj9X5nt5IMRY5BFbRtUrL
         Bx4sGb6EBPraeDqiEbZbdGMguDPP7dcCnfBPkrxUapc+whLADpsrnqahI22m/ATEue
         8Wv1YGz088S7g==
Message-ID: <e910864b-51ac-80b8-40d0-c7450bbc4e5a@collabora.com>
Date:   Mon, 10 Jul 2023 09:43:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: rockchip: Drop invalid
 regulator-init-microvolt property
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Furkan Kardame <f.kardame@manjaro.org>,
        Yuteng Zhong <zonyitoo@gmail.com>,
        Wenhao Cui <lasstp5011@gmail.com>, Lev Popov <leo@nabam.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Peter Geis <pgwipeout@gmail.com>,
        Dan Johansen <strit@manjaro.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Alex Riabchenko <d3adme4t@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Tianling Shen <cnsztl@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Andy Yan <andyshrk@163.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Dongjin Kim <tobetter@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Jonas Karlman <jonas@kwiboo.se>,
        Anand Moon <linux.amoon@gmail.com>,
        Shengyu Qu <wiagn233@outlook.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230707162217.675390-1-cristian.ciocaltea@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230707162217.675390-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/07/23 18:22, Cristian Ciocaltea ha scritto:
> The 'regulator-init-microvolt' property is not currently supported by
> any driver, it was simply carried on from downstream kernels.
> 
> The problem is also indicated by the following dtbs_check warning:
> 
>    rk3588-rock-5b.dtb: pmic@0: regulators:dcdc-reg4: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
> 
> Remove the invalid property from all affected DTS files.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

