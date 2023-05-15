Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2C5703F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbjEOVDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245420AbjEOVDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:03:15 -0400
Received: from sonic308-18.consmr.mail.ir2.yahoo.com (sonic308-18.consmr.mail.ir2.yahoo.com [77.238.178.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B1349C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684184592; bh=jEBoYmuGZw6R38I5tsonVRB7fSpXqSHBWIu+bqGhF2Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fVfhbPGR7YwNKFaT0crjlfBWJGB82Lr6gAWGyGjOepCecKiaAJNWH98jC07R/s7tQPx8qYM1JFg5FM896W6pgktU5QsnW1wAg3HdIxzqboXjvabMpcTspB3gzDbXKMcHkUxmTDiyu20nmvLFxICBu22/V0NN7QG1MP0HciZarQpFf+L/+rKOXqbkkVjpvWDxWRoz4CIu077OpIL1OECt/D5KCJU9WGDSk1KSRbXC+Q2DifGS4GkfYlw+bTisQxAVfg55JSqaIhPGpEQiQxXVDJoYA5kSa/F8Qb+ctVVln5Ewf5obFUEk6chwhJKjk3TCJCAnvYzaI/HY9W2LLonukA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684184592; bh=KpImkhB1Jal8MxquNpn0+KcmeLsSamjSABVAK3TvEvf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XmuHbvv/1vtgpLRzCb48odjkmJUbJCAPu9PEB0rkvmbbBCsQwU4wWIrUSfANf78l5bwiEK+B1yjJLVgc8mv5X4n7hiFzaX6R+VPnMZun2npSC0o56R1KPkIfVVozZofGpSfpbY2F22rjEZphQHIpA14H8bY1DEVZ0/a54Lz2hN3CBsCFZO8qMGqgIiJ/RvlcfSsCSnIGk6XR9QacxcvspPOG9MfNXKRf5B9kHwBOUWUjbNKDIhvrmRE8pHIT/34p2sAvBoXrpLg5izGBSWZJ/l5oraOG06eQdyMUWjaETcViGZrM4dAH0Xg1a6rm223QBL+i3S7QCsrbsu9Vbz/PoA==
X-YMail-OSG: hjtdLAEVM1mOXg3I.4z0L.vXtdKo8d72ldKYGVs6PB66p1kh6nG4y4RD8fAtFOO
 dJCBhgE3CJMbd_ycyx0M_DI7BVV.4PCwSkNH5l6WbyHXJ9.wC3thebacAG.dtCacN6D5ri6hl6Gc
 LQpRsySgcXt7Uxzc4.TSsKq.VWdIFt4_J0VdsACblAcl3DEaEUIkZCjKAepwZ_8Ta1Rdw__u8rhP
 wB6a.hsFb4OXc5so8gPy8HZUa9Hm.cAevZhfs2ZntwCP96pQmM15NYVQQCySEb4ymmYT6pGGbDQD
 e3_I.wt6BdfgOnm6qYVLJtjV2Pjk_DKBaxTuwGW1b1DnzZoGkWAzl9jEETL23EibAfyvhTQ_310W
 OuGTFpEtd0zoy8mabg9kFfdo7ALWJYyinHAeQvbaELNm9.af1RbM6UwgH9Ki2Br8N26eaxFEiXWK
 jQD5YWphiLO0qLppy.aLjcII7RqnpJtQctnLrhmEBqWfuDKNlCNWhcxrxRlgN.FddHgE4vXR3DhJ
 t8sXoBomww7Jbxb566XED7opqM1W_IEWuxCx6tQqk1hP9u3g9UZ5iO0RSKQgQWRVntVuOIJht6UT
 jhBa1pF7jk1b1v0OsTrLiwuyDGKyu6d_KhS5kfXv6fUdvb5vFN80Smv_Kx70KCrQNNqBKvKR4t7n
 0tXlr1R6jNrek.ejpH8RRgmuUhXKH.6ZqjJqh5Z07cXY2YdMAuQuD6A6aAwgYNgf7_zCvf1llbpE
 sDo5pz9TxnqsWZB0TcTT7kER49q.yGVcr6poTqUvH2ZgB51KHXHS5xmOCEMujDnA_TEKMNyYL0RN
 KMmK5tiD9zU65N612AXu8YVAQtMqRsqMi1r5Y31343_sqqU7vHJT6iVkTrOB6VSSNRwdranpvamJ
 OO5sctHLOG3cuRxQOMfQGogm6TbFI0Ic.CNWZ2eQ6ETaakCd6.KMXk115CJwPQ6ehHdzLL4sPOUz
 vC_4pGIB1vPMPhSvTg_3sq1cdwneAlYU875qcUtxTnWG9q3Y8s.4CqPbGUmHekKARHj8i7Lfg09g
 GRLviBn6axuSimEc5zFaKAHoTC63r3rdttAYJUKaIIHe9aP.2thIgZbfdkXRUAZfLyPe05kaWJ5A
 Qk6V56F.qP0JHzSwzzluKNPfsoJ62ck3rxtlgp2Sbv64pNZasZTWFBx4.LLLe535zY4OnEXDb18s
 iOcB85k1J0s2I0lmNHk64fz.JhYus71dfiEWRN75KoSZTkMQN983BI6DMYcxyaRn6u82QJLcjCdQ
 iimOMQYm08_M0LkssKPwj0YRMjYQxmlmVM8ouugn7Rv_7Xh_oG3Rg1IdXC9mKfjaMJaLxmXAwSCU
 qcQBYQ8IfX8S1d2iIwlUgjkZP08GnK4h4gy9oo55ZG1TIzimeR5atjDsst0pAcvjmZ6rgkHx7EpK
 NeJ0nKuieGUgo92Xy61HBDwpFSn3AVj85jpev4iIUvbwOThntl5DIDbAESyvkiz9rEfEH1oQnOxg
 o5WF0KAD3MdQB7ea9jcBHJRARMRsMbmy50yCI4cr80slpIZggbfDd8M2drLW6h2UgfvbSiyOhI3p
 QSWwBVsvfuSwB6.TzPS7zrRhPE4M.wK0LNjf.1F_L4BEeTFf62H8EGNJixII5mBovbOUsBm0qJyZ
 6NAG7rmOs23EX2YotoSGUYl_IwVMZbyxJjY1Qp2z3KjnFOy9E7H.7Bce3MEwP5eRFkEZpgYa4KE1
 bv153yfe.Yb59d_aSyjfkaSuUiP5VCQLijcIC7ZCC0oBblJ9L.zje5Ll__9XwHFE7pMFrDsJ65JA
 30SY8tp2YUZoD615nRic3_Mbk12Hk0k4FnbnVMCadSB4eDzVAcy9tOKGc8v1dFILgNOmryOGcnMd
 rWCHHbGkWwJB13CJnTPEsS490kZMo31myLr7D55jSFO1MD_6bpovtFmyyQaEAU9r6aAW7IFOmROX
 83uWcL6SUe0IEkmUHNSDgMUeDhIdJuz1tflJDGUiqbZMUQzBGP31jyMsA3eF9wsKRsBsHXgEXTA2
 iMMOl25Aobf7tST.iv570_lJFDYWMdMWJxeQGIEb.snEo7EjAFnQNWxJ1KUrjlLAAck_._eSLHyy
 psDktKUVPhqQSVkynKtd3BOFGNc4CHkVxds2U3_.tF_y491EQpddWo.t00nI.GIDsxoSONQs61Wl
 athDoxYFO6WgFojZYvvU9Ckr95eq.iO3yIsKRYVf4Y_bh1tOqK9UsDXrwv1rDrXuVXVcI0WMKZun
 31tgKpLOr8JGyLvSyOUsW1UlksaQSig83ZdnuWR6NWnnNSPlcPcY4EQfRljTuHAk8_GtGzuDX9Gj
 nU9CV_0InVVv8wYXS0bdcqs9kKg--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 062c5fa2-bf35-4f16-a827-84f07a0dc1ab
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 21:03:12 +0000
Received: by hermes--production-ir2-7867f454fc-bgghb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d8cd4b5b48eaefdf4c621d749d286a70;
          Mon, 15 May 2023 21:03:07 +0000 (UTC)
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
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 09/10 RESEND] dt-bindings: power: supply: rt5033-battery: Apply unevaluatedProperties
Date:   Mon, 15 May 2023 22:57:18 +0200
Message-Id: <ef86067348f01a3bbf1bd9b4f81716b62ea1f552.1684182964.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684182964.git.jahau@rocketmail.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
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

Additionally to the already available ref "power-supply.yaml", replace
"additionalProperties: false" by "unevaluatedProperties: false". Otherwise,
when referencing rt5033-battery in an example, message "'power-supplies' does
not match any of the regexes: 'pinctrl-[0-9]+'" will be returned.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 .../bindings/power/supply/richtek,rt5033-battery.yaml           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
index 756c16d1727d..b5d8888d03d2 100644
--- a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
@@ -26,7 +26,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.39.2

