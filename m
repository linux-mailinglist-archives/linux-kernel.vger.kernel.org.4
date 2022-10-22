Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7728608E3F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 17:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJVPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 11:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJVPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 11:48:50 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38076254753
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 08:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666453718; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QhV7BPIHhLuHizltffvkqwhw8szTSptOai7mppWCbSM60DUzjufZMpx/pkRgVIksaOmuwcWjFuRZIziYpD3EI1GfDc1Ysa6Djs+IxstfPiHpXdSpi29zO2EHd+Qr30Fq0nKXgpfnLS6OutdfsY5rwE22CNf+aeadDJDIU5FDJW0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666453718; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Reply-To:Subject:To; 
        bh=PLteAvlu7tiizFV31JvLcda9oMjY/1RcKBLkVXlBxGs=; 
        b=byTRgMWpD5zKufMRy/aw65RI1sADnVp7BVq0/tHjpxXaDsaIsFpYm7qOi8Xviwslc/sxXDIeujGea9TVYFr6tAdWCvI++j0KT3JpAW+itNoiJ1ML8NgRIgP+hsokQStgXxjmVu4ebrwVrG6GoXnTFDdo2dJGlncrHVTkTNSlwQo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666453718;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Message-ID:Subject:Subject:From:From:Reply-To:Reply-To:To:To:Cc:Cc:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id;
        bh=PLteAvlu7tiizFV31JvLcda9oMjY/1RcKBLkVXlBxGs=;
        b=bGD+nyVj3tMWDyM7mbFXgP0csPTJh2Tb1XoUv+qFC7kWDKfs/N2Y9W4Lx65VYG/G
        lETXR6gqOG0iFD84ZyC2cAZ5+ZmNk+oWe8xL1E6zZcPdOOt3QEGIkYG1fcUyK6O3xkh
        sKhP4pdpe2ePgM7sDWCZQr3FHukWs3mRxs6+JvNw=
Received: from [192.168.0.106] (101.128.127.165 [101.128.127.165]) by mx.zohomail.com
        with SMTPS id 1666453717717477.2049524546918; Sat, 22 Oct 2022 08:48:37 -0700 (PDT)
Message-ID: <46c341df004f1dd807caca8aef5e9fb4c217f671.camel@zohomail.com>
Subject: [PATCH 3/3] Staging: rtl8192e: rtl819x_HTProc: fixed unnecessary
 parentheses
From:   Aaron Lawrence <t4rmin@zohomail.com>
Reply-To: cover.1666450553.git.t4rmin@zohomail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sat, 22 Oct 2022 22:48:33 +0700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From d2168b90726dda2f02279a3483b53b8d9b34cb30 Mon Sep 17 00:00:00 2001
Message-Id: <d2168b90726dda2f02279a3483b53b8d9b34cb30.1666450553.git.t4rmin=
@zohomail.com>
In-Reply-To: <cover.1666450553.git.t4rmin@zohomail.com>
References: <cover.1666450553.git.t4rmin@zohomail.com>
From: Aaron Lawrence <t4rmin@zohomail.com>
Date: Sat, 22 Oct 2022 20:52:58 +0700
Subject: [PATCH 3/3] Staging: rtl8192e: rtl819x_HTProc: fixed unnecessary
 parentheses

Fixed multiple unnecessary parentheses as per the Linux kernel
coding-style regulations. The issues were flagged by the
checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rt=
l8192e/rtl819x_HTProc.c
index a701be8c2923..62aa8e893c34 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -285,7 +285,7 @@ void HTConstructCapabilityElement(struct rtllib_device =
*ieee, u8 *posHTCap,
 		u8	EWC11NHTCap[] =3D {0x00, 0x90, 0x4c, 0x33};
=20
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE =3D (struct ht_capab_ele *)&(posHTCap[4]);
+		pCapELE =3D (struct ht_capab_ele *)&posHTCap[4];
 		*len =3D 30 + 2;
 	} else {
 		pCapELE =3D (struct ht_capab_ele *)posHTCap;
@@ -644,13 +644,13 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	pHTInfo->current_mpdu_density =3D pHTInfo->MPDU_Density;
 	pHTInfo->CurrentAMPDUFactor =3D pHTInfo->AMPDU_Factor;
=20
-	memset((void *)(&(pHTInfo->SelfHTCap)), 0,
+	memset((void *)(&pHTInfo->SelfHTCap), 0,
 	       sizeof(pHTInfo->SelfHTCap));
-	memset((void *)(&(pHTInfo->SelfHTInfo)), 0,
+	memset((void *)(&pHTInfo->SelfHTInfo), 0,
 	       sizeof(pHTInfo->SelfHTInfo));
-	memset((void *)(&(pHTInfo->PeerHTCapBuf)), 0,
+	memset((void *)(&pHTInfo->PeerHTCapBuf), 0,
 	       sizeof(pHTInfo->PeerHTCapBuf));
-	memset((void *)(&(pHTInfo->PeerHTInfoBuf)), 0,
+	memset((void *)(&pHTInfo->PeerHTInfoBuf), 0,
 	       sizeof(pHTInfo->PeerHTInfoBuf));
=20
 	pHTInfo->sw_bw_in_progress =3D false;
@@ -666,7 +666,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	pHTInfo->iot_ra_func =3D 0;
=20
 	{
-		u8 *RegHTSuppRateSets =3D &(ieee->RegHTSuppRateSet[0]);
+		u8 *RegHTSuppRateSets =3D &ieee->RegHTSuppRateSet[0];
=20
 		RegHTSuppRateSets[0] =3D 0xFF;
 		RegHTSuppRateSets[1] =3D 0xFF;
--=20
2.38.1



