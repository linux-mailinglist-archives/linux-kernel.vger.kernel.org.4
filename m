Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2AA607A51
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJUPQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJUPQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:16:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF7427212E;
        Fri, 21 Oct 2022 08:16:37 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LF99ET031173;
        Fri, 21 Oct 2022 15:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=w7DOAZ7bjYd5DlCK+vTzZ8rrvZ0nNvNBR+CY5uDp6Lk=;
 b=JVpR8N+IRvPmSCCKUh6dCI4r+99Chi5ys0rmn0xh9CkzOjwzgn127GHaYvm7XY/X8+30
 GNmdVpLOFttqnnXNjeot56OOoRMZqoZK+U+I9odt0ywBvwrm3JjQPDKudEkACkyqAwie
 ilDo1Ol6fH8JDgUJbe5IFCfsenSbUZrVuhnwlyWGzOrbrE45NBbXwq977l9MQW2EDIwa
 AmMJSxaWJem5mpQZTXwnW1RStu/0D6Qw3xfH+CzySUNr50EM2vHpyZYfKDL7glof3QEj
 mGhDn+pyQTTvM/nnAt0nU2ndxOs5XUjJXI9UgV8hQXNDo3zc/mN4eM0SW27IGFLtXfwB BA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kbw7dsedq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 15:16:14 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29LF5IBV019500;
        Fri, 21 Oct 2022 15:16:13 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01wdc.us.ibm.com with ESMTP id 3k9be2gvd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 15:16:13 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29LFGCbo47120718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 15:16:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 533D858060;
        Fri, 21 Oct 2022 15:16:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA15D58058;
        Fri, 21 Oct 2022 15:16:10 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.163.86])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 21 Oct 2022 15:16:10 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net, andrew@aj.id.au,
        joel@jms.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/2] dt-bindings: watchdog: aspeed: Document aspeed,pre-timeout-irq-us
Date:   Fri, 21 Oct 2022 10:15:59 -0500
Message-Id: <20221021151559.781983-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221021151559.781983-1-eajames@linux.ibm.com>
References: <20221021151559.781983-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ws9Ti4BoPPa3Tw667wsCxzljzGpSvnbA
X-Proofpoint-ORIG-GUID: Ws9Ti4BoPPa3Tw667wsCxzljzGpSvnbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document this new property for the pre-timeout interrupt.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
index a8197632d6d2..81d2c35ca7e3 100644
--- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -40,12 +40,17 @@ Optional properties:
 			specified no external signal is sent.
  - aspeed,ext-pulse-duration: External signal pulse duration in microseconds
 
-Optional properties for AST2500-compatible watchdogs:
+Optional properties for AST2500 and AST2600 compatible watchdogs:
  - aspeed,ext-push-pull: If aspeed,external-signal is present, set the pin's
 			 drive type to push-pull. The default is open-drain.
  - aspeed,ext-active-high: If aspeed,external-signal is present and and the pin
 			   is configured as push-pull, then set the pulse
 			   polarity to active-high. The default is active-low.
+ - aspeed,pre-timeout-irq-us: If aspeed,pre-timeout-irq-us is non-zero, the
+			      pre-timeout interrupt will be enabled for the
+			      watchdog. The interrupt will fire the specified
+			      number of microseconds before the watchdog expires
+			      and trigger a kernel panic.
 
 Example:
 
-- 
2.31.1

