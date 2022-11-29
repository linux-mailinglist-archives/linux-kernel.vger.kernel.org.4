Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBD663BEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiK2LRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiK2LRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:17:37 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691DFD50;
        Tue, 29 Nov 2022 03:17:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669720643; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=NzHdiQtyKF/lIeeCj234BMnDVnChfQiZ4TMMUtRxWQ/hyZoV5gAl27aNoWKxRwnbgyQ/fCQzVgT0C6PQP97Yr8TUS7luOlo+GHN5u0s+6f5DSQyqi6uQ+AVFLFGvQOHqh2ZAG/0m7uS06gSfk1UrvbaE+3PxK2nr5HzEMHnIc04=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669720643; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=wuTnTkxy7g0Gw/TD9R0MRukx2llcST0fSdcHE1S5IGA=; 
        b=e8S+Dgn1tw8kEdp9CuAn04PRXtg3P1tIDdpSLxD11tZczlxy3m4A+/uUKIc0Jb+G6VEHTrxzHCm51QJ46x3YrSZlgDhU/KzLrM2rINd/TGcmj+JXPIv5OcGbfx6L8iB6/1Uym9hhGT1gAzAYS7k6AcvfkoIVXOX8l7FhDYr0mY4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669720643;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=wuTnTkxy7g0Gw/TD9R0MRukx2llcST0fSdcHE1S5IGA=;
        b=g0PWVxHbZb0J/8V1o4Y1dd0u14cyZz5T6Fd5s7vZ9ILfCAcTajdu+7WZCEeiOYCv
        mxMqzgbP0VuYoAPw7NFgjCJ7tQYp191JpmEI5rcl6bVAG/ZIWXPHNDerQi1on+uTvee
        thMd9BQuaHfy734PYvJOAETCTQuQFMZwd+AJ4UHs=
Received: from arinc9-Xeront.lan (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1669720640742618.9209820853164; Tue, 29 Nov 2022 03:17:20 -0800 (PST)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH] mips: ralink: mt7621: change DSA port labels to generic naming
Date:   Tue, 29 Nov 2022 14:17:11 +0300
Message-Id: <20221129111711.2739-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the labels of the DSA ports to generic naming for switch ports.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index f3f4c1f26e01..1a601d7c73d7 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -357,31 +357,31 @@ ports {
 					port@0 {
 						status = "disabled";
 						reg = <0>;
-						label = "lan0";
+						label = "swp0";
 					};
 
 					port@1 {
 						status = "disabled";
 						reg = <1>;
-						label = "lan1";
+						label = "swp1";
 					};
 
 					port@2 {
 						status = "disabled";
 						reg = <2>;
-						label = "lan2";
+						label = "swp2";
 					};
 
 					port@3 {
 						status = "disabled";
 						reg = <3>;
-						label = "lan3";
+						label = "swp3";
 					};
 
 					port@4 {
 						status = "disabled";
 						reg = <4>;
-						label = "lan4";
+						label = "swp4";
 					};
 
 					port@6 {
-- 
2.34.1

