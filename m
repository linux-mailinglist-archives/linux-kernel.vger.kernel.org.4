Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1561F154
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiKGK5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiKGK5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:57:30 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C751A061;
        Mon,  7 Nov 2022 02:57:29 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id t25so28965164ejb.8;
        Mon, 07 Nov 2022 02:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+Z2+ck32GlpQgV/uBGlJrkyX3/Vf2IzJOHORrIT1MY=;
        b=XFFyTmL7BSv4J4Wq1E+s9vtLhWCkieiq+QZhvKznof880A9tcPYTH7fnAW4IWQDkTe
         vkPTrSTPhhq+1pOcbw0zlF6zg1prsrr2WYym5Pc58X2PY/4NjVCWx+03Yab1XvCcann+
         O4gG7kTNce/XcWV3xi+oBITARBXYdNnH7XCqqpt8D1Wt/JT3SMRjrkf0KlcG2kRukrcj
         WI0BsNOJu6lqQ8Qs17prqMpqyslaH0LHQFTWx6MO1d0tCZQQOGyw6PO3u3gYyVbt1Hhg
         1BiKkaRdcomr2mNejNy17nOiy8JM0C9GyYIHSqxNAbHYOZXVzJjXG46S5uYITS8HI4UU
         GKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+Z2+ck32GlpQgV/uBGlJrkyX3/Vf2IzJOHORrIT1MY=;
        b=M9/l7DoxWM2DDPnSp2ts3HNz8mqZnDDqi05QrwnHp9rpI/0O67fI/E6y70joCFHyfN
         tWg1SzqqRlqY34lG0ren0+sT1drXojwwAFQMQRQlIVSwixaZioiKhmancPcood6Y4vao
         UQuiRdTuUI/cjfMqQM/UQ5KOkkpnleC2or+zARM6FY27xJmMdFGBg9+Tz3VqHy9nFmPy
         ZSSN72x9IfFUcPZWf4C/PeDhquGt+3VOHGUqAw1R1Z0TLmLzIN5F84ESHhUtuJHduo1z
         P0PyOlG16oqGrc5nH0aSSyhvO2189GrbGTvV72YXDvfGtSbZ5G4inw/cjvH7kHJz6Mdv
         9ONQ==
X-Gm-Message-State: ACrzQf316eEPkESBgOv0vl9K2sIoNPjAukT4h1Enm4cAEjU+5/hNzSrV
        IJBagKM36JImGOYU3BtKBiyOEdsXuEQ=
X-Google-Smtp-Source: AMsMyM4NvgfZgWsr6EjuRh9MkFgv0bBQd9NonzB5fp9eFJcOmOlXfJonMayyfIaL6OdMMGpuR07UDA==
X-Received: by 2002:a17:906:7948:b0:7ac:d6f9:eb3e with SMTP id l8-20020a170906794800b007acd6f9eb3emr46181609ejo.350.1667818648080;
        Mon, 07 Nov 2022 02:57:28 -0800 (PST)
Received: from felia.fritz.box (200116b826b04a00c13f470e37e07cb6.dip.versatel-1u1.de. [2001:16b8:26b0:4a00:c13f:470e:37e0:7cb6])
        by smtp.gmail.com with ESMTPSA id et10-20020a056402378a00b0045c47b2a800sm3949250edb.67.2022.11.07.02.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 02:57:27 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] notifier: repair slips in kernel-doc comments
Date:   Mon,  7 Nov 2022 11:56:57 +0100
Message-Id: <20221107105657.19002-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoking ./scripts/kernel-doc -none kernel/notifier.c warns:

  kernel/notifier.c:71: warning: Excess function parameter 'returns' description in 'notifier_call_chain'
  kernel/notifier.c:119: warning: Function parameter or member 'v' not described in 'notifier_call_chain_robust'

These two warning are easy to fix, as they are just due to some minor slips
that makes the comment not follow kernel-doc's syntactic expectation.

Fix those minor slips in kernel-doc comments for make W=1 happiness.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Rafael, please pick this minor non-urgent patch for your pm tree. Thanks.

 kernel/notifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index 0d5bd62c480e..ab75637fd904 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -62,7 +62,7 @@ static int notifier_chain_unregister(struct notifier_block **nl,
  *			value of this parameter is -1.
  *	@nr_calls:	Records the number of notifications sent. Don't care
  *			value of this field is NULL.
- *	@returns:	notifier_call_chain returns the value returned by the
+ *	Return:		notifier_call_chain returns the value returned by the
  *			last notifier function called.
  */
 static int notifier_call_chain(struct notifier_block **nl,
@@ -105,13 +105,13 @@ NOKPROBE_SYMBOL(notifier_call_chain);
  * @val_up:	Value passed unmodified to the notifier function
  * @val_down:	Value passed unmodified to the notifier function when recovering
  *              from an error on @val_up
- * @v		Pointer passed unmodified to the notifier function
+ * @v:		Pointer passed unmodified to the notifier function
  *
  * NOTE:	It is important the @nl chain doesn't change between the two
  *		invocations of notifier_call_chain() such that we visit the
  *		exact same notifier callbacks; this rules out any RCU usage.
  *
- * Returns:	the return value of the @val_up call.
+ * Return:	the return value of the @val_up call.
  */
 static int notifier_call_chain_robust(struct notifier_block **nl,
 				     unsigned long val_up, unsigned long val_down,
-- 
2.17.1

