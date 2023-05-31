Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12040717A02
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjEaIZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjEaIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:25:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D822F99;
        Wed, 31 May 2023 01:25:07 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 12D9B6605840;
        Wed, 31 May 2023 09:25:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685521506;
        bh=1aF/ujhueME6nmzpnzqxi8tyyhgx1bzMbLCCVhzmmro=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FhF29Dom6kf+vxi5Mwx18c7tyyeDjQ0aXX7AEKH/9Fatul1QgqSjWjvcueJkQNSxq
         1/AK+qg7K3RQTiQ+SNXplQomxOs1Ff6/BPVNBr1hXnWtVBchmUqvOGYOK5jP7f7ZIS
         i7p+dBDtFmg3IELg3IQ6n/s3MCfkbl7c1KA0O4EhdnMwNZK9ii9WJutUDnlx6n+Kc/
         lbsKvB8xNz0AOxUzOIwcPfVI6z2BqWlEPlRHPi/t+BhNjQEs6A11E/TH/cK4QgC4Zm
         wZBHypXXE41b9oQDgwJ7kWaejiEzFpTHajlaYyzI32+4kjIXV8uZqUwYEHXy0+4p5c
         /pQQaSVVH6tMw==
Message-ID: <0f75de5e-db68-6ad7-3176-f8143f0df922@collabora.com>
Date:   Wed, 31 May 2023 10:25:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3] pwm: mtk_disp: Fix the disable flow of disp_pwm
Content-Language: en-US
To:     Shuijing Li <shuijing.li@mediatek.com>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com, Fei Shao <fshao@chromium.org>
References: <20230531031001.7440-1-shuijing.li@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230531031001.7440-1-shuijing.li@mediatek.com>
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

Il 31/05/23 05:10, Shuijing Li ha scritto:
> There is a flow error in the original mtk_disp_pwm_apply() function.
> If this function is called when the clock is disabled, there will be a
> chance to operate the disp_pwm register, resulting in disp_pwm exception.
> Fix this accordingly.
> 
> Fixes: 888a623db5d0 ("pwm: mtk-disp: Implement atomic API .apply()")
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Tested-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


