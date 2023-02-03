Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474FA689786
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjBCLOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBCLOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:14:36 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634FE79639;
        Fri,  3 Feb 2023 03:14:35 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B67FD1C000F;
        Fri,  3 Feb 2023 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675422873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HAMONlr9R1WXauSk/Wj92zOzmiMIj87cwyrNJBK5Ezk=;
        b=A3ZfWhkCsAD4ulDqxrzeWbibM3BdocWhNXDIyJM9oR5wq7EKn1P7f/+wwuvj9xwv+O66PA
        2zcQydBGBDSbJMU//fm+piM5NsXyWq8mJbQRjixdQxDlRSxKnqoTXtlxvxLJ+ouiGRGPCe
        eZmkKF2O2K1phXQnRtNZkRyrPGfdAS1Nv0JIw8ONeOZWkTqbuAVdcHfUpwY2n+ItSubbhu
        tpFZxGIvtVSOkIcK6DWkjuVw93Z/yp+NX790IGNELwf1rdNO68aPJ2MYhh9+3Z8kgymtFQ
        DTDzv1u3dRafXpCqZqh2Jijr6CoUvTkBFQyLFrmuyfLo8nxtC5Rb01E+JT7icg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/3] Add the Renesas X9250 potentiometers ASoC support
Date:   Fri,  3 Feb 2023 12:14:19 +0100
Message-Id: <20230203111422.142479-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Renesas X9250 is a quad digitally controlled potentiometers.

In the audio path, it can be present on amplifiers designs and it can
be used in ALSA as an auxiliary audio device to control these amplifiers.

Best regards,
Herve Codina

Herve Codina (3):
  dt-bindings: sound: Add the Renesas X9250 potentiometers
  ASoC: codecs: Add support for the Renesas X9250 potentiometers
  MAINTAINERS: add the Renesas X9250 ASoC entry

 .../bindings/sound/renesas,x9250.yaml         |  60 ++++
 MAINTAINERS                                   |   7 +
 sound/soc/codecs/Kconfig                      |  11 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/x9250.c                      | 276 ++++++++++++++++++
 5 files changed, 356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,x9250.yaml
 create mode 100644 sound/soc/codecs/x9250.c

-- 
2.39.0

