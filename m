Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E53E5FF96D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 11:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJOJXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 05:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJOJXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 05:23:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067974CA08;
        Sat, 15 Oct 2022 02:23:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f23so6777739plr.6;
        Sat, 15 Oct 2022 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZV6fFcsquYjpRdmdX31xgmTg85v5mjqXVyB1J3bUt8=;
        b=VfpkPBcQehQY1oW/jKmOZl6f+kkrip67blT+NAdH0Hdsrn3ao5j98BEn+gPEUzm5Wm
         7nd8s9bHEZwiOAzzOMWMsnnAH+tlh9nehYonWbXIVDvodVj/Nh3YGscmK1AzCRKBT/KM
         9bVTNjs8wyDE0p9rUrAIA4pH3ceo33OGBvbPWjOf3Qq+x87y8lhVabnsPAXyB6rCusF8
         D1j2tLuulDX28i5u74vNJzu4FuXNM0CInEsaoXi28pj9g9Dc/piv9xFpUDFUohTIAo5e
         V7PvprTvsZKfEdLp3ImPKGPKmjQuTmPUZW9cBOli8SWINJdfrZzdGF8D5BNNFq2IKIRL
         +weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZV6fFcsquYjpRdmdX31xgmTg85v5mjqXVyB1J3bUt8=;
        b=FyWL/2iRxvfxmZJy6+vvQjrwOg/Znz6eNg2i1ibPHym5WzwL1pjYkr1nh6W3n/kgD0
         sgUJTbrbjzSOqT/dutfeeHDTwVRieMp9yGcSdOLV1cK8ee5OOGG5NUFoO+pg1QQKDsd0
         VljaR1GVpHJzb6O339WfbAFc3eC2VIFXbXrwu99slsooElwYW4Qc2qi/YI9kwKzU22cH
         9fyc/XXzBQbvNipC6c65ftiQiF4qJIBjWLf5FQLq7BuOPHOzVI98zq2kY8kFr6eMivy8
         hLwdT2F4UYbkx4B6INBDY/usXQjmyzYFqGZEK5Fom5JielWMdT9d6CH5bpbFgclq9yNg
         cnxg==
X-Gm-Message-State: ACrzQf0MEQZnir1yPKFf56VjXlvLtmPHtiuACeWONf1QeCTnT/+ekEft
        TnRUltOydJDc/bxEdFTA7i8=
X-Google-Smtp-Source: AMsMyM4A7bxk+UUZZ6+jWJywTLMOfAprhp7XASLUeD3iC5JIJ6pkwYPt0j20GNMcO2xcI/+MSvlvpw==
X-Received: by 2002:a17:90b:4b41:b0:20a:fe8f:5a3 with SMTP id mi1-20020a17090b4b4100b0020afe8f05a3mr21948417pjb.120.1665825779472;
        Sat, 15 Oct 2022 02:22:59 -0700 (PDT)
Received: from localhost.localdomain (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id v2-20020aa799c2000000b00562a237179esm3076019pfi.131.2022.10.15.02.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 02:22:59 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res@email.cn>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>
Subject: [PATCH] docs/process/howto: Replace C89 with C11
Date:   Sat, 15 Oct 2022 18:22:01 +0900
Message-Id: <20221015092201.32099-1-akiyks@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Commit e8c07082a810 ("Kbuild: move to -std=gnu11") updated
process/programming-language.rst, but failed to update
process/howto.rst.

Update howto.rst and resolve the inconsistency.

Fixes: e8c07082a810 ("Kbuild: move to -std=gnu11")
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Alex Shi <alexs@kernel.org>
Cc: Hu Haowen <src.res@email.cn>
Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
---
 Documentation/process/howto.rst                    | 2 +-
 Documentation/translations/it_IT/process/howto.rst | 2 +-
 Documentation/translations/ja_JP/howto.rst         | 2 +-
 Documentation/translations/ko_KR/howto.rst         | 2 +-
 Documentation/translations/zh_CN/process/howto.rst | 2 +-
 Documentation/translations/zh_TW/process/howto.rst | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index bd15c393ba3c..cb6abcb2b6d0 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -36,7 +36,7 @@ experience, the following books are good for, if anything, reference:
  - "C:  A Reference Manual" by Harbison and Steele [Prentice Hall]
 
 The kernel is written using GNU C and the GNU toolchain.  While it
-adheres to the ISO C89 standard, it uses a number of extensions that are
+adheres to the ISO C11 standard, it uses a number of extensions that are
 not featured in the standard.  The kernel is a freestanding C
 environment, with no reliance on the standard C library, so some
 portions of the C standard are not supported.  Arbitrary long long
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 15c08aea1dfe..052f1b3610cb 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -44,7 +44,7 @@ altro, utili riferimenti:
 - "C:  A Reference Manual" di Harbison and Steele [Prentice Hall]
 
 Il kernel è stato scritto usando GNU C e la toolchain GNU.
-Sebbene si attenga allo standard ISO C89, esso utilizza una serie di
+Sebbene si attenga allo standard ISO C11, esso utilizza una serie di
 estensioni che non sono previste in questo standard. Il kernel è un
 ambiente C indipendente, che non ha alcuna dipendenza dalle librerie
 C standard, così alcune parti del C standard non sono supportate.
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index b47a682d8ded..b8eeb45a02d4 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -65,7 +65,7 @@ Linux カーネル開発のやり方
  - 『新・詳説 C 言語 H&S リファレンス』 (サミュエル P ハービソン/ガイ L スティール共著 斉藤 信男監訳)[ソフトバンク]
 
 カーネルは GNU C と GNU ツールチェインを使って書かれています。カーネル
-は ISO C89 仕様に準拠して書く一方で、標準には無い言語拡張を多く使って
+は ISO C11 仕様に準拠して書く一方で、標準には無い言語拡張を多く使って
 います。カーネルは標準 C ライブラリに依存しない、C 言語非依存環境です。
 そのため、C の標準の中で使えないものもあります。特に任意の long long
 の除算や浮動小数点は使えません。カーネルがツールチェインや C 言語拡張
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index df53fafd1b10..969e91a95bb0 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -62,7 +62,7 @@ Documentation/process/howto.rst
  - "Practical C Programming" by Steve Oualline [O'Reilly]
  - "C:  A Reference Manual" by Harbison and Steele [Prentice Hall]
 
-커널은 GNU C와 GNU 툴체인을 사용하여 작성되었다. 이 툴들은 ISO C89 표준을
+커널은 GNU C와 GNU 툴체인을 사용하여 작성되었다. 이 툴들은 ISO C11 표준을
 따르는 반면 표준에 있지 않은 많은 확장기능도 가지고 있다. 커널은 표준 C
 라이브러리와는 관계없이 freestanding C 환경이어서 C 표준의 일부는
 지원되지 않는다. 임의의 long long 나누기나 floating point는 지원되지 않는다.
diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index 5bf953146929..888978a62db3 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -45,7 +45,7 @@ Linux内核大部分是由C语言写成的，一些体系结构相关的代码
  - "C:  A Reference Manual" by Harbison and Steele [Prentice Hall]
    《C语言参考手册（原书第5版）》（邱仲潘 等译）[机械工业出版社]
 
-Linux内核使用GNU C和GNU工具链开发。虽然它遵循ISO C89标准，但也用到了一些
+Linux内核使用GNU C和GNU工具链开发。虽然它遵循ISO C11标准，但也用到了一些
 标准中没有定义的扩展。内核是自给自足的C环境，不依赖于标准C库的支持，所以
 并不支持C标准中的部分定义。比如long long类型的大数除法和浮点运算就不允许
 使用。有时候确实很难弄清楚内核对工具链的要求和它所使用的扩展，不幸的是目
diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
index 86b0d4c6d6f9..8fb8edcaee66 100644
--- a/Documentation/translations/zh_TW/process/howto.rst
+++ b/Documentation/translations/zh_TW/process/howto.rst
@@ -48,7 +48,7 @@ Linux內核大部分是由C語言寫成的，一些體系結構相關的代碼
  - "C:  A Reference Manual" by Harbison and Steele [Prentice Hall]
    《C語言參考手冊（原書第5版）》（邱仲潘 等譯）[機械工業出版社]
 
-Linux內核使用GNU C和GNU工具鏈開發。雖然它遵循ISO C89標準，但也用到了一些
+Linux內核使用GNU C和GNU工具鏈開發。雖然它遵循ISO C11標準，但也用到了一些
 標準中沒有定義的擴展。內核是自給自足的C環境，不依賴於標準C庫的支持，所以
 並不支持C標準中的部分定義。比如long long類型的大數除法和浮點運算就不允許
 使用。有時候確實很難弄清楚內核對工具鏈的要求和它所使用的擴展，不幸的是目

base-commit: 1eb303dc5fa5967f9e5edc04df1f9cf161614ad0
-- 
2.25.1

