Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E587966D461
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbjAQCgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbjAQCfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C422B0A3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09hYd031093;
        Tue, 17 Jan 2023 02:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zQ5XjtvJO+1YkocW/18NhwSq/RqvPYsN72u+sviozfE=;
 b=obSmo+WoIQH/4vz9anruROYJoSu3xRr3FeLVhyJlBztORMV5yivW3ohn4JwPyO52uUrM
 RNbpEAbzWp/QHPNOvJrUCQuVuTtXpzetSV4J+97fRH2ChhBTQMYrmbhu7M/a7kSepo5f
 57PQSBSF/So9Bu7bdHkAVsiDIVt+IGFKUvve14uZukd/XNbCbnWbfcsxzaIcm83VbPkR
 t3J9PP7BSq3PCIPcRgdI1jMvHRaYO99YHtqeuRb9K8YCLjzekOC2dfpO2cuSpJ0LpoBE
 VmY0qG0nW/T3FZ+BGCtn641bjKR8eqtk1zBBYtWS35pei9vHmcasLfqKaI07O0zEGI5z pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxt3phv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNXAUT020577;
        Tue, 17 Jan 2023 02:34:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq37hat-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRvzHC6aBpsPE7pVCYQQ7NWHTldIrJheynxF0TY6KO1NY4KVXDqEdDj7U+05cZc/16nyb1D7CEeaiYcR5gnTZIFN8BQB+f6f/BO+7kxP3ZPGUZvGcSvfN7BYTRrFG0SOebUO+YjC9JhrzNMfoNJL0zHP9C8fIWt57tSlZb1NmXx9II9QIB5xyq5eUK12UQUVgO+isLu2IlUQYbmzd5gC8suW4Yw1GTXmJ3B82E2g8m+QLCDWOiGhW9ELvg/yaGSmhdXnF4dC9M4pXuy73y0VPcGljnxcw83OLkseTKbV77JO6OltxTaXQAt327hQ3L9SRGdO6ZuG5SRnaTz2Tu+MoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ5XjtvJO+1YkocW/18NhwSq/RqvPYsN72u+sviozfE=;
 b=LZP7DgKLOxPP6g859x5ciLiaPVeiwSk23hiQk6Px6GGcwAjsy/4uOMbzyzukTyUMvo1rVziA4hZqzBpKKds8fuXrutvvEAr/No2sPFRPqDZY3esR9GubFmgFO5kcaT9WRVyG70lL4UW6LllDKaQDskb4u7dG7TI7C62CVpWMfNFgvtypL8QeKg83yfQGME0lc8q4b+ci4v9DYSq+eB/bLXD4Yt7oZrDX4utDPSVPUjFbC0vfqPCjMfVR17E1ZUlggjYaKDYAc5mPfYHi26iRupSBvO1wzt9cXKSby7GThuBJs8BUfyvBrd4BDrRQOUm5ICV6bg7JKdCcnInaizpauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ5XjtvJO+1YkocW/18NhwSq/RqvPYsN72u+sviozfE=;
 b=Nu005uKLLkGwEl7/6FowStMMCkWF7X3g0R4IutQierWd9af1yYTszKkGJXZsJALVfyfAT9AwPa5QAcpNxgjoIMGDMFnnefdTM3T7JBP8LrJe+6OqKSzTef0glVNKLV4oBVijb5KVDln17WJlqkzZkTXPAOPRN+ClOzQGp5BEnVk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 16/48] userfaultfd: Use vma iterator
Thread-Topic: [PATCH v3 16/48] userfaultfd: Use vma iterator
Thread-Index: AQHZKhwwvi5mGHoUYECUpp0A5/lQTQ==
Date:   Tue, 17 Jan 2023 02:34:15 +0000
Message-ID: <20230117023335.1690727-17-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: 5f15e3de-5e4c-4743-f1c8-08daf8335449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQN8OG1J/FOX28ArGgCNE3YYR6iODrcKP4xtQx2knuPLQwFFYadNWZcn7QOW8X9fn8r7TF215z9iuGNQacatEjzRW/Ihz8mu+MwjIipyXiGUmR8av3ds6ZgFHQDQ02ileBVH9IfqXliaMVTmJ0fxO6ZLf5a5Hhxpgnts6wq34S/PXxeccjaXJBa5TQvGVi9cxjsafIWkXCZTSxm+uzBr36YExahoaw3fDQj+D3hH0vQ+0EFecv1Bq/syBwMebhxzBiR9a//cLHKuISQYEXyYpYNDlb2q0nJzJJGPMFpZpnQ7ZpfifJE/GMDcPeUghrXJjaSemadZbg0RltdC2Vt9hWLtFW5iQosE3lvBUj95kjSlEQN7dl4vX82qEcd4iJiTdllxV2/0EZS8joq4eVibu5dPz22zRKzwxPbnw2RANhX46RxBKwlgonakCm2OtqGqOX1QoCC+pwzwByl9B/QDyHjCvm+0lemSlL4tWANUQYtU513M93frhy30WRiU8h0CSzJvE2jCLNn5z6OXx8P9XX0+sf1j87wLov2a4T6Hi6WBBT2E9IRE173Bi/DJIsCB5CPqe8utF6seLz7jj6cuy+34RLPxh6EAEUqaVDGLYkS52rb5xAtHl/940+JsB6P99j1zIWK4X9MSe4b/EvCW8T5BftMLZ/eqtyQPeDLNotKGiHOupKnRiBsuzE6KYjwzs18MvhWL7D4aUFAwIVSwsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V62sMVALv4FYNTOKv2gw1W33eYQF68KRlYZQH/86u1fkrdUIFYYurM9mT4?=
 =?iso-8859-1?Q?GkOvC6kvKKQR4WcHJ065kYUcqYBHcsJA1Ep5YYKvLf2jHqX1xtPSPyV56R?=
 =?iso-8859-1?Q?uDWxPmJ5DrZoQo732ZveCYNbmKAsLL2afYhgQ9IL8D4TUscaBdEuERHuqz?=
 =?iso-8859-1?Q?MCSyrxNjx19nadaeQnCCYZKAuhvgRCkCb5hddJsEms3aYW+dRHXct5E2QW?=
 =?iso-8859-1?Q?9UTMHM9moPjSAyZslET7ayGaiQSZlCzrE18csyK1du6+BfN9oPU8e4fgDy?=
 =?iso-8859-1?Q?Pa7FFqNYORFTCxjTZs4Snl7knzQAWxv4ze4HOQrATb6Bl6y2XYm75o1ixm?=
 =?iso-8859-1?Q?UPPib9iz3QNtoKqlTJzC5cJ6Zif8xtbu36Y4pVacDxJ8yeTkjJ0TtJvNEs?=
 =?iso-8859-1?Q?5AIW/WAdFGACN4HLoJK+URHGd/LfhD0b/+ZiWBBnT0b5oCqyly+vGoFG22?=
 =?iso-8859-1?Q?SKEqTyutZXpCpuT+xYbMGPiigE8nuWBfD0E5SQFDKnTwDPCWQoPoV9ACCN?=
 =?iso-8859-1?Q?nZIAr6N8UegUOH6NoB7zXtbw4WufcuIQUngKJLaFopmwM5TTWrMwDjd+99?=
 =?iso-8859-1?Q?4JMqg2ssi5NnKceuPZrBexDYhIYZG7dGjF3GC2DoB3U2C89gBz1Y8eu7k+?=
 =?iso-8859-1?Q?3q9vn4LMXBPDHRu4PyRoJL0VEDY4IwAjzZFeGAct41drGPq0Zc2/oU7IvV?=
 =?iso-8859-1?Q?fBMhhrF5o6EccYIqXsS6W4kKD2TLdEFgcO2slP4qmAbHqJFhBp0OURUd+m?=
 =?iso-8859-1?Q?ruTFdnLjgX4Fw+ayNdTeBXcpdBIIq9/Y/AwkvaUgzYzdtvl6Dxz1wQKt3K?=
 =?iso-8859-1?Q?vfCoQmkYBWcuvFA/c5tOnSq+4TsEqA+q96zUdrQ+VIw9gMapM0inN7hG6c?=
 =?iso-8859-1?Q?NAvpwxiE+B9ZRYPP/l3kZIIPbn9UGxb6KGOCxsJMb8VoNgDZceouLbC9iu?=
 =?iso-8859-1?Q?GC9yUIResX+S57afFHH27wqYTqCGO8u12dueO/O0hKD77akpoloUApZ/Lj?=
 =?iso-8859-1?Q?6byaotFIaAbwd42DLwjiQJhdltlJqu4G1i3xed+frsVjy39ShqYmmBx+n9?=
 =?iso-8859-1?Q?X2S30KDrUIPvfUpMiMUtSCA+NAjxdzubq1O42mWceSKPDvjX+UactFueD2?=
 =?iso-8859-1?Q?9qzEBB5cumW/g5UIXiLjrRipLX7anMolOAnJH1aIMgVt5nuZ28DgTm38KG?=
 =?iso-8859-1?Q?3s4VQtuV0CwYaR2UeUFC/cUBMj4NkRWFSdFbHSEl8KXkdF41tIvT7FJmgF?=
 =?iso-8859-1?Q?10MjqUdiL3gGAa+0AHHIy9kYGPJceRqqZwzBV9GnqMkjp4Zup8HUcAsT9R?=
 =?iso-8859-1?Q?4eFULmKIXsOfDXIOTbHYDtJGxrK/DAQWRK0YrM3zwypV6GeXeEZd7dO6UE?=
 =?iso-8859-1?Q?2viKfS0UU8iTw+rD8YNdEm1arknfNY5XU6kUokk6WmVYA2HccARSY1KtmK?=
 =?iso-8859-1?Q?1+hzwQezhF5eVg+1J3Hd1jczLihKA9zRh+4vCJPmRk2/OpAWSFJnQyg+/Z?=
 =?iso-8859-1?Q?/CZBL3V3Rp4Nj9ZmxINNE616gismriDAjDg1tkKD6hDhooMBBSsAsPRyPv?=
 =?iso-8859-1?Q?CMPP8H9JOX0BYoOb6KOjDqY3Ceg3N3aQ3tiS5qHtTyLmj+FJxa+MKXxuba?=
 =?iso-8859-1?Q?TtzYtnGVi4HPIpTfHF62m4wGUk7oU7NidWHZ1RHLYaB+3m+dRBXfPqNA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VtUS3yNrUqgHiRC3xdS0BKCW6jNSuII7xLJcUX5Gkd4CPB/q6DZncaXXkb2nBoZcHcFd+5Bpr6MqLSOyWN3C7Jt/S20OZ0Lw+GoZNFkkIuoSN7PJxV6HbqEedH2ovort5AsYrJcMjG0BG3LdZLgO/BS7ckuiupu1KPMElIWyvpJkMXI0KadZAQ26Bej4Cb6eJ0CMFLUuwjkLBwuLUNZzrzswMilak+yKvP86cYM+0Y7l2qGejo74O+czNJb16YPBGyzLXW5lWLeaYH0K40ey59k8pzNP4NgzDhOpzxZUlI0HPvzLA53LWiBECPUJomMhe3VwornYFrrAYCPEBJyhEMWlqpR6yuAOgMn11NcmnC+RQBP+nRZuZY0Q0NkLBkItgPyiRBnZ+8V5ehMlyEXQ5coWkvsO9tE9QNKuo1QwGbBlUDTQF6/N6ntpZIrquc23XNlKZJapAGsD/0d10IZDbw/tNEgM+mNLDWeDw3CkgD1Q+meUT81oLEF222ir8L+1HoWzoCdIZssdVv1L2sCMWBVJXl7cdRPg+zQ9c2RTFh7EWY3P3sbvKg334UlW0JsdCTmQqk1eZgpBAp0e2xTwqTLWvN0CE/b+vE48bPNeAOMYpcopUqMignDMSdqWGfnQIIq93aS7Ct+pgc3lfjWvPx196fU8GHnRqA0KyumQwhXB2dl6D98muX10/Wdp3W0/4y28MbGD2R+T+qOKr/2kGMDJ9EXT1HZf1KbVnZLQEEXgmQVSF20GKsIcWVQ9d46D+0IqtpRPfqsLdea9sKlxPJ2quItvG7vL7jsmw+JhzdYXI6sbu4/PH6FDmgzgv1/htAjcD9Rz1FkMzv2Czgh2OCGyxvI/iWsk6tM6unWrqNp288NciitnjpVY3oX6Io5nv1INx8Cd9N7qGZG+yXim7g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f15e3de-5e4c-4743-f1c8-08daf8335449
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:15.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ux6p2EpRmYL33CrVLOlB1MQRE3eQvYCDQEod2KIROzRH03hLXcYCx5bHwM+F6S2QkiHWJKnwfQRCL8i0UgT1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: Xj7bO4vVdGnSZaF2hIYBvid-K2imYjTO
X-Proofpoint-ORIG-GUID: Xj7bO4vVdGnSZaF2hIYBvid-K2imYjTO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/userfaultfd.c | 87 ++++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 54 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 98ac37e34e3d..8aba0afb9b43 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -857,7 +857,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -874,7 +874,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev =3D NULL;
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
@@ -883,13 +883,12 @@ static int userfaultfd_release(struct inode *inode, s=
truct file *file)
 			continue;
 		}
 		new_flags =3D vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end,
+		prev =3D vmi_vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
-			mas_pause(&mas);
 			vma =3D prev;
 		} else {
 			prev =3D vma;
@@ -1276,7 +1275,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1318,17 +1317,13 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 	if (!mmget_not_zero(mm))
 		goto out;
=20
+	ret =3D -EINVAL;
 	mmap_write_lock(mm);
-	mas_set(&mas, start);
-	vma =3D mas_find(&mas, ULONG_MAX);
+	vma_iter_init(&vmi, mm, start);
+	vma =3D vma_find(&vmi, end);
 	if (!vma)
 		goto out_unlock;
=20
-	/* check that there's at least one vma in the range */
-	ret =3D -EINVAL;
-	if (vma->vm_start >=3D end)
-		goto out_unlock;
-
 	/*
 	 * If the first vma contains huge pages, make sure start address
 	 * is aligned to huge page size.
@@ -1345,7 +1340,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
+	cur =3D vma;
+	do {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1402,16 +1398,14 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 			basic_ioctls =3D true;
=20
 		found =3D true;
-	}
+	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);
=20
-	mas_set(&mas, start);
-	prev =3D mas_prev(&mas, 0);
-	if (prev !=3D vma)
-		mas_next(&mas, ULONG_MAX);
+	vma_iter_set(&vmi, start);
+	prev =3D vma_prev(&vmi);
=20
 	ret =3D 0;
-	do {
+	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
=20
 		BUG_ON(!vma_can_userfault(vma, vm_flags));
@@ -1432,30 +1426,25 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 		vma_end =3D min(end, vma->vm_end);
=20
 		new_flags =3D (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		prev =3D vma_merge(mm, prev, start, vma_end, new_flags,
+		prev =3D vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
 				 anon_vma_name(vma));
 		if (prev) {
 			/* vma_merge() invalidated the mas */
-			mas_pause(&mas);
 			vma =3D prev;
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret =3D split_vma(mm, vma, start, 1);
+			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
 			if (ret)
 				break;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
-			ret =3D split_vma(mm, vma, end, 0);
+			ret =3D vmi_split_vma(&vmi, mm, vma, end, 0);
 			if (ret)
 				break;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 	next:
 		/*
@@ -1472,8 +1461,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D mas_next(&mas, end - 1);
-	} while (vma);
+	}
+
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
@@ -1517,7 +1506,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1536,14 +1525,10 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	mas_set(&mas, start);
-	vma =3D mas_find(&mas, ULONG_MAX);
-	if (!vma)
-		goto out_unlock;
-
-	/* check that there's at least one vma in the range */
 	ret =3D -EINVAL;
-	if (vma->vm_start >=3D end)
+	vma_iter_init(&vmi, mm, start);
+	vma =3D vma_find(&vmi, end);
+	if (!vma)
 		goto out_unlock;
=20
 	/*
@@ -1561,8 +1546,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 * Search for not compatible vmas.
 	 */
 	found =3D false;
-	ret =3D -EINVAL;
-	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
+	cur =3D vma;
+	do {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1579,16 +1564,13 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 			goto out_unlock;
=20
 		found =3D true;
-	}
+	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);
=20
-	mas_set(&mas, start);
-	prev =3D mas_prev(&mas, 0);
-	if (prev !=3D vma)
-		mas_next(&mas, ULONG_MAX);
-
+	vma_iter_set(&vmi, start);
+	prev =3D vma_prev(&vmi);
 	ret =3D 0;
-	do {
+	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
=20
 		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
@@ -1624,26 +1606,23 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 			uffd_wp_range(mm, vma, start, vma_end - start, false);
=20
 		new_flags =3D vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev =3D vma_merge(mm, prev, start, vma_end, new_flags,
+		prev =3D vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
 			vma =3D prev;
-			mas_pause(&mas);
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret =3D split_vma(mm, vma, start, 1);
+			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
 			if (ret)
 				break;
-			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
-			ret =3D split_vma(mm, vma, end, 0);
+			ret =3D vmi_split_vma(&vmi, mm, vma, end, 0);
 			if (ret)
 				break;
-			mas_pause(&mas);
 		}
 	next:
 		/*
@@ -1657,8 +1636,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D mas_next(&mas, end - 1);
-	} while (vma);
+	}
+
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
--=20
2.35.1
