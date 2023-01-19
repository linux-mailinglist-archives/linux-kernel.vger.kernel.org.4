Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5FE673B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjASOVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjASOVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:21:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE262133;
        Thu, 19 Jan 2023 06:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674138084; bh=FbzFEzuuOBe33q11CFVBIBSo/Y1oAjkTiJWrAEWEqic=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TT1kq7kRKlPGtrx20q3/N8fwu35DUfzhcd6lFHmJQbiIl1fCmawUIs+MmOv3z1eWF
         W6n35jNDW+4Da88joR8vnmYwp3O6YbDiVeBTz6Rs96by/+sVK+NNs54TFFQHzYwyO2
         t5p55wZVZ9uaME9MphGtMehbXK7yRBnNbP7iLB9Gm7+65HK6zCT89ftCeVUHeBBQ4m
         aBZOtLgEM5xwNbHy/QCohzy/9LaBhabeT3JufoteG/5UuaKL3m94/PQGOAcroZr1tG
         ZX3/G+jSqwP8pYcehd2PO1rhwRDIrG/f63EIA9wNwv+aM7KB8HsfaVvRxdAqC4IbP6
         0X0+ZD3BuJGzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N1wll-1oY9KU3S6T-012Kxv; Thu, 19 Jan 2023 15:21:23 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ACPI: battery: Increase maximum string length
Date:   Thu, 19 Jan 2023 15:21:15 +0100
Message-Id: <20230119142115.38260-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230119142115.38260-1-W_Armin@gmx.de>
References: <20230119142115.38260-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y3hAPY55nvDn9rP2gASyCOXpuGfBLwCogm7hwp0Tnep1QK6uiac
 LuqzC4m83H3JtbkuV4ZEOawFUqdOPTpNKQF4/nD50SjMN598qThYEPjHukKiUi612nI4Ci5
 AmFshQzuWuFxMGcStciFMpb+fzBiDo5NUhU2QCo5hTTaV3iZ9f6D6qQCblPd/2e7Wv2o3SF
 sj7SrOo4r+FrDg2MHJ17Q==
UI-OutboundReport: notjunk:1;M01:P0:G5itjEFB8KM=;KJg7/i6h1k50KxlPzDDYmbwiYSO
 ISQv2r4FcKmycbXNE+ocD67ms9N/gj95R0gVSCJ6ZjzWW5+U26sclZQJ9xOHJQIIWsWJqb6VO
 FxGXZsegkP19Km36UIwmpIfYsWAIi0RZmoHWbHyK0LSG4KwQuoCxsB8hq6N21byXoe+0PDi7p
 l/H5uZp4OAacFIQan0GeBc0OsU4fXQAOBUZ2wvCm2NOqFO1I3xBgpEWHgd8+D+wQmx4PdzVWG
 dznrF9K44Y7YGOpGdujXkN4BvZCByjAvYAUOxOmagv+bnn/dlamgYdEEMq6F2payLw7FzBqFq
 QNbkzdh6YNAqGgKYKmAfisHc3tcBViNQUw1FhaaMGO9iN970GqgjdtNtok+9NnYgvfEVgsg7l
 gqzDFmoggQqhjXGLlUlH4dxxYNeq8U/4n3KKdkQjXN6Ypzl4mPnCz6i1pzwC/CJjRt3SYIYo4
 kyIyUji6+UrD29AL2CRYxuW2KWYBryLg73DE8R0jDenUYYhK1LwFOMg0JpWPYVzzJ/zJ8iV/4
 EMqwBkNtv77G1W2cMIOwUzhXRHh3WoLaH24MvmvU+cvTYOKaWRSxt80DytPEQPPVDm06RpDaF
 B9OS3hExK/qv60K0Ka9SbWVyBBGRZCph94UL6R6M6Zb2qWzVwChMzj7T2Lxr83WQq063atdTt
 OV6hXaWD38eun2D1ucDw6GlY7V3/i7q2I/lNSiOyh68KZJWRJ0u2oSRlGvPjcx2uLUU8j2MQo
 0gAGQ5Y7fIWU/wa/FsWIfSyCnWuPRK0DtFtGM+/KV35f+0fAY4h1IqvQlHROvp3flwIh97h8C
 leFJS3KQmPRvGCKsjyuVYn+ghf6A9nBJaYOtBkApIDkQ2FFl9KX1g720OjjyZJ6sT61W7uXcI
 2VlAyuP2x9BHGUa6HQNcKXPQTHE9exi8hWVnVX1D//+VxLNK2ifdvTTVs4qZ3evXzkSPopUx5
 Fw2rnyTuezGFOd95KGI2EUcvQQk=
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
 drivers/acpi/battery.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 0ec12a7dbcca..9c67ed02d797 100644
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
@@ -437,7 +439,7 @@ static int extract_package(struct acpi_battery *batter=
y,
 		element =3D &package->package.elements[i];
 		if (offsets[i].mode) {
 			u8 *ptr =3D (u8 *)battery + offsets[i].offset;
-			u32 len =3D 32;
+			u32 len =3D MAX_STRING_LENGTH;

 			switch (element->type) {
 			case ACPI_TYPE_BUFFER:
=2D-
2.30.2

