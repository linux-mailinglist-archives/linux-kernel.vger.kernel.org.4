Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A408746154
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGCRWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGCRWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:22:30 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82722E5D;
        Mon,  3 Jul 2023 10:22:29 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34570ed4cb8so19598995ab.1;
        Mon, 03 Jul 2023 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688404949; x=1690996949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n+ZjGjSll49/jZeLYkpeh0rYqtB4VgUifEJvJI0PHuY=;
        b=sG82R9IIfRC+r7VHJWyoYwzrsjdOAeHozBdMICRaGv4fPNi1oXuSy18AOsm2hqYjpK
         jg1bnoDRgNSXA1hszhHWemoLtyfE4QZU3N688i5ClRS6es18D6LKso844bUiPPs9662Q
         /21eCy3gHHQAM4KbaeyNrE+aZPxFLO9wC6MiE3TrXtgOP3Evlu1TxzkYAIjO6gSrb2PX
         P0vZyP00cXJutjWBgyFY0d05IoTWpgU3QGGGGLRlLNtNAO19UxTwX7hZxCy7pWa2cZRu
         EgWxXgO/8INyP1NHXgwcIXGrAFauDELaaOa3W7zSvYTZTBsmOJvd515kSMCPEzd0Cwi3
         knQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404949; x=1690996949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+ZjGjSll49/jZeLYkpeh0rYqtB4VgUifEJvJI0PHuY=;
        b=Ap6dovoUOx7d7EqCw1BgfY6SgOQziUmljp0QRsy5JpkOwg5uzQbr8ntUmb0V5EQOua
         RysO4W0/dmVSxVK6cwl2DIsfErfrc0pRIgEPTYHucDh1duLUoRZIIaRSZYUASJYMo6Sf
         dI4IiKq/H6oLCz8F2xQypsdt6xuxVkTPj1UKJZ/ZTE7DChyRsIaIRjOYE9RlfJ/Gn8tr
         EizV7fs2COT+lNCNRSqunGJanulEWe8vcv4PWWTY7FTw0BdnPvs56XIAVPXnzN2IxLVF
         iaHqjW+QqmX7k/CqWa+4Nbd/rJaL83F8XGtxyTGQ614S0vfhEowFodxRqeYb+nCeBVdZ
         CwzA==
X-Gm-Message-State: AC+VfDytqQxd7wtV95LNq17/+HyKN/cXzhv4L/x+5uTVtQyosZ34uLSO
        /yzzlkNbUf0lhQ9gXIqFnzI=
X-Google-Smtp-Source: ACHHUZ781J9cXqGVW9tjuylQx29kjih2s55K6UlGRS5TLBvfDm9HBUYQF3weel+frtIdPTko2fo0Aw==
X-Received: by 2002:a05:6602:5a:b0:783:72b9:ed67 with SMTP id z26-20020a056602005a00b0078372b9ed67mr11193837ioz.10.1688404948785;
        Mon, 03 Jul 2023 10:22:28 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id ed22-20020a056638291600b0042b3e2e5ca1sm1033860jab.122.2023.07.03.10.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 10:22:28 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/2] kyber, blk-wbt: Replace strlcpy with strscpy
Date:   Mon,  3 Jul 2023 17:21:57 +0000
Message-ID: <20230703172159.3668349-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series replaces strlcpy in the kyber and blk-wbt tracing subsystems wherever trivial
replacement is possible, i.e return value from strlcpy is unused. The patches
themselves are independent of each other and are applied to different subsystems. They are
included as a series for ease of review.

Note to reviewers: MAINTAINERS file does not specify clear ownership of
these files so I have addressed these to the latest committer for these
files: Jens Axboe <axboe@kernel.dk>.

Azeem Shaikh (2):
  kyber: Replace strlcpy with strscpy
  blk-wbt: Replace strlcpy with strscpy

 include/trace/events/kyber.h | 8 ++++----
 include/trace/events/wbt.h   | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

