Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00F66D45D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjAQCfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjAQCex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8E22A169
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:28 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H090kU000925;
        Tue, 17 Jan 2023 02:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kcVR8wcRzd7rqAneXAQMl2ph2Vw50Ksh3FmZ1KTj5NA=;
 b=aku2XUUUD6fhwcMPP6BIC0asx7PnvnssdKwHmMt9jIR2Gb23n1od4csYoZEfhi+58Goa
 mtoXtbFZuq2xSE58cCiG+TfHzuESdRR+ju3vTEu+xTupEFhkxEmF+iUA2wZQ1ZbRMsTa
 Pd5PzDIcaRcZhdjqL23VN8OYwxNy6by8gzob6e0I8OgclHpFmetKkRO6W1B/K463PJoc
 08yKc8cUVpytOu6Gwtv+Lqu6/7QRaxXNDXf6Sns/zPic8tDkJZuDZv0zjOTKYNhHXccN
 uS634JE5oMFD62RX/kKnOUwB7AuCL8WagYKVErLVxfBg3hJpaKpUk0g52cBCGqwLoS23 +g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medbqbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNXAUR020577;
        Tue, 17 Jan 2023 02:34:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq37hat-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilDY53721N0oAJ+8kRM+rQ8daJJOkKtKvtxtkCIILzDVKm3fpP1+hC+D/bJr6ADRI5c37VOx14OHMSStsYoLCdYMecCM88K9UgaSADQ8t7LCqf1qouf5HdplCCs1E7kB7bSM1RmwxjaovcJLDEgfpOghbe6yGPrBaq9FaaudV0SdxyRsT2pRXjOL1+dY7+ceA2fe/postVb74BbEWF7RUpv3+EyODGzKKfPBqSQfV2Oz3k9wFlbhw3HhYWEXvdvGva4WE2ZeCGk4Ahv7fpNMjcOFZnIb59raSEUEegy98jvtGX4o4joYZtruQAnMwf3A+wvLDPzB9Jk7afH2cC7ccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcVR8wcRzd7rqAneXAQMl2ph2Vw50Ksh3FmZ1KTj5NA=;
 b=TQpEERqjMB4JubTWGiMXmr12XKHLk9+5zxcu5EejopCGyAcRDRNlauxjewKgT1tQjeXK/AOdZdYWEmPrVaciKwujwlHVzJJb/Xe1Pxs7fToMaTIPD2bMsrsT/NH0/I1VdUuJ5I1s/7pw7HdMw7L1qVqdbQo5K+NTVvJYVEThctOcmB8ne5YJrHwDsvKuEJO3566VjNzxx9EId7belFJUd5ZAlbS1uSd9cIbgVR6C3mY3D+FlN63i9OCvz6MMUmPQQW1ZPDCGAkkjgjftaTffS/Hn+4L9x9es86kRQYQLHUCAlLYoSJ5MN8TF/AAn4zQmXLYbpuu51WmqdtE7abJDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcVR8wcRzd7rqAneXAQMl2ph2Vw50Ksh3FmZ1KTj5NA=;
 b=uHgMn3M9t29HyZO59H8KA1dberR7SJWo+UZqgpBh1+029eDgChARuFrfePzXgzCgj3vYTjbaON1AiXol33MoitAT+wxuF5LC7lkYElWATvEA9aEIJ/skbPUlhN1CpSv0WYXfMKuTJXTl3166WBcwVNwVzcLcF+Q8LBDZJrcgXSc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 14/48] mm: Add temporary vma iterator versions of
 vma_merge(), split_vma(), and __split_vma()
Thread-Topic: [PATCH v3 14/48] mm: Add temporary vma iterator versions of
 vma_merge(), split_vma(), and __split_vma()
Thread-Index: AQHZKhwwxX9ewtOVqUOnMhRjb4uIEA==
Date:   Tue, 17 Jan 2023 02:34:14 +0000
Message-ID: <20230117023335.1690727-15-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: 0a2c0c48-2842-4dc0-abc0-08daf83353bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EBrJCP69SsxX5CJ0YeZJG/Knu+w7fQzJtOtFCB4D2LBmFTYwTGnD7oG8NfJisYbz5ZlZ6EHKaBqlqpPw4Fqeze9CCUq5lJgHthSdaitF31OL4/h/LMbAndCDP7ZztBEL0V28vrntLawFgM0oLiiepsmNMVi1vGkEADiOTdTS1k4tYsOKfYwqmmjgDSEeECsmY7NiynnVzCxrpc/FTzUZkKs3LTIqk1RuVyk/jiJ0IrTkD1TOKpbLGBFFt/XtOFB/z9KMiny5Y2+TTQjl6Tcwh2MQFKtnur/IANhObQE4XPwSiVDx/mICg6KZcIRY4VlW2PTsFZ8SNRb60r+SlCVYet3JmeAbq5rGptRIbyUsiT3Wnw53f5Eke1XNRSHOhfdAgyher3+cDxvOhJxKEgKiN2wnmR/oCI27u/T+fBzNiKCFVIT8eBnxcWrw1OuMO74E5MpN8cEmPC6MnhDNCCUvE3ZGFKzLh2Q33bPWCC1hp34yclBmIAs+aZGCrLHInPTcGdo4uwhN5LmtwPfarOUOk4zpjAnTRfe7b8icOYSwI7ov3fDe0KkTREeq+IGb5Ur8CJsdgHm2pJAFfc/yuHcLLVZua3xUuGBNcYX3sc4CPFMJcvkxl+tre6qMniqxSb6l18Aab7xv7xVTBr3jFQT3EicyHfplhKKSMg9cLGJimrp6R2E8fbrLqk0k5zsLE3sD3j2khLUuNEVwmoikFfqrHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Pmo77gmQlUQGomf5q4+Ht3IEbl1nidTcK7x8+L2xBUULbV2VKWEjWjsRxD?=
 =?iso-8859-1?Q?mFcGKYu93oXIfQe0BbyLV71oKJwj7RD62138Y47BhO7kpZkuq2hRq2mgFh?=
 =?iso-8859-1?Q?m6+BJtSLrFjZDC3fIUU1cXHrUnXvD3M7nH700/SBz7ygtdR5PUe0NgjLDQ?=
 =?iso-8859-1?Q?E5/KEVAk4qz7uGEs3kgyJ4C1NVDf0k/1qvGuZccVr4UE2prWMNzjgu+f+f?=
 =?iso-8859-1?Q?UyDiGJ27eJpvBRTPqFrg5y+vaDptMuRvFZWpgHzMzRrrBW4jWIxDWX/cj1?=
 =?iso-8859-1?Q?qGb8AgKDVz+4UEJEaBFVy0JqL6RDIh0paZSpVXrdWA+JJeH9hEXyZ8mKVN?=
 =?iso-8859-1?Q?Ua1vW+yOar6Ff18YqVrtQ+hlISbGPkD7i8jemIt7KXd6Xe5Ov9oLvKJugp?=
 =?iso-8859-1?Q?EyymJ1/cEqu5jc7O1jzgGL76DDMDQzNlbsFPjFyDuIQa2D/SIFSJm1qI6z?=
 =?iso-8859-1?Q?WQzVUhK0B0ebvS8Co1OgGpFy6+9VmRDuexKNiXxXA7QIWITKK31LnrOzAC?=
 =?iso-8859-1?Q?Y8ZPq+68FO1e6KQtdMtlrx7ioJlAq2XYHedI/IkhAGBRqeXTePVLNyOh2N?=
 =?iso-8859-1?Q?ti9Z5UJOc2zj81i+nSa1abFuTel5adQU84of0UtTAm48oLwWyvQKnAu1EW?=
 =?iso-8859-1?Q?zfbQJkJeEqZNK+kCv6T9y09XULJrZe/PE/y/g9KExclLhP/xBYJ7VkTkQ1?=
 =?iso-8859-1?Q?k7Mh2pPuz6UipVL7wfeFGJQWvhl298IJIzPgDlR32ADyaaJ85Uh0x3Vhux?=
 =?iso-8859-1?Q?i+LC+iwpV0iH+xfHTM0BPoWHgPZtfhfGDZt1W9puRgIN68/yZ5gTZf/Eg6?=
 =?iso-8859-1?Q?UkmAutVxHs0vPZ3K/MAMk+pB2p3RCggzyO20qanT4E+PXvnfkOwLxYctdv?=
 =?iso-8859-1?Q?J8UV2qtP7tOX0AGMzNlVw75G/rkOh+CZjEoUJ5qTevzM0GKSRu3eLLWoiE?=
 =?iso-8859-1?Q?OYP1+6Y8DMoSJ5A0+pLJImpC39w0Kz+p6kuZxB+xUihfPHb73ZG/sV6UM6?=
 =?iso-8859-1?Q?zuf/OBXoqx0z5DebSueBArIR0PC6pyQGtDmS86DIovlNsGJalhL04wldhJ?=
 =?iso-8859-1?Q?t9CDY8fFnXxEclClFCZGVBuViRrda/y7IJ3M62GZt03B7j4aEixhdd2Fct?=
 =?iso-8859-1?Q?1ksBkwm4bl+Jpwz13X6cBf+9nmp2zOrorHtZVrOyrPrAi9eF32ZdZhd3/D?=
 =?iso-8859-1?Q?4Hf0xveQ5POvvESF/dkyf4b1nk0k+kaNL9f+nt15PC9csHNahIF6BMGKDZ?=
 =?iso-8859-1?Q?gbuCwuFXDlDe2KloEzspNWmWKbT24x0dOP7cGUkS5VU9wjZJYBnfgj9NjK?=
 =?iso-8859-1?Q?vO7ccHP6zlh9TPXsfcaNYgcxFRIHGR27msp1egc5zu6vDvjPFh4UfjHkDO?=
 =?iso-8859-1?Q?vmeEvrZLnCNNLQelshB5RDJmxsQKo5uSJgQDLVhSeAFEjKQpzEzDYLfgzj?=
 =?iso-8859-1?Q?XV2zZ8nb5rCr7G/y/zs6CKJlmGPP1qOOEuCjns6c6FPm2ENS+ae86OwwTA?=
 =?iso-8859-1?Q?+pno9IgWfx+uuMu5D9f8kZblljxmbRmfji6Oy3nv/lo0aLmoiHWAn80tL/?=
 =?iso-8859-1?Q?J5r1KYNS838ulwDICgdkzPHLloWXKvaNdB8AU8uplVJL8JFZVdGZY1Q2YA?=
 =?iso-8859-1?Q?7MrEmg5+48Cp1K177bn2pBrHfS8w/m2EZ5QCtA9IGjLLegaRA6KXle+A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fiBQz+JRTKoedRtZ5v/nEpH1X+bUCM+uiBi4bMn1YXxiRL46yvvDOf2Log4MVDlyipFHcmCEIq4qJUom0N/XG2r0fDfxAFlR7bdxOQ1NFIJJ3/SOtKwyXFKfN9E0TnpChAFdL3iVCxkEgtJEB85RrOPTvSt183YpbCRxiRzDTAPHgipP48ODHCMSLJL9MTpIks/h/ekmrtQQngt5RLmVojQf1ze9P0MkhcFJ98yzjLTRsNUGUG3sdvfq7xfjwCnAHuBJrW/ZVHe4rRDSmUrDBJwaMNV2pvIjs6ckXSSVqRXBq3wWtS8v6gSAQ+ikmG0uUd+HSGf654JasLcCfElhCBaHWsS5tmtNG6Jn8v1tIhszHMWuhwW/GLfHVIwvnUSFRLy+UO4j203Ap5MrJIOYVQb9445F9Si5BXMZyNSnSjDJkdGFzYS7dRTpVKoB7yHtxWe50RwyQlEfEsYZPAxyN0AH67z8VwxePyyhrOE9+awYKRN67Dvm4gZoEJTui0v0s3071sJ77e7UFdiO2QH72otHQ/T1DTjfNatt6GTaBW8aGTEPkO50mhekvpWzJ94FPnWXzMwmTawaUd4+UuPHI7XGvia3yqD6QSszZAKVMAXn0BdOML/bKxnfvUumFLju30wTA8IC7m6i5a37deKpi4NjyAIcXb6FlFLu2pWzbFUgBI0aF0LOQux4lRve5C7OJwvetywiZie+j5eB1q/pIBJ9Fd5jrWbjTBZUlfbtCY2T/fOM6kaK5IAHYdmtsjJzAhFVbCQ2pMU/1udEz1kmlhANK4wiAkGvXIbqye0EvfLy46PW0NgAbs8UCRfjsJhcPdUpLQyfAM6wc1D2FbdZgtuLpQfJTSkE9mLa5wgpVBhUG1vGAWKvc3/PiLQftg6eVo8+dBr0+f8eUQi6whXRpA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2c0c48-2842-4dc0-abc0-08daf83353bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:14.6250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQmoyQKrsrnMoBbB2odNQUOr37IaHb5z14UTF4R5HzNfUFcvZx4k7rBfqHb4uPUdQgH9n3z5hFtQh0G7pfqTEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: dabg_I2fGpyz46I0xwjlc9-vZPsr1YET
X-Proofpoint-GUID: dabg_I2fGpyz46I0xwjlc9-vZPsr1YET
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

These wrappers are short-lived in this patch set so that each user can
be converted on its own.  In the end, these functions are renamed in one
commit.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 11 ++++++++++-
 mm/mmap.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 126f94b6f434..14e3698fcbe7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2834,11 +2834,20 @@ extern struct vm_area_struct *vma_merge(struct mm_s=
truct *,
 	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
 	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
 	struct mempolicy *, struct vm_userfaultfd_ctx, struct anon_vma_name *);
+extern struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
+	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
+	unsigned long end, unsigned long vm_flags, struct anon_vma *,
+	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
+	struct anon_vma_name *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
-	unsigned long addr, int new_below);
+			       unsigned long addr, int new_below);
+extern int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *,
+	struct vm_area_struct *, unsigned long addr, int new_below);
 extern int split_vma(struct mm_struct *, struct vm_area_struct *,
 	unsigned long addr, int new_below);
+extern int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *,
+		struct vm_area_struct *, unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
diff --git a/mm/mmap.c b/mm/mmap.c
index 02083b2cacfa..1fd6962f440a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1091,6 +1091,25 @@ struct vm_area_struct *vma_merge(struct mm_struct *m=
m,
 	return res;
 }
=20
+struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
+			struct mm_struct *mm,
+			struct vm_area_struct *prev, unsigned long addr,
+			unsigned long end, unsigned long vm_flags,
+			struct anon_vma *anon_vma, struct file *file,
+			pgoff_t pgoff, struct mempolicy *policy,
+			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+			struct anon_vma_name *anon_name)
+{
+	struct vm_area_struct *tmp;
+
+	tmp =3D vma_merge(mm, prev, addr, end, vm_flags, anon_vma, file, pgoff,
+			policy, vm_userfaultfd_ctx, anon_name);
+	if (tmp)
+		vma_iter_set(vmi, end);
+
+	return tmp;
+}
+
 /*
  * Rough compatibility check to quickly see if it's even worth looking
  * at sharing an anon_vma.
@@ -2272,6 +2291,18 @@ int __split_vma(struct mm_struct *mm, struct vm_area=
_struct *vma,
 	validate_mm_mt(mm);
 	return err;
 }
+int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
+		   struct vm_area_struct *vma, unsigned long addr, int new_below)
+{
+	int ret;
+	unsigned long end =3D vma->vm_end;
+
+	ret =3D __split_vma(mm, vma, addr, new_below);
+	if (!ret)
+		vma_iter_set(vmi, end);
+
+	return ret;
+}
=20
 /*
  * Split a vma into two pieces at address 'addr', a new vma is allocated
@@ -2286,6 +2317,19 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
+int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
+		  struct vm_area_struct *vma, unsigned long addr, int new_below)
+{
+	int ret;
+	unsigned long end =3D vma->vm_end;
+
+	ret =3D split_vma(mm, vma, addr, new_below);
+	if (!ret)
+		vma_iter_set(vmi, end);
+
+	return ret;
+}
+
 static inline int munmap_sidetree(struct vm_area_struct *vma,
 				   struct ma_state *mas_detach)
 {
--=20
2.35.1
