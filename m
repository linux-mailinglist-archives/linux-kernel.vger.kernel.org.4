Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BBD72A88E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFJC7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFJC7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:59:32 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B855F3AAC;
        Fri,  9 Jun 2023 19:59:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E7BC45C019F;
        Fri,  9 Jun 2023 22:59:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 09 Jun 2023 22:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1686365969; x=1686452369; bh=fqqfREt6el0H4FUtv/UFCMik/
        ekaqDFx+K8V6xPHXrA=; b=XHmMz2/TUW0yymNJduvfAI7TWUn2doI7XIGh3aeMi
        I9DOUUxXtUb5JpEW4XKybSf1DLiIyxjVOKBlUxJAbvPa9vD/FrysI9DXX6YuZe9q
        EyBAgoQbm/ddgbTsskP4aTOVq/brmhpYAwII7cZqgveNtm65I6gruAHDHGHmy3Lj
        IqvkKK1ityrxYmqMlR5xLhHMX1lSjD56PQe0WoayB936GgRCViGp2qSECeLef98L
        WjHF7grogPlYLGCm4aaN5KA+In9aS5p5RmTJf03XJyhWfNfCmdNtPiYxaV0ofdwy
        p/4WcorAeRumhBXEOOiz2qW6yVznVvsVLc86K12yw0+Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1686365969; x=1686452369; bh=f
        qqfREt6el0H4FUtv/UFCMik/ekaqDFx+K8V6xPHXrA=; b=bCkb0S9qaYw8Fhd54
        5wZBtSL6oakDSto/n91eKd2nRtAH3fjbIPrtzAaCpNTNiaHXo7GyJsRq9aJ1Qk9R
        4R4N3PbYB1MI8x+1KG0n40mpSuu9AaWPtWnNfsDe+EF5OpPd7JUPOao1gWU0p7+/
        ksbXJ8YcliKzdza+3AFj8c/lGWp8AA0xHq/RADyqjWolew1utIAZ9jW1UQxMIAgM
        p6XhFilcTIrtUjumjzTiDgYe8ePoz05Bcls31udSVFyYyoXOnnlMPwqeWcXWB0Sz
        y4ECLpJJdNdccFKAMkMV83KhVtQ2Td7i9VXieZ5ZLXPnK7NZEWurQ6vdMIuojKcP
        yTTbg==
X-ME-Sender: <xms:EOeDZOiw4cYUSQzMCP1JJN-Qfh-TBB33eoHDkJB_4H_H7uve2PCWOQ>
    <xme:EOeDZPDe3gAoT11JA6Trlha6SB6z6Ti_vDULUM_91Sh4fpcVkRPkAiDwCCLhkuzIj
    rEy5MwL6EGJeCY>
X-ME-Received: <xmr:EOeDZGHk0DevVbhRG5On2z84eMczrD0oEh4S8_FfnhAVdKuKtUgeyxCF0Q23NbfefHR1hu0sk6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtledgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeekieeljeeutefgieejfffglefhieet
    veffleefudefjeegleejvdelvdefueffveenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggv
    mhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:EOeDZHTPb10tgvzuk4Q6r-YlLRNmxE6XgYUSvtjAQCjzIzyRz3fO-A>
    <xmx:EOeDZLxQMVAHaUOnt82CchjE9ebQsGe3lL5MIFhZipNfifeu-NNIqw>
    <xmx:EOeDZF7kvmmucCUMSgqgwH1BEbAb2xldb2Z8Jua_LQsglPreiowQ9Q>
    <xmx:EeeDZMryYT-OR_G3h3vJvhsVTbhSl5lREuMt-XvP814z6VpnyNEzTw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jun 2023 22:59:26 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH 1/4] Rip out simple_strtoll()
Date:   Fri,  9 Jun 2023 22:57:56 -0400
Message-Id: <20230610025759.1813-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not used anywhere but its own unit tests.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 Documentation/dev-tools/checkpatch.rst             |  9 ++++-----
 Documentation/process/deprecated.rst               |  5 ++---
 .../translations/it_IT/process/deprecated.rst      |  9 ++++-----
 .../translations/sp_SP/process/deprecated.rst      | 14 +++++++-------
 include/linux/kstrtox.h                            |  1 -
 lib/kstrtox.c                                      |  2 +-
 lib/test_scanf.c                                   | 10 ----------
 lib/vsprintf.c                                     | 14 --------------
 8 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index c3389c6f38381f038ed5d9a884f2d333a749f8a2..0ae0ca80beb0c0171e8c04306cb5b9ccbc9fa713 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -290,11 +290,10 @@ API usage
     See: https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on
 
   **CONSIDER_KSTRTO**
-    The simple_strtol(), simple_strtoll(), simple_strtoul(), and
-    simple_strtoull() functions explicitly ignore overflows, which
-    may lead to unexpected results in callers.  The respective kstrtol(),
-    kstrtoll(), kstrtoul(), and kstrtoull() functions tend to be the
-    correct replacements.
+    The simple_strtol(), simple_strtoul(), and simple_strtoull() functions
+    explicitly ignore overflows, which may lead to unexpected results in
+    callers.  The respective kstrtol(), kstrtoll(), kstrtoul(), and kstrtoull()
+    functions tend to be the correct replacements.
 
     See: https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
 
diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index f91b8441f2ef70576c5bad079e631e4077eabed6..b2f677eb6d6b12df63003b00960ef27b1656e4c3 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -109,10 +109,9 @@ For more details, also see array3_size() and flex_array_size(),
 as well as the related check_mul_overflow(), check_add_overflow(),
 check_sub_overflow(), and check_shl_overflow() family of functions.
 
-simple_strtol(), simple_strtoll(), simple_strtoul(), simple_strtoull()
+simple_strtol(), simple_strtoul(), simple_strtoull()
 ----------------------------------------------------------------------
-The simple_strtol(), simple_strtoll(),
-simple_strtoul(), and simple_strtoull() functions
+The simple_strtol(), simple_strtoul(), and simple_strtoull() functions
 explicitly ignore overflows, which may lead to unexpected results
 in callers. The respective kstrtol(), kstrtoll(),
 kstrtoul(), and kstrtoull() functions tend to be the
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
index ba0ed7dc154c95e0e973cb51cc36b95e786079a8..cdc0aa107bce7f4018ad241a02b4f701974e52b4 100644
--- a/Documentation/translations/it_IT/process/deprecated.rst
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -118,12 +118,11 @@ Per maggiori dettagli fate riferimento a array3_size() e flex_array_size(), ma
 anche le funzioni della famiglia check_mul_overflow(), check_add_overflow(),
 check_sub_overflow(), e check_shl_overflow().
 
-simple_strtol(), simple_strtoll(), simple_strtoul(), simple_strtoull()
+simple_strtol(), simple_strtoul(), simple_strtoull()
 ----------------------------------------------------------------------
-Le funzioni simple_strtol(), simple_strtoll(),
-simple_strtoul(), e simple_strtoull() ignorano volutamente
-i possibili overflow, e questo può portare il chiamante a generare risultati
-inaspettati. Le rispettive funzioni kstrtol(), kstrtoll(),
+Le funzioni simple_strtol(), simple_strtoul(), e simple_strtoull() ignorano
+volutamente i possibili overflow, e questo può portare il chiamante a generare
+risultati inaspettati. Le rispettive funzioni kstrtol(), kstrtoll(),
 kstrtoul(), e kstrtoull() sono da considerarsi le corrette
 sostitute; tuttavia va notato che queste richiedono che la stringa sia
 terminata con il carattere NUL o quello di nuova riga.
diff --git a/Documentation/translations/sp_SP/process/deprecated.rst b/Documentation/translations/sp_SP/process/deprecated.rst
index d52120e0d75354d0d32c33d631f9f364eba32f82..f0ba93e7188f02ae98a8533e2dfee4c82cf78c5c 100644
--- a/Documentation/translations/sp_SP/process/deprecated.rst
+++ b/Documentation/translations/sp_SP/process/deprecated.rst
@@ -117,14 +117,14 @@ como también la familia de funciones relacionadas check_mul_overflow(),
 check_add_overflow(), check_sub_overflow(), y check_shl_overflow().
 
 
-simple_strtol(), simple_strtoll(), simple_strtoul(), simple_strtoull()
+simple_strtol(), simple_strtoul(), simple_strtoull()
 ----------------------------------------------------------------------
-Las funciones: simple_strtol(), simple_strtoll(), simple_strtoul(), y
-simple_strtoull() explícitamente ignoran los desbordamientos, lo que puede
-llevar a resultados inesperados por las funciones que las llaman. Las
-funciones respectivas kstrtol(), kstrtoll(), kstrtoul(), y kstrtoull()
-tienden a ser reemplazos correctos, aunque nótese que necesitarán que la
-cadena de caracteres termine en NUL o en el carácter de línea nueva.
+Las funciones: simple_strtol(), simple_strtoul(), y simple_strtoull()
+explícitamente ignoran los desbordamientos, lo que puede llevar a
+resultados inesperados por las funciones que las llaman. Las funciones
+respectivas kstrtol(), kstrtoll(), kstrtoul(), y kstrtoull() tienden a
+ser reemplazos correctos, aunque nótese que necesitarán que la cadena de
+caracteres termine en NUL o en el carácter de línea nueva.
 
 
 strcpy()
diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 529974e22ea799adf5c07b48d803ac9bfc1f85a4..c3ed0ce20be49fba185937e3fd0f949e7be6f9a4 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -145,7 +145,6 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
 extern long simple_strtol(const char *,char **,unsigned int);
 extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
-extern long long simple_strtoll(const char *,char **,unsigned int);
 
 static inline int strtobool(const char *s, bool *res)
 {
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 08c14019841af9df6d1c354b4503ecee4c7a9da0..3397a91e07dbad814bb0f2c93d19761a375bedc5 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -150,7 +150,7 @@ EXPORT_SYMBOL(kstrtoull);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Preferred over simple_strtoll(). Return code must be checked.
+ * Return code must be checked.
  */
 noinline
 int kstrtoll(const char *s, unsigned int base, long long *res)
diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index b620cf7de503542a98f38c45c76e9043b242746e..73e6e912f39c7746b1aaaf35eeb562c9c2d3fac8 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -727,15 +727,6 @@ static void __init test_simple_strtoull(void)
 	test_simple_strtoxx(unsigned long long, simple_strtoull, "0x%llx", 0);
 }
 
-static void __init test_simple_strtoll(void)
-{
-	test_simple_strtoxx(long long, simple_strtoll, "%lld",	 10);
-	test_simple_strtoxx(long long, simple_strtoll, "%lld",	 0);
-	test_simple_strtoxx(long long, simple_strtoll, "%llx",	 16);
-	test_simple_strtoxx(long long, simple_strtoll, "0x%llx", 16);
-	test_simple_strtoxx(long long, simple_strtoll, "0x%llx", 0);
-}
-
 static void __init test_simple_strtoul(void)
 {
 	test_simple_strtoxx(unsigned long, simple_strtoul, "%lu",   10);
@@ -800,7 +791,6 @@ static void __init selftest(void)
 	test_numbers();
 
 	test_simple_strtoull();
-	test_simple_strtoll();
 	test_simple_strtoul();
 	test_simple_strtol();
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 40f560959b169b4c4ac6154d658cfe76cfd0c5a6..a60d348efb276d66ca07fe464883408df7fdab97 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -144,20 +144,6 @@ static long long simple_strntoll(const char *cp, size_t max_chars, char **endp,
 	return simple_strntoull(cp, max_chars, endp, base);
 }
 
-/**
- * simple_strtoll - convert a string to a signed long long
- * @cp: The start of the string
- * @endp: A pointer to the end of the parsed string will be placed here
- * @base: The number base to use
- *
- * This function has caveats. Please use kstrtoll instead.
- */
-long long simple_strtoll(const char *cp, char **endp, unsigned int base)
-{
-	return simple_strntoll(cp, INT_MAX, endp, base);
-}
-EXPORT_SYMBOL(simple_strtoll);
-
 static noinline_for_stack
 int skip_atoi(const char **s)
 {
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

