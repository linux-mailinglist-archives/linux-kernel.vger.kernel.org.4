Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BFF6A6281
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjB1Wdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjB1Wdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:33:41 -0500
Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED352448D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1677623608; bh=/60lX8qClY0qG4p+gMpnXJCc2PHWDxwrRrHNh7M4OdE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=j5eb2MEQxMQ21oQ07TNCKSyznwaJR5be14JWfKb7jPJs+VvY3Zv1M8zndpNiXH5eJ6bE6nJXHJM0bRZVWutqSutTvrzfhc0xuCuqtvBKbuijZA1a4I3T6hepNZzCpr6Bc/9Fbn7Ef+6nNP6fgAfzQYgEuDDys/lFnYrsWX8YZjQo34i2A8FPnZ7HykT5AbamSOWlSQ3fLIja0Ql9fjCuXLTXONtlTOZWMFHqNfz6nnqKSLuhwh30o5bBF0bm8ILqnigfjzzl3rcT7dIQBhLBEiT0S92YWlcJaiS1LwhM5npR/SEFNyTzk8RvjFYeBUyCMCxYn8juaksOAtP9pGJ27w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677623608; bh=3MHeEdLApQFylH5wpNauTk0oQjfVg4rZVS7S1Xlueqo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cKWhoGgHqVMSAqx4ksHCMKCvWxJrpumCxrDVKemX4ZEqeKfYbY5afg9mjGWLIGj804oximcDXYDdQbo5IY+CPDeq92Amsb2DxqVlvnRD95KKIumVxSg89EwvvW7Dh5rLVmctHCxe61QKfGarJ7aRW6psrIwp0Ez2dhPZ+v2GitYxSg5ju7cGrCF4Yz78HWA1/b3An5KI+9h9igl5d4yH9l24WoTiQYMs46ghiiFuO+VG+c+SOgilWMs5BmINTmZacCs/gClLrA1dKSwKA9Xj9mVQrDk6E2SAQXPMhW+btcS2PQg0ChOrK5LGVyMJGVPc06wjVc7oQbV1pxnexw7aoA==
X-YMail-OSG: EQy1tkoVM1kGIESbKLoX9l2gD4QgX7fiO5vsj_FSSIVt_YVJJL0Z4vFdWl7.odh
 24yTyHVJbHz9Fk2Yu21f7O2K_U6V6nPFGH2wN.iA57pTVzFN1q02Aew6jVolFJKBDVtn9wOZFiVJ
 xSq0hS8vqGRwDrWJHMMYo3MEV2mGA1QOuTbvAgKtSYrlaNlfyS5aMAYs1fcVWwOVkCuJeLadTH5d
 uaxavYBer2NphL7rWXxVWtwIxCfHnNO7RNCFKN4Ri8uDZ89vSYAnvLYGofd82SDwTIzdLwTWDQl4
 I1l9z1BNzDczAvCo1VzBsRqEjOa7zekY7N.o.de84mUWsYlN0oYTGtxRp3cojgr.P4BgTACkfQg4
 wFKYeWX2UM2lA36Fq7Fc3vUazGvOmXwXwkGua8vJ7foEXU.coOHTAUy.6exAy3BOscwjlAWsGnLB
 mhO54V1J8ikHDxbkam6Y.2.NfjPnN1QJuBOO0BSphY1HiYAzsvXgg77gdJ_I8VtbBa6sWPdtaU.3
 0Nb3.eK4h1kJp7xlszoZGq4K43VHDAIrbEhQ.Fk9dZwLvpuNIWhHDwYHN7zsS3rogDKayK9E3KLb
 1xeKjWvC2g86ngY.yvViYmf5YBglbic4CH.WFZMpZjY0XlM_IHmWE4W_oX4njeQWxB1GTHbFRMqr
 zxJJxjRLgSpFE.oNIdqjviNGx_XE0rAALD.5bAu7AQRzqyRbROUrqxUCQVuPsf3_wNh0We51WI.i
 vqNEex6sj5GWoZBfk_9ezNKA6BF37tpSj3CWQVCQAUTUqCaSqvi_bgiEoE_mXmVzEBF.Xbh50.pi
 M0xr2R65.NehzZFHBGap1ZygIMA5xgDGOEqlm.X0loYJ1laqBdCB0ni9V2BTjI61nKMgC9._6j2n
 x_CCHHFVW2mrR3q17rwbAoOdbddGaZgENxcczJjrpUwjzKESGxv9YvldeQg4699DpTaxkS_ivlDP
 seWJDgI2GG7zoJPf7periAJdslUAaK2PRPFOFsuGjI6i1cNzkRin30TSgvK5W6nt_8tJm5NhiBaP
 gITuJ21DFSZnLXUPynAGCdnTzUp4RbLRGNNIKpYc_GyV14jsNJbaoDYFmFONI2X1vgihr6xBxgwJ
 hZhtwxBaKwGrO.x0DsvPC0EkvZf4TL9Vz8xGHYLThZCa3PvELc9c5TTOq0tG8zWOVwy3L1Pf20aY
 RGFvIyugzbtO2jROUdhpeN0Bijd8.ks3XBhU.VFOBb3zZ0ctHVAaQVxYmZc5eI_RGFyMibqylHj4
 azWGkVaf3jCjSqetk1L1kfig2PDuLrl371eEvWCpPYAaIAZuZElr.EghLVgrE2kZ.XEufrVsiHVW
 Ts21ElLMT1Cr9GRU8HLTu95jD0pIYcUPwT8KBf4I9m0fNkTJu5rLFU4nF_r.T9ur9s64_fOgi74e
 hpPLpHPwCaghV8ICwRaZrDlnRttxepzpurQucGhuAvd8tRATsc_kduo4Xr4uXVTGN8VClLljBm7F
 pWE9r4uhaIeIo0XU3ZzN0zESNRD0q56fcp0v8N2cx_VsWLXAkGeU0UJlutjfKvuVlvqEi0MKHJmJ
 MT1_LJQK5X9_0Q2H6hxiguG6z5NClcgvB9GreyL266tYCtbSFMEv2z3f4iwPLt9J2Zbr7Sb0WR0_
 _Ow3Kuz2CxbUGyMUNpkK__q7xo8ueM2nS67UCzskDQpRuwNYOqC9KaY7m6ZsIm2IjSRNlwNo9_Bm
 SE1q6jXdVxELeRKjm8SeOnPx1eeNo5qye3Xlu.fRj2WSBBBLFSbmTonVKhVPzXZ8Gcekeqv.UD_A
 b44JBUaEvyGTeSIae6gthynVx5JOjzp.UlTjVdRO.8q98x14p8vf2McrlLc9HAYzp4tR43ESycUP
 .HxeNSvqh5xndof57XU6IEDDVnuUOyZ1z3ZFRowF8rvQ6zp1Gco0YxoFwgkHhO7GV4gAGBFO.QrH
 9_HCMV6t3f9nvrXj0.0F3hbmLS2W0cWhJGiBLWHqon_J7ECiBhMZuj1_wMscDsgFWGsT0ZcUMIpA
 gRSW3txwBVr8JLFzQjY5hDfFecseEreGjRk3vfocmu8G11jqH7GuxsbETwPitKAWNw9sfNwfATYf
 8UghOjuG2SlVJOHzjQb0jqjexzFHF4FKGVi3l4RsIVy7TdZkjP3ka3abrsIUVGospoAk1eiQ07de
 t50wVKOhxptXIjlEeFBMNMaH8S8izYcu9.FohaW2uUh5ScOiseyg3uq4OLKUlqaudo6g32aZ6W2S
 N3hb0BugwqQBlly2z82r81zokQeWzTv_u1Z6Fez_gi0oQ3IV228lh_ekvTO37Numv81k9p37XmtL
 qNsapB.MknikzTBleLhS1NZu.UxTM72MbkbXzA6f0gNZX4w--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Feb 2023 22:33:28 +0000
Received: by hermes--production-ir2-65c64dfd66-lx9xq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4362ede20d54ad479836919fc460cee8;
          Tue, 28 Feb 2023 22:33:23 +0000 (UTC)
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 04/10] mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
Date:   Tue, 28 Feb 2023 23:32:21 +0100
Message-Id: <f66e0d7263519261f0ee8ef32e12b6e81caa42e4.1677620677.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677620677.git.jahau@rocketmail.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The charger state mask RT5033_CHG_STAT_MASK should be 0x30 [1][2].

The high impedance mask RT5033_RT_HZ_MASK is actually value 0x02 [3] and is
assosiated to the RT5033 CHGCTRL1 register [4]. Accordingly also change
RT5033_CHARGER_HZ_ENABLE to 0x02 to avoid the need of a bit shift upon
application.

For input current limiting AICR mode, the define for the 1000 mA step was
missing [5]. Additionally add the define for DISABLE option. Concerning the
mask, remove RT5033_AICR_MODE_MASK because there is already
RT5033_CHGCTRL1_IAICR_MASK further up. They are redundant and the upper one
makes more sense to have the masks of a register colleted there as an
overview.

[1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L669-L682
[2] https://github.com/torvalds/linux/blob/v6.0/include/linux/mfd/rt5033-private.h#L59-L62
[3] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/include/linux/battery/charger/rt5033_charger.h#L44
[4] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L223
[5] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L278

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 include/linux/mfd/rt5033-private.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/rt5033-private.h
index b035a67cec73..b6773ebf4e6b 100644
--- a/include/linux/mfd/rt5033-private.h
+++ b/include/linux/mfd/rt5033-private.h
@@ -55,7 +55,7 @@ enum rt5033_reg {
 };
 
 /* RT5033 Charger state register */
-#define RT5033_CHG_STAT_MASK		0x20
+#define RT5033_CHG_STAT_MASK		0x30
 #define RT5033_CHG_STAT_DISCHARGING	0x00
 #define RT5033_CHG_STAT_FULL		0x10
 #define RT5033_CHG_STAT_CHARGING	0x20
@@ -67,6 +67,7 @@ enum rt5033_reg {
 /* RT5033 CHGCTRL1 register */
 #define RT5033_CHGCTRL1_IAICR_MASK	0xe0
 #define RT5033_CHGCTRL1_MODE_MASK	0x01
+#define RT5033_CHGCTRL1_HZ_MASK		0x02
 
 /* RT5033 CHGCTRL2 register */
 #define RT5033_CHGCTRL2_CV_MASK		0xfc
@@ -92,7 +93,6 @@ enum rt5033_reg {
 
 /* RT5033 RT CTRL1 register */
 #define RT5033_RT_CTRL1_UUG_MASK	0x02
-#define RT5033_RT_HZ_MASK		0x01
 
 /* RT5033 control register */
 #define RT5033_CTRL_FCCM_BUCK_MASK		BIT(0)
@@ -119,13 +119,14 @@ enum rt5033_reg {
  * register), AICR mode limits the input current. For example, the AIRC 100
  * mode limits the input current to 100 mA.
  */
+#define RT5033_AICR_DISABLE			0x00
 #define RT5033_AICR_100_MODE			0x20
 #define RT5033_AICR_500_MODE			0x40
 #define RT5033_AICR_700_MODE			0x60
 #define RT5033_AICR_900_MODE			0x80
+#define RT5033_AICR_1000_MODE			0xa0
 #define RT5033_AICR_1500_MODE			0xc0
 #define RT5033_AICR_2000_MODE			0xe0
-#define RT5033_AICR_MODE_MASK			0xe0
 
 /* RT5033 use internal timer need to set time */
 #define RT5033_FAST_CHARGE_TIMER4		0x00
@@ -195,7 +196,7 @@ enum rt5033_reg {
 
 /* RT5033 charger high impedance mode */
 #define RT5033_CHARGER_HZ_DISABLE		0x00
-#define RT5033_CHARGER_HZ_ENABLE		0x01
+#define RT5033_CHARGER_HZ_ENABLE		0x02
 
 /* RT5033 regulator BUCK output voltage uV */
 #define RT5033_REGULATOR_BUCK_VOLTAGE_MIN		1000000U
-- 
2.39.1

