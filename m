Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7843E63DE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiK3SfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiK3Seu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:34:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D717B93A74;
        Wed, 30 Nov 2022 10:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669833268; bh=NscgIAZRMqN8AzDfYglDMPfWX6oPBec9DPODcgSPEzQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=YilvTdd6MPnBoZF1okZsAnOdDtlZ2xDxGftIohAFdYSH7ZJdr31o1/ZvOiNYzmnCr
         kuWHUmeXrLXvggi0Jxwg1G4MyALqhS8dhk/JaPxXfNxMpjePwg6eqZFo2KZx56tLcX
         IP7QsHsj0uCNOv/3+6IMmQnCHCAECJh/tW67ZkS8ujxo5y46gVP80lH6GUCafumfRx
         zG7qcjtChipGbVgnAcFmv+yyxxCdDClZwedkDmjTRF2On8MMHGblcldzgOrNl29ew3
         4aMh2pAjJG6nDPiWYkfDZM8x5Ur1bLTEih7fWcQ0yGRF59P5NvgbBfhIVkgZUof/1V
         tSj6vntAhDYiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Md6R1-1oQHwt3PsZ-00aGDa; Wed, 30 Nov 2022 19:34:28 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Move error message to make probing silent
Date:   Wed, 30 Nov 2022 19:34:18 +0100
Message-Id: <20221130183418.357246-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cl7FFu4dmz8bgye6pz2NXjuVh20/evlO5cStb+/Bwa9oYVDqVrM
 YXQuPG8DU+ayKe3fj2vQDzWCf8CKbGDGbW4FIonkW/H1FE766zTehnPllk4FAfm5rtLGxn+
 Od8j+Qh9unanFH8fAYcZqxF1eArEt3TAkI4EJu/bceTqeqwMXHsyQRB8EeeaOjySKSJSUkN
 OateN8j4KxN2xLU4zk9Rg==
UI-OutboundReport: notjunk:1;M01:P0:cQXm5xf/vnQ=;JyxUz5l+6szKd3ShbnveZk/XmFc
 CAEWQBO0MUS8AsBaRSXVa87uSC3k+W+y7VrStbbDUDpVmWq1syWlVnhknDt116r32RWg5Idb6
 FBfmffYC6zNyE6iFnNXatcpI5OXTvuma7lROgRbBHIILC9cz1eWNZSEjDlafKAv6tTR6EAay/
 5CEQhUkTZlsdsLHlgTUGFmeXs6lj04ROKpS6VPJizPa+m6FZMzxwcEs0R6dQK+O3++W51eP6Q
 Ix/A+9J5TGpUe/8lhhYOlD7NVsqllsS85xQBhoWTjjMg6LoMBPQYO7sUbfFWv4K0pkELK6jeJ
 tdf1OqoSwGBm5bRwfX+Erh+FCKJXmS8Qr2R8kn29O+llDWvlmW7x6VqLEqbWtnmZH40Tr8w/t
 K9P3nrxvOPejWCYboZUZrxQ0eYUrDY47k7j5iqio8pbXCYL8+/kHWrnSYShg0j+QkTggcFuvq
 zIX0+9+SPXF8VYwHTu1URbbv7ymfEbaNv/NlHwLyu+F6Cvg7MRqjP/D74N3nRh2xBlD1JPMZJ
 Le/UZ5Yq4Rt+a1IJQlRUs7Et2OHvaLPsQG3PR8vSWx61OAcuC9qFt9kDDLV/wqdgMfImsBc/l
 gZlSNJyK3zr34/dNLAGQe7KOqvNLjYEV/cIigCQiUFiQLDVnihrvBnQ0G5GeJu+gXii0fdWQH
 GpYTorNQKJ1EFHHEGBxWoCY3eO0BIROJ4Zvze5UVDvan3hg/na2dyvK3v23kLs2q2lucPiFGE
 X1W6gjxk9p7eFWolIIXM9skveoor0sfGXTPtYfa02IA636XTdgnivmIfv/VMjwBKq4uRzYmA+
 NGjNwJh4Q8tmPDc/n8D41oW+p23aXPa5aFayWtaJYHS0RLlek53fSyn/xj7CVedT8EJLrTUIi
 ii/mFigVyCPFKXJdDNCdF2hiFUdJhnPNoeXjyGCfskhYNKS0lf+OKpe5Jy717rCohOkhluEJW
 QJk3pKbFv0AtkZEiz0BwBVjUDCk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dell-smm-hwmon loads on unsupported hardware like the
Dell XPS 17 9710, an error message is printed.
This might confuse users, as drivers are expected to be
silent if no supported hardware is found.
Reorder the error message so its only printed when the
driver is loaded with the "force" option being set.
Also reword the error message slightly.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 1572b5416015..7ac778aedc68 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1447,9 +1447,10 @@ static int __init i8k_init(void)
 	 */
 	if (i8k_get_dell_signature(I8K_SMM_GET_DELL_SIG1) &&
 	    i8k_get_dell_signature(I8K_SMM_GET_DELL_SIG2)) {
-		pr_err("unable to get SMM Dell signature\n");
 		if (!force)
 			return -ENODEV;
+
+		pr_err("Unable to get Dell SMM signature\n");
 	}

 	dell_smm_device =3D platform_create_bundle(&dell_smm_driver, dell_smm_pr=
obe, NULL, 0, NULL,
=2D-
2.30.2

