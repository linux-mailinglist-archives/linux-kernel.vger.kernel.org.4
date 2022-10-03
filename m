Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21F85F305F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 14:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJCMh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 08:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJCMh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:37:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615602AC49;
        Mon,  3 Oct 2022 05:37:25 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E08D16602266;
        Mon,  3 Oct 2022 13:37:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664800643;
        bh=mUEUSYdWSHm5PqjemMFwDRgFrWK0rEzlRVBCVzPa5AY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=km4rRLgJ9osYdiqu021ka1hijqBvRELrqXVrNphErcGXJf2zBbfRY1f2tkmMWfyHc
         gUxymPh4hVGr5UR8DTCr42sYLeY/C0He98FoPef3luP+fCeQ2sJ1usZPwGS2rv6MWo
         +x1Q5FHRq34wpebYpk7+qH6tYRxDNwq6kun/odnwIk5ag/VTcoKtsiZAjPus77efAh
         5sf+n5TXzBZz5d5kNcm6ElR3A1JzUd4z9GpceJG7c73H5AChPcAJYmiWkjYMBaXw91
         bF0DmZI35LPfBAa4poewYnQ6pF2xNpxqzS2HwOsLqucWU1+h0l23eGbevqOUHaw2Q3
         vqREkgRZPNbIg==
Message-ID: <b86ae975-30b7-5e3c-805b-0332f241db74@collabora.com>
Date:   Mon, 3 Oct 2022 14:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/2] media: platform: mtk-mdp3: fix error handling
 about components clock_on
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221003070830.23697-1-moudy.ho@mediatek.com>
 <20221003070830.23697-3-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221003070830.23697-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/10/22 09:08, Moudy Ho ha scritto:
> Add goto statement in mdp_comp_clock_on() to avoid error code not being
> propagated or returning positive values.
> This change also performs a well-timed clock_off when an error occurs, and
> reduces unnecessary error logging in mdp_cmdq_send().
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


