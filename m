Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D6A65777F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiL1OHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiL1OHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:07:24 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567FF10B56
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:07:22 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B5CF132002FB;
        Wed, 28 Dec 2022 09:07:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 28 Dec 2022 09:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1672236438; x=1672322838; bh=id
        LicMBZIzQfY5/e+pSbLh+Z27RObyqK85/CknT0pzE=; b=C0yaNOSba6OryyAA4O
        5/URcS2zNDNLvB4uAIJPUvRTMl20JretnWi1iPwQEGLYscDHfNE6L4mhG83+lSDv
        HdfCA5gqJc62QrUp8yyxg+FM62I5fSLei0lfGQ+tbEISAmzGbpC54PclUQExI1YT
        SooOM/4CcVHnMEKoQxl4sS+S0xOAnJ6YVfLljBqlXExhsciiFL6ZkLbR1e6hwULJ
        MYE9t5Vhdb3KAcrMi0SrugaN9duFvmuEoCNsv+6tiG28E7LKy8VWOmDdgkrN0dgY
        /Q/2Qi6ghgPSzzOHU9AqnhJkF1lCyL2bn+RGzjclgO7Gg8GxiZIMxQ44APTAG043
        m/Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672236438; x=1672322838; bh=idLicMBZIzQfY5/e+pSbLh+Z27RObyqK85/
        CknT0pzE=; b=CUppFfXDzG9V4lwanTMi+MVJ4HpWMc4+5Ir+5hfT2MtdPNCAzFM
        byaWOGWubnIqOzX3kNWpgpFkOPUisXrCp8mg9y4yl0xWnukvF9NtZrxgNo2y/Ze6
        i0//XIT+FTiouZAjHXkw4UjuiJ5yCnVt/FaEtwfDfIZaYn6bZRi0KFbqWSrlvsWv
        Pz8cYj1B9A82VlGC13LvjGQP6BI8bpy5OUHZQJR2g5gvjji+dsQvAxc97jlj77RO
        /njTjqLqKNhinOdSY6UPNc14T+o3I64WcPe+kRvoTZTeupp9Tpgzuc4sPn8FM3Pg
        ade8ErCrxni2WDdjb3DeSYDJdEEVo9lcIgw==
X-ME-Sender: <xms:lU2sY-NT93-YZ0z5aIQUAfPuB3-25OQVYLH1DpDmyPIXGV1ACZ25cA>
    <xme:lU2sY8_F5iiMU77r_IryU9Ck-ZKQTf7Ue9DJ5_NI6eqfiN3a_75vu__9g6oFOVv-6
    3gMEBOfY5-pB2TJtA>
X-ME-Received: <xmr:lU2sY1SLLpT-B3wdaR8_DB5K1zukC0dPY3-fUMFRd-FoZpQ4dU2dzEvx3ZaN17Omrg3Mh1mursiGg5iLd3PiIbEoTf0Sf6UCwg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvohhmucfhihht
    iihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukheqnecugg
    ftrfgrthhtvghrnhepfeeivdegffeftefhkeeugfdvudetfedtieejuddugfejueektddv
    vdefueetgeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepthhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:lU2sY-s2UndtnrJseT2rVHgqRJqSi7D6UCZBo9PPy5x0n5fuPCv97w>
    <xmx:lU2sY2dIQFI90H18YLRbNCQ0_EbJ5Qp6BQ-bIjFGHux-6UUA9MN02Q>
    <xmx:lU2sYy36RVhA2n-_RcLR5PLydeuCQtWqHYNjeQKLld0b75T7QTHQQA>
    <xmx:lk2sY3XC9WGfaSycXF17PY2cwIDsjYfp9e_ymz6spa1nd92QEAXcmg>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 09:07:14 -0500 (EST)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Lee Jones <lee@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Ondrej Jirman <megi@xff.cz>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Martijn Braam <martijn@brixit.nl>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH] mfd: rk808: re-add rk808-clkout to RK818
Date:   Thu, 29 Dec 2022 01:07:08 +1100
Message-Id: <20221228140708.26431-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes RK818 (e.g. on Pinephone Pro) to register its clock, without which
dependent devices (e.g. wifi/BT, via sdio-wifi-pwrseq) fail to probe.

This line was removed in commit 3633daacea2e
("mfd: rk808: Permit having multiple PMIC instances"), but only from RK818.

Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
---
 drivers/mfd/rk808.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index f44fc3f080a8..0f22ef61e817 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -189,6 +189,7 @@ static const struct mfd_cell rk817s[] = {
 };
 
 static const struct mfd_cell rk818s[] = {
+	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
 	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
 	{
 		.name = "rk808-rtc",

base-commit: c76083fac3bae1a87ae3d005b5cb1cbc761e31d5
-- 
2.38.1

