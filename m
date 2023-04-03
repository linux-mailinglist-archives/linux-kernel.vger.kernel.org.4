Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00666D4272
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjDCKq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjDCKq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:46:26 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB2310EB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:46:23 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230403104618epoutp03e3cdbbaed3ddb172eca1cac7f69a2abe~SZuzy70KM1067910679epoutp038
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:46:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230403104618epoutp03e3cdbbaed3ddb172eca1cac7f69a2abe~SZuzy70KM1067910679epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680518778;
        bh=u4wHhHxX/wH87CXpAawXg+T4k8pAk6veQgBLbqbmiSw=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=g1ojxlH8Fm2sO/1S7XlhK1Cg1+iyfX7vRygW0uJLMrmnXX3DyHfUsXbAuTCkxsIaO
         xqZqIrAOX9WBBDKirYEasCyIe1YBUx2FX4Ufr4IM/fH+d3PyOKYo/4btwoU2fzdXZF
         42HfyCggYJ6Rtlljj6dYRF0Pqlat8M42BPSQLais=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230403104618epcas1p35ee985525a9fdbfb0974864dd1ad913f~SZuzSVMuC0884908849epcas1p3s;
        Mon,  3 Apr 2023 10:46:18 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.224]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Pqncn6dt9z4x9Q1; Mon,  3 Apr
        2023 10:46:17 +0000 (GMT)
X-AuditID: b6c32a38-39fff70000029402-4b-642aae79fa36
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.7A.37890.97EAA246; Mon,  3 Apr 2023 19:46:17 +0900 (KST)
Mime-Version: 1.0
Subject: [RFC] vsprintf: compile error on %09pK
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     "pmladek@suse.com" <pmladek@suse.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        GyeongHwan Hong <gh21.hong@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
Date:   Mon, 03 Apr 2023 19:46:17 +0900
X-CMS-MailID: 20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTX7dynVaKwcq5hhYvD2labPn9htGi
        e/NMRove96+YLC7vmsNmcW/Nf1aL/4+/slrs3riIzYHDY3bDRRaPnbPusnts+jSJ3aNvyypG
        j/VbrrJ4fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafArECvODG3uDQvXS8v
        tcTK0MDAyBSoMCE7Y/m598wFa4Uqvhz5xNbAOF2gi5GTQ0LARGJR533GLkYuDiGBHYwS73fO
        Yepi5ODgFRCU+LtDGKRGWEBf4u7bB6wgtpCAksTZH1fYIeK6Ek3dq1lAbDYBbYn3CyaB1YgI
        JElM2X+THWQms8A5RomVh+czQizjlZjR/pQFwpaW2L58K1RcVOLm6rfsMPb7YzD1IhKt984y
        Q9iCEg9+7maE6f1z/DkbhF0ssazzAROEXSOx4twqqLi5RMPblWA2r4CvxKl9x8DmswioSnTf
        72YE+VFCwEVi9i9FkDAz0P3LFr5mBgkzC2hKrN+lDzFFUWLn77lw1zds/M2OzmYW4JN497WH
        FSa+Y94TqGvUJFqefYWKy0j8/feMFWKrh0TfYuMJjIqzEOE8C8kNsxBuWMDIvIpRLLWgODc9
        tdiwwAQetcn5uZsYwQlTy2IH49y3H/QOMTJxMB5ilOBgVhLhVe3SShHiTUmsrEotyo8vKs1J
        LT7EaAr0/ERmKdHkfGDKziuJNzSxNDAxMzKxMLY0NlMS5xW3PZksJJCeWJKanZpakFoE08fE
        wSnVwGQUlhLD/UBqwWJ9n5S72Ts/m8icj3oSuuKM1DedGbk3jh0MfpW/QfPgs8/L9rw57sh0
        +r5TwExlnh8GfOqlHH//lC42ErgfOun0bvHrsuyTJXnfnXtVJz3v67EvawP2pXoJCOR/M/As
        05b5FHm4pnDm1IlCGpxW3uvV2U7fvpYifPs5y8LJk3PCb6X923XA77rs2yUbe3QqfErTHUM8
        Hv0S5WJ8PumMcNXK27YFkwuXHWm/tHTq5k3rEllO6WmfOM2VotEmaxiyaM/0bfbuOUsfcV+e
        aBqyf+WCaew35YS3652IULLyeXDvHyPHevV/wlrHPq99XdBjFPxEakKUzudn7ZEF8jNDfm6p
        PMlX1flfiaU4I9FQi7moOBEAv7bgkSEEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42
References: <CGME20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I've just changed %09lx to %09pK on my driver code to hide the address, but=
 I
faced compiler error. The %9pK without 0 worked.

Is there restriction on %pK which does now allow %0 ? I've wondered whether=
 I
did wrong or it is a printk problem.

To show easily I tried to add pr_info(=22%09pK=5Cn=22, nodemask); in page_a=
lloc.c
Then here's what I did.

=24 ARCH=3Dx86 make x86_64_defconfig ; make mm/page_alloc.o
=23
=23 No change to .config
=23
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CC      mm/page_alloc.o
In file included from ./include/asm-generic/bug.h:22:0,
                 from ./arch/x86/include/asm/bug.h:87,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/mm.h:6,
                 from mm/page_alloc.c:19:
mm/page_alloc.c: In function =E2=80=98__alloc_pages=E2=80=99:=0D=0A./includ=
e/linux/kern_levels.h:5:18:=20error:=20'0'=20flag=20used=20with=20=E2=80=98=
%p=E2=80=99=20gnu_printf=20format=20=5B-Werror=3Dformat=3D=5D=0D=0A=20=23de=
fine=20KERN_SOH=20=22=5C001=22=20=20/*=20ASCII=20Start=20Of=20Header=20*/=
=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=5E=0D=0A./incl=
ude/linux/printk.h:427:11:=20note:=20in=20definition=20of=20macro=20=E2=80=
=98printk_index_wrap=E2=80=99=0D=0A=20=20=20_p_func(_fmt,=20=23=23__VA_ARGS=
__);=20=20=20=20=5C=0D=0A=20=20=20=20=20=20=20=20=20=20=20=5E=0D=0A./includ=
e/linux/printk.h:528:2:=20note:=20in=20expansion=20of=20macro=20=E2=80=98pr=
intk=E2=80=99=0D=0A=20=20printk(KERN_INFO=20pr_fmt(fmt),=20=23=23__VA_ARGS_=
_)=0D=0A=20=20=5E=0D=0A./include/linux/kern_levels.h:14:19:=20note:=20in=20=
expansion=20of=20macro=20=E2=80=98KERN_SOH=E2=80=99=0D=0A=20=23define=20KER=
N_INFO=20KERN_SOH=20=226=22=20/*=20informational=20*/=0D=0A=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=5E=0D=0A./include/linux/printk.h=
:528:9:=20note:=20in=20expansion=20of=20macro=20=E2=80=98KERN_INFO=E2=80=99=
=0D=0A=20=20printk(KERN_INFO=20pr_fmt(fmt),=20=23=23__VA_ARGS__)=0D=0A=20=
=20=20=20=20=20=20=20=20=5E=0D=0Amm/page_alloc.c:5564:2:=20note:=20in=20exp=
ansion=20of=20macro=20=E2=80=98pr_info=E2=80=99=0D=0A=20=20pr_info(=22%09pK=
=5Cn=22,=20nodemask);=0D=0A=20=20=5E=0D=0A=0D=0AJaewon=20Kim
