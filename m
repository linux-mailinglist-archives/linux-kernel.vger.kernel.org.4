Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772955E5CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiIVIAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiIVH76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:59:58 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA1B33A19
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:59:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=momi.ca; s=key1;
        t=1663833592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XbvKAdtcmW4XCdEMoBcO9b7szK/Fh0wTG+QKWKgbeXI=;
        b=iVLD2H6lYDqJ6qfRGev8DClt+tffgmekn5XH177loNzsYDdQQ92O841yeV8Idx0BwYZvTj
        vpOViyvyeBV/GM2UzoLIJ+wAx1aJT2jJT9dfF7TI8z7tZfKIr56sHIU2/L0EkLNIt+0AWv
        gYxhOqHLiYm0NHUmfw/GGVSiCYqy0t1WmSmGKimcG7MT+54Z9sEmfmcoKTv/34M6rmSfuN
        8EJyz/MkOXAZ3Gwo53eM8lU6TVIDrslwZ13/2Dgd4CXdB7iJ6drmV9RtaNIYkOhs5Kcb29
        vhy/oMcJb/SGQCXiHLuX/TGkmlRQ6zH9RFJa8a9LNkRpWF90fgGoVrl5536odg==
From:   Anjandev Momi <anjan@momi.ca>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Anjandev Momi <anjan@momi.ca>
Subject: [PATCH 0/4 v2] Staging: rtl8192e: fix coding style issues
Date:   Thu, 22 Sep 2022 03:59:19 -0400
Message-Id: <20220922075922.20523-1-anjan@momi.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: momi.ca
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes various checkpatch.pl issues: removes unnecessary
parentheses, removes multiple blank lines, aligns multiple line function calls
to open paranthesis, and adds a blank line after function declaration.

Anjandev Momi (4):
  Staging: rtl8192e: remove unnecessary parentheses
  Staging: rtl8192e: remove multiple blank lines
  Staging: rtl8192e: make alignment match open parenthesis
  Staging: rtl8192e: add blank line after function declaration

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.36.2

