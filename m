Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F020363C596
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiK2QsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbiK2QrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5ED6C73A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:21 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGOeuj005604;
        Tue, 29 Nov 2022 16:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HZkGh/AK9aEBEeDLAsuHbDy6lfrlPVkrwWemk1krQcw=;
 b=HE0GIU5Ch9Zmrms719OjHQWhGOeRYe0pHG/TVKWUIuTA9GaA9BttcUcclii+NEE6S928
 xSZBl+3xPgqEzNpE8K1QRPwrbxxbw0okRvf8HAmwSUqPkc+FTBHD8UncD5e8t0YpPO7V
 URJbK17vypb0JPnbE3Psb9g1M/yoS+vODeFZLJ062h8i6/b3apMi3ZU2wfyKKIU3bBL4
 ERYGYS+RX2EV4ueSh7kTLiXJqu4n8P40GYLTM3ITnL90Y9Z1MjtcFCfTbm39MhdARW/5
 De2kgl2LclRKgVOy1yVITu1KHujgDvpYtLETNhQzU+3Ca4IkbkjK6zCZ4hHBvNe706NI Bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2qfd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFgHOT011450;
        Tue, 29 Nov 2022 16:45:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398drgfk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkWj40sf8QTumMZ8rOFJFEqtAOHFG1b91xjaXEVwa8286iurBPJwDo12fueR6l+12qHucGAXI5+y/9tLK1tMaScNSWbbSuF7egfzXk1rmbUIomBmm/YRTHtjyyq53/QI3XTSwO2hXPtXviHjpT9JhsEfmc6OR7hBwZeB4/XKyDkskW7D/oLTKoPy8pGPpwdnYoW6JXb+GHqYG7RCjs+vdr7F0uk8QsZE4r3ciLyGw43xs/XRb9uoxMFPUm3VYAixx+uWXglu4v/7W3MKu+eY+8QxCtzzA5HpbcVdDKpNp8RkchFjc1DUrXHkHIY3iuRXAfcMtwc5tToCISNc0jXI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZkGh/AK9aEBEeDLAsuHbDy6lfrlPVkrwWemk1krQcw=;
 b=bn9AJWLtNdQge3mEiIviaAXUNuKsDhtUYntWLGiAlYZnTOb74109ffod7NE1CFkCPwd9DU703XjRuQpwy0yZ1uNWK1y5Ti/wH3d7r0vjfX38hPHjhF9jLAKAnrwXpUKXLAFC7KpRFepriIWdwOj4oGt751HQgGYnmBw2uCPejW7/avWgkYDQwAugMsSm0Kep/droilHCDLE2mR/sKPT7g69JbnMSxuGxnze1jX3LgNyp2r6VMsbXCHgchnjDImpHKD6W4pBJeNmGG1LF5A58ueKqSsNP73xUCpgMscZm2ZYQTsBykzZUI2UwyIv9WZxzGbJVEAyANX2vxr9CYUszqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZkGh/AK9aEBEeDLAsuHbDy6lfrlPVkrwWemk1krQcw=;
 b=qJ3f+KHHYj01bKBhj6DVY/YoL0B0QtLLrSzZCcmXzr+MusYzhB42W+sgrbmZ/t9NOhCnuKqxM6w1tX3FbeqNep3vbL0PQ0ikNulnVyJ4AjnluVQbgeMLcy7tNQV0xeWCPuDKkr+9TtaX8z3Fe1HFlL1b0gB3JFrO+VMWHkg8ncM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Tue, 29 Nov
 2022 16:45:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 39/43] mm/mmap: Don't use __vma_adjust() in shift_arg_pages()
Thread-Topic: [PATCH 39/43] mm/mmap: Don't use __vma_adjust() in
 shift_arg_pages()
Thread-Index: AQHZBBHdtymiOJM5JESSvlvJ/6HVqQ==
Date:   Tue, 29 Nov 2022 16:44:36 +0000
Message-ID: <20221129164352.3374638-40-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CY5PR10MB5937:EE_
x-ms-office365-filtering-correlation-id: 099106b9-a1d3-4d03-d7bc-08dad22914c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8PaOBWpLprrqCnNOoqoq/nNjwk8UIMWXNSICKcoJoxLXW9GLDRSEbP8o2NZEVGdrT2pz/q23KRXam/e/MKTctzCWPV30DcY8/q/M2szluVX2yXk9zK/iSX7N+gqDGcWS0uYWqGNCMUFRELvNgp7UGzatz9uF9UAIKtj8Nf4/MInhUcYK53JW2qnqaO68CphkU5jC2kwOVoomhEZO1wcUGN2VpVuFc8XFBhKiD4Bp8yhGeiGqf76ciVXsLyZWx8p60NYqa7FhpvGXOvHci0C4JAGdwwpd04EyBPlazhP6ajfG/9Ok/+wgf4wtJInnQUmT1GoVRu5Ku0c/S2Nt7NbdBTeDIZ419z4OLSPpMaMX7tT5W/RfY1o+6b8ahGoSz4xPGBK+JN1U2NJxzR2lqycjBEuRS6Ldmuvb392r/atZ10ARSTtSkP2IM+1R53x/zMWJKT3EQANVVBJdzGy90ntRR3R4wGs5RqSa6+o+cy6djmFYwJjnwbIII8r3dOsmm/1VL1uTBqS0oKG1DH26ozL+TgxWUqKq06MqIXU5pD8XHzR/tRUWjF9fo/vSOPaEz2Q46ib3xihI27nOJxSTvYOWLmJ3RTKQFKOQVzUW+VbS/q5gAqNsNyenagTIqCSkmThCZbdbXWkYQgGJni1pMBFIf7kd/08Z9pOnvt9GX0ja8FDhB5Tiw/IpSUeoc4kfI1m45+V4OuJ1Y/V3ch4DKfeQUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(8676002)(66446008)(66946007)(86362001)(66556008)(66476007)(4326008)(64756008)(91956017)(2906002)(76116006)(110136005)(54906003)(41300700001)(38100700002)(122000001)(6512007)(83380400001)(186003)(8936002)(1076003)(36756003)(2616005)(316002)(5660300002)(107886003)(26005)(44832011)(6666004)(6486002)(71200400001)(478600001)(6506007)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jjZ4qh+vX9BzLCQ8toCltBVxzfc+NYkU/CF3rUYLWx8gMXf1a23yjZVWqm?=
 =?iso-8859-1?Q?QfcmIzpwuduP4NVB15PT26SSz7jHE4YexIbKuZrjSZ94u7M3j1nPbq65VZ?=
 =?iso-8859-1?Q?zpCobo/p+9jDxzSi30GoPVDyANosk+M+mCAa4qsnlfAHE9hGQ/tbbHwXmI?=
 =?iso-8859-1?Q?J3DFEIHSDP878L+l2a6VVSLeKu72JNhm6+Y2V53DGAKos/u+IolkS8ytr2?=
 =?iso-8859-1?Q?YcSQ9rt8LsXIyHerRwNHiNrNRHE5efcajST38mohsyHJMJnhVOwu3HIWDW?=
 =?iso-8859-1?Q?SooJ+taVmVHq6uIogBXNjbpdJWL7O0ddP+Pu+zisV8TjEqh384Rq2xCMIX?=
 =?iso-8859-1?Q?SLvhv980CEoH07DKZhONqbHsogDv/6dOmWOswEBvKuwfGGSGl8Jpg9Pbjv?=
 =?iso-8859-1?Q?jDGb0wNj9ekgQcRAzxiaxqZg0+UJ9SqovHJWxGb7lWN1TeQMIgmk0QdYde?=
 =?iso-8859-1?Q?NPvPo0PQsc9Ad6idtjC3HNiOswn++s6lt0ZkEUlyKFS4dGFRGpDgRZ4dvS?=
 =?iso-8859-1?Q?ACfjbyhywb+TZlJ2hdmWqn9yHXQzX09X6D0jN4bjZx4myTjHFLXh7XYdXO?=
 =?iso-8859-1?Q?9ELhjzsKVQb3yCUjoNbgeGsoXsCKiV4/zp2CAs+BU/WJkILazlxQB3LtWy?=
 =?iso-8859-1?Q?qlBq/2Nvn4yua7nTZryg6kYcGCrMytT0GegnkMw8okRi73ve/ENQELtWzw?=
 =?iso-8859-1?Q?nMTtbXG9CpzUuV1VnWE5eB+wxwcihVnH4amF3zFaJFV0WMN6411AylVklP?=
 =?iso-8859-1?Q?ZrgvAgpMLuTld3AxF8ADg39cOkOHqMFCTkGJ4mEDeVmdgUdayIwV59Uq+v?=
 =?iso-8859-1?Q?zIIZ6Cl2iC3krdMKjCX1HqUPlE/14Tedwq1sQUHQvAY7DMA2P2rPC/hC5G?=
 =?iso-8859-1?Q?aaUAmGlDOIFZRq3cKZbPQA3w/S0qSuW4/e+YSiTy1FRR2NBBaZ/MG1N98/?=
 =?iso-8859-1?Q?oAcM25gAp3IlCdRwcHuJez5MkdZrRz3tK4iJCWQ6LMpq8SZnoI5c9ZTk/N?=
 =?iso-8859-1?Q?5htHDQ7g0GxV9/Buf9HpQl2Qp7BkVmTn63c9QU4axPY/0o6lmKnSzvCYSj?=
 =?iso-8859-1?Q?5z+GXxPFMHKf/IWCUikAmiCNDngwD1lMbLNwxa6JHaa5fuCnJlw82fiy1Z?=
 =?iso-8859-1?Q?Ro4ZyaRMNIB9k1fO8+7Ctsi66z26JTAgY03sKPyNKGUHKxYnCJpxF95EX7?=
 =?iso-8859-1?Q?zodocpO3ikmvJJDG2oWSFD7v194/zMepbqWmnQyM1u9qtz70LrZN3bl5B3?=
 =?iso-8859-1?Q?tS8S4TO4R+qw+wNuByYOyX/P6izTMDNwuahYCjNvUO85SOqfrC0VAkuLvq?=
 =?iso-8859-1?Q?vAcw7cW4EtGtjKXO6iPCIA+y8sKXOu/0WqplYWIChp3EFVE0QMyPA76r5m?=
 =?iso-8859-1?Q?vxRF82Qb8wzC8+HOPw/FpWIUHtwRAWctT8Bb0P/T7lDOHpBW7w8cSQFhBh?=
 =?iso-8859-1?Q?sII4mLsrhZSxDMWxXjlDghbWqPa6nCGL1668eYkBQQR47+2rn3Yc7IuRbR?=
 =?iso-8859-1?Q?XA7wBF6FXXBMMla8gqUtiwOJDYxqg6GBrPMaqM4juISLeP/udcyGqJE+ws?=
 =?iso-8859-1?Q?xIQIe/e/EFPdeMmY+pZlJcS57/ryfaAP4/ZRk7uJw0xKiu/Y3BcECwEtdC?=
 =?iso-8859-1?Q?wS5mF66qQiCx29GuVbNiLvxvsLxrt7ss+tEatOngj5oPV+9uJWT3cYGg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4fTG7kniYP3IAvmujRcBNBxCq5+lQ9nvHUYILtCXK4Mq7FEJD61KspQSevPdFV+bsahWDiHJRgtQ6F8MA+BSlqpkFEuI/4zeTdLlNhN1eo6uf8oXDyRKxbvhks7xR15LhuWbwt00ZznrmNJ9Z3PMh6R+DK8HVsErKsxjz0MmrwtZtSi1dPI8FfH1thavehEwZouNL/rk18eA3eFCgyjkSf12EF1rgKK8fgDL73MtcKGV8L0cM/oGSCqnd8272UKO39IeP7UafQtGMmrVqyTccddg01RHyOdOyPwT+0vFBR2JNL2LeDIoWGR3hMwpT6fZI9pzdyJxwByI38PZCfZYF2AhHsLeMc0eXluohjhSuTLrMyTfuu3KTkYIOZAgCW3VBFI5ThnpxkGxAkqM0b/FWEBpPEPK2q4amX8nQ1k9dABCnQacSQXebQpC2NieV6Wykg+GbrYE1vglSbbUGZoOw/Zu7ixvxjcKUibejMMCuuhSAMclKY5Vj/TpF9H7X/BICHfH1RXZRmp6lTBQiJfymEH9cpBGeX6A2XYZJIWz4POXtZrRb/k5mqu23LYTCQdIsGYvYXyofef2ZBJJTODHXBlMjRt/YW8KeysGZ26Ca/zR8nHkYbtTj2zXKqOj7RJ7Tu1wKOc2hd4WtNfb9ygBltHdFXDRwQodRex6uB14gmJ0Txhfn1dJtN3bQGdDFrFnb7aK1cXzkHjjFwgg5vkz28Cq5NcEGcU5tNr+jJiEVWdtI8+SAgfxna9ACtSsQbgFYegreLOFmUdYQONdBCxOkpDrgYkp6fWAu8RFgMlE/mYZdgihGlL0XGitdeusVifjKjNbmBo6iKlr/dcWSDdnBYUhs+qlEl6YjhF/VOwcO+VHXHt+kOUhfFJ6Y2QcP+q7gJahzSv5h+h6mqJJS2u4Ow==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099106b9-a1d3-4d03-d7bc-08dad22914c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:36.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wB79a5iKT3lgu+8Z2eE/nodhDYHTUl6Uv5J4fTtQc+DlHU3pWvOEhgCvq96oYWc1dfKydaiPTmvwXMAP6FlNXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-GUID: lpH78jnbJwmdhg6R-WxqA0MnTUuHne5D
X-Proofpoint-ORIG-GUID: lpH78jnbJwmdhg6R-WxqA0MnTUuHne5D
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

Introduce shrink_vma() which uses the vma_prepare() and vma_complete()
functions to reduce the vma coverage.

Convert shift_arg_pages() to use expand_vma() and the new shrink_vma()
function.  Remove support from __vma_adjust() to reduce a vma size since
shift_arg_pages() is the only user that shrinks a VMA in this way.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c          |  4 ++--
 include/linux/mm.h | 13 ++++------
 mm/mmap.c          | 59 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b3fa6dd2d0e8..8903351e101b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -698,7 +698,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff))
+	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
 		return -ENOMEM;
=20
 	/*
@@ -732,7 +732,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
=20
 	vma_prev(&vmi);
 	/* Shrink the vma to just the new range */
-	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff);
+	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
 }
=20
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 13abf070e911..5483041ef7d8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2692,14 +2692,11 @@ void anon_vma_interval_tree_verify(struct anon_vma_=
chain *node);
=20
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sy=
s_admin);
-extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *v=
ma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *expand);
-static inline int vma_adjust(struct vma_iterator *vmi,
-	struct vm_area_struct *vma, unsigned long start, unsigned long end,
-	pgoff_t pgoff)
-{
-	return __vma_adjust(vmi, vma, start, end, pgoff, NULL);
-}
+extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next);
+extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
+		       unsigned long start, unsigned long end, pgoff_t pgoff);
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
 	unsigned long end, unsigned long vm_flags, struct anon_vma *,
diff --git a/mm/mmap.c b/mm/mmap.c
index 061e92dab623..519cdff9d135 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -694,10 +694,9 @@ static inline void vma_complete(struct vma_prepare *vp=
,
  *
  * Returns: 0 on success
  */
-inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
-		      unsigned long start, unsigned long end, pgoff_t pgoff,
-		      struct vm_area_struct *next)
-
+int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff,
+	       struct vm_area_struct *next)
 {
 	bool remove_next =3D false;
 	struct vma_prepare vp;
@@ -743,6 +742,44 @@ inline int vma_expand(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 nomem:
 	return -ENOMEM;
 }
+
+/*
+ * vma_shrink() - Reduce an existing VMAs memory area
+ * @mas: The maple state
+ * @vma: The VMA to modify
+ * @start: The new start
+ * @end: The new end
+ *
+ * Returns: 0 on success, -ENOMEM otherwise
+ */
+int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff)
+{
+	struct vma_prepare vp;
+
+	WARN_ON((vma->vm_start !=3D start) && (vma->vm_end !=3D end));
+
+	if (vma_iter_prealloc(vmi, vma))
+		return -ENOMEM;
+
+	init_vma_prep(&vp, vma);
+	vma_adjust_trans_huge(vma, start, end, 0);
+	vma_prepare(&vp);
+
+	if (vma->vm_start < start)
+		vma_iter_clear(vmi, vma->vm_start, start);
+
+	if (vma->vm_end > end)
+		vma_iter_clear(vmi, end, vma->vm_end);
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
+	return 0;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -858,14 +895,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
=20
 	vma_prepare(&vma_prep);
=20
-	if (vma->vm_start < start)
-		vma_iter_clear(vmi, vma->vm_start, start);
-	else if (start !=3D vma->vm_start)
-		vma_changed =3D true;
-
-	if (vma->vm_end > end)
-		vma_iter_clear(vmi, end, vma->vm_end);
-	else if (end !=3D vma->vm_end)
+	if (start < vma->vm_start || end > vma->vm_end)
 		vma_changed =3D true;
=20
 	vma->vm_start =3D start;
@@ -878,7 +908,10 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
-		vma_iter_store(vmi, next);
+		if (adjust_next < 0) {
+			WARN_ON_ONCE(vma_changed);
+			vma_iter_store(vmi, next);
+		}
 	}
=20
 	vma_complete(&vma_prep, vmi, mm);
--=20
2.35.1
