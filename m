Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8A65F42F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjAETQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbjAETQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A357495A7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:11 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IT1N2006652;
        Thu, 5 Jan 2023 19:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5oddPyVGxo/ITa895tY4016/N2FSt9g06ZqP6l9igmc=;
 b=tsGlMJ7PgjY3XQH6yAu7/0tpNmBuKOWmlKh9WeB+hVJNxHNs0HXpb6NkM1QQUJy3agpZ
 cSROAF5iVSDIEEMLgcRcOTp34MVS6WE4teV9KPWRIW/OaCgb636cSD+0i2tptzLFuQfw
 LUHTBbFtoDiHZKxnZepGMBugQE+tOploYEIFhAEMiCL4aNAfNYi0vLZqjnFArutw4xFX
 yOPDU9da1cxGv9F0klJeEh+tQokEpXSlS3Ulou+pdUQ+XjkXCrjzzfRdAtlPNVLWX4ot
 +UwYQrw0EiVJMHDc4tmC2qqKn0jhe9ehr9YPD+ml+hSzkixCdRGRDqeA8C+oItKzgQtk fA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcpt9mpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I0WPL023380;
        Thu, 5 Jan 2023 19:15:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6kx6-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKjUbf94U2s29NcS9nTNjgML2QsysiVvjYdieXnahBhvZCNaxtvyNZR8+9G11huKDdvu+YRQ7vrYS/YGtpW0RBAE636p88KEAaFmaCdBidM81QJruBgI+PrCgIPz8BAguPvvWuRY2t3WY6mZ81FksdGMbprj8SpjBVnZDPRL9RhkE3IfHmAEYg0gKrAmLCXaVRv//MRss6Q23q2+SRfzkg2lWymFIEUvA95V/proDjc7QHQOi4p+OuU6ON+JoQqgAf2HO/qwDSvJa90Hmci/sVhkV/mUpHS5jL7rFg4InDZyNsGyuE7S7zJrIsQt547/sYtB/gbmI6B1/fKMTnoWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oddPyVGxo/ITa895tY4016/N2FSt9g06ZqP6l9igmc=;
 b=Ag5YjKXUAUcBnXDg8tql6/pN4FaZr3i4ZMRpu0C+Hohko69itQIDB8Dh375YPRyCy3u0ah5L4bNsWuOvgWBCDNedXn59igW6LqJNBVqzzEPchSPjnIQ2IF2C7BlgTsUNFU2uTr5q7/r5cDUEMG15KW4CwCo3CuL2E7N9izG0zWFUT2iPiYm5hL8RIivp/kLrDMs9zfrLkzulXE3t1qadCvNjedY5e4ZbAE8wTiRpAuhBv/74YnuJCiTySiX0Mbw9VxmEWjRCnCyHV8P7CoLNWU2fs7FEcd78Ec7hvQ+o62IwyZmk5abJY2d+HY6I6Cz0PCE6kXp5kpBsy9VB1f/ddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oddPyVGxo/ITa895tY4016/N2FSt9g06ZqP6l9igmc=;
 b=ybW2BrbYlKzdggG6h9G7s8laTiXeh4SGQMmfPzEQmvJ2CO6hFRIINK35cPvOP3nXwpV+9kkm7xAJ0X7/Ow8lEyU8mpfcWcCtPItxfITKwVzXLSL7yALfMCqOa3nj7k2WWBKq2Vpyxm5B7qOKcXWX/3wnAuQUylbh7pxKCzYUwQM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 09/44] mm/mmap: Remove preallocation from
 do_mas_align_munmap()
Thread-Topic: [PATCH v2 09/44] mm/mmap: Remove preallocation from
 do_mas_align_munmap()
Thread-Index: AQHZIToiC4A4L/Ep90ijxDQbmF78WA==
Date:   Thu, 5 Jan 2023 19:15:55 +0000
Message-ID: <20230105191517.3099082-10-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5231:EE_
x-ms-office365-filtering-correlation-id: c0f0e2e2-ff85-4646-299d-08daef514555
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nT1002kgSu7KGJukdMAwi+6ZEdbGnBe0cJnu/ZqiYP9oVAnUHZAzFlAGuOpyFsuVYZFSsTcKCZK3+ypWam9WgdoeBY6VchJ0lO+yfJThux2Y00EOgvn37f6naQcFrTABsMz0MNNGjfRdk+6L5HVy0dzX9fhmCbRwZM7xcxEL7jyH8hi8eGS63L2hdjgCmBkKiT4ZClAoBFfATcDAQEWQ+fRj8VLGO3WDK9SZgN187hCm0CQ0B/ANzM29TAu5zDL6SHtx/gmmxOl+chbYkdXWfFXK5Qr9X8G98Sp5fdW7RNuUlcRtodVg5wKrZmTgKYMWUlDRvj3wdFEqpPNZ+SQY8af+yEDbWg9N6GIK1Gt+a6Zz+If1c3V5EVqeBps2OC4CMeLzxF8WLHvoUxFZYKJMXcT5D1gAfMgufdolXuPksKMsw3tdlmFUPbkwuyTV8To7TDD3KhmAcjsXTbTavLTGSXwF7T/n+8vymV4zHchf8vmzThATv3fq99CG9yIUa7mjHE66kRwLtb8nnwAeqqQHQrOfKgAOst2+wmlFHRA6tonugMX7MCOT5CrhobI/o8s26J6dklRDhB+s0a6LBh2EpjKh+YRsGnSM6eoqDqD4JUHDKa/pmIFdmKlXVj0gSejHBEb0sn0FGUSiXoB3ix41vzLmI+HPF4IMHO6umj57ZY6WTTLKadZaRSDtLmMWddRxSzzJxu30SckXVxo5raYNog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(110136005)(316002)(54906003)(6486002)(186003)(26005)(71200400001)(107886003)(91956017)(64756008)(66446008)(2616005)(6506007)(4326008)(66476007)(76116006)(478600001)(41300700001)(44832011)(8936002)(83380400001)(5660300002)(66556008)(66946007)(6512007)(2906002)(8676002)(38100700002)(1076003)(122000001)(38070700005)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/MRM92/yabb/EqSRbik+4wbm/HwSzeFZFcMEAfbx0qnD4euMRYxKXDOL6m?=
 =?iso-8859-1?Q?WgFJGGLlCru7m+9gNunBy1/OF4mb6qm0oprOxPIF0OV6Ix/a81L7/K11Es?=
 =?iso-8859-1?Q?9wr9PZe9+IzyqBl33wWj5/ybQgwVEEk9bwrwvTwNJHcwXSS374qSG9IxKM?=
 =?iso-8859-1?Q?bvUxjvKcZL8P/5tDGhj6cQ5NS9Vo/XG1nm/nLuJXyagLgIteWay6GOB0x+?=
 =?iso-8859-1?Q?7TLslsPHwfsqtEpBh9thviy7IJJqzpaL6/r0w3kN5++G/Dt7X7ElT1cPHI?=
 =?iso-8859-1?Q?4oAPXtr5Dc4lw5rdk54/hKomqTovfwFaBvHEdwuO2C2C2wU7wFTd8GNoHI?=
 =?iso-8859-1?Q?1nEO/NqJvJWIKLA0WwmWxzHetNPYtBC+SrOjgwTE9ymfNns4lUR7JcKN7/?=
 =?iso-8859-1?Q?wuhZuyTadGR1DN4OlTl6QbHRjMIUvs2we7U5e4vGID6lVXBD8nBiqfcxw9?=
 =?iso-8859-1?Q?mu7WS1gtDDNE9keWBhfRafTIUpn0De88jSwdTQjzMCpxVgqTTIoLFbVqr3?=
 =?iso-8859-1?Q?oqQt/ukIJq4eTp4WPz8KzUoo6L6VyveF/SttGpZVqC61xXXdeXCrc9huol?=
 =?iso-8859-1?Q?XXK7jSyZ4Ew1rrWx6y5iQvi+HNEtE8gVfnphXhY91TvbmMhBOXZgyYRNpG?=
 =?iso-8859-1?Q?O6K84ectZjoVA4I/eg1gVW+KvtjF7KSmRGZl/ez6A5zoI7yO9ScZtnsyBF?=
 =?iso-8859-1?Q?fhsRWI+4DlEoBDNe1C1aMQsAM6x1TveES6sFbWHmFM8R0cjDVMWnBDPdQp?=
 =?iso-8859-1?Q?3ZNruB9bPneGpwhgFH/wOXAMfCB7SeKEx2++8DUiQliJX6ocOx08do6keL?=
 =?iso-8859-1?Q?uD6xPwnONd42FGM7iWtETZwd59bb4X+9ZunCgGNxUnLzB7kVk1wtTxy4jJ?=
 =?iso-8859-1?Q?sjb99OluUlfsqHNxD8GbCdi4lmH9IE35tJmZUQd0xLFgnH/RwWwuWdJQAy?=
 =?iso-8859-1?Q?302h0DRST1HPe4p7OsgFQyX6KImkg4bIAB8lXoHqx0vBd41v4nIPd+20qs?=
 =?iso-8859-1?Q?TX5837fiF50BFepn6b+OJ8Jw6DKmLqpCal3EMXxUL0fQzSlozxvx8hhvEF?=
 =?iso-8859-1?Q?MZnN9asdbylhvorHi5YCZEE+iFKU8RcICLsReGYcGYfcJkI+fYShCY1UYA?=
 =?iso-8859-1?Q?XvTgR9JYSog6WDM9n32FgEp676+1WGz+4yz5djM40FCnMq3SSBAonJsj9I?=
 =?iso-8859-1?Q?nVUUBVce9q69eHz+XAVHndNdmRqtg/4U2KK/LrV4EhdT9hbKo8z7umvwMP?=
 =?iso-8859-1?Q?Tv27ODB6LDakZbuTCNA6xVX1RLA67FwYsyu2dskOfI4kOd282P8AjvOZlS?=
 =?iso-8859-1?Q?/UfLp40DD+aGiVGuWB9pXiazMFIa0WxC4M5Gz0CW5GixWovc6s05JiyuP0?=
 =?iso-8859-1?Q?K79pnPW/mnV5AsbO6wqyeT2FB5YUyo7qQWzsA76VsXW6TAI1v4I/1z2uH7?=
 =?iso-8859-1?Q?IWTGiZWk5mW/Rnw55RiJ48eicHXgKTZjvrfYaGKa1TvFJCqmX8XhHDyMN0?=
 =?iso-8859-1?Q?tDVtAdNsBMcvYTPO/9T0t7TV+UOv0TBkm6KF4uzIJBCdqEZDuDvMYIFgRB?=
 =?iso-8859-1?Q?Kqv6gCjCQ+CsdJVhjHtY5zTi8xL2tQE8oOHm0DhSk0XCQhTWb+BjBsdPMr?=
 =?iso-8859-1?Q?J7muWd49dqngB+HZX8frs7phRDcnRU6QaLrRkJlXiUUsfuVrPHANwzlg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G5ea/f10URU45VdsST+cT0vaqMH6vQ5M6uQsrlw01hyuBCWKsjA6W2tG2t4u6CPJ1pHBXkcvRgQtFdRgicuMIEqEe5jisFBpC6IYA1zMJFrCt7JyfKWNdsDXqrs/c/t1qAo9RhHj2M57QE2pd1ph4wV43usgZJPAk5/U/ZO6CfEPCfS7V/zgH3IMlxazZ6AJI2WeYLw01U5SRPD6dkX5ppT+wpUlaIgOtqatDQ2phEw7b5cDq/t768eo4l2/nrIFcjhMX8GM9b8lMdNhGKBTJrZ6y+jOsuix+bgKods9EVCCU2xo8gMN0IJpcOQubGahZ2NgpIQnKvCtRc1X9xKJRVJwoF+T0BsTtgafusZDq4xY5lygokNvMW6rOlhxWywzi+g8rD30MIXWKMrXjzeZ0XLn2Od6uZNbuQLTsOwef09FlobzmE8sn6yb7VH8W8h2w74Er9aFou3SIrdPUXoCM/M2Hm2c6bOk/FriosUSpWxWMJUAZu9cOuQNGtukPqP8WYubON6CY578fUZ4mpjqNTlGtZRsCrk6uu5GcRHT+EaTV9cp/4tmtT1Qc9mSPDRC1wsVJ0W3vLyqiDl8JKrx5o7cZHOrjCegOKID+YoC7kzLEnkqmaTQYmOh0t4Vaa99B8FlQ/Wj07uFXEenDo3Ne+xwGQKquEUJ5Rxlq1gxCQha67MEzEd5mI01RD+ConCeg/rdeR7c0fJp5Ao6TdK6I5snP3A7YrO4G3nJcHJAXJg2oWVhRCZORDVJfrGsDRuDKI119u7LudthSmn98zdSvTrtAgvBvFyCLFIE0vKt0qpj6NTNPlEnX3ETI8sISQ5o1BAIsRa70vj6bdbgbdmW9MbTNmKTGF1Y7+3D3qbnXcSB+y1XTijMxOX+aMq5TKol+PGgiSdWYnvZEkV5ClZGEQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f0e2e2-ff85-4646-299d-08daef514555
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:55.1726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +c0m1YblSfsj507fXDwkJbgUO9Lwjxte7uzG8LLNKIKAvy4X1TgnXRTzh7QvRabtjXHZbm50v2jKTks9ztYKHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-ORIG-GUID: W98OwjEx5t78S8lfhLtWEBlte7yydFIE
X-Proofpoint-GUID: W98OwjEx5t78S8lfhLtWEBlte7yydFIE
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

In preparation of passing the vma state through split, the
pre-allocation that occurs before the split has to be moved to after.
Since the preallocation would then live right next to the store, just
call store instead of preallocating.  This effectively restores the
potential error path of splitting and not munmap'ing which pre-dates the
maple tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 00b839cc499e..238b10ca9f9d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2384,9 +2384,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
=20
-	if (mas_preallocate(mas, vma, GFP_KERNEL))
-		return -ENOMEM;
-
 	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2477,8 +2474,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 			goto userfaultfd_error;
 	}
=20
-	/* Point of no return */
-	mas_set_range(mas, start, end - 1);
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
@@ -2486,6 +2481,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count =3D 0;
=20
+		mas_set_range(mas, start, end - 1);
 		rcu_read_lock();
 		vma_test =3D mas_find(&test, end - 1);
 		mas_for_each(mas, vma_mas, end - 1) {
@@ -2495,10 +2491,13 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		}
 		rcu_read_unlock();
 		BUG_ON(count !=3D test_count);
-		mas_set_range(mas, start, end - 1);
 	}
 #endif
-	mas_store_prealloc(mas, NULL);
+	/* Point of no return */
+	mas_set_range(mas, start, end - 1);
+	if (mas_store_gfp(mas, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
 	mm->map_count -=3D count;
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
@@ -2530,7 +2529,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	__mt_destroy(&mt_detach);
 start_split_failed:
 map_count_exceeded:
-	mas_destroy(mas);
 	return error;
 }
=20
--=20
2.35.1
