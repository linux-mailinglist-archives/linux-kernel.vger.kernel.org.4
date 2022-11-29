Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71AF63C577
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiK2Qpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiK2Qom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2E35E3C6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGP14g031318;
        Tue, 29 Nov 2022 16:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uSweNQ5DK3Nmh4aAYiVtOYJ5qY4vzSTfB3J5vg25+g4=;
 b=ojHYmhnd9IFUv7lsVT0cDNd00i4yvcvE/BANR2F+zcBZSMYpzpacCoPejo96wZHBgzWU
 ZD4tlPo+sNg3W+o7nEgip62HKyAZb8z8LoF1YEGxXYgb5bn2wTZc7d2Uwdt/jtRrQJsn
 K0ScTCIYJgkJUaTL0/evsso7qw4nUTJkEqxXOLa65CvoOC8UBNxzU57igMJ1NUIyeIru
 ewBTjxx2vtx65NQVFKCnxg3158nR2DKtVQAl5Vq7Tsq9b9lUEy/whvpuirKBN1FCNy1k
 Pn1HRnYZTjyufanovVx9BPyzz7/WIMYLbe45hb5t/nvCzyiKSp9oo0PYGX/mK8q+agi2 Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3xas9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPm027963;
        Tue, 29 Nov 2022 16:44:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdflu/4rGFC+s0A64AnGxr6obk2krdfNluYcTkdvJI/wphIDWIO+i9yQcDzyKteh7Z5gZd4fRwqCw21yJSVsLy/T9mhLGcnrcQaiRRsX5D3UtS0IFNaLYtWFXL3oKn7aLrutPH6bqTC79T+rKkyUdELmwEGV0BihOfM8/IYO0sA/jHf9diGkqNuSGZUjBXqvKw0lL90AO2VVgrKjZJel5LCqRk8S80Nm95U59oSxO0+XvJXdxF+zlp+AErvGVBii0vgYb3A35D0Eph43UESYvUnOpsnGtRqdvGMfFxn7Yc8ER5rSQ4A1b7PjQwTLF7llgYyfLsKkAD6H2YtzeNtsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSweNQ5DK3Nmh4aAYiVtOYJ5qY4vzSTfB3J5vg25+g4=;
 b=B3cBaJ36Mz3nH4JEkuP141K+KzKGXJgfkrKAGJQyoVe7FbC+c+5gUg8PH6tdtStQhf//JBsRPeVburRg2mqkYHmjDWwfxOTAbXNzHbrHfP3BRb7GLiO0pVhQgCLCf1BRCTaBsaURcJ1I3Xj/DWuI71vDtZ4x9L6mWknCWjmEt3etEbRUfKAUbY9JuJOKNGKVCjpBf4aHaaIFrNW8a8nfLlkO5aidvahFU60Ldtt6mgeJiC3AzJe6CeQTiUCOTdV4GMb9jVzdwgHAEvuJXIiPguzUlSPkWXauaMsSr75t54pUW5ZaW5fdJnYomwvjatpP5YEBS8Z/ZTPC8iPeRsTikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSweNQ5DK3Nmh4aAYiVtOYJ5qY4vzSTfB3J5vg25+g4=;
 b=v+yj5/Hj2R344ukP/hpKQZI4Ie3fXBXrqL+R1Klbi1elbEZwo4HFPyqcWHdeez3PGmrnU03gxcAaynPNnHWOc67i96jktCubi3RmFEmJ8H1zvkxWrT4P0WKzVmA9+t5QPXh53CwpM72/hKmSVxuYQIRP7EGbBa4Pz9YxnwRBQwE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 20/43] sched: Convert to vma iterator
Thread-Topic: [PATCH 20/43] sched: Convert to vma iterator
Thread-Index: AQHZBBHZQOLofThL1EGav6weVWb08w==
Date:   Tue, 29 Nov 2022 16:44:29 +0000
Message-ID: <20221129164352.3374638-21-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: c94f2fcb-cfa2-4db9-5d5c-08dad228fccf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OCvbzgBdXCeMU8UW3naQ3ydokMkknvLgqlkmjQGmOmLriSj5v6DmXVF2gXw/3l+pjMM3BoFb0bHgIphHHlM5vdJomEMIQZesMkvalgNDWP8afsKVg3YmkOiIsXqvoe30XPoqOGvn6IlkA7tTMppZ2CWEpflUadIonNX1ENSojJ5uFRv6Qyb4BJqW6/ZzMAxFV3sajP03QIthMYJUpTOhwQWxJks6kek/yz5ste6vLmdPKo0MA6qm3v8aVe9M6UpVCCz1zhQWeAIgLq3uBs2k+8w+HrBdWNFRRAkv8LIe3/jJsBr1fdBBtAyigOTwTVAOxY/adsXjlNsnACscYLz2rBErRg0RJsvXX5S/X1mhq6EZk7hwr1oMxV+dIHQ+nPcTJg8H0nbeFelUdfRD49U3hBZTJJrZ+UQgjqkHPWHH/Mxj7t6pd6hrsM9g14CtiQK3kNed5D4u0HSM39MZNTLZjeteUCwslVLKCazMiSWnrphgJZkoDwe1nREuOeggoEPUF4oCaraiT4DJ0gqOv7jXuK9cSM0JU8MpWIm3rI/ubAnEfCM2beh8uNvMwmtZPmc51LDRY5d6ykGoOsLJzXELWN+rAASgCa6jLe+FkWI3WY+BHlpINWejKzAAEWaUFVoeHFax3iIzlxLz89RHW4T0EenHy3JlNVLZz8eba9ddTQsMz7MctMChM1V9xQS1ZgG6hkb5kaExSYYkkhqq25i2LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eqd3QRAUNxZPTTLF8RBPhY7iOLLfd27kXPM9eTBpoMeCHIEBRLyUc7AbLE?=
 =?iso-8859-1?Q?emaDHoDXY+/xLWaRthgbRdZlIS44RnfnSOf+x4skrB9QFuXSsCoEOA25F+?=
 =?iso-8859-1?Q?8BS109CFtgzfno3dCZgHYCzlewBqTYokxNeuy/GrHucYpLoiw9s7MyecjE?=
 =?iso-8859-1?Q?DFyDSITRMN5x1lhnKPa4TTQz2gSSztxQ5Q4L4VQQ7y9azRnhuu0Wbxy7cC?=
 =?iso-8859-1?Q?yI1ON00fYSJB++AL6u6TVKY2NaC+PFFgwaWCGKcD/2RNL93cDmUQVOoC9B?=
 =?iso-8859-1?Q?CsjJW3G8xl1sfzzQVKZmLxvOeqRIy7qdvVHRztRiD3V/er54HIub95xLW6?=
 =?iso-8859-1?Q?n5Bu21jNmuDUvF5nujvXwHoqu6BJ4seILq2chzq5mz3lY1aX/63OeOwMn1?=
 =?iso-8859-1?Q?ruEA4XPgdCgt/nx8HGZNUuPo/s4ciZKze6kGzF2gShaL6+JvTOYaxM1K0b?=
 =?iso-8859-1?Q?TB7O8lKYh/rdY9l2Ohh4dO38oR4r7AJWJLXuDiALTl6svyUQTDunJahDqa?=
 =?iso-8859-1?Q?x94Gc0RLfLbYXd2c3xTK/s0Q+gusV77lnST2xo69NLZ5+Xwf/1YSqwoV7S?=
 =?iso-8859-1?Q?xc9dkQ8NVGIoUV+w3tLxFZKjRBWIua3tmZrUsxoMewehrlD7uIf4BF5/ND?=
 =?iso-8859-1?Q?RjIYP0fPEX1CiGYC6v+tMgkUabBh8NIVq3DP+j/TVRaSk26Iz9ytaECv61?=
 =?iso-8859-1?Q?R7ieP11fa/AGAPTWCbbaBJzAXxQIUsYcDVYViyZra/dnFOEI0o4lqCDOIP?=
 =?iso-8859-1?Q?US6exy7J/6Aq01/BcSVHp0DpftCURlWE3Jbvh4ilBa6bpNw88gWe03z+pm?=
 =?iso-8859-1?Q?WNiXRqIE0i8WsfLdXgE6TT0RXOIvvFhTykWIdEuc0YaaXT4+/mZlrMFD7f?=
 =?iso-8859-1?Q?C7Ui5YJYzUyxDsPpVdbt75Qwr/cSq952svlYg4EuPbOJieWCnVN/WMaI1V?=
 =?iso-8859-1?Q?G8fyY/t9UaDihOCUegycai8MP/8pkYyZO22llN3fKYbUmCfQScSDHDgyrp?=
 =?iso-8859-1?Q?yZjQuleLe0cCMlRtH4HMTsaM2tEN/uhKUP8veGKD0jpp196Ozk9xY9Q0eO?=
 =?iso-8859-1?Q?bEIS3F09DNHTrO4tPWGvWBEm+ww7kZjPDjtGtBJsOci6BgHvJGfhp3xprR?=
 =?iso-8859-1?Q?F05sOeAJoNlJqjYx/hxvRTI3RRdwbY/gJjsGRMEU4ej16MYEWWDwvTkWUW?=
 =?iso-8859-1?Q?vJP/GAiZjbf15g1y/oKY+IkPzZg+RenxeWgExhHRgAlOF5c0Mx8jmOVhfZ?=
 =?iso-8859-1?Q?cxXrzRAYaTl+ar6UC124dAsaW+VztaXo5DTKBD/qu4XohkqBtg1g9dlyXW?=
 =?iso-8859-1?Q?AxindDDnER4C1wWjZlUwLSnzHKY1TmPSmlFS0yQ57zC7awzaCOjYn7GI5P?=
 =?iso-8859-1?Q?VNo/Nl7+q1Jw/nn4MDb+ZRlasGmkQrfA/GmC+QsGIY7YDofiazyBc5teXS?=
 =?iso-8859-1?Q?tiG/zZJcTRc+iioWPw1/m9oNGzxJmdoquO8WWNbDGuGTZYZ3y8BaJP8qzz?=
 =?iso-8859-1?Q?+9ulNNbxzk28+bLE6k6O1ENZLj7SlOiy8yc7izO6vLAzVfh0uE7YKRfe8u?=
 =?iso-8859-1?Q?zipSHRjHlGwp4FiOpyhhV8EtYD+W6ACzMKX4pk25CJBQmciDdCkTpZYKB9?=
 =?iso-8859-1?Q?UbP8mTy1UuB0IKr0QLNk5JwFhiTiUToC7igmquWCqEZ1lCrvkmiWjkIw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HK78EchnmH/CnLR5dBmjF1jt1KRHIVQngxOhexR7dVXE++ERdjKfFeV1S1igc8YOps688g8l72iSytMeRY5GL+b5i3HoPaotkvmjwHL4BM4ILmJwtvSzBjtGLmTaupweKTG4WCiKVE1sm4rkMTCOjcbFnR0Tz55e42Pawh08uY854yGaGcovXNj/687WCySLMjKC5zKJEcnj0bvmeug/zUruieDdg8jyy2KLWyYENkvnwbu0ijbq0PvN7L0gZcrb35uKf4yBHAPRAVv4BHo4FUbxpDzgwLVH3CKFI009NCle/x/pF5VdhGK8L0Aja44e5MlJ0/LoThZCr5o0tQ/mxlhPWEenLidpbsSzF4boEUZPzzfvhTZE+giu9SA/ANEEnPI4OTnVvu8B75PQIuQdWj3nV2PABSkA2/S430jt4AaHyF9YJhZLYEsVOc+KYLvLtoRN5F/t0n+KJTsTH4EOvxmLIAJwRz08FlnEZeoba4T2mpelIVL1sC8skCLZyEkR2iJlsYaDBsYN/lNauAwSQCF5Y3ARTowZ0Yy/T9fDkE6fd0RsTBaY5qxO0tx2fF4uIGlhrV+MZbix5zmzEC5PSqnokZDd2CBI0Su1xKAOlSmU+ulohTlojGwgjglW5s/QYdM/v+5ZzEbUTqYr+di8uToinHWsX4iAQhdprU0ALdGDp5JFsGgokeIozIuG0Ujh9eaoDGEAKzuV/giopCLUg3llJFHe9RRwcYu42CM6gYbnfNHuNMoYZO9eYRSi1cN2/k4GZlafhmk5Hy6eGuEw8qyCgIPMsxcZ5Z2igpsWUIeTzoWwmDIFGd1gWP3wIIQWBH9BYsmkFsi9evtXb3NPHf8BU3HK7z/QY0rjeZV5LTbeqQ69sL73NxRlnDFeY+DqYWXAFy1Of4qXaF9DJCgyxQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94f2fcb-cfa2-4db9-5d5c-08dad228fccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:29.2539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNlNWL2/A4TSYqnMy+1NEjAbeVgf2A3ks0aNc0f2hfhMj27fPYKN8BNaU66qbLIpJ53NRUYHUHlLGTxFSgKTSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: wIIPLfQDvp6TiXoTrAZRW6FRwSD0XcWJ
X-Proofpoint-ORIG-GUID: wIIPLfQDvp6TiXoTrAZRW6FRwSD0XcWJ
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
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..aa780a00bf4e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2926,11 +2926,11 @@ static void task_numa_work(struct callback_head *wo=
rk)
 	struct task_struct *p =3D current;
 	struct mm_struct *mm =3D p->mm;
 	u64 runtime =3D p->se.sum_exec_runtime;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
 	long pages, virtpages;
+	struct vma_iterator vmi;
=20
 	SCHED_WARN_ON(p !=3D container_of(work, struct task_struct, numa_work));
=20
@@ -2983,16 +2983,16 @@ static void task_numa_work(struct callback_head *wo=
rk)
=20
 	if (!mmap_read_trylock(mm))
 		return;
-	mas_set(&mas, start);
-	vma =3D mas_find(&mas, ULONG_MAX);
+	vma_iter_init(&vmi, mm, start);
+	vma =3D vma_next(&vmi);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start =3D 0;
-		mas_set(&mas, start);
-		vma =3D mas_find(&mas, ULONG_MAX);
+		vma_iter_set(&vmi, start);
+		vma =3D vma_next(&vmi);
 	}
=20
-	for (; vma; vma =3D mas_find(&mas, ULONG_MAX)) {
+	do {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
@@ -3039,7 +3039,7 @@ static void task_numa_work(struct callback_head *work=
)
=20
 			cond_resched();
 		} while (end !=3D vma->vm_end);
-	}
+	} for_each_vma(vmi, vma);
=20
 out:
 	/*
--=20
2.35.1
