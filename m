Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29FF61406B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJaWIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJaWIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:08:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D305725D;
        Mon, 31 Oct 2022 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667254076; bh=VveKbMG/LTeQaxRP8VX1jI0G0ua9jD0BD6rfLDH/y98=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=sP4CweUGFldYkPrWsc+3fdSmFaSTIOLYa7Bgd1XTvLX6MnXXUmZQm4Ur/EvHVsi5t
         nbYgNmKvkDf9qxdWbnmyLKyCcDWBcQQGpw+6YTUv2RKQmsW5e9qz/vWf8dzisCgqpb
         BCvH3aSuzuBTZI54n9cBz2MDPZIMg0sn5JFOUHVA47StxKAVxMtuUKqNka2iyV54NN
         mks5m7dcIPD+Owh/fYQgWda3SKSM1RSA/aKoZapdRzA4sqBJQTV2LwcMR6GQbyr6ts
         qkD4+8tygQNex9my9491VWXHHU0R4tHwIA/facv+hBL01yvCTAsqK87PUXDlruppbl
         PUBa7o0MpqZlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.35.189.154]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWAOQ-1oWMrO0hWE-00XeGW; Mon, 31
 Oct 2022 23:07:56 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: samsung: Fix reference to CLK_OF_DECLARE in comment
Date:   Mon, 31 Oct 2022 23:07:51 +0100
Message-Id: <20221031220751.158341-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j5Emc8TafbsF2QWUEXsuiBD6yXMpy+wKwVPFFwFvU3Zh8C+CfRF
 h1keTk4bH98w1t+4AbGCbiggaJDXvvFAjkP696LacxG9NuEHiVBTRVXBPlMfKkis1417Ab2
 zlPVbgbbI/dKXInlEd/YiF0NQiJbxNMnqBMmaSIErWguIn/U8n2whZ9ERDCP/OnBUXifQ/s
 IBG+iYlWuJdkcCw/x7AVg==
UI-OutboundReport: notjunk:1;M01:P0:vg87klxitfo=;mH/hOW9HM30y8XcYhkyU5YF5z8l
 CuldXJj+yBuKqHrG/f6gNkXZOz3aDm47AxQ2Y+0Cog5x1jWGeUKEEEjDHN7ENxPkTpmdYGRj2
 cTfqCmaxuLeY3M9ha7TC5qHUGZP4QclOD1wPprHkBhJmCL44zbgLT+rScSzVB6l1x74JIiGRD
 8NW4+X4IvNjI5bC0uYGgw6YAaAuH1e3Kv8jwpv4On/U9HL3ZuYm+W4GlYIdJElV6FdKmZ9bVQ
 gN2EEjhzgO+mM+vGjqk13TWkeIjMK7wLpvxnnP0CGRrkQXTtD2GgevtV/RT7kP56mFxnAS0cp
 v/AeiGs/X3p0XeOXgquPtM93KsvcdG2V4Ri6KDtv5wBrLj1JEjpTnUjUi/QIei7G55MGmteVH
 bQQ8WzUra46dITtmSXa55bBHBJzt5p2VZ3h+j/749sJ0p7vpXFJD30UJHJnboURm+vuwyMqN/
 2lH4AVRmG4W/X8SbBHJ8XF/uwZ9c+MdeT75RGavMAmyNP0uNbe+8Ah28pMEG8YiT+x16gt5Ij
 o8jMSjxVuW6E0OaqbysR7aiIs47DEkoi23YIL6hBM8LcecPki4mpBIIP+Q0411akjdrUWmo2E
 pwFqnHH1lbbw8OY4JoHO2N0YBu2uOePhn/HzKUwloFUjV4OuIhZ305kuqiSHfamVGO74ArPJA
 v2ZimHm24GECRSOQKvmrAOKkCtRMeZxgUO30eMyXYPLSJbAPHsSYdcFAKW/jxvmfAiE5Fq4i1
 UcGNODo3zBJwzX3XWyzL/GC+tZrBFyK65BIzGltyXS+GrUFzke7hfiA6XazI5IgMisP4rB6Ls
 j8BXjx5cUGlQIAmDNrweB4RMVkhM2GXC9bG1K0yL85rw8MhjSpqyu3Rdw95H+K6OA2cmhXJTa
 iIQvRTpugRX+evRbT5XWudKa5Kn/LJl+2YT34ZzmbnFIBh4SAE71aMzC86KmIDPumSBo3fJKF
 0Zb8ww==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was misspelled as OF_CLK_DECLARE. Fix it.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/clk/samsung/clk-exynos5-subcmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsun=
g/clk-exynos5-subcmu.c
index 65c82d922b05c..96d74bc250e5d 100644
=2D-- a/drivers/clk/samsung/clk-exynos5-subcmu.c
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
@@ -47,10 +47,10 @@ static void exynos5_subcmu_defer_gate(struct samsung_c=
lk_provider *ctx,
 /*
  * Pass the needed clock provider context and register sub-CMU clocks
  *
- * NOTE: This function has to be called from the main, OF_CLK_DECLARE-
+ * NOTE: This function has to be called from the main, CLK_OF_DECLARE-
  * initialized clock provider driver. This happens very early during boot
  * process. Then this driver, during core_initcall registers two platform
- * drivers: one which binds to the same device-tree node as OF_CLK_DECLAR=
E
+ * drivers: one which binds to the same device-tree node as CLK_OF_DECLAR=
E
  * driver and second, for handling its per-domain child-devices. Those
  * platform drivers are bound to their devices a bit later in arch_initca=
ll,
  * when OF-core populates all device-tree nodes.
=2D-
2.35.1

