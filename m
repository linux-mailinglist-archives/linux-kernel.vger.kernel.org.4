Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1494663C570
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiK2QpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiK2Qom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A3A45A21
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:39 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGQ1w9012682;
        Tue, 29 Nov 2022 16:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dwXa96mmtavLyIPWSQPEFi0lfaZOBC7s5fNRIY0AmIM=;
 b=qZC6ABVp6NVmfAQMQf/baXeaBywWla98HK1pfviHMFEses52yc7czsDWRFgEgSuodjsq
 jwpWi30bIwmDh9xfLG3x/y45tUCphLrpCeztXgCarQLtyy7pgzEUTEPKNb2J+3oOfqXd
 x8NNaGECcOuDKJPVe+Vf9fB2yWntIHD/zCRuNbYf/RESXxiE7PnjxKAIjD+zA+dFnivh
 rPUjzf4f0KkCxV/mlOnvytI6HY8ndMdjPLRYJai62udW32NepAnuOM6+PgqQc6PA03o+
 3PKL5IX8h06YeNt4z95Pe12+4Pon1dvnWeKRcSEDngWsHjsm4V7w8DizhgXAxZUMiuxS bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdn97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPf027963;
        Tue, 29 Nov 2022 16:44:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz0Bks5vH/8wveBZR4UwZooch1nzjvALHnSL9At8AIkabXhh1canu3Coqh7j1ytxtCwtqnjf6hJAXgqEAa7BPhnCSrBzDvCOzvDjtZYfAhPV5Fr38/0MeO/QjEoh6LHOR69+NVtW6eTv7IadhNFsZX9cLbYBj+EDUvAN5YrKX1zPVqdmNUG4mQio09c00Vw6ZUwU4PcxlPyaCgP7nyYYIEOk+sbaMoOKGz9u8xsrGzLb6332qY8lKQdV9goyYdgI0Rce7H2bTRHBhp1Y7bGb+a0wIMWELqc+g5+ZW7bj4RWCerlTNlOmP1whQEUrQacloYYiPPYf7p/iTbOJRPPhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwXa96mmtavLyIPWSQPEFi0lfaZOBC7s5fNRIY0AmIM=;
 b=LxvFIi/SFUzpxSLQPtZvn9o79DxXsWY9reu80h6iw6lpJlPv3g2Me0PxTLI/OYgDLHRDJudN7sVTqEbEf3JBfvDkDAQYJ70sTYTust1rK/zwq/TFTDgqm0Y5+mrCn8YmB7+X6VqT1o148+1ZNmSejLaL9Z+/WmtkDtCNiyGgN2bqAIT0+f3s3bQ2v3oCPsVwqnXORAKmWH1/oyuV4ZRajE4ey8YF7M8nO7xh6ve9hDtoH4fUFHGXr3kb63w+xroEAyBe2OZORSA/KYPF3vpsEfi5+kxC0ID2vJA4jQqUJfRQuOPKBhjf/X6kg1p43C+mz21h+SE5vUmfM86QMqT6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwXa96mmtavLyIPWSQPEFi0lfaZOBC7s5fNRIY0AmIM=;
 b=Fz09D0/cF0l8YUUgKZmRYAoVRGsuD4f+vU39Xle4l9deSeKrGw26iWiQ7Ec17UZhrkZ9XWl3cUBavEA2j2JC03iSqAuqLcqexcnbYUSeHW4WWogazQrU2U9QtlIyh+TWEb6BUu7No6MFa7obFV6YMe2sAziKVVQ3qmjtBxrBQ5s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 14/43] userfaultfd: Use vma iterator
Thread-Topic: [PATCH 14/43] userfaultfd: Use vma iterator
Thread-Index: AQHZBBHX3uY+RWqtqka1JFNycfUzzA==
Date:   Tue, 29 Nov 2022 16:44:26 +0000
Message-ID: <20221129164352.3374638-15-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 991585be-742d-4a35-2d03-08dad228faf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o5srJ630F4/Ry+rF8MYYHv6GQvl+44cb10PGIFkLhG126FPnlf3pKH7dQv3XG/OGjeKclitDD3iSYtIkMczcwj1WLTtGV/BOEN9OYvESN9klia9dCaNWNGWkE+mhD93pqTXJZn32LjQjXNyLZmNo6J4iM6v/T3MVOt0aks7xBbLIEWolk8do30YteGvLOBnfy+AWTcub3Clm1A62Lbd4/ChGNIhMG6nhCLJvnUDkoBpqogmCauFwWXPTaPL2zWNNiahBHdatz/2WHEx8R/WLtspDUMgCSttjVQR4GRdcibYr/HXmxosyZ7vDeIXSFt3LYIg3zPGVYGJMYkVtbcmIGJ5voqohoh0zTKDG2IuNJe/YdYcaaU7waza7/L9pBHSVnqYGfMfAzCIIJV8YRD8VhfPKVL0vf3L2FcXo7Dk5Kc+xtM5FfqgmdzRPw4bFC9C9UcHYt5FgcMgMq656KZaupFIPbVyzBYsugfXBdk5+3EwRAr+1n/HYZ46mME83GJOf60SvM2LpudGdbdES3xXKWgNvkxfZBxN46v9xkUX9/lbNurMZp8qiU1CZCFdUE11oWwP78YYoT+Vv3JZSnBHgJtzNMp8bhSFIY7O8L7njQekLYXRwtczd0AjVpRSDjisXUWhhtZThjq5DF0OmDp5+A4AqENhOS4tuUTMsrdbeBfedB7FtU/pRL1hbcjUy8/7dg7h/MCEQrZjHag67vM46ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TRkzgKfP9OK1bxSRvYpHDinZdiJBVWChSmpMRY4QxF2LKN/0XIbvYFNqI0?=
 =?iso-8859-1?Q?xoe60iJETDHhESNkZ42ix7s2fas4Pf3Dz9oS47MlWZAYMKNi1jnvcTn03f?=
 =?iso-8859-1?Q?buzt6RtE4BmpTSz0o85GxN1IsRXNJFlP6c4NkwM/rNuG7eARhs1MbhcvGG?=
 =?iso-8859-1?Q?x4weYW8e8xHc029D4Y45H5Ww2Y/J4y+kaU9r+2GBGPG4Xml6ddJfex+z9j?=
 =?iso-8859-1?Q?uMBDngkNOSRNRBkB4UJtpTF4v4Gx/DaiUhkUxlmciueGHw+EYDQWmt+nOS?=
 =?iso-8859-1?Q?VOMCmikButGFSphDdnfp7P9ZlKLAqrchEERU5ROLDQQd82scdaaFYT+3Xe?=
 =?iso-8859-1?Q?E78/8kGCEncFdhi1CRcFZevGl0MMMRWIDD3mSiG0TP0jie1o+EtJliYIds?=
 =?iso-8859-1?Q?n6czASHVR1HvXHxZHyDkgY3EgN/9bkNs6i8jOGNk2L3cqwDJkhO6lTW4NR?=
 =?iso-8859-1?Q?TraaBUfBQcZXRUHcEvJW+N2PndcPX8wG6U67yUypaVTk2BIw8zZvYTMPLb?=
 =?iso-8859-1?Q?+iQvQPTmFtu8FmadFJruKVQ3GP9SMOvdU/Dmqomr3ZHTiAA3LJhLhZodcC?=
 =?iso-8859-1?Q?2b7SapxLcERav/ZjJFQf95qTaiPRniIF7MnLNNKmFoAOs4Cfa+f1wVTvAF?=
 =?iso-8859-1?Q?SJtxjmBD3q2P/klPsHn/C5fO4sBKOekZ9l+5LZnr+ZBqRHD1vsUr3veL89?=
 =?iso-8859-1?Q?hWXHrdfyY4BsJkXtP68FbPVGofyUQhpE9U+VBMsievrNoFriONSTTycXad?=
 =?iso-8859-1?Q?Kn0omVOj5XLsCV154P2VpCYAOr1CrLTpnSufR9jct01rWd52/cY1WWwIw3?=
 =?iso-8859-1?Q?ZowXiFr/ZG7p2ZMgfPuQgQO8zXumAkPa4/ekG8v2lWSpasLqBoFUdSL03y?=
 =?iso-8859-1?Q?CkCfVUWqPBQUmf5EoP78vvXWNFml5bS+wxwkwW5gQ4DcTQMZBwCzqt47Qg?=
 =?iso-8859-1?Q?LTAOQpPtwO1i/KxJqzbFq14hnxxDfP2faXNlIUpSCT2S3ryM05MqqEymF9?=
 =?iso-8859-1?Q?f3uP28+8JVREmPlqWK64shIAZOLf0BDw1oEHfSFqllAX1hhiXXNimNoX1C?=
 =?iso-8859-1?Q?DcMVOK6QT7a0nfWK8H0tiLLHe1cngt3vehVcOFLbUUKAoxzOAyjY7BKgKU?=
 =?iso-8859-1?Q?X1tvr1BDju/h3cunlfiDC0tzWZGeiibbrMk3JpHf+KzLAQCA3QL6j+hzGk?=
 =?iso-8859-1?Q?bylClmPyRJLFpO140CmNDFrAmVUlbRzn9MQcAK9px3OpL44haxCTHYyRxh?=
 =?iso-8859-1?Q?dY+0LacwvwYb30zqWyavgkQSIAhwoZqU09MecgU1K7zj/UsOf9oBed7eY6?=
 =?iso-8859-1?Q?0+PDjqtXqHI8Bxz4fdzZPGd2SMOUMIoP38Nc05rrJdByc+hiSLSbP4Iiyg?=
 =?iso-8859-1?Q?hrYyEPFcRalGU9vCZFdXGnQE808828vBQRguupJrt/czpde/Smq0xS/0rT?=
 =?iso-8859-1?Q?aB5GIjbcJKOngEo3+iTseAHtKKIMUDUQvMuBkPzTrl+UM7mA/FE3uuQbUx?=
 =?iso-8859-1?Q?v275RNoiIh8hM+i9GtejeUVzzfEbg7U76d+wvC3I1/69aQY52SLQ+HrOgi?=
 =?iso-8859-1?Q?E1yKfsxBRpr4vyy57e9SJpudwauqqTyDrVrf85joZrM59t7wdqvUBhWeAO?=
 =?iso-8859-1?Q?tRe08TvAvjhqoLZGor1bZX9b7FL0+hOrQpZY14LIEbAL5gmwDufVPpVg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FYPs9CNaVHZ307CUZTFI10AvihGHqRdHJCHqu9E4C4C4SRUnVJHS7z/JgjNNhYW7jaCB8kLsEijKV9idMB2IW9vY0N0lhfKVcjUi7hEPfGIm0wKKIX8eVkutDa36KO22+MB6gTCstGj7ZXxiEVVITgWFRdmldJ4nl2d9XlZSmwOe/1nPEP7QF/R6TgZ85bMueVoM9cdh4eRBxaP0UDwDsl6rUCbzEvGXRRCPbwDnw8mt51e1YNfxQfZ6u6guiWP7gMwrGz4dM3FPw3mp6kCbfXr6CPl0laJLyqTdE+AqvEWLf0vFYH1qnAAyul4HIyNB0A22V/F7rsuCUwogSKW7Ss5jttN9G+6qCYT+UUFcYO2il/kmwtbH5l0UlHUpql0g2OgzeuKlUN8OmZfsrQqoU2ap+XKNt/LRXuNEN9ng2BRkcnLhV382d8C3XphL/4jPN238sNYAW5X8ewFRoIVI/FEfTLeS3W8962YpRwdDY0rvP3LOX78G8tIv66JiSqLUk467xtQ51ZQi4bkIk7nEYoLPVNiMRfkv4BykMm/k/zKrQ+hFn88329hi4drMCKygHPooQHmcq/6pR6G7yo8vNJ+3HFoXcUm4FEJFZnCn13k5H3s1KzsPFeii5xOIxY3S8NLhMvFsBxCPAUOWzY67E+YM7n/vPhXiWBTtqkvLhBX6VXW0uDeBMgzzVVtsTR8zldjfkVhenqnGayh+fVZfpdqWHAuO0VhNIcHoHtqoVOB0ZvJQG1SefZkESeqit5iEA1uqqapV77TalsucG6bGD+QMkch11h3vHuaIwmUTb7dofSnEwFDKLU31di1GV7syES0e+Ahdz7BmjK2e9GzoWMUdmfiydiZmIKLYxccKfFOnqB2d1Fh8645I+SLO5ClrivBfjo6Bat+zLe/aOMa5Rw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991585be-742d-4a35-2d03-08dad228faf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:26.3791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10EMOJUE3mEAJCI9txv82yd0Wrt5xOP3I0ojDBLM+jBCZ1vLH6BL99qqmxVgJp0GaESVwREc+nIuz9HYInkFhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: gJIjFeg_44BfRx2EX6AxeBTR5ezgQXsq
X-Proofpoint-GUID: gJIjFeg_44BfRx2EX6AxeBTR5ezgQXsq
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
 fs/userfaultfd.c | 88 +++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 54 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 98ac37e34e3d..b3249388696a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -857,7 +857,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -874,7 +874,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev =3D NULL;
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
@@ -883,13 +883,12 @@ static int userfaultfd_release(struct inode *inode, s=
truct file *file)
 			continue;
 		}
 		new_flags =3D vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end,
+		prev =3D vmi_vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
-			mas_pause(&mas);
 			vma =3D prev;
 		} else {
 			prev =3D vma;
@@ -1276,7 +1275,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1318,17 +1317,13 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 	if (!mmget_not_zero(mm))
 		goto out;
=20
+	ret =3D -EINVAL;
 	mmap_write_lock(mm);
-	mas_set(&mas, start);
-	vma =3D mas_find(&mas, ULONG_MAX);
+	vma_iter_init(&vmi, mm, start);
+	vma =3D vma_find(&vmi, end);
 	if (!vma)
 		goto out_unlock;
=20
-	/* check that there's at least one vma in the range */
-	ret =3D -EINVAL;
-	if (vma->vm_start >=3D end)
-		goto out_unlock;
-
 	/*
 	 * If the first vma contains huge pages, make sure start address
 	 * is aligned to huge page size.
@@ -1345,7 +1340,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
+	cur =3D vma;
+	do {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1402,16 +1398,14 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 			basic_ioctls =3D true;
=20
 		found =3D true;
-	}
+	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);
=20
-	mas_set(&mas, start);
-	prev =3D mas_prev(&mas, 0);
-	if (prev !=3D vma)
-		mas_next(&mas, ULONG_MAX);
+	vma_iter_set(&vmi, start);
+	prev =3D vma_prev(&vmi);
=20
 	ret =3D 0;
-	do {
+	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
=20
 		BUG_ON(!vma_can_userfault(vma, vm_flags));
@@ -1432,30 +1426,25 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 		vma_end =3D min(end, vma->vm_end);
=20
 		new_flags =3D (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		prev =3D vma_merge(mm, prev, start, vma_end, new_flags,
+		prev =3D vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
 				 anon_vma_name(vma));
 		if (prev) {
 			/* vma_merge() invalidated the mas */
-			mas_pause(&mas);
 			vma =3D prev;
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret =3D split_vma(mm, vma, start, 1);
+			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
 			if (ret)
 				break;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
-			ret =3D split_vma(mm, vma, end, 0);
+			ret =3D vmi_split_vma(&vmi, mm, vma, end, 0);
 			if (ret)
 				break;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 	next:
 		/*
@@ -1472,8 +1461,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D mas_next(&mas, end - 1);
-	} while (vma);
+	}
+
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
@@ -1517,7 +1506,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1536,14 +1525,10 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	mas_set(&mas, start);
-	vma =3D mas_find(&mas, ULONG_MAX);
-	if (!vma)
-		goto out_unlock;
-
-	/* check that there's at least one vma in the range */
 	ret =3D -EINVAL;
-	if (vma->vm_start >=3D end)
+	vma_iter_init(&vmi, mm, start);
+	vma =3D vma_find(&vmi, end);
+	if (!vma)
 		goto out_unlock;
=20
 	/*
@@ -1561,8 +1546,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 * Search for not compatible vmas.
 	 */
 	found =3D false;
-	ret =3D -EINVAL;
-	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
+	cur =3D vma;
+	do {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1579,16 +1564,13 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 			goto out_unlock;
=20
 		found =3D true;
-	}
+	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);
=20
-	mas_set(&mas, start);
-	prev =3D mas_prev(&mas, 0);
-	if (prev !=3D vma)
-		mas_next(&mas, ULONG_MAX);
-
+	vma_iter_set(&vmi, start);
+	prev =3D vma_prev(&vmi);
 	ret =3D 0;
-	do {
+	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
=20
 		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
@@ -1624,26 +1606,24 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 			uffd_wp_range(mm, vma, start, vma_end - start, false);
=20
 		new_flags =3D vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev =3D vma_merge(mm, prev, start, vma_end, new_flags,
+		prev =3D vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
 			vma =3D prev;
-			mas_pause(&mas);
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret =3D split_vma(mm, vma, start, 1);
+			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
 			if (ret)
 				break;
-			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
-			ret =3D split_vma(mm, vma, end, 0);
+			vma_iter_set(&vmi, vma->vm_end);
+			ret =3D vmi_split_vma(&vmi, mm, vma, end, 0);
 			if (ret)
 				break;
-			mas_pause(&mas);
 		}
 	next:
 		/*
@@ -1657,8 +1637,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D mas_next(&mas, end - 1);
-	} while (vma);
+	}
+
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
--=20
2.35.1
