Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53ED68CCAB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBGClt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBGClp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:41:45 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C70A1734
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:41:42 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id sa10so9284824ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 18:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s91+oEnSweyrYJ7zOZXbJcjJdLANF4FIs4mTGGeIDMQ=;
        b=YMe/uZDCbnhDaSVnvzdwIpnoXqToDEgkK/wvAOVAGROldzLAoL8psy6ygrWLF2kY+L
         VSEUAF6l8dDfKkQTxykXCMWsZA9rJG3kk+OMAeSk0MNG+rlYc/8sjyaxEaRP7/QPx1cw
         1H7W458Pm5wr3z6JAb+LQP5xcat1krsqi6mnlHTNorybcD18LEK0wJIUJqaWwk0yf6Ak
         IgobIfnySqTxqImZR/boCge0WGNswtl3jlx2NNmdVfXgQYUw+GvL2XO//wHt8FFREykE
         AsEoCOGYmMQnPrZnWUrTzbgBQ22dreOkwHWBL5hvTyOKsVhJ3L2/8fbfk3l8+K3hyzkJ
         p/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s91+oEnSweyrYJ7zOZXbJcjJdLANF4FIs4mTGGeIDMQ=;
        b=H3x30GPfsGAtvWDOZwqygaXYJRnBPmMrYvSjlnl3x4JbaSDAM/UscuYykWw81UJbg2
         FACEY7sz5/B9I6TrYzhvrGZp0uqE5AzxJElioPddC0C3n6RYf33raedTnioxX+Nu8X+h
         BNmnNOLSZgs0iXrgxPq+HHzF+pIrTxXDwmjas+7PuGphOdnWWPrRaxOLT5vm+PtmbQ+A
         M94WkT0I1WOnJmAb7sfCOH1z1v/IFiVFm6AcCgK2iNRrHLoCT9kx/nrGTF7R/I7jzqGx
         XZbvbj2ACzcbEwJvQ+RSzgFYFJZcBaRNPlf5bmQygmgALglS45bfYxDquoLZs+yQiWAL
         PPhw==
X-Gm-Message-State: AO0yUKUTXoSYSe6IEKVkevDeJliMOEDsjSHXzLOdNUoFcdCpcZ+KM+6U
        g3/bPysK/6YcSXyL4+G9oFwplOZK6oRsZQ==
X-Google-Smtp-Source: AK7set96GHsjy5MMPhjXojl5tl68cK1PeI4zYySwd/yFTzbhIGH1ou2Wh7tLUVeyF2ZgMP8/57GybA==
X-Received: by 2002:a17:906:81c9:b0:88d:ba89:1840 with SMTP id e9-20020a17090681c900b0088dba891840mr15672819ejx.17.1675737700791;
        Mon, 06 Feb 2023 18:41:40 -0800 (PST)
Received: from smurf (80.71.142.58.ipv4.parknet.dk. [80.71.142.58])
        by smtp.gmail.com with ESMTPSA id gw1-20020a170906f14100b0087bd4e34eb8sm6152954ejb.203.2023.02.06.18.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 18:41:40 -0800 (PST)
Date:   Tue, 7 Feb 2023 03:41:18 +0100 (CET)
From:   Jesper Juhl <jesperjuhl76@gmail.com>
To:     linux-kernel@vger.kernel.org
cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] Update CREDITS file entry for Jesper Juhl
Message-ID: <8e18fa82-1095-330f-29fb-80743d22443c@gmail.com>
User-Agent: Alpine 2.26 (LNX 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 6e44eab54e48c76f7e738d642b9a680282787ee9 Mon Sep 17 00:00:00 2001
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Tue, 7 Feb 2023 03:37:56 +0100
Subject: [PATCH] Update CREDITS file entry for Jesper Juhl

Signed-Off-by: Jesper Juhl <jesperjuhl76@gmail.com>

---
  CREDITS | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index 5f5d70c9c038..847059166a15 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1852,11 +1852,11 @@ E: ajoshi@shell.unixbox.com
  D: fbdev hacking

  N: Jesper Juhl
-E: jj@chaosbits.net
+E: jesperjuhl76@gmail.com
  D: Various fixes, cleanups and minor features all over the tree.
  D: Wrote initial version of the hdaps driver (since passed on to others).
-S: Lemnosvej 1, 3.tv
-S: 2300 Copenhagen S.
+S: Titangade 5G, 2.tv
+S: 2200 Copenhagen N.
  S: Denmark

  N: Jozsef Kadlecsik
-- 
2.39.1

