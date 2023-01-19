Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8073B673B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjASOVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjASOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:21:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E9B3ABA;
        Thu, 19 Jan 2023 06:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674138081; bh=Ny0LIyIy4GYeNxVRqsepIJrTH+brTIWy5Eqgj908uvM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=BQy6kjqtVPWffHeFMB7//sMS/abEsee7PWsSBv0cSuNS+s7CBcVSjTwOOjTrim4L1
         EqDbbXxPYWKLxuyjkHeOdeQYI/isNk8fdvPZBH/EdCggRyXMbPYXeFZSkLczFWlkUn
         653wVfO83COuLw/V1TLK3hKKEHHTniORt0HU5ODFl18+pbRC30Ra0cIc3bFV3D3+Bk
         NmA7q4X9xQ8SdVqefbtN+4b0bXemc15fM9d1Z008VBcGvtGq/HBvD6SyuRjn51csLu
         yKvBfFhQSHPs/G6XbAIqQdy4aEdu2IETdjGeb0jBK9ESqvREiTj/OIEC9+2Rlolk8U
         cb9ZZ4VRBOyoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MgvrB-1omTEb3cCr-00hKKe; Thu, 19 Jan 2023 15:21:20 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ACPI: battery: Fix various string handling issues
Date:   Thu, 19 Jan 2023 15:21:13 +0100
Message-Id: <20230119142115.38260-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J+xZQwCdYjduuupMiKWHSxhYonytUIVNgNt8jouF7YexN/V9PFe
 N2eDHLVOPkxnGmbLZPAMmAzqY1YHDsvE3s+phqMcjgqTY6EMnmUwn/zLKG8sDVt6T/G7zL3
 Sv1B9zjjEq7zAI8OgqjTVpC+287YXQfebG/ruiVtCWPTzUUzyJXxoZ8jFMHmegId12Dc0NL
 jhaLq5crKJl4ECBycTblg==
UI-OutboundReport: notjunk:1;M01:P0:YX+0BR3tP+s=;TmUGic/D7nPR5cvCyCBpGyhBZZd
 2Waqveq+Gn7bDybQD/6SHnTAN4y8JK7avKw5IJbGVX2r/k4YdmChbsqUDAj5OHtbiiwPH15kk
 EPwTQhmD+dsn0kaFtfcaktTPnKKL/jKvrfyFqFflsUvOftb6xNR+3WzrukIzaO/Y4s1HKPodm
 pr9Ey2TpFutdP5Uwdc44sSfoFAhZMf2V9yMHl8MXWyxOBwzRE6nKSY2vw+ICx5m3WVWCitx6i
 MnUJ5rTb/heobFTmSl1FOk/WPZObyUIEilwR78rzeL4mlaNiwZN48rk5XilN2IQyUE5ulB1yW
 lYNmfEJFEXOq3uDSKVgbtVclKEo+emaWglW6IbxhCbdtoUVevvwal5huR8FYlSRErPdjNDm+i
 mn/E91Ff0Y+THHBPtTwynlj4yYItPQNmpEnvCnF3z56bhv6uI6bvrFn19T/T7HcokFmXJcE9f
 iuujDBqpLON0c5umgElinZ8hTzmqKa7IqsVCgoeoUuVwMiplamnZ1kd2sRWpc4THllwqH0VoO
 /klRFQnTdOqXzxYPnspMGSdIkiSx55a9jv7aM2O6aZ58Eice3UGoOadvg35sA0PRh/yHA+7N0
 zuN8aJvFI+UWoNMavlQpoDiGF2q/Mu8R5FrDBqrwjpRqw22vhVJ8V93OhsN2o0t2UHEDwIs8G
 mNcKVPJZjDS5Zs0DYY+a0gsItmeXLs/rpUDZnmtnTlMlvep9BeSwsIUBut6wu2syaS8TC/wQs
 SQeIr+MJ8Cly0XhZ297bfuFP/PRvYgk1m3MG8bHn91XCYSmOc/+kbJeeZmMYmw4yRXXtAItUs
 vJiUoDZzt8K2/z9EAtUR9fIxCbX5KPgT+lV1ht5dEK9hn16fOvIbf3kCT9GD63wxcpPb7I3Al
 f5cgvBWgcejuJihdNJr2cni2mAoUsFvVYnr2+B6uGXnaXrTdzWdQvBFWU7FFoaPZUehcHKKYo
 8ZzFau0gVsM2pXmxQAUQ+rraVRQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my Dell Inspiron 3505, the battery model name was displayed
differently than when running Windows. While i first suspected an
ACPI issue, it turned out that the real reason was the ACPI battery
driver failing to handle strings larger than 32 bytes.

This caused the model name of the battery (35 bytes long, hex string)
to miss proper NUL-termination, resulting in a buffer overread later.
Luckily, a valid string was stored right after the now invalid string,
appending only the battery serial number to the original model name.

The first patch fixes a potential buffer overread then handling buffers,
while the second patch finally increases the maximum string length to
avoid truncating such larger strings.

The patch series was tested on a Dell Inspiron 3505 and appears
to work properly.
=2D--
Changes in v2:
- Drop first patch since it was already applied
- combine the second and third patch
- do not replace 0 with '\0'
- spell ACPI in capitals
- rework the buffer length hdanling

Armin Wolf (2):
  ACPI: battery: Fix buffer overread if not NUL-terminated
  ACPI: battery: Increase maximum string length

 drivers/acpi/battery.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

=2D-
2.30.2

