Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE30065F430
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbjAETQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbjAETQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036DAD136
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:12 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ISlMP001327;
        Thu, 5 Jan 2023 19:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6pBshLkdqSo1VBylaZBMWLf0C9CRkqL4Ielj6sbUnaU=;
 b=0/uSVYP0iqqOMH4+VOHyRMvxaLnYEIC3q2cXrMG2TaAwFG4j5RuUpDvdDJcrIOiwn2Lp
 1uKg5wUNY7S0l71uGzqlM8mEAjljaSZSGZ2UiCvREN+1kG7priAh1DnmdtljYPu3O6VC
 Xg2uGlhiHH0g9hGyHX+Z8xx1rAh7aWdsJHeiJMt8IsHyaCYSreOH6SoWS+RKFWMajO/b
 G9qjRbPdxrMGUTdc5Y/nFOg5RGjeE/pZ5qf9jGTnywqwE1tGq/W0gPckTBrgbd+9J6bU
 fpoMNcr9JiBSwaO2KNUcW64bJXEmc+RWWmcwN3wHhrAdvPmZY6mxEdXwjmJwBmJTs2ry dA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c9qv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I0WPI023380;
        Thu, 5 Jan 2023 19:15:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6kx6-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mESNu3vgh1FqIKJtvMkKthtz3KFgyPSib9OxH9Va5s95v8rwHlEKMcbILwIPmo9dwDc3Ufy5ak2vL9ldD5roBsGKnHdZ23vMHEUeEgeUQAcGWzsaeo+jlQOkI9U8lmLaKNLV8Sl+fl19a6S58ieRFHzIFMKTZnchBD5h4S+yqByDGgHKfa4YfZaU4zsI8ZGyAxmvLa0irf5RV72mdtW6KrH69qIWuYidfO3AacWBWqrPi1OFgepX+Bo/NsiolhrxdNGjIlCJ0oL/4i7Gb7HkVHIGTPkVHHV6jAVy8i/7ii+bs29KefooXh1BReNukTpMPEcC3zN8SF5ZwihqsZkC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pBshLkdqSo1VBylaZBMWLf0C9CRkqL4Ielj6sbUnaU=;
 b=nPniBzA+1vL2HJta3Cz9/qxllcJ37TFOvzRUM/lqNjdDzIYMI48Wc61AE4/tJVuIr9Ks4kgBMrfbNo4OUcSeMtcgmYkIJ/lTAKq0OiYxrknVMm+csQJo/NSctBVwUK++JZ/IN2m8bXdWSKlJgdDZ1b25Dk/um03CzhCHEMGqZGoxSKzCDRz+5R8DHJLmxZ5hMuaVg0h9eH3VKNEJ0XTWl2leGM+VcF53t1H5OpMyAKASwLw8fEqGtt75ymWDhsw0YThy7zI1thKFSccN2a+r5+CWz1JpuKCZF812kwkNLQighPXrdXtcZrP63QMa9xVatkDF1mH1YQ2dohaBBWEM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pBshLkdqSo1VBylaZBMWLf0C9CRkqL4Ielj6sbUnaU=;
 b=smtdmd0j7uSv8ZQ4+Kd8r2rOsgFHaUbnN0au4q7A8KkJCd5AKsBcfX1b2N791wb5GBhdtpZShhOwe4IqrgS7UwLad8b6CRQXZeQ6UFFit6mOjmxzTvgvqBcDHNJztSJ5oDP6aQXArQ9OL+LZrN93S+Lsf70dkEtoBVzCnpNGzq0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 06/44] mm/mmap: convert brk to use vma iterator
Thread-Topic: [PATCH v2 06/44] mm/mmap: convert brk to use vma iterator
Thread-Index: AQHZIToh2YIFO4Pea0W8K6URlm/QaQ==
Date:   Thu, 5 Jan 2023 19:15:54 +0000
Message-ID: <20230105191517.3099082-7-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5231:EE_
x-ms-office365-filtering-correlation-id: 6c9bdb8d-73ab-48c2-d315-08daef514498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Saxe1qIc1iPeCSBC5i+vKMiWEqLd4kthjqiKN7I4+9YpFjEdatps2UvAetwI3h3SnSUQrQuWOvNZKlKK9W+XGtEHtP5nXbJR3glWPKOOXEW8gQJHZa6vWvYpZz8WkT0nGybISpv1RSl8l+gU0KOUzleJxcvrwCubUDV2SQpg2FmWQXWYKGUbDwYgNEyaanyZEUKWrSFB2n4Z1OPTJA+30VS9IBe571M8cnsonEF2JkqJzI8bGEWdttraoyFdIA4P+p6U7DsXOrzBD0x58EP9IaCmDxMN/hGhUiKEpGYvuaTcJqz1EmIZgPSwlUognRz9J+9pagx627bPaoq9Xfy15xBne9mXKefkDriYVRPHKVO9aVMJjyp7UBETqs6pdyUibTHLijRqZDg0Oi1LhWLZkESNYKE0eOo/+cVGI21OJo59LqEU0nZ80cbPmswqG7iFsc+b9FJ+KZOGyIw5tRT9svoENaLCTOzxoooP5juyssjiItqrvqgVX+xl5HsPvjd665hOozOcaGdXGAXl1TdXsxQ3fmRs5nYh7+lELvrGSUSsLTFb4TK7/9vrAl0a/N8m6iz+smsg++iMOFpDcyEH3AMhGltBwTb72aEpaKhyWe/q/Tg9AHaz72fJg/6LG6Kou5JM6CoK4jNiX++G3W25I03fQ2iyy2Rv+/BJekuHoW8ELS/q2RHbpIn7Sir4t8tJmrXSdr6DHjia6SABE6h/hQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(110136005)(316002)(54906003)(6486002)(186003)(26005)(71200400001)(107886003)(91956017)(64756008)(66446008)(2616005)(6506007)(4326008)(66476007)(76116006)(478600001)(41300700001)(44832011)(8936002)(83380400001)(5660300002)(66556008)(66946007)(6512007)(2906002)(8676002)(38100700002)(1076003)(122000001)(38070700005)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zrl/LknJrixZ10kbDQMTucMNoxOwX2NzCcboR3l3dCT5/oAEeFlRYbj8q5?=
 =?iso-8859-1?Q?UA150RlZ766IqxSQTEU6MP72duSYxUXCOtlZcjL4iq1OC4tnBZ/JP02I+J?=
 =?iso-8859-1?Q?60PptqSwE2GqNNe7yXjAEfXNcOJ0V+ZIyq9MT1FfmEvpf3s5Y96yOoarIQ?=
 =?iso-8859-1?Q?PfjhNwpvfwXv1uD/E6UD5Zzdd94/v+yrNvATT7w3P75tuFozIVtOOlb+TE?=
 =?iso-8859-1?Q?ojSsZKL2avEis4c7JcZzl3AdBT+WCXXHpsz/jyJml3RTGyozy5kzeBq9/5?=
 =?iso-8859-1?Q?GnX23JGmdb9wAyiLQoqlrr2z+p4eDqwMPZFD0GaJLWypthbbPG6+lb3aiF?=
 =?iso-8859-1?Q?STo+AUYfGHOXyxC/zOlmOSRQnfHyfRTJEfgQIBkk+OGNCFGLwXT8vZ4l7i?=
 =?iso-8859-1?Q?LW3YOhMDB4E9s9Jr2yNkSn1lQ571/lE8slhzWjh1iVv9hhCc9TfZn7K48p?=
 =?iso-8859-1?Q?qAcjXJyLy9SNExHFTIqNRAG9dtWfV9YFSh57MObUxYc0Rxcu+bE1BC3/oi?=
 =?iso-8859-1?Q?0ko979GHLdJVKPjw/rQ0vT9GvuostiRZYmGQZJAQ8pbLUX9UdiFJOcACT1?=
 =?iso-8859-1?Q?iduB31qISzNjIeg1Cnm5vyawLaIJCW68XVE+cCeEKG2O13ml9TifZkmv80?=
 =?iso-8859-1?Q?QtVYEBmLQC2BXkQDTVTPaJLg6VlwtUmC5p95HHKWBIl8lZh3XWI/YN7LAK?=
 =?iso-8859-1?Q?zxlg2Rf5WOTl5ePc8xkydeHAKcVV6QllfC4igy6zx0tUnxredFBCAtPsx6?=
 =?iso-8859-1?Q?ylEH1MFsmoVPokoC3DQfICydeCM7Kg4xV8tOZoeQjMiKRJDk56xeApWhzs?=
 =?iso-8859-1?Q?iQ/D+NwsbjhDuiwzONRyL9mAC15GF+GqYtH7ReI98eFBPG8tNEf0E8QpmV?=
 =?iso-8859-1?Q?jE9/h9jmyP+w5MqdTOZRPbRWnjcdCyjJ1Tts89Qi/b6YrFx/d9AXQsp213?=
 =?iso-8859-1?Q?MWYV6SY5jnNiXsm+3WpcAaZ2V3+1nGPoHQzOP80YqBHgQpp1fwwxiOvNvZ?=
 =?iso-8859-1?Q?3MbSu1wMDheN2SpnxoJ4+izMmMsdrSKWpxtmidmgexusAmLcqGh2thqgzk?=
 =?iso-8859-1?Q?YP49On/UOqqhw+ju2bee2SUIKyYlCQ/jG6/w3HXERvQ8g6aNyFWVlYenZ5?=
 =?iso-8859-1?Q?Jaq4kLkDRRiy9pT9Kz7Ekl03wBIDrZvdSvFcND80ABl//twY5qeBiVCs3h?=
 =?iso-8859-1?Q?BS6HmLCccPysnZFH2TJBErtiIEkm52ZG1Nmwd4U7VoEmfd0CN51uvkMqKK?=
 =?iso-8859-1?Q?l+YRS7esTNz4oJzw2+R3iOe1tmKlB9W0vxSnhnWvL+4wECexSOEm6GCeEy?=
 =?iso-8859-1?Q?GMDnnVa7q7LzRJpq+5P84xfgsR+z9xvdcg9eJNaHtzNlDo/c4mSUbYdwr8?=
 =?iso-8859-1?Q?Xf121kxwQA8NoI2FSEI713YwcU9w0kaYAscBrj90Pvf5rVTYiNEk8F7Qno?=
 =?iso-8859-1?Q?g6TCId3uiPjHeFlTAn+p++xLMOW4u8J2PI+o6t/xoAjpQwROidRY6PXBaO?=
 =?iso-8859-1?Q?O2BECAMb+fsAClfWUcn1Z5IOg6AJ+veKfI3NAOkXwP4QsCdlnnv+6FvEQc?=
 =?iso-8859-1?Q?ubGMHbfP39NAI3FZcmTsNvQDvNSEBozEdNVtIfsiM2DFxZy3Z/3w8isv3e?=
 =?iso-8859-1?Q?vkpaHca9m6CC2gDLI/ZK5ps5kCQ4i98HteoA91fdafrmvVKwPbhG7ccg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XLSdJBsG4vCGQgGyGf2UkDDyF1sYxghsNoj7zWfUPwIFaF4kf/UBS50HWnIlzCDxX1bwxBh0gjEHSgXa4ILOEoRKw13aLLIVeodk1UhmiKgbJ2xfALENDJkwQ+YHXgVFLQE2i7vLVoN6lfKsD9QmwTMGfcQSG46lhI7tNwJjMnXzRh3UpyuWZRNqQPXKPjKD/i0hiuq0pVoUG+EH375N7jBZ7sVw6j+B8C+Lo56dn+DaLTuxhFrz5cjUxDVIfY7CMwT3L6j6F87gnqVsG9kGd4Srdk4WUJDcpTICVD1hmp583ImolPxXLWLBT9iiKumqFBTZ01sOnIaDlh7vL8jc8Ci1saax3CPAh4bCAsoRHlGSTVqT0TyhuWpdJ1jx7MJvjJ4twSIYHhT27MBKQORY8zi5sZpkZDK61dLeFpSgONFQu5wNV2CRG2VRI7jNUaUH19q66inupTPdbV7pDNDENAj+5uCfeLk7qHjdk1Vx4e+QIc7juycBhrZawuBgcscWCpC5Cz2IsglhClTowjj8MUD/mS5AplbLLiiy5cAUfWWQN8PVS36Xc81dt5vLbS0kKfK+OXMo0YjeXn+AiamrmmfrsVe9q4KwQ3zYXmtsbWUQwso54CzwCmRHYbt6irECZeB6U8hHnaXplGs/9stONwpzRQPWgC/MoihfI4tEO7a0hjWNJzHLiw0QDyPiGU4KkNzED4Dz+1BWmTvYSE/H+oHkBgs952P8jXpEIR7I7v9+ZXNjFbj0cPy3IOdlZUxEMDGXxG3zUzN8023bsvglj10OseWiO0HJZToM18fyEtl4rFzHrfsK1Z9s6K0GuPSeRZlfR+5in/CWljG31SUo2vlQaY98GK0cGLI6qCkFGPXT4BbaedY0rOf5nOm5ds+qSem7sR+7fQaWr64/QGYs3w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9bdb8d-73ab-48c2-d315-08daef514498
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:54.2821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v12k5sqgAGYYGEsQBbiBk3iS2FNCgeb2/j5p5K3/FlrljTVzOvXgvHi1SZFlKakUQtWd6gwji7kWwO0Y5vnddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: qA2N29BLl0kQjRFlJGCLAHpUBTXFTi9k
X-Proofpoint-ORIG-GUID: qA2N29BLl0kQjRFlJGCLAHpUBTXFTi9k
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

Use the vma iterator API for the brk() system call.  This will provide
type safety at compile time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9318f2ac8a6e..4a6f42ab3560 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -239,10 +239,10 @@ static int check_brk_limits(unsigned long addr, unsig=
ned long len)
=20
 	return mlock_future_check(current->mm, current->mm->def_flags, len);
 }
-static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf);
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *b=
rkvma,
 		unsigned long addr, unsigned long request, unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
@@ -253,7 +253,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -301,8 +301,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		int ret;
=20
 		/* Search one past newbrk */
-		mas_set(&mas, newbrk);
-		brkvma =3D mas_find(&mas, oldbrk);
+		vma_iter_init(&vmi, mm, newbrk);
+		brkvma =3D vma_find(&vmi, oldbrk);
 		if (!brkvma || brkvma->vm_start >=3D oldbrk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
@@ -311,7 +311,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		ret =3D do_brk_munmap(&vmi, brkvma, newbrk, oldbrk, &uf);
 		if (ret =3D=3D 1)  {
 			downgraded =3D true;
 			goto success;
@@ -329,14 +329,14 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	 * Only check if the next VMA is within the stack_guard_gap of the
 	 * expansion area
 	 */
-	mas_set(&mas, oldbrk);
-	next =3D mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
+	vma_iter_init(&vmi, mm, oldbrk);
+	next =3D vma_find(&vmi, newbrk + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
-	brkvma =3D mas_prev(&mas, mm->start_brk);
+	brkvma =3D vma_prev_limit(&vmi, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
+	if (do_brk_flags(&vmi, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
=20
 	mm->brk =3D brk;
@@ -2963,7 +2963,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
=20
 /*
  * brk_munmap() - Unmap a parital vma.
- * @mas: The maple tree state.
+ * @vmi: The vma iterator
  * @vma: The vma to be modified
  * @newbrk: the start of the address to unmap
  * @oldbrk: The end of the address to unmap
@@ -2973,7 +2973,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
  * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
  * possible.
  */
-static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf)
 {
@@ -2981,14 +2981,14 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
-	ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf, true);
+	ret =3D do_mas_align_munmap(&vmi->mas, vma, mm, newbrk, oldbrk, uf, true)=
;
 	validate_mm_mt(mm);
 	return ret;
 }
=20
 /*
  * do_brk_flags() - Increase the brk vma if the flags match.
- * @mas: The maple tree state.
+ * @vmi: The vma iterator
  * @addr: The start address
  * @len: The length of the increase
  * @vma: The vma,
@@ -2998,7 +2998,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
  * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
  * do some brk-specific accounting here.
  */
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *v=
ma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
@@ -3025,8 +3025,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	if (vma && vma->vm_end =3D=3D addr && !vma_policy(vma) &&
 	    can_vma_merge_after(vma, flags, NULL, NULL,
 				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
-		mas_set_range(mas, vma->vm_start, addr + len - 1);
-		if (mas_preallocate(mas, vma, GFP_KERNEL))
+		if (vma_iter_prealloc(vmi, vma))
 			goto unacct_fail;
=20
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
@@ -3036,7 +3035,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 		}
 		vma->vm_end =3D addr + len;
 		vma->vm_flags |=3D VM_SOFTDIRTY;
-		mas_store_prealloc(mas, vma);
+		vma_iter_store(vmi, vma);
=20
 		if (vma->anon_vma) {
 			anon_vma_interval_tree_post_update_vma(vma);
@@ -3057,8 +3056,8 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	mas_set_range(mas, vma->vm_start, addr + len - 1);
-	if (mas_store_gfp(mas, vma, GFP_KERNEL))
+	mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
+	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
 		goto mas_store_fail;
=20
 	mm->map_count++;
@@ -3087,7 +3086,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -3106,12 +3105,12 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	ret =3D do_mas_munmap(&mas, mm, addr, len, &uf, 0);
+	ret =3D do_mas_munmap(&vmi.mas, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
-	vma =3D mas_prev(&mas, 0);
-	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
+	vma =3D vma_prev(&vmi);
+	ret =3D do_brk_flags(&vmi, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
--=20
2.35.1
