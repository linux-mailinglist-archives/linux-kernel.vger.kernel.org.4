Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD866D46A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbjAQChI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjAQCfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B878D2CFE0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:35 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09aKG011754;
        Tue, 17 Jan 2023 02:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SJEJ71CHLPVQ9y9IwfIDwgRcUFzrXy+O3J54pk2rrrU=;
 b=bTx14I9Dq4Y4NFauaU90kEz4bNz+JxrAD8oW5TMN5o49K1QiRYLcpVVPAFYtm9uz/6p3
 cApl8BX1K6H3/Ze7Sjqs4CNQbYzt5UKvLcTZek7k8M+xUnnk0m297wRyirNDpBwQ8i+6
 HUS9Ca6d5/b6MDLp9O8A1wG8X4+t+zUgaFJU/88Uj+6lvB+FOd1WQVaf8HyJZg1sIgVe
 vV55DZ1qQw8rt1Gzi/HS7jV2MgNqWOJSN4YL/xqJsAh10R+jCU6hFn4wMlNn5QbJUHYE
 96YZj/3JTr1V7a3y/Dre9fuuc5JOQ6TsTaDpGVGVtHYO4192Zv+EesPxG0WncPDU5KDz jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k00urcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNUM0W004833;
        Tue, 17 Jan 2023 02:34:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10f0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doMujDCn/i04jUoWHSGCfK/0Wlcj4KrXd19c2ybQhelH87F2ga4zO2OrtjtRbc5mXD+ZMqk54AzKvVaQ3Qcf/7tX00Le+3s2ISmGsCQvro6iRIbgWrx8HF7Cv0gzJVt70JtTfS/7EDEf06jinFUz+D5B6jeazFmUK3GO1lOYNHeNnOgLkocCjwmtvJOdh24c+rURYCqBKYQz34dd26n2Apvd3qT4y6ZdcScC33Bf3Bo2GKrK4YDKSJ7f2E+i0s4zauxdYWgfDIFFPSmNBjHmlRxskkSEyayjpgtVIfnBy72Ec007uc4XsCpzhaRYSYh+AX3S2+//ijb0d9xK90RoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJEJ71CHLPVQ9y9IwfIDwgRcUFzrXy+O3J54pk2rrrU=;
 b=HpWTjt4ZoyX5wtc/pRlCotnFhAmBDf3mCPR2obx7dPzGfhLJEo/OD8OV7m0Esu6pRMrJa1qsVOtoPdYecZuIPRlfbAjFo1MAPvUgkDh44RYjGq4ShMHa5QeBqTkYxl1WVwdHxv/5pgTRMnZHBtNgtrxcWblLVkukHpEyP/2fqrjpWyburwfMwbLxsWwSGx9eocxUDQpJI9cEJcQI7qIbxwci2g8aRKP9HCyk7a9X85M4vjX63Vi9GTulxbVe5KLam4VuxIv928clr6tvOMNXVc4GkoZaAPBYLkUQSlwKHNqddACn8djuKiBeJj4xeZAX12gNNOcttGXGA61GtShGUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJEJ71CHLPVQ9y9IwfIDwgRcUFzrXy+O3J54pk2rrrU=;
 b=hxq46zGAnh93R5dAr8CChHFzfn+SBLVHmNPTjLhCW4NcAxCag4c86Itdj/OlzZMN2cJ4vOrvnJJkp5aavrKdQ6s3j4b/7VBNxSno05bfGY3OmRU7yw2P1MDuXZAkFN4ExahDGBS8p5tejgOd7XwW3nBCORnJaxDsEHSpygKvMRI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 22/48] sched: Convert to vma iterator
Thread-Topic: [PATCH v3 22/48] sched: Convert to vma iterator
Thread-Index: AQHZKhwygmPlOzt5/0a+OnzyfkssVQ==
Date:   Tue, 17 Jan 2023 02:34:17 +0000
Message-ID: <20230117023335.1690727-23-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: a4c9e32c-e7b0-4a66-470e-08daf833564f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +cySUlAwHEBsx8Ekq3J3uD0fzYDNpWnLv8E3rZN93ohyL/cG1VvjTwL51kt89Oc5PvlZCOosk5SADFmMlsTSjpOOqXXxN28qlj0lLQCryagUOspr6DKY/zav0RT6H6x2ve3EDFNbP0yg9mPJIpD6MlqUpE5DF4HaVoWqXUndip/pR7eboHRPaU70uNFLVd5xpW3iA+fPYwSQEYeuUvWcalAXHZtl2RnLXaBAp5Hzr8iILhtuNyX5gYp3amCkg36EXZ1iSGSCM0X4jXOafDJ6gbkMFp3adJF9ZW8fIRc0gz6zEtioUwf1XTyJ2YDIzAvOMROWRNsbfi3idp6r+TOUIjYZha5j6G6Dq89PJnA62lj7ucsZQneIOPORAWRNG6kba7BtHtevUTgti1TrhSeGj4/FcBI9ci3XByjezVA63I0c/Gge84dNvr0xVSKIR+Z1JOp2WyAfQq9aK+S0GcLiJLvpip8tS3MXpu7kJQLLq81D0jHo2Hcy1J0rzw5/TDARto8UwHA2AekrqxRdDhFVULSm0+j/0fwze5rI+q81rrPphQbM+ded9+yTlMV7eEL1l9BhTmj9CBku61UXrnpHDPYzYoEpdTWGRIRFAvJx0/N1eU8G/9WySHIadPWhQqOfbLV26eDqfnz0fVMFLzeZGcfr8rwaZKpHNIRUMRWZ1qT3hPw46/uuSb9fB5OzjdjUpBYqzFvWT3QYp3eY9Z+dXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iq7UCAF5woGURIilwLZHMZ9if4wwWDn7+0vdbaP2owIi8ydi+N4SPfKNEY?=
 =?iso-8859-1?Q?6/sKUzMmH2dKOhWzWxGJO/zkv8VENL15ExpYqJ+NOOfuZpyO+ANZBfNmR/?=
 =?iso-8859-1?Q?agY6i91MGD2Gq9jvVUSsOOha8nvI3k9kOD7cH24gt5b9pNlITwt9gk38/j?=
 =?iso-8859-1?Q?NbOyK0LGsCpdWfosm8kWn90L8k1MbxQBCsosYpoKuboUznRMDmVvJh8Avu?=
 =?iso-8859-1?Q?gthmMo7M29mUB3qETIeN5tGYskeImFoxIhz4NUfbJyw/fFnvf9vGpDUR7c?=
 =?iso-8859-1?Q?AMCyJKs3jx1acmjyGx8Bodxo5zFDxD07kqUhwcOzogYrr870VP842k1c9e?=
 =?iso-8859-1?Q?gbPa9F1rDek26PA/skfx4RKNBWpE84CZp2WqlmbBoRD7KyKQrzwGm5xTLs?=
 =?iso-8859-1?Q?U4t/vO5EyavtIR0YQaLyi3dNfLvwZdVW0B7IfqRuqML72jUNSgzC4UdwfN?=
 =?iso-8859-1?Q?+ysjjCREkVCS9I6mVNSSvAHF5Yb6n4OIT72ETZsUup91x3kthcNE7wf7r2?=
 =?iso-8859-1?Q?LPkcym5Ytn36ZCivD2RzSM8gFc+DYBswo+9K0OW4G4Lbq8ioO9IF/uR/Vw?=
 =?iso-8859-1?Q?sjzfRnveNI2u2B+SvLr5cxhk3Bbc3JAgfS1bWfyEBs8mgcaJt1ZlX04puG?=
 =?iso-8859-1?Q?fozVrP7BhaIr2pC6jSUmBxF4e2EMtVkiK47y1c+hilX4FnEldFM8L7A2Gs?=
 =?iso-8859-1?Q?vmpU36Jvp+zh+6SG2YL30trbTSU0zNqYDBAlBgyDwwYQrmd/NTwnmJ6/5+?=
 =?iso-8859-1?Q?ezyK3Zi+nQdbMm1chvad4ALC6FxDwKcLpXwx0c6pbgJ9uQAZnkhi+id75I?=
 =?iso-8859-1?Q?yZR4qSMiVRfS4iRGZpA5fAobxmIvMpHJlqhU+8Y8biG+Xwzv6nbrgSGpqa?=
 =?iso-8859-1?Q?u4vb8CEwrmD7rz00Me8ChlGZdnB6bTSWtoFiI+BEVDFgnPfhyA0QMXoKgL?=
 =?iso-8859-1?Q?UsFbQ2h9MuPXiBsm1V6gKd4FeOCGQfM7eZaLc+MrsCAI93AUQR0ae1mh+R?=
 =?iso-8859-1?Q?C9/t7cpniv5t975E02wu0OclUXGo00vD991WsQcdgtHUhVkGy1dRqV6t7W?=
 =?iso-8859-1?Q?MWmYk8yFv6oJ3vFk8ope4U33nsN7X8ruZiUKgtuvTcgL4rTj7CT0hAZGEq?=
 =?iso-8859-1?Q?ziukZ8GOZcRPDToTtUCJr4GMFUoEjR6XgqjQgRi5upkCukkqN1hxLFS2wy?=
 =?iso-8859-1?Q?1luy/dfwcSJdYdshm/df40FQ9Uqam9HELg3OHqiE0Ruuk3iaDL8nUfZFSm?=
 =?iso-8859-1?Q?tC+X5MIKysdcgqK8UiE9635tpNSK2HHDqbJGCZU1fr3I9jneG00N3XGjOY?=
 =?iso-8859-1?Q?ODcWJlsqI2otrnWCj9MElugdZK+njcZ7HS0pLwyYprzVxs7cnCguSDSVQm?=
 =?iso-8859-1?Q?DBiKW6obsP3fOWLc4MQYV8v+u+7+cWuLheEjvB1vAd15UWa12m7w3mPOzJ?=
 =?iso-8859-1?Q?BxSLw2qB0wjndvS+Sed3Fg4RXbu/35hTv10nR/RtrNydV47jGqQ7N5sr5a?=
 =?iso-8859-1?Q?CxyIzdZpauZ1pJBUzx8CC/pOjNLZ0eLU9xkdNz3ISoBvWXR3d5zhyX8yzz?=
 =?iso-8859-1?Q?PHa/XPF0QMtUNvSZf7S+kAVlCL4D+80IUIdS0WN2bV+AEXJPZ0CVkn1Xit?=
 =?iso-8859-1?Q?tkPwAvoZFSidLKtRf2adBcZqf62uJOuQZCD/93YClkQ7Ez/To+Yi580w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uAevaBtwWJv/7PYpE8VPBegeVyrG+2EOXZYE2XAoFBYexhHzam5SOBr37gNUMCA60BWVP5BbdRQyYwwk+jadIvFsQ0g5Il+5cSfwZ9WGfEKyDxmWXqWYv73272vhpo84rfB7XT+pkGIjTs/YVRAQ8pcA8Z2Nb87HOm4R84qn9f3OamHkOc5bq7iyI4/yc3LQLBctLEfWgxoQAkrMEekKDKN8YaEsHN3BLHqs1JrMVt/jQgkruNb0DcisuS5GKOOVhKZsxcWJXSwZ6lrvOhzaplmUv59bW2H+/6rJgi+JTLE7qJVgotFz4MMafZrU90EyJbjv8bySCL4HjLaKTZdO37w36zjcJ9WaHgPlfmY4qMFh7vyB+KtX0JPleRghrims/oJbxZh1NctiHwBq3Gg5EuiC8wejI5Ko7GcuTosjCRD4ZKFUBuFOGhzDiGRLW12L2pEclfQhTLmOuuhfgUUXrEyBSILcmsyi6Noqb5cBQ8YD//zlra9+gjhPseWdPXO65+O9K8sbSanozBEziHad5x8P68UZsJsH6l00gWB2FJdEN4YgurvcMIMYZYeHuWPTwAwYDA3Zcw3zx/CLDWBLHNBtDiP/Ko5AaYhi2K2CuClTCzYhONpR5Etw8sph8aqHnjpPZvBwV7hM+0Xhy3ahjLpSA9/MBGZqMuyO66IwfA9SFW1zhapWjwDEK4BmtAY+M0pC6Pe4uz5EUob3KTFsyoPKfi5zu54+KxGkOS4Z3C7cIMXblhpdG6zP2ApLvl3WCiK8dAdqL7g2YoeWtujkC52cEHV21WeOf5dgQaQbUo657f82/nd9kq7gDjoBhDz7IqTxlmnfMoehf4WDf9AnoFNlKdqLCa2yVHTqbGUXwqmN9xiJQ4H6zerYWmsYuE20jVGYr4H/Zl8pxPC9ZXi5jw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c9e32c-e7b0-4a66-470e-08daf833564f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:17.2498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5sunabb5p+r+Vvs1OfRtpC+W+/pHwP7lEH/np1zszSaYd0/+1hp1hv2tfjoWiiOZa2RSaZcPyV/DUVqK2MdjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-GUID: e1zw0lfey81-sNf-fIThd4C02F9XeLYc
X-Proofpoint-ORIG-GUID: e1zw0lfey81-sNf-fIThd4C02F9XeLYc
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
index c36aa54ae071..9c9950249d7b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2938,11 +2938,11 @@ static void task_numa_work(struct callback_head *wo=
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
@@ -2995,16 +2995,16 @@ static void task_numa_work(struct callback_head *wo=
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
@@ -3051,7 +3051,7 @@ static void task_numa_work(struct callback_head *work=
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
