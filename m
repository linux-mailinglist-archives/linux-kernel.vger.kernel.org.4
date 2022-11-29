Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2148863C57B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiK2QqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbiK2Qow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C75EFB3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:42 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPitZ017353;
        Tue, 29 Nov 2022 16:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GOm614tl429iOQ+POVCVrJ+RGa5kuncI+Q8HcO7IgjY=;
 b=uzyUfyuwtkna79XCAvBNwagjfUlIOKEzMVWB4Sle/eEi3U6WiUBZ2u0fQhlM3LBXcryH
 L1k3zbQ4i7GXQqNZppeUdJfHTPtKMwKAXTGM1Pr+1ySZgtE5bCWmQNmXza0aZx7wGrGo
 SFTOZC57yx+SzX02QqAdCmA7fZdG9wbi4vGmRScDON11AdjokZbjOKw9wC/wF7otyIrp
 RAdaSh15aZcJx+57ntbM1iF+La4S5bk3tS0WGWWhnjwcpaXbB3quHI9E9RgE1GiNAwoa
 X42gM8WiZFFzvK7a6yZP7LSRVQgjHrDeboFFn3PHog58vK3/pP9ddUORUdCFZCyo6ge+ Gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xht6hmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPh027963;
        Tue, 29 Nov 2022 16:44:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9s4Sc5Lqcate3hz88HHjTyiPMD02qZwZEDi1Ym8IyaM5PWz3UK0+8tsvz/eFOh487F5Yygtk8XwKFibhFW1ExNcm17MkwY/W4fB3zNggj/tEsBF5aNex38mKNNHx2Z8pwDi9ERes7zWtiqZHg2us3NotxIlsmFunDGYswVw+Lu9Wc1EP63/GbNCurQK3O/72vB3eBrTjbe2V3j3UZBfwjpkpYeyX8YZVp3LBXCg0FaLzp2RCbzLChmGInwQ/x+XarTTbcnoLeA8+G33nvL9q6UNf1NRO6BQHGJx/xA8mxq8zzQ9CytJTjaZN52euqa3fINS6mzHRw9qkC2iN2fCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOm614tl429iOQ+POVCVrJ+RGa5kuncI+Q8HcO7IgjY=;
 b=Hwf/CbmXWUu9WTbR5HUV2v+vEnv3/igRdfwUi+XKwYgK61nb8qhMb0wf5cwaQFypfMfZspM0/l13YSVfykw37pn5teccixa9L5DYPPTarNnksynKmrrH4lRFd0WcCXQgW+1jS6WbYx1+NdtXT4jnW/SquBBUvRzlCrW3ern4MCM8RnF95V771xmXHy9BbfmTevSrBRtxLt87ru2gmVOb2PNGZjjoO+DG3H6x91aWgW3+xIiwSKmUrz1cXRAdqLw2+vyqMCBsFvnGWfQEu1nnylRzc/p1iNtpbGpOAUs68haC1xZ42/MUaM62BbFIrD3FYGvI9Naow6lBUmmBq91Agg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOm614tl429iOQ+POVCVrJ+RGa5kuncI+Q8HcO7IgjY=;
 b=rYtSisGYkvsRW1M9TN7zJpTpDgZQYuAInq5Kn13J4YbC8u4YDkt1hGW3IvIk2VZyVmrYzcBphnbbBNqLm/Z+gHld/NppmEb9ti/ONogawHz+SHr4l8slOzIOFjbDNPViXDerOqZVzDKU0fCPQBi3NtmPy9tneSCAnHzjGll4mYk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 16/43] mlock: Convert mlock to vma iterator
Thread-Topic: [PATCH 16/43] mlock: Convert mlock to vma iterator
Thread-Index: AQHZBBHYWjp8mhR86UCgc/OVUkasHg==
Date:   Tue, 29 Nov 2022 16:44:27 +0000
Message-ID: <20221129164352.3374638-17-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 4cbd0d5a-97d0-4cd3-e7e2-08dad228fb8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U7dwCBQkN7lv1l6lUM3yN8ENuknFr1J5PKkpTr7I/dse1mAt0/8GiUgF02peZy4+E2woHeAKIjT0xj3bQ0NOVzwF6RhgLEAU6KjXdYYbZBf27p3r7lxoEuAO0+Xullmyln7ALfsSDhEMPwrLPSZzoLZaYRis7qSgeJXAMelE520J/T22JiyNTefRuPXZjX29vTWmhuwALPqomUdJQTzJciB+4O+y/rVgdRZqwoXONd/cF/hsMgoBVD9ffENuY0R/P1upi+N8pOOiPV/sBx1MNnwUXgMb7/IW4Lu2cEK8t7vqHAihcM5E20XDi++JDxj81j1O7sYI1Le8woOhMnsi8iub9H9lO18jIzCs6bxBadU84YQk6Y9Q2k66nmeU5h/ev+kXwXjANKVIoxP/u7G5vZUceStdhHkV1sEnzB8UvQmNhfndN7pC2gVyNuVtuqhROYVY9BaPKR/os0c/+F7tPcRf0a9bGiT50slQYObPtJrh8vc0J3Yb1pUB3qWyjFNaHSFcpW6jBlSEE1kkdBYyYZyzU6VERVaFRxivlVvj06zq0ZwngPHXi3kVn4kScPPSHNrCNqTdFvDqZsQCNBmM3H5rlo1MFPScZVyToQIfumUet7BTOISY9pN0RxDBZ9I/1n1tUbWBJ6V6kE22ZMc98bOfGUv6urw8fmZgZiZjmmYQNg4IUGv9ZfvQp1Eht/gv60MTPzxT0vilTgIfSMCuig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PodY0m6F3HoV8S0FyJyWrqObHVS12bS+7fYmflISGbaN6zsruPvXF/EnC4?=
 =?iso-8859-1?Q?fTsc1FOJy3Rn+pm9VRVzrHwus7gLMjO/7B5xr3OLjsI9DbA2acpKwrfRt4?=
 =?iso-8859-1?Q?jBPyyeqR1yz57T8ubBbHIb0WHv3ydl5lShPHwPLjRKMCWwbY17GehT1Nkk?=
 =?iso-8859-1?Q?Gi8OLrlMRtuPpkUh2gAg181KBKh2oDcQ3PESg2QYTuoisZyYS/k6gkEUXi?=
 =?iso-8859-1?Q?+W+1lF1jXBSqF78DmKHseu/i5QQZ2r+7shFDuUXBwM+tHqWcA0U3dW+UNY?=
 =?iso-8859-1?Q?JKKGCA/DzoPbKTQhMGSg7/gCLLR6S9zugGZaEVOMz0rAClCbJv0IXuXWB2?=
 =?iso-8859-1?Q?yj4ipJtcA2jURw3ugf9FWBKBgLP+FItzlm8hwndJdGxEvYcxZND6priJLs?=
 =?iso-8859-1?Q?aI49/EdAR4PGfU0j5X94Aj9p787PvUtaR70DBXTypJBhri0CoZptU2vUpO?=
 =?iso-8859-1?Q?jlEyR4gvNbTd85PyrW+Q4CogS08yywf8j9Hbv42a4qwrYhvAeZyh8XUOXH?=
 =?iso-8859-1?Q?d8dFKGe46uuo+p2UrUTHqldTa2A1RjzA4jF1TrpB9WnQ9FyRq+d4yIN+A6?=
 =?iso-8859-1?Q?L9V4fmNMBtYKEGLbuwB9TXNVnJwDRHDOjDRbmy3UdW2ee1eUUNxfCRufv9?=
 =?iso-8859-1?Q?MxeuTqrxLaHpHGjCYOSAPjsjq/qP1RcScv6J5qSsf/sWmaCxQoCceXcqfx?=
 =?iso-8859-1?Q?lAb6WdzxmhNKfwQBVu5Upw49RK7G1SUdfwpqdpDpIS9LVBgIfotuy2P5gA?=
 =?iso-8859-1?Q?YWoXIbrxhh4O7VsH2Ur7xrn80clTyzNjNcNE4dCu4FAPHAruAXhVxssvrw?=
 =?iso-8859-1?Q?2obCdsWaB+O3z7aGE3JcmgBmOFwmjYkRgk7Ipoys9tuJw8JW5/SfZwiJqn?=
 =?iso-8859-1?Q?o2/7vV2sXFuUKQAjPcFYBAe3ULewjEGINc5phLHRF0o1m3jcVm/3uL4ncW?=
 =?iso-8859-1?Q?q4yravFDKKoIM6HACb2yXLFeB6zk3E7JF7xDzNRPs9QpdoxVEfBEkxX1cZ?=
 =?iso-8859-1?Q?kP3gT4+wjtYnQaVs1q24d4JAz0rkxMwXm2j8dtG9w8tqfYL4THXmezzlQK?=
 =?iso-8859-1?Q?iGXbt0oUor0BQfeazLPck3jRszJbZyxKh5fGOqPV66kbIo3fQ/ZYKew5Mu?=
 =?iso-8859-1?Q?6Xf5VcSF1kII5JQonzL99KUkgY7tD7UVC/JMkfIHvwazG34rJ1pqyDVgCd?=
 =?iso-8859-1?Q?QTce3YEeVrsLjyy6hWKPFuOY6GQsfNpykVbtcFWAlkAVv/I2ZalJCMgwgy?=
 =?iso-8859-1?Q?w6hAt5ATyq9gI+LEp1DNBorpin0lWS+0fScrZeA4ft05uLtEZm9yL4C/3C?=
 =?iso-8859-1?Q?B+mgfjPaWXnFuh0pA2vi6PRhdTOHVmNiLH1IBaY3LXPRLtqAAUAFsrK9YP?=
 =?iso-8859-1?Q?ef9AGrqPS9phU0V6BXnX41mGFwz0RoGz4rLw1lse4Zk2t42SJeWCBFMhFL?=
 =?iso-8859-1?Q?+1Kwa/m3JvXN6dIUkQHLDovSqb3CZLUrJO48shS788+skT+p/c5gYvW4Q2?=
 =?iso-8859-1?Q?4Xnl9Ai/9zpk5DV/uZxcvc2StjsQAHDHkdD79KI1PZkOnCgMTPRkW7y70B?=
 =?iso-8859-1?Q?DAs9pIiy1sejbcF1q6sgciEZG5JT3YoLv3ktzORHmAJOWMl7RffRmeLESN?=
 =?iso-8859-1?Q?DK0TuGj5CWOHiLkftUvM1oFtAdsUcWWLucAOtZpEEpRK/EbOo0tdd9Vg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rqruLL/KQCF8ZV9Vl52B0cBDvAGCWEtT7y8TtTkRBlaJZ1DRDVlkF8gpq/8t4nVZcOh7rfLGzbKzy2xzQxsLR7TwqhdYF3YKOTiLcxPeMUzpS2al+vrEM+ASAw9SqoeiejiivpB87qqywRomgWY1c9JRC7SywxFEjROqUIH33m1HvtBxaZkbJJpC1PhO97Tw9xPGKjLRLSWORTfOQOti2fn8znk4RQZriB/oRc2ElzJydCSEQc+/mHFxMx8n9UztdwmfXH0KAVsTPz/a9mRXpRLz7NnK7nialkSekpSTRISb2Rt+eL9fCedmp1MvHrQ/ytaiX/9K4U1yhILcvvH11eMhFpmkA6dfdADpbESYPvIiTUX/1+QVwbgP6erq25Z/Vwm32ZlR5DVszptkFtWsmw2vGsehXOnkR/fstQRjYbBRriLZ7r/9r5+mg2Y69ltlulwYqoGUwJTRuOW2xKWFYQRIB8Z/a96iUgsg+HphiPuWUec1Fc6+Ifhix4vRsfvSuEM/1VaJ4fC9mjrFuH4kHq4594yQGCIVlfWbxIgHRL2l6SfY9+EXQ9kOZXQhXhxx3NuZsF23Bfhsa+mJSrMpNe0DUlKtcrG9rAUSC6dEDu8izpaIU/JMFWuL1pNQe5jksFpMgYJBPCegV/W7IDxKiCeLLTNIbEXh3DZa0obemc8siP0gtecxAOCCs3wTc5hw+WVwW2FbkPRRF787PXctJFY1wnY+wGPjBYhqmZZvcWaVYSzepk+/VtCaJm+Re1WE+1vPnmXb1jYzHN1taVFm0Sy1OLZmBil7LkiGFB2fwlFXi1HCYuA62hEykEDB9PPT36eHhnC0aL8RKbactlNQN/IpNOvn0BE1HOrNFvfeN3ndQrrclPpcpOIeSki4YUvm2MbPLs2LjBafNze3RK+C0w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbd0d5a-97d0-4cd3-e7e2-08dad228fb8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:27.4415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQAOXTXMNTyabjriOYiFNVmeXxmrVPTUa5tFqQ1qJC88y4zh9ibHaLbY2l8Hu84A40ph2g1N3C7crH9QMf3lAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: MZ-jChB0kaPxvTw4NiPOTae775zkNI59
X-Proofpoint-ORIG-GUID: MZ-jChB0kaPxvTw4NiPOTae775zkNI59
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
 mm/mlock.c | 57 +++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 7032f6dd0ce1..f06b02b631b5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -401,8 +401,9 @@ static void mlock_vma_pages_range(struct vm_area_struct=
 *vma,
  *
  * For vmas that pass the filters, merge/split as appropriate.
  */
-static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct *=
*prev,
-	unsigned long start, unsigned long end, vm_flags_t newflags)
+static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vm=
a,
+	       struct vm_area_struct **prev, unsigned long start,
+	       unsigned long end, vm_flags_t newflags)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	pgoff_t pgoff;
@@ -417,22 +418,22 @@ static int mlock_fixup(struct vm_area_struct *vma, st=
ruct vm_area_struct **prev,
 		goto out;
=20
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev =3D vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
-			  vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	*prev =3D vmi_vma_merge(vmi, mm, *prev, start, end, newflags,
+			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
+			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*prev) {
 		vma =3D *prev;
 		goto success;
 	}
=20
 	if (start !=3D vma->vm_start) {
-		ret =3D split_vma(mm, vma, start, 1);
+		ret =3D vmi_split_vma(vmi, mm, vma, start, 1);
 		if (ret)
 			goto out;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		ret =3D split_vma(mm, vma, end, 0);
+		ret =3D vmi_split_vma(vmi, mm, vma, end, 0);
 		if (ret)
 			goto out;
 	}
@@ -471,7 +472,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
-	MA_STATE(mas, &current->mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, current->mm, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -480,39 +481,37 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D mas_walk(&mas);
+	vma =3D vma_find(&vmi, end);
 	if (!vma)
 		return -ENOMEM;
=20
+	prev =3D vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev =3D vma;
-	else
-		prev =3D mas_prev(&mas, 0);
=20
-	for (nstart =3D start ; ; ) {
-		vm_flags_t newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
+	nstart =3D start;
+	tmp =3D vma->vm_start;
+	for_each_vma_range(vmi, vma, end) {
+		vm_flags_t newflags;
=20
-		newflags |=3D flags;
+		if (vma->vm_start !=3D tmp)
+			return -ENOMEM;
=20
+		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
+		newflags |=3D flags;
 		/* Here we know that  vma->vm_start <=3D nstart < vma->vm_end. */
 		tmp =3D vma->vm_end;
 		if (tmp > end)
 			tmp =3D end;
-		error =3D mlock_fixup(vma, &prev, nstart, tmp, newflags);
+		error =3D mlock_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
 		if (error)
 			break;
 		nstart =3D tmp;
-		if (nstart < prev->vm_end)
-			nstart =3D prev->vm_end;
-		if (nstart >=3D end)
-			break;
-
-		vma =3D find_vma(prev->vm_mm, prev->vm_end);
-		if (!vma || vma->vm_start !=3D nstart) {
-			error =3D -ENOMEM;
-			break;
-		}
 	}
+
+	if (vma_iter_end(&vmi) < end)
+		return -ENOMEM;
+
 	return error;
 }
=20
@@ -658,7 +657,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, =
len)
  */
 static int apply_mlockall_flags(int flags)
 {
-	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, current->mm, 0);
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
=20
@@ -679,15 +678,15 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
 		newflags |=3D to_add;
=20
 		/* Ignore errors */
-		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
-		mas_pause(&mas);
+		mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
+			    newflags);
 		cond_resched();
 	}
 out:
--=20
2.35.1
