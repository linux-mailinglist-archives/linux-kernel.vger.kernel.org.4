Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D058A67711F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjAVRda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVRd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:33:28 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD102D56
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 09:33:27 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 98CB51BF203;
        Sun, 22 Jan 2023 17:33:24 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] scripts/spelling.txt: add more spelling corrections
Date:   Sun, 22 Jan 2023 18:32:56 +0100
Message-Id: <20230122173256.52280-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current Debian lintian tool flagged several (more) spelling errors, so
add them so they can hopefully prevented in the future.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
As requested in https://lore.kernel.org/lkml/CAP-5=fX1-3ZnXk8G2fB0q9F3MjjA+zWWm1LbuYGc5nL5v3bXYg@mail.gmail.com/

 scripts/spelling.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index ded8bcfc0247..d53627fa9b81 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -65,6 +65,7 @@ acumulative||accumulative
 acumulator||accumulator
 acutally||actually
 adapater||adapter
+adderted||asserted
 addional||additional
 additionaly||additionally
 additonal||additional
@@ -122,6 +123,7 @@ alue||value
 ambigious||ambiguous
 ambigous||ambiguous
 amoung||among
+amount of times||number of times
 amout||amount
 amplifer||amplifier
 amplifyer||amplifier
@@ -287,6 +289,7 @@ capapbilities||capabilities
 caputure||capture
 carefuly||carefully
 cariage||carriage
+casued||caused
 catagory||category
 cehck||check
 challange||challenge
@@ -370,6 +373,7 @@ conbination||combination
 conditionaly||conditionally
 conditon||condition
 condtion||condition
+condtional||conditional
 conected||connected
 conector||connector
 configration||configuration
@@ -423,6 +427,7 @@ cound||could
 couter||counter
 coutner||counter
 cryptocraphic||cryptographic
+cummulative||cumulative
 cunter||counter
 curently||currently
 cylic||cyclic
@@ -627,6 +632,7 @@ existant||existent
 exixt||exist
 exlcude||exclude
 exlcusive||exclusive
+exlusive||exclusive
 exmaple||example
 expecially||especially
 experies||expires
@@ -838,6 +844,7 @@ integrety||integrity
 integrey||integrity
 intendet||intended
 intented||intended
+interal||internal
 interanl||internal
 interchangable||interchangeable
 interferring||interfering
@@ -1023,6 +1030,7 @@ negotation||negotiation
 nerver||never
 nescessary||necessary
 nessessary||necessary
+none existent||non-existent
 noticable||noticeable
 notication||notification
 notications||notifications
@@ -1044,6 +1052,7 @@ occured||occurred
 occurence||occurrence
 occure||occurred
 occuring||occurring
+ocurrence||occurrence
 offser||offset
 offet||offset
 offlaod||offload
@@ -1055,6 +1064,7 @@ omitt||omit
 ommiting||omitting
 ommitted||omitted
 onself||oneself
+onthe||on the
 ony||only
 openning||opening
 operatione||operation
@@ -1334,6 +1344,7 @@ sacrifying||sacrificing
 safly||safely
 safty||safety
 satify||satisfy
+satisifed||satisfied
 savable||saveable
 scaleing||scaling
 scaned||scanned
@@ -1614,6 +1625,7 @@ unuseful||useless
 unvalid||invalid
 upate||update
 upsupported||unsupported
+upto||up to
 useable||usable
 usefule||useful
 usefull||useful
-- 
2.39.0

