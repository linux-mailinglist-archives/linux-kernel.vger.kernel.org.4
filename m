Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09B163C565
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiK2Qom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiK2Qoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C20C5475C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:33 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPo8c012293;
        Tue, 29 Nov 2022 16:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9QxF2bsty8tFgN1YU7NieebNj9Kp3YKtX501tgL1yKw=;
 b=fTAyGszwRZbG0e87btMGW9/C9ZzvAvyusfmTuelLeaq0KdrRvYXowdGOV9oANrZPTNAN
 Y46CR37rZ8rasq2ogLSROkMY6tgKO58wQeeghAOW6cGQlbfKZ3jJPtl0X+h8UNoPYnVc
 xxPD6zA1+bN2bnTw8MaWlMliVAwnmOfywUvEugx7dhTgTbB+FWC0VMbn0ZOzKGzmKqAA
 1tCaMzNblnyF+GcfGjLZ3hA035N5BJjvxHRWOPIq9FP2tdMskuAfs+i1koeGqaOJdVD2
 W4IknqsQllCGVYQx4pb+hiwVGphdMqcIP2q3a1hojmC9eypOUo0RThaSyziphdMkB/LB Lw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdn8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATG7rBX030968;
        Tue, 29 Nov 2022 16:44:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398771pv-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlI2qbPiFa2ZKtl8mIVDoxqtodB2K3cBe+HguDc2Fjycd5jn3SMtmV3Z5F7qPQg242ELlBvG+OKKQ+yLpJreE/jgb0R38N/UcZJcxZNMeJbAvUBiMns2u3yrwKBMwnHc7R9GqD7xXK3fUVzAecbV9eVK/Qf9j26n8SIY5SClFrkxK6KmV1celgeOPpk/dqoU1d7G1Yv/z3Gz7V2dyGmKC6FAO39bAE5k7FdRpyHrrGj9a7P1zauRafwc68p7pVYbPRkS4bqU+IGuQZ+7T2Y5POIqcgLcYVW4NWhj4BCgiMy4ZiDGUv3mZVedVIa0laFMhjHTcgXno0uMJwFDTCkB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QxF2bsty8tFgN1YU7NieebNj9Kp3YKtX501tgL1yKw=;
 b=YymQ8/aWQtSi6N553A1YyHo2JFUiaP1cbGPkgq9HyvOpF/c0auhFDb7bL33khaNnJpXSNBeeA9de8VpKfy3n2VP/GXXoutZCb5RH2liUOqJ8/T2C/88/LpJVXgRIpIKMjK29tp/tPKf9TuZT7pWzf3h+nMo9lke6o7LVOVg/BZvhlc9GIqTaeGMRhkBguk5iyk/Opo3q9kBAQqb/FKDudxJKJRDM7qxqJF5cplr/mazaLoJYzcstFaj/jo/aL0pVV09wJPRF4rMPBgzD2Y5oya0xmi08rvgxtMmsd9vBvKbQLdFXywL72T4W3psr7VFzdoqTgWi9P3h2ickuQPC5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QxF2bsty8tFgN1YU7NieebNj9Kp3YKtX501tgL1yKw=;
 b=fuQ5w8FqxUZgrgSvePsahewq4oqV63NZYKsjQTR9MvNKrAQ0w8/0owyszTCT7PEUqGomj5yKdSJyIFksRibUGwYnbIjKiwcYixtkWO+WFCP2Z+R6qBbqJJpB7OYqy43XfAoyOvRucqFIDfG0vjUYuqTIhZY5SdTSg1kqoubnrY8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:44:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 05/43] mm: Expand vma iterator interface.
Thread-Topic: [PATCH 05/43] mm: Expand vma iterator interface.
Thread-Index: AQHZBBHU9foHbUxMAEi8caFhrTc+aw==
Date:   Tue, 29 Nov 2022 16:44:21 +0000
Message-ID: <20221129164352.3374638-6-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5321:EE_
x-ms-office365-filtering-correlation-id: f769a0be-3679-4a21-d8e8-08dad228f7a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k3EWTr594Gyp8UUjm9iTLds1R9+7Aok2B9BQgYFRyQwxXZuU0sFg0nsEBstBUUkJWVKf4vrb89NrWPKg3o6BATPFRNsF0BHFywBe+Q0b2sGet8O6zemkhgkVmVC5NyqALSjp0RfDBZeOXERQQBzHtBpVWrEO2Ej70BfnYVOipxVwwLf8llpq5o1VzK1nUMX8JP8xk0oNfxLluckxPDlXHTBhs04WQhcN+i6kNDQuW9/zC+RM/xL336QItFlakGAYb4VwuI5bVWTs/NMSBLzLDiHSf+RQth6qM3QR9b/wb2ajGHAKDOEaEdM8w0u5yW3stXjd0nBfItJULeG/9bQ7gDWNIH992W+VhBaDDKLFv03QH4LKFPD9EZKhTDud5X9Fuq8/fKzRx8F9hD9Zxn/zRX5fdS+Gw+55t2cD1xKLjnNBERURDH20Zj9QlQ8xTq0sKaFKzvXnC1NLE0mmXa0oSFvkhsOrVMeS+ZMDzupIEBT3YkoZX78RuAzARSFjvf+wxx5kIFg5ii3ZIbMV0dirKLI0xYrkO2br6CprXxReYmuUryCNIcLpzr6cH1ksrtlKS3z8jL8TyyoCsRpRoIYJ801amedemA3D9slhICD5n/nU57Rf8GRsn8O/WXIyg4BgICPnzXvBVX7MgvdlOf5guH3PECK8leLDUmPnkbGZ/VGlzzkesX/oLEPQtmYwMidEkVm5qfm/FEh+EFs3hDIH9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(83380400001)(54906003)(71200400001)(6506007)(107886003)(110136005)(6486002)(86362001)(36756003)(38070700005)(6512007)(38100700002)(122000001)(2616005)(26005)(1076003)(186003)(8936002)(5660300002)(66446008)(478600001)(44832011)(8676002)(66946007)(66556008)(64756008)(76116006)(66476007)(41300700001)(4326008)(2906002)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eAON6EEcsXo7cXTdJFLoC/pdctwIFXbAGWOkwZLBNlut6Uncyh995C9LKN?=
 =?iso-8859-1?Q?5s6QBGElArN3xYBxnJcl21kz37v1IDMaw55Xju5L4GPe56VgMCWR+jP6lz?=
 =?iso-8859-1?Q?pPtBWnkN1/OxcQEXMlMC6alQ8M0x1TYV8PaU2EOP60SDiP1vgGt16EnFrT?=
 =?iso-8859-1?Q?eJYT1IbkqPk72zoj87eLB9rfhnfhJ6qhj5axM5laurmUgbXLzAHaPo84aw?=
 =?iso-8859-1?Q?IfQ7Lcy9wH4eYdyVvko6gd2HDmladygzrBcBc20r2nX1Tvy7m7uXWFc8ov?=
 =?iso-8859-1?Q?lexuFMvWyYm1sE9FKukPgVXCi2SG6vm+nYnloLuBMfBOaHmmzuv4lXjO4G?=
 =?iso-8859-1?Q?wsTOZdNaar/SWgD852jzFQ8hE1ztn1TSJLmrZvPoCbDaLuOIFFGURAuZJV?=
 =?iso-8859-1?Q?8qGMPmPj3rqy89yNiP4S9WkKOlNPPAv1q4xrtmLGrMbLywDlYkw3+VxsmH?=
 =?iso-8859-1?Q?KETharZUsL1WffuypcUZw6uf1RtvHF7OS6iRSGubPSyAV/42JDZqN5ER08?=
 =?iso-8859-1?Q?tp24/MZka8tNm9HLc1GI1SDiCcrL5MR0XkAPOvLjQFXNSEiD6Uphh5H7rV?=
 =?iso-8859-1?Q?tCPfpSdGd/vpKy7kzW3VuFqg2no7ALxSJEqcgYnPj4dblfVxz+jshUZp0i?=
 =?iso-8859-1?Q?P0M50bvIYm4a4GhIZDnzKpz+Z0TtdNxCWB3z3u9DMIh5lXGdJjYYn9dk00?=
 =?iso-8859-1?Q?ndvG067MvI4jaVvHcFh+aIuwcGu/1DcvH7qKDXvHOsSSwk9QlAFMRRXOJe?=
 =?iso-8859-1?Q?OKRLa72qXUyyLmn9i8OG20QxfjnBsIr9ktdL++Xco5vuXmCit2QGSucVPl?=
 =?iso-8859-1?Q?9XXANs5a+e1ya6ddb1BVxAAM6K/0IkiXGoeNJoehBNxIpa4Y5tHOChVVPe?=
 =?iso-8859-1?Q?fa6UCW9awOccG4Klr0hfFE6IWUrm6PdUwqqbi31pxgDES9qO3zQOvkEuLv?=
 =?iso-8859-1?Q?9fyvwkfx/uLQe4dobwqKsG+t4rI/yT/wj5tii9CnsqZq0p51Auwqomm30F?=
 =?iso-8859-1?Q?OURwgXje7rspRTytoitnfFjCtCISDTA0+p4ujfE6RlGfJKGkVpOOCWJuKw?=
 =?iso-8859-1?Q?i88+XIuAX85+TR2gHN1rSoQaDyhv9k7Peql108mpu9QfM5QN/jtlWeMAea?=
 =?iso-8859-1?Q?s60/RatX3T7jkxn5Yx/o4xWYKcputyIqciDsdWK35x+ih0oOQudBnfjot9?=
 =?iso-8859-1?Q?BjubSsRawdI0/Nhl0xSwGXoVpq0juBUIDl8bYypkmnXuk4aJcfnaTUBStJ?=
 =?iso-8859-1?Q?l13vzZhaK+KgYOGrGmTVCJWGVU1OFvM2Ya6yZZuPlxpsK5pZBZ6zQO2dMU?=
 =?iso-8859-1?Q?9vX7NzrFud1tYlAkmWZgfsrt9oKOMbdQPMrNZ2tRW8XvC8QdvDMlbQOv1q?=
 =?iso-8859-1?Q?GcyItW14mqmBYM8zSVXQf6zp9Ldj16ttC8qI5ItwWG/PmQpiYy137GxETG?=
 =?iso-8859-1?Q?DFzgZfY+T09YHSefkLN02sUhnRbhbgMfCKdvpVZD/TJio6EFMgM+GCxaqP?=
 =?iso-8859-1?Q?G7oPQLW1tbBpvyH4H5GA8ihK626rmvRr0A4kjicg5inVwNPyGPwVy5FUSf?=
 =?iso-8859-1?Q?P1U3OEv7cAIIxZ2waQf707BDvXiYjrON/JT84BMk09tEyA/PM00k6AuFx4?=
 =?iso-8859-1?Q?XT/KDjIMS/3Bu1n2qkCvGS54Li6Pslp/qQ93sPrTY2bWA1RDIfl/pCCA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +vnfkPxkPmUhtZdqC80uWNaVGGFVJ6EOYbCWo8EtYjoHBlle7XnTHmwxukbubNzMEhBt+bRhevCR2xd7xXd0+LrvenHdS/1LyrgS5rQC4C98Kof2lXIdCtA6bOXSFq42Xf0XcbUVmgL0LT2ROz0I3ojdl2e2U7DhXYPzwkO240xKtpwQxJual7cva/w4G9tqA4o88YIN9LleuVx7sAqIVC2aiqbvKs5MjVtoqGfvDV5YaU5ju6WG8lkJQmNjj5yuLZyC99L1VK26Ir2Asb89bE3gswpddRaMgnMiomTT6/mRZsRIiAbUtFIozGbGAlHOz7wc9oL8wA3KyA8EigVvfsumbh91BedIo5egSZ9wG+PDdDoXQsYzCRZ4CzMJ4B47J2khSIX2bfk4JrGJBJFk37MR06xTsUc2fUXxpiS8s5eZjEFOP2qd4OOxEIXOhywNzCLYzhZzxdev2qd+mEG+BKsjljoEqC2cynjxXjRkrCLg903dq5L8miyq29/2gEh9E0MqNVF0nRA3XLw8t1YVwTOMdV86srqfaeq/GXIT7vOef3uWNKkf186rVE4yzfYKKHoTNSOs1YQqGJXBep8oC6ZEmmzn2hvb2B/r6XugjUc8JZw9C6RhjYIoB2MyuQlqIYaFZDN12k5v8DTdNBbnZd4HkRmHe86WXjR8vPVTMzEEbF+CQaTHBdBYjPLB980TqPgxsqO4oObzN03noIlQtP6todUZY/Pe1kUrNIWpSg6nK2S4tHooYo61/0Z0n2qk60SRsLGu1KoPwHqq1lV4pYOHQ3QSPDxCmunhKmLn4ZcpDcuQuiVDCREcSd2W18FbNY3ta6uzxY3KAMFCn0y0joI6nraKXE4NtDkgn7lYMQ/BWXHe/K2cF1EvPDalGSazw765X153yjAw54fuK8cMjA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f769a0be-3679-4a21-d8e8-08dad228f7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:21.6763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ox/3d3yn0B4Ww701y+UceTlOs5LcpcvB25iaF6pkxSEcosoNXdpTq0ECw/8q5inFTYJhHpEJlrnMjbVGNotQXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: o2JD8iLMVvtAMqeXFaX0d501FSwV3e73
X-Proofpoint-GUID: o2JD8iLMVvtAMqeXFaX0d501FSwV3e73
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

Add wrappers for the maple tree to the vma iterator.  This will provide
type safety at compile time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h       | 46 ++++++++++++++++++++++---
 include/linux/mm_types.h |  4 +--
 mm/mmap.c                | 74 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..2d3a49ba2261 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -664,16 +664,16 @@ static inline bool vma_is_accessible(struct vm_area_s=
truct *vma)
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long ma=
x)
 {
-	return mas_find(&vmi->mas, max);
+	return mas_find(&vmi->mas, max - 1);
 }
=20
 static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
 {
 	/*
-	 * Uses vma_find() to get the first VMA when the iterator starts.
+	 * Uses mas_find() to get the first VMA when the iterator starts.
 	 * Calling mas_next() could skip the first entry.
 	 */
-	return vma_find(vmi, ULONG_MAX);
+	return mas_find(&vmi->mas, ULONG_MAX);
 }
=20
 static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
@@ -686,12 +686,50 @@ static inline unsigned long vma_iter_addr(struct vma_=
iterator *vmi)
 	return vmi->mas.index;
 }
=20
+static inline unsigned long vma_iter_end(struct vma_iterator *vmi)
+{
+	return vmi->mas.last + 1;
+}
+static inline int vma_iter_bulk_alloc(struct vma_iterator *vmi,
+				      unsigned long count)
+{
+	return mas_expected_entries(&vmi->mas, count);
+}
+
+/* Free any unused preallocations */
+static inline void vma_iter_free(struct vma_iterator *vmi)
+{
+	mas_destroy(&vmi->mas);
+}
+
+static inline int vma_iter_bulk_store(struct vma_iterator *vmi,
+				      struct vm_area_struct *vma)
+{
+	vmi->mas.index =3D vma->vm_start;
+	vmi->mas.last =3D vma->vm_end - 1;
+	mas_store(&vmi->mas, vma);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void vma_iter_invalidate(struct vma_iterator *vmi)
+{
+	mas_pause(&vmi->mas);
+}
+
+static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long ad=
dr)
+{
+	mas_set(&vmi->mas, addr);
+}
+
 #define for_each_vma(__vmi, __vma)					\
 	while (((__vma) =3D vma_next(&(__vmi))) !=3D NULL)
=20
 /* The MM code likes to work with exclusive end addresses */
 #define for_each_vma_range(__vmi, __vma, __end)				\
-	while (((__vma) =3D vma_find(&(__vmi), (__end) - 1)) !=3D NULL)
+	while (((__vma) =3D vma_find(&(__vmi), (__end))) !=3D NULL)
=20
 #ifdef CONFIG_SHMEM
 /*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..faff2cc005c9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -819,9 +819,7 @@ struct vma_iterator {
 static inline void vma_iter_init(struct vma_iterator *vmi,
 		struct mm_struct *mm, unsigned long addr)
 {
-	vmi->mas.tree =3D &mm->mm_mt;
-	vmi->mas.index =3D addr;
-	vmi->mas.node =3D MAS_START;
+	mas_init(&vmi->mas, &mm->mm_mt, addr);
 }
=20
 struct mmu_gather;
diff --git a/mm/mmap.c b/mm/mmap.c
index c3c5c1d6103d..8f24021ef5b5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -144,6 +144,80 @@ static void remove_vma(struct vm_area_struct *vma)
 	vm_area_free(vma);
 }
=20
+static inline struct vm_area_struct *vma_iter_load(struct vma_iterator *vm=
i)
+{
+	return mas_walk(&vmi->mas);
+}
+
+static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *v=
mi,
+						    unsigned long min)
+{
+	return mas_prev(&vmi->mas, min);
+}
+
+static inline int vma_iter_prealloc(struct vma_iterator *vmi,
+				    struct vm_area_struct *vma)
+{
+	return mas_preallocate(&vmi->mas, vma, GFP_KERNEL);
+}
+
+/* Store a VMA with preallocated memory */
+static inline void vma_iter_store(struct vma_iterator *vmi,
+				  struct vm_area_struct *vma)
+{
+	if (WARN_ON(vmi->mas.node !=3D MAS_START && vmi->mas.index > vma->vm_star=
t)) {
+		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
+		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
+		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
+		mt_dump(vmi->mas.tree);
+	}
+	if (WARN_ON(vmi->mas.node !=3D MAS_START && vmi->mas.last <  vma->vm_star=
t)) {
+		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
+		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
+		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
+		mt_dump(vmi->mas.tree);
+	}
+
+	if (vmi->mas.node !=3D MAS_START &&
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start))=
)
+		vma_iter_invalidate(vmi);
+
+	vmi->mas.index =3D vma->vm_start;
+	vmi->mas.last =3D vma->vm_end - 1;
+	mas_store_prealloc(&vmi->mas, vma);
+}
+
+static inline void vma_iter_clear(struct vma_iterator *vmi,
+				  unsigned long start, unsigned long end)
+{
+	mas_set_range(&vmi->mas, start, end - 1);
+	mas_store_prealloc(&vmi->mas, NULL);
+}
+
+static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
+			struct vm_area_struct *vma, gfp_t gfp)
+{
+	vmi->mas.index =3D vma->vm_start;
+	vmi->mas.last =3D vma->vm_end - 1;
+	mas_store_gfp(&vmi->mas, vma, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
+			unsigned long start, unsigned long end, gfp_t gfp)
+{
+	vmi->mas.index =3D start;
+	vmi->mas.last =3D end - 1;
+	mas_store_gfp(&vmi->mas, NULL, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
 /*
  * check_brk_limits() - Use platform specific check of range & verify mloc=
k
  * limits.
--=20
2.35.1
