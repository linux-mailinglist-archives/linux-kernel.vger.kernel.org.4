Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF665F443
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbjAETSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjAETQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368A912A80
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:22 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITc6M025555;
        Thu, 5 Jan 2023 19:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5kGdcRd7sciAlJGxfOjIvnP/V/UXOl2Higa/J0aWF18=;
 b=tyNXV/Im981ZWU0hulPtGy/vYGB7owkEBVWYbDjB1ISY4XtUdz25pkExyrn5MUd4Ejpt
 dMoFZdq5FOG5tqph7ZPOYk4w2qeTXwzwjqJ9p0kNMX60231CTmJDxoyQ/RNUYuw+qCp5
 Wf4krvMIqcmHEQBxfNC4Q8tX/HHa+b5yCBAWxXUohU7zteBLpB37U8/7aiRvv8l2KQOf
 V/3Mri9z/xapto9hIV6nGQFTuzhmkpq9ckZ0i71pElTNYC6srObrKtvAAevwfdBqAiuy
 NLI1fQqAtyWH2n4l18vdZ7QVI+aoE4ahCDBU8Tbi8C+xZZDNYdmrptl9ElxSe7Qp0ARv Pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtskup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305HgaKX033879;
        Thu, 5 Jan 2023 19:16:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdtsj1fk-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A82YLN7LGpERBYbhkN5L4DFZe2qPTWCJ4ljuz94gAAISYLwIDDwBxctcocOzO1Dn4LAKnIMmUXiqE+/a9BANVaatYscEB4NbjASOD23VHpGYHl6PBsjtuSBpMlDSaUxDsEayqFR+fV4vz/meCqxCpRZE0VxPr+ZHYT8hh+ertt4BILaGkcVSZ5EhteiIbnsoZapcxj/ssMrGeSHDtgU0Xe2xhpbtMnLZnEiu41ETGbUUl7Y6U6P7seH7cVMUNeJpgDMTemtBZLjL+HrE6a3M5/cP4fqQhd5ZlN/dJogLVnJ7+6O1yWgSkVVJiWCeFwln2/5ufI6qzOQybliQFdEDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kGdcRd7sciAlJGxfOjIvnP/V/UXOl2Higa/J0aWF18=;
 b=eWADLKLJyRWAn8iLVxy1h5BRecZ9rn7Jj9Pq78xLuOBS7PWmYt7A2KFyn4FIDAp5S6ulG8G8P87+LLYVng22VurY77iLMTD35UJETOaDHdU9nHk2E2ali3/ZkwtDCYxIMR/prObEgScH7uopt/u6ab0P/Ud8mXQz7b/8HgYvGKVyWnmxPYzbwI4M6I/N7Oux794QBYoax1vHp/bK/c3o0zOU81Y5d5Vzj9znSxnozlJLDqpx8CLX8YjnsDNSVEWddNSPQsRzz/5SQXtPqzNACBckNHjs4Wk0Ki/GJrz3tOzaJ9PSqRKgmGUTSY7Qrk905FOLin09gTHzzeZl+kmlSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kGdcRd7sciAlJGxfOjIvnP/V/UXOl2Higa/J0aWF18=;
 b=ukLlbKbb5oOSb3NRq2NWN44/AQbmEKrKpTvlqZqOT5on9Ygco+mk9T9kqE3GVgidfI0kQ17VQCMh1j+eOB/28doWMWTN6FhHltoqwvhqvN4WOBmDtwE7ndgVwBDDJn9z3UgmKhv63SUnizPfBNujPCkcmPJx/3/c/jh+lz8Mbko=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 25/44] mm: Switch vma_merge(), split_vma(), and __split_vma
 to vma iterator
Thread-Topic: [PATCH v2 25/44] mm: Switch vma_merge(), split_vma(), and
 __split_vma to vma iterator
Thread-Index: AQHZITolqDVQ6iqu60KRVDrk/+ixag==
Date:   Thu, 5 Jan 2023 19:15:59 +0000
Message-ID: <20230105191517.3099082-26-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: 012c78bd-1eda-415d-5a4a-08daef514ad1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 960Jqa84OphLC8jG+cCtRRjZ9hXahCvTCKFYOJXszNP6lBihL+kZ3RAodhTDOGqqqJiNPeT/dKdRxxO94KeJnVRlX9g/xEvxEe404cehOuHRwBk759VazozMB3k6I7Vo/jODerhm9hUXblJmwrEbf1AvraF9/DrZKSKnq9qOUbWMkV343Kma46u7zGLIriactw4IQ/IPkfIsfwVwqaeVU3iNefDCuVAf9TP9kxhfU8gyMA2HCxbmCEy1N0sVEhfDw72zNBm74TCefVboZ3I/+5qnmSM75EET53n4rg2ESzlDtj/FEohGCtOoI0O4GfsunbQYI7VpMc+Z256YIMiRhC066Uu3U68KFdVsUVzog8Ybi6h4lNlI4CQOo3PLOt17Dt8NvZXC9W+qyhJuva5JRW/TiQ6naZSdnGflwlBUYF80z6qcR1HBbBzO/R3fqKKmw7DZs1lE52fxcM/0K27kVfabZi1KoF7XGkN86lw44b+kzR805+q7D1FN14fhVG9NNNrFQg8tluTQtyRWSgJWEByKyqVnNduTUBB1c2sGy9f89oeGv0k/mPqkp0dWz7leo9AZosULxTgtOotmsrFONt7tO16PanDx7Wxvc4BTfWpXwl1xof0KQdQsCAQ0mL1tM+alP39x2oBY47VoS5aUCoSQ8Zp2h6l+wH2q1Vr77w3aHgWTPrZBB+l70lCb/kLwMI4rETb14iavVQHsqxTrMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(30864003)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L2HJB+zkQCWG3uQObULX0MrJ+JJ1YOU2/Ty+fwp3wl0cx1GOkGy9L2U7a7?=
 =?iso-8859-1?Q?KQCVhA4u4/7UZA7Aq/VbhkUzSZ3Iyx8R7xzYji1J7YixR2mZntRJheuzzk?=
 =?iso-8859-1?Q?jTCe9zdgrAvTV9a+IJLX//eZXwWjDZUNZkqPnWe8mXlrBLCFfBcMZdo0s+?=
 =?iso-8859-1?Q?GOih6KIN2n8H9+R6bWEQa+ZjyEdAIbpua0Ea4EdVF9EdvqFXTUpKeTUawP?=
 =?iso-8859-1?Q?UwmptBZlqh2SqdG021s8ZXSxTVYts7xp6Rqck9dhJZWthbwF7zl8mq+7f7?=
 =?iso-8859-1?Q?mTt+rzgHTaJpa1m9898Kvt9xl6QEv4n/jcSQikjMXS/tTO09h+AzolH4Tf?=
 =?iso-8859-1?Q?KVl7g2IPTijFE+eIXO8qdw7J1InhMtHD3FXvYGYylZ3opBCrHgjEIF75iN?=
 =?iso-8859-1?Q?YVmWPXgVpkpNnH4XRSq/UmACVLfWqZwdicdcuPWK5azNsYo2H+unzujbGO?=
 =?iso-8859-1?Q?bK6K6ddyN2R9C2bKKj+MRRn+qa1ZATooOG7X3UFwkTGkfdEOiy+3HvQH23?=
 =?iso-8859-1?Q?F/EPGUAlKBFTduZBe7sfEJYbMgg6bAt3/jkrODPvri9MNpYZJLm+fe0bgU?=
 =?iso-8859-1?Q?bUn0Dd63lUZpgaMDXluRgPoj8oE+P/MH2ah11QU9+kXwfkV9/+7J4dmK2t?=
 =?iso-8859-1?Q?HfTYGLVaQnF6F1Z2B9s6un65+t8rKd7ZEsrPe/P0PTJTjAZOm/Qd5wDbGR?=
 =?iso-8859-1?Q?CTYVlXTGWKBqiSVtnoiIAmpz5DDdbj9I8qGBQlXIr7e9EuIQauqN6ac8l2?=
 =?iso-8859-1?Q?ZjavxCKkJAQGyIlLZ0/F1Azti3726OnywwKyizSpwODP54/jm3MZWty91Q?=
 =?iso-8859-1?Q?nxyq7BmxLjAoLnzmO+8O+s8dskrfXjUT1jeSR+Rj+W+UrzbfXKG6fTHD0p?=
 =?iso-8859-1?Q?hwQlQL6TDkWrvLdmjiasiXXh5ieTryGYnmv0JQC+P2o7kW+/S4e8mfjKrT?=
 =?iso-8859-1?Q?MYQLKzXFOwmTC0+d+80VEmXcmOUSJxo8C+4QavzTYRtNxvohJqp6XNAPST?=
 =?iso-8859-1?Q?9BkJhiZvFCln1IUm7x4UcNBzIgz90/kCe3+WfYRhxOF1KoQdDCc7T4OZ+k?=
 =?iso-8859-1?Q?I01OIqc3ZMVnKIJfLb5CDxZ+1V+o/3Epn84AXC8PtGWp4ZlTMkq2HPpOp7?=
 =?iso-8859-1?Q?1uiEgEkp1/AT/sNuXzvK8f9BqQQWQhg1pOIZI0q/UYQflJ2uiDl2qTuniP?=
 =?iso-8859-1?Q?85fxsTNV52la/3jow/VKPqclxL9tmTlH9ldEfHMmVnh/UP/51x5SNmCW0C?=
 =?iso-8859-1?Q?8act8LtdKJtg+CRcv0gPxAfAGXozjqwWrQapOiFxc+RswlP9aPROXJQW2h?=
 =?iso-8859-1?Q?+b00uzPq+Ju+p5JAE4Yu+xn7hqFz9dMfIbcWOvHfYhe8R6rc9wia71jWSk?=
 =?iso-8859-1?Q?d5MN1ISjA2anjQtwyHTsZrDNFXI4N6dqsVqEwYQImrS4Q+xSPmliyhkwbV?=
 =?iso-8859-1?Q?oUiQaDkjwBph61DcY5scoMnUP7fbbbAbbAuJ4f5QF/Y6rKxQmIYMmdZAg7?=
 =?iso-8859-1?Q?3cPz7RLxwVu5IbvKDiAKMsxW01//BPCOCnLrsv39ppq6WACC8y/KKuw0p9?=
 =?iso-8859-1?Q?X4D5a9Kml8z/CooGnQVVFVTrq3Lp5V7pRAFC2bMGKm3E20k1qybsP99LOO?=
 =?iso-8859-1?Q?knjTuWRcav5GmO/p8VADNPPesegnNBqXGCoSP0M5FaAlcAsHAxvDmx2g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: A0Xr/xaOdou9Pnsa4jDHypS1oLSNllUtI7ErD0xOkuAFFu4l5P2IcYGz5SWTstDf76DJkGw63zljM4ONjX1ZSd/uAN6EMN/aVGuizbCo7zZWrlGWEqlhNFjlVbwMd0fqPaW1R67R/LCBt3TUHiu9f/k3hHlDbPE6yGLyIEcBjPkqPknhIfUry/gmmvHn/ne6heOgUHTbkIOmPQ/rauwiaJeakYoIRbJUMF7letaLOOztZbIsi+eE2gZsmO67jOlMpxo/G2Kz41C9Rk4duPPhe000JsqEKvXOJfCU8M+mw+W2P0EpTRyYWn4Ju2hu87YCk1FBO0JD3QV9MVpsfLmyCtMrE3uaKHNAeS6CrKUdK9gF/HxuTBg+sHDsIA4wutPQYntPb/8uCVKNcI9gl8Os78Qcv3vx+CUcHQVBDTnk21pBHh2jZ9zsda8xPWZjwvaTVOF+lQdUv+5AQeX6EDoZbBu1onlxfSiAnp18yfjAzb4tGYY+DykX6MTren4goouIyodkT2/faaX+CCMprLhx9afM/jjz0DV7uL54D1fSDZMSehwj2HlnL+cHV227N5d/De+5xttvIbvadHuNmtpQNub5Tf7Lxx0CLBOkpZ9UJeWG42SbufqOMDLBx4f4g1xb1RLsBCwl9C0YghRXlSff3gQtx0X4sF//kKRRcNUkXJUJcMpOhig3dxI7SiHpR/F4O2FPRhVRoE/QVm7n1TFyLEZfCCDeREk3rZZ0tuS5T13yxLBfzNgDjvwT+7f7yVqfelwhtXHzdkPRz+Gqx8x6Bb6dfTZSP90ZYTDXi6Ie0xTBWq3G68Q1Mjd49/JbfI2bOxi4GIGnn8Ib1ADRbWFdegMX6FAFE2jmeYZB0lWvWkQtNqV9SNKsUpErU1o4P1NAwG3eDLpE3RFVRx6St73Juw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012c78bd-1eda-415d-5a4a-08daef514ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:59.9536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Twul6XlGQUEUX8UNS8bx4XXWSA7XjdbiB96kpuNtdfeZ65OYNbcDzXVy9wosjjkCXCNA2xduZnfMUKoOjFQ/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050152
X-Proofpoint-GUID: Mdv2uLMEXro04nBYKkNeJdPwMBbLvRfb
X-Proofpoint-ORIG-GUID: Mdv2uLMEXro04nBYKkNeJdPwMBbLvRfb
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

Drop the vmi_* functions and transition all users to use the vma
iterator directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/userfaultfd.c   | 14 ++++----
 include/linux/mm.h | 16 +++-------
 mm/madvise.c       |  6 ++--
 mm/mempolicy.c     |  6 ++--
 mm/mlock.c         |  6 ++--
 mm/mmap.c          | 79 +++++++++++++---------------------------------
 mm/mprotect.c      |  6 ++--
 mm/mremap.c        |  2 +-
 8 files changed, 47 insertions(+), 88 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index b3249388696a..e60f86d6b91c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -883,7 +883,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 			continue;
 		}
 		new_flags =3D vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev =3D vmi_vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
+		prev =3D vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
@@ -1426,7 +1426,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 		vma_end =3D min(end, vma->vm_end);
=20
 		new_flags =3D (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		prev =3D vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
+		prev =3D vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
@@ -1437,12 +1437,12 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
+			ret =3D split_vma(&vmi, vma, start, 1);
 			if (ret)
 				break;
 		}
 		if (vma->vm_end > end) {
-			ret =3D vmi_split_vma(&vmi, mm, vma, end, 0);
+			ret =3D split_vma(&vmi, vma, end, 0);
 			if (ret)
 				break;
 		}
@@ -1606,7 +1606,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 			uffd_wp_range(mm, vma, start, vma_end - start, false);
=20
 		new_flags =3D vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev =3D vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
+		prev =3D vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
@@ -1615,13 +1615,13 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
+			ret =3D split_vma(&vmi, vma, start, 1);
 			if (ret)
 				break;
 		}
 		if (vma->vm_end > end) {
 			vma_iter_set(&vmi, vma->vm_end);
-			ret =3D vmi_split_vma(&vmi, mm, vma, end, 0);
+			ret =3D split_vma(&vmi, vma, end, 0);
 			if (ret)
 				break;
 		}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 98c91a25d257..71474615b4ab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2830,22 +2830,16 @@ static inline int vma_adjust(struct vm_area_struct =
*vma, unsigned long start,
 {
 	return __vma_adjust(vma, start, end, pgoff, insert, NULL);
 }
-extern struct vm_area_struct *vma_merge(struct mm_struct *,
-	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
-	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
-	struct mempolicy *, struct vm_userfaultfd_ctx, struct anon_vma_name *);
-extern struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
+extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
 	unsigned long end, unsigned long vm_flags, struct anon_vma *,
 	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
 	struct anon_vma_name *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
-extern int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *,
-	struct vm_area_struct *, unsigned long addr, int new_below);
-extern int split_vma(struct mm_struct *, struct vm_area_struct *,
-	unsigned long addr, int new_below);
-extern int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *,
-		struct vm_area_struct *, unsigned long addr, int new_below);
+extern int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
+		       unsigned long addr, int new_below);
+extern int split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
+			 unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
diff --git a/mm/madvise.c b/mm/madvise.c
index 4ee85b85806a..4115516f58dd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -150,7 +150,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	}
=20
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev =3D vmi_vma_merge(&vmi, mm, *prev, start, end, new_flags,
+	*prev =3D vma_merge(&vmi, mm, *prev, start, end, new_flags,
 			  vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			  vma->vm_userfaultfd_ctx, anon_name);
 	if (*prev) {
@@ -163,7 +163,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	if (start !=3D vma->vm_start) {
 		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
 			return -ENOMEM;
-		error =3D vmi__split_vma(&vmi, mm, vma, start, 1);
+		error =3D __split_vma(&vmi, vma, start, 1);
 		if (error)
 			return error;
 	}
@@ -171,7 +171,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	if (end !=3D vma->vm_end) {
 		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
 			return -ENOMEM;
-		error =3D vmi__split_vma(&vmi, mm, vma, end, 0);
+		error =3D __split_vma(&vmi, vma, end, 0);
 		if (error)
 			return error;
 	}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6f41a30c24d5..171525b0c7a8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -810,7 +810,7 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
-		prev =3D vmi_vma_merge(&vmi, mm, prev, vmstart, vmend, vma->vm_flags,
+		prev =3D vma_merge(&vmi, mm, prev, vmstart, vmend, vma->vm_flags,
 				 vma->anon_vma, vma->vm_file, pgoff,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
@@ -819,12 +819,12 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			goto replace;
 		}
 		if (vma->vm_start !=3D vmstart) {
-			err =3D vmi_split_vma(&vmi, vma->vm_mm, vma, vmstart, 1);
+			err =3D split_vma(&vmi, vma, vmstart, 1);
 			if (err)
 				goto out;
 		}
 		if (vma->vm_end !=3D vmend) {
-			err =3D vmi_split_vma(&vmi, vma->vm_mm, vma, vmend, 0);
+			err =3D split_vma(&vmi, vma, vmend, 0);
 			if (err)
 				goto out;
 		}
diff --git a/mm/mlock.c b/mm/mlock.c
index f06b02b631b5..393cddee2f06 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -418,7 +418,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 		goto out;
=20
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev =3D vmi_vma_merge(vmi, mm, *prev, start, end, newflags,
+	*prev =3D vma_merge(vmi, mm, *prev, start, end, newflags,
 			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*prev) {
@@ -427,13 +427,13 @@ static int mlock_fixup(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		ret =3D vmi_split_vma(vmi, mm, vma, start, 1);
+		ret =3D split_vma(vmi, vma, start, 1);
 		if (ret)
 			goto out;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		ret =3D vmi_split_vma(vmi, mm, vma, end, 0);
+		ret =3D split_vma(vmi, vma, end, 0);
 		if (ret)
 			goto out;
 	}
diff --git a/mm/mmap.c b/mm/mmap.c
index 579d586e4e6a..8e7f4fc36960 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1072,7 +1072,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsig=
ned long vm_flags,
  * parameter) may establish ptes with the wrong permissions of NNNN
  * instead of the right permissions of XXXX.
  */
-struct vm_area_struct *vma_merge(struct mm_struct *mm,
+struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struc=
t *mm,
 			struct vm_area_struct *prev, unsigned long addr,
 			unsigned long end, unsigned long vm_flags,
 			struct anon_vma *anon_vma, struct file *file,
@@ -1081,7 +1081,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 			struct anon_vma_name *anon_name)
 {
 	pgoff_t pglen =3D (end - addr) >> PAGE_SHIFT;
-	struct vm_area_struct *mid, *next, *res;
+	struct vm_area_struct *mid, *next, *res =3D NULL;
 	int err =3D -1;
 	bool merge_prev =3D false;
 	bool merge_next =3D false;
@@ -1147,26 +1147,11 @@ struct vm_area_struct *vma_merge(struct mm_struct *=
mm,
 	if (err)
 		return NULL;
 	khugepaged_enter_vma(res, vm_flags);
-	return res;
-}
=20
-struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
-			struct mm_struct *mm,
-			struct vm_area_struct *prev, unsigned long addr,
-			unsigned long end, unsigned long vm_flags,
-			struct anon_vma *anon_vma, struct file *file,
-			pgoff_t pgoff, struct mempolicy *policy,
-			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-			struct anon_vma_name *anon_name)
-{
-	struct vm_area_struct *tmp;
-
-	tmp =3D vma_merge(mm, prev, addr, end, vm_flags, anon_vma, file, pgoff,
-			policy, vm_userfaultfd_ctx, anon_name);
-	if (tmp)
+	if (res)
 		vma_iter_set(vmi, end);
=20
-	return tmp;
+	return res;
 }
=20
 /*
@@ -2286,12 +2271,14 @@ static void unmap_region(struct mm_struct *mm, stru=
ct maple_tree *mt,
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
  */
-int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
+int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	int err;
-	validate_mm_mt(mm);
+	unsigned long end =3D vma->vm_end;
+
+	validate_mm_mt(vma->vm_mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2331,8 +2318,10 @@ int __split_vma(struct mm_struct *mm, struct vm_area=
_struct *vma,
 		err =3D vma_adjust(vma, vma->vm_start, addr, vma->vm_pgoff, new);
=20
 	/* Success. */
-	if (!err)
+	if (!err) {
+		vma_iter_set(vmi, end);
 		return 0;
+	}
=20
 	/* Avoid vm accounting in close() operation */
 	new->vm_start =3D new->vm_end;
@@ -2347,46 +2336,21 @@ int __split_vma(struct mm_struct *mm, struct vm_are=
a_struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
-	validate_mm_mt(mm);
+	validate_mm_mt(vma->vm_mm);
 	return err;
 }
-int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
-		   struct vm_area_struct *vma, unsigned long addr, int new_below)
-{
-	int ret;
-	unsigned long end =3D vma->vm_end;
-
-	ret =3D __split_vma(mm, vma, addr, new_below);
-	if (!ret)
-		vma_iter_set(vmi, end);
-
-	return ret;
-}
=20
 /*
  * Split a vma into two pieces at address 'addr', a new vma is allocated
  * either for the first part or the tail.
  */
-int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
+int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	      unsigned long addr, int new_below)
 {
-	if (mm->map_count >=3D sysctl_max_map_count)
+	if (vma->vm_mm->map_count >=3D sysctl_max_map_count)
 		return -ENOMEM;
=20
-	return __split_vma(mm, vma, addr, new_below);
-}
-
-int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
-		  struct vm_area_struct *vma, unsigned long addr, int new_below)
-{
-	int ret;
-	unsigned long end =3D vma->vm_end;
-
-	ret =3D split_vma(mm, vma, addr, new_below);
-	if (!ret)
-		vma_iter_set(vmi, end);
-
-	return ret;
+	return __split_vma(vmi, vma, addr, new_below);
 }
=20
 static inline int munmap_sidetree(struct vm_area_struct *vma,
@@ -2446,7 +2410,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			goto map_count_exceeded;
=20
-		error =3D vmi__split_vma(vmi, mm, vma, start, 0);
+		error =3D __split_vma(vmi, vma, start, 0);
 		if (error)
 			goto start_split_failed;
=20
@@ -2467,7 +2431,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (next->vm_end > end) {
 			struct vm_area_struct *split;
=20
-			error =3D vmi__split_vma(vmi, mm, next, end, 1);
+			error =3D __split_vma(vmi, next, end, 1);
 			if (error)
 				goto end_split_failed;
=20
@@ -2748,9 +2712,10 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vmi_vma_merge(&vmi, mm, prev, vma->vm_start,
-				vma->vm_end, vma->vm_flags, NULL, vma->vm_file,
-				vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			merge =3D vma_merge(&vmi, mm, prev, vma->vm_start,
+				    vma->vm_end, vma->vm_flags, NULL,
+				    vma->vm_file, vma->vm_pgoff, NULL,
+				    NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -3297,7 +3262,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
=20
-	new_vma =3D vmi_vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags=
,
+	new_vma =3D vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (new_vma) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 7e6cb2165000..057b7e3e93bb 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -605,7 +605,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gat=
her *tlb,
 	 * First try to merge with previous and/or next vma.
 	 */
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*pprev =3D vmi_vma_merge(vmi, mm, *pprev, start, end, newflags,
+	*pprev =3D vma_merge(vmi, mm, *pprev, start, end, newflags,
 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*pprev) {
@@ -617,13 +617,13 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_g=
ather *tlb,
 	*pprev =3D vma;
=20
 	if (start !=3D vma->vm_start) {
-		error =3D vmi_split_vma(vmi, mm, vma, start, 1);
+		error =3D split_vma(vmi, vma, start, 1);
 		if (error)
 			goto fail;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		error =3D vmi_split_vma(vmi, mm, vma, end, 0);
+		error =3D split_vma(vmi, vma, end, 0);
 		if (error)
 			goto fail;
 	}
diff --git a/mm/mremap.c b/mm/mremap.c
index 4364daaf0e83..00845aec5441 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1034,7 +1034,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 			 * with the next vma if it becomes adjacent to the expanded vma and
 			 * otherwise compatible.
 			 */
-			vma =3D vmi_vma_merge(&vmi, mm, vma, extension_start,
+			vma =3D vma_merge(&vmi, mm, vma, extension_start,
 				extension_end, vma->vm_flags, vma->anon_vma,
 				vma->vm_file, extension_pgoff, vma_policy(vma),
 				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
--=20
2.35.1
