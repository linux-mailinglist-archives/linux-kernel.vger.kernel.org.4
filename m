Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93DF66D469
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjAQChC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbjAQCf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA1D2A9AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:34 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09eKV006596;
        Tue, 17 Jan 2023 02:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jdrqLITjgM6OCw5/BFOTwwt/x4Bda3oztOTO3t+P8ro=;
 b=VUWWe7MKuIpMoKMdkPhWOTyD5iPSEPQNnCa2AAkOO4yFQ3WmC/S+U2u1AAmPNSyJliyc
 6s2CDcNHyZv53BXHorhmIVsfyhAd8tbmmS87YqkSJ/d/1q3s8KdAOg7rjINazhYHdNRO
 0/ZIJnqI7U008S8m7nokcy9K/YypzoHaS11Z/em9DYxY75ywNTDNiSL9+0vN+81uLaz0
 AVKoVKqff8IJHzZblsgN/2Z9AMaA73NyVPNGF/t9qQc3mLxBqrjQXtOJ0l6GYREdc5rA
 p/E9dS1wLYZzWpoBtQhwbTCrNQFWBeJdUWpZ+UJpolmZKlcD51NRtYcoSKIzY8F4di4w rA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaabrjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNUM0a004833;
        Tue, 17 Jan 2023 02:34:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10f0-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/2gWuTKzD6eBkLUgaCiDFUqH4CyR7/qrzXQeH6Y8gPVa30W9zpj8u5PUWCMRFenCdWWEkZdjlRfkweT/w7t2oZbNr3j2lckVLJ+3UbeelgM6cZuo8ta8hpNQBdN+ryMEIFznVZQ8DohRyEZutW6ppNDymb0YMbPTJ/O61wmxs+SnsYCtBR/r4EDeyQty/vL08hH+uWm+p+0xIhnFgM6RyTiupEvzfVjBF12JDw+P+zUJqHw60Zs1MOK7Udtboh6qZAtpeZJo+R86pC7vrqJfgp9cZeZ9DZ39z0zZ1tBQ6XMZjnwi5duBxehRqU3MTtCoqJ22SYVOd0tk8uHqI1xAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdrqLITjgM6OCw5/BFOTwwt/x4Bda3oztOTO3t+P8ro=;
 b=h3J8K+3DdS2FjxlOwdSESzr6WB2LdfcQZ334w4GwHIunvAdPM9sZibCgjOf+A9egtwhVCnbu1LA5YTwTDXWt58fOAOLQy5749AfHAWQXmCzupcQ6kZ/CmVe9n7pyvCpAM+xFzQEM2NQIsx2FWra7fmmKS15ab7zs43xeI64HqMTlBgM3yZZG0cFUcwmYWnlCAP2LhoJrHrCX/A6JYq3X95ETv9FMyu4SL+A135aWK8Daqdzm9fZrmC6+yneiztzjCVJH/WSJn0it6rS6Tc20D5NOh/7TIjMQbzsxRzi5BGEByHFg05yXb+OLC4gR84g+8ZOHZ1koJB6LMpI21wIHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdrqLITjgM6OCw5/BFOTwwt/x4Bda3oztOTO3t+P8ro=;
 b=BUdsB3brE9TdoUdWlPmDFqM9A7eU5DDnIkidTew7ilz1vdlRE9zIglPsafiatZzXF+xwl48Z+w3jzL8AP2tmfjWLBJYI31X8AI2MMcJWoW3iGGi7f1uuEFQX8J+3gHH8ZIM/mtJf81tn+dqiY2BP8tWn0UZt75nS+IVHUtIEp/8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 25/48] mmap: Use vmi version of vma_merge()
Thread-Topic: [PATCH v3 25/48] mmap: Use vmi version of vma_merge()
Thread-Index: AQHZKhwyJpWl6Xvxs02znexMfpYYWQ==
Date:   Tue, 17 Jan 2023 02:34:18 +0000
Message-ID: <20230117023335.1690727-26-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: dd2ca94f-2a41-472f-fbee-08daf833574b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ueaT/y66em9c5d7dtL7Z4x9QDBoQYQvzDJqpadLqkPAwp17Jc3G72rR5Is8iIG+astjWQ+L+8yXgQYtx2GFcU51IV8Uw5rLn97qj1GO59oYTfX6VDI2kiBfHwGCb5zhAwTndsGdPz1vIusJ/AlCx/+bkbH9sbOvHcUZ3kEUckjumKy/5At361fSqeske7Ewa9KCVENVZz4aq622dvQHZBywuOyNFghc/UbEelLfCuBSOK+R6KZMkKsTDZDufH3ma4I37Ef9TMZJv7C2MdAxEQFM79GL5ksQ6o8B4oOrJmKJ6qHwHS64/y6ZnoX/zEVDqqkJpGJj8sykCpLLur4zPDKF7U1Y6wlTrqibQX94MUeN/Bj8YWIK7x8a/X7oLOa8+pApyzuiR8QvGqlrNwuvkp14y78m3B/cYZ8rxd/9D4WC3+5EuqNjBJi5gKv4P/mkNPrnM62yOwkmnIbI9eLRrdJqVzH3GkMhsg5wgK+elWxAd81zuQJpXXp17Agk7Tw/GZmfRXs2/sovR+ZPkaIHKjg5m0BjyyimUmqECywae+TyTbrTryJP10UKOLTvVUAdSLkK9Hz1R62TPmHafHyjF13WOgs9E8ybh2qoOOh75pvao+fXb0GonGG0MYyVtjNrAJKNCXGrXPpgoi5G6XGlQmpR9maDw/sa0yNla/DGdBsfkK82N+ZBhW0c9BWm+DyyQJ/cc3JhNFLCyr846xFzJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+IfDJ0BK+CEmSy8q8qoZv4nUDUr2mneFKVvYK1kCXUnhKihBkGLmZ9UFY6?=
 =?iso-8859-1?Q?afiLdGPH6mFfBEIi3HF5XyrUSaebyby82Dn1wn1LW/gD0B3Bu8u2JcZWKd?=
 =?iso-8859-1?Q?rwjE/G2zQFCYpzK82xm86Y+P0VoLYb8FLP6ccnJm67JnoS3krpexs+T0yt?=
 =?iso-8859-1?Q?Cln8ZqgQmCIQ8BIpIKE61D8geXyFfqWRTpkIJNQWiUNftd+ISrGztMZM5b?=
 =?iso-8859-1?Q?zLOvTrk+P6w0SzHQFKWf/+ZwTLCKMe93Szxy5PZlfdg7+QLmxyO4XvcfgT?=
 =?iso-8859-1?Q?IF/HHmkV1X20nYQ8cND0ozCl6HLHQplzufkrwDfLYhh5b+f21iTRVVHd91?=
 =?iso-8859-1?Q?yxQMA2BJp3f4SSFbAHtvug9TjS2A7O+4nkiq8zI6XR+gxq986595vPn1l3?=
 =?iso-8859-1?Q?6YAmTYv1AOPyu7U2E0egWy4CTA2rG/4KXio9Jo2eiLQUet6O9D5Ib3Hsr5?=
 =?iso-8859-1?Q?sWnPE2k+hYEjHXovIdqsKJy97xgTF5pncuat7LqMQYKZ9cgJh1/KTEYB2h?=
 =?iso-8859-1?Q?q9O15e8TFBfwZTY2R1WXng1LG6plagaVWXqiM3/HEPgrMNmoIksK4CocnW?=
 =?iso-8859-1?Q?of7OhdI5uZ+Lk72Bn0X0seYAPQzw+iJjHjsDw36qAredhvoMi0VDGQe63l?=
 =?iso-8859-1?Q?Y5wjZuhnvWWAtJZK+HWSGcGY+o8IFU7HnPc84DC7QUcoC+ALphbs5wl6Ia?=
 =?iso-8859-1?Q?CgTyGHWNTNf3aOz+TvZAgdQZUdRurVRXZ8/R7ZX1bl7caUWNUE3UPGEDSw?=
 =?iso-8859-1?Q?gMBhMe3CvpSRZ0U+dM3YcgntVr/Z6uDdkWZb3ZIaD3HU01ikMitaTQ+FMp?=
 =?iso-8859-1?Q?iIP+mL4huS+jIGoQCo7Iws1QVvfRYimNKCX6ENlZJsLq3lkWcA+FsXw61R?=
 =?iso-8859-1?Q?D9nmDHxvHBSGVGX8JUumUImc99PdoqmqctTlrrVVP/8UHcrs0Sz8ajmlL3?=
 =?iso-8859-1?Q?a13qL+ddQk8BptH1zZmimp3qjlGujfUI2YFfkkAdZyJ3UB6f0V8LUJ7Tk6?=
 =?iso-8859-1?Q?289N0XeKduTFNZD8tCBriN6vcd+3h6aByQLKm4Fadxb1VaQAM1KCcQiyUY?=
 =?iso-8859-1?Q?L6UqrIbh6xfJq/4uZhzHdXkeKScGenv4oAH9/Amwqb9Wfjyl6ooah9O06m?=
 =?iso-8859-1?Q?7yVXvEYxan7phOC3qK5ajETNKR5oQmdqwP1DbrZ48b6KTOWZQcLSC8o3+5?=
 =?iso-8859-1?Q?8hVLenJaeezD0ISnn4wi/Omv6qE4OMju0+i42CocJUPdYunJhX7Fq2CxIn?=
 =?iso-8859-1?Q?Kl/S0jomo4XXfxwY90hTIRftJkH8aY8f8W1XhKYdGRSpRlHGutvwEvfaZU?=
 =?iso-8859-1?Q?i+sRvNSqUESwbfh2cc21ptO56whEKqRg1opH1PNfhM41RZiqAtLcddvHgO?=
 =?iso-8859-1?Q?0Wq1OhZyjCNtcyI8JWayaY/s6zJ0XWJWRKFMf5Zjws8Hc7rfNyj4WXTk9r?=
 =?iso-8859-1?Q?Qke3X0NbXASI01/58Y6FzVEtjCBBywRvbWaF95VMskTTuXFslTWj4psks9?=
 =?iso-8859-1?Q?wwTo4F7DOIqKf/t5ZKebRsXR5t3mv9YfSbLI0pKYaMECHw/WCDM3S8LxFm?=
 =?iso-8859-1?Q?9IVNipD3VXMjCnsmHwIVLx/t1/qVtL7AuZOecZTRZJH891ImlYXZj3xjlT?=
 =?iso-8859-1?Q?IcTTMYcWCAfbRs7FpT23gDjDyAdHKwNkIWosDYVhzZoSFSQjsGK4lILw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: piM4CbhMo0pozBSVsQFYR1M+qDwaHESBsKmRHsa+KdnP2Q7Tq6uvu7JERbAFK7V24YHGPbI2rsZLcYRyW4sKGh+Mfm5fXy+mYQBzc4QnNvmb43JeIYjhHcO008urrSNs/3bbSUJFBIHzyLC9XvBgveGeASesiH2gz3ncQU443Xb0I+tWYUXfrR2hUHksffS2x6lvt6I3r/s2U1UuDceGhpum3IIrCb477/Vig4CkMVkb5o05MXtkSQfokcRDEC7lQJ7YCkvQkzfRLSPSV8uISL/RQbDFm1PxBP46//Ni61ceQm8GHI8TMgZ6Lrweg8a71P99s/3L41OBwaSfFlJYAK+/iEcV9K+QSC4861u0V0fbTGQlxPTwkynhhF9n/k9J7GAM8NbJ0y+lGUOkGkS/cqn+jKzAs8f0JM/G/OL7L3oIFaHQCQU7iRZWU6THGgMWjzBvrlWhOIavtcyBCQmOWdqLiL/dXO2O3+R0kbmk4UxyyvQWyAXuAR66GBwqc9/9umUz4LChIuONSzocwkDE9q9MvOnURDJWtEqPTEhZFLK5e3yfEJbD7z6DlUCWWfK++zPtHUVw2RIdlvlv2bQEGWfVGmkQbofM55Yfz/UdKrbJCUEAie1KPGokT/3HIpELGuuRTUQgJI8x+sHIN/Bv9O0q7naITW2ufkSpRfMe7qLq2JsxLqZpOfS6OJP1ap6fPCOYhxsHaaiQyqPDRDpo/0oZxrzZd4BxEulE8FzoKg+pYm7W2XF3QIpSk5Eme2HByGKVlmMNXpsnn5XM7vReJ4/1O4TEbdUZ35sEuZIAjb1xzaIr6kHWddw6zB5wk/G+9UV1DGrQ4BOL8+u46lobzPMoZL3HlKF0CWDe1ZDLbUIXjXN1ka4cfNwOFmgb2BriXLBwf1L+SaDxho1bOYg0Rg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2ca94f-2a41-472f-fbee-08daf833574b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:18.0623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPQOSgzxRj6rC5/8OthsUg3e2een+Xe47aRv/1BUdWa7P1ukMtP2NbvzgOk4Xxf6mRKsivBWNRZVBk++jSP7rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-GUID: 7g4ANzWHFrwqsC73_VBOF6jNxyS1QI3X
X-Proofpoint-ORIG-GUID: 7g4ANzWHFrwqsC73_VBOF6jNxyS1QI3X
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
 mm/mmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 530a58e88d66..8e83e174c1e0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2689,8 +2689,9 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			merge =3D vmi_vma_merge(&vmi, mm, prev, vma->vm_start,
+				vma->vm_end, vma->vm_flags, NULL, vma->vm_file,
+				vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -3220,6 +3221,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *new_vma, *prev;
 	bool faulted_in_anon_vma =3D true;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	validate_mm_mt(mm);
 	/*
@@ -3235,7 +3237,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
=20
-	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
+	new_vma =3D vmi_vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags=
,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (new_vma) {
--=20
2.35.1
