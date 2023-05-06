Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9036F8E5D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 05:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjEFDkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 23:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjEFDj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 23:39:59 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6315BA1;
        Fri,  5 May 2023 20:39:58 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3ef33f12995so13987021cf.3;
        Fri, 05 May 2023 20:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683344397; x=1685936397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BpswY9m2+akMpZjU1Lghg3scLIT0ByR97P+sSuwJhQw=;
        b=oD7j9RV4M2MhuS3xLZsb2d8VXEoZ3l2IrCNV/UmdUhaBgoea0qw5wl71yXLeZv/dFC
         3XMx5kR1dmneTT2XWgi3MurMBqv/xp4dJ+DnKujmIor7o3i+lB2Pb1W58mQ9nrpJ/Zhr
         2cUtBaiYk7M3xLq09gLYENEJTju+yu/uMFHTKF1pJFAEl/HH4MMkSIKJy0BXt7s6e/W+
         TcI61liQTLtZvtICA5sUO1k8+SQZS2vp1IwkMqf6rnBhuDgWDlPapsIABwtA/l+Dybbp
         tcjphRxGFdsruwZssgksOZsTOrUM2NnUmeqKxyRXPFl3EUaehJ5Z4oh/hNv1JgJcMrKu
         Zdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683344397; x=1685936397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpswY9m2+akMpZjU1Lghg3scLIT0ByR97P+sSuwJhQw=;
        b=eF186aPVlNgnBgbZxEpczHKjGiG/kDKGMrhA4dPhE6FnWo6x3No7j268T9ynnqqzZ0
         TvqGcItjFmAvHiuWw4co5FzAxR0XGnWBSKyecxb+shD0HxahEXqhJa9yCG5hPgqmDZJ/
         sMEdgpnlfA/cU3WBUMrjdhxwkMn9N80kUwAZHN3eYqWWBXv2/Xl+D/xQ2oAcVr6c/C2T
         RfBwfjq87hZtlwtluPdpbQQuBtuwer70B5FA4f7dlCbSM6zOc+Z7H85Gx+GKRkUGna/b
         ttAvS1eM7Q2m11IjPxgb5uIhpq0l4NluvUBrzpTxNNIgLOxE6mv0h5Ke8M6S+5w4hacr
         ZRVg==
X-Gm-Message-State: AC+VfDwrhGidD9/3XvOqccx/emyCFBZkUI+bvZq/koKtXerkK1Cs5Xq2
        Lo4AwAZs4nYSuWHrpCieflk=
X-Google-Smtp-Source: ACHHUZ7bnLO45tsKPI+UOJ46pyLBSkekEW2ehWqDecsRxiwLn6lF+27PKDLiSVZcbZg7I7nwR6dfQw==
X-Received: by 2002:a05:622a:1393:b0:3d5:500a:4819 with SMTP id o19-20020a05622a139300b003d5500a4819mr5635171qtk.23.1683344397617;
        Fri, 05 May 2023 20:39:57 -0700 (PDT)
Received: from localhost.localdomain ([191.96.227.112])
        by smtp.gmail.com with ESMTPSA id h7-20020a37de07000000b0074e13ed6ee9sm1013605qkj.132.2023.05.05.20.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 20:39:57 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dhowells@redhat.com, jarkko@kernel.org, corbet@lwn.net,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH]Documentation: Security: Consistent block output by removing a misfit line
Date:   Sat,  6 May 2023 09:07:38 +0530
Message-Id: <20230506033738.16908-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A simple removal of an unwanted line from the block output to make the output
of this block look like others on the page.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/security/keys/core.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 811b905b56bf..0ca5bc591d95 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -314,7 +314,6 @@ about the status of the key service:
      This file lists the tracking data for each user that has at least one key
      on the system.  Such data includes quota information and statistics::

-	[root@andromeda root]# cat /proc/key-users
 	0:     46 45/45 1/100 13/10000
 	29:     2 2/2 2/100 40/10000
 	32:     2 2/2 2/100 40/10000
--
2.39.3

