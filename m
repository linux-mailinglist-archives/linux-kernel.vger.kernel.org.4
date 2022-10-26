Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A062B60E443
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiJZPOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJZPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:14:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145DD240BE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:14:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QEDqNS021472;
        Wed, 26 Oct 2022 15:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=zDBAdQot+ixRbujDJkRJuP8QgiracFTopAdpCSAS5w0=;
 b=HR/LHtUZZNzdRm+gneLA+7OJOMtE/JnXsTzIBbSa7N8ZZ0Ld2O0c0Y4rwIo667+qxrRM
 UdFhzc1DZhJ0Xo+dSrviTtTjwnowS7N+bnkU/gRyaBtABqMkWiXofAeXb8H/sOAQalR1
 KsaPOd/Mh2i0wzIswthY2b3kIB+s9N2eZ/P4JJZaCbGzxtecHjdavySeAbPFIJlBYhDS
 w2PohTXQtxChieyqlr5YAbkPzT5uWsixqZwYZQ+kjdX0SCE6wlKd7dN9RMJW09UbdqfX
 /IiWqFDUb7nVklp6eRI5saWQqsFgafo3tyM7wN2iL9NgLm7vEBmuVx+Lt+KLZZIuYb3N PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc741yhmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 15:14:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QEeCI0031800;
        Wed, 26 Oct 2022 15:14:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6ybvr88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 15:14:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcWOBPEoVlJCry+UxqAv+r4g34Nr476gEbJvaVY+o+TiNqNaUQyFDH4bb7gacQUuSuQP1IY5KlfBZ+MkIbWnUwpVURweg34kHBpegk6XRzWfCDaFFgKQyCP1WJ8TdBIUFYSe/oF0uaIhY8FLiV1pUq8Sit8h6VaNRXqa2CLAHvJ2V3TR2Az5WQd94v+ASEdd3U2eZbJxFRe2XMRMFtradLOIiKn9D3mrfvAaZdi3mbRFXeaDkVvkrClBiqKQB4+Kyzybg5AL3oY+5knPRK75opbzblBy0i3diUAnWQs/z4CGy5RQhFhjtU1hGnVAZmPQkzcDcwKM/ZA8/k3YjP1eHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDBAdQot+ixRbujDJkRJuP8QgiracFTopAdpCSAS5w0=;
 b=Q3JbS4xOZHDRtTKcInQxeITaNT+LNq9UA214K2M4Bapt9mzdWczzc0EAWlXs/LBhKRh4q5sXhoWovRkCi8Tj97UEVDJ93Ht8Q27HUFxsmoXoI+IorlmQ0kS9pWYweD+ZCmeD7DEN+yrHQBulSeMKNCqVgvdrPMWUuAVG4TT6hgsJf0oADhmBo2Xvonv6PV3Urckg5ni1Ry52yk0+Cq7ffvvECBolIDrMYA1wYkhE9XEQ9OV0dHnLlGNPv7KTGDXqO+GJ8qGIUr2T+SSgMqZ2YAVuWXeTtRtxhXJUioYbr1SdyS4H/THVlIgtaS5lGL5X+NnF3FADvCAtqKEPCMhq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDBAdQot+ixRbujDJkRJuP8QgiracFTopAdpCSAS5w0=;
 b=vI5XymgfcVTzVXHIsdyiLOgBPvn9F46AcDqymtkn5Nw/HGAQpNdReBg9vXD50uZHxGQND6yY9aN7BPxDHJoKKOhVg8MsZcCHCBS45YWH5NkETRkXvkitjwbRMT/fqAInU+2bok/hG5RkWyUpGMB5ghCIlvflk6Xv9F5ekJ1rINo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB4838.namprd10.prod.outlook.com (2603:10b6:408:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 15:14:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 15:14:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] maple_tree: mas_anode_descend() clang-analyzer clean up
Thread-Topic: [PATCH] maple_tree: mas_anode_descend() clang-analyzer clean up
Thread-Index: AQHY6U2msCB5nQrR7UWVn6PfHu0VWQ==
Date:   Wed, 26 Oct 2022 15:14:31 +0000
Message-ID: <20221026151413.4032730-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BN0PR10MB4838:EE_
x-ms-office365-filtering-correlation-id: 256bdcfa-15c6-4515-6392-08dab764c8da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HnDhV6QgpApeUNTdObMveXaGg4rltZvaf7VZqgfRmXHDt+6D9Dan/R/VkHiuvAkPjqEI60ZKrVuVRA3W1wnyt3Bl/phjZvxgrKnomWqaZH+3XNJaEzyZZcv3kJaw3VqxiGWjR5sLyq4WMOc9RL7gt2zMPUaK7LCRqLg1nES2FtSC9GYqU5/EUOiuU5InchkoUxzV9k52qX4/0ERSaAV6TCUYIvfPO/irxW055olE4M6Tx5uwDjf41iF2OlzHo9KN09iZV00pqRNZcHG4iUMPsd2K9aDLWimpWmN1Sa6+o8MWR8xjsAoA5ioE+ohHzKe1cWwJW74Ew4cfUNjJvzmhrIvP0UYIxCV8LQWGfAp5Z3ud6NTsI671d13r1fHiZp5WMHuQo7h4j1Dnq/n+tV7HVl/oiWpVUQfBS50IwCfbNSrKa7WSEB+AFOn6GLjzp2U7dwNI/R7d5zKP7XcrwfiyYKcgQ94s+AyRCPx+CzpsSyAofxF49KnOlOxb0pvNO2H5/U80B6sauE3NbraxnFVY+s/mba4MpmOJPpCdW0LFAnIkcBtQULrCw6ydrP3eKA64hZpTQOcK7dWFgXjg/5MVJGk2hO9h8g1QVRIQU3VCwfjFsrtKf/bWA5MuKcXlZwhI4Dyrdm6kG2VV9rYqWsFeiC1dBLeMeZmljT4aUE6wmgU6XWs/ekPf9P+mnBX7CmcglI2rHQYsXuoDlgVPC5/P1Qu8vjJZ5jPR9zcZxtry1dXUS6IJaCoZetGQRiHshj8kBXHk/y0wNoLFW1+4l9cg9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199015)(86362001)(83380400001)(64756008)(8676002)(4326008)(66446008)(66556008)(38070700005)(8936002)(41300700001)(71200400001)(5660300002)(6486002)(2906002)(54906003)(478600001)(316002)(110136005)(66946007)(36756003)(2616005)(44832011)(6512007)(122000001)(91956017)(1076003)(76116006)(38100700002)(186003)(66476007)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?50l2daQTaWMIZ1xTEDlIrHwHNOTANMC8IpQU1htdGZjiL1v6bRr8d9rEzI?=
 =?iso-8859-1?Q?G7fIuxt2cpRGS0IkDXsqA1sDRvzj8MhCFSNA2vZmdoQ9zDWfdL0KP4qoDo?=
 =?iso-8859-1?Q?fCiVuwoINgtLVMfJHMdPjzyWqlST1HEw33Ve0zYJNn/yJyaJoL/CyAmy3p?=
 =?iso-8859-1?Q?d0nuQuE982aiHuiLCUu4EBm/ZVQo2CcyEu1AT4kymds4D5GGMiVgFjZknW?=
 =?iso-8859-1?Q?R/FscmiXW6fWVNVbIsIcPXcoMKZAV0hxmk3Ggtb9s1iprNPC8p0PzgOhvO?=
 =?iso-8859-1?Q?IlncErjf93RqAfagyHNyZZlH3xJw2UiHB+jYTdNu2BQ5Sv2cOytzIBWC+P?=
 =?iso-8859-1?Q?kMljUsXe0MeOwZ4ZY49JLDGg6z2aVkhyrhUhL5wz2dogWw8f59xMppnok8?=
 =?iso-8859-1?Q?V7LGHSZF/bsJ0m1bv1S94vKRHJ8fSYqqD4Q+KYPQxPbSh7iBgCdq8fVyQU?=
 =?iso-8859-1?Q?T9tb5OWyQFwsooEs8c2h0twbTo4tmZYDEt1h9YXIpcEygc7V/bcIr3U73S?=
 =?iso-8859-1?Q?06fcdJ2cQdCDieEPOfv3PQMtTz9HqTICn69kEqoq1a+FITnuqutTYLF1Qv?=
 =?iso-8859-1?Q?mgp9Z2zIj+QvgfL6EQI8K3YlbcQKFnW3mdYeakxa71XiyuRb+c5hQxDrT8?=
 =?iso-8859-1?Q?qRAPZ5iJ3+c7406ewMN5ebk1qJcZg/7Mm4QmBw18Tu/8Io1eLiAxZL8Q/j?=
 =?iso-8859-1?Q?9einaNwszA12duDBMo2uEEQ80uNPOr9YLDZgYt36OGnh3FPPS7guOEx1nG?=
 =?iso-8859-1?Q?Wdxzo0tnZG7nSxLiU4mkVunHAK/dR+AYgSyW9urdzlPrwVWN40D9rlbWks?=
 =?iso-8859-1?Q?G3YyfchjqubKhiWcEupS0VCqMf36M2cQJSqW+CBHxLi0y5T7p0zToXD2Lh?=
 =?iso-8859-1?Q?wG0TsVtrz4Fu0yTL1SRBnmVrjXCPF7qPutzkiH1hxyL1euiP/1b3OL6iD0?=
 =?iso-8859-1?Q?xK5bmAEdP2AjR9AZ77Q4u5iTltf53ZyEl04SAkD9+zw8+LK4yIWksbk7Og?=
 =?iso-8859-1?Q?7XsG2MHYNXHJKZEre5lTMJGZ0+5qKeGm7PM53Wc3ciiYaXrJfAN1p6unDc?=
 =?iso-8859-1?Q?jZtRIwk0OzmipsOfdqp6wSZbkQiRqQtzU6Ljrf737qbvJYNwfum2sCCS6Y?=
 =?iso-8859-1?Q?nJzStz9sH3Vn2H6V+KqOp7gHeeZfsZUZikIuAdmbq2iffmQMyX9oqY9uvH?=
 =?iso-8859-1?Q?nenTDJoPpIMgKsyISdxno5knA9m1B+Ks19TNm/CDbBzAOmKVaetkoUoQBP?=
 =?iso-8859-1?Q?mZy32yY7rjnB1ZV9tQWfVCk/meAaWp1CUgUXaJwI1WyEC34fpfXegKn+oO?=
 =?iso-8859-1?Q?f8yvMCeBMs2RAPYKSxgrJLp0LM6Hz0dy+hxt7GFm0soV+ut77DN65Pk/o7?=
 =?iso-8859-1?Q?wWfGq8iWZi/sv6RpYW05CH8s/hB64j0+ArOC8Ttmv1MDGCIh5ZYAkINjsS?=
 =?iso-8859-1?Q?StoJOgcUcsJL6h8VQaB9zpPpGGUezsEJ7G5fTLfkARRGET12ynYVy04aj0?=
 =?iso-8859-1?Q?q68u0eEupT/2W3KZT2TfukWR78CnlWPkzLfZIHkYrUKu0408IuPHWP3r0q?=
 =?iso-8859-1?Q?JV1gJJ+Ivl80V5HBs/pftymMlElZa/RmZmtFynoJ/q2ksy6bhBDkkHjFWM?=
 =?iso-8859-1?Q?SczeiASedcS93XZQcBKsQhpo5pwcPNm69JP0bJEKD5s+e68dzqhwI+fg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256bdcfa-15c6-4515-6392-08dab764c8da
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 15:14:32.0558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COs7XMvTdtckp/+o4hww6N83v5PM1zLArgNG/omD6PMw2L8p3b4Z28nnXauPweeQdZUqfxij4CNXuEsqFnvboA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260086
X-Proofpoint-GUID: 9kfurUg1WwyirjX9PdG_LXh8R7U66gPX
X-Proofpoint-ORIG-GUID: 9kfurUg1WwyirjX9PdG_LXh8R7U66gPX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-analyzer reported some Dead Stores in mas_anode_descend().  Upon
inspection, there were a few clean ups that would make the code cleaner:

The count variable was set from the mt_slots array and then updated but
never used again.  Just use the array reference directly.

Also stop updating the type since it isn't used after the update.

Stop setting the gaps pointer to NULL at the start since it is always
set before the loop begins.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6f3945654baf..4b3d16ced024 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4964,8 +4964,9 @@ static inline bool mas_anode_descend(struct ma_state =
*mas, unsigned long size)
 {
 	enum maple_type type =3D mte_node_type(mas->node);
 	unsigned long pivot, min, gap =3D 0;
-	unsigned char count, offset;
-	unsigned long *gaps =3D NULL, *pivots =3D ma_pivots(mas_mn(mas), type);
+	unsigned char offset;
+	unsigned long *gaps;
+	unsigned long *pivots =3D ma_pivots(mas_mn(mas), type);
 	void __rcu **slots =3D ma_slots(mas_mn(mas), type);
 	bool found =3D false;
=20
@@ -4976,9 +4977,8 @@ static inline bool mas_anode_descend(struct ma_state =
*mas, unsigned long size)
=20
 	gaps =3D ma_gaps(mte_to_node(mas->node), type);
 	offset =3D mas->offset;
-	count =3D mt_slots[type];
 	min =3D mas_safe_min(mas, pivots, offset);
-	for (; offset < count; offset++) {
+	for (; offset < mt_slots[type]; offset++) {
 		pivot =3D mas_safe_pivot(mas, pivots, offset, type);
 		if (offset && !pivot)
 			break;
@@ -5004,8 +5004,6 @@ static inline bool mas_anode_descend(struct ma_state =
*mas, unsigned long size)
 				mas->min =3D min;
 				mas->max =3D pivot;
 				offset =3D 0;
-				type =3D mte_node_type(mas->node);
-				count =3D mt_slots[type];
 				break;
 			}
 		}
--=20
2.35.1
