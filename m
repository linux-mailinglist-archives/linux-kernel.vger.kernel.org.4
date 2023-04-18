Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5836E5B99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjDRIG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjDRIGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:06:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1147D6EBA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:06:04 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1410F66031F1;
        Tue, 18 Apr 2023 09:04:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681805095;
        bh=HYpSE05+ALPgNHVs9N+MeFT7atq4JrXWaOIKaYOOtLA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I+M00XgHxGxyOLUsCzKyQXxyIFIaswZl6IWIAkI/YQpGz/SP7UHqvJNwJu+2G0U5U
         g7glAtqLguG31hmXCDsLoscckWntth9/l3n7/0vIT0asKHkuEng9Ln9HAcfYOCNBt9
         Uu8Qab4z2c7pcpTKUbp7FCcTHLvVANrJ2ff/LKPCVPY6uzERkD1ilJgP0eZ63L5XMp
         vh6+K9uOa1RXtGJaly62mFwpTnsm+IYQBUMi06FZw07twoHX5yUeoTmfZZ9TpzDWIW
         qfmOvpK/DnQeEHLwK7DM1uUOhS1lPYGq4RbaTo0uPUuvRQ/LbVVrn9VzkdJyuweAto
         r/cEmfdyXuKpA==
Message-ID: <b91a7bf5-9da5-cfe2-e488-b7c4e6fd5470@collabora.com>
Date:   Tue, 18 Apr 2023 10:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/panel: novatek-nt35950: Only unregister DSI1 if it
 exists
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230417-topic-maple_panel_fixup-v1-1-07c8db606f5e@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230417-topic-maple_panel_fixup-v1-1-07c8db606f5e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/04/23 17:41, Konrad Dybcio ha scritto:
> Commit 5dd45b66742a ("drm/panel: novatek-nt35950: Improve error handling")
> introduced logic to unregister DSI1 on any sort of probe failure, as
> that's not done automatically by kernel APIs.
> 
> It did not however account for cases where only one DSI host is used.
> Fix that.
> 
> Fixes: 5dd45b66742a ("drm/panel: novatek-nt35950: Improve error handling")
> Reported-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


