Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6875FB7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJKQIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJKQIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:08:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C642E53A4D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:08:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BFOcVL020067;
        Tue, 11 Oct 2022 16:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=M73CoG/zwcq42BekkteyGMOr7SRzTJgMEtJNJU+4zOg=;
 b=AKvjqB6+vLaGNQnZJO1OkAcGBP2+cp9ONgRGEgx6q+TV/d6ZpAxyAnLYZYEPl1KM9mik
 JoCb+E8uPTgMaAyPNLvagSCzoNGI0HtWJegGmwp+y5DbZnx791f6QFFyhdtwV4+cTO62
 qHijZMfFfIlBfg4LTZcRSTjjKHBLXgIiFYBC2f5MqEUDcJRIgVnn0JNOtbpSiMLtcZLT
 FnTYBE4AK25ERBPq1hDrOV5s1fQnjtQrIm89AvrImlRiRTC5zAJcQIq97TPPISYFqvC9
 Lt3oIaCsRu2qa/jJG30nTbI7vJP1BQEjKueC1vuqp1/v1F+XMbgjViyb673Z1WnVasfr yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k31rtf9wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 16:08:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29BERltv002884;
        Tue, 11 Oct 2022 16:08:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn3sey0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 16:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAUXVVqHSKcb5shu9aACSRWNPiF0iRj45urA3rtKupYyMw3sualGW8XYRa8prgOiSnf0tB3QCZj/efFcXDQv3I09NCw8dnqPEcF71Hw9ub1CBECkEcrEIEoKzGu3FL+lvq/LinxJlV4CFoiDKFz/Ch4RQUhnOFOTOMoBsHP3oPPqYsKwGn6cID5Vf2bZSKyhyUrIlDcFiZ2ULOTuSBMIKg00R9hLfqs8k0jEureJDQE5alLsWj7PAWxWPyp6EZKM11OhAuHece71WM8Gu3AR3VmH0A3NgpqNbM8QSNdEedSkGL0+jQ3HyX6LlZxFpLgz3fMItJMhphTAEfUny7l2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M73CoG/zwcq42BekkteyGMOr7SRzTJgMEtJNJU+4zOg=;
 b=EWY+QqMnT39tItrba4ODquLInTX40Yf/DRgBr5RxTYuilvW/DOsCJ5wwN2iQfSiqEytOMDBvqdDRHuGBV1vPoLSemlncR5GSXTPhq7toPfUlGSo8i8nPGFwcrKK34v5HzuaF9z3wtJ82y4mvKybial5R1Hh22dBSneiv//yuOonTPttZf7ghi2eohQiBwknFqRJSpLO751Y3CjKc+zVYVfAQWCo2CWLb2v9N2kPLZ6wOW0jLT7bGlYT+H8tTR7TLaFkKJhxYzQfN9ZjMCHj24/6Yphq+FPZAs0oLA57FpD5mZnYehvvzhXoQCslDC40XyIVlR0lzsC2BRIk/EIsvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M73CoG/zwcq42BekkteyGMOr7SRzTJgMEtJNJU+4zOg=;
 b=TAikKfyHHunh5pKGzeTsHjZhmpyl0CXlpTHyG1m8vm3nowqPiJWVMNTFPpaMhV2fSIDoDwMchf4wniE0mZpGcdYwem6B9SpSlXx/jBpYOhbp4he6/3vZBhT0LNFGkBejGNmvupNxZlAYk3xuEX0yPKYuDGKhTVIXuBTqQ5GKfeI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4125.namprd10.prod.outlook.com (2603:10b6:208:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 16:08:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::2d77:5bd1:1bba:df5e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::2d77:5bd1:1bba:df5e%2]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 16:08:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Yu Zhao <yuzhao@google.com>, Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] mm/mmap: Preallocate maple nodes for brk vma expansion
Thread-Topic: [PATCH] mm/mmap: Preallocate maple nodes for brk vma expansion
Thread-Index: AQHY3Yu4FDy+85Aso0SE0pqHEc5P9w==
Date:   Tue, 11 Oct 2022 16:08:37 +0000
Message-ID: <20221011160624.1253454-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MN2PR10MB4125:EE_
x-ms-office365-filtering-correlation-id: 718dd444-456a-4416-ca43-08daaba2dada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c4LKarqSkkKMDudBPVAMgmH5YHntpp2UCWJs488uU0fhuI1koyfk8GfkpJQMc2LuvtrtUsvSEpK6tViTBv93UBGUzP2tmoZkxP1kjXIrDSLx3+Yz7mvH6I3gvg/and9OTvWpJiBoWMyy/t3afOXMkNxIF43D0MFFDW3iUQ4Lx3G2HcxaWKiQdlVTdwAB1O/6Vi5UfC9E06MGDJdMaRNRk4YzSF1MrWO8gml0nAXTfECIfRIOg3sxswHVLQeQ5QnJp1AuRU8GtoZUavr1stJ81e+meXzKMwCben3e/NBxKvGo2L/9WEdUUwgxHF7+d3EBWE9HSVbRxB6KXNhDgo8jMD15Cis1Z3gddjx6xMblT029uvpu36/PF6dU/RkWNGS2OXRcXdbp4HbOpoc64R7sc9DhlXo2sg2gouUevWfMe/SHvbE9t/xXuFyFCeoPYEVfF/M5uLM3FNm00ckeoi/64YjuuiYlJkt5nSTpaN4oSYkiNIiT1xrD/tTg+A+wldJLZU897bU85Na75eiDcBlHErpU9goHNAoR+Lbi85AOqXRG7V7NuK2aIdkxDCKSDBV9WGHCwCNoheA3etocZkaFHII5zT++clSKQeQeuJtftnZw74q/xKFK70BESag3iZ6TNFkw2YSOsecK3b4UbJdhxFxLdE7nwtfuH0rTkj2reXsBuN6cw1ZLwukiXoc3CfXG+hlEEhhCudJpmhJzOizpx9W4I8wLSpCN2CCSPYbQOOVob9H6kCUrGrPuI7yje9NscSeRuS4cJ81F6V7j/DNpBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(38070700005)(122000001)(38100700002)(36756003)(86362001)(2906002)(186003)(83380400001)(5660300002)(44832011)(2616005)(1076003)(6512007)(66556008)(26005)(6506007)(107886003)(64756008)(8676002)(66946007)(91956017)(66476007)(66446008)(4326008)(54906003)(76116006)(110136005)(71200400001)(41300700001)(316002)(8936002)(478600001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zuGSQ15CCRDSJNfc6bahmPCZg72U1J6Dx78+Y6YnjqM6VXhSNya2/BaxYG?=
 =?iso-8859-1?Q?MTIfIFQcGS2uqaSM4hx6HpdAvkm9Pl2riq2q8+zZrNsWzmZJzLPCgjHxwk?=
 =?iso-8859-1?Q?8k7QwMBUCePgyMYfo2TfAYvpKZwKMB8dR6mMdrV05Xssiroovi2/1vOeDF?=
 =?iso-8859-1?Q?7vbn7fKvbRBOAkdHtzEldnzywiMbv2eHThEzJut4agNT1jw/sNhfCIjL//?=
 =?iso-8859-1?Q?vVzkiu820jvieRMXkdVVCC+loR0uEYZa2hY2b5N/CUlQc+rK5ACCWOCVGN?=
 =?iso-8859-1?Q?GtZ72WIvD8a7t47rRUk12kO9D4FkhbtIrxN9SzsV75vzgHr+XD8sB/kcmT?=
 =?iso-8859-1?Q?pOcSzk7b0DL+Kgam6btrtgFaYTQDdZKKl2y7pvMIioAmdRMJWnCjsFkMR2?=
 =?iso-8859-1?Q?PY4g5fxlf07gIQhGT5P3/DiYVBhtAT9xceLFpmlIQWCkpMbHF54P4F75HJ?=
 =?iso-8859-1?Q?R5X1iDw5SEyLmyuHv6pUebjSeIsLzyBsO3+AeBARjSNPFYX0BwScXUo4FP?=
 =?iso-8859-1?Q?Pe29OfcyusbmxStYEtHM7512i2m0/UEx4d52X4kfdqtGsYPtXtrcAUrbH4?=
 =?iso-8859-1?Q?PSHe5tDiNYTYUWFTB8+TXXCfCdvLSAD71GwHlyPLKU2PaAiWM0jy6ixNIK?=
 =?iso-8859-1?Q?SBvZYiAZ9WgsLhLslHacT6NYJVgiZQdVDjn5eCCEQBFuWWwWXu2eLz8tLI?=
 =?iso-8859-1?Q?J+b3xyXOJqxag++bnZ2ZctplV5dgNs7HY3LQFrfhdtwVN21JXonvGJBp3a?=
 =?iso-8859-1?Q?nD8EKZrg436Vwg9G/7bwdW/kqpxD85Df25Vmf7OeYiMgsWJ5iIOkqywFc3?=
 =?iso-8859-1?Q?RdmRHCQ0c9DsVluL/XR4wHUvR+mRoEqO9ebo62gv/qcl0ydcrd1tGzHMsB?=
 =?iso-8859-1?Q?Iy8RRu8oVo1khnUx+CgPHe2dhH73FflqPaQYVDOENWnHOAuH5M77rJaKIR?=
 =?iso-8859-1?Q?mOaJ5fZbaE3Ulxmntds3cT55VeH7OZdbmU4hmaiIpatYcJDd9SyVa+Dusd?=
 =?iso-8859-1?Q?inDVZ6SLMt2K2IbpdUmEVP1Z27DinOwdpG9tVL90yppuoiHSyNByKtRfeT?=
 =?iso-8859-1?Q?n1OOewrbi4DboTOuCQzfXH5rKYY7WC7qQfQjqdfzAXhAgR7RIFN33G+9uZ?=
 =?iso-8859-1?Q?kVuJeiueKxufml8n/vaU186NpzBoBBWfGwhBppkIKlp9QBGWLim0SaONFk?=
 =?iso-8859-1?Q?GFL8FBahHLrZxVzo3FPqJYzV9YNdjd2jz4RUN0SgGJs4b3MMSJOZE4BmiD?=
 =?iso-8859-1?Q?aucBaiWJJqIEnWm4MxBVqfPMSDF40Wlbh2HmcMiu2Gc1wk86Qttx6RNiFV?=
 =?iso-8859-1?Q?V+byE6Qf/4XM1VSU2F3fa6xj1Ea4a/uJtVKM5eVuWzkWK3wODp4/uj364S?=
 =?iso-8859-1?Q?pTspGagpgVCJ+WFB88Lw7Q9Bf3Uu/YjfwEByRJJ9uVklFbRrLFm5PMrs0n?=
 =?iso-8859-1?Q?Hrg44f+kxtCALc9GJeIC9J21rlf3OQyHy8kBJwCunCHV8AzJ18mvDPg1rn?=
 =?iso-8859-1?Q?hwryvzI/O4WOMRDkozprSqquhNpiDq/9gLVaAtqx+dtJcEWGntpfuD4t3i?=
 =?iso-8859-1?Q?kjgiYcGMOB3wr0BUBzp5VUHbGEffyfcq9t1/IZ9j2hE+g0Kw7l9dGY4sOl?=
 =?iso-8859-1?Q?6SlRbs8VwQc6cSWEquAfHDWJjMiC8qGvt8u8brZNwhZA8MoRXQBUkHOA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718dd444-456a-4416-ca43-08daaba2dada
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 16:08:37.0857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5arYXiB2coUbLmyAM9c0IoBLfch+uORAZT4LFA1JpxRkyD/z137ykIKQ1MHlzRmdVCTv3k1nrcRVmD+uBA2uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110093
X-Proofpoint-GUID: sudWUtX824Ivyoqt_Ng_Yki4stvDj2Zb
X-Proofpoint-ORIG-GUID: sudWUtX824Ivyoqt_Ng_Yki4stvDj2Zb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the brk VMA is the last vma in a maple node and meets the rare
criteria that it can be expanded, then preallocation is necessary to
avoid a potential fs_reclaim circular lock issue on low resources.

At the same time use the actual vma start address (unaligned) when
calling vma_adjust_trans_huge().

Fixes: 2e7ce7d354f2 (mm/mmap: change do_brk_flags() to expand existing VMA =
and add do_brk_munmap())
Reported-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6e447544f07d..74c0e3784500 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2942,17 +2942,18 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	if (vma &&
 	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
 	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
-		mas->index =3D vma->vm_start;
-		mas->last =3D addr + len - 1;
-		vma_adjust_trans_huge(vma, addr, addr + len, 0);
+		mas_set_range(mas, vma->vm_start, addr + len - 1);
+		if (mas_preallocate(mas, vma, GFP_KERNEL))
+			return -ENOMEM;
+
+		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
 		if (vma->anon_vma) {
 			anon_vma_lock_write(vma->anon_vma);
 			anon_vma_interval_tree_pre_update_vma(vma);
 		}
 		vma->vm_end =3D addr + len;
 		vma->vm_flags |=3D VM_SOFTDIRTY;
-		if (mas_store_gfp(mas, vma, GFP_KERNEL))
-			goto mas_expand_failed;
+		mas_store_prealloc(mas, vma);
=20
 		if (vma->anon_vma) {
 			anon_vma_interval_tree_post_update_vma(vma);
@@ -2993,13 +2994,6 @@ static int do_brk_flags(struct ma_state *mas, struct=
 vm_area_struct *vma,
 vma_alloc_fail:
 	vm_unacct_memory(len >> PAGE_SHIFT);
 	return -ENOMEM;
-
-mas_expand_failed:
-	if (vma->anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vma);
-		anon_vma_unlock_write(vma->anon_vma);
-	}
-	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
--=20
2.35.1
