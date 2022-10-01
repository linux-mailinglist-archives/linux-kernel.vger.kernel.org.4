Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89EE5F1888
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiJABvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiJABu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:50:57 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E678F12DEE1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:50:56 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r134so4571893iod.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=g4pU8Y9k0PcP+fUHksjHfytvmYaiYpOQZLkW4vDJzWE=;
        b=f6yFZaZ2hv0kLIRDvxZd01qquunSSt9RXhbv2OzYebHwO0ZjmuFuljdhNkp+LRLtmT
         HCnYhYuzjn1Y1dsFZ87Q9k+uFBXljjHv2f92W5OayUcR1kYyzfQBtAWvMTZNwUyTUGx6
         V2JylO9d4Tk0yeSz1BRsiPcqHK/6/mQhC2FIiQLlZM/j5nsGglQEkl2RzI08IvR4ulLW
         a+9yYO7vY2qRaqKYpbu9t+JqvGOteK8Ef0l5Cu8HGbrrZzr2HXrFLSzzsjdOSgOwkJFN
         H2VUX9z9B5aEl4jzhuEWQqLppOTG1OJkvafPh21Jite7I0nUGsNplyEeUQMbSDIdfKZJ
         nfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=g4pU8Y9k0PcP+fUHksjHfytvmYaiYpOQZLkW4vDJzWE=;
        b=rAy6+mX8zlg7RgMTsxX+3xKwpRl/QRJNNhdaTLdLVjZfKwFkwxYpjhOp/GR3U+bxef
         1SCBI+M2tfbYggxa3c9e7ZsauL5N4vb94kzf3W1egOkWsJ7rxAweDi91kSvNPXjqqmST
         IrIA8aNjpwa52MGKA86zPm2I6U8zah01HMONSzg+re9rrtYrXmu8dFnuEQvZyE2vc5jI
         EgXrHZujIqV52aVEd5Q9gUfgfAWmWmHhacuFHG2lZUsyfm/WRB6MK+bDuZi6lwBQ9MY7
         A1oUCztjJvGAO8g+ybBv8kZ0Vr3DcUp801k2NkZJRKFhVmID49BZOtM5q2ZT/feVfaW7
         iWVw==
X-Gm-Message-State: ACrzQf1yyDw5GQt9/n2GW81iLiiJhJJO8KVKxh27Oh5XALH38zrVbadC
        EnqaKrtk/9GUsDJWkv/sYe4=
X-Google-Smtp-Source: AMsMyM4pYcbRACIaF/uOCC9WKTTjPx8YnfZLGdREfRmBhZN674rygG6dE1zpFzY/aB2ibqJHk+/7ZQ==
X-Received: by 2002:a05:6638:1c17:b0:35a:151b:c726 with SMTP id ca23-20020a0566381c1700b0035a151bc726mr6024714jab.66.1664589056296;
        Fri, 30 Sep 2022 18:50:56 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:9591:95fe:2a76:5935])
        by smtp.gmail.com with ESMTPSA id i4-20020a056602134400b006a0eed3fd65sm1656748iov.54.2022.09.30.18.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 18:50:55 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, tim.bird@sony.com
Subject: [PATCH 1/1] mailmap: update Frank Rowand email address
Date:   Fri, 30 Sep 2022 20:50:09 -0500
Message-Id: <20221001015009.3994518-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Frank is no longer at Sony, add an entry for his latest Sony email

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Yes, the Signed-off-by: email address is the one I am adding
to .mailmap.  This will be the last such use of this address.

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 38255d412f0b..4e978828d1f7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -135,6 +135,7 @@ Filipe Lautert <filipe@icewall.org>
 Finn Thain <fthain@linux-m68k.org> <fthain@telegraphics.com.au>
 Franck Bui-Huu <vagabon.xyz@gmail.com>
 Frank Rowand <frowand.list@gmail.com> <frank.rowand@am.sony.com>
+Frank Rowand <frowand.list@gmail.com> <frank.rowand@sony.com>
 Frank Rowand <frowand.list@gmail.com> <frank.rowand@sonymobile.com>
 Frank Rowand <frowand.list@gmail.com> <frowand@mvista.com>
 Frank Zago <fzago@systemfabricworks.com>
-- 
Frank Rowand <frank.rowand@sony.com>

