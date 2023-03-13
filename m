Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44F56B717B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCMIrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCMIqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:46:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1AC4A1D9;
        Mon, 13 Mar 2023 01:45:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4C086660217A;
        Mon, 13 Mar 2023 08:45:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678697149;
        bh=lTDRBLheRzJD0JjEVCsdrfB9802O7wR6meIpoKLcxaY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=idwJ7r14FC6XKQrv7+SO/qq7b4jjZMgLw1KTQQjynzhBjEDqPNjYjkLUlCbGYblP+
         39KqZuji2yyWeosH2Q0VbqegtpGNgW1Z6RSzj/6xpAH1ewHzS+tFAglJ4zcJNoIJ9Z
         plEf5DYsL+2ObJjOw3a2ncy75Xdxj7zK6kDDSh5aZC1lIoObV0TGu6g7YubHSg8XCH
         AM5tJaSUqYiGgjeWzvnEl3Ba5kZHBw7NXS3+bHZiOQXpQCRLY2Q1e/qiFWGLFhLrLI
         ZTGM3f8uRSMT1WQ60T1BVAp8wHEjjLds0+dZFQFq3zNTDHQt6uwfw0jnA6+pk4U2zw
         BdE7966QFhu1Q==
Message-ID: <7999691d-e3a5-03b1-25fe-a59f8b59fb4d@collabora.com>
Date:   Mon, 13 Mar 2023 09:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/9] regulator: mt6397-regulator: Mark OF related data as
 maybe unused
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
 <20230310214553.275450-4-krzysztof.kozlowski@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230310214553.275450-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/03/23 22:45, Krzysztof Kozlowski ha scritto:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>    drivers/regulator/mt6397-regulator.c:400:34: error: ‘mt6397_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


