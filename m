Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E705B2FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiIIHer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiIIHeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:34:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58E69FDD;
        Fri,  9 Sep 2022 00:34:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 994E76601F9D;
        Fri,  9 Sep 2022 08:34:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662708866;
        bh=bjppm3Xg5rRyAVAP2JUIBpEpmHiyGYMZzbFmLSD8Ufs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CPiWIK33O8O4yRN2/S2bnLMQwjs3pzfpMtc5te8+VNoKgb936foJfRzXE66ASdEq7
         WxJ1wrQmnizKwBah12QL+vv6cWibzo1x7UbFVT5ktmDc7kwUlRb8abDJyh8oiD6VRp
         rSOfjUQ+LPP8kio5fRcshnyVR/y9Sm1oWEQUcc3apf7lwEhyzuoSUp3qHgj0ajuBhD
         CrrkEiyIXMAnxFQsdDsf6x7LQvxvEquiwp+c9vY/pBhoevwlny8hcSn8Uub/oIYzu7
         zfTzhfata86iha9Eltwqxc9xALp3y0tW/UyxSll/iwhG21WOAjQH/IqIxZnnmaaZQE
         0hdtk7b956hKg==
Message-ID: <38db9b6a-2d78-6fd0-81ac-605724ad5f5a@collabora.com>
Date:   Fri, 9 Sep 2022 09:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 07/10] arm64: dts: mediatek: kukui: Remove i2s-share
 properties
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220908161154.648557-1-nfraprado@collabora.com>
 <20220908161154.648557-8-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220908161154.648557-8-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/09/22 18:11, Nícolas F. R. A. Prado ha scritto:
> The i2sN-share properties were never documented in the dt-binding and
> thus shouldn't be used. Now that the ASoC machine drivers are setting
> the I2S clock sharing internally, these properties are no longer needed,
> so remove them.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

