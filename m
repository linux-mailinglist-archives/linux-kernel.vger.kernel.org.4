Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34526D6E80
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbjDDU75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbjDDU7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:59:47 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47B44BF;
        Tue,  4 Apr 2023 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lCv1XD+1utX/UgiXxL0j2fq6JESpOlGaFtsH9EqSVZw=; b=jgNolpKvXRypgk90qu6HKHYBgN
        RZL3+jwdAv+MpPSQZeGkXCde06Z/uCE0IPmFxVvNO6dG6xtO5AkmgAjlqkBh+0jrRFz3ErMTLTSdI
        6B6wu7qq46sPPzVwhY0+hAaz9ooFe6Z5R9owCqZDtvTVgfOnBGmmgPV/+CGCGGQ5QxkjaSjCslurP
        5/e6wdSR8cUMSYX0r6N+tTAHH/KVJS+qB9fI06XmTecSOQL5di5I2lfAXs+H3SbLXN4/NlMk4lcG0
        vCfqjZb6/VTiErYQdLA0T0mt/Da5eOHqds8+JiEesQo9KwlSxorjJFAyG1eECxfTkbY3MZItWfUCF
        g1L+AbYg==;
Received: from p200300ccff1e1f001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff1e:1f00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pjnkg-0007tn-9A; Tue, 04 Apr 2023 22:59:38 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pjnkf-00EuLT-2m;
        Tue, 04 Apr 2023 22:59:37 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tony@atomide.com, afd@ti.com, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v4 0/2] dt-bindings: omap: Convert omap.txt to yaml
Date:   Tue,  4 Apr 2023 22:58:42 +0200
Message-Id: <20230404205844.3553159-1-andreas@kemnade.info>
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
 Documentation/devicetree/bindings/arm/ti.yaml | 147 +++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 148 insertions(+), 152 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ti.yaml

-- 
2.39.2

