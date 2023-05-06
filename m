Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4DC6F92EA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjEFPzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjEFPzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:55:08 -0400
Received: from sonic308-18.consmr.mail.ir2.yahoo.com (sonic308-18.consmr.mail.ir2.yahoo.com [77.238.178.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EE614912
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683388504; bh=y7nBXmAWn5fuyd+W51PTlojU0wcY54lQ2u9CMVZDNDM=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=FSXHaszpe8+R06HwaygqEkYEfX7+Iq7O7n6qn401LgxnRVwHb1+xIfLh5qEYPDOU500F9JeVBHsN2dO5/QmPM9U60HdeVN/FsCZ1yMmrVSXrxuDkPHQs94sS1FXZHur9YokW1kBz7lgeyoOC79KnhRvi51qhpSheIbfmx3EiPYKAynpgp96N6n5rPkc0zZgI9JtY5hKAljWu5uYhIJ7NLKyFPqzm3Ko8rRQTaeHGcn9/XrJwWWpHp3fSIBfmYISA2Zpbm5d56OZWF0bzle3pm5OaxtG9QVxrGY8DVqy/qum6CueZ1sfxUpvmAg8DskyxHOV6rG/Me1yyBlCk14IuHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683388504; bh=2c79bSUIPeqc9Dq8xpVCJZHfY2WUKKcDRxbkbXTnXMh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=J69PiyJF62vvD999Ey8vFKY8WFjIi9+CLn+V4SJiH/PivN71Z7iPj/e8jiovsH5zoLJ9Zb074mb4Q5M964OivqGs/cV/nZEDG91JhDpNqzqwUznqRHeGHDv4pH5/C1j/Q5SFNi5CE7ynT6v2/ZxDDWOF/rIX/biFcDwjnTtYUZgVDtnrjtpNAqeD8LWZmJIUZYaSxS6YFLveoR0evunlDzAnsrmKbkUdX8BhZs/GRhPuIwccqK7qMVIc4Ac3h3ZUQl260IgpJjMtJXBhEbGve1sDbhubv8CNhFub1G6uviYeD0TPC/Ubbvih5AJATt2lOo/aY295bJlRJ1HeeSkmzA==
X-YMail-OSG: 6OfztBUVM1nY7FVNWl5VY.t1.2I4VdE1d395fhfkyug2dqm9QCw7tUDSlJdjQ5P
 zGLLwixQU69lyc6KJWoRhRLwsIdlriUsma13st.MTbQ_kyYcnzWZDK0czMotKVuR4eiB2eXnheCa
 Q6OnrWhwaPM2ezGXpYK2DwVR9jinKADglvT_GnTk9HeCnRJO7h32UMfk84oTegm7xMRlPsFwH9H7
 OPA1SWOKJm8tiG3OHIVLcJ5NtWRsDCie6H8O_JUVAe.Gi_7MdQxSI8HIKmo1yHgWG3SmOtRwOwEq
 PQ_JumWVBcc4CVk5r3Md_YYZp1DX_pyI88L3oZVR5k6LH9FtwrxQIJi_71R7K6GhnOg516JsMdJ1
 0KJ4zS1rhuS96d0oMLnL3_3CIlojDfNcnRB_6nsScXrlgtInfGiZ7GyjnIp6MzcFBZlPCfmhtAtJ
 siVnKuJotcM0MJzbX6Bfk2JLjL_7Kd9XHHswdSiei_Q5DDv2srbpNc9tgnHBLnPIRHYp1u7eXFSH
 76OnWUoEGw5Z5vSUcLHE3VftdXd3_53Ku_fmYvt.fI.vM4BRQCPjE75URHAxbbuqF_EArQaLtNYB
 _8NNq0PiXVVg5GG_eLYLBOWKMYHWvdZ2lwBjj43ESRmDWiq4UaN4HWRI5dfCiVGeudg7stL_7q7a
 btk9YNfVuUKWbXiUS_qM5Xau51mihhAgjIpC3.k5hQ_2a8gNes.C.AEYD22Zu14JiKI7E4rSNh_A
 rSV4dMHOcahqTNqLn91dqUMhFNsejg__f4Rb.Jtp1kAEy706epOuZgIoit5Rv14ZGPjYl3LFscoY
 TAqmWOrPbmNRcaT3Kgmo5GJt4Is15E3Kf21qJcQj5l0XVgNPpgbRkr_UDmSkNsAyz4GfllLpVFOW
 NZWkVvafFv8C8rnC6J9oDlDAm_K9Q_cxhg2BB.YNdHGU7iHeeWnzghi7WVlaYEL_ennEpKEMgI8a
 qQ.83QuoX_.HTq9sCeQwsB2pH6_Hf7vitzCdxVXzwL8j0uQpAbL22UZGADghrbCE0.oXfx8KuPPx
 p3kdwzSkhhrRATjrJjEQcsfDlIFXawRpClES14ID1plXtOjT11uK1GQSQcnJ89_RPmqgfY8KIRxJ
 GRTYBXJeqbxqjIDripcEzMaxLtrsHxmkwpsC23gGaXWMDdWuKR4.NRn8K2uIFbX6zIDqdTUFDf1b
 s9PUwXgjg27A.HjQR.A78FM7vr6G05CHGqSVDy3.mpfb5AwIdUevelHiSh1POf_8Wd5SfqtfO2Iz
 INCJjERoKKljqwR0eP9aex3ZUX0y23w5CBRkQW4xupgPfr57qKcQI6kM53Qto_0NHUMVtI_cocEd
 Vw5vV3zcZtBrenvjEiP4Q4jRyQ1IyleM1EI_dfTK3cRoTV5ct0lZ6e1wzt4h3KpyBtfJHIf3Hzfs
 6EOjeBO8nekXahq3Zd2UIjGKwi4gyslgVbzabiwU7LbR_4goNQV9WmwaVPXJjqmCB8gKJ3UfXrMU
 rHf2JmRhKR65fPVcNKjEe3FpDP5ynuFEoZP27CX6m0VjthFrww.tPUJjGW2dWGDxn2YIunDAicto
 riDHm9sRLn5ih9IV3i7LI5Uak2AcRoGEhuRy4ntgdRwBjRav6vqysjXnK3vDOcTKMTlqd7_gRo_7
 tamHsAMmDpZ7Hsy7Ld27_jPRoEkLvcUrziyEcBCka3UK2uUzDM9oeBa_3oIzW2L4ri9NXjfKTTp.
 nmbhDOIbReSpf6j.PU4E4NrLON3XuBX_Iboq71YKtScB0r.stZzPGZYwEDZlWWWluWwk._8Eg5wh
 orEomx.njNsnD1vbmFpU12OBXhhCAhnRAZoMJNYN_XGhe1kT1S7.Pkcs6x6FOkBsK5Xu71V6bQOF
 KkWVc56Eh6tCxZCj170PHjdti7UIXOphyThNPFQmZXZ5Cn3w9lEsSGPYroOmMo4kAgFmeHNZTo.Q
 x5nMr1HSf_YyfZ4DXIwmnx..H7pfhXjIAKzL3HGfhS_9DQUbjVl9fOD1Jky_pDD7LmGWLzFKd7sW
 vnW0v6J_mjmsW9mCYIFVln0pwxzg7PdnLdDeizoszuZ5KFHxHHYHi865ioPLdsmUUhe_PyKmAtFQ
 8NCpXKYY9kDm6HksCxptNhVzqzpyr_qoLTAouze2J0QbFdUXfQr2LZxrCe8.tl_UdUJDa8ajJNbi
 ahfH99WszOWSv6vi16WOqsemdGqK29roRUiiM8aRtG5JDb80fKU8eR4ld07GKSr.0OyXRXzcPj7f
 .Uhtv8_vTpyB1.RahxG568uLrxC5mgbs_s97oTobksRulGJ74i6VrubWUc2rqPkDTzBYzfMA9z5M
 CvXjRbVpVbuzZMrXa0WE-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 9852f431-f38e-4c96-bd14-9c7684c2562e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sat, 6 May 2023 15:55:04 +0000
Received: by hermes--production-ir2-74cd8fc864-s5qrx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2f796affa0781b2e3002453351a4dea5;
          Sat, 06 May 2023 15:54:59 +0000 (UTC)
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
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 0/8] Add RT5033 charger device driver
Date:   Sat,  6 May 2023 17:54:27 +0200
Message-Id: <20230506155435.3005-1-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230506155435.3005-1-jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the charger driver "rt5033-charger". It is part of the
multifunction device rt5033. The patchset is based on an older version by
Beomho Seo of March 2015. For more information on the history and setup of
the patchset see the cover sheet of version v1, there is a link further down
below the changelog.

Changes in v4:
 - Rebased to next-20230505
 - Patch 6: Towards the end of the patch, where getting the extcon device, the
   procedure was changed to first get the connector node and than go one level
   up to get the extcon.
 - Patch 8: For rt5033-charger changed the "extcon" phandle into a "connector"
   phandle. Updated the connector property description (in charger) and
   examples (charger and mfd) accordingly.

v1: https://lore.kernel.org/linux-pm/cover.1677620677.git.jahau@rocketmail.com/T/#t
v2: https://lore.kernel.org/linux-pm/cover.1681646904.git.jahau@rocketmail.com/T/#t
v3: https://lore.kernel.org/linux-pm/cover.1682636929.git.jahau@rocketmail.com/T/#t

The result of the patchset v4 can be seen at:
https://github.com/Jakko3/linux/blob/rt5033-charger_v4/drivers/power/supply/rt5033_charger.c

Jakob Hauser (7):
  mfd: rt5033: Fix chip revision readout
  mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
  mfd: rt5033: Apply preparatory changes before adding rt5033-charger
    driver
  power: supply: rt5033_charger: Add RT5033 charger device driver
  power: supply: rt5033_charger: Add cable detection and USB OTG supply
  power: supply: rt5033_battery: Adopt status property from charger
  dt-bindings: Add rt5033 mfd, regulator and charger

Stephan Gerhold (1):
  mfd: rt5033: Drop rt5033-battery sub-device

 .../bindings/mfd/richtek,rt5033.yaml          | 113 +++
 .../power/supply/richtek,rt5033-charger.yaml  |  64 ++
 drivers/mfd/rt5033.c                          |   8 +-
 drivers/power/supply/Kconfig                  |   8 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rt5033_battery.c         |  24 +
 drivers/power/supply/rt5033_charger.c         | 728 ++++++++++++++++++
 include/linux/mfd/rt5033-private.h            |  64 +-
 include/linux/mfd/rt5033.h                    |  10 +-
 9 files changed, 993 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
 create mode 100644 drivers/power/supply/rt5033_charger.c

-- 
2.39.2

