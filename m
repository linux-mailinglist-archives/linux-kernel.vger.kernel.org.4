Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88E74F258
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjGKOev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjGKOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:34:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F1C1A3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:34:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57745160c1dso65056867b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689086054; x=1691678054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x2+pNKeYSTTkMHkj+CaenjYOksDIkk5vhNRhS7msv78=;
        b=rWmTYzGgcwZ9eiHk++iMkj2Y4zpLmf08k7Fa3FxbN2PPOiL0EOcRfmzpzmhxyA4emz
         Zg9vbMS+wwftUe4xhBLzikZhynzAc5rkXBa1gKdfPrw20WY6j7lwbreVixWTX2F+Q7GV
         MyzX+OLukg3yi87YVhK8m131BpFH4KFNk82gxBnH1oLyPQmyOci6MGj/rKMLxnB78zy7
         0xjIe4k9etocylJpPsc3HYGBeTSh54bew9GyNu+UTR1qCleLfNcoc8QtaPrvdilWLAur
         sCWvVN7UZnFy5mwKJ4MrZdhTXXQQiUV2S92piY3NcUDDBVoBgWhQtNG73j7TeETUv+JI
         pB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086054; x=1691678054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2+pNKeYSTTkMHkj+CaenjYOksDIkk5vhNRhS7msv78=;
        b=eyoElSU0aC8jYBBGjEcR9lSVK9LaL/PmHEjFsUhNnPMLNQAdS1ycmSZqtg4p1oah+x
         e1tNLqpZfZ9ia4WQnX4iRQ0wdWEHhFg/1XNuNZw/sqgvJdyi5bX7zPgFJiHT/+ebVIH1
         +qnha1CmKzFrzb6d3qGwM9sVeh26zhCLAd29hPK64NUdc2XywLS6PKzVI+FXRxam/QzW
         VI2p3zhq5oQ6eX5dACK+kYODVb9dsCkZDLBIdNaR1wDEJ/AwKaseRBHCbakSN3QwKcRA
         11J7mRIHHeiDPJGws+N2c1dicwWi/cbSwVa1ojHiK8mZobwW3pLK/owmPQopiWiNesYY
         R8sA==
X-Gm-Message-State: ABy/qLYGiji2BUdZJUfeh5+wcCy5A5KEyuCzfm68fPDw3fiC3VE5FW3U
        6Yya+g/vqnAWVXr2ZLxFH7T9x11rA/k=
X-Google-Smtp-Source: APBJJlGMXFL68J/yseQS6WSJsGcs08hmpVoTnEriAaqp762LgxsoCDYkaMziTccnqGd7qTZ2i7dyeqWztoc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:564d:3aaa:6b5f:4419])
 (user=glider job=sendgmr) by 2002:a81:e304:0:b0:573:8316:8d04 with SMTP id
 q4-20020a81e304000000b0057383168d04mr130837ywl.4.1689086053931; Tue, 11 Jul
 2023 07:34:13 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:33:37 +0200
In-Reply-To: <20230711143337.3086664-1-glider@google.com>
Mime-Version: 1.0
References: <20230711143337.3086664-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711143337.3086664-11-glider@google.com>
Subject: [PATCH 5/5] fixup mteswap
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 arch/arm64/mm/mteswap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index 7e8ee43e0d389..e072c1209fbb6 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -30,7 +30,6 @@ int mte_save_tags(struct page *page)
 		return 0;
 
 	tag_storage = _mte_alloc_and_save_tags(page);
-	pr_err("HERE: %s:%d\n", __FILE__, __LINE__); // TODO
 	if (!tag_storage)
 		return -ENOMEM;
 
-- 
2.41.0.255.g8b1d071c50-goog

