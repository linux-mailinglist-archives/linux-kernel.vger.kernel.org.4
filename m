Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D3608E2B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJVPsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 11:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJVPsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 11:48:18 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C76C24F787
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 08:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666453692; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=aX+c+3sqfxc9z+dl9x6y8cih5DwAHQNXedRIwbslvq+h8rlWYFSwSvzRHIcb51NNdAToI9jCOFLfweZKSB55cLOG5QufolAn7/RfrnELC72uzMx89MVcXBL+i8PBMWMvOcluGR0XG36ljkDTiVlKioLQ/XuufH7eEqfFZgpCZ9Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666453692; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Reply-To:Subject:To; 
        bh=k86z11QiGLM7/rSPsn/K977IgcOtMrJbCuc0HoOvE2k=; 
        b=nQWaIp5wZY+1TCVDuhmUG3Khpx6vN0qEiTRgK6kjcGlRhHw2dE/qnMETZRDvDaD1amZ6P4nS92NdcK69q+lbbm7eRULY5sHY6xa60R/lI1JbaT+G5xlr6fpTcDG5Djnc8Yh3YQXji3M1i7qbqjljyJZN/qgYIMZxiKlQ3rglk2s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666453692;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Message-ID:Subject:Subject:From:From:Reply-To:Reply-To:To:To:Cc:Cc:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id;
        bh=k86z11QiGLM7/rSPsn/K977IgcOtMrJbCuc0HoOvE2k=;
        b=IvFfk1nBh3VaPuVQYIToRuxNG+FL0qqPM1W1hGfmxwjex1ymKRPlKNOpVT6f7Vrw
        HvCyX7hVwCYSdlmZBRSggvLMJNxkQOEJW9cAyR2Qtge0VtpipA/N9jpOJVO9MsGIFAw
        moNiqlLtczAa7Igv0KRmo6ZU2n3b5RyXPzCX2py4=
Received: from [192.168.0.106] (101.128.127.165 [101.128.127.165]) by mx.zohomail.com
        with SMTPS id 166645369256132.12809450240286; Sat, 22 Oct 2022 08:48:12 -0700 (PDT)
Message-ID: <d4898956a848c85fc93c3f7d25cafbfc49a46e60.camel@zohomail.com>
Subject: [PATCH 1/3] Staging: rtl8192e: rtl819x_HTProc: fixed missing blank
 space
From:   Aaron Lawrence <t4rmin@zohomail.com>
Reply-To: cover.1666450553.git.t4rmin@zohomail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sat, 22 Oct 2022 22:48:08 +0700
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

From e6635103e3cf2426220767955b99d2e2b62a7329 Mon Sep 17 00:00:00 2001
Message-Id: <e6635103e3cf2426220767955b99d2e2b62a7329.1666450553.git.t4rmin=
@zohomail.com>
In-Reply-To: <cover.1666450553.git.t4rmin@zohomail.com>
References: <cover.1666450553.git.t4rmin@zohomail.com>
From: Aaron Lawrence <t4rmin@zohomail.com>
Date: Sat, 22 Oct 2022 20:46:25 +0700
Subject: [PATCH 1/3] Staging: rtl8192e: rtl819x_HTProc: fixed missing blank
 space

Added a missing blank space as per the Linux kernel coding-style
regulations. The issue was flagged by the checkpatch script as a
warning.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rt=
l8192e/rtl819x_HTProc.c
index ef3dca51cf99..b763cf0ba356 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -70,6 +70,7 @@ static u8 LINKSYS_MARVELL_4400N[3] =3D {0x00, 0x14, 0xa4}=
;
 void HTUpdateDefaultSetting(struct rtllib_device *ieee)
 {
 struct rt_hi_throughput *pHTInfo =3D ieee->pHTInfo;
+
 pHTInfo->bRegShortGI20MHz =3D 1;
 pHTInfo->bRegShortGI40MHz =3D 1;
--=20
2.38.1


