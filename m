Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7736B610C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJ1Ijn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJ1Ijj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:39:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E790E0EA;
        Fri, 28 Oct 2022 01:39:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0CFB3660290F;
        Fri, 28 Oct 2022 09:39:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666946375;
        bh=UhMWJ/1/cEHdLVXxkAy9ur25nedUXLfJn8yUZ5lgu04=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TefUW9//YWfJDnNMBy5ONnnUxBXe/gejvnZs+Gxu/ShigBEh2gElXp/yeYKn67n3W
         wYKId+ZA4K5/rNAaMXTTZNbz8D04HFcxOrsdoL06tjAd057i1R1cRA0xuVj6nTZMWL
         jc2HqGmg46eE/7za1W7guuJoTKf/w9NjTTZkSxrH4fmmCKMjHTxuUX2yXPo6dCzf++
         W3BVHpf2icr820ATZo4+yvfE4iQFk5fUPIYoT0iTJqWC3eWZ5hP+uswwu4T1cE/YTg
         33b9ucRL2oO2bz+cmRA3nbRJkjIWq3VNm2SkaMQYU3Or+FnlgIOJ6cLE8M0oybagYC
         mMBK4o/11hlqw==
Message-ID: <eb47aba9-e5d9-9f27-06ae-cf386b291b05@collabora.com>
Date:   Fri, 28 Oct 2022 10:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] pwm: mediatek: always use bus clock for PWM on MT7622
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Zhi Mao <zhi.mao@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
References: <Y1iF2slvSblf6bYK@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <Y1iF2slvSblf6bYK@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/10/22 02:56, Daniel Golle ha scritto:
> According to MT7622 Reference Manual for Development Board v1.0 the PWM
> unit found in the MT7622 SoC also comes with the PWM_CK_26M_SEL register
> at offset 0x210 just like other modern MediaTek ARM64 SoCs.
> And also MT7622 sets that register to 0x00000001 on reset which is
> described as 'Select 26M fix CLK as BCLK' in the datasheet.
> Hence set has_ck_26m_sel to true also for MT7622 which results in the
> driver writing 0 to the PWM_CK_26M_SEL register which is described as
> 'Select bus CLK as BCLK'.
> 
> Fixes: 0c0ead76235db0 ("pwm: mediatek: Always use bus clock")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


