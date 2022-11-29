Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7C863C593
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiK2QsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbiK2QrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6086C728
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:20 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGOoMi013723;
        Tue, 29 Nov 2022 16:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=x55XavSBAi4yOVyvkovD+p8FY0W8H7n0eGu3byOi1+4=;
 b=XT6pwjhs9Gmi7qrWbS+KJfdXEymNFHTgt0ZLM2jJ/2EJuhArdpLGeXchW/HGG3WCicw1
 c+bB1bbn3DHUgd+Yi1mtn24CSN4QFfSs2FOHygmdLHE2YsVBeNvR7tpAG+kBKeuFGyY1
 C9Eo7VzqP3HNNZDqhkZDVccZEr8SQOsMpgJdd44miPYXso+AIBdAS4VgFsBb2xrABtCt
 yugzgqLg7jLjtt9DN57gDt9WGMZPYb1JtN6vN7bddGDYtMCd9sXg3lIvrU17aOrzmZFx
 Fkoa/LUY1PoU5rj+jUxFeAS24WORebm/DOES2la3sHw82tF7OmD5poh69acV0tXW7CTJ WA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3adt7e5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFgHOR011450;
        Tue, 29 Nov 2022 16:45:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398drgfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKpJLAI0eLc1P3y1xiPDwIrdvafsvjJM/++utN4dN7QE1Ny0CChNyYuqD6+knduMVYy56rZwKYGXL8gnyXtzI6JiSsu/rVgAKe9FZfIkSBj+m3yD8CgRcojoJGY1pvROvqG06TKHIGIy35A+f9tF0mYclQoALrHN8W+9Lggk7EkHI5gxqZg8c5PEFrMsspquphY5x7A4brxKN7MhbRHWrKp/y4F6v2JBNtHEK4Mpwz0gD2OL3aYU1m3rA6nZ4S6cwYp8wHxuudRG0F/s2wFPUnXUgyCIECLVMgyjkpv+8U5REpvNo1hBq08Yt8S6OQJdMhQLvsfQZBp1KkVVgdn3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x55XavSBAi4yOVyvkovD+p8FY0W8H7n0eGu3byOi1+4=;
 b=WiPmqyJAVyz5uwNK5RjXogiQTNpd/FmJNVkaVD4N8uwIp7BEEEGPqvkX2/zNoPUe76Q4y7xGUHw1MmobKWN8zsgqEiMfuQ9LkKXpK8LMi/U74Ufc9N1kGNPDDapwAVA0qdvznsif6vTgQHYJMXhcEzJTI7rEJW1TNWTZjTB+jvC5BUhFT+0x6L4eemM0WJWY8nQwJb8TbC8km+1rzjUaA9BxNwbcgSzii5/wn2AYHDyRaAHArFeZXxXLk6VLxdqePuon6QPNb9tpugAzoPUWtGdDfQx8TYngMJF9SqLN0ORN9MDOoVcQeuCRXwGizCiNhlSMTLu+FiV8PjQcSxmKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x55XavSBAi4yOVyvkovD+p8FY0W8H7n0eGu3byOi1+4=;
 b=jN4zU5Oml5XNOeAd8hCKph3rwPBo9XpmZwTyK62vy30NTsZuCrbDFH/tr8XfqsMlAv+lKIQaR21UUYbhQ1CuMKbo+ODU7K9qIB72IeVuZi3LynbwUjdT6AN63YY5tSlooeduzwai3Y37qrQbBd8RII4fYPLs+mfJMzjdh0RaXRE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Tue, 29 Nov
 2022 16:45:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 38/43] mm: Don't use __vma_adjust() in __split_vma()
Thread-Topic: [PATCH 38/43] mm: Don't use __vma_adjust() in __split_vma()
Thread-Index: AQHZBBHdg31AmCq0YkitidwPIgqU0Q==
Date:   Tue, 29 Nov 2022 16:44:36 +0000
Message-ID: <20221129164352.3374638-39-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CY5PR10MB5937:EE_
x-ms-office365-filtering-correlation-id: 3eb6ae5e-08ce-4027-dbc3-08dad2291489
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2e58AWSw677I65ukj3bLVL31BX6t5qnxQKBHmGACHa674UHrFJcdIvOvej8jFwKY7ibLqdOjJpyC4wlgm2e0lvqQ1ddH0K/uhMlzzBEYmuiXSmHKmMS9fKUf74pxerQNnnxyZAufDrOZia78GBTPGDsqku0TtjsrIyvXu7ZlWohU1GVSMnXGw0IpF/RP0vDLPbz9xEUqnaQZY6AARuXPpoPMRlAd0B2ENHKwwdE2ptR9GXEtJFMRb0/rK3ou6hMvWPUCW2A0QARRei8Sk2zgOp/UMH+4xpcfpn3L+EA7hAP20nBORcxNf11lNXTBTY3p7mW7/1NAeSn32fO37KLuMxGr/N5VOFM/CIhz90TOMzuwqxUiyMMlHaCAEjc/aJv/lov3wZdudCMylEuT1iCe/nTTw2jTunUhqxyQxcOGVq1DIJ8W5QBp2tjgGCpDpTgJfRkjUtxEi9bfMfPMsdRU8+jKcF5w6SR6NfPymIxiIdlibGGyhSFwJK7San4jw3AxpSHyN2n9J2iASZAfqkvJb2NWRceBtjufDiukhNHXIpfeUYZhFFCnvESkqE8eKnT4i10OODpaRSSKUWdXpGH+12so7Bnwb3w9g65Z/DERUugO1+PDylbbeE2m9er/CezWPvC7ieQFz4cAt21A1LsgBYrVjenfza+15EAcSc0y0Oi6casBzLiwGX4gxG4NnaccOXrvyXAdXcECffDRa+s9sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(8676002)(66446008)(66946007)(86362001)(66556008)(66476007)(4326008)(64756008)(91956017)(2906002)(76116006)(110136005)(54906003)(41300700001)(38100700002)(122000001)(6512007)(83380400001)(186003)(8936002)(1076003)(36756003)(2616005)(316002)(5660300002)(107886003)(26005)(44832011)(6666004)(6486002)(71200400001)(478600001)(6506007)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mXU4B6iVJAqTajioUAHRVL0+H5hMwQHmd12Ry/AApMvh779BS2D4Nz/v9b?=
 =?iso-8859-1?Q?QdflOxbxW3hOAGixiTayUVcH3DPwEOi/P/56feRlEOE/4IVMkEdByy/eQe?=
 =?iso-8859-1?Q?V3bhoUyMAas+TSg/k3QYJcxdGxToEoUoqI0Z4bnIPeVSxGa1yDEdfOwPMQ?=
 =?iso-8859-1?Q?ytJ1ibrC0f1okCgzO5i0x4GrqNauuycmsGvETXnSGhf+q3d/5xxMeg9KgE?=
 =?iso-8859-1?Q?pm3xwhc24gWxWoqKXBSYcucTVSjmIUnT+Fadlkdp0XN5s4tHvxWo5F6vRW?=
 =?iso-8859-1?Q?YPc9acDt91dL62pi797W7ggizYbEfA9gA8AOjvZs/LATP04j5HdUBPG20F?=
 =?iso-8859-1?Q?BuCZpihQvQq0USZ+1f7tKZsWy23dhNEp5qJCunM0ehfq3GbNSCsZX1kutE?=
 =?iso-8859-1?Q?h9SReMx8o8hs2dp51baS4raTU6WWF/lrd+/STy2UcYnfwMVO4+uj1N2IOV?=
 =?iso-8859-1?Q?H48sX7j6wgOhflMOYEWVB21HYoOUwU+5MHzvr9qGoKDs8TA/U/0jZ6/hrx?=
 =?iso-8859-1?Q?NDo1gugPkTI53FmglEN+iUplq9OGYYETu2gd5jZlVaCHibWIarmdICnbrh?=
 =?iso-8859-1?Q?mqh/9vqcDUWYF10rUogL9ZTSU9qOpKI4Kj0PX/v6e08luYpYmLucfZnXjh?=
 =?iso-8859-1?Q?1Whl6nluVspt6GLglcGD8u9ccxW0rny9aFZNRuCOySxscw8upRP29286WL?=
 =?iso-8859-1?Q?RPV7ht0P60o5mr3/BoJBYKTY+msNH7Bq39OlQCzCL+xakOaqbEC8Cy3ujP?=
 =?iso-8859-1?Q?opQKcS81YkO0O7d8Qa8LX7sdP5dXpy3pLFjUb6kuW+8tALuXpRAINKroWj?=
 =?iso-8859-1?Q?vE+KtgAaJsjIxPB80Z4BZJVSZMGd2u5eyMzapJPm5Q4vifBk8uub9LmEYd?=
 =?iso-8859-1?Q?7y0lbuchgffUZQEOEYfIqrVRbaUuIINBwq9vAwjbNAvjCSKhLqsmgU+xQx?=
 =?iso-8859-1?Q?SBdhe9DHALQ1q2Q7tq0d9N2PgxrthecKW/DLo80B5va89NloajfT3aWYiQ?=
 =?iso-8859-1?Q?t5H/5NiSo5BNm4XFh0lja3GAYbB2Un9nbHL4AnLZMV+4b2KeYDpIXnFYEC?=
 =?iso-8859-1?Q?eJI+77TIwGP7+/ZgFzAcVhMOJcIkm/8LiErbVP1Ya1MdFv2mAWIpEoi7kH?=
 =?iso-8859-1?Q?HpS5hu9Dchk2oRZvWx4F73cJ+HnaRkNP/ZwazM194g2d2wSbt999dgGCfH?=
 =?iso-8859-1?Q?tSpP2nvnYIqFtnRRypXsAwc5FMoAvmHwHKBiyWFslR83bdwDtkpdL23bch?=
 =?iso-8859-1?Q?9XUhM/BaG/NDGdt6/gMAEVBuKFQjJ9I2apYKx21SeozCQdvKPMS7vaSq6L?=
 =?iso-8859-1?Q?NsXjRTyBi2ZL2z7DCMYdz5FW6ThYsFPnVdjuoTt3ZTikUqMWLXhGKUvevY?=
 =?iso-8859-1?Q?pUV6jeb4nlO5RC548/ZIVZf3rxpOeMsdS8+HhIL7TC8bN89uQJIXKJEt7S?=
 =?iso-8859-1?Q?yM9ZL+bkzVVtKhYJjb3HfZFuRz6TLbyFFO6zOHUAwFq9XDcwL2ZKZVIdI6?=
 =?iso-8859-1?Q?4asFFt6pe/36hSnTV/2ah8Qa7KkFmn8nqVYzDtxB51v6AlsCfHyi8uISIp?=
 =?iso-8859-1?Q?4yBWgyxV/nXXmuivhVx94lZkBUxywZcJvUqRRSmxz/41lrJzhdesrIP/dU?=
 =?iso-8859-1?Q?l909d3Lc4TGHXMCQ4/eDXdCPLrOZOUXw3b9HbIUaEwtegbzzi/6b2lig?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: stp2Il4TfE9NAm69dQ+qdLyfLOv+rhhkQaG91Cn94UMVcMGJxqSzmoZ7kPoFk3m3JTRsbx6XEcnbHXjGWw52X6t/eYRvGxiedS/bZORPy9kgYZUa2fKoXPGT2aWsmzKha43lqtdHS/zn7MViVRk5kOc+9YSnqh0vrKND8axIm3WNKPEptrpn2W676TpFnUILU1OSOygWlNYK6EguUnli82RqNNhKQohWh4hLOMr7AR7KjO+6Jp2OU5cE4ctKCNycGt4wWmd8zs/Xd0x7YcrlT2KpJZwq+X4RUMNXDhT/Vplq1ElRuVL07ivcaGvRwYn42uOi9Dh7wO6QwkUO1jDaoCC0zH2Uh0NLgBu3qzpbOIYBICZMAg5W6k7S4wDFsKAhnQgC4rkxu4dfGkuK6hSjfYLZgIBKrErFloEl9olClD92xhnqlP4jsZAD4vpY06WN4cFvbvv/39tTcwN/J2QL2PT5sDmlIiw3Cp7y+jD5Byg9CVfApPiBL7ZGuHbpN6VLGzwuvZbH/vVDUHpTfbfGo/rugk9NPyIxAD8juE3yngiCEodFwcYGSzjqS7mvU7w4IiTRe/B6Gx4L0zWggENTbftlf2LYpDS98e6SyCO++LIcMiOmjyE5SWq317MXCBJ7koNC9ZdLPOtDU/GupeNq9I8WVEtgTC2vXqVjOnmCwIoEa+KtJuu3kSAlE68LLfZiE0sJAHc1lgsJWLCIuNgs/RapN8KMdvnU4BrR8zFcDyfrJyXr3a2MSAdzzNxoSxBWCvTqDtkccMyEecJuwT/WrcuyOw00TS9zVe1t6VZTSz5X8HIMTx8IEzVb0adhZPuMO2JXBaRa0y2/qxl9XqRVzsTFTqQk8DEtbV1VxMOZgkXP31OIOGCkfK1o55mPxTnEoGHZU4dOpGSKyIkFq3Idvg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb6ae5e-08ce-4027-dbc3-08dad2291489
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:36.5503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIDEwF3Iam3Mp7+owI9v7PhX3WdmpqzYB0mlfpfqtopq1TIVXKLZpFKdpAchlkP5KK3U9cI3H+ZojQvOm0ZwEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: zeE5lkwbYNEy7SMIoxGn5hWodzKgoufS
X-Proofpoint-GUID: zeE5lkwbYNEy7SMIoxGn5hWodzKgoufS
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
index 8d2b47e436b0..b3fa6dd2d0e8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -698,7 +698,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
+	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff))
 		return -ENOMEM;
=20
 	/*
@@ -732,7 +732,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
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
index b5cdb9d9e987..13abf070e911 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2693,13 +2693,12 @@ void anon_vma_interval_tree_verify(struct anon_vma_=
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
index 258113e13a88..061e92dab623 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -752,7 +752,7 @@ inline int vma_expand(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
  */
 int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	unsigned long start, unsigned long end, pgoff_t pgoff,
-	struct vm_area_struct *insert, struct vm_area_struct *expand)
+	struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *remove2 =3D NULL;
@@ -765,7 +765,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
 	struct vma_prepare vma_prep;
=20
-	if (next && !insert) {
+	if (next) {
 		if (end >=3D next->vm_end) {
 			/*
 			 * vma expands, overlapping all the next, and
@@ -856,39 +856,25 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
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
@@ -907,9 +893,9 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_ar=
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
@@ -1091,20 +1077,19 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
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
@@ -2247,6 +2232,7 @@ static void unmap_region(struct mm_struct *mm, struct=
 maple_tree *mt,
 int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, int new_below)
 {
+	struct vma_prepare vp;
 	struct vm_area_struct *new;
 	int err;
=20
@@ -2262,16 +2248,20 @@ int __split_vma(struct vma_iterator *vmi, struct vm=
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
@@ -2283,33 +2273,31 @@ int __split_vma(struct vma_iterator *vmi, struct vm=
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
