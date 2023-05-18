Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B2D7077D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjERCJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjERCJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:09:09 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B2930C2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:09:06 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230518020903epoutp01137f51a3ecb831dc0c4981f3a14c5a13~gGtCbMy9Y0090400904epoutp01F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:09:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230518020903epoutp01137f51a3ecb831dc0c4981f3a14c5a13~gGtCbMy9Y0090400904epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684375743;
        bh=xDos3JdY5eZv9AOm5NW2P5dEKL/exMKHyUAJBF32oFY=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=jLzO5MRXQa74NGm25ndMaIibQbU5oGVftw0U4BejzTwAqFlfbwTflXoduCIpfTRo6
         vkavjRJtDM1VEvYQyH+qyFqmejaB6jYh1CzvPFmu8aa+JxWucFh1FTNA9mCg8pw/bq
         HUDBvmUTTtVN8VBQ2TVRhKNaGQhaY3ch0085lJG0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230518020903epcas2p165046a34e719cb71894110fc3f1a645b~gGtB6WSdj0450604506epcas2p1S;
        Thu, 18 May 2023 02:09:03 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QMD1B5wtwz4x9Pv; Thu, 18 May
        2023 02:09:02 +0000 (GMT)
X-AuditID: b6c32a48-6d3fa70000005998-b7-646588be02c8
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.F7.22936.EB885646; Thu, 18 May 2023 11:09:02 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) (2) [PATCH v6] f2fs: add async reset zone command support
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Daejun Park <daejun7.park@samsung.com>
CC:     "chao@kernel.org" <chao@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZGV56DEz54529znm@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230518020801epcms2p717775d12022c5371fbe9dcdf226efd4c@epcms2p7>
Date:   Thu, 18 May 2023 11:08:01 +0900
X-CMS-MailID: 20230518020801epcms2p717775d12022c5371fbe9dcdf226efd4c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmue6+jtQUgxXTdSwuzPvIbHF66lkm
        i5eHNC1WPQi3eLJ+FrPFpUXuFpd3zWGzOLL+LIvF4uVqFvs6HjBZrOqYy2gx9fwRJgcej5Z9
        t9g9Nq3qZPPYveAzk0ffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
        GlpamCsp5CXmptoqufgE6Lpl5gDdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkp
        MC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzvj76w9zwdtLjBXvbuxma2Bcdpaxi5GTQ0LAROLn
        m362LkYuDiGBHYwSJx4eZupi5ODgFRCU+LtDGKRGWMBTYs22HUwgtpCAksT6i7PYIeJ6Erce
        rgGbwyagIzH9xH2wuIiAj8SLzrXMIDOZBR4yS/RO2MUCsYxXYkb7UyhbWmL78q1gzZwCWhId
        03ewQcQ1JH4s62WGsEUlbq5+yw5jvz82H+poEYnWe2ehagQlHvzcDRWXlLg9dxNUfb7E/yvL
        oewaiW0H5kHZ+hLXOjaC3cAr4Ctxf91hsDksAqoS5xp2Q93mIvH8yFUwm1lAW2LZwtfMoDBh
        FtCUWL9LH8SUEFCWOHILqoJPouPwX3aYDxs2/sbK3jHvCROErSax7ud6pgmMyrMQAT0Lya5Z
        CLsWMDKvYhRLLSjOTU8tNiowgcducn7uJkZwOtXy2ME4++0HvUOMTByMhxglOJiVRHgD+5JT
        hHhTEiurUovy44tKc1KLDzGaAn05kVlKNDkfmNDzSuINTSwNTMzMDM2NTA3MlcR5P3YopwgJ
        pCeWpGanphakFsH0MXFwSjUwTT++9e6ZnU8N7+xyfXXN7IJATfen7TVTz31heGXFEPT0fcue
        DR1tc0OLP1/fu9RV4N7Wzq/xs3e5/nIK0/9w3/rzcsMVt9Y+6paaXX/wi3npQQWbRwwcP5uf
        Rh94tW9qy69XnneUHku96/v7b0f0g/0yDv/Kb//bevvdyv98a+RVpZcX/m7rkHuq3rQiSefI
        23dKWiyS7cV9G28edGi/9EZG6sPsy/KPPzorn3c43zspZ+abQ9qWPGfkC1IlVyVvV5twWHK7
        4Pwu96PNzzVf3L34pij65xqxxl1M4owVUa2P3motkeO92qM+9eq7uJOCcdldr6fuO7HEXvPU
        5Rf5rRy3f0/5U81vfT0icVralyRvJZbijERDLeai4kQA8zwBATAEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5
References: <ZGV56DEz54529znm@google.com> <ZFqWr3sSYMsHtHAC@google.com>
        <20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5@epcms2p8>
        <20230511052416epcms2p617838faa71a203da6978c89ffd216e91@epcms2p6>
        <CGME20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5@epcms2p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 05/11, Daejun Park wrote:
> > > Sender : Jaegeuk Kim=C2=A0<jaegeuk=40kernel.org>=0D=0A>=20>=20>=20Dat=
e=20:=202023-05-10=2003:53=20(GMT+9)=0D=0A>=20>=20>=20Title=20:=20Re:=20=5B=
PATCH=20v6=5D=20f2fs:=20add=20async=20reset=20zone=20command=20support=0D=
=0A>=20>=20>=20To=20:=20=EB=B0=95=EB=8C=80=EC=A4=80<daejun7.park=40samsung.=
com>=0D=0A>=20>=20>=20CC=20:=20chao=40kernel.org<chao=40kernel.org>,=20rost=
edt=40goodmis.org<rostedt=40goodmis.org>,=20mhiramat=40kernel.org<mhiramat=
=40kernel.org>,=20linux-f2fs-devel=40lists.sourceforge.net<linux-f2fs-devel=
=40lists.sourceforge.net>,=20linux-kernel=40vger.kernel.org<linux-kernel=40=
vger.kernel.org>,=20linux-trace-kernel=40vger.kernel.org<linux-trace-kernel=
=40vger.kernel.org>,=20=EA=B9=80=EC=84=9D=ED=99=98<sukka.kim=40samsung.com>=
,=20=EC=86=A1=EC=9A=A9=EA=B8=B8<yonggil.song=40samsung.com>,=20=EA=B9=80=EB=
=B2=94=EC=88=98<beomsu7.kim=40samsung.com>=0D=0A>=20>=20>=20=C2=A0=0D=0A>=
=20>=20>=20On=2005/08,=20Daejun=20Park=20wrote:=0D=0A>=20>=20>=20>=20v5=20-=
>=20v6=0D=0A>=20>=20>=20>=20Added=20trace_f2fs_iostat=20support=20for=20zon=
e=20reset=20command.=0D=0A>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20v4=20->=20v=
5=0D=0A>=20>=20>=20>=20Added=20f2fs=20iostat=20for=20zone=20reset=20command=
.=0D=0A>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20v3=20->=20v4=0D=0A>=20>=20>=20=
>=20Fixed=20build=20error=20caused=20by=20unused=20function.=0D=0A>=20>=20>=
=20>=20=0D=0A>=20>=20>=20>=20v2=20->=20v3=0D=0A>=20>=20>=20>=20Modified=20a=
rguments=20to=20be=20correct=20for=20ftrace=20parameter.=0D=0A>=20>=20>=20>=
=20Changed=20__submit_zone_reset_cmd=20to=20void=20return.=0D=0A>=20>=20>=
=20>=20Refactored=20the=20f2fs_wait_discard_bio=20function.=0D=0A>=20>=20>=
=20>=20Fixed=20code=20that=20was=20previously=20incorrectly=20merged.=0D=0A=
>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20v1=20->=20v2=0D=0A>=20>=20>=20>=20Cha=
nged=20to=20apply=20the=20optional=20async=20reset=20write=20pointer=20by=
=20default.=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20Don't=20add=20the=20history=
=20in=20the=20patch=20description.=0D=0A>=20>=20=0D=0A>=20>=20OK,=20I=20wil=
l=20do.=0D=0A>=20>=20=0D=0A>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20This=20pat=
ch=20enables=20submit=20reset=20zone=20command=20asynchornously.=20It=20hel=
ps=0D=0A>=20>=20>=20>=20decrease=20average=20latency=20of=20write=20IOs=20i=
n=20high=20utilization=20scenario=20by=0D=0A>=20>=20>=20>=20faster=20checkp=
ointing.=0D=0A>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20Signed-off-by:=20Daejun=
=20Park=20<daejun7.park=40samsung.com>=0D=0A>=20>=20>=20>=20---=0D=0A>=20>=
=20>=20>=20=C2=A0fs/f2fs/f2fs.h=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=7C=20=C2=A01=20+=0D=0A>=20>=20>=20>=20=C2=A0fs/f2fs/i=
ostat.c=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7C=20=C2=A01=
=20+=0D=0A>=20>=20>=20>=20=C2=A0fs/f2fs/segment.c=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=7C=2084=20+++++++++++++++++++++++++++++++++++--=0D=
=0A>=20>=20>=20>=20=C2=A0include/trace/events/f2fs.h=20=7C=2024=20+++++++++=
--=0D=0A>=20>=20>=20>=20=C2=A04=20files=20changed,=20104=20insertions(+),=
=206=20deletions(-)=0D=0A>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20diff=20--git=
=20a/fs/f2fs/f2fs.h=20b/fs/f2fs/f2fs.h=0D=0A>=20>=20>=20>=20index=20d211ee8=
9c158..51b68a629814=20100644=0D=0A>=20>=20>=20>=20---=20a/fs/f2fs/f2fs.h=0D=
=0A>=20>=20>=20>=20+++=20b/fs/f2fs/f2fs.h=0D=0A>=20>=20>=20>=20=40=40=20-11=
75,6=20+1175,7=20=40=40=20enum=20iostat_type=20=7B=0D=0A>=20>=20>=20>=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20other=20*/=0D=0A>=20>=20>=20>=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0FS_DISCARD_IO,=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0/*=20discard=20*/=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0FS_FLUSH_IO,=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20f=
lush=20*/=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0FS_ZONE=
_RESET_IO,=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0/*=20zone=20reset=20*/=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0NR_IO_TYPE,=0D=0A>=20>=20>=20>=20=C2=A0=7D;=0D=0A>=20>=
=20>=20>=20=C2=A0=0D=0A>=20>=20>=20>=20diff=20--git=20a/fs/f2fs/iostat.c=20=
b/fs/f2fs/iostat.c=0D=0A>=20>=20>=20>=20index=203d5bfb1ad585..f8703038e1d8=
=20100644=0D=0A>=20>=20>=20>=20---=20a/fs/f2fs/iostat.c=0D=0A>=20>=20>=20>=
=20+++=20b/fs/f2fs/iostat.c=0D=0A>=20>=20>=20>=20=40=40=20-80,6=20+80,7=20=
=40=40=20int=20__maybe_unused=20iostat_info_seq_show(struct=20seq_file=20*s=
eq,=20void=20*offset)=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0seq_puts(seq,=20=22=5BOTHER=5D=5Cn=22);=0D=0A>=20>=20>=20>=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0IOSTAT_INFO_SHOW(=22fs=20discard=
=22,=20FS_DISCARD_IO);=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0IOSTAT_INFO_SHOW(=22fs=20flush=22,=20FS_FLUSH_IO);=0D=0A>=20>=
=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0IOSTAT_INFO_SHOW(=22fs=20zo=
ne=20reset=22,=20FS_ZONE_RESET_IO);=0D=0A>=20>=20>=20>=20=C2=A0=0D=0A>=20>=
=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>=20>=
=20>=20>=20=C2=A0=7D=0D=0A>=20>=20>=20>=20diff=20--git=20a/fs/f2fs/segment.=
c=20b/fs/f2fs/segment.c=0D=0A>=20>=20>=20>=20index=206db410f1bb8c..4802b05a=
795b=20100644=0D=0A>=20>=20>=20>=20---=20a/fs/f2fs/segment.c=0D=0A>=20>=20>=
=20>=20+++=20b/fs/f2fs/segment.c=0D=0A>=20>=20>=20>=20=40=40=20-1196,6=20+1=
196,45=20=40=40=20static=20void=20__init_discard_policy(struct=20f2fs_sb_in=
fo=20*sbi,=0D=0A>=20>=20>=20>=20=C2=A0static=20void=20__update_discard_tree=
_range(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20block_=
device=20*bdev,=20block_t=20lstart,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0block_t=20start,=
=20block_t=20len);=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=23ifdef=20=
CONFIG_BLK_DEV_ZONED=0D=0A>=20>=20>=20>=20+static=20void=20__submit_zone_re=
set_cmd(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20Wh=
y=20can't=20we=20use=20__f2fs_issue_discard_zone()?=0D=0A>=20>=20=0D=0A>=20=
>=20In=20my=20understanding,=20__f2fs_issue_discard_zone=20is=20used=20to=
=20queue=20the=20zone=20reset=20command.=0D=0A>=20>=20Which=20point=20do=20=
you=20think=20is=20the=20issue?=0D=0A>=20=0D=0A>=20That=20actually=20calls=
=20blkdev_zone_mgmt()=20which=20is=20doing=20the=20same=20thing.=0D=0A=0D=
=0Af2fs_clear_prefree_segments=20->=20f2fs_issue_discard=20->=20__issue_dis=
card_async=20->=20__f2fs_issue_discard_zone=0D=0AIn=20the=20case=20of=20dis=
card=20in=20the=20existing=20code,=20discard=20can=20be=20queued=20by=20__q=
ueue_discard_cmd().=20However=20the=20reset=20command=20is=20issued=20immed=
iately.=0D=0A=0D=0AIn=20this=20patch,=20I=20changed=20the=20zone=20reset=20=
command=20can=20be=20queued=20like=20discard=20command.=0D=0ATherefore,=20I=
=20changed=20__f2fs_issue_discard_zone()=20to=20queue=20the=20reset=20comma=
nd,=20and=20to=20issue=20the=20reset=20command=20through=20__submit_discard=
_cmd()=20->=20__submit_zone_reset_cmd().=0D=0A=0D=0AAlso,=20in=20blkdev_zon=
e_mgmt(),=20bi_end_io=20cannot=20be=20specified,=20so=20waiting=20in=20f2fs=
_wait_discard_bio()=20is=20not=20possible.=0D=0AThat's=20why=20I=20created=
=20a=20new=20__submit_zone_reset_cmd().=0D=0A=0D=0A>=20=0D=0A>=20>=20=0D=0A=
>=20>=20>=20=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20discard_cmd=20*dc,=20blk=
_opf_t=20flag,=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20list_head=20*wait_lis=
t,=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20unsigned=20int=20*issued)=0D=0A>=20>=20>=
=20>=20+=7B=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struc=
t=20discard_cmd_control=20*dcc=20=3D=20SM_I(sbi)->dcc_info;=0D=0A>=20>=20>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20block_device=20*bdev=
=20=3D=20dc->bdev;=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0struct=20bio=20*bio=20=3D=20bio_alloc(bdev,=200,=20REQ_OP_ZONE_RESET=20=
=7C=20flag,=20GFP_NOFS);=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0unsigned=20long=20flags;=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_issue_reset_zone(bdev,=
=20dc->di.start);=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0spin_lock_irqsave(&dc->lock,=20flags);=0D=0A>=20>=
=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->state=20=3D=20D_SUBMIT;=
=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->bio_ref++;=
=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0spin_unlock_irqr=
estore(&dc->lock,=20flags);=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(issued)=0D=0A>=20>=20>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0(*issu=
ed)++;=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0atomic_inc(&dcc->queued_discard);=0D=0A>=20>=20>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->queued++;=0D=0A>=20>=20>=20>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0list_move_tail(&dc->list,=20wait_list);=0D=0A=
>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0/*=20sanity=20check=20on=20discard=20range=20*/=0D=0A>=20>=20>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__check_sit_bitmap(sbi,=20dc->di.lstart=
,=20dc->di.lstart=20+=20dc->di.len);=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bio->bi_iter.bi_sector=20=3D=20=
SECTOR_FROM_BLOCK(dc->di.start);=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0bio->bi_private=20=3D=20dc;=0D=0A>=20>=20>=20>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0bio->bi_end_io=20=3D=20f2fs_submit_discard_en=
dio;=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0submit_bio(b=
io);=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0atomic_inc(&dcc->issued_discard);=0D=0A>=20>=20>=20>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0f2fs_update_iostat(sbi,=20NULL,=20FS_ZONE_RES=
ET_IO,=20dc->di.len=20*=20F2FS_BLKSIZE);=0D=0A>=20>=20>=20>=20+=7D=0D=0A>=
=20>=20>=20>=20+=23endif=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20=C2=A0=
/*=20this=20function=20is=20copied=20from=20blkdev_issue_discard=20from=20b=
lock/blk-lib.c=20*/=0D=0A>=20>=20>=20>=20=C2=A0static=20int=20__submit_disc=
ard_cmd(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20discar=
d_policy=20*dpolicy,=0D=0A>=20>=20>=20>=20=40=40=20-1217,6=20+1256,13=20=40=
=40=20static=20int=20__submit_discard_cmd(struct=20f2fs_sb_info=20*sbi,=0D=
=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(is_sbi_f=
lag_set(sbi,=20SBI_NEED_FSCK))=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>=
=20>=20>=20>=20=C2=A0=0D=0A>=20>=20>=20>=20+=23ifdef=20CONFIG_BLK_DEV_ZONED=
=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(f2fs_sb_ha=
s_blkzoned(sbi)=20&&=20bdev_is_zoned(bdev))=20=7B=0D=0A>=20>=20>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__subm=
it_zone_reset_cmd(sbi,=20dc,=20flag,=20wait_list,=20issued);=0D=0A>=20>=20>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0return=200;=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=7D=0D=0A>=20>=20>=20>=20+=23endif=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=
=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_issue_discard(b=
dev,=20dc->di.start,=20dc->di.len);=0D=0A>=20>=20>=20>=20=C2=A0=0D=0A>=20>=
=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0lstart=20=3D=20dc->di.=
lstart;=0D=0A>=20>=20>=20>=20=40=40=20-1461,6=20+1507,19=20=40=40=20static=
=20void=20__update_discard_tree_range(struct=20f2fs_sb_info=20*sbi,=0D=0A>=
=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20>=
=20>=20=C2=A0=7D=0D=0A>=20>=20>=20>=20=C2=A0=0D=0A>=20>=20>=20>=20+=23ifdef=
=20CONFIG_BLK_DEV_ZONED=0D=0A>=20>=20>=20>=20+static=20void=20__queue_zone_=
reset_cmd(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20block_=
device=20*bdev,=20block_t=20blkstart,=20block_t=20lblkstart,=0D=0A>=20>=20>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0block_t=20blklen)=0D=0A>=20>=20>=20>=20+=7B=0D=0A>=20>=20>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_queue_reset_zone(bdev,=20blksta=
rt);=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);=0D=0A>=20>=20>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__insert_discard_cmd(sbi,=20bdev,=
=20lblkstart,=20blkstart,=20blklen);=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);=0D=0A>=
=20>=20>=20>=20+=7D=0D=0A>=20>=20>=20>=20+=23endif=0D=0A>=20>=20>=20>=20+=
=0D=0A>=20>=20>=20>=20=C2=A0static=20void=20__queue_discard_cmd(struct=20f2=
fs_sb_info=20*sbi,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20block_device=20*bdev,=
=20block_t=20blkstart,=20block_t=20blklen)=0D=0A>=20>=20>=20>=20=C2=A0=7B=
=0D=0A>=20>=20>=20>=20=40=40=20-1724,6=20+1783,19=20=40=40=20static=20void=
=20f2fs_wait_discard_bio(struct=20f2fs_sb_info=20*sbi,=20block_t=20blkaddr)=
=0D=0A>=20>=20>=20>=20=C2=A0=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0mutex_lock(&dcc->cmd_lock);=0D=0A>=20>=20>=20>=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dc=20=3D=20__lookup_discard_cmd(sbi,=20=
blkaddr);=0D=0A>=20>=20>=20>=20+=23ifdef=20CONFIG_BLK_DEV_ZONED=0D=0A>=20>=
=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(dc=20&&=20f2fs_sb_has=
_blkzoned(sbi)=20&&=20bdev_is_zoned(dc->bdev))=20=7B=0D=0A>=20>=20>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=
=20force=20submit=20zone=20reset=20*/=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(dc->state=20=
=3D=3D=20D_PREP)=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__s=
ubmit_zone_reset_cmd(sbi,=20dc,=20REQ_SYNC,=0D=0A>=20>=20>=20>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0&dcc->wait_list,=
=20NULL);=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0dc->ref++;=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0mutex_unlock(&d=
cc->cmd_lock);=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20wait=20zone=20reset=20*/=0D=0A>=20=
>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0__wait_one_discard_bio(sbi,=20dc);=0D=0A>=20>=20>=20>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return;=
=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=
=20>=20>=20+=23endif=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0if=20(dc)=20=7B=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(dc->state=20=3D=3D=
=20D_PREP)=20=7B=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0__punch_discard_cmd(sbi,=20dc,=20blkaddr);=0D=0A>=20>=20>=20>=20=40=40=
=20-1876,9=20+1948,15=20=40=40=20static=20int=20__f2fs_issue_discard_zone(s=
truct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20blkstart,=20blklen);=
=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20-EI=
O;=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20>=20>=20-=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_issue_reset_z=
one(bdev,=20blkstart);=0D=0A>=20>=20>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20blkdev_zone_mgmt(bdev,=
=20REQ_OP_ZONE_RESET,=0D=0A>=20>=20>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
sector,=20nr_sects,=20GFP_NOFS);=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0if=20(unlikely(is_sbi_flag_set(sbi,=20SBI_POR_DOING)))=20=7B=0D=0A>=20>=
=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_f2fs_issue_reset_zone(bd=
ev,=20blkstart);=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ret=
urn=20blkdev_zone_mgmt(bdev,=20REQ_OP_ZONE_RESET,=0D=0A>=20>=20>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0sector,=20nr=
_sects,=20GFP_NOFS);=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20>=20>=20+=0D=0A>=
=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0__queue_zone_reset_cmd(sbi,=20bdev,=20blkstart,=20lblkstart,=
=20blklen);=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>=20>=20>=20>=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=20>=20>=20=C2=A0=0D=0A>=20>=
=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20For=20conventiona=
l=20zones,=20use=20regular=20discard=20if=20supported=20*/=0D=0A>=20>=20>=
=20>=20diff=20--git=20a/include/trace/events/f2fs.h=20b/include/trace/event=
s/f2fs.h=0D=0A>=20>=20>=20>=20index=2099cbc5949e3c..793f82cc1515=20100644=
=0D=0A>=20>=20>=20>=20---=20a/include/trace/events/f2fs.h=0D=0A>=20>=20>=20=
>=20+++=20b/include/trace/events/f2fs.h=0D=0A>=20>=20>=20>=20=40=40=20-1512=
,7=20+1512,7=20=40=40=20DEFINE_EVENT(f2fs_discard,=20f2fs_remove_discard,=
=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_ARGS(dev=
,=20blkstart,=20blklen)=0D=0A>=20>=20>=20>=20=C2=A0);=0D=0A>=20>=20>=20>=20=
=C2=A0=0D=0A>=20>=20>=20>=20-TRACE_EVENT(f2fs_issue_reset_zone,=0D=0A>=20>=
=20>=20>=20+DECLARE_EVENT_CLASS(f2fs_reset_zone,=0D=0A>=20>=20>=20>=20=C2=
=A0=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO=
(struct=20block_device=20*dev,=20block_t=20blkstart),=0D=0A>=20>=20>=20>=20=
=C2=A0=0D=0A>=20>=20>=20>=20=40=40=20-1528,11=20+1528,25=20=40=40=20TRACE_E=
VENT(f2fs_issue_reset_zone,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->blkstart=20=
=3D=20blkstart;=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0),=0D=0A>=20>=20>=20>=20=C2=A0=0D=0A>=20>=20>=20>=20-=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0TP_printk(=22dev=20=3D=20(%d,%d),=20reset=20zone=20at=
=20block=20=3D=200x%llx=22,=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0TP_printk(=22dev=20=3D=20(%d,%d),=20zone=20at=20block=20=3D=200=
x%llx=22,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0show_dev(__entry->dev),=0D=0A>=20>=20>=
=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0(unsigned=20long=20long)__entry->blkstart)=0D=0A>=20>=20>=20>=
=20=C2=A0);=0D=0A>=20>=20>=20>=20=C2=A0=0D=0A>=20>=20>=20>=20+DEFINE_EVENT(=
f2fs_reset_zone,=20f2fs_queue_reset_zone,=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=
=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO(struct=20block_dev=
ice=20*dev,=20block_t=20blkstart),=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20=
>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_ARGS(dev,=20blkstart)=0D=0A>=20=
>=20>=20>=20+);=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+DEFINE_EVENT(f=
2fs_reset_zone,=20f2fs_issue_reset_zone,=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=
=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO(struct=20block_dev=
ice=20*dev,=20block_t=20blkstart),=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20=
>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_ARGS(dev,=20blkstart)=0D=0A>=20=
>=20>=20>=20+);=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20=C2=A0TRACE_EVE=
NT(f2fs_issue_flush,=0D=0A>=20>=20>=20>=20=C2=A0=0D=0A>=20>=20>=20>=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO(struct=20block_device=20*de=
v,=20unsigned=20int=20nobarrier,=0D=0A>=20>=20>=20>=20=40=40=20-1979,6=20+1=
993,7=20=40=40=20TRACE_EVENT(f2fs_iostat,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__field(u=
nsigned=20long=20long,=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fs_nrio)=0D=0A>=
=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0__field(unsigned=20long=20long,=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0fs_mrio)=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__field(unsigned=20long=20long=
,=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fs_discard)=0D=0A>=20>=20>=20>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__fiel=
d(unsigned=20long=20long,=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fs_reset_zone)=
=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0),=0D=0A>=
=20>=20>=20>=20=C2=A0=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0TP_fast_assign(=0D=0A>=20>=20>=20>=20=40=40=20-2010,12=20+2025,=
14=20=40=40=20TRACE_EVENT(f2fs_iostat,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->fs_=
nrio=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=3D=20iostat=5BFS_NODE_READ_IO=5D;=
=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0__entry->fs_mrio=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=3D=20iostat=5BFS_META_READ_IO=5D;=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->=
fs_discard=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=3D=20iostat=5BFS_DISCARD_IO=
=5D;=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0__entry->fs_reset_zone=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=3D=20iostat=5BFS_ZONE_RESET_IO=5D;=0D=0A>=20>=20>=20>=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0),=0D=0A>=20>=20>=20>=20=C2=A0=0D=0A>=20>=
=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_printk(=22dev=20=3D=
=20(%d,%d),=20=22=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=22app=20=5Bwrite=3D%llu=20(direc=
t=3D%llu,=20buffered=3D%llu),=20mapped=3D%llu,=20=22=0D=0A>=20>=20>=20>=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=22compr(buffered=3D%llu,=20mapped=3D%llu)=5D,=20=22=0D=0A>=20>=20>=20>=
=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=22fs=20=5Bdata=3D%llu,=20cdata=3D%llu,=20node=3D%llu,=20meta=3D%llu,=20=
discard=3D%llu=5D,=20=22=0D=0A>=20>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=22fs=20=5Bdata=3D%llu,=20cdat=
a=3D%llu,=20node=3D%llu,=20meta=3D%llu,=20discard=3D%llu,=20=22=0D=0A>=20>=
=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=22reset_zone=3D%llu=5D,=20=22=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=22gc=20=
=5Bdata=3D%llu,=20node=3D%llu=5D,=20=22=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=22cp=20=
=5Bdata=3D%llu,=20node=3D%llu,=20meta=3D%llu=5D,=20=22=0D=0A>=20>=20>=20>=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=22app=20=5Bread=3D%llu=20(direct=3D%llu,=20buffered=3D%llu),=20mappe=
d=3D%llu=5D,=20=22=0D=0A>=20>=20>=20>=20=40=40=20-2026,6=20+2043,7=20=40=40=
=20TRACE_EVENT(f2fs_iostat,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->app_bio,=20_=
_entry->app_mio,=20__entry->app_bcdio,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->app=
_mcdio,=20__entry->fs_dio,=20__entry->fs_cdio,=0D=0A>=20>=20>=20>=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__e=
ntry->fs_nio,=20__entry->fs_mio,=20__entry->fs_discard,=0D=0A>=20>=20>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0__entry->fs_reset_zone,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->fs_gc_dio,=20__=
entry->fs_gc_nio,=20__entry->fs_cp_dio,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->=
fs_cp_nio,=20__entry->fs_cp_mio,=0D=0A>=20>=20>=20>=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->app_rio,=
=20__entry->app_drio,=20__entry->app_brio,=0D=0A>=20>=20>=20>=20--=20=0D=0A=
>=20>=20>=20>=202.25.1=0D=0A
