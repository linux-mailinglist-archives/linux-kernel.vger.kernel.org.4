Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64519658E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiL2Pot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiL2Por (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:44:47 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B1813EB5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:44:45 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id p4so19567766pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7LjvNmFYtzAsC25vAMO2QJVZc+XB+9EQbUS0DGrgDU=;
        b=PbtGMeNvAH5sIErnJlF6RN06SEJnTPL8q12+rDbTGlHAKJpHr0/UEd6FjY2fkUJYJI
         bgMVaGltlxlu4GlPqWSRBWfcPCt+uq4KLfXtUVgDHjtF6JdR970o168kKpLE0LQhx79q
         kwcA6bI/OrGQb7G9zTggSvNdCDl3+QbqU46rfd4UGDSqqAukuDxwvs1D9G5zW8msAbiK
         zkCN8LgWAphOl6WhLo3sFYqvsl5fJ+srt9vfEQMGiARNJgUpTEQ576W7DpQuc8ENAYDv
         1QU9t2DHmukVcxAJ5EdvvGDmxZELRrk44NqW1Bwi7B84o0KAFYLhsoA88N55MIRq+EfH
         MG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7LjvNmFYtzAsC25vAMO2QJVZc+XB+9EQbUS0DGrgDU=;
        b=Qs5spRSr/ekPHxDWyxTWGd8gMikJflz1otY+XMRlYdl1xK8tBRisy+zJLkpHI5OsSE
         qHuLd0/Glhn7xH1oR84PW3siSvqIFPhcZPJHEBPDeOi57jlrzPAjV2qhEi0UBZS+OCYy
         oPjdGC6GrGogMOXCUHNYIAh3bEUgllKKblTOOvK2ALWvaBt9j7U0DXWzJG6BYPgrZ5/W
         Pw5GihBnJlqwRWpQBxN/zV1aoscYYEKDCNoSV1NwHTAw3Fyb8yOMfESDXXXCZBTaeRCs
         ObnDBFI4M4ZncR1rChs9Vf4Wvks5hfzlMXAsYjV1XJ2gk9HXBZk5EWVvZX8pW1sb2rT4
         zHAw==
X-Gm-Message-State: AFqh2kpxDPq40xFsM6Hzn6gDaGR5xNge+swdHgFL3xMXSJOsRFXNYGmg
        aPD4pTQceMIO47Y0pF4qX9o=
X-Google-Smtp-Source: AMrXdXutZbebfznjrJ8oCu7nv3tPPes+dfGDmenFp2dGlXXTRGJP1wI0skuRmwgaZsuQ5tdl0s1tbQ==
X-Received: by 2002:a17:902:ab14:b0:189:c62e:ac34 with SMTP id ik20-20020a170902ab1400b00189c62eac34mr33777332plb.47.1672328685007;
        Thu, 29 Dec 2022 07:44:45 -0800 (PST)
Received: from local ([202.131.133.58])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f7cd00b001743ba85d39sm13231993plw.110.2022.12.29.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:44:44 -0800 (PST)
Date:   Thu, 29 Dec 2022 21:14:38 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     gregkh@linuxfoundation.org, drv@mailo.com, ztong0001@gmail.com,
        dave@stgolabs.net, nhuck@google.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8192u: ieee80211: Fix indentation errors by
 removing extra spaces
Message-ID: <Y6215u/jtmcgO6TY@local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra spaces before statements to fix
following indentation warnings reported by checkpatch.pl.

WARNING: Statements should start on a tabstop
+	 struct delayed_work start_ibss_wq;

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index c5c43d2fb93e..694d1b18f81c 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -1823,7 +1823,7 @@ struct ieee80211_device {
 	struct work_struct associate_procedure_wq;
 	struct delayed_work softmac_scan_wq;
 	struct delayed_work associate_retry_wq;
-	 struct delayed_work start_ibss_wq;
+	struct delayed_work start_ibss_wq;
 	struct work_struct wx_sync_scan_wq;
 	struct workqueue_struct *wq;
 	// Qos related. Added by Annie, 2005-11-01.
-- 
2.34.1

