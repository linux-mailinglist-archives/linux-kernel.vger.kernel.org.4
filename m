Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DF55FEC91
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 12:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJNKaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 06:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJNKaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 06:30:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE71F4E638;
        Fri, 14 Oct 2022 03:30:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 355946602375;
        Fri, 14 Oct 2022 11:30:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665743411;
        bh=6L92KhTI3HHyC9sYJgk4N+q+nYhrAq6X4Q060GaWgUg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Yl0HDSJdvksMkC+OgWrxdQGHbzwV1bbWfJbe+/aoc7oiXV5cLsK7LSQQt+TkBzgzC
         H652/DSoMWqM+73qpo9QSXoVg0sywrUqtH48e/8Z/De7Uf0NKCDXChKzrglo41Uuft
         O+VCrcBFME2gcS6knyVcooqRXxF3CEewTlfQilejZmSmTC6Z9Xxo+7PSUhXpJnU5Vx
         WeLJ2/JNLuQVPNRbPqLQSh8Wok1uNmZximH4QzN7hiIh2etNl8Aq2LjA0UQUvhOlTf
         eSCDVwgFfkPaBJAwcUjYQ1PSH7ukgE6ZXLxgg79ARmB+WVAHoYE6xp9SwEMrxnx459
         4COvF36tVoBjg==
Message-ID: <4e89e401-ae10-f8c2-07c5-1cd7950f3e27@collabora.com>
Date:   Fri, 14 Oct 2022 12:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] soc: mediatek: pm-domains: Fix the power glitch issue
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
References: <20221014102029.1162-1-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221014102029.1162-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/10/22 12:20, Allen-KH Cheng ha scritto:
> From: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> 
> Power reset maybe generate unexpected signal. In order to avoid
> the glitch issue, we need to enable isolation first to guarantee the
> stable signal when power reset is triggered.
> 
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


