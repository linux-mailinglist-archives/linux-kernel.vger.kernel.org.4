Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F956D8375
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjDEQTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDEQTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:19:22 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BF3134;
        Wed,  5 Apr 2023 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=km6mpQ1Um3jlOO4FLcCYa1cMiZEF6yyn6QqpA+XaoIM=; b=xtESDoRXBgCukBKOnj4Wrl50Ey
        aRUaP0bvQOr1jrjbJMXUKUBsm0l++p5XblmaTb+50R8/g9LePV88SR+LS61EBvoO++r0buVupysbn
        LfuJIEHGqaMGs4PMOBBm5Es84TpOEiNNqsGBiHg8DQe6n1X08eehYgNicwWA8DM1ys1H8W5+Qp49o
        Z1jLR0oIVPDAu2nDYkkpxrfwApYJhaDTH9k6f5CPtGZylHMURS35T7iRyZcTXSM75/5zWROPlnX2X
        mLkWD/LAUZC4K3OJRmG+FGDEzBWn/bI7ANnljQgt5VSpjiX1HhpYyjThHql+iZR3YYa/wtcF/QZff
        wx17/Z8w==;
Received: from p200300ccff0b98001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0b:9800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pk5qn-0001u6-SG; Wed, 05 Apr 2023 18:19:10 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pk5qn-00017p-1V;
        Wed, 05 Apr 2023 18:19:09 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tony@atomide.com, andreas@kemnade.info, afd@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v6 0/2] dt-bindings: omap: Convert omap.txt to yaml
Date:   Wed,  5 Apr 2023 18:19:06 +0200
Message-Id: <20230405161908.4312-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert board compatibles to yaml and add the new yaml file to
MAINTAINERS so that emails are properly distributed

Changes in V6:
 - reflect the rename also in the file header

Changes in V5:
 - renamed the new file to ti/omap.yaml

Changes in V4:
 - fix order 
 - re-add dra7 to .txt to have it sorted out later

Changes in V3:
 - update MAINTAINERS
 - remove converted stuff from .txt

Changes in V2:
- renamed file
- fixed gta04
- added Openpandora, Epson Moverio BT-200
- drop example
- remove descriptions if just reformatting the name

Andreas Kemnade (1):
  MAINTAINERS: add board bindings list to OMAP2+ files

Andrew Davis (1):
  dt-bindings: omap: Convert omap.txt to yaml

 .../devicetree/bindings/arm/omap/omap.txt     | 152 ------------------
 .../devicetree/bindings/arm/ti/omap.yaml      | 147 +++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 148 insertions(+), 152 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ti/omap.yaml

-- 
2.39.2

