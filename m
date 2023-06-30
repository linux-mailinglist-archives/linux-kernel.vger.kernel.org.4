Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A406C74414D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjF3RdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjF3RdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:33:15 -0400
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AC7E6C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:33:13 -0700 (PDT)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.19.58])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id B505810A258A1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 17:12:31 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.199.100])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 40E57100017BF;
        Fri, 30 Jun 2023 17:12:30 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1688145149.849000
X-TM-MAIL-UUID: 71dbd5db-74cf-45ce-a709-5fcf4c19fa38
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id CF7A810000E23;
        Fri, 30 Jun 2023 17:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htesn4jFwT0TKgU+LaT+mzqfGxvxEaHATF19aJxr/0zRNCPF9jiFPbi/Oxh2Xz6TxzrjhgNiKncXWXJ4b3Hnc3v1iOoQ0dzv8/TewC7dXloFhqREfULfsm0dbU0QwlvRoDtPyawZz8UcHUbK+AdTvjQvv9C8kbeg0V2fmsrmm58Rk8ffvnv2yvIY739Gxrl79DAkMqkMMOMQz1U8E+UCAslw0hRY1q2ha5Cn+FvMmp3rQNvmp5SKCZtdQPZvAfmo7rpuQE++1pHhtD62PvM5OAJQTbax48/M0lgk4yZJ/S9rz4gt/uiY5HR7e0oYab2OWpgbFzycaF+9r0jFX6Ukgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q60tNdBmhsnchPnWNLACIYzfR/FeJ2vn169CHo43Ki8=;
 b=NOY7mFPE23mPpAZ4DcrshFAuQoCymV4Qpg29Xlt+kDE7VvxWJSHVz+AsVQ8Y6vMyCDv8XzIgeUgzG56393hATueIuoKX0OOlKbFJqEg4SUSS6fxcdwRuBd3XRtBfHfR/C8GGFv4UCkT6GbI8GhDErLwwPYfp9d9YCZahZjoXDkij2tKtrQc8GK3GJj8yIqfDIXP5QavY+QLYj6hkf0R7iculLsSet4gELdRrqSKQbCB6/dfatl6I0/bCDRV2o8dLxsDoiXZ64I5IgvgJqlQ+8WIyT1O/J5vMeEHHpgFKFmiOZ9ktn05unQ/3DisS21Md40OqN5H3WoMnqDWZnrK+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=google.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
Subject: [RFC PATCH 2/7] timekeeping: Fix cross-timestamp interpolation corner case decision
Date:   Fri, 30 Jun 2023 19:10:45 +0200
Message-Id: <20230630171052.985577-3-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630171052.985577-1-peter.hilber@opensynergy.com>
References: <20230630171052.985577-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT043:EE_|BEZP281MB1879:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ebcbff29-e16f-4686-b065-08db798d2e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JRVLcZhO1vAL7O81m022CXTz7yvw8LI6wMvEOB+m9RgARhuABqMDn4OnaO/cYiJDrh7JAUyjbUDR+QqFiGwIpJFUhEufHVuOKCVtU/C+woVgDCLeElLmHdYdKwHqKUp7agQGxA8Azl91TfWDb1rR29WDq7Wx90hXcIPIbHY0B8SklE+Z7tzw8NJ7tIY2UXeDnX68wVpd1/lCKgSjALhVqdv23T0lXkSNLGZmouT7c/IdpErsFIQu4AhVZ83HN3kHkMrQ1izdPOZeGk+rYDQ1LiIzd12IXvU4KSCfQj52sTkqgMG0TR8eM2j0yFzSSZRpGLS3+2k1ah4r7AzDzXMWWp0JQEdhfOpU+DfFcDSxprTvDaIVfBjGHawg5qOLHx0LzE/6GxHv3I2x2yP3OR2ULybegd+U4H7XTGOW3/2gmw6ubabXrLywGVH2hyA5ggM5Yo1lvjkETBXjODmPUrc1sgtS6p3YVLjwlWF5WrA311nZP9XhpFoEkITzRTyzweIbl0sUzM5TdECsE0KuCmtvKsO95+8a0Ko0EiFnX3S1UjvzXQuem2IaDTod4EGqUIVQXzSYMVbe7PDqCNiBl4LJCmFhYw8j5gY0HEytNRKA2StVf+TbHPOalifx9Zm595JpWRE7YzPhNPejfIb0Qfs538ZtjxjfI1bzxfA8AF9Sc22M7yg/5SsVhvJJqL01T+6Mibv7rYaNn2yYboGUt24QOAFd2bTQzcYp3tgCU1cHabx1BVA9mMuD1m5XeOMNLUtZaF18CVy2ac+3G6POs7q7A==
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(346002)(136003)(39840400004)(376002)(396003)(451199021)(36840700001)(46966006)(336012)(47076005)(83380400001)(2616005)(2906002)(81166007)(36860700001)(40480700001)(36756003)(8936002)(8676002)(82310400005)(5660300002)(86362001)(54906003)(41300700001)(6916009)(4326008)(70206006)(70586007)(316002)(478600001)(42186006)(186003)(44832011)(1076003)(26005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:12:27.9433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcbff29-e16f-4686-b065-08db798d2e7f
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT043.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1879
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27724.001
X-TMASE-Result: 10--7.750800-4.000000
X-TMASE-MatchedRID: 1XqbU0So2KXeBLQRDW0C4eI/SZYjZQvVuxdWEFKDsyyXYoGYte3R6q4H
        XgANsgPq0mUWktwu7TXnChKkI+hacAbTZXdljfOOm2eUW/oDuiHUWSTjY4IXEm149/2JSpDnQfG
        nDcNT/+U/ll3y6AJK8EURbKbsUADuwijDQnirsG3SlRrVG2nKgyqryEPUMZEg5TQA00qx4JWLz4
        gav4lvdTKT8fDhc32NMySZ9aHRPt/PupojnxPiBHOjEKYddvv6cnxszfxH2Ckmx8kl1Wnd+q+eC
        SMeOiOkfZ9uentPYeaJcb4M4L3rfi1QF7giu85XOwBXM346/+wU7BU91OLaCei3GsXe4mHOzB/L
        iqfZJh8aw7I5evsuCHFywM3Ch1Yp
X-TMASE-XGENCLOUD: 3b0ad64e-e23b-423b-89d1-10fbd1df4d76-0-0-200-0
X-TM-Deliver-Signature: ADFDF136A588C9A88EB8FEB556EB8A2B
X-TM-Addin-Auth: DtwCBclG1ECHvjY8OmFIA3YFulJggL4gVfPFWuOd7F5yj/x0J2Ow7CBfJ47
        kui0ERey5u5nX98KEnoKW9BjGBk0q/MnfJ2LGuw2Mr8wlWzXX1qVXkWcu3+HvC5jpyzrLcujLV4
        B+cpHvZ2HVOu0Zh1Q2pj0hmDHsPYTD1aCSh+8bMLOTbD9mahISclDjutArwvNF1Fq6FiTj64G4K
        iS78T363jxDgumFQT+VOKBGlA4J7zRU3imu7xccWpH04dl6jHjUyBhpRiG54DT02Q2To9pEx0iD
        6kG3hs8opEyLF5A=.H5AV2DlODN1T79Z4+7H29YjOQTxYkBZOA8PUa1PiknwAst0ejxA0SFycgV
        vVFKkB9/Ta/Uzh7eYdshe3LrgoXyJ2TMhVQbYV0lAJ79wxRXxh2M3uB358YALnxF6L1zPT+9T0m
        UYFeJ2TktKTXIBfolaoZzHkPiynISlSrZjhN2B4r2pblWjGFMpAIn3BWq4TQgyYXEWwVtHwcKr1
        Tqpq5a+EOBHRkqCin1ToYcUnsZ4+y98bNh0Nm9f5aaHXnWMtEWm3/V6NgvIXzOFp95CG/EwJqKn
        Lh7ubFfG5cCL1lfNanwdr0TOfRjIosTEOpMtLWP/qUyMYtBgcUgA7R7wRSg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1688145150;
        bh=vw7IXbVbuGsoAPP7rGBOB/cR+N7efyuPwJIzEnE6rAk=; l=2613;
        h=From:To:Date;
        b=ldpexf99aNZV7pwnG8ud0mWpRmclSY+Y/DJDcBOTJrPy+uLK/E2IxduD3XmZPnK91
         H6JS5zqF2IAeoP8dFPMyqtzTkhyHHvhZriu4LVb9OmB2we2csfse6Sy5pfXG5z38hJ
         /fRaS899IiIJA4iqzkRQYb8H1xDadVKNRy/F/U1qE0bCJcsitWcv3NF5dnz3l5a3xG
         b6liLfA1bxAfg19y3mIWDKPRgq6787/7HzkF1WhDGS0OQbh/jXfF91wg/WD5ITddab
         UOTm7FYgEW2f5hM25RRkCNLkCcnalt4c60yIeyN90tRMnnZFXt0gab4+pVRT7zjmDQ
         UfeVGmpR8H8SA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cycle_between() decides whether get_device_system_crosststamp() will
interpolate for older counter readings. So far, cycle_between() checks if
parameter test is in the open interval (before, after), when disregarding
the special case before > after.

The only cycle_between() user, get_device_system_crosststamp(), has the
following problem with this: If interval_start == cycles,
cycle_between(interval_start, cycles, now) returns false. If a
history_begin was supplied to get_device_system_crosststamp(), it will
later call cycle_between() again, with effective argument values
cycle_between(history_begin->cycles, cycles, cycles). Due to the test
against the open interval, cycle_between() returns false again, and
get_device_system_crosststamp() returns -EINVAL, when it could have
succeeded.

Fix this by testing against the closed interval in cycle_between(). This
disables interpolation if interval_start == cycles. For the special case
before > after, similar arguments hold. Fix this in a similar way.

At the second cycle_between() call site, add an extra condition in order to
effectively check a half-open interval, which keeps the condition
documented above the call site satisfied.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 kernel/time/timekeeping.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 8f35455b6250..7e86d5cd784d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1180,13 +1180,13 @@ static int adjust_historical_crosststamp(struct system_time_snapshot *history,
 }
 
 /*
- * cycle_between - true if test occurs chronologically between before and after
+ * cycle_between - true if test occurs chronologically in [before, after]
  */
 static bool cycle_between(u64 before, u64 test, u64 after)
 {
-	if (test > before && test < after)
+	if (test >= before && test <= after)
 		return true;
-	if (before > after && (test > before || test < after))
+	if (before > after && (test >= before || test <= after))
 		return true;
 	return false;
 }
@@ -1282,6 +1282,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 * clocksource change
 		 */
 		if (!history_begin ||
+		    history_begin->cycles == system_counterval.cycles ||
 		    !cycle_between(history_begin->cycles,
 				   system_counterval.cycles, cycles) ||
 		    history_begin->cs_was_changed_seq != cs_was_changed_seq)
-- 
2.39.2

