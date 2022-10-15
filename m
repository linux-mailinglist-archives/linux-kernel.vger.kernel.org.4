Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A91B5FF7FD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 04:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJOCMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 22:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJOCMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 22:12:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B377538F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 19:12:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29F2BX3G026699;
        Sat, 15 Oct 2022 02:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=qrxJIbgoG3VpLO8BMB50TCmQSIanjlk9BG06RJdD56M=;
 b=IE7aw0k4bjsSINmyH6nfq+hSY28K+dhDajnJtnESGdCo0nrLucBucKDLiVi0eZtDPiv9
 8oqfmHPTF23L20Cs7fU+uDf4yz7x8xj46cmjuL+U1MKi+chRw9ubAnzLPygEKKNgK63r
 SgfK6U80mz4AsEMgO2hSCC0P0eXaH5AdzHiVA09POdks0sVyZu/HaE8QraW5x6T6Wf+S
 mFHfUz1sz9S8YUJbfUx2xfdJRnKeJmPACj6KIPKwpkvDCYo3f1bIrzzepXgQamxxSAUS
 N5OZU0JJdDnNAepA29txuG42D7mYyJXWtPEADMnmN3Mm37oEjg7j+ZA8k3tgYRbt0PtX xA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7kn2r07m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Oct 2022 02:12:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29F1XUDl028714;
        Sat, 15 Oct 2022 02:12:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k7ka7retr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Oct 2022 02:12:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPYhZEUwz6uZDumjpLUEt8zxFMzOG7tq6nqKoNQefCOgbbhdUmPMRDm0QGHJ9yFNtHD0AY0b3KLMY0KhoKV8hRsoZoixqPWzZ5mlJWj4Nle5xPsoDfnUlNSVXIVwKiXg1hdjatGBrBYaaVPmpdY781LDkec+9GYaeRLD1Zxtg7iGHrexGpbGFDM13hZGaf0peBKo1a+6H+BFkg4qUuSloLViSxWblecZ4WY6Qtm1jSYn137uP35c3mtSoboNHBDJJWAB5aCeGR+nNEroSVmyUdw8+HHPbT7DJfoMvMjYZurEhIRu7WPyFl2TEDmX1NBnzfl8lJQ1daMTK13y+CHKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrxJIbgoG3VpLO8BMB50TCmQSIanjlk9BG06RJdD56M=;
 b=CBZGGHv+dA4m0ZDixhJSyszd1v7InHf5XscyDNyn5XURPX6789WXmmpWoSZ/WqWIXq7h+Zbag2QA1byU7GMdEw+3GexN5Fnhbm1bbejLM8yWybLzUF13Gql52jKplsEWiogrC+8rs3t9muS72Ty0rhSqVnd68DbSrUbywRRJU9i5Pxh6ji/Y3+x/FfBDsVWJuX1qk1YSXGroFSkpW7k8RSKWb5ZZ5JId2WFQ5ik6Rbp3UaA9/W7bqGozjkXfqqdsJpmMFZ0bnIm/LWm7wULvhs5jFa8lWq2T7yFfkDz0/IGUaeCQVpFY26WNW0m1JFKkYcrRpsXmxRVHgt19gzUtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrxJIbgoG3VpLO8BMB50TCmQSIanjlk9BG06RJdD56M=;
 b=WZZTEO27oqrM9dc6nAAOdR2Gk/CwmjLsWMDLjiq/ZTV8qn/pV8K1O3hHVxKgD55UabciLG76KDiXPRHsxYfk88GCvcHlq9BZws/6ne6soIetiw8rx9lfOEkEqtB5m2wIgi6kX8xU16+I/6Vhara9oBESD9e7kUOFzKwhsK5lqio=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5061.namprd10.prod.outlook.com (2603:10b6:408:12b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 02:12:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::2d77:5bd1:1bba:df5e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::2d77:5bd1:1bba:df5e%2]) with mapi id 15.20.5723.030; Sat, 15 Oct 2022
 02:12:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] mm/mempolicy: Fix mbind_range() arguments to vma_merge()
Thread-Topic: [PATCH] mm/mempolicy: Fix mbind_range() arguments to vma_merge()
Thread-Index: AQHY4DuWutsjwuGIPUKqd30DUZ/6yA==
Date:   Sat, 15 Oct 2022 02:12:33 +0000
Message-ID: <20221015021135.2816178-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BN0PR10MB5061:EE_
x-ms-office365-filtering-correlation-id: 40302c36-1038-4cc1-55c9-08daae52b895
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6K1kYQzJ7f1EoaNxqdm8SfRy9pAmsFmpMkc1w0eP66sFqezBNAKONYpsJi6vOX8+Sn5Rm8qwpalm96beBiXWyhLF1KPgC0uz767HgaCwZgx99czx6kCVGbGJx17YmJq6KO4ewNBG7zRxME9/SNoqhxmXfJCYxNUu28ATEocJwlyjegsajYFNa+/cErhtas8dNDN/NRI6xG1l3T4+hrxJBZGFv92wsy/P9jGj53fWiRyyuqJQP0HDo/dyuOEMrkHG1m9xrtHcyTNghYS/21i8cbAhGRR4a7lO4ASCnAk4DWWCgEtDDrRLfMPlp6UuTXSxVWoa2Bwr8lZBbHMzIZVcgKk+DfxwjAl5GxTgpPKn0Z+zSZU6H5ZDLZKfZ9xuGB/1lGUx+6TMZa2m6xYNVu8mKGryqKJ5YhfK+hGo/4aG1ewEShIKP8namU+SdMav2tvhtGaRKANT3tbN/co0F0dRLs9nZ0/6GWjuqWS9WpUgZMeZ71rDAwtu3xqTRhvwXNwCh0o8kVg4lkbtLYcoF4lfA2kskQ3O2ym5KpgO8MAvSUh5YEm8GOWo7b4khw6S1X5BtkijEH5/022tia5+qF8qfpnAeiuR6GZXO9WrDmJV+Hbk/hKqpHQapW8cDEPU93byyRvHpAdoJFjFqxhMiguQRY16Jgz2AfY6L54vccIpxSrsEOzN2btRheTBzzeouxfdF6ao3fENLZdnxWLKlpsHHxZNUgtJrBh84nj7DMMk2+47dQAZSFdfNR7NDMguRImgUCD0ls3LVmdj5+MNWwUsCBsu6KTX1TFXhR1MgCNrZhY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(478600001)(71200400001)(6486002)(86362001)(2906002)(966005)(54906003)(110136005)(122000001)(316002)(76116006)(66476007)(83380400001)(8676002)(64756008)(66556008)(4326008)(66446008)(38070700005)(8936002)(186003)(41300700001)(6506007)(66946007)(6512007)(26005)(1076003)(36756003)(5660300002)(44832011)(2616005)(91956017)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?//K4g5KcoY8wBva2rh+YFJLYD8V+nt4/3jTBMZS98zlNu82VUuXP9+G/UI?=
 =?iso-8859-1?Q?fRBWnNdUq8PZ3uroidC9zXbuNkcU8EpyLgu52TrlY+PeBMfmkgPWuAbkpI?=
 =?iso-8859-1?Q?nxEI2jOlE62x+kT0d1t686IRPnXBJMUyKpycu39QrSY7sqRl6rHxJEfibY?=
 =?iso-8859-1?Q?K2sGHx9Twzc4tmPcj4gbADdigUQKTT4booKMO4+3GbUb4Nt2XfNhwW5C+w?=
 =?iso-8859-1?Q?N7/emTAT++rJKoWk92a6hA9DsYRHUIjsslWLEWcVU8jE64rnyCMn0VF6TK?=
 =?iso-8859-1?Q?gSkLJX36h5/15ggZBoJ78jEa7J0nHRxdgH2NIncpAMaO40Wyt7vhg5nut7?=
 =?iso-8859-1?Q?bG0X5vyTLaMPB7lTz8ijlecSN2Bq4grtZNPWS+uy00ZB/dM/GbWRSGnaXF?=
 =?iso-8859-1?Q?qQLeKtcLVDDMtPVV62NpLrbRnDu73HYYjiEl3+f9S6/o/eWJjZECsM+gK+?=
 =?iso-8859-1?Q?UuaiGY/KN1b7Ep9I+4A0nA4ZD93PKjmueoNmP7fReIJdr45Bs47WY0A76B?=
 =?iso-8859-1?Q?euxCmfNuOE8kq/GrbDCLF7zHQ3XsZ9Okosa7vE5h22dM6hVeL98VxQx+e9?=
 =?iso-8859-1?Q?0eJEENHHwb3maJ7Rhr1wgxVT34u311wdrXQOLBjuNXAMo8i6E8KUauq6sY?=
 =?iso-8859-1?Q?wfCJ2yAaIeSbLgZgBTamxESAHm4HO2HwUhUwfIvCWAoQttsqBgPkh+S0gE?=
 =?iso-8859-1?Q?4mmNhYc9xq0u3NJqhutIyxnIpnywgCA+bMX/ssODrsUOvRJW8wSaed+KpV?=
 =?iso-8859-1?Q?hr4TBKcVBsYiHgI2UC8t2Utb/tqWJLSfk9FtkHgVvDBIKok/3g/VamUn0f?=
 =?iso-8859-1?Q?t01RvKoMNmf6B4tomLRNtIRR+pnJzjtiMcJaCV9src3nXKrk7AYbD0VZzu?=
 =?iso-8859-1?Q?dfotkjn6Zjix4ESCt6088O/hM5Br3bh0TE+TAa9MC/r3NQp1fESH4ajux5?=
 =?iso-8859-1?Q?I8/j2zj/8IuelJl7qB+sbPJfzaf/qz3wAXvNfla7YY5xxEV3Cpreez1ur7?=
 =?iso-8859-1?Q?69RSFKfNs96KoW84ulD0HfwWs31XevdCU/pt9lc4B/FfZsWzcWf55aP47y?=
 =?iso-8859-1?Q?tm0QnMqej2Db4J9chMGRfRBZ1Z7yrf89612DxzttU8fYlkeNZ8u7c1ev/p?=
 =?iso-8859-1?Q?LEtSqjjekEpgo64NmIn6+msci6CJgi5ZBfyn9YfSjgmghFxtDddBVJfe6K?=
 =?iso-8859-1?Q?qkRxUz0StQhzIuGG/bz9x/NYAC0c4aG8uGnOWDxDHHe2yktlWeOZSuTW32?=
 =?iso-8859-1?Q?p36lLuXU13YcFC34E2VM+qdlfgNz9XfagwpWiBv0/Mhl9bR7pUKQ2LvkPC?=
 =?iso-8859-1?Q?73qj2GZOkDz1Gmv6K0PAoyD2isGNWnvBfdeS+7KsiKSTJ7QXHpAtgTnoOm?=
 =?iso-8859-1?Q?6mu3SP//3pc5/UtYaT8iYk081WVTv9EcKCXCHHU83oQYJtTAFOhsq/AJ4j?=
 =?iso-8859-1?Q?JrfRzAAbu15+AH98h617/8hXENoSYBbQzuMpiCS0gXzVBBTiEWgeN9K3am?=
 =?iso-8859-1?Q?5lVpHjfJxlNtc8xSLn4x6rOZ4cfiiA0y/wcS5dkoaSuv7j/U4vjVVrsReu?=
 =?iso-8859-1?Q?zDa2RZuJbocT3OtAj3Lqn8AEOgRcJBcwQ6WuCe/2YuIposLeQ3/gVDOfN5?=
 =?iso-8859-1?Q?qvN99kwrfrzn+W7YaXmp9uDY404UEvtEAC2Tj5zv8HgAK8Y0Fj9LDEvw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40302c36-1038-4cc1-55c9-08daae52b895
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 02:12:33.3536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65RHR10J9su6MLhU1g1rUrPkuLwK4D9R8a62OsnIPiHvZQFJ31eNKjljXf9peP2PVXRmi9t+dzcDfNDmgnYYRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_13,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210150010
X-Proofpoint-GUID: JMYnG66i9JbzvK5F_qd_4G5totU3c36N
X-Proofpoint-ORIG-GUID: JMYnG66i9JbzvK5F_qd_4G5totU3c36N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fuzzing produced an invalid argument to vma_merge() which was caught
by the newly added verification of the number of VMAs being removed on
process exit.  Analyzing the failure eventually resulted in finding an
issue with the search of a VMA that started at address 0, which caused
an underflow and thus the loss of many VMAs being tracked in the tree.
Fix the underflow by changing the search of the maple tree to use the
start address directly.

Cc: Yu Zhao <yuzhao@google.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/r/202210052318.5ad10912-oliver.sang@intel.com
Fixes: 66850be55e8e (mm/mempolicy: use vma iterator & maple state instead o=
f vma linked list)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mempolicy.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a937eaec5b68..61aa9aedb728 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -787,17 +787,22 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
-	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
+	MA_STATE(mas, &mm->mm_mt, start, start);
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err =3D 0;
 	pgoff_t pgoff;
=20
-	prev =3D mas_find_rev(&mas, 0);
-	if (prev && (start < prev->vm_end))
-		vma =3D prev;
-	else
-		vma =3D mas_next(&mas, end - 1);
+	prev =3D mas_prev(&mas, 0);
+	if (unlikely(!prev))
+		mas_set(&mas, start);
+
+	vma =3D mas_find(&mas, end - 1);
+	if (WARN_ON(!vma))
+		return 0;
+
+	if (start > vma->vm_start)
+		prev =3D vma;
=20
 	for (; vma; vma =3D mas_next(&mas, end - 1)) {
 		unsigned long vmstart =3D max(start, vma->vm_start);
--=20
2.35.1
