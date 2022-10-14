Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116F45FEA57
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJNITw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJNITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:19:49 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C931409C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:19:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=momi.ca; s=key1;
        t=1665735583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S+qVVqu5oKqaCALiw/URmOVikhCImWYfEp52IRag7j4=;
        b=qBynZYdiFQ6FweZcz6BIC/LCRGjDIdVVPeem/a6JY6m8/MJCH2iWH676EYdb5eGX4Wpu7z
        /173g3NWHALAJr4OOeHE3u6Hx6H2vBk4OQWKqLGqQGQ1tqCUDJ/5BnsQ5lNr276ABcxkH5
        yDg+24YD2bL+dtC7UOfios1Sznk9SP2z6uAnk/NTe9EPQFXa/6uyD5viVlQ7PDvOLw4z3P
        xzzipwOjjIPfKvCazVm0/GCDNBN9fxx8ZfTGyJ0xKTkfEoozttO/zfeLRbIPVmOODPK/ij
        xoOPUc9YbNL0h6uhZ8/nPFteGckv705s3hta1PIERMax8O+X1/RnXAWVqJ/9VA==
From:   Anjandev Momi <anjan@momi.ca>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Anjandev Momi <anjan@momi.ca>
Subject: [PATCH 0/4 v3] Staging: rtl8192e: fix coding style issues
Date:   Fri, 14 Oct 2022 01:18:36 -0700
Message-Id: <20221014081839.23902-1-anjan@momi.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes various checkpatch.pl issues: removes unnecessary
parentheses, removes multiple blank lines, aligns multiple line
function calls
to open paranthesis, and adds a blank line after function declaration.

Anjandev Momi (4):
  Staging: rtl8192e: remove unnecessary parentheses
  Staging: rtl8192e: remove multiple blank lines
  Staging: rtl8192e: make alignment match open parenthesis
  Staging: rtl8192e: add blank line after function declaration

---

v2: add one patch for each style fix
v3: list below the --- line any changes from the previous version

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.36.2

