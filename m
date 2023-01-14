Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1643466AA3A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 09:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjANIvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 03:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjANIvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 03:51:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC2F5B8C;
        Sat, 14 Jan 2023 00:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673686261; bh=qDiU8VzRpc8nbJnYzYiamI1ZZHk6Ixfnz0knnvQyrtw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=culIWb2uze8BZDLoxLW3BOBsno2ppEyXLxjZck1m6j2ct080SjWu6y9zkAG7AEZxb
         JK++ri/ia8H7dSfJONvL4nHLs2irhTS8qzR0XESaeZpkjbcVawveS20dRrkAJGuTS3
         dm4vXyrU2pt4v5wJJGvBtvj4rgzQxXNpRO+HiN9Erp2ROQB8jhwvDdNyYdMCA+6RGi
         Y0MgZMJZBlxlCpeXitRne1zJ6rwbp0ubQFx5NKKQgoAWMt2NYPnUccGcrfSB6/puGG
         P3Y/FF9gsiripXGkTVxQacAu90eemLhWaw6TluSaCEdmU5UHQDvfpsVxf9Rszx4348
         7pTKrQHdJ8pkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MG9g4-1pX5JJ0ZNU-00GXYi; Sat, 14 Jan 2023 09:51:01 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ACPI: battery: Increase maximum string length
Date:   Sat, 14 Jan 2023 09:50:53 +0100
Message-Id: <20230114085053.72059-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230114085053.72059-1-W_Armin@gmx.de>
References: <20230114085053.72059-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zYDjh5yQ6xfg+VdyX+ZG78depAZcOfdAewOPFoaubCgLLSYJ6KF
 t80XIBjuMtxn08FpN+opH2TXsQ3ChX7tc2WGyZ3u+u6p5baMKjftlYaKZmHQ+qbGdUOb5cZ
 5cE2VUwKRVOu4MvUN2TCyVuVgPfOlrIuM74gSrxUZlvJ5e3oXVdlZtgDt3YUjst0cyDbI6C
 epSCx8aO76ZQSVahx7hxQ==
UI-OutboundReport: notjunk:1;M01:P0:NbzVKmFVonI=;nJZYmEX/rQXm9ia6oRISMQ1AjpW
 ZxcunGQqQWKtP5CePJ+o1mt19Z+mHFcnsF4RnEjgBbo7HZMHiiqHGGz+gvcaJySn/w7IBYSdN
 PhZxMSyLHyH/dMzEbAPPGzDKkCkfh3lRN+2azuVPJwmluJdKvHm78mzSqYXri4m2VRy0FVVjl
 YuaZkYwXOfjM62DY12n+qAKorVTxT8jczZ3q766B1hayPC5vi820CS3mMvZg+nVIZidiKG0Md
 X/NDkIvnH5WFn+jvEm/tbtzOTyTwMvkq4+0OfHEUQUmJeHqTG/qLTKcSV+narayuAFIjaTgna
 BVWg4oOQGERgCsPZXQUXRWmp00QvJB78ZAuD0ataNFMcO6yrBN94jnpkGitxPXWFf/aS3DZJ2
 XrmHrgMAsyYPkMJstj1ctI/QJZHEkCjw78M+Q1myMnQtRZ45EwaclbgKXAIlK42EXCwp2br4S
 8KXNQjRJ9cdILGjOmKs4a1y00yKtG68aQHlmJ95+JzIz6XcP34N0u9U3uD8auGNAGmsM4WIa7
 jLbE9LF0DWZbDLOFQ1B8D+WawCg3pjC9pjBylC5kXtlRJ6cUiFMHEn+5026pLHFpgBvR7SsUU
 +1YsupgP+mc6NLcjUqv7+qtmpD2advaO14kfWy21DMsNAEHrdl5DzftAtlF7y+FI6yXlvWPt5
 qLqGcVTQjNyOwsZ3ImL0dk3mJm1eoQPN9SRtlPK/eYRhZqZEIS8QSYTTYqisV3Wa7tkJVbsBI
 WP6239nLhetmx7Db46Ux0Cw0PxrW/vvEHRq5oaEt70NCgEnsQd7gXGTyIuevHgqDB5g+0wAWk
 kYCdCDuPulhRlfDYADVkx0/eYX4PxcZlzkoHWP6s6BUtvQDX9orbs6f1ruDFD6I/ZOtj+4Xvc
 OU/vjRZji69/RVtfZRKTD08mUw88IRKYlbgXDLRxvrjXvwW7pbghkTXtzYy+sJmQXcm+9cAgT
 Z1bIjH8Kt0Kw49RIoGAnlzm06xw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Dell Inspiron 3505, the battery model name
is represented as a hex string containing seven numbers,
causing it to be larger than the current maximum string
length (32).
Increase this length to 64 to avoid truncating the string
in such cases. Also introduce a common define for the length.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b39b84b8f3ae..9f4c31484adc 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -42,6 +42,8 @@
 #define ACPI_BATTERY_STATE_CHARGING	0x2
 #define ACPI_BATTERY_STATE_CRITICAL	0x4

+#define MAX_STRING_LENGTH	64
+
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("ACPI Battery Driver");
@@ -118,10 +120,10 @@ struct acpi_battery {
 	int capacity_granularity_1;
 	int capacity_granularity_2;
 	int alarm;
-	char model_number[32];
-	char serial_number[32];
-	char type[32];
-	char oem_info[32];
+	char model_number[MAX_STRING_LENGTH];
+	char serial_number[MAX_STRING_LENGTH];
+	char type[MAX_STRING_LENGTH];
+	char oem_info[MAX_STRING_LENGTH];
 	int state;
 	int power_unit;
 	unsigned long flags;
@@ -440,12 +442,12 @@ static int extract_package(struct acpi_battery *batt=
ery,

 			switch (element->type) {
 			case ACPI_TYPE_STRING:
-				strscpy(ptr, element->string.pointer, 32);
+				strscpy(ptr, element->string.pointer, MAX_STRING_LENGTH);

 				break;
 			case ACPI_TYPE_BUFFER:
 				strscpy(ptr, element->buffer.pointer,
-					min_t(u32, element->buffer.length + 1, 32));
+					min_t(u32, element->buffer.length + 1, MAX_STRING_LENGTH));

 				break;
 			case ACPI_TYPE_INTEGER:
=2D-
2.30.2

