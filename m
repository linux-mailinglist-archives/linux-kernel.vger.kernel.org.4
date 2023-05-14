Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0095E701D71
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjENMhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjENMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:37:32 -0400
Received: from sonic311-30.consmr.mail.ir2.yahoo.com (sonic311-30.consmr.mail.ir2.yahoo.com [77.238.176.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92F21FE2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684067849; bh=ABeDo2NB0iraRjL4IKIY6NTLT84fW2XDtRNA6OdZxuM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OG9u4u10QhHTqLZL3Z/c590W+5uvwb/7PNYCmdUC3Q5wFNk35lu2uGXkceV23V/lhMhOl6lhaZFhjfUbmqI/gF/tHUa8YbGyZGFS6KhOtWyo0vA8Xbq89TnF2CQUpd6PcG+wUqdEPUBQw9jTdHFCy4T4GKD5dmEir6mMlhRoBM/llSFn1d8h2aXbhWDAbe8s5iSUxV2WAs5uKVoF8LyqMu92GycFYHcHjjo8hQh07Xa6O0gwggOZTbnB63Ra1cItHyr5sP6H/6pH3ldymVYTB+PPyQoqvl1odiVgYcnqElIJqFqXeUElLBCxAk2SO+KxyIMUPxuDuGPhhm6Lr++sgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684067849; bh=bOgMST9Qz9+ZA5gsFOQZ4NduBtPmyUrODYeOAg4u6dD=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BrH18X5QbvZlTBi14RxLBH8OEifz+1jN4lSp0klb8BDsE4COVXfvwjEYiFf0Eui0uOnOKJkiqJYvcRqanDVyK8D6NYaDF1qyo7GrEAGZfdZtFza3bJisIk+kaUHDfgnu4HAxDiajgv/dJpOGkCaTGtZ1yA2NSE4QGjUSdh7VJEnfmrVgzMN2D3uQP57XqoRpXPxZUmDUvc3S3H7AgcOPUh4pOVV3F0T/oBUvkpXrinaFRNIfKoaUD+Xv4QOaaMacJzCdopkQj+MpqIcLz3RtBTJPpvJ61BAtrYL0Mn2BXaxwICn8jeYdjesy003HJ2Q/zFmugk+oVh59/iYFvQvwyQ==
X-YMail-OSG: 6Wf8Fn4VM1ny1TUfhejUZUUATuctGmhdxD8fycA_qD5azT1n4PnyNWlCTOqbAtg
 IZb6agVqNT79m7DN8a8wyxA_6NuZd7WWwrldfdskOtDpZPW88MRGS5ZGjEmaBGaqg2pnKRBIiXWJ
 XbqG0GQmWNFGiwYsHFwRrFTOZM8UJU78ImxIwCPtjpSZHSFrsGGo.ZRcL0SgtW9BC814GrqbV9P_
 rXLdoofe_5_nar8Q8unKWB6ENJYdy4x_cPHsQv4dAZpfj8Q0bFdo8ybK9pnOSXtRDparW3xHZVtI
 FoZOOw7jG.nXhqCl7a0e6mIfOjxa457fRUwEvbJH6tKtRCYXhJ_ctY1CMI.OZZ13n2eHfuu92aYV
 PR8ewn7n1GR.yPBgRMS13PFyY0l4.tac3qb.SM7OTOGikMm3XgPkoWg4spCufqaGqjyUjYp9.tIR
 5R14JdXlD_eMKqu3aP1WDdy7ieK8FODQK4jL2MSdOOjqQJf5IrrRqscro5Xmw3OfZLtI6wxMhM95
 eNPOBVk45FVz6c_YGkFGT7awh3LaG5Mj9ozXx_bOjNVAiVGrZ.kgQySdS2wq.YalmuGqkVxILbLf
 UNTfuyDErQnb7JsUm3T9eAETTTW1vJSxXIhsAedXSXZYqFpEDyyxKlFG6lix7QaSnK3hmCKMsZJZ
 tUKtEn8fz.csDVfBYiJkiXDgu8OM7D6HKaS2v0t_m9lvxG2W3yxwNkqD3wkwx3yFA2WaLiMPKZrL
 eZSz_0pv3nR9tSns3IU0bdzU9MSwowhy9QRVAb6bR4ZC0saxPu0JZrxmq7FYif0RF.FFdmcHsSTS
 UKbRAfJbgnYV9XfGBr02pAgwz0x85xfP4DJ5W8_UAqG3c3vttLJSdaoetBQswl9wcpxGWsUFx7.z
 IT0V6JHMm34_a7fTaTCyHQ8Ev1f9AUmnOPO32DpxwPnDX0v16v.8e4vBb41EWihqoURTpuNQQcgk
 8zh_L.iF7Wmj8NBMTWsrzKuCnW2RqoKGoZw_kyqGf.DIY_7.sEbkStRObeGYRYX3Cioc1KrTyye_
 n5VVr42FPwfKRRsbkAJ0TGdFUx2SUQZvg62TiKjHrZC1_DXQrqxIIPv1hWBJ22ADJRP.u17kTumB
 opJ1VXHlekJdV9lWf0hQjRf8lAXRMCeWilyYLhYUGdo7D09jufTQiiU3bPc5STOfLb6L23JkvEH8
 O9BxrLolPxQOnV5FdxaztWyZGr4K8bC_Oo2T0Efp.n8AAXKSZVS.FILamSR8.fDtK7L_VOekPHbX
 pusiPyYLVsKhOWHFt9vluBWZFbdAIPQfhN9LWcZIEZYIS8HrFQnfK1kU4qq7ry7_EJpBcT8E7kao
 rjvA4YPdV3Ynq1dpMoG200MZTAEKw_pr51NLy7Ijx1vDovw6abwvK_Lmkync2BsjNwIrtpXDxMgh
 pvAT97rmHafhLjzmJBhWLqKQ_400SHSVE0tMqnqHdnXsuaONBnOV0OLkUtbhXg3Z_bExtKvE7G8d
 d6hc_Q.ds.Y3mrTyixr0dPF_WKlU6c_Et9X1DzN6QtP_BpVIqfWS4gax.9N63Ui1KRZKuiO5NBNX
 9hrUZRhuztBfepfAg8IqhE9_OrkdrU_ag83apfQM7aVZ1i29kpomOhYK9GrBhPITXwmSXF3pt4x0
 lrUp8BYLp8y_TjAU9Jrg5qvMv6YNckkSPIrdvDZJ35VD7npBr4D7AP47G_7mKJfU_BB9jLElyqYg
 6zfmLQCGhl7ztz2KYCSnqUNvKDkhSb_nvb2JxRUQz6jDT3oqdnZ9cp3q2ptt_CXelDvZ_6.2OWND
 HjhSdsTlvdLxGhjA3OwEokqNBjEI0twwK_inxl3aofqLhkeSv7QKJ_dyCGZBLVBF7UXdSShojt40
 2U9lomEzYuBADy29_XM5FwzbGk5FkN5Yu9X6to5XabJSiTLFGn3Dl1vifa4m5rIIfnz8s6ABUeyj
 bN6_Vku9_TL9rV7FryUtwqbvCn66HOnI36mwNFoiNpQtSH4o8IozduCoR1nw8xeZUpMBSe8LxwwS
 9mBcM01Ep4nkUtAdYMsxeuXMHYcdR0SPpsfE8rgGwjihU_vnGeE5wmzAE8osUJbYkDcWfr6OotV5
 nPUuaso._N9UhtHgOxOHo0lkCrcQMu89rnmSyU0WLsT_VdL97zd5EukELiGS6cC_yuDRp8WKJ3Rh
 Rxk2gdnCJzp9RnKey.dC6oF7mFEFz.fo5w7Zb4j6H47Tp_9rimHPfrTssA97kpuh3Jv4gBlpM9Au
 ghwyMKe.9.Jm.dQDEp.EAHQ7LOU8pkrMKIj3CKe1K1Rt.VZLb8G73tBcQ_0AaDm8.Iirwys6VI5p
 vvgcIzvbje5KAMgAdYtzzYP9nwuRj
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 613d2af4-0dd7-4765-892d-9e43d36e4134
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 12:37:29 +0000
Received: by hermes--production-ir2-7867f454fc-tvsct (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ec262f708c8ca7d1990bed607fb68ca2;
          Sun, 14 May 2023 12:37:24 +0000 (UTC)
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
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 09/10] dt-bindings: power: supply: rt5033-battery: Add power-supplies as a property
Date:   Sun, 14 May 2023 14:31:29 +0200
Message-Id: <20230514123130.41172-10-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514123130.41172-1-jahau@rocketmail.com>
References: <20230514123130.41172-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additionally to the already available ref "power-supply.yaml", add
"power-supplies" as a property. Otherwise, when referencing rt5033-battery in
an example, message "'power-supplies' does not match any of the regexes:
'pinctrl-[0-9]+'" will be returned.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 .../bindings/power/supply/richtek,rt5033-battery.yaml           | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
index 756c16d1727d..07e03418a909 100644
--- a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
@@ -22,6 +22,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  power-supplies: true
+
 required:
   - compatible
   - reg
-- 
2.39.2

