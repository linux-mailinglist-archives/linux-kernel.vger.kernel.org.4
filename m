Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA65D65F44B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjAETU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbjAETTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:19:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C931DF1F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:14 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUHKS030049;
        Thu, 5 Jan 2023 19:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9wrLMq2gptGF3Uu0h1TPr93fT4zhbM9qkTOW0TghwWA=;
 b=qJ01Aj81zYTyI7q+RXKrSWGKdFpAlwM8PEg6HjcTKTDSX6hrxCCJtZ5N9mqU70UZHRhm
 F3mqc9Hi58xhzw5xqH/UFWuaU+I5/mBTnbqriQuCPLc29YGGR77jhMUY3ZxmUYzqE33b
 W9VE+TUaq49BjlZ+MZ1KNuOnLEQ+cX3drXrjULR/yrJnxd6xBvPHwvzzR095POCfQN4t
 kY7+qoSlftJQwQf9FyIwSI9FmcijEiPqBjG10cx2iraoU0bdqzyj1B5xCA3uBUrLGRfS
 2VkJ+IbpCvCcWLuGp2yKyAvwim2ES8yZQl07+/1fqbXvnwa9B7LO/4H5w9K49rGtvA15 pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya9kbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I1EPm033688;
        Thu, 5 Jan 2023 19:16:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf7u5p-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpKxV7byYKwjjylnf8i5f4e6YvjUiDtsjky3ssdOtvCzep2P7CYK2q5XG6MI3xdFLQ40XnnN9mjderumCuxdlZlS6bAOO+y6oM6QbfuIbp9GXNqRVLQtTMXg8S9JwgW/j89fhHghPnokApKdHNN/+BuOfYOETu1+AlV1FspQCbB7hQAVJi/ZdPviCMJnwTvUXQEC2oE/fX3Z3iSfTTVMerDY+e0CqNVG6mq50eFdvhUjmfNkroW06X+J4dMbPv8lYTCzEp0scB+AH7nDxKA1W8oWPz6alqriaBBjduHfeR3XFSqT7W+ozVc9UA1az282AKkkNm5DW3AQQSgi3+Pdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wrLMq2gptGF3Uu0h1TPr93fT4zhbM9qkTOW0TghwWA=;
 b=d9pi6XqQb7UhCVBhwO+rA0j5WF0/i5H65jQWP9extm7A5clq/hDvpMGjKma783i3zdieGAVg0COzYYLg1JMMyt/3lDORhG7mCWfwizH2t0GOLEa8MxCkZw0bvig3v61ro/9THBgAkx4sXwPpKEywSdMLSIYMoEI/7ESRzv8SZuT+nPQmOmGn3vvLtJSW7WHT24mF1kYJtx/FniecTDVzlj3mhjEbAiNNI1Zf1wUE7nr491dSbUDfbIpc4kSArvg/mTDQVp661Iwfa+I7MlwHDwFt9vMmj5TPCKEwIR3XyrMoi8QvV0CuMRgD1wVAk6vgndTsUDF7Moa+f7uuNib4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wrLMq2gptGF3Uu0h1TPr93fT4zhbM9qkTOW0TghwWA=;
 b=dbGCYIU9mx03IbIOTgm712aCpaHp/UyHTJkM5qBwiiyAhAng+PDa/mG77XO4N3+0TlrFQJxq9I/eV02mtPUJTUFMsvHzFDjnOrnpP0pBRPfNx+PgMiHUEHTolTNuw6QfhurXh9tkOpDmGDgowBAp4tyJ4kmK6WmbnsAoKDh1+vk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 36/44] mm/mmap: Refactor locking out of __vma_adjust()
Thread-Topic: [PATCH v2 36/44] mm/mmap: Refactor locking out of __vma_adjust()
Thread-Index: AQHZITonCFPQfkbt+E2tBznCmY6rRw==
Date:   Thu, 5 Jan 2023 19:16:03 +0000
Message-ID: <20230105191517.3099082-37-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: bb78fc06-f311-4a3a-e4d7-08daef515f5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HLEpPFFAKaPP7VLGUU0LLWdWBZ34X6ayTJf77EIDK77rjkj87ad5GH0aBMTujfeQEcHXPS1fhvQZ+zCq4ZVN5KTKSBQ6TGiyzGAjC9kCY++y+6OdqEDc8ExlopbKMBPzhKw+BsRqgsvk3poudXKSuo8/+cawVC9LWmgwJHtGx70jqwOqS60IeSGqpy79BIzpxVIQHSbNNUDxIW+dwPb9Oas7JH4PcZiUHCCCUOrnbzH3IUsYnaZkgQ7r7F/0t8WB7ag5ZR7/nibr4ZxoCMeTyAEeo/MNBdf03HBQhVi1g/frjDAVZ8qwaPyrTYL4QFVZE0TYczDgsg+QH2LE6iDrc5TivstbGwvtY7zM+WynX5ANANeoi9yDE4QpZ+8kUesIvzlDdlSWnLF3+T5oHukSEA4uwwJu6TP02+0WAgBDv+t+Ix+N3VYDPxi6br++/K8nE+xNtHn5+TxGeHGYRokjHxhOu7Mvk7472dNx4Wy3u0SGPu0PTnAmPJGExJr6oQxe2LvFAW3DMHH69jG4YaTxT0qaLbXeg4N3Urd7vlU86dr76+YiWGndUSm4Pq0FgTDh0Ge389UzCItu6bCg4aFMf0hv707S+NDi/KWV3g5jkiMIYGZT8kpewlu1YtYvSdAXnlfs4hlJ4x+FgBBXxus61k7SbON1fJY+gmevp5FFlrP4sxWAU3/OnavmoC4uWaGYgJrEB64ZcyGoExC3gfzM9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0pYDpjZozaYk1oo6cAhZj90/pzgeq8lOugIzGxzbBTWI7TpCL+A5lFs4yw?=
 =?iso-8859-1?Q?sT63bOgMPSjVPUfhSKM3z8Eu5CY1NqzHdW1eDff5arKLmSBvUJrKrWggkZ?=
 =?iso-8859-1?Q?VPhjFg0xjHKA+8XM4lIacCGAHrRhbPZlb2aLnzgFcg7h5Z4gDgEybSExNu?=
 =?iso-8859-1?Q?OZ/E5H++AXeRCmJjXGPtbV7EA99TJOIMbTNJ+Ud/MTTTi8aECXsrIkLGNR?=
 =?iso-8859-1?Q?8QV2+MeRSwHlC/np8k/fRKR4W6FtjSevzIs982iXjTqqGjkxy+KXGt7l0G?=
 =?iso-8859-1?Q?pIyh9mtZptVniThCdtDcKWLf10ByV49On6d+8YmqRaD+5GuTp8It2TAdKW?=
 =?iso-8859-1?Q?+8hD4JC0BkUZ5CdNNH0VReTmcKpOeeDi502RCZtmPXMRJtZ2NDlaZPeyXY?=
 =?iso-8859-1?Q?jGdUTDUrd/5amfOf2jzi4pf4SNijxpJXnMAqev5uKhn2s0frRuxTolgs6L?=
 =?iso-8859-1?Q?QDYTetcAg6oP5AhNA/UOeYB6QA/GT4ywDWUwyJeMpI/J29HqxbuwblzRIL?=
 =?iso-8859-1?Q?LyVd0Cq7N2b+s3TsMxDHEVoMNm/KRQmZiCf24km4lqSrJVUxexnRXJcsx8?=
 =?iso-8859-1?Q?DWXBALDaj9lImQ7TUqJGzAtkmpNOCJ3yFmrPftQ+UfgLd3ld9znHiWIMhv?=
 =?iso-8859-1?Q?Blo5nSEa5wYVXWktEg08Fl/RgQGmx+b8DeGyVMObRp7zQxJ+ylh/x69eqV?=
 =?iso-8859-1?Q?U0gSIoQOKIjFttU8cQDfxrHIaAgAp+7aLrLgSUR7Fw1A8Q/ef025Bv2S+o?=
 =?iso-8859-1?Q?aXVB2iVWyNPrPRfV/I8HbYjWWYoQISi2m3oftkCiuRk2KIOYZgMznZNp5g?=
 =?iso-8859-1?Q?sw209SvLTHCLpySneUilQn0UgdztX5M0/RSt0QLfYA8EG5Cxw5FKkZha65?=
 =?iso-8859-1?Q?0kHOj0qf34prFO5Kf62h7DwcX5qVpJRJVWzYjrjpehkRoGohBAnOu53pB/?=
 =?iso-8859-1?Q?Xbf7Ws2WSkNnnQWE5caaWjNkTM93g6TblG+szSavb4TqbaRL8GMGkMm/6A?=
 =?iso-8859-1?Q?xwXtShXcL2l45C/MJrKczGmL3sKH0klf8qUUx9xs7JRyADQnEMcJz5yunL?=
 =?iso-8859-1?Q?QzaV6Ntz0okBclPD0jUgJQ+NAS8Kxk7YMT/+kO3hFKvXzO/NosTTQoq1ow?=
 =?iso-8859-1?Q?2bGHL3liEbohvhrvu8gd5sG4Rbkl+DI0QDHdSopGrC0Ns6osu6Vi3FIuKS?=
 =?iso-8859-1?Q?wrPBuFPXguG/k7QomSoXzANA/j2mtaKOhviqyd7E3jn3fpcqv+rh6wQlz4?=
 =?iso-8859-1?Q?KRivEHYz4SIB7wH7aEYPLSCN9aQ8a/vjtKkyrVC5TztDJMkYP08uGK13YB?=
 =?iso-8859-1?Q?vNK3l0BG5Rm715WMVS8+ofmCbDl09cUFM+dPdZq92QLoS3uo6tVm/4eMR/?=
 =?iso-8859-1?Q?5L6aLkHxDIueHEiHVbXu36ZxZBMyU5SZc/4UpeQlipste95aXRTESMZJ1K?=
 =?iso-8859-1?Q?is0KlrR4UIhHEUq7VUe19aYLk9nnyt7fdx6HUlDR/q+Fp9YaylzcYwBtyE?=
 =?iso-8859-1?Q?NsHqEYGRXoI7AgfbN9UEttlxiPlpU5PxJQsU6AFZQogexl8KB376Ye8HNc?=
 =?iso-8859-1?Q?f6/YEGn+gYrLG/6W3D80GlN+xJzQw32wQ/sagEeYF4JdWDYva350j30xOy?=
 =?iso-8859-1?Q?st0DsLq+nLYz72Xmf5dKCSD/qxKkFJwlC0j270Vy+z6a3d6DI2k02kaQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5C12oW4giruVFNUBuPQsugdX9HYPRFSOxWkQ9GwLAO/Vn9HInWlK+gIOmn9Rbl2r7W0sXsKKgFBtMUDlvA1vlGjjFmOrjmsGCqmVTWJstgk7T2SFXREim+RnP2QaiKjdqro6ahveyMMm8hLRDsQMrsbejqCTfaCBQVHcHv1USpCPCcC68rOHnTj2mqKBvNNYSL9mcxbNbhMpfeO5eqcBFoT107+vXTVb9CRIYnwrkNz+JqTe5pcD4bhiAdDdeVgPZtSap/Rxp6PBp7pOwAdPueyhvaALuPX2ApJDyySsy0+uwLX/C2vgB2pbB6jUxalPJUvyhE0225IbJxNx0rF88ll2oRwThde2ZdIZs5pcRMlvhwVolchKrLPzlz/da78Hkez1ZaXT2bLUf2GZ50MY/PdBBh8Ps8p8tKGRuZfjoZUbeTMBvo1dzaCKJi2dMWBeYabSHz6aFGW5IhWVmpNnxsTehQf871Ml1aPnoN6LLsEK9Iw4unmaL3z7z0/p8U41w/M0nzTUq79xeJ6ZZ/0C7P+7HZqHSb/i/eRrMb0ttayV25ouGxYmFl6QoUm+0TUDt+MRAxkZvJyglrluI8VkX+/FWhmRBdDlyEqSAW0JeESnQu5wlevwPY8CjjsCrOVsbTKXhPpxL2PLm+BKi/EidEC44NTEfgC3pM9YGf1RBwrM6Pliz98AYYvoumW+knclAiRpTpSHFxTavMPiyjuYFLm1xHBfBau1sHrxWUu3mizcejEYkX6Wppul4tuSLrwZOusipd71BC+z9FAqFGAjyMT2vpajlu345CJ3GjsKphqozU1C2IWI0LFA+MgavGBqtjgdmPScYo9biyTkGGhH2sqhwgFyWOlhmnGJ2MXPxQFcBUUInD6r/l/2LYsWEpYcMuRl9STooZUi7MrLIXM12w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb78fc06-f311-4a3a-e4d7-08daef515f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:03.5783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RBgABYAh4jh6CJL3HDVYbtfHHGmvDSZn4aHebZ8bWmEyJ3O3dSOfmR/CGE3o4OjLyaVdX9790XmM2Xb2jrx0Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=771 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-ORIG-GUID: tJesb_9O7EsbWqyu0HTUM3sZlI7IatWe
X-Proofpoint-GUID: tJesb_9O7EsbWqyu0HTUM3sZlI7IatWe
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

Move the locking into vma_prepare() and vma_complete() for use elsewhere

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h |  13 +++
 mm/mmap.c     | 231 +++++++++++++++++++++++++++++---------------------
 2 files changed, 149 insertions(+), 95 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index bcf75a8b032d..0951e6181284 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -848,4 +848,17 @@ static inline bool vma_soft_dirty_enabled(struct vm_ar=
ea_struct *vma)
 	return !(vma->vm_flags & VM_SOFTDIRTY);
 }
=20
+/*
+ * VMA lock generalization
+ */
+struct vma_prepare {
+	struct vm_area_struct *vma;
+	struct vm_area_struct *adj_next;
+	struct file *file;
+	struct address_space *mapping;
+	struct anon_vma *anon_vma;
+	struct vm_area_struct *insert;
+	struct vm_area_struct *remove;
+	struct vm_area_struct *remove2;
+};
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index c15a04bf3518..3cf08aaee17d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -635,6 +635,127 @@ inline int vma_expand(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
 	return -ENOMEM;
 }
=20
+/*
+ * vma_prepare() - Helper function for handling locking VMAs prior to alte=
ring
+ * @vp: The initialized vma_prepare struct
+ */
+static inline void vma_prepare(struct vma_prepare *vp)
+{
+	if (vp->file) {
+		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
+
+		if (vp->adj_next)
+			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
+				      vp->adj_next->vm_end);
+
+		i_mmap_lock_write(vp->mapping);
+		if (vp->insert && vp->insert->vm_file) {
+			/*
+			 * Put into interval tree now, so instantiated pages
+			 * are visible to arm/parisc __flush_dcache_page
+			 * throughout; but we cannot insert into address
+			 * space until vma start or end is updated.
+			 */
+			__vma_link_file(vp->insert,
+					vp->insert->vm_file->f_mapping);
+		}
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_lock_write(vp->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
+	}
+
+	if (vp->file) {
+		flush_dcache_mmap_lock(vp->mapping);
+		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
+		if (vp->adj_next)
+			vma_interval_tree_remove(vp->adj_next,
+						 &vp->mapping->i_mmap);
+	}
+
+}
+
+/*
+ * vma_complete- Helper function for handling the unlocking after altering=
 VMAs,
+ * or for inserting a VMA.
+ *
+ * @vp: The vma_prepare struct
+ * @vmi: The vma iterator
+ * @mm: The mm_struct
+ */
+static inline void vma_complete(struct vma_prepare *vp,
+				struct vma_iterator *vmi, struct mm_struct *mm)
+{
+	if (vp->file) {
+		if (vp->adj_next)
+			vma_interval_tree_insert(vp->adj_next,
+						 &vp->mapping->i_mmap);
+		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
+		flush_dcache_mmap_unlock(vp->mapping);
+	}
+
+	if (vp->remove && vp->file) {
+		__remove_shared_vm_struct(vp->remove, vp->file, vp->mapping);
+		if (vp->remove2)
+			__remove_shared_vm_struct(vp->remove2, vp->file,
+						  vp->mapping);
+	} else if (vp->insert) {
+		/*
+		 * split_vma has split insert from vma, and needs
+		 * us to insert it before dropping the locks
+		 * (it may either follow vma or precede it).
+		 */
+		vma_iter_store(vmi, vp->insert);
+		mm->map_count++;
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_post_update_vma(vp->adj_next);
+		anon_vma_unlock_write(vp->anon_vma);
+	}
+
+	if (vp->file) {
+		i_mmap_unlock_write(vp->mapping);
+		uprobe_mmap(vp->vma);
+
+		if (vp->adj_next)
+			uprobe_mmap(vp->adj_next);
+	}
+
+	if (vp->remove) {
+again:
+		if (vp->file) {
+			uprobe_munmap(vp->remove, vp->remove->vm_start,
+				      vp->remove->vm_end);
+			fput(vp->file);
+		}
+		if (vp->remove->anon_vma)
+			anon_vma_merge(vp->vma, vp->remove);
+		mm->map_count--;
+		mpol_put(vma_policy(vp->remove));
+		if (!vp->remove2)
+			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
+		vm_area_free(vp->remove);
+
+		/*
+		 * In mprotect's case 6 (see comments on vma_merge),
+		 * we must remove next_next too.
+		 */
+		if (vp->remove2) {
+			vp->remove =3D vp->remove2;
+			vp->remove2 =3D NULL;
+			goto again;
+		}
+	}
+	if (vp->insert && vp->file)
+		uprobe_mmap(vp->insert);
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -650,14 +771,13 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	struct vm_area_struct *next_next =3D NULL;	/* uninit var warning */
 	struct vm_area_struct *next =3D find_vma(mm, vma->vm_end);
 	struct vm_area_struct *orig_vma =3D vma;
-	struct address_space *mapping =3D NULL;
-	struct rb_root_cached *root =3D NULL;
 	struct anon_vma *anon_vma =3D NULL;
 	struct file *file =3D vma->vm_file;
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	struct vma_prepare vma_prep;
=20
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
@@ -753,39 +873,22 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 			   anon_vma !=3D next->anon_vma);
=20
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
-	if (file) {
-		mapping =3D file->f_mapping;
-		root =3D &mapping->i_mmap;
-		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
-
-		if (adjust_next)
-			uprobe_munmap(next, next->vm_start, next->vm_end);
-
-		i_mmap_lock_write(mapping);
-		if (insert && insert->vm_file) {
-			/*
-			 * Put into interval tree now, so instantiated pages
-			 * are visible to arm/parisc __flush_dcache_page
-			 * throughout; but we cannot insert into address
-			 * space until vma start or end is updated.
-			 */
-			__vma_link_file(insert, insert->vm_file->f_mapping);
-		}
-	}
=20
-	if (anon_vma) {
-		anon_vma_lock_write(anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vma);
-		if (adjust_next)
-			anon_vma_interval_tree_pre_update_vma(next);
+	memset(&vma_prep, 0, sizeof(vma_prep));
+	vma_prep.vma =3D vma;
+	vma_prep.anon_vma =3D anon_vma;
+	vma_prep.file =3D file;
+	if (adjust_next)
+		vma_prep.adj_next =3D next;
+	if (file)
+		vma_prep.mapping =3D file->f_mapping;
+	vma_prep.insert =3D insert;
+	if (remove_next) {
+		vma_prep.remove =3D next;
+		vma_prep.remove2 =3D next_next;
 	}
=20
-	if (file) {
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_remove(vma, root);
-		if (adjust_next)
-			vma_interval_tree_remove(next, root);
-	}
+	vma_prepare(&vma_prep);
=20
 	if (start !=3D vma->vm_start) {
 		if (vma->vm_start < start) {
@@ -823,69 +926,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
 		vma_iter_store(vmi, next);
 	}
=20
-	if (file) {
-		if (adjust_next)
-			vma_interval_tree_insert(next, root);
-		vma_interval_tree_insert(vma, root);
-		flush_dcache_mmap_unlock(mapping);
-	}
-
-	if (remove_next && file) {
-		__remove_shared_vm_struct(next, file, mapping);
-		if (remove_next =3D=3D 2)
-			__remove_shared_vm_struct(next_next, file, mapping);
-	} else if (insert) {
-		/*
-		 * split_vma has split insert from vma, and needs
-		 * us to insert it before dropping the locks
-		 * (it may either follow vma or precede it).
-		 */
-		vma_iter_store(vmi, insert);
-		mm->map_count++;
-	}
-
-	if (anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vma);
-		if (adjust_next)
-			anon_vma_interval_tree_post_update_vma(next);
-		anon_vma_unlock_write(anon_vma);
-	}
-
-	if (file) {
-		i_mmap_unlock_write(mapping);
-		uprobe_mmap(vma);
-
-		if (adjust_next)
-			uprobe_mmap(next);
-	}
-
-	if (remove_next) {
-again:
-		if (file) {
-			uprobe_munmap(next, next->vm_start, next->vm_end);
-			fput(file);
-		}
-		if (next->anon_vma)
-			anon_vma_merge(vma, next);
-		mm->map_count--;
-		mpol_put(vma_policy(next));
-		if (remove_next !=3D 2)
-			BUG_ON(vma->vm_end < next->vm_end);
-		vm_area_free(next);
-
-		/*
-		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we must remove next_next too.
-		 */
-		if (remove_next =3D=3D 2) {
-			remove_next =3D 1;
-			next =3D next_next;
-			goto again;
-		}
-	}
-	if (insert && file)
-		uprobe_mmap(insert);
-
+	vma_complete(&vma_prep, vmi, mm);
 	vma_iter_free(vmi);
 	validate_mm(mm);
=20
--=20
2.35.1
