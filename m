Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74C35F02AE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiI3CU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiI3CUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:20:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDAE4D832;
        Thu, 29 Sep 2022 19:20:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u12so2996910pjj.1;
        Thu, 29 Sep 2022 19:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=SUa/4+caVBv6PoMoDBL5nY89uKoHKJ97ytgcWCmTBgA=;
        b=oGOI0B4DEdS7UJlwAlxaA9XlbpPMMInd51a1eupKFk3AP7gTbbVfViq07FEQnbXYTX
         uCdojtfq7/vNxhuXdaKA0j6fr9AQQrsNarvIZHYSbx6py7t+DAtCvPy+iaNg7JAv3MJP
         wd0FnTdaCCbmGBTJWG06Bb0dcOEQr7IrCYYup2akoDrKH6vBXYdOERnAnRr6nWzD64hz
         0U+KnBkLvvSXaG8fS6fadaz01UaZoZYduw6mtvwDhN1+cHVgN0ZVBS9DjiSpjswTAVgl
         64vF3qLk7jWwOs+Ck9h6/ubxy6HpkWx4gZqZai4wI1RMea3DAxb9+u6lH/rgZnK2cxfN
         KBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SUa/4+caVBv6PoMoDBL5nY89uKoHKJ97ytgcWCmTBgA=;
        b=n4AuxtUHnqTpRqHUEDxZ9rW5kRpIe69W4XL9rhUuFHRXd4Zy1TNLGif0IqcWgpMDjj
         tdZYgHVOy8iqKz1RUq24vSUC/CTDcD5s8SdNSKr+VGaxhSZ7coG+Fre/4Ta4oTAmnec5
         L6jRY86Zwf78E3OJMJl2T/Ub0F33yEHWkDSvOlA18nfEK+2xL+9HBqPIL6lyI2MuIePO
         zkpDaUqpU1XmnP8r9wfi9JXRY+QssJY2ah1UMMhjDo99mjOXpPWml1bM7SCZ0Qxb6C6C
         wsQj1S0eXk5pX3MBVyGvSJSn43BETTofOXm3HO02TOoOPJPTy0FfbpVwR1T1ORPziFyF
         4RVA==
X-Gm-Message-State: ACrzQf1tR/gRpRTqHOO7ZHt0zZE1uEk7v+B2Ia4DlqlHpeBq9QGUpcmg
        DZM9pPiXY/DBgNno1bAxVl0=
X-Google-Smtp-Source: AMsMyM7PJM5JhpuH0U97cNrqaL9X5PhYhGXOy5ysxLg+F33208f72L9z1SaYj2xkIrG8Sftn02LCMA==
X-Received: by 2002:a17:903:18b:b0:176:afb8:b4ab with SMTP id z11-20020a170903018b00b00176afb8b4abmr6631756plg.80.1664504411667;
        Thu, 29 Sep 2022 19:20:11 -0700 (PDT)
Received: from localhost.localdomain (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id o11-20020a62f90b000000b0053b850b17c8sm386115pfh.152.2022.09.29.19.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 19:20:11 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
Subject: [PATCH] docs/howto: Replace abundoned URL of gmane.org
Date:   Fri, 30 Sep 2022 11:19:36 +0900
Message-Id: <20220930021936.26238-1-akiyks@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow, there remains a link to gmane.org, which stopped working
in 2016, in howto.rst. Replace it with the one at lore.kernel.org.
Do the same changes under translations/ as well.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>
Cc: Hu Haowen <src.res@email.cn>
---
 Documentation/process/howto.rst                    | 2 +-
 Documentation/translations/it_IT/process/howto.rst | 2 +-
 Documentation/translations/ja_JP/howto.rst         | 2 +-
 Documentation/translations/ko_KR/howto.rst         | 2 +-
 Documentation/translations/zh_CN/process/howto.rst | 2 +-
 Documentation/translations/zh_TW/process/howto.rst | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index cd6997a9d203..bd15c393ba3c 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -379,7 +379,7 @@ to subscribe and unsubscribe from the list can be found at:
 There are archives of the mailing list on the web in many different
 places.  Use a search engine to find these archives.  For example:
 
-	http://dir.gmane.org/gmane.linux.kernel
+	https://lore.kernel.org/lkml/
 
 It is highly recommended that you search the archives about the topic
 you want to bring up, before you post it to the list. A lot of things
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 16ad5622d549..15c08aea1dfe 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -394,7 +394,7 @@ trovati al sito:
 Ci sono diversi archivi della lista di discussione. Usate un qualsiasi motore
 di ricerca per trovarli. Per esempio:
 
-	http://dir.gmane.org/gmane.linux.kernel
+	https://lore.kernel.org/lkml/
 
 É caldamente consigliata una ricerca in questi archivi sul tema che volete
 sollevare, prima di pubblicarlo sulla lista. Molte cose sono già state
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index 649e2ff2a407..b47a682d8ded 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -410,7 +410,7 @@ https://bugzilla.kernel.org に行ってください。もし今後のバグレ
 このメーリングリストのアーカイブは web 上の多数の場所に存在します。こ
 れらのアーカイブを探すにはサーチエンジンを使いましょう。例えば-
 
-	http://dir.gmane.org/gmane.linux.kernel
+	https://lore.kernel.org/lkml/
 
 リストに投稿する前にすでにその話題がアーカイブに存在するかどうかを検索
 することを是非やってください。多数の事がすでに詳細に渡って議論されてお
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index e43970584ca4..df53fafd1b10 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -386,7 +386,7 @@ https://bugzilla.kernel.org 를 체크하고자 할 수도 있다; 소수의 커
 웹상의 많은 다른 곳에도 메일링 리스트의 아카이브들이 있다.
 이러한 아카이브들을 찾으려면 검색 엔진을 사용하라. 예를 들어:
 
-      http://dir.gmane.org/gmane.linux.kernel
+      https://lore.kernel.org/lkml/
 
 여러분이 새로운 문제에 관해 리스트에 올리기 전에 말하고 싶은 주제에 관한
 것을 아카이브에서 먼저 찾아보기를 강력히 권장한다. 이미 상세하게 토론된 많은
diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index 1455190dc087..5bf953146929 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -306,7 +306,7 @@ bugzilla.kernel.org是Linux内核开发者们用来跟踪内核Bug的网站。
 网上很多地方都有这个邮件列表的存档(archive)。可以使用搜索引擎来找到这些
 存档。比如：
 
-	http://dir.gmane.org/gmane.linux.kernel
+	https://lore.kernel.org/lkml/
 
 在发信之前，我们强烈建议你先在存档中搜索你想要讨论的问题。很多已经被详细
 讨论过的问题只在邮件列表的存档中可以找到。
diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
index 68ae4411285b..86b0d4c6d6f9 100644
--- a/Documentation/translations/zh_TW/process/howto.rst
+++ b/Documentation/translations/zh_TW/process/howto.rst
@@ -309,7 +309,7 @@ bugzilla.kernel.org是Linux內核開發者們用來跟蹤內核Bug的網站。
 網上很多地方都有這個郵件列表的存檔(archive)。可以使用搜尋引擎來找到這些
 存檔。比如：
 
-	http://dir.gmane.org/gmane.linux.kernel
+	https://lore.kernel.org/lkml/
 
 在發信之前，我們強烈建議你先在存檔中搜索你想要討論的問題。很多已經被詳細
 討論過的問題只在郵件列表的存檔中可以找到。

base-commit: 05fff6ba04eef8b88bb94734b66731bef3d8d34b
-- 
2.25.1

