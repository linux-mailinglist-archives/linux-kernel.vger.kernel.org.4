Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C16703EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbjEOU5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245417AbjEOU5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:57:34 -0400
Received: from sonic307-54.consmr.mail.ir2.yahoo.com (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3322F1706
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684184251; bh=tWxmac8mwRjMj71krRu9An5Rypa20FdRhR7NzHl2dAk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=D2o2sxLxc4ScX2s3oImclchspwHQftupJ/r+dkpSHg+6P4BAYrIRdXLc+qyxRMOFSo3JOoEj8A5zIWjP77KcrPqwmORWY4BmRVjsso6l5zRBBmy/lpxTVSTo/Kzt1f2UkNoZ+zIeXggcqjPag6cxXr6ZicSL7Era4l7sl2sXUVYmiOt11HBGGJAJqOMISLf0JUt+xjLg1Rj84asSb3SN9tfYE7faTgqW+sGQ5N97XMbkxA2zYYsNYnTAmhVMf9buwpQmD3g1jnhpnwS4Q3oKO9U5NYruHM2Gg68wCpwT0CEqnAZzZyPP7MxWT/NdKEDOuy+UHGSCp34TptA+sOFSiw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684184251; bh=c9IPw+ErhVvayJ5Q+Fb1GjkCkpfTDVFbIK2bZ/eM3J8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Uf/P2lh6sBBTwo49rkTVEj8hh6B7g/nPNUygTXWSM2vGekVBm6LrvjDHt4QHAxe8E7okHmDgu/DvCeSKhEu7S5+SvrDqwY+1Z76mB/8YV+7KU/EI8EIxaT8w2l2vvWB2MqSppjxkeNOid52LTUrGUzWq3OoZ6GRWDXvKMb1UDjnoJ65BgJSe64KFQmsGFaZ1gFvtny6KAd/tYf5Qda9kaO5UdFtJ27jf0sO2LNX3/35BlxhM9Mc/7/PQrmbXtW+6dLEaJ+yqGC3hIYBm8jUZ25h6NCoKsax/4Vx9cGUXq12Ju0MhnfT1BtQt5zOhcVyl9DBZMjor97YWf3kaWpfUrg==
X-YMail-OSG: rQO6rGMVM1nSx.1whPQhOYAsXm40DLbztfgApVz88tiXdV0AdNiE03v8_O6KXsC
 PC08p.3p8mgd3w5Yd5SSIdND4nL9sF3sDRoSjlq_NPKo.M3TEVR7TvmpyVvhhVzsRoork15zDl6X
 k8IQvG89yBjbZnRS5Vus39PE4Sj4gG9Yuhx56KUhFWo3KOw9U2tOx5CVb_29ZcyQ5UkEqG9df9VE
 PRUlIHSFUw16y6zWw5VaSkI3k9rs.uTxv5aXOM2Ljm6c4YAwlI.XKm13Xd0oBAYMQfUhGKyImPZW
 wNOx81YwlQotYvPLNv4WQiKESnr8YzFXrySwWFdJPO1vU8nqA8mQ8etf3GOMAwSZgrFun6W3RK9f
 7orsqMQRiS2zbCkq65vg8vkrmibg7KDYt4MWTg_4cbsTFbvgv69f.FdEhG5DC3ayEC7vJ7LL.EmQ
 d8sXYBzJJY9lweAfEHvyGsl6rMmwVusSp3fhZwA8nJiZWn5vJGubAGP3ej2YKqb2zY78sQhX56tH
 36LTXVrQAwymOjOWczLIKDzKuSR5KK6KAp01cGSHL3WiZT4eCh9dw6HxgCmCqJlu6vlqni.FJO4F
 ozV98Fp0BZVXk7kvQUx.iUcY4FDXyF41MaeUZTyWDyAVbAAjr40SHpW..Ztluh.jciVO5YUNl3sJ
 A5rsfm4lOB67XAwCx26kNcMsnnFFWSiHxRgCDmgX3Tger5eumNKj30UE1Gf40dQ_DN4F_xB1vhPb
 mYU6Kk36YtQMrUKvDoTEPTTb3PqEaT_1wyxugTuao6OuH1FlwDCHbY03VH5I2mW9RodrgkSJdPEz
 Jbcska4x.oQUdRb3lhJlIlbKhShRVjeV8fFC5EZRrWpsxyzQEF3PAGXgx6.SrWTBR1K_VoO2ZJIr
 eAOgw2a5P.zLN2n3_UWpFoco05ttTDlEXZlKiUBS4VwnTyzhGCrXHhFJG1gSqf70nljKbVNALNt7
 IUtzyzOkFvQ7l6O3tfyS955k_QM864wJeUkeNIING9iXhBlX_8.2YeiDfYeKtXhVQIKQM03cH9e0
 bPKLEm307LPBQHalNeoJy0xw6GPI6Q90fkm071obvvu8nnaY_hdZM0VWU7MTo.NxysMzu8gLfuy1
 tcuaH0lbm1LQsjcSHvuOf0jQ_Gehhx8h1dpZaHEjD1LhwdCNZAnxaNhRHuTQRcOAaViG9mmzcF2Z
 BWIz3VsqAfYKcasmRaPoqhHP_7Sz5GCwB6Gc.N8iqWgGUH0Q4hwAaviJzHrzImwobAy5uxju8qxJ
 x9M04pW5uQYqC_xaJwjGRGxqOxNVDYbSNT9eRoeGnxTZmnW1541BZW.a_7vG6dzIYUA5YAurEn.P
 S7xzaQ.HMpKtjps7Lc8xGT4EoLoawkqcazZ3GDnNpM6Q37p330rCejS8tOjH.9AG4PqlTnsgpFTS
 X.CrJ9ggtdSJC9pEA0Ujhl2RozBWKTfE92LLP8PmckE6bPmVOj7OGe9.Fe1TCredt6I2SY5rYCcr
 hN9_zoRq2QmzTfoS3wcXYxIY2cyy1gSZL_a3tchPUmGBkIXVPGLDJ4aOVaCChor6IJpcgxuraCKJ
 bMbK0mZWQ8YWlPO.T46O9OYVOtytqHFUF7EqgERyxgvOBBcXVccxJc8ITisrXE8T4HalXGiO7OFj
 V1NujcBddrgwo.EqLXM9wTxmTAF7OQP608j2bZO6_In8voxNsGj1LkNFOiwRn3bOVTyb.x_LZgpY
 F72jcQ.w24FfByFPNwzh6OCEQRbcHcVpF0fFM3h5apkm.CFeH7ktr.renh9qzBL5SYyDp2e6S8rh
 hNCNHGdH5lYZP7CZPOBsBLJhYX2VWZp9QpaYA7yN5V3SeuPHc8EYuJtrIJ2YXVHblgXMuJDqse9r
 aUJqJcv6.vWPkDHQOMS47Ol9nm48qfHihy4V10TBgIRskBfqructj_8Dwdpt1mWtPiOZqGCyYyF.
 U4YMYKStJCmnu_0kaqkKGyRIFcQaiNXEf95_OrgLFlGmOwA1F0XTF5P4YHOJUfyBlceBy0iwDfJs
 pwkkbdO6znAaYsso1KhhHrA.c74HzcsraTCBULwQu9pFykj_W5bHHe4eKrMmQNyNVppqaTW7ShxQ
 WapkKqBqsrhaT7OmFP82lWcbhrkd6nX4EkNKaqtbSRBQwzQDedDIO5OQoNrXOWu1Rfa7dM54eY1y
 aPygE3MaSIdYsmjwvM9fjIn.AAmmMRUn9jH2Pac03ofYNxDLxLX7E8mMQ5UJA5DiKYTqgMPyARm4
 Kr1tFRBvqUefcstQHAjF_hHVUFJv1WxF6gIvkadq7nEkXHNi_AzOEaMKz6u9uyMtNomQwQA34iT5
 _BRFVX1ckSbxXcI5.IBf_
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: c0a1adc7-e037-489e-96b8-54ac5eade888
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:57:31 +0000
Received: by hermes--production-ir2-7867f454fc-mmctx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9295bf04d78301a0059f933a0cc30ae0;
          Mon, 15 May 2023 20:57:30 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 01/10 RESEND] mfd: rt5033: Drop rt5033-battery sub-device
Date:   Mon, 15 May 2023 22:57:10 +0200
Message-Id: <6a8a19bc67b5be3732882e8131ad2ffcb546ac03.1684182964.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684182964.git.jahau@rocketmail.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

The fuel gauge in the RT5033 PMIC (rt5033-battery) has its own I2C bus
and interrupt lines. Therefore, it is not part of the MFD device
and needs to be specified separately in the device tree.

Cc: Beomho Seo <beomho.seo@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Fixes: 0b271258544b ("mfd: rt5033: Add Richtek RT5033 driver core.")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/rt5033.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index a5e520fe50a1..8029d444b794 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -40,9 +40,6 @@ static const struct mfd_cell rt5033_devs[] = {
 	{
 		.name = "rt5033-charger",
 		.of_compatible = "richtek,rt5033-charger",
-	}, {
-		.name = "rt5033-battery",
-		.of_compatible = "richtek,rt5033-battery",
 	}, {
 		.name = "rt5033-led",
 		.of_compatible = "richtek,rt5033-led",
-- 
2.39.2

