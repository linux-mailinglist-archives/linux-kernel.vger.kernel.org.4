Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8B664327
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbjAJOVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238486AbjAJOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:21:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3998BC21
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:21:29 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AE5fCs014700;
        Tue, 10 Jan 2023 14:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aaAOYejAse+X/lc/zIFkjIqr3WyeVR0v2SzO9N6XTR0=;
 b=tuW+X9LYI5spLWe0FbAHkjMiEu48G6aM3yOvJkGoLn7unHBZTcwVOKICA/Rhhu5pB/Lu
 3Suua9UB9Dj0AsKoN4rtoP9yUVkMSnyjk+HnAP4k5LSLqDKss38nJqvihEZwpCXitL8K
 WyfVJt79V76z5qHecMgwj0Yx6kuNoo6vXdJQaJLLGripIhNhHJ3f++uzheGeJfCdgI5S
 PZ/sBKEUNoxcOi9de8zUYh0SKyqyvqq8GJ/7AcdmAxAtaNIxmY0/I5rwnANCpXyUHfGP
 21wxAjJLXJP3TaV+6R0Km/3ON3q09nM86OmaQqLggZLmJpRIA/8v3tGED3pbaLEgqqOL 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btn983-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 14:21:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30ADHcQo021435;
        Tue, 10 Jan 2023 14:21:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n18s9jsxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 14:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIMv56qrfl4Hdj8DZKS4KMesCcqoBnc2iiHnZLjIShFDT/x1Uh/7GBCN45vxL0jGhDRGsv2qr2oHsazpDY4j47mEO1/m30qbblEh4riF4lHB4a8hYuyLjyoC1JcZ4epKu69q1k1NkhvdLc54WKrBsQJSzWbjDCzyZO+sR+1fBWtTd93iJLJKbhR7H1OCtrTqkorVuiiTl2oB3LGHLg0oABD+bmIuymWcyDIokqk/4Hy8ll1jfBWmma/I0+7lsWFplWU1Tcpj8Z+n2Ef1yEvQYw9yMqekUX0PRFGtlgY1umQkF7iyHB4Xas7ngCdJClBSRQVfy3Md5sdbcyGt7GQZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaAOYejAse+X/lc/zIFkjIqr3WyeVR0v2SzO9N6XTR0=;
 b=YAk1lkWP2QH4DGJOWmGRcJ6U64+F5V0CbZHzdhy36SWMpZ84zcTN+lqnTp8CQTFe8nKFvESkFTF0r1Hfx+p4n1Q0C7s8aapQqvwNndGOu7SVfMe7SPLA6O2O/R+aJh3UxhwbQVbJOU+kCboMJfFn9InbsKMgXzzJtv4AdsZ/4B3XEw5woUotq6ZfoGMdUJEMnf+aag2LfyNlXUXcA4jhY3mq7nvqjDM1N9+cyg9gjvzx9yDarR6B81F0mliU7zIfMTooMu0v3bDSse2rlh2fauaUbK8pRydT5w4ak3FhLRWr0d9v4gZehc/AtlwePyozZtx4xQ//7/VtCFoZtUeHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaAOYejAse+X/lc/zIFkjIqr3WyeVR0v2SzO9N6XTR0=;
 b=jBWZ4Hf2sMuw2xpsDBbUq4uN2UNbYOajrl3w8qQe8PBFPWxltJT3/L6CthMND6l1KCENs8WLRdAfcoHIvtQIcYNt6uXKeguCPe37DG/mbhqFU6xidm4mO7U1g8RfjO6yW6zmPlMxw+sn7Etbgmf3apuHpKqPNsL+w/cGEhbkThc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5052.namprd10.prod.outlook.com (2603:10b6:610:de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Tue, 10 Jan
 2023 14:21:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 10 Jan 2023
 14:21:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     SeongJae Park <sj@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH] maple_tree: Fix handle of invalidated state in
 mas_wr_store_setup()
Thread-Topic: [PATCH] maple_tree: Fix handle of invalidated state in
 mas_wr_store_setup()
Thread-Index: AQHZJEs16LTgU8asl06B/cuTn0zvJ66Wdu0AgABH6wCAAADcgIAA9UaA
Date:   Tue, 10 Jan 2023 14:21:15 +0000
Message-ID: <20230110142109.gphhirh7jo67br6x@revolver>
References: <20230109154012.3342cbb91defbc485db641c1@linux-foundation.org>
 <20230109234317.1408-1-sj@kernel.org>
In-Reply-To: <20230109234317.1408-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5052:EE_
x-ms-office365-filtering-correlation-id: 26e49a86-e7dc-4a54-ebf4-08daf315ef0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fbh1T0EIuMfIZs5kh8pgLVFGRoQ1mJKuX0mSGVHe/NeE+nzazz8FE2LvsuxqA4BbPIPBHQK8C1xKS0iOBu8xjkHmOpaErdU3oYtEk71Q4b3mLx5M6n97UN8aah+Sp4MKccOz0eq5rv90mAg7/bl1RrGJFqqT2XFgKgqwg0zvOgqx9m9u9RZIvpE1vskKwteu43NEF2U4bYJh0SQ0uo/2CYFbqj18LZDliwAOueC1aGs75WZIU+QHaTYJHGzpzfJes3dURkapIBFLbKB+DiK3VxgI4kSkTPJsB3xSsU/KI6xUfpsSX20vHRyJ+APJCEMJXsqKiib4RGEVy/BxjYGWLCbzO8pr20/9MvEWbVdhf41uUVtt32Y4gXnFmXmZ10TBiO1JViCzCJafMDp4MGaGOSUxYbrikPD8L2fMMQByK1y0gcvGG0Nt6l1kw5eEr39phswRRd+HsHHKRkBFieM4o+5BfBJlzGj8hBWGqQnd7s/ylfsduo1p/M+zqmWHujV1WIy8QlYw964O8BdQjt4ols+mdn9TJtI2dKfdIYm3LDHoI8U3sJmAFAX0dyvDevMsI0QM2uh/OzNLUIjOsudWd5Mf6i33KACMgU87X9p7wPZkPUdiW2728gQI/dW+/S2xywuosW7D4gO8BZyiU/tihCs3yDeeFMwrFjXCcpkkjmv2hsNrY5wl/ZrH3iLd8n/TDyh6d4mQOZ+WgayBmWgrqZAc8PkFNDLw6JRKEDgSItM1o0U/T0VgLa4tmq6VrU3CLqi+jaqlfb35NQidARGeVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6506007)(122000001)(38100700002)(2906002)(966005)(6486002)(38070700005)(1076003)(26005)(6512007)(44832011)(186003)(9686003)(478600001)(71200400001)(316002)(5660300002)(33716001)(8936002)(83380400001)(86362001)(41300700001)(66446008)(76116006)(8676002)(4326008)(54906003)(66556008)(64756008)(66476007)(66946007)(6916009)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u2/uWDtArQUyKxvK5gFrCweniFKr+JjTclEcGnogmmad2XEV9icPODfozLDg?=
 =?us-ascii?Q?UReCtp9AIoalgpj7ba0tGeR5GkVYW4ut2IafP9Nb5lyhwxeexp4+CkyBpUzf?=
 =?us-ascii?Q?2C4QSQ/BZ8r1fTGnEdYWkh5vXyzZ/XNtZsx0mLyIh2goS7QHZbuayQt5m4dT?=
 =?us-ascii?Q?+lTvEh2e5b50J3kFM4p/v2WaUbs6+EXTJbj3d/X8vLm2bxOU5B8Nfzw/dIXR?=
 =?us-ascii?Q?eHe5XOWiJ3HbGsjMshFvdtSI+trOBv+CmGCwVbJNdTvZ7fMpMwxrJPetf9ZH?=
 =?us-ascii?Q?EZJknoWwjKhNENk7rdjzR/OABbsl8CHEkE5AhwUGTAMfeelgqJNuGQ71L0hY?=
 =?us-ascii?Q?AsOB8yyXDLfjSxnei8AZ5f5Wg62K8ToJwni7UYX4rwMILIOXrxaNkfNSfWrW?=
 =?us-ascii?Q?UWyXnlo4ohyr3qxtPhzFGGy0bjNRrVednRSIc1C0+d/0+AnPZDQoXw0dXZ2B?=
 =?us-ascii?Q?A3ChzdQa7fPWh1r333dXSkLRttllzNC3DICveoeFu5yZ/DHtHpQ/mGZlAahJ?=
 =?us-ascii?Q?AflG7TWsTZFN8paPxPFoI7k8sc5jhCEYlFHJgBoHPMSx5867w8umPZ3tdJW0?=
 =?us-ascii?Q?IuW6XAoUgpCo4ZY9rOv+/Fgean/t9HuzZRiscYgkdXjJFIWv8pwGoRcjdqpK?=
 =?us-ascii?Q?kOA1wApIYKfAjk5rVIvtZ3wz1oGi1PWo9pkNsJ+YIh5OqcHbRCImrhlvCEyp?=
 =?us-ascii?Q?OLa4MKwPGsliBHhNVY82HEoD3WiS4Eu2fILsO1a6Ln9Fa3HY/T8+nZw0VXb0?=
 =?us-ascii?Q?44nKog6lQqtLpy7+Y9Ygc+VKIw3DWAiXIATuTVAwJwn8ahPheW0Rd2itsJsy?=
 =?us-ascii?Q?EpL9uz+3ODMLvOXyi3+uFMv/gKQvqhPDG4u8MJ9iEEv/q7wM51DLpfaYpBYA?=
 =?us-ascii?Q?iVuRxNHXqWMH3t2FxGf3YlFnNNxLmpsbc8Tc3BJMTeJDf8RBnrn4a1DI+4e8?=
 =?us-ascii?Q?71swycyIx3tBxDMqUVSjLpFDxmFl8+CVbgUG3iz1fZMkK0Z4pJ8yvKwepD/v?=
 =?us-ascii?Q?8Krhowxiq9qTDhdyzq/rm3EsTma5X/llD7DD8+FGBwPj/ZQ0QV/bKhZMw4b5?=
 =?us-ascii?Q?OsSc87XQxGdUbPFLwwrupBbo1K8oNzicO+rZ9nNanqJHQHRaE/Kmp8s7OCYb?=
 =?us-ascii?Q?qbgYv1Pqy9VU50bhvezwBfKg98M4DJio6KkKcf0dqoAmQZcVnbb/qeT/NKh3?=
 =?us-ascii?Q?G7mNGrXtKDd0EdMCGegBI8h1leoZ+51hyS7gWcR2BByN2/7ZpWQcyigMd0ua?=
 =?us-ascii?Q?35zi1i7rpBXXTfVVLtsfddrQrRuoMbpyVMH7xJVA4iVstvnC5itCObmR46Rv?=
 =?us-ascii?Q?jNf7srr8Qdreviz1b9dlMgJHsft8a+4E8semsGEO3/eLUy+Y04kHsjpJUYbq?=
 =?us-ascii?Q?gJ/x5PfrVx8qo57nhuzAmkv942XQx8BpuFUshDX4zONDM33vkvIv4vhVVC4G?=
 =?us-ascii?Q?VGNxngWmPoyXosRO6s3QXl9l+3Ew7U1IaulX8sl/911asw/5XLOD0MAsWs+k?=
 =?us-ascii?Q?fV6n1vTbppE+gEYeoRevd4ksAMlkEMVOWxkqDLAmYcTzxFL7FqL/xL2bAU6C?=
 =?us-ascii?Q?jtiMAxjrI7vNiZcClJ2tNhTyLjFa4QzHbXAAUd3eoOCWbfLepjGZwHTiH1I9?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBF230D0A9368743AB586F777B6AA6B7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZlLB+LjxBeSXVQaKCiOkXrBhQn9mFdmGWY8nNsyHtgRMC8uqqbjkMRVZ5HetCA8Mn/hVpgqqLxCtCW/zR+/UvQrdCZkevmatRyDEKVq7wJh9wt/7YCYMHrKjA9xmVen2/3Z9bSehKjosj+OABZeYeV7o5KEax/kDSCrXMiG+wZSTUHzZ01JskLoo0Gzt0X7wnT55lbWu4b5e11MTqq9WzcbIF4BtYfSK6LzchhBTxxjiwTBQX6Kk8zlvaMoFCBSjZQC5z0EpCec/PFhnh/s20fLk1bz3ST5Annqy1RTAZom2OKiaovSDy+IQV6kxGRDoWNBTcaPaz8aXdOoLCvkgZYXT0+dIStVwAat65t7AMPzbzVEltSKv7WMgY93V1gIH9zMTW3dMh2EMJmbW68qw2I2AvSgL8/kUefRKWDCdh5Y5nhbbHnSpsj6d5sRz7UUyY7vlwqV0Csec8BgImyiGncbU/hdcJWf3QTYSGi9X4wWLmIqKI6XMLz6+ls5x9f2AofMmSgqhLeE8yi/Sj5zhRKdLnyaOMgZHLevOxpTJadFwfXd1icW0iwpAn4JuO1Fi3K8lRaoAjYr96+pwzOzIy2/2Y5TwnfC2L6JdmnFDKWun1nUSAlELLsG4gPyIc/tpfe9gW5VMb4wQ0yOaM2wwI2eSILMb1b24isCHgXoiIKdemdombm6eVVsbR8ZWXws+yEsCaTNGW/yki/nDIlBb+WZKBnLjebbBW0G07rNjN4xhzJizXj6ncQjdC3e5knDd9/gdAuErV4uArPBldbmM3+jve2v95+y87BY1UeIRolv8MYlTMJ6pvOxp9TkeY3bhyYUL9ZjWd20phr4erVCmUkbzhkUo2iIE43MNoWJcs7b9z5si+bZr1Qi08UoM5bEXfqmkcX94lKJRO+OIvW6zq1hIKjDMlADSwPXhlnu4+0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e49a86-e7dc-4a54-ebf4-08daf315ef0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 14:21:15.6367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dd6AlmjkUMvOOE84lnAE1B6xPz/A9lE82bi41A4GFhFyfNm+ynwhEc6C7PmceLjSXK8JgWrQkoLOejH37GmuDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_05,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=827 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100090
X-Proofpoint-GUID: nMUsZS1QmrAZ2qamtyWZiqOquwiiBxIC
X-Proofpoint-ORIG-GUID: nMUsZS1QmrAZ2qamtyWZiqOquwiiBxIC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* SeongJae Park <sj@kernel.org> [230109 18:43]:
> Hi Andrew,
>=20
> On Mon, 9 Jan 2023 15:40:12 -0800 Andrew Morton <akpm@linux-foundation.or=
g> wrote:
>=20
> > On Mon,  9 Jan 2023 19:22:48 +0000 SeongJae Park <sj@kernel.org> wrote:
> >=20
> > > On Mon, 9 Jan 2023 16:55:42 +0000 Liam Howlett <liam.howlett@oracle.c=
om> wrote:
> > >=20
> > > > If an invalidated maple state is encountered during write, reset th=
e
> > > > maple state to MAS_START.  This will result in a re-walk of the tre=
e to
> > > > the correct location for the write.
> >=20
> > Can we think of a Fixes: for this?

It wasn't really an issue until I wrote the vma iterator store
function.

You can put this before (mm-unstable git id..)
9df3d25a97ec ("mm: expand vma iterator interface")

> >=20
> > > > Link: https://lore.kernel.org/all/20230107020126.1627-1-sj@kernel.o=
rg/
> > > > Reported-by: SeongJae Park <sj@kernel.org>
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > >=20
> > > Tested-by: SeongJae Park <sj@kernel.org>
> > >=20
> > > I confirmed this patch fixes the boot failure issue.  Nevertheless, t=
he 'make
> > > install' issue on my system is still not fixed.
> >=20
> > Is this a mainline issue or an mm-unstable issue?
>=20
> It's mm-unstable issue:
> https://lore.kernel.org/linux-mm/20230107023954.1841-1-sj@kernel.org/

Yes, just mm-unstable.=
