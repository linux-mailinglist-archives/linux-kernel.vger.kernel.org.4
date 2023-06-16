Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1507733B64
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345452AbjFPVLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345430AbjFPVLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:11:23 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCB3359D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1686949880; bh=GNws8JqhI1syhONxm9VFF5xmbPy95z3gs9cgYJvfAXw=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=lRPkFImCcmJBL/XyEaTF1icEXm5P/I+XcuVf6vS6cPQfgt3qqtFGgJaBFBZRT6u8RCmgxOHknDl+V33ncl3BwJtBDbMPNzybApwtJzsF4mRCxfj9jCDP6MBznW4Ll0bs0VnC2fi3ff43vxdbXi5iwisZTbzTJJEj4dmtUo+Gxox05/PSuEteVahahz6zucrsvFoM2BtUmhmNhRL2kxBuDv+KAILstxVmrPU2gE5LZx7skka52RAfM9esyyoFIe/Cc2gQYu6b01QNVLlKH+z/2qV2hANRWjqJp0x3cS352pKSEpY4AHmjvg3c/WFBAI64BuT6u5oGO4HiHdqGERDBzA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686949880; bh=INBTJ5UOPVoKkiBDPrIgd04zR/zK15ksy6pKMr72xsh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DZYSmZkRrpK4h7Px24yBydwLIbwTTj8bHMuOpV74ERcxv/pDbFp91K/LCH6Mggr7+DQYjj+b76Ap90NLEZw0WEtz3+V2QeftWMPNK0926L/vHMNzb2Icv0JKZMmXAy94E06EyDJXe3Egkays+p362+NMm+4bA8OGV7a4Ql8btqqA2Yke67hAGHByKbvzxZmEPIagU6JJOuLw5NQK8wQbxB8D6ax12nvM4azt7Sl4gyoVQ01UfTbc7iSgED8Gnh1Uot7OktxRsAspQzavxnWcH06ZEPEEOwH2/a8XHZlUOgrtDawBXFiJkVr3x9spML1s1QnTVbDYuDYletR1m6gdYw==
X-YMail-OSG: TU3BL_4VM1ndNiGo.VTvovAWBLDENUB4DeHYOGNbYrbj0TjThkxZYXBqfhKKTVx
 pAADlkVsF08mKQkkQ2a1oLm_VGlY7gFjki_QUDL4dHdTa8GvF7pyVcNi42u9e5fXMoM6yilyiYag
 lod8V.V.xaLdy6tMJ8FmRvl0LI0T_u8SkE0BS8XUhNrw0BevDtuuwmITD7E00gM1Hr7JiJ56hZmf
 s2XAB_0R57eckv5HcdPk.cNh6mBiVBy2_irBOd6dGnfPxrkuolPo4EpExni7gIOtsxnDygdM8RnE
 kpd3Cgj74i9P4IDqhkj2kkZgWxPgTQ7s9f0Ym7bGAkZTU5Ym8wrq4bq8D45I9OTlTTp6ZuXAyCl5
 UFNJ33VSZ39pwy9MilXHGIe.vLxiyUPRmiR9VxwvaA2wX1FS3as7Q761i7YIkZpH4c8VtnXHC618
 Rsu3Z87ANu8ClY3rqsn95.HkIByM.btxrPyhKETljrfLoHSONRbuYi5cGGkJpRMXf2gJiKSlRBtu
 MFRRJgTFyW1Rot5Kz1mXHOTB9MBw3UrpIwMVVgJLsD_doB9uZXFWINn4MHEnR_bPnGcMkeqStQCs
 3meOFjNiKzRTvjapjFEGzLc026KOWbbw.4BDi2qeXdsxSGrGzMXyuN4Ny_lZF991LafHPch_got0
 wQ1ee2kfmKKXLojjQ7T_YH4Fl4mzeCnmIKpx7wiSy6xe8X565F65ETbd_8kr5jz9Eo8Pl4hZ4mpX
 P9Zqx.aRKpPOy6M_o_RSFWFRDj8TlgHa7boaNeFietMBGzToGUZje.Xzv09P4XpeBmbcEC0Z1OF0
 rxXQNd2AFjyASkny5sZ9OKn9jj1_EgIsl.uCh0dhPrm3FcUt2WhVMJkfgXc1dxYbNZ3IiigUrhs.
 WYbT.8sO53evYGSJTQTOno1eRgrLbizKvvoSkjYkMCQPYqZu3rBhHzMljre2DuMs.gni3YYXxtam
 wCpBgPGc.8mmmIZyG9Y04yypIJiMcWCv_v4U3Lg49DJE0Xl5jFPcB1rH5twg_lLw308xFBO6vu_b
 hpSVVSqVOd62lhYr5lZCVapzQtRzUS5lp0pbY7ruHKe49fjBLiT5pt6zU86_ACsnmNjtqeRZHxYE
 bmiaaUB5le9OBaXenvit3uMMQD7PCBVVmb9c41_o6stZxzBv2Ek1ZPjEJO17jPzXNe4d2mlIrquw
 Vp4Dk5LmSiyaSNYt26V7Qdc3WhaZA1NWsCdFIEsk9OXGmoAlZMKDYWgNOUfbmCJ0C0XiyoguqHn7
 JfDfifJvScH6oOmj1yUE9SfZkWwnRpMMwHeP3xzrKb4AfVeH8c2SjqAg3KsJidZelUm8cT8ddrmm
 DWnIrvyjTEm2zbo3QJLG7jt3aAgXqWYECuJ8vG3PYFLYOEwpe0Tgb97pqniJCOpWkoOib.D3zlc6
 4KlUgJ8cwoW6XAv7YciHv1UBFZQ7ZffmKxATCXS1gENI2vdnrJSqBBeGJdz8NzCgPUp2TR_C_eO8
 9Tf0p4TIFyJV05gPMXdn2Bie80nWzKQuBvknkBeAylxlS5_7qK8_UrNYgPNQxDPMLkWbSjwEKMKk
 KrrjEylbx6ef6QcSRraccVY8m6AyW7YoSIdbtCH7W30UCDM53ofIJitTmk9DzFOrEByJR5GpOi_v
 wSb7JhPNv3Fc4sYCYCT9tWY3znLxNYhOD9JYMmPtwCT9xVcu5QfbKmbzuJX_tX1t8sDY_BGsGLKN
 _n61NRKVdKY58HvL8IHzWx9sYxAlZxCZ8cwuasT.XkYFoaVC6V96TsP2M49ejUwiOulfa2DqpocI
 XI8EBc4pi5v7JZ02Ie_epdb2nwZpZc_n7.LplFTl8M5u5LNUiQkENUrdO9VIyYVE59rNKxmzOL58
 r6jEQozMKR4IBZst1Oo3WnqP459JCY6K7vgUlq0RxYEb97VjqIVeAyEmrXAAaLRySrazcXUu_8Zf
 lYs7jMIG.dfcIiyqZptu4LMqzbz2rtPqIAlGRJQ0BjxcB0zb8MZjCWtgzgeFcokiPb3mhfuq3Csm
 YMgMa9M20n6kGpXVvPwH2a9dMNcJ1CxQQdqbfTVjq_WiZ89CBIJH7U5Ek04MBJ.kpChQdzny9ipQ
 bq.GcE8xF4DEcy0EUjSobMCzA1ktKlPtas12phv0jWVKfrcSAUrOu64xLfjhdJrxgpE.DTJ9A03D
 a2qRXYrdACYyly6bbvP6e5qbdgpXZPLcW064_V.h0GiSozwn.9smQIKGH3jvc46tstvzNwdXeNSF
 JPVWhGcMlh63TbQ2W_ImxfXC.nUNdvRCUj0OY3n6C6zeRfM0qLCjARg28XglAGTKOlMSpsPbG31y
 kubn7sBg0YxKWZV5gKQp382EOlOWdkSM1
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 50239dfa-8d14-4e9b-a02d-f9422d0bfe68
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Fri, 16 Jun 2023 21:11:20 +0000
Received: by hermes--production-ir2-7867f454fc-gg9x8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c618d34c94eed5ad1e4505ee686233db;
          Fri, 16 Jun 2023 21:11:16 +0000 (UTC)
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
Subject: [PATCH 0/2] Clean-up RT5033 charger "rt5033_charger_data" and probe "&pdev->dev"
Date:   Fri, 16 Jun 2023 23:10:46 +0200
Message-Id: <cover.1686948074.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1686948074.git.jahau.ref@rocketmail.com>
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

During the review of the series "Add RT5033 charger device driver" [1] I
noticed two things I'd like to clean up. Additionally, in v5 of that series,
Christophe Jaillet pointed out an unclean error handling of function
"rt5033_charger_data" [2]. The clean-up solves this as well. As I didn't want
to disturb the review process of the series in its late phase, I now add these
clean-ups as a follow-up series.

I was a bit surprised about the patchset "Add RT5033 charger device driver"
being added via the mfd subsystem. This clean-up series affects the charger
driver, which is actually part of the power supply subsystem. I'm not
fully sure what the series should be based on and how it will be applied
best.

Additionally I just realized that in the immutable branch "ib-mfd-power-v6.5"
of kernel/git/lee/mfd.git one patch of the previous series is missing. Because
of this, I currently can't use linux-next or mfd.git as a base. Instead I based
this clean-up patchset right on top of the previous patchset. An instance of
that base can be seen on my GitHub page [3][4].

[1] https://lore.kernel.org/linux-pm/cover.1684182964.git.jahau@rocketmail.com/T/#u
[2] https://lore.kernel.org/linux-pm/20230514123130.41172-1-jahau@rocketmail.com/T/#mbe33ab528f3d8ae136f01b13f45a9be35c0ad061
[3] https://github.com/Jakko3/linux/commits/rt5033-charger_v6
[4] https://github.com/Jakko3/linux/blob/rt5033-charger_v6/drivers/power/supply/rt5033_charger.c

Jakob Hauser (2):
  power: supply: rt5033_charger: Simplify initialization of
    rt5033_charger_data
  power: supply: rt5033_charger: Replace "&pdev->dev" by "charger->dev"
    in probe

 drivers/power/supply/rt5033_charger.c | 43 ++++++++++++---------------
 1 file changed, 19 insertions(+), 24 deletions(-)

-- 
2.39.2

