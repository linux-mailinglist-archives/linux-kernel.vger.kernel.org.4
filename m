Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD2A74FF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjGLGQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGLGQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:16:56 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00DD10C7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:16:53 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R16vl4CzKzBR5lM
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:16:51 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689142611; x=1691734612; bh=wfCG/SruIwuAsnB8Aw7zPE90r7M
        G2A0S2zrw6C4ebX8=; b=jPww0/OU4JzMMNPQ6XpcmuM4SWqHcVuv9gNZdGW+x/a
        a/kVx7eFwGymkOs/9d+kZcD6lClyDgZJXKDX7XGWMWRm84u7qEcLfXPuZ5oKl2c9
        mhVtdYibTT16CuNMLLInXf1/tDC+p9L0aP1ay2wEGBum1CPOmHA3m8pO1GxwqF7H
        sbDpztCLJp7hM6X7EojqWHK4HKi3HO45y0VBNiU5q2vS7UP0O3WMsvmgDOTtsLT+
        uENSaEQdAzL3z1jmPbpJVqkfrinylcUto2x85TJSq/W5CD2/Howkp8o3IRFZwpjF
        f7kLRekqS05+yOkZk6dRKMJny5bjbQ1bBFI70uTEO+g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cq7JK9H79MkG for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 14:16:51 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R16vl2G7kzBHXhD;
        Wed, 12 Jul 2023 14:16:51 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 14:16:51 +0800
From:   hanyu001@208suo.com
To:     sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: Fix errors
In-Reply-To: <tencent_6D69416A3BCF8704CCAA9D2A6DC60B891E09@qq.com>
References: <tencent_6D69416A3BCF8704CCAA9D2A6DC60B891E09@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <66805adb7db117206d4c0c943024dbac@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the below checkpatch errors:

drivers/power/supply/ab8500_bmdata.c:186: ERROR: that open brace { 
should be on the previous line
drivers/power/supply/ab8500_bmdata.c:192: ERROR: that open brace { 
should be on the previous line

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  drivers/power/supply/ab8500_bmdata.c | 6 ++----
  1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ab8500_bmdata.c 
b/drivers/power/supply/ab8500_bmdata.c
index 3e6ea22..a092727 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -184,14 +184,12 @@ int ab8500_bm_of_probe(struct power_supply *psy,
      }

      if (bi->alert_low_temp_charge_current_ua < 0 ||
-        bi->alert_low_temp_charge_voltage_uv < 0)
-    {
+        bi->alert_low_temp_charge_voltage_uv < 0){
          bi->alert_low_temp_charge_current_ua = 300000;
          bi->alert_low_temp_charge_voltage_uv = 4000000;
      }
      if (bi->alert_high_temp_charge_current_ua < 0 ||
-        bi->alert_high_temp_charge_voltage_uv < 0)
-    {
+        bi->alert_high_temp_charge_voltage_uv < 0){
          bi->alert_high_temp_charge_current_ua = 300000;
          bi->alert_high_temp_charge_voltage_uv = 4000000;
      }
