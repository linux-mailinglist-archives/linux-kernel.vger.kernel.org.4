Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B43473FBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjF0MPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjF0MPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:15:20 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3973819A8;
        Tue, 27 Jun 2023 05:15:17 -0700 (PDT)
Received: from loongson.cn (unknown [117.81.87.34])
        by gateway (Coremail) with SMTP id _____8CxpMTT0ppk8BYDAA--.4879S3;
        Tue, 27 Jun 2023 20:15:15 +0800 (CST)
Received: from localhost.localdomain (unknown [117.81.87.34])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx3yO60ppkXxIMAA--.8320S2;
        Tue, 27 Jun 2023 20:15:14 +0800 (CST)
From:   WANG Rui <wangrui@loongson.cn>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] rust: build: Define MODULE macro iif the CONFIG_MODULES is enabled
Date:   Tue, 27 Jun 2023 20:14:22 +0800
Message-ID: <20230627121422.112246-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx3yO60ppkXxIMAA--.8320S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWDKFyfuw1xtF13Ww4DAwc_yoW8Gw1fpF
        97W3W8Ka15GF4DtFW8Ary5WF12q34UJ34Dua1DX3y2qFZxJ3sxK3yftFZagrW7ZF4xX34F
        qFs7uayaga4UCwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2txhDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LoongArch does not currently support modules when built with clang.
A pre-processor error is expected on building modules, that's caused by:

 #if defined(MODULE) && defined(CONFIG_AS_HAS_EXPLICIT_RELOCS)
 # if __has_attribute(model)
 #  define PER_CPU_ATTRIBUTES __attribute__((model("extreme")))
 # else
 #  error compiler support for the model attribute is necessary when a recent assembler is used
 # endif
 #endif

This also happens with bindgen too, so it would be better to define
MODULE macro if and only if the CONFIG_MODULES is enabled.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 rust/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index fc8cdcfcc9e5..d31d9fa27ef0 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -295,12 +295,16 @@ endif
 
 bindgen_c_flags_final = $(bindgen_c_flags_lto) -D__BINDGEN__
 
+ifdef CONFIG_MODULES
+bindgen_c_flags_final += -DMODULE
+endif
+
 quiet_cmd_bindgen = BINDGEN $@
       cmd_bindgen = \
 	$(BINDGEN) $< $(bindgen_target_flags) \
 		--use-core --with-derive-default --ctypes-prefix core::ffi --no-layout-tests \
 		--no-debug '.*' \
-		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
+		-o $@ -- $(bindgen_c_flags_final) \
 		$(bindgen_target_cflags) $(bindgen_target_extra)
 
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
-- 
2.41.0

