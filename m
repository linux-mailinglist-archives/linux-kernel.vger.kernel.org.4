Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FA76ED7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjDXWWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDXWV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:21:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E76185;
        Mon, 24 Apr 2023 15:21:53 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C99816603278;
        Mon, 24 Apr 2023 23:21:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682374911;
        bh=ESGQTysb9bAcGF9NJuR8F+/xLoyGAWa3On+CkdrCRPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aki1CjZPU4EnCrslc7TQ86Ho3ZnoKio1p21RY4+oS61iwpdgsTuF6huK330rG3T/I
         ZuvBbxjlTmL+RsFStGkFNvok4fgZn/wEunikeZo1M1OFCpC7WmuU2qZj07SRRW/xpO
         lBUcZ6JyE6eT448Vu2yd/ftAqwdm9UPphAeY38MA7p2d+SUOQIbYa3jEvDzMaYkx1f
         pYYkIEDN2B3ovWxAI01GHkvz6+umqc0reKzJFsrDNo6gq0caZROmDPuMwMIyZM5Lww
         x36xMLO5duIzRf33QulYcrg431fdHZB3dHOkEe6w3XztCg4eZFqKrdQaZvWtpqBX5c
         27ie6G8kOAwOQ==
Date:   Mon, 24 Apr 2023 18:21:44 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Balsam CHIHI <bchihi@baylibre.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, daniel.lezcano@linaro.org,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: Re: [PATCH 0/4] Add LVTS support for mt8192
Message-ID: <fab67eef-4dc9-420d-b127-aedc6f54cad0@notapiano>
References: <20230307163413.143334-1-bchihi@baylibre.com>
 <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
 <CAGuA+ooi7Kx05gagLzXAN3upDiSqDUNOM_djYdGftw6ogVx5gw@mail.gmail.com>
 <CAGuA+oqDPPYFJef_8=YrOpHQNVJ3xgm_zXS6fq_HG2Jy_6t-Zg@mail.gmail.com>
 <CAGXv+5EZPWohGN5CaEiqVrM4MyAar3cPEUhHtGY_9wTJSJNVFQ@mail.gmail.com>
 <CAGuA+oqF4jFMyEo09VDmCf-_7g0ua3XDKDAJ+t3Gat14pDM9NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGuA+oqF4jFMyEo09VDmCf-_7g0ua3XDKDAJ+t3Gat14pDM9NA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 02:20:24AM +0200, Balsam CHIHI wrote:
> On Sat, Mar 25, 2023 at 5:33 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > On Wed, Mar 22, 2023 at 8:48 PM Balsam CHIHI <bchihi@baylibre.com> wrote:
> > >
> > > Hi Chen-Yu,
> > >
> > > I suspect the bug comes from incorrect calibration data offsets for AP
> > > Domain because you confirm that MCU Domain probe runs without issues.
> > > Is it possible to test something for us to confirm this theory (i
> > > don't have an mt8192 board on hand now), when you have the time of
> > > course?
> > > We would like to test AP Domain's calibration data offsets with a
> > > working one, for example :
> > >
> > >  static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
> > >                 {
> > > -               .cal_offset = { 0x25, 0x28 },
> > > +               .cal_offset = { 0x04, 0x04 },
> > >                 .lvts_sensor = {
> > >                         { .dt_id = MT8192_AP_VPU0 },
> > >                         { .dt_id = MT8192_AP_VPU1 }
> > > @@ -1336,7 +1336,7 @@ static const struct lvts_ctrl_data
[..]
> > >
> > > This example is tested and works for mt8195,
> > > (all sensors use the same calibration data offset for testing purposes).
> > >
> > > Thank you in advance for your help.
> >
> > The MCU ones are still tripping though. If I change all of them to 0x04,
> > then nothing trips. There's also a bug in the interrupt handling code
> > that needs to be dealt with.
> >
> > AFAICT the calibration data is stored differently. If you look at ChromeOS's
> > downstream v5.10 driver, you'll see mt6873_efuse_to_cal_data() for MT8192,
> > and mt8195_efuse_to_cal_data() for MT8195. The difference sums up to:
> > MT8195 has all data sequentially stored, while MT8192 has most data stored
> > in lower 24 bits of each 32-bit word, and the highest 8 bits are then used
> > to pack data for the remaining sensors.
> >
> > Regards
> > ChenYu
> 
> Hi Chen-Yu Tsai,
> 
> Thank you very much for helping me testing this suggestion.
> 
> Indeed, calibration data is stored differently in the mt8192 compared to mt8195.
> So, the mt8192's support will be delayed for now, to allow further debugging.
> 
> In the mean time, we will only continue to upstream the remaining
> mt8195's source code, so it will get full LVTS support.
> A new series will be submitted soon.

Hi Balsam,

like Chen-Yu mentioned, the calibration data is stored with 4 byte alignment for
MT8192, but the data that is split between non-contiguous bytes is for the
thermal controllers (called Resistor-Capacitor Calibration downstream) not the
sensors. The controller calibration isn't currently handled in this driver (and
downstream it also isn't used, since a current value is read from the controller
instead), so we can just ignore those.

The patch below adjusts the addresseses for the sensors and gives me reasonable
reads, so the machine no longer reboots. Can you integrate it into your series?

Thanks,
Nícolas

From 4506f03b806f3eeb89887bac2c1c86d61da97281 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
Date: Mon, 24 Apr 2023 17:42:42 -0400
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Fix calibration
 offsets for MT8192
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index b6956c89d557..f8afbc2ac190 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1261,7 +1261,7 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 
 static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 	{
-		.cal_offset = { 0x04, 0x07 },
+		.cal_offset = { 0x04, 0x08 },
 		.lvts_sensor = {
 			{ .dt_id = MT8192_MCU_BIG_CPU0 },
 			{ .dt_id = MT8192_MCU_BIG_CPU1 }
@@ -1271,7 +1271,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
-		.cal_offset = { 0x0d, 0x10 },
+		.cal_offset = { 0x0c, 0x10 },
 		.lvts_sensor = {
 			{ .dt_id = MT8192_MCU_BIG_CPU2 },
 			{ .dt_id = MT8192_MCU_BIG_CPU3 }
@@ -1281,7 +1281,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
-		.cal_offset = { 0x16, 0x19, 0x1c, 0x1f },
+		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 },
 		.lvts_sensor = {
 			{ .dt_id = MT8192_MCU_LITTLE_CPU0 },
 			{ .dt_id = MT8192_MCU_LITTLE_CPU1 },
@@ -1296,7 +1296,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 
 static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 		{
-		.cal_offset = { 0x25, 0x28 },
+		.cal_offset = { 0x24, 0x28 },
 		.lvts_sensor = {
 			{ .dt_id = MT8192_AP_VPU0 },
 			{ .dt_id = MT8192_AP_VPU1 }
@@ -1306,7 +1306,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
-		.cal_offset = { 0x2e, 0x31 },
+		.cal_offset = { 0x2c, 0x30 },
 		.lvts_sensor = {
 			{ .dt_id = MT8192_AP_GPU0 },
 			{ .dt_id = MT8192_AP_GPU1 }
@@ -1316,7 +1316,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
-		.cal_offset = { 0x37, 0x3a },
+		.cal_offset = { 0x34, 0x38 },
 		.lvts_sensor = {
 			{ .dt_id = MT8192_AP_INFRA },
 			{ .dt_id = MT8192_AP_CAM },
@@ -1326,7 +1326,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
-		.cal_offset = { 0x40, 0x43, 0x46 },
+		.cal_offset = { 0x3c, 0x40, 0x44 },
 		.lvts_sensor = {
 			{ .dt_id = MT8192_AP_MD0 },
 			{ .dt_id = MT8192_AP_MD1 },
-- 
2.40.0
