Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538FF5B80FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiINFb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiINFbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:31:21 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017686C745;
        Tue, 13 Sep 2022 22:31:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2105F5C0067;
        Wed, 14 Sep 2022 01:31:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 14 Sep 2022 01:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663133462; x=1663219862; bh=mT8Oy9Arlp
        TGJR2YdOtkz3D8RzCOFiwRQCLe8Tog5gU=; b=q4fUvYElSSymRhlYxHC973G/E8
        IZRRGwkUTKR/lXBdg3ZW92+XZuoGlBCd/cD/HKKA9X0CB85MvoGbYd7UySG/3rDM
        r5CFuc+pzdwJQkeQSDH1WkGOQGsiWj5PErzDoPugWbwS7THDYtT14U+ee2ldNiwi
        6e880f7QBvTEIafMHEUXZDL9bBdXJdPdFNEPDbWwbFy/YIFxcYLqwygWvEuWxexN
        QkclBNbPzLBgVBefoENPFa0lOYEaUnDZJmsBCqX6Z8DDPbNeT8tw8gL80vOeDUM2
        LfBIurqBRVnSJfaZsWOItu3V5LSXOJPqp2MS+m9OOv7vidUhmUszA7H9VB2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1663133462; x=1663219862; bh=mT8Oy9ArlpTGJR2YdOtkz3D8RzCOFiwRQCL
        e8Tog5gU=; b=vEB0w/FZ7dkHW3p87IheGNgqZWDVtAfMWHXGqYZ+CTCORtA541D
        IU2HkxaqYNfZ8oZ85N843/QnKh4G2NUchTCxOb8ayeou4oocTLia50oEkRJReb55
        LjXwIN33cGXcyabCxCU+KFeiySVSyUjJOCX1xRk+XV+EvUB9eAf95/EKKJq7CZKu
        eXxD0eLtjdMYoC9o4LSGNv2blx0Yo+lUM+ff0d3uSELbCSzBpYMlAXsHxCQXaVJE
        ANJ5xF4ODMlShP1Gvs8EhLNIf8A5/eZewj2N5psw8TCOV3isA2GjJ+c+a3aKeZnc
        YmaT2tvx1mmcmvMX5H4XwSbLg+Yh0uftikA==
X-ME-Sender: <xms:FWchY26rusUm6xQt7jLh2r6zFhzgRcih1lcSvd6e-fCXjuQ9xjSfhA>
    <xme:FWchY_7t3ZuQS8aPLPHIk5KRQw8g07JQsnXPk0twh0Ir3cF36w9z_WvgIzRYeAjaK
    Ja5Z2kr3NIYwIxvpIo>
X-ME-Received: <xmr:FWchY1fh2GLxBR39DMIwrg2XvUkHNaaViF6NY1ECXTRUkdMTbYtiFSdSkMs62xRNrVy--xM2Iaa7kU0BjW_TaylLDUP2I_e6mQpmOZ5GPRI_MePRPPf8Tn5wNOHxt2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduhedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeforghthhgvficuofgtuehrihguvgcuoehmrghtthesthhrrghv
    vghrshgvrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepgfekteegudffgfdtvedvje
    ejffdtgffhteefgfeuhefhleejfffgfeeuueejleffnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrthhtsehtrhgrvhgvrhhsvgdrtghomh
    drrghu
X-ME-Proxy: <xmx:FWchYzKI42PcGOmZuoQ84rZDIet4VUwtf80ML6sIAfia3lS93m3N9w>
    <xmx:FWchY6KtmRqArsuDkNp49IzVF-Knm6OOnEJzP-xJTswo89Sf6jMLww>
    <xmx:FWchY0wWrXPOE8XXmHkkxEx0M93JTmQa3FkUp7JqbtQ6UsG3k4z8sw>
    <xmx:FmchY5_N7r2f-K_RIdbwDlerDedM-sUJrJRIbRu2cs0g20leW0MaQw>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Sep 2022 01:30:58 -0400 (EDT)
From:   Mathew McBride <matt@traverse.com.au>
To:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mathew McBride <matt@traverse.com.au>
Subject: [PATCH 0/3] hwmon: add Microchip EMC230X fan controller driver
Date:   Wed, 14 Sep 2022 05:30:27 +0000
Message-Id: <20220914053030.8929-1-matt@traverse.com.au>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip EMC230X (formerly made by SMSC) family of fan controllers
provide PWM control for up to 5 fans (in the EMC2305). The EMC230X is
capable of maintaining (closed-loop) a target RPM speed through PWM.

This driver has been tested with the EMC2301 (on our Traverse Ten64
appliance) and with the EMC2305 demo board (ADM00879).

The driver is by no means complete, for example, further work would
be required to support the different PWM output frequencies for
voltage-based fan speed control. (So far this driver has only been
tested with direct PWM capable fans, like the 4 pin fans found
in recent PCs)

The emc230x driver also has thermal subsystem integration which allows
the emc230x-controlled fan(s) to be used as cooling devices.

Mathew McBride (3):
  hwmon: (emc230x) add Microchip (SMSC) EMC230X fan controller support
  dt-bindings: add binding for Microchip EMC230X fan controller family
  arm64: dts: ten64: add configuration for fan controller

 .../bindings/hwmon/microchip,emc2301.yaml     |  83 +++
 MAINTAINERS                                   |   7 +
 .../boot/dts/freescale/fsl-ls1088a-ten64.dts  |  43 ++
 drivers/hwmon/Kconfig                         |  13 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/emc230x.c                       | 587 ++++++++++++++++++
 6 files changed, 734 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2301.yaml
 create mode 100644 drivers/hwmon/emc230x.c

-- 
2.30.1

