Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7276D312B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDAOD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAODy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:03:54 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D61BB45E;
        Sat,  1 Apr 2023 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Aspgqd2CQUgGC6jhO6bVKbJh3b17oUccwUnqrYvry14=; b=l6SufDvpkl9yE8WeR8MCi53qAJ
        DT1Xt9qRWdXDjc9WLSPsreYLo4vz2pxZk2YLxe57g4hT9CM99TtJpXHrRxa+V5Vsq1B/Uj4q+F143
        fzG4iJqOxOX7xxauiR1prcnI6XVn4YJr0Yk9Wsw5kykrD4I8dkVItKSrZjKFTtee7WoJ2KgbcpdpT
        Ex81BO0YMWjT/bqOKgPji9XbeqYft+XqF5HVwCBgG7l4xe/TZn+PAbvQRpAGacLLOWUb5lfJ6+gj0
        o6a0wAD/OYOl9feCvRwEvAKh66QDnT5jl4+Lmg2gf8Lk3FmIuOxfXiAUNLRTgBsjoAIP/NfeaAthU
        kKT2h9aw==;
Received: from p200300ccff2d4a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2d:4a00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pibpd-0006fe-Bj; Sat, 01 Apr 2023 16:03:49 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pibpc-00E73O-2m;
        Sat, 01 Apr 2023 16:03:48 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@kernel.org,
        Tony Lindgren <tony@atomide.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/2] dt-bindings: omap: Convert omap.txt to yaml
Date:   Sat,  1 Apr 2023 16:02:46 +0200
Message-Id: <20230401140248.3363674-1-andreas@kemnade.info>
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

 .../devicetree/bindings/arm/omap/omap.txt     | 185 ------------------
 Documentation/devicetree/bindings/arm/ti.yaml | 157 +++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 158 insertions(+), 185 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ti.yaml

-- 
2.30.2

