Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD2767FFD5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 16:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjA2PSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 10:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjA2PSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 10:18:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D7A25B
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 07:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1675005479; bh=Qq27hLNazqH6IS+M8JNjhsN17IYOdE9EIDZkEI6lmRQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=oaGcEF25MVLWvpj9LSN33dXSWNdRumAqNqKMDM1pxOPQ7uSE9BOsvjHQqwYVWRTuJ
         X0xtkIWaGU1oXwLE6ggdUFQdnXk+IsAQ3tI1aEQXXpdCDCEB9tbRkA+P7GfKA/CK3p
         qyVRy5aypRa8fzlI04xJ8uQ93nba1k7ECvW7e9mQo3lRrvtItArAqfdTUxyADuEwml
         mxWOIYWrfLVa96inwpBvUrB00dFLd8klmQr62cJo9NuXv3d51uHwgp3hQrNdwt1699
         MV2jNFi2P1eHWRzE52fHjNdvi58tCpU+e0n9W2oN0SyQbTvYU77YDybu8lKpRhKBGz
         2BU4kz3KLUUng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4Qwg-1ocSpc3fxG-011VXG; Sun, 29
 Jan 2023 16:17:58 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     amd-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix a typo ("boradcast")
Date:   Sun, 29 Jan 2023 16:17:52 +0100
Message-Id: <20230129151752.1531144-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xA1iziq1qDckbUx7DYH0baOF/Vz4I/NB3FFlnQfCBb3BQrDRP8l
 5m3hjte8K/tgYs9o/DN6oqtO+oGEoOBkdNexPlWO99DMjOqqNWIbYM0gfPfEcvzChPmsmW2
 B99/WPZZwCqAJZ+U/zRPWDl8FFp1I93BEEKVN+p9Ue8IUB0jzqVRo29j84b1wxaA9Kviumr
 t08iOcW1c7bqIc9WedRUQ==
UI-OutboundReport: notjunk:1;M01:P0:eTk6eCX3x2s=;tecDAsgsvgPjd+fgAz8NtozAi6T
 wpr85IP/1M7zQdspO1A+t5hJE9dQ/BRzM1AW1yl8qgejive8BRFM2hYblISQFwslC+cuiS/st
 VwZ3OvKdCLXouUKdmOwrR4Q+edsAM3CcXgTbcyu8rFwYzFxNFyVjCXeiQmdHCELGjanhkGElz
 lh7z/IrfLPeK1NrDO161iRgcdRwVxA4SefTaqW8bliYU1FZV9Ri5HPwfYdgXlD91ioe+D+iRG
 IJLhyRN8o6ukxPXkEnVmqaijlp4ARI7yX9V0o19D+oJSD0kv77+e9cwu+vR0gFEzEV0rZ9yvR
 me0uuoDxRYwJ5PkJ+9LGqnfeRjCnfUKG6YTZufnakDPxvn4VliwJthfgOKZyw26z8DKtt/Fgg
 kLyxgEJyX2ankdPas1BGlzrhmL8D9KeZq4YXpZ1jFCm79e5ZkouLF298UiPWg8X9+9I2hixUX
 3qAek6Ka86FmTXf4iYzIpxGOQCcXEYlFnsNhkcCmR3sP3XMVPndQGqO4aNIjFY+WpufIeOgtg
 58wpN89gCVfK85izhYHVbAcpIQ+soLXNtScIY6FPmb/t2JdKI+snQZSr6WFPNFhJAKTT/bM5d
 14Km2IX6TKyENfpNWS/zrpoRJS2f5pUWKruEoHnljTQKTADpJ9qEtcBXh9PeuaDeW0wtHysJk
 NQ4tyqFdry9uV7vsht2TsXpxGzi5gZ/Lg07rQ0/GQTGp81Ple8cz31FsCnl3MrrLSgkAsx8Yd
 1Oo/GEhtFjNtX86I7bHnypb/1fWXP2C4JZ9UcAmsk20y1o2gTdkflKyLNYs7Duu/czs9zaqLW
 7USzxyMBPvH+C4dwe3vO5a5DDMqvCiWp/o+sZs6wAorZw5FfxZbyGzp95vcLINKuUMETDf1QC
 7sXP/PKB4mZ65+greqznVrqD+E2E2mfm5L6r0XQsHgLnnk7ZBbD3heSJhQI15+9vNFfB1nCtl
 dIyVkvo9vQ76GfERETec4y2nSq0=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spell it as "broadcast".

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/am=
dgpu/df_v1_7.c
index b991609f46c10..5dfab80ffff21 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
@@ -94,7 +94,7 @@ static void df_v1_7_update_medium_grain_clock_gating(str=
uct amdgpu_device *adev,
 		WREG32_SOC15(DF, 0, mmDF_PIE_AON0_DfGlobalClkGater, tmp);
 	}

-	/* Exit boradcast mode */
+	/* Exit broadcast mode */
 	adev->df.funcs->enable_broadcast_mode(adev, false);
 }

=2D-
2.39.0

