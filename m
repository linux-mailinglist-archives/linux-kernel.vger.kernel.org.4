Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACC65F441
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbjAETSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjAETQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC846EE25
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:18 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ISm9h001342;
        Thu, 5 Jan 2023 19:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=A8EhhluF1/bHGEprawBT8nXjfiUMfSvpckqA7Wu6mU0=;
 b=cUqV1TARBT8c1JsqB3cgPPO7AuF3Gt1oI0I1il4CekZc8AZqzKcSVSzj1hdh+VCv0ocK
 g3mlgCHo/WsFqri7DUOt1ch/357kICSdpSJgtvJj3BBn7I3w5ymqRU24I/VynFSA3+Wv
 W3ZVPGSuaijWXnYvbs3AkhiTpFclhE0iQrIjeTi0Qk9CGsZZlohRKsZGBPRUlSnLeW4R
 EbhKxQu4Ghs10aen0s62IV7N/OE/NNg0RixWgp7WgdZSiyqnnpDQa3JD1xjyyXkFnkZD
 jeGnwcXN/uzPbShWQOOkdfRaqirdV1mmnG6xH0XFbWmFfAKypvafdXrZAbbbu0x1vsL7 Uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c9qw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305HgaKW033879;
        Thu, 5 Jan 2023 19:16:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdtsj1fk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaaaSQyQ81LaiazFhwDFNqNEjCTijneMepnO90m0LYTbHbFXHJVGawXALc6jwIJdsSFQ9nruTEnKNBMJxFhG8GNghxRcGDVUUPZVaPWug+DJ8P9rom85R266L8FMYNegyNVFrhUDpAKILAPQY+LFWRrzXc3LBdwU6AY1zS8k/DA0OVISlA2rFbCWKmq35tYj2OcV2uNJjxc8WiwQ7kqAQLKq2xPFORci4JiRVZzjRHPAs6uwIS5EnSibYogJiQccgYMHRgy6/Ewh9QGxqfg6JbcDLk2eYVS5/OpsWeG2FiNh0Ste+Cj/WzduiNW4jXPOKNYfMGkzuTlcZUZILGGhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8EhhluF1/bHGEprawBT8nXjfiUMfSvpckqA7Wu6mU0=;
 b=bGUykpe0Mp/EDd9WeNg0o29PiRpHkAetAM8dOKdtkxvEEnfklImGRqEienN6RjUe4pcy+VT1LbkTstzeolcuTJBDuK6+dtwaZ2FGDTpIpVBi4dbzupw90eXJyKEVCagl8t4dt4YQbxy4tjdK5a1q5IV15wxHvaW9O0vUy9HbJf2o2OLSbI4E1XN4kBuIqhkQewUeDkzwwcEEkebijIJc7GWOVUKxWjn2G8318CnZWW3c7tuixitmvA2ivX+Zo/dsnbGHVur7PFqL9AQ/c9FcvZYXPJEyIL9G97Fb6WWKDFSN3yuZquTZJzSQtwns//zOfoz9jwjgOrBKHBpLWMG0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8EhhluF1/bHGEprawBT8nXjfiUMfSvpckqA7Wu6mU0=;
 b=A33dSLBIQtf/JmgT4OxVdsSNl0qjuwEohDs0K0jwCS2zeSv4+74ksSC9KksxC1xsksaY4zlhi4sdbU4EQFk+948QhYmyBE3NJv2Gx/F03qSh3/3iZsMvIIo0fgNl1yjQrKWrh5p32FhXF3Ni1dQxgrCo1LNV0zcpyB9hK9TQRw8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 22/44] mmap: Pass through vmi iterator to __split_vma()
Thread-Topic: [PATCH v2 22/44] mmap: Pass through vmi iterator to
 __split_vma()
Thread-Index: AQHZIToky9xKc85E+U28OcnfnQqIUA==
Date:   Thu, 5 Jan 2023 19:15:58 +0000
Message-ID: <20230105191517.3099082-23-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: 3acbfce6-4276-47ba-b9ee-08daef5149c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nga1PpxGD2wIFt0dJDzbqzNAnC3ElcZfbHKaJfOuyhfogzf5rrs3rb8qWt7Yfn2C+8+kIJpjfASPlwpgie55SJw0t744dYlzLCnoEoCVfsoZ6wlT/46x0/vBbIett/RDd7DGZUJVRd9Bz7nn+TMFwMGWVpQCBShNqDKUbpvTkkKfvLkZtJvot2v6ECHjeqgUdflZD2aFnbtgrkHR0uc5e+wnnKV74rOMH/gYzlP3nTFn/xeh6Fm8eqfNy9GBfVZiKejzAotiH98P8rwJrZZIvRhT81Na6e9hWQpxVwXfIEcep8fHdaUVNmOtlum0xprud/V7G5NAnniGdnT1efX5WDaklS0OAtw9Cp2MI1//4NX77xGoEEcWL7zQGDG4lwQ9lN9SgMKxCU5i94xM1/Y9s+XwpwDp9WC4RzCvgU2i2Fml6/CrlfwF5735ZE8/Hw1F1rPt0n/vXpKLiFO+9RbjRAOVppjjXBItjLiodp16gLTUcsyydCYO0uFCRv3NWetb1gpKvryZTj0zSDXIwkHeJhTxTZ9dZmKCU2qYNwBh1nJmq5EJaxpDIl99XAynihmR6qPgXqm5nGqzq0P0x7NkEGqkegQVCTIepSzaUtjLMig+z7w5Fj0Wp0IRFNAgG7E38aK4asYsFr40Xoz1/YU9n5ajiT6noDp7WTLqE93ubFxbMTdl/8y8tw+oqwCxpmKZXCINKiWRGW6m5+V1CvBO1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(4744005)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LY5Gva2z0UL/ZrvLpD6fTOcdrBURcQZbb7xFx2eO5N76Rq3dGaYCNLfj8e?=
 =?iso-8859-1?Q?C8mN9MUxMv1tNqubZPYDJ1Nk7euJn+fx+pt0g79Rbr29ONERqykusuhGGK?=
 =?iso-8859-1?Q?zn4YTiDY22TNSj40Jjd1ArY1dh1wUvt0tFYpaguSFgv0HE0KvZdv0tjY//?=
 =?iso-8859-1?Q?//hhzn5Xvlhvwv5i5CI/j2Vmbka0r8TVkPRAba+qoc1NABFqNA/pf7mK+i?=
 =?iso-8859-1?Q?WT4u+T2g8JmJy4QuqXr46B59ucHE2dD7wi9WDII/RnZitYByIJ8U5NfGAL?=
 =?iso-8859-1?Q?/TmMu+ZHn+xwxchOXX69H2UcG1TIGecA2c8deKCaobJ3MyuTmcM49R3nsQ?=
 =?iso-8859-1?Q?Jg+p+jHImrC8XEBS8Wwt+bEbYc1HezJa0e40kKUxK3v0w1WjDlTHuomX/l?=
 =?iso-8859-1?Q?dQIDgpNltq3OtnwWkZfF3bx7rWy5bJJl2lp8hMu4v+RZt/PBLxeYuN8s3P?=
 =?iso-8859-1?Q?XALYhD3LpEBGk8nfyhJWnP1tFaFT+QDkzE5yA3+3ddSns3z4r5kVDzujvk?=
 =?iso-8859-1?Q?Bn84B1HghipgxipyUjBXN4ENPUxW4gvcvrVvyvBun5F0nOVm5cNkZoHXVU?=
 =?iso-8859-1?Q?Pg8n7ZP/c0YvlypS7rpRfNuNuxmqJ5jgW3hmQFAXjxacrD3N8IeiTh+6ah?=
 =?iso-8859-1?Q?lHNctMjkH3CE//r+Td9tAdpjgBNxy2hIFTgor2+KqFuCDAY61TsQgNh6jt?=
 =?iso-8859-1?Q?peYlIseDZO0CqVg5omoZBrChUcrSKRv2u/ZxlDzvIAsdtMu6nGieY49wp6?=
 =?iso-8859-1?Q?5Fy8PJanvi0YBsJvTVyspQ5rVYHi7GAvdRXNtJdM4uBNd2W2x0HwVKinpX?=
 =?iso-8859-1?Q?LpOa5XDcIaoNZdCB+lRfRwjZPJLsKjg3/XiFq3e3S6737zeGaOecI+cJoz?=
 =?iso-8859-1?Q?R3vXT0AXMgcsjliyGhb/Pe32K1/6vZWrk1/6xJ3loqJ2/xjQF2hpSiEfld?=
 =?iso-8859-1?Q?YLRinL4Xqx/0ao5VCs/E8YuhZMkfUVjGixrFxTpvqfj4L6bvT6LfwV+N0g?=
 =?iso-8859-1?Q?zUuNhdQczwK0+doiaMT8WYAMtyQfUu/H1izp3+VBbH/lW6O8g8Mrd8XZmK?=
 =?iso-8859-1?Q?+uXSisodyFnvrq0xj+bSQVeZZAx2vUgJGR1uKt78SI3MASnxVRSTsGpiuI?=
 =?iso-8859-1?Q?eyS+1nG6wWaSiHG0S/dARwoo5Uze5GE1yXzi87cqzKoeG1GXYrTCfc4qXl?=
 =?iso-8859-1?Q?CKZY/y9chmQVIPPXEpsEUXy4AIh6m83hVCwnEHI8S4cuHuTthnMxSylwBW?=
 =?iso-8859-1?Q?Huylma0Aw9sOC8REeODsNf79Z+S0QTr+1sSSkwJCOt5bLl+JDR77wsHXvD?=
 =?iso-8859-1?Q?ad1tQLcVjsGC4kOVybKWVoIlqsJENwWDclpmEJm9RhDmgIeQEq/3B1A0CA?=
 =?iso-8859-1?Q?1wARvIGwcs6T8KsE5+6pRBf1wRG2xsPG5yFAT+fLCw8pMqahuEFHDqPZFs?=
 =?iso-8859-1?Q?tYKMnK+g4C2g9Uo+j2ZxoisLrRmYN35DiDluCPfeFqLX+DJ70uZcpRfSQj?=
 =?iso-8859-1?Q?uaLNNvlB7Ms5twLw3jd7TZXIYZQQFQVbwM4XCeYEHgtT8v9KyjiUaDRRD9?=
 =?iso-8859-1?Q?oezgXuLpWUT6dZ+Dor+iBwuJ0uCe2I3d2SKh1aT/ovdCA+SISUIflawKoO?=
 =?iso-8859-1?Q?qKmNTmiRhbMQCO0xs/IQJTAk5KbogDN8qKJG+RLODc5jvr8xJFe0ddQA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x/+bd+Vmatayi3Y3GtDGXO6LBnO30MKRLb2qmrDOu7JuNQYo+K9vq7QTPARwnHczZBK6FervCHjndrhBcmtPfIxTfel3QSq4ARGHJmzst13oHyFgu5zcVGUaGQ5+pAi/sHz5wycOiPnFIXdjVRGvNdZUft25meNnzH8aARX2gcmjEFZzRhM9OVoptzqcBPLI79zVwZHXOwiK8LcSAt2RvWPZuJ6l0R5nUx9DprzMckC5TmVjvBB+5iucZFbS+LkVzr5WXjGVZtjtLlC9RfVU2XCfOXosDATdZLvbjZk0WnRp2Si9bRXO2w/ajVr9UGe7GUet1YeonnqBbKEu5N7lc2aj7f1+YB/njgvv4qf7xOw6D/BibdVnybVgYKO++KCxuh3VGnE2oVEqB0XX9njMDLwt3tiGkc/g/VBPmzJ96axtcpWBALRBDvJyCq9luIxK3j27UbWKZQoR1E98LXwEr4r9nkPDRSP/+rv/H5bXHLFioa/bKSWqCdi9qgdf/78rR7tJrU9cNoXPjUJbHy4j3hFgkm+BG23N717FVLrBD7QzsdL7OySiOQPRY4PmlyOleT5kjyuGIGH5FOEX6WEgFYIM9SKjMwsk1iBAC4bqOktKAWp7/yRlD0KaELcGd7xHSeDfGA9cmlwVKGWpgtgK5psI1d7eZTK3C36LxcYKhUTC3hT2Nbs5iVWPgX80b8tmumM2SgaGe12/LTgNQNkuIZ35JP2jtxHXHB45zNuCqv9O96xEO26/tNefs1ckXbBEDr8BHSNd86lBBPieBx6Sscn8eNCp3E7haqorPnny/CK9SGG3rSEc0Hr3+RlXtb5UZd3KTIW5jNRs3hoRpj9ZwUqE/jZFz/dSKqLhYhWNhWpcMIVXpN8vV4nbYm+P3QuVBiQ28BKRUlLkMVLC8xNXAg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acbfce6-4276-47ba-b9ee-08daef5149c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:58.9693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPCYVrUjF/kyqAtu9XGwiQxsSjZWmOIhuDXutorIFomOoQSm5KrBtUcMFEcEsBH1NNph/YRRSLq3ieAXGQwLzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050152
X-Proofpoint-GUID: 9n8UK822l1bPGrC9hi8N62CgsOQNiiq1
X-Proofpoint-ORIG-GUID: 9n8UK822l1bPGrC9hi8N62CgsOQNiiq1
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
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4dd7e48a312f..80f12fcf158c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2446,7 +2446,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			goto map_count_exceeded;
=20
-		error =3D __split_vma(mm, vma, start, 0);
+		error =3D vmi__split_vma(vmi, mm, vma, start, 0);
 		if (error)
 			goto start_split_failed;
=20
@@ -2467,7 +2467,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (next->vm_end > end) {
 			struct vm_area_struct *split;
=20
-			error =3D __split_vma(mm, next, end, 1);
+			error =3D vmi__split_vma(vmi, mm, next, end, 1);
 			if (error)
 				goto end_split_failed;
=20
--=20
2.35.1
