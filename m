Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0718F6048D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiJSOJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJSOJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:09:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C2897D6F;
        Wed, 19 Oct 2022 06:51:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C1607660238F;
        Wed, 19 Oct 2022 14:48:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666187291;
        bh=JRFBIEM/o3vlqulr1q6kOtGadUUgU5fFs6PkyTMxPoM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UCmD794vdXoT52u4B6OT78/64SmEehyANCMurAXV+o/M6BESNlUbHQOjv3jkxrL3K
         9BHh5/+85ySWzuLpP7nrVjysxQQG7CSGjLuo/NzoPd9x/rv1kKajohe3gYwOmMUAKQ
         VZ3Y7RSFJYmJRoqWW+Guri4l1q1fr2KAJSCn0OBVhTPBohP1KiapOQGFTw5tbiBD+l
         LgC3Db3v/ivXnLilPWVuqrwBSxZ9YPhBB1c/VAinDz1eeUhf2Ha2DZfJ0kCg6LaeHl
         gPpqH+TTY9yAIc9ni4o+ZaG0n2zBsfLoj2KLMROl8HFiNwYlX+ExHYApUr7XZtuTaJ
         u9ZL2m9yX1X6A==
Message-ID: <56042926-4921-3e77-ae0f-3bc6c462bb5e@collabora.com>
Date:   Wed, 19 Oct 2022 15:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4] pwm: mtk-disp: Fix the parameters calculated by the
 enabled flag of disp_pwm
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1666172538-11652-1-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1666172538-11652-1-git-send-email-xinlei.lee@mediatek.com>
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

Il 19/10/22 11:42, xinlei.lee@mediatek.com ha scritto:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> In the original mtk_disp_pwm_get_state() function wrongly uses bit 0 of
> CON0 to judge if the PWM is enabled.
> However that is indicated by a bit (at a machine dependent position) in
> the DISP_PWM_EN register. Fix this accordingly.
> 
> Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



