Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62706071B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJUIGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJUIGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:06:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6385A24989D;
        Fri, 21 Oct 2022 01:06:45 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E74BB660252D;
        Fri, 21 Oct 2022 09:06:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666339603;
        bh=JOzVQSWbOar0QWC89gDB7DxKIGXkAbTdcppYKPGwHlI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZLks2CCtqDoIKItBujkDcMzhOd4ITkNmXyDjKYMSUxjEqX1mqfBac2QAO/xmKEKBM
         UTrTEdMcAKmFHlM8+LnXlFirzS+irIsKg1KEOSBZ5CSBjk4alsiH4szV6PJLYmmVSA
         7CHv6Nd4qplQlKDpWoSI3wdZdvsyYQCGep9auZWvyfJsjPin2VtX5ECmKLfFobCy04
         I5WrEFc/OcddwmMNglmMITivnmGB7e3IwsYn0RS+xAES+zRsgNuml+SzfnIhG1qA3J
         9UK+iRTLF+t2Ia/rSB4ANSr66dqJqByJA0+w2Gsbg7Oc6vmEzIUcs2ejAdjfI4ssIq
         fpR0IeVqeVLQg==
Message-ID: <c32186a9-5a4b-e3ad-b955-164070bf893e@collabora.com>
Date:   Fri, 21 Oct 2022 10:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] clk: mediatek: fix dependency of MT7986 ADC clocks
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>
References: <Y1GnFEjOWpplFjqI@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <Y1GnFEjOWpplFjqI@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/10/22 21:52, Daniel Golle ha scritto:
> It seems like CLK_INFRA_ADC_FRC_CK always need to be enabled for
> CLK_INFRA_ADC_26M_CK to work. Instead of adding this dependency to the
> mtk-thermal and mt6577_auxadc drivers, add dependency to the clock
> driver clk-mt7986-infracfg.c.
> 
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


