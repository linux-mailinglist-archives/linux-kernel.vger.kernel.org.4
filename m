Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D195EBFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiI0Kj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiI0Kju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:39:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3735A91D8F;
        Tue, 27 Sep 2022 03:39:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A8B6660225F;
        Tue, 27 Sep 2022 11:39:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664275188;
        bh=9oJQjywKlDMfwAImptwT2qI9qRdrXJZDRc0OLQQxTKw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RRDCxYBAg/5sAacauybkzGdFRgbRmXkz2N9biveYu+HQx+Vk+RUq+Lh56smtaA1+x
         CQC2/JpLgOKW1x8TPP0rj/qplxu9/1TMSgCniQ1aJg2El8pdZ1RYsV/AHBo0cg2L4W
         uzfHVD27qhJnkJ0jcMotVB8kZGXNmxbE3TGbN/3pN4buLw/qzXPouzjigBz47SwI8E
         PUOzvzjjgo4EVc8j2vEuULUC+T2A1goCMgFmDQSM1IxCLLVvD15lsH8QJKEipJZh1x
         gOms0/scdhfEOp74FiL+QlZnefe2RuHilDZtCpRhm7vsObUA8FCTtddCvY0SMr5G1e
         sGTwOWOsmHuWQ==
Message-ID: <13cb7e98-7db6-5111-8cc7-9f17d5a3b62f@collabora.com>
Date:   Tue, 27 Sep 2022 12:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 5/6] clk: mediatek: mt8192: deduplicate parent clock lists
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220926102523.2367530-1-wenst@chromium.org>
 <20220926102523.2367530-6-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220926102523.2367530-6-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/09/22 12:25, Chen-Yu Tsai ha scritto:
> Some groups of clocks of the same type share the same list of parents.
> These lists were declared separately for each clock in older drivers,
> bloating the code.
> 
> Merge some obvious duplicate parent clock lists in the MT8192 clock
> driver together to reduce the code size. These include:
> 
> - apll_i2s*_m_parents into one as apll_i2s_m_parents
> - img1_parents & img2_parents into one as img_parents
> - msdc30_*_parents into one as msdc30_parents
> - camtg*_parents into cam_tg_parents
> - seninf*_parents into seninf_parents
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Makes a lot of sense, agreed.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


