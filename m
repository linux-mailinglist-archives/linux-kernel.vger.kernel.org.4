Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112B55FBDF9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJKWwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJKWwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:52:00 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8946E2CE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:51:58 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j25-20020aa78d19000000b00561f966ae13so7892665pfe.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XusyGq/BtMQpus8wnubVaoCLzcnzByi/X6aLyv7q1P0=;
        b=UlX7ihEkCl9FTBOFGfPO3DjyEi8CbSe6MA2faSMYt79GLuSxcIOtuzUSEFmFkHCPYh
         gi7YM1+Nt+S5BAVbQvLteUDGKHWYm03X6cCGqMHwq7pv2G85gNAdFTiS77dnLorKJ1f6
         nYqCJ+6PS3v5vJ9YPhfBWZ94wmXD01ITcD2kdxwtyIWriAd2itVtC7Ig/JdhFbyErTe9
         ZHhCGmy9Pi/DwtUnITIdz86i0G4SjZIfe599rMN5YW1SpazJSg3G4t/2kqFRouwhSa8f
         9Wr8bWO6+LF96EpW1TT9pJbuISKI9P12B7iyro72q13+yU3cPqym7NizIvJ046Qax/Qb
         cyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XusyGq/BtMQpus8wnubVaoCLzcnzByi/X6aLyv7q1P0=;
        b=G6N/Gmtl3vf7snIkzQwROD3L4WaOMbOFOFQb1AIB8NpKF0jDharzvni6D1LAqc1NnH
         cs146o7TIFqo+5llHPJ8Vu08ovfBhWFF9hBI9KbwK+6yCzqWEoWvCTid5lN34yYJAtWi
         T8VyTr+9uQquUb2DmjsqvbEtpVSAPoiES3hp7E8hsZ6rRecLgsO7JaAocCJ4EfeeUzRY
         nGrPnmVSpVs//rQN2T+wsTlDHdESMFuI0LNyPbyyC2NDwW2YzEMSn4sR29Y7pVavtAWM
         hBdoURKK4U7ylTm+87JJdj/DelfP60+E/WhhyI55m36c/AeqZaOKI3tFsAnLf2MtNRtw
         n+Ew==
X-Gm-Message-State: ACrzQf3HNsTE5T8B0kASpmY5MosGkXkh+JyCwmp5CS+ohxpThencfitY
        hrhPHt/Uj6psb4db4SZLnpy7X9vWqlO2qvWS
X-Google-Smtp-Source: AMsMyM7BbZniYAkhXHjl+6EW/unOoIqSD0+K1jLc1Zwy4q0lNdSkkSR5TfuTFzWgjoCHzU3+UyoNLsubxOdef7jC
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:903:1211:b0:178:9353:9e42 with SMTP
 id l17-20020a170903121100b0017893539e42mr26440622plh.45.1665528718016; Tue,
 11 Oct 2022 15:51:58 -0700 (PDT)
Date:   Tue, 11 Oct 2022 22:51:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011225155.4055415-1-yosryahmed@google.com>
Subject: [PATCH cgroup/for-6.1-fixes] mm: cgroup: fix comments for get from
 fd/file helpers
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the documentation comments for cgroup_[v1v2_]get_from_[fd/file]().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
I cannot reproduce the warning so I cannot make sure it's fixed by this.

Again, apologies for missing updating the comment in the first place.
---
 kernel/cgroup/cgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6349a9fe9ec1..d922773fa90b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6246,6 +6246,7 @@ static struct cgroup *cgroup_v1v2_get_from_file(struct file *f)
 /**
  * cgroup_get_from_file - same as cgroup_v1v2_get_from_file, but only supports
  * cgroup2.
+ * @f: file corresponding to cgroup2_dir
  */
 static struct cgroup *cgroup_get_from_file(struct file *f)
 {
@@ -6753,7 +6754,7 @@ struct cgroup *cgroup_get_from_path(const char *path)
 EXPORT_SYMBOL_GPL(cgroup_get_from_path);
 
 /**
- * cgroup_get_from_fd - get a cgroup pointer from a fd
+ * cgroup_v1v2_get_from_fd - get a cgroup pointer from a fd
  * @fd: fd obtained by open(cgroup_dir)
  *
  * Find the cgroup from a fd which should be obtained
@@ -6778,6 +6779,7 @@ struct cgroup *cgroup_v1v2_get_from_fd(int fd)
 /**
  * cgroup_get_from_fd - same as cgroup_v1v2_get_from_fd, but only supports
  * cgroup2.
+ * @fd: fd obtained by open(cgroup2_dir)
  */
 struct cgroup *cgroup_get_from_fd(int fd)
 {
-- 
2.38.0.rc1.362.ged0d419d3c-goog

