Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A37744325
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjF3UXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjF3UXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:23:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163D32D69
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:23:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-313e23d0a28so2743352f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688156622; x=1690748622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c54yYLH2fTT0X2wdCkESplEqxVmW0la1I4ALaZleQJk=;
        b=fUS4qJwj6lBdPii+ygZiCsQSZSIqpX9qYrHJvIj3mjqpcVf/RK96wNHVKQzNbgPAWq
         GNft75GrYTu2lTtwJlTl72r+p8eglrazL3P4iqZ8JwgZs7ewrHUpMXyLHhAjKQjhX0ez
         Jlg0E3IIzWNTI0EpxbT0Aip2TLOKRrzXAR9JxH0ovdg+6NbMruKW7E7yOvW2f08cKbAh
         RrTLXraRGqxGUH8POq51jShRdQsm5v9fI2jMEov8LfPK//tLQbTJBsqG9c5mP5EhRuzI
         DsuafumqZX8Vxq6N8va1GBVd/O3aB0jxf/l7So0P6BhyQA88kOgK91Fkgkx62ri87GdF
         Xdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688156622; x=1690748622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c54yYLH2fTT0X2wdCkESplEqxVmW0la1I4ALaZleQJk=;
        b=DZnFndDR1VTWZ8Te156Od1mOdfi5cfcSBIDcK2e+SwozrxfHa0vNYxL31OsX8mPQnw
         8XOeY1KTcyJkZarBHk1Vt2A+R2+lEkCCVyyaRf1rujJaswumsULqQUwtkpzVbheWpAbi
         DyglGcV2hRQLDbdO2+k/KKBAEHWfVZOSy0XzN43ON4LApmr/VPxW5opENALyO8mvLaro
         iYW/MJRPU4WGmfMCeq1X4hyEuzfnxZwo6OdmM+Ggwbq9La4AiDrf4yhcnoS7El+8oON7
         iNQd3LszXj3ceAZGeZ1/QLJjl6q0t2go01eieBD6HkKTtA7Yu8DUS/gEApZuI11Zxg/K
         9jGg==
X-Gm-Message-State: ABy/qLbZcic63MYm7r+DqY2GNSEXO0ACLGz3vu2gOBJKxvFHZzDpZokR
        h6lW+YZAhsPMplNCWAz67qvjDjYiMhTPzA==
X-Google-Smtp-Source: APBJJlG0PAu5wVFHCilzmGODBQytG5jpYUn7kfvR6uIcVLAofJeXSbAEOLbjTSK4U9eBnUZqb5qe3g==
X-Received: by 2002:a05:6000:1364:b0:313:e922:3941 with SMTP id q4-20020a056000136400b00313e9223941mr3134750wrz.46.1688156622447;
        Fri, 30 Jun 2023 13:23:42 -0700 (PDT)
Received: from localhost (dslb-094-220-187-252.094.220.pools.vodafone-ip.de. [94.220.187.252])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d590a000000b0030631a599a0sm18970813wrd.24.2023.06.30.13.23.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 13:23:42 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mailmap: add entry for Jonas Gorski
Date:   Fri, 30 Jun 2023 22:22:56 +0200
Message-Id: <20230630202257.8449-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630202257.8449-1-jonas.gorski@gmail.com>
References: <20230630202257.8449-1-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The openwrt.org email address is long defunct, but still pop ups from
time to time when asking get_maintainer.pl. So add an entry to my
currently used address.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index bf076bbc36b1..e1f8c928a5c2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -237,6 +237,7 @@ John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 John Stultz <johnstul@us.ibm.com>
 <jon.toppins+linux@gmail.com> <jtoppins@cumulusnetworks.com>
 <jon.toppins+linux@gmail.com> <jtoppins@redhat.com>
+Jonas Gorski <jonas.gorski@gmail.com> <jogo@openwrt.org>
 Jordan Crouse <jordan@cosmicpenguin.net> <jcrouse@codeaurora.org>
 <josh@joshtriplett.org> <josh@freedesktop.org>
 <josh@joshtriplett.org> <josh@kernel.org>
-- 
2.34.1

