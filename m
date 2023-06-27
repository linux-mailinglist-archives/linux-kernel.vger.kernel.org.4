Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92673F6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjF0IUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjF0IT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:19:59 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31829E5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:19:58 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QqyLd3qXzzBJBJT
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:19:53 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1687853993; x=
        1690445994; bh=jY7GM3rqeJ9VfWC97Fh6x7E9dEWzSb9DMFgD9naR1Xw=; b=f
        rQn6QORX2aaHA3uO3Dp87wfgGsBZX+8jQhRVXRoa/mBpSsFoxx0v3kYH8css+YFk
        +54o5TFG5yGODOLnkzXQC/H2PB6QOs/b5UpuNUbhYOAKAtnU/0+UOKxi+mVnxAMV
        MQ9Jw2npILrHRXyGcCiuWcS+xelsjdwuxKEisHgfbdr/ALA35lvMkzXz/Dkk8xNq
        0s7It/1rDXqCyD6UCGjOEmZqIcR4YTovr3l4+bMTaW/n6XCAXknNg18AMz1rEQn6
        HyxwT0Jsm5lq4uvixc33K322YShJcFlBwzUPaIT/sY4jc3ii47OuDma4NX/kVdj0
        MX/t9V1ZtFbM2hkQ6M+Aw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hmtpCTA30zPe for <linux-kernel@vger.kernel.org>;
        Tue, 27 Jun 2023 16:19:53 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QqyLd0Jb5zBJBHT;
        Tue, 27 Jun 2023 16:19:53 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 27 Jun 2023 16:19:52 +0800
From:   baomingtong001@208suo.com
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] samples/hid: hid_surface_dial: Remove unneeded semicolon
User-Agent: Roundcube Webmail
Message-ID: <8a1926c8717b152be6a7051c47959a50@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./samples/hid/hid_surface_dial.c:170:5-6: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  samples/hid/hid_surface_dial.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/hid/hid_surface_dial.c 
b/samples/hid/hid_surface_dial.c
index 4bc97373a708..704f2b639492 100644
--- a/samples/hid/hid_surface_dial.c
+++ b/samples/hid/hid_surface_dial.c
@@ -167,7 +167,7 @@ int main(int argc, char **argv)
  						"invalid r option %s - expecting a number\n",
  						optarg ? optarg : "");
  					exit(EXIT_FAILURE);
-				};
+				}

  				resolution = (int) l;
  				break;
-- 
2.40.1

