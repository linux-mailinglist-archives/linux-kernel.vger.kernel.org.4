Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066E470AD03
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 10:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjEUIgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 04:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjEUI2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 04:28:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B11198
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 01:28:18 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 78E5C3F4B8
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 08:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684657697;
        bh=Tv9SP0tP+8DRjLTNt8sd7O2hc074o3ygEuc+rvxGi5M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=B2np6/42mdslIvsIz/AUbtKnejLsEHxvj1UOw6KmBS/Ta48DhDz2j4JvvklOznnLT
         mPkeOIyWbL4B/QRQfBBsYPkGzkaaG+XgbruvhbESXtjYopzkV56ZxCPPxsAM5f+wiV
         hxWbuit6wu+iTb0v/Pzmeux2by3trT85gWPFAWVf2OMZrIRmdBWJHrnJeP79aczMBF
         WI+BtN1iKDvpC7UNpQUik5CH4hMCxKk4Tr7Njr4Ow+WVkCqiKld0aR1tQx2+lalUmv
         +zNbTSZTYJd3+kMXtG+kEQl9nyGXcRoLZYIzBQ7MNQMgl96ftZjJcvRLqq9S2CQS2z
         svf3lys3oLPFA==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-51392d645d5so539515a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 01:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684657697; x=1687249697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv9SP0tP+8DRjLTNt8sd7O2hc074o3ygEuc+rvxGi5M=;
        b=Bz/OrGpO0o4MVfUKs6oJHS+0bSzAqZtBpqeRjnKPmS4DQmE2YnK5wM2ZeHibI4izoG
         1aCdD833hs9NZNYcYXTdgs591dMEupbo0r8TM5prtXJ1HtXIFbeKy3KcASmHa1Nyb3E3
         xBM0oCVlL897MbQScIDz15Xfqd+p00VHPMMfDIxnHljj08a9ctXyinjpvXkNyH33GgNU
         VYfs2pEtfyJ1r9vf2Vq575ukCqdxqiTckJxYBZJx7aUtEg7tHToHR6PerM+9EIV9qT+7
         /IUkoS0TiFzrEaslBjX4ggjss4soWCrldpJAFJ/iE/Ey7eV/kBlgeprXZ9tStq432Woo
         A5ew==
X-Gm-Message-State: AC+VfDzbV7tH0m6I9O60H0xAHtp8u5DYQ1mbyOJkVNFfsw/zFMYCnp4X
        U5X2LR+wUx3o0GzjNHFkkeEUrwJmw+mry7GM6OCYnkH/t/iDWHznquuN6/ee5d2hC9TGfWOvw18
        xUv7hpa5OsuRydQ7HSY3sY9eSBAfHbJuzuyieQApgyg==
X-Received: by 2002:a17:907:ea8:b0:96f:d63a:9508 with SMTP id ho40-20020a1709070ea800b0096fd63a9508mr408830ejc.33.1684657697001;
        Sun, 21 May 2023 01:28:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5zjmpQLazlg4eQAFXZI5Rr2SSRNw/GT8/EqlXK/VXX1kP9qh5iIckYIkjPiO0SfPZjdVdQXQ==
X-Received: by 2002:a17:907:ea8:b0:96f:d63a:9508 with SMTP id ho40-20020a1709070ea800b0096fd63a9508mr408823ejc.33.1684657696828;
        Sun, 21 May 2023 01:28:16 -0700 (PDT)
Received: from righiandr-XPS-13-7390.homenet.telecomitalia.it (host-87-10-127-160.retail.telecomitalia.it. [87.10.127.160])
        by smtp.gmail.com with ESMTPSA id z17-20020aa7cf91000000b004c2158e87e6sm1656646edx.97.2023.05.21.01.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 01:28:16 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ovl: Kconfig: introduce CONFIG_OVERLAY_FS_DEBUG
Date:   Sun, 21 May 2023 10:28:11 +0200
Message-Id: <20230521082813.17025-2-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521082813.17025-1-andrea.righi@canonical.com>
References: <20230521082813.17025-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a Kconfig option to enable extra debugging checks for overlayfs.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 fs/overlayfs/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
index 6708e54b0e30..fec5020c3495 100644
--- a/fs/overlayfs/Kconfig
+++ b/fs/overlayfs/Kconfig
@@ -124,3 +124,12 @@ config OVERLAY_FS_METACOPY
 	  that doesn't support this feature will have unexpected results.
 
 	  If unsure, say N.
+
+config OVERLAY_FS_DEBUG
+	bool "Overlayfs: turn on extra debugging checks"
+	default n
+	depends on OVERLAY_FS
+	help
+	  Say Y here to enable extra debugging checks in overlayfs.
+
+	  If unsure, say N.
-- 
2.39.2

