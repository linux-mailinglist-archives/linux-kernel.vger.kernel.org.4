Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8379E6F1F25
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjD1UKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjD1UKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:10:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E056926B1;
        Fri, 28 Apr 2023 13:10:49 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1E58866032CF;
        Fri, 28 Apr 2023 21:10:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682712648;
        bh=b5em7hgy8DNSPO5+mn/VtcgYEzm4w56x9wJfr+VO8D4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOYtKibkW1pr8UXj77mTOfkBfTEHE2oP6mK91rL1sLuM5uyyvweODtM13BjoCDbqq
         FFlgX6LUhK6MPAje3n1giNCCJZ6nK4Jzn282wQtxAY3Vs3fUeYfiB0HcI4kr75L+QD
         dtA550hoHvFG0YaRobuOVtopR1PCjQlRpnP/TYL21qS0vVL4cseX7YVT1gXlGIHQJY
         Cm5igPAjkdFstwIoKSWNP0DM2AqJnoDgW3xoW0u7vuXjWkqqJnBXPphbruh4q3VzOf
         EYiQtcnpkVuoWrFv54pwSmzpmg18h9OujEAIIqdPwFmu+14kVVWc/OuZiWOp4YltMr
         20V+GcMJtpdWw==
Date:   Fri, 28 Apr 2023 16:10:38 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     bchihi@baylibre.com
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: Re: [PATCH v2 3/5] thermal/drivers/mediatek/lvts_thermal: Add mt8192
 support
Message-ID: <37680c5e-e61c-410b-b48d-829914200e4a@notapiano>
References: <20230425133052.199767-1-bchihi@baylibre.com>
 <20230425133052.199767-4-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230425133052.199767-4-bchihi@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 03:30:50PM +0200, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS Driver support for MT8192.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Co-developed-by : Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 92 +++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 5ea8a9d569ea6..8df7b4c72a658 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
[..]
> +static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
> +	{
> +		.cal_offset = { 0x04, 0x08 },
> +		.lvts_sensor = {
> +			{ .dt_id = MT8192_MCU_BIG_CPU0 },
> +			{ .dt_id = MT8192_MCU_BIG_CPU1 }
> +		},
> +		.num_lvts_sensor = 2,
> +		.offset = 0x0,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,

Hi Balsam,

during the investigation I did to fix the interrupt issues I mentioned in v1, I
noticed that the threshold interrupts (hot, hot to normal, cold), only trigger
when the controller is configured to filtered mode. In immediate mode the
threshold interrupts are not triggered.

So I say we add

               .mode = LVTS_MSR_FILTERED_MODE,

for all the controllers here. Same for MT8195, although I guess that'd be better
done in a separate series. And I haven't had time to test more on MT8195 to see
if I can get any interrupts there.

One issue with filtered mode is that the data read is often not ready (valid bit
unset), so most of the time it returns -EAGAIN. But I think that should be easy
to address by reading with a timeout (equal to the measurement interval we
already know), instead of a single time, if on filtered mode.

I'll also try to review the other commits in this series, though that'll have to
wait for next week.

Thanks,
Nícolas
