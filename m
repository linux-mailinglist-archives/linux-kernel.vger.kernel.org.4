Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3968C65F44C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjAETUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjAETUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4836B1BE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:34 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUIWp030139;
        Thu, 5 Jan 2023 19:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fOI0ThBpRiVc0Uet2n6YUDaHqGgBSIkgC44zMu8JC0I=;
 b=0Ix8+iJA13ZPHvpn2G9kDhF5zZrd4bWsrYa23K7qZ9ipzgKOhUThZPhD6pM7XKWYCMp6
 zHBv9M9kPjFBrIomGbClu/oyau1Vj2FU5QtfshcxXpcqTJUJH0BdIG1ISFPHPwbpjtfk
 75Ioep9yRqgBMIHjeHUkUfM6fX2py1zQ/3JsMdsx29a5F6EEPsuBBG9iUdDEUT805IC2
 LrrCQNiIkLaQjIXN1105W09c/RPW1nxBWAHsMCH1M+5MiKwGeLfaMCk9iAcYl2xok2KH
 cBixyGLY4WXlChmVo1XQmBmSnAbGvTrzf6r58kEhN0CdapDawBA0pp6mVebaKTXB2qCJ Tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya9kbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I1EPp033688;
        Thu, 5 Jan 2023 19:16:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf7u5p-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBwUtPPPO93Ghg2TZ7kA9XeI5ADNg0sQMgSVJ6JUGEAM1tpNSuwpJeqGOPg1nrn524thfdrvMxrXCgBR3cOmrZboaLtiHgjpzloOwwE07WFmpQYjkVK+be906cfyKjbHqwcb/536Po7ylwtsulwA/xCJUxWf2XRheJFC+7K2sWsB0zBZ0H1hlImiRIRBn5U9EmRE2giXy3RGWlc4G81knezijUArY0MLN1l1tJSOQu7q9CVANjYvUk4MDUiTLXJkN9/korR2JYbohLvt/8y8SCNV4voZhb/E00RC9A/tbzNBiAZfEY9vpl20UlvNYj3PYc/FwFp+Bv97XSvvRjy1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOI0ThBpRiVc0Uet2n6YUDaHqGgBSIkgC44zMu8JC0I=;
 b=mnwLyfCtFyawPQZVSb8K6xIo12AxoRJUjnFMimP9BXiC/jGN1Yn9b8a0HuWpV3qFcenkvjTaIK+Fzv66gCRMxAn/C31qJLVEMzxBTRjeuziDkq2GRwFdRfxwVJe+rMInRvCwWhHtLb57twNv9fvWfoEduJ9N0n9rTCZP5lh0cMrEBmz2QSym8oRS9bMDu/PFwJZ+6ueFCXgdg9NSRmSZt4lfgxrdc71hdzur9krkU/NLUYO388ah5uIZt4hL/tlTHD9G3aPB8lIUSInCp3wMgQ//S5otsg1SAnrBSOUkM7AivAbSIR8ThsHXceVwFJVhOyXucdWXUPiePmTHbmUJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOI0ThBpRiVc0Uet2n6YUDaHqGgBSIkgC44zMu8JC0I=;
 b=h0LNgUGC8wLXyXHDuJVsm3DQoD+P0vIkDQO/ymw2+IsI2sxzTqcy76/Ff6dZSrde3Ta19ipfhzphGjPzrI4y3FApG2WohcMJ5Sv1nYePq6xIOCUvMo2gFeaHvSveP5ewLtfOSyImAFLfMfw5g0QzLAsasymk1r+5hdKtO7Jg1eQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 39/44] mm: Don't use __vma_adjust() in __split_vma()
Thread-Topic: [PATCH v2 39/44] mm: Don't use __vma_adjust() in __split_vma()
Thread-Index: AQHZITonjB4NzQAbgkqpv5IwNTKaDw==
Date:   Thu, 5 Jan 2023 19:16:04 +0000
Message-ID: <20230105191517.3099082-40-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: a0c91420-d413-4827-c694-08daef516005
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8acoK+9lXw//L6eGR2zQWp8vfgmyuIJZqJUeEOwVMKQuP/ByR9I6B0S1eDPRV2E1hZrpfbD5akeujOeIkVtPygvBcFSY7Z36DRfiMqY9TXtJbsAeuhDx9MqJZHDzc96TF94XzwfNXxHIMg0oaCH9geBeMsumeE/l+o2GR2IvZtka1IePjQLc9CUe7TLOxVZ2t9kfAAY10W/aENnPkeKH55/tXNFa2Ixw9ExcNjlXiTSXY6thBuM7uRFN2cY/QyLvGU7GLXzp70Ipp2g0zQAn+Q4cqMJHH2l/+F1j4bnnSG3fH4VWlao2jA80AqgKE0xAYG0ZlLbYkMreHYo/yWBNPXoUGRn5HexjWW8kzgz0CjYrxg7IIs85sVh8b17T8gCE/28OpdNm19aM7Bvpo7zQvKZGIXFurQ3vUC38++8VvMRdRmAaALzWY1ynWMEtnxADlg2EsdD/bo+o5o0laP9DeF+ZeHTWnxYC5o3pSCTF+cgmM57HVO55lEOfWBArLV1LXj+kZvhIjuR5hpVcx8nnD2RCXMxemYCKpCnfwhWmfW2FIrdy7r/Oaw3JHdbbz7hT/HYctiHHQj55NbEMG6b0KOMLnGuhgU+6wwxqjrwhggGTDb/I9xLiglJLFyWiXMsEYjqhSFaG659Va5pK7qrND5GESjij+QYd04+ZSQWmMzosGQ6Qmvp+ktdsrFiLXo/gJ9PwW+84qgohYFWLEZpIxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rEbNZj2lDdOTQ9OdzqyJYfEcHzX0SM8S4ubrIumjXsdCEpDwyxzsLTS0ei?=
 =?iso-8859-1?Q?IY6WhyuYyxopJAknJ7MYZZHdZ7F/Q9C+77URfPIeilOBb6RynUHjYCnnPi?=
 =?iso-8859-1?Q?aDy/Frnm46qjgbngz/FHY++3An4IlCsq7TCyNRkXcBanXVKK0CsDHQtfso?=
 =?iso-8859-1?Q?lH+7m8EoaRD6bushHHQtD5TWhEEHH/p/EA8Zu7qDLuINzxnewVfrlcLqwa?=
 =?iso-8859-1?Q?CLX4Ky+iyC0q4VOEHK1o5Hl79PwAdFnLkCB16aYuJffdJdkx/oemPYSrwA?=
 =?iso-8859-1?Q?ypf4VkInZKYO5GTXJThdFZ7adj9VEQJACP8YqaiRMTUWLRWkBSOZAmvEsA?=
 =?iso-8859-1?Q?rMmz0yLc46u7jn8PcjP8Q2gv5nb0H0lwT145Cg8QgUfEiJCxJLvlm5cxfc?=
 =?iso-8859-1?Q?Cx1BsZkDLiTefl4Evg7QedllmMcs7PRjRoSczEmRoV1/hLxDbK0gt7NsAx?=
 =?iso-8859-1?Q?MQMT2Ysx8LDNLUHTXCJYe/rvNWvcBItz03wa6jkZ2CEq8usLg++hf0hEuY?=
 =?iso-8859-1?Q?l1DtiMItEnsjqAzZHK9sDgbGuMI7k/pIfCfHSEL0orpgfK6BZiKOghYKHZ?=
 =?iso-8859-1?Q?lx1sXu8Qkn5urnbw7TOLJfXn+QP6UQUADNZqj9V//6MLy5EnKuCHwZTrvG?=
 =?iso-8859-1?Q?UWIdwuGZotra2vXSpUt9LKS+CtOLFg11mwJZyMRkGzMUJwcktf0+2bh8Nr?=
 =?iso-8859-1?Q?RQxDYtYgIrT+hO8TYP47/19rtkPRe+zV9xi/feKBRRGEQwDP4n/kbVrNJr?=
 =?iso-8859-1?Q?gk1/gv7e0of61DzvFrnbkJnwCB/kUk/CTjt4f6Hcwy4sar302MxcxSm2n+?=
 =?iso-8859-1?Q?vcgI+kiKdGJZPs54KYxC0kJ1mR9ASqL7szyOYm6K9G5tEk9hs7bcXy15y+?=
 =?iso-8859-1?Q?3aS9wQwaAsRbMJVx9nFN9L1GZBqSYS8+HQMozqfXKe8e3RusR2ZmmuZy8d?=
 =?iso-8859-1?Q?y0sGQrwiN5iHtWry+b2IB4BbMgnIvJV0Yl1YVkUFUrbHbNkqWdI8H4F35a?=
 =?iso-8859-1?Q?rLvYMPOzDTT+BBIo7srr7iGfwZG2U90FujBFMdrhqEPOZ6Np/JfXZDDBFr?=
 =?iso-8859-1?Q?jjYlvSF9LWj22feFbVxvPCkYpqV0tZHDd6TuISVY2Uq7k+oQEO2jiKtbV0?=
 =?iso-8859-1?Q?5UAg26eBl3yrOgpnnI/TKydRXCvviKdzOHM4oraZS+Y5gsBVO6a1nL8s5s?=
 =?iso-8859-1?Q?NCNBUHG47rPRrQeEnfUap9NVkiG09df493krHKV0szKBfA00mD8KHJLPII?=
 =?iso-8859-1?Q?45n3ntdLfdkNqfBm6K0TQ4SsYzk+w9BHTgiIbvzF4F7kbGjP5ZGXLJj8Pn?=
 =?iso-8859-1?Q?h2wAjbCgWyKr0Rt2/yBa40lEAAcKvQglpZ93XTJP+lSF4b3PDR5uYrc3hc?=
 =?iso-8859-1?Q?hI1JWVx3qGWGewogAmeQnspyheJaz4eAwKPK5Mv6/dyKv7Q1SzQKsonxJ9?=
 =?iso-8859-1?Q?mAYX7uNYiGDXANu0r+uhZfIg2XUvNMSHaltK5cP0KaAVUbj7eKoejZGHgj?=
 =?iso-8859-1?Q?r5hR96OORuVf+E3COPQFBWUh0H38vBcwyH1M8DDAVzrKEkw/4ZZLFIaqnX?=
 =?iso-8859-1?Q?fYbLn6d8jrt4pVr95R4o6AyPlehguElFLPd+WKBPqWBbCQxljzzc6ZTiH7?=
 =?iso-8859-1?Q?zKosuuuP/i3dV9/KcK+RXg63Fz3b/5yRWPp/+fO5DqXvKli6ESLvDr9A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GjiF6BdoOuxHkPgADDJFNAtoqo4nVILkr//SsihVp0pSTUc0aZcMdsiBzh5TsEb3uremjaIvBXALg2DddyZ+WqQc3AyzjoChpKTZn8Ke6zoC2vFzDFtxJVfhnXfaGuGCsTiUYPJtKbi1EMH5rS9KMORlC8ZPxAdhqYF6WkCFgtJL1xdjjLhNGq8oNs16RLvrxyvqzJj3Ii/aA8CpghgEdT40PZIh8e10rJcs7IUpHfU7sRvHugLQ2jW6Z3Srtqs1cuwR9fLhVgXwHRYrzd67GhLIMAn3ak1RffRYVZabBrok60ZDfNEun8KA2WQyGh0ACqJvjWiqnnnxktOdBC8W6skGgqF3RYhCYZbFHMXuSChyJ4HD472hnsRzL7sDwHKmzsVu0kGlOkFZBFXRdfqh34MaIuQx7G74vyVUqc64Z2H77iv/CwhdlubPkxWzfPSAk1RZhZMjHuUUX4/0MPDusI2XHf6hHI0Z8teMjaSOA8DcPLFobfOVmpL2PpkR42FVCI3inmZzHMncwWpeqEUp5iGbhIp+ws1CEZtNUP+QGPIUYWKHVX86BsxNAkKyPSTRPo9ZoBw+t5mw32ewvq9xl9xjUNg35YbBufuWuZOdqMYAitK0QLL3wsHXq7rjdxtlbZ+gitMdDPEj5obBPzTl7/gwiDRwyYbLmliWx0E0N5q37HfC+4vHaXO5Sg3Fet61E6WCe+vUZfIjIyhFIBdmclpxrZ0IBfQEfzpgf702zduauzuTyGDIX8E4BZ7PPCf3WZ0oVhPIpLCs+SZVnNJ4SGe5ekBE19bENy80hhNqOe9zjdMeNiIJnMEuEx7Lul7MXd32dVlWB5WzSM/+ltUB4MD5TAIGUGAI5V0VrPjIXc9grC9lGsnQIj27Dd6vACE2E0OPUP8JuEecCW9diaQVZw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c91420-d413-4827-c694-08daef516005
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:04.6095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dCkzWeXZOWeCZGxaMM+o05hr9p5Yjp5OJoVTVJrqmyKYBu5nf5WEd1eErkDT9b5ksaHFkDpnVYO4OxPRnTcjPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-ORIG-GUID: ETck5X-j_ecBVIvQ0g416VGeNQHeDZ0J
X-Proofpoint-GUID: ETck5X-j_ecBVIvQ0g416VGeNQHeDZ0J
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

Use the abstracted locking and maple tree operations.  Since
__split_vma() is the only user of the __vma_adjust() function to use the
insert argument, drop that argument.  Remove the NULL passed through
from fs/exec's shift_arg_pages() at the same time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c          |   4 +-
 include/linux/mm.h |   7 ++-
 mm/mmap.c          | 114 ++++++++++++++++++++-------------------------
 3 files changed, 56 insertions(+), 69 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 76ee62e1d3f1..d52fca2dd30b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -699,7 +699,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
+	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff))
 		return -ENOMEM;
=20
 	/*
@@ -733,7 +733,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
=20
 	vma_prev(&vmi);
 	/* Shrink the vma to just the new range */
-	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff, NULL);
+	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff);
 }
=20
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index aabfd4183091..a00871cc63cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2823,13 +2823,12 @@ void anon_vma_interval_tree_verify(struct anon_vma_=
chain *node);
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sy=
s_admin);
 extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *v=
ma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
-	struct vm_area_struct *expand);
+	unsigned long end, pgoff_t pgoff, struct vm_area_struct *expand);
 static inline int vma_adjust(struct vma_iterator *vmi,
 	struct vm_area_struct *vma, unsigned long start, unsigned long end,
-	pgoff_t pgoff, struct vm_area_struct *insert)
+	pgoff_t pgoff)
 {
-	return __vma_adjust(vmi, vma, start, end, pgoff, insert, NULL);
+	return __vma_adjust(vmi, vma, start, end, pgoff, NULL);
 }
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index 431c5ee9ce00..3bca62c11686 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -754,7 +754,7 @@ inline int vma_expand(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
  */
 int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	unsigned long start, unsigned long end, pgoff_t pgoff,
-	struct vm_area_struct *insert, struct vm_area_struct *expand)
+	struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *remove2 =3D NULL;
@@ -767,7 +767,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
 	struct vma_prepare vma_prep;
=20
-	if (next && !insert) {
+	if (next) {
 		if (end >=3D next->vm_end) {
 			/*
 			 * vma expands, overlapping all the next, and
@@ -858,39 +858,25 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	VM_WARN_ON(vma_prep.anon_vma && adjust_next && next->anon_vma &&
 		   vma_prep.anon_vma !=3D next->anon_vma);
=20
-	vma_prep.insert =3D insert;
 	vma_prepare(&vma_prep);
=20
-	if (start !=3D vma->vm_start) {
-		if (vma->vm_start < start) {
-			if (!insert || (insert->vm_end !=3D start)) {
-				vma_iter_clear(vmi, vma->vm_start, start);
-				vma_iter_set(vmi, start);
-				VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
-			}
-		} else {
-			vma_changed =3D true;
-		}
-		vma->vm_start =3D start;
-	}
-	if (end !=3D vma->vm_end) {
-		if (vma->vm_end > end) {
-			if (!insert || (insert->vm_start !=3D end)) {
-				vma_iter_clear(vmi, end, vma->vm_end);
-				vma_iter_set(vmi, vma->vm_end);
-				VM_WARN_ON(insert &&
-					   insert->vm_end < vma->vm_end);
-			}
-		} else {
-			vma_changed =3D true;
-		}
-		vma->vm_end =3D end;
-	}
+	if (vma->vm_start < start)
+		vma_iter_clear(vmi, vma->vm_start, start);
+	else if (start !=3D vma->vm_start)
+		vma_changed =3D true;
+
+	if (vma->vm_end > end)
+		vma_iter_clear(vmi, end, vma->vm_end);
+	else if (end !=3D vma->vm_end)
+		vma_changed =3D true;
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
=20
 	if (vma_changed)
 		vma_iter_store(vmi, vma);
=20
-	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
@@ -909,9 +895,9 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
  * per-vma resources, so we don't attempt to merge those.
  */
 static inline int is_mergeable_vma(struct vm_area_struct *vma,
-				struct file *file, unsigned long vm_flags,
-				struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-				struct anon_vma_name *anon_name)
+				   struct file *file, unsigned long vm_flags,
+				   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+				   struct anon_vma_name *anon_name)
 {
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
@@ -1093,20 +1079,19 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
 			is_mergeable_anon_vma(prev->anon_vma,
 				next->anon_vma, NULL)) {	 /* cases 1, 6 */
 		err =3D __vma_adjust(vmi, prev, prev->vm_start,
-					next->vm_end, prev->vm_pgoff, NULL,
-					prev);
+					next->vm_end, prev->vm_pgoff, prev);
 		res =3D prev;
 	} else if (merge_prev) {			/* cases 2, 5, 7 */
 		err =3D __vma_adjust(vmi, prev, prev->vm_start,
-					end, prev->vm_pgoff, NULL, prev);
+					end, prev->vm_pgoff, prev);
 		res =3D prev;
 	} else if (merge_next) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
 			err =3D __vma_adjust(vmi, prev, prev->vm_start,
-					addr, prev->vm_pgoff, NULL, next);
+					addr, prev->vm_pgoff, next);
 		else					/* cases 3, 8 */
 			err =3D __vma_adjust(vmi, mid, addr, next->vm_end,
-					next->vm_pgoff - pglen, NULL, next);
+					next->vm_pgoff - pglen, next);
 		res =3D next;
 	}
=20
@@ -2246,6 +2231,7 @@ static void unmap_region(struct mm_struct *mm, struct=
 maple_tree *mt,
 int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, int new_below)
 {
+	struct vma_prepare vp;
 	struct vm_area_struct *new;
 	int err;
=20
@@ -2261,16 +2247,20 @@ int __split_vma(struct vma_iterator *vmi, struct vm=
_area_struct *vma,
 	if (!new)
 		return -ENOMEM;
=20
-	if (new_below)
+	err =3D -ENOMEM;
+	if (vma_iter_prealloc(vmi, vma))
+		goto out_free_vma;
+
+	if (new_below) {
 		new->vm_end =3D addr;
-	else {
+	} else {
 		new->vm_start =3D addr;
 		new->vm_pgoff +=3D ((addr - vma->vm_start) >> PAGE_SHIFT);
 	}
=20
 	err =3D vma_dup_policy(vma, new);
 	if (err)
-		goto out_free_vma;
+		goto out_free_vmi;
=20
 	err =3D anon_vma_clone(new, vma);
 	if (err)
@@ -2282,33 +2272,31 @@ int __split_vma(struct vma_iterator *vmi, struct vm=
_area_struct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
=20
-	if (new_below)
-		err =3D vma_adjust(vmi, vma, addr, vma->vm_end,
-			vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
-			new);
-	else
-		err =3D vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
-				 new);
+	vma_adjust_trans_huge(vma, vma->vm_start, addr, 0);
+	init_vma_prep(&vp, vma);
+	vp.insert =3D new;
+	vma_prepare(&vp);
=20
-	/* Success. */
-	if (!err) {
-		if (new_below)
-			vma_next(vmi);
-		return 0;
+	if (new_below) {
+		vma->vm_start =3D addr;
+		vma->vm_pgoff +=3D (addr - new->vm_start) >> PAGE_SHIFT;
+	} else {
+		vma->vm_end =3D addr;
 	}
=20
-	/* Avoid vm accounting in close() operation */
-	new->vm_start =3D new->vm_end;
-	new->vm_pgoff =3D 0;
-	/* Clean everything up if vma_adjust failed. */
-	if (new->vm_ops && new->vm_ops->close)
-		new->vm_ops->close(new);
-	if (new->vm_file)
-		fput(new->vm_file);
-	unlink_anon_vmas(new);
- out_free_mpol:
+	/* vma_complete stores the new vma */
+	vma_complete(&vp, vmi, vma->vm_mm);
+
+	/* Success. */
+	if (new_below)
+		vma_next(vmi);
+	return 0;
+
+out_free_mpol:
 	mpol_put(vma_policy(new));
- out_free_vma:
+out_free_vmi:
+	vma_iter_free(vmi);
+out_free_vma:
 	vm_area_free(new);
 	validate_mm_mt(vma->vm_mm);
 	return err;
--=20
2.35.1
