Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C819C733B67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbjFPVLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345565AbjFPVL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:11:27 -0400
Received: from sonic306-21.consmr.mail.ir2.yahoo.com (sonic306-21.consmr.mail.ir2.yahoo.com [77.238.176.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5213AA4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1686949884; bh=2W0/s9Ei/3O15AUKoqqy+U+PAyRYFPdruzdJ33WOGco=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=IlbipCUnNwFJWBJMWof8BoQrRUxxcHM+casc6zwXMefAcLU4ICOt0KxjWc329Esd+HiWUrNKs/mP/Lnxwfm98qnRzCXMC5NpBSdmQH8SC29RnIE5T9OCQUbpOUL4HLco9reM2mjwqQEIzKpt3hDDOs8l7Gtr+xaeg7kBWk4MfOep/mpX248EzKVTJPA9ARIMmCTWcLlQvTy1JkPnMPO/bS5S9ZCR75iUr7gtnSkdbon9QoBsgfEqyQjFjh7iWqmZt8afYVnxKd0nNinzjtHlHKptqt/2d06dGhGYjKBgNj5evxVVHGKh3L/nvY50Od0auhRMdTNci6wbiulfSXKvMg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686949884; bh=gYfF9Km1KkuiJgjuJx7CFL7L6+LHkiGQFKAZPKxrRos=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Pi+3f/9k2VyDUtCVS55SQvFqqMKdnGb5r2a8KD8lJL8wLHH7aj4dYdV9EVfp0BXyQ2KvyNOu/+62Ncclr5GXzuhB9Xl8PxgI5ldrjQGoog1JuKWFRs3cvZaHuOlH8G53Gy+1zQ24dDdnz8VI6TZAwWVTwsZSok6ZJtmoUBFdYMIVUdf9AdH4Mpylfn+kkyCLh7+HgDfdeedLMFsjnwOlKBSFS0Cn1gxuwZs2irYt2d/Ej+2QXZQlm5LqH0UcGXlCv4raxoYoVtGKA3uQdp1TkFVffleYb4tS5U5PYkhtjePHK9D/+Gg3TcrYM8Re9JHfi+BQn+Isex6oIdIPvUyR7g==
X-YMail-OSG: ER_yI88VM1mo2Ge8EsI_.ohOcn10sxXGnW_m6.KqjdOYAnYpqKsNDVyWA98CJur
 p5cjWPEHhgmSLjgAlvw4Nju3_ccMcxObzv8Eb6wS87lmdMC4kUOcvy3YRzPehB6DU1hZPkqluDSp
 qpG8HxoB7aL8cqF45PrKqNqe2U.g6AxgctDAnBsyPVVKzlrdS1HayYBaK90SvZMPJQSk5Cu.KDf6
 CFRlZkZDjnmTZVHUrA6ZdS0T4sVG5IIaiiuq1JVBr.nyASj_A7Fi6UFzeSgxoF1neCj700H4WMJG
 m.Y00Cplo76qjNQdHGvs8pPen1iQ1klQul7TjrfXS54mDathcdeqMqpcY6HHG328JlidjE212VnU
 o5ZflK3JTTWY4IlUY5hgYeLkn0KmJzUFpRm494oR5jxPUNWoPvRyBav_mJeHMwSjGcX2MZmsfo2L
 YzZtFdqSiORm8xEu5NVpP9sXQlBhixjSlUlYWlaQ3NLm4RQqasBR8QxkP2IChLyBnZ3XagDAMNJn
 X1zlBVdlrqZNXGguS1nemXx9Ipdv8OIs66yhSflCRrZwKDfecP6L3hlcEUagW3TWuH2uHuGP7CRP
 ZYS.KROGc6_XxXfgPtPP6YiMELUf_rv7mvJKXIFQMmqPz29i6_sta30IEpvV_02jf8TOpo66m2a6
 cRfcK.fqnQAXmxGBCoJOQTmc67.ljuwvOyzo0AGiXkaTk9NcTiynC.k4W04_T0oXmJr_2c9axp__
 VU63avlMIJ5wJQt9jCm3x__XbqGoE0Uo6xTViqcPLkQteIOlTsHVAXUMVF_No8fCjFCxqfJgE4Tg
 beTpWzWdn_6FgmoXfaH1vwI.b4VjoT5FxLaMC3VGQyKzn8EiHolPhSRKe16kIRSdhZQ6mSM9KIrd
 IwbnrNhz21AZfyac1AELFnT3DeAOoNLsP3k1eJOUDzbJgXLtlhPb5qXzejOfQy00.392DFE_nWqx
 7CRhq4Bpix2.t4sec5_ZrDgXi40D.7fo.tON1FP5T29TOU_a.7XpKbTIRE14a7zsA7O9mxH5NVyN
 FePtXpe_rF6t3HFFLaWyCVESxgz3.xvG7vLQZ0VlDeElVIIboSH1grMDfXItJwOeYiLBnJT6CXiN
 LzmMX4We_PcXS0YSO_qQpnaDco_apOH0aVnmRRWlJWwwSQsNEuI9Ska5HT84QJUJDGJdUBwVfHLw
 9ag.Ur1.8dsiKj3ggLsfe.rmR.cZ3Q2iJR_nGB41FK65S9fea16lCwVSF.RGCt_XXkKyqSMoTczb
 UncQQHLNLW0r8bvMG1V0Dk0qJKMw23uQiGqs4MyZmeKDwFCKSORPSjLhT68EuFz9ngvVsnSLWdI0
 tP45Fu2wWdacaFNGwg27iIymB3YRkKHBmluOYHNBYlgI1TYwm7wXp2WOacxZ2JFf9gTqz1dxeDDy
 3pkdO2.qP4B_y4XLYR_oi.bgmX4OE54.p.LZ0Ma37XgOAPE3em4Oia4Udv.Ya7PIh2tNlVXAQSoo
 x5YAG67uYFQsZUwzJjsw1ca.4H7xH7CxYDMpec_8Yo44MUs1xM9pIR2yILR98Qc1GjGLhySdiSff
 q7QlJD_PQM2QnhBFvsuuYfWND9TE_TS.P73.0fwXPaPpFS2tEgYlBGFrrOxuK4f8WtuqF3HXPmlL
 bflq4vBoqhnXLMHYk6n6kYBzyM5oPKnxnbcGJnTLdo351C57b5cvaMjgeeAtaxxHlJy3x3zwv8q8
 ISVWMP4DCgb0tagzHbviMdbMnGLgtKikxXSpzeduWgEbUoZ3kLR6uXPG._KrWFF8_uvJSNLKbn6D
 THiaJMukf1bAH5FF8mSz.N1xg7RtbRi_5CVDiOyVsmJiWBISaNR1hRJEPL9ZKiM.bs6uYd2WZmeu
 yHVhjn2KywLgC9xhKVfVW0NuYVfNz9kXnNkOQXsPUfPmYDdnJiD1RkRifYSXI8WiATRec.SKOgxb
 6oFC.KETpTdyg6aBTtxE_BDKAUcUfAj28keIwI9AOyZt0wHpD_TZxTcWdDR0fv9.VM.Gn_S32iMw
 PjCDjz5GthAXJKcDzkhnY3P9dpsDv4i0Y2GRgoVqwU2glquDoBIYHB8hkfZI53DzRLKFgenpIpjH
 0XG3.KbeTvo3bmMBV_1Y7vACxJKGG6dapu7FmeoeMbj05hg.QiW9g4C7k7x0JZdz29jK7OXP0YO9
 BvCxNRQcQSKUJjz8KJ85EWLFMOYAmb77aXQq_iMyEDAV5VHsFZpdx3lKFjC_QRuDgwCG6a6AyL7U
 F0kzalVh9ibkeLeAM3cVju8tkmYPr6xGKFrdwG3U6BLHDfCVGpTzKbXPdP08XaiBJhhnjJuh48ek
 N92Xo2ROKHnls1hR0l5p9peOusLlp41zXNA--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 5be4c50b-e39c-4e3f-8b4e-f2655f0c20ef
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Fri, 16 Jun 2023 21:11:24 +0000
Received: by hermes--production-ir2-7867f454fc-gg9x8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c618d34c94eed5ad1e4505ee686233db;
          Fri, 16 Jun 2023 21:11:18 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 2/2] power: supply: rt5033_charger: Replace "&pdev->dev" by "charger->dev" in probe
Date:   Fri, 16 Jun 2023 23:10:48 +0200
Message-Id: <99b76d5ed0d47f55ddbf55564a0424d67af1a447.1686948074.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1686948074.git.jahau@rocketmail.com>
References: <cover.1686948074.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the beginning of the probe function, "charger->dev" is set equal to
"&pdev->dev". Therefore it's more clear to subsequently use "charger->dev"
instead of "&pdev->dev".

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/power/supply/rt5033_charger.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 361a36c2a195..71a237cd1d61 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -667,11 +667,11 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = charger;
 
-	charger->psy = devm_power_supply_register(&pdev->dev,
+	charger->psy = devm_power_supply_register(charger->dev,
 						  &rt5033_charger_desc,
 						  &psy_cfg);
 	if (IS_ERR(charger->psy))
-		return dev_err_probe(&pdev->dev, PTR_ERR(charger->psy),
+		return dev_err_probe(charger->dev, PTR_ERR(charger->psy),
 				     "Failed to register power supply\n");
 
 	ret = rt5033_charger_dt_init(charger);
@@ -690,22 +690,22 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	np_edev = of_get_parent(np_conn);
 	charger->edev = extcon_find_edev_by_node(np_edev);
 	if (IS_ERR(charger->edev)) {
-		dev_warn(&pdev->dev, "no extcon device found in device-tree\n");
+		dev_warn(charger->dev, "no extcon device found in device-tree\n");
 		goto out;
 	}
 
-	ret = devm_work_autocancel(&pdev->dev, &charger->extcon_work,
+	ret = devm_work_autocancel(charger->dev, &charger->extcon_work,
 				   rt5033_charger_extcon_work);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize extcon work\n");
+		dev_err(charger->dev, "failed to initialize extcon work\n");
 		return ret;
 	}
 
 	charger->extcon_nb.notifier_call = rt5033_charger_extcon_notifier;
-	ret = devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
+	ret = devm_extcon_register_notifier_all(charger->dev, charger->edev,
 						&charger->extcon_nb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register extcon notifier\n");
+		dev_err(charger->dev, "failed to register extcon notifier\n");
 		return ret;
 	}
 out:
-- 
2.39.2

