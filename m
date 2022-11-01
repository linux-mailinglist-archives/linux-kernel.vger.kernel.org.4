Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1448C614EE4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiKAQMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiKAQMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:12:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C3D1C436
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667319135; bh=q6GkPfpD7CLnsI3bfj3DoIrApGPxoN5WHLC2wxCj9zg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=l8y/QIZz0ikaShF/oooBKXObnJmjzUs3r5M6jjp+2KCLtYppXy0ycnCTgQyZVYYX+
         MDfajdFndJm7bbIBEQW4Nymuj86pl52vC+ClrzcFSnrq7HCIC5vvlU79Upms0O1Qtb
         PZhyQD3msBA7HfF87yUw23ANmQmtKgcs6DyrRoIbbMn09bpV5c/1znoIvy886jcV/7
         mzulwPZFzrktyZtA8iIJppzWiDetHmx2a/5r3mGyEOZaWMz2mwSi8ZRpPDvN15PRog
         9ztdcAM3frMuR0SbdXVWMIoI/lFaazS9+XHC74frbg7T4HkIPFXisz+fdz15Nj68RK
         SAa0SAI9IhGYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.34.126.36]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowGU-1pOkBk3a5G-00qPw6; Tue, 01
 Nov 2022 17:12:14 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bitmap: Fix a typo ("identify map")
Date:   Tue,  1 Nov 2022 17:12:07 +0100
Message-Id: <20221101161207.969265-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6NHg7y6vJ5DGQOptdzIi6UXNCYxzRGXvBDpFsukLM2BHV6OsZlA
 pgBG57415sjLXEAj1Do/si0Ys52lO40E6tAHvb5Sbzp7rUBcevxoP9TJviQ6vbCxwU4nyoJ
 5LC/czVDSSPNAS9zozmxR3kHIJgaNPKebpeJ43ZzCERGM8hXYWnzIyUrB1pFMGmvmP87U1L
 B6Jw1IVxwMbi17e96BJZg==
UI-OutboundReport: notjunk:1;M01:P0:VvACZHWST5M=;gRhpzjT73zwvaT1YtAns/b0WsvU
 aBC9AV40cBWzt9tsqlQgLYj5tf7qF6zPbx12y8yP6jgqa5FdkNPGf2KfEhE8p/sbqECSLEaeN
 +GMkdUFzPh7gOeGKEwIPoIB8Y1hZ5FIEncIdwARWuuly2Z/rcVmyhSDwqtO/XNDj6XoiTbY/w
 QJF+/hHPELpHHpUT5B1eKKj92NuZWIShlGHKJSg5p8gfAxCynr/LeNzUN9jyXFSgrY2ULZ4AU
 oJASLnCm07CpYXC3C8qMDXUEH1T5rM2k45Pg3aiQUE92iZNuJ9KrBgVbQDjBgB5/4Orqs3NUn
 Iux2B+9CXlH6ZJZE9ICxPGEQbabCwHCmCf0h5hToQ9PWDM8CFZELdzWBWV3ACsXZ/NaA6i3OG
 /8mbeFNHmqU4WhCBODmEqExcN01AEWVDsLavpJDgj8Sbj+1QwoQCwJqr8vzGAt9xxH7I49QI1
 dPPBZgnkz4ASu8JIwn1+e8JAeaGHVGKwjnMvl0PXOLfCcywOUWFIwmjgOP89/fFz/PUHUzzJK
 t4gu+89vA3LijrGyN1xcbmjvs67YwNMnCNqV0rvcUsRnt0+x7aJQXHh7XIbmUjQbj+vzYasEH
 g3eTOSfR3qXfWLmP/nhL3MC+R60DMRBrvRmhAIsLMd97GxS8Ho383jCntfrBFrxfUmAPPrDqC
 lBf/ph3/Wp868phMczXShBUzljWdidg8+4abyWkfD2IPMBsEiEAtoMEQRoFs6YGCaveSO3KuK
 ClVjiatb6NQ5BRei1Y8iVddVrDHI1N7Zx8bVA00BXq3iX1CoALkeg6NKGr/q3vk6ktXKy9C/U
 tSKr2fadUG82D0pRmlxiTkPsilWC3VWspVKfVuuNnbHbH40GDya8IevO6p4ryuNhb1YMVRPe7
 5Mx2hioBgTn/hoxSt8anD4/wXX86/6afHWeF22LAccsWvYBS2sKT3Rs2ZJPMrmuMlIS1I6MDo
 3Lr9rc/rbR1cy7FCqUWQ7lvSXL0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A map in which each element is mapped to itself is called an "identity
map".

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 lib/bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 1c81413c51f86..b0f234bc1ce84 100644
=2D-- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -988,7 +988,7 @@ static int bitmap_pos_to_ord(const unsigned long *buf,=
 unsigned int pos, unsigne
  * to @dst.
  *
  * The positions of unset bits in @old are mapped to themselves
- * (the identify map).
+ * (the identity map).
  *
  * Apply the above specified mapping to @src, placing the result in
  * @dst, clearing any bits previously set in @dst.
@@ -1037,7 +1037,7 @@ EXPORT_SYMBOL(bitmap_remap);
  * the position of the m-th set bit in @new, where m =3D=3D n % w.
  *
  * The positions of unset bits in @old are mapped to themselves
- * (the identify map).
+ * (the identity map).
  *
  * Apply the above specified mapping to bit position @oldbit, returning
  * the new bit position.
=2D-
2.35.1

