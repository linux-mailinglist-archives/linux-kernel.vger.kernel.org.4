Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E654763C56A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiK2QpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiK2Qof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0A854B36
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:34 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPitT017353;
        Tue, 29 Nov 2022 16:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MeWAgNHkqtDGHNJyVDaXVgFTDWgD+IXgAuiuBpJtiEA=;
 b=2crd6MODmo0wIt7NRa0JXs2csMz5W5gzOHvkbc030KwdUpw+0DsNqvo74GJrhbh5TRNF
 IOfbHRKIZCaLVIVR6FGoYUzTNZMwsHBXUcWKEfBApwO1HRLVsdK72PzE1kiO1GJaozx7
 G68EEPl1GpFAUAQZVdzeLDt75+NiAQagEZQukE6248w4GX3gzjcsgdQeNchLuZ6q1EYj
 ZdBc6GN+vJAmcuDSqjjzZY4eWig+DL+n1QW7gMvd6Yxhvf1WB+aM8MnAu28AfZa9Loi/
 lF4qeox+Pqaa8O/qvCuufotU0nKG8D2Ni2hEozc0fFocA2Jhf0bhpZg3s2IwjD50Uhr9 IQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xht6hm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATG7rBY030968;
        Tue, 29 Nov 2022 16:44:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398771pv-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhBK03iYD64DzTBDGNiniEqkPXyU0JlGmsG59bFcqmtVmvhImmJyo4TytJ13NDkl7iXzF3Biz9/ve2JVGWbJeXvKoDGT8TVSDIdzTQkJHBkdDS1ztkWaXJYdozBX6uXrTugQMBxFsv3FMGMuknjVs7HQM0O3nk2K9CnnBIqeTGhhbWq/VJjXW3GTEO5fkBuwHcRylzt63Zj4g5Csadqi4gnalY3En2mlmGPou3r/hZKAJaGHjAEpGf3d4l06nae1RczAit6pMsDom5x/2xHJO2urChIYS/ySbJIw94OIJNJOaN5GlOkRuWbVRocVrNJFE1ni81ASxJuKcJBfrMqafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeWAgNHkqtDGHNJyVDaXVgFTDWgD+IXgAuiuBpJtiEA=;
 b=C0VRugfMEvfKTplWtpeJVwa7AyJR9Gg70YxsKWv27I/U2VozQIh2xVshyhx69mraJGnvkAz8j755KvyZzdXjMnHKqmxxtBFa33gHO58PXoN1znI2MnmTiGbXSedAjNNMERR+s+804axO21n+3T2QxvJ09Ac8qOjaN0/kbCZytx+dhdJB111Ri441yBxnuvIa9K09KlodiyXnk3sck0eToQFlR8pPEdTI5rLwrbAMyKgQwl6hFGmiXJEqxiI/ThdUscS0grHPJtnbFlyO1On1/TVHGQoUk3YT+ZoP3LCX8JckEImVc6z0yQEdaId9ellOGq4yRn4jn1bfmoBvIurWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeWAgNHkqtDGHNJyVDaXVgFTDWgD+IXgAuiuBpJtiEA=;
 b=bPQ7Xamf0A6cS4yN6VeJ/0IfxqnDiCdRxImlC8lL8M+dczTarI3SI5BaK9x6nVv1FCMa5spMk/7J4AlZwqVZdDrqyZfB3g/EORqjeSrm4irRe4tkdagCoOZi9NdevJQRYcLD6cgaSAgPU1EWkU4faIwyCcr1RTW4nt0vjYJyh8E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:44:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 06/43] mm/mmap: convert brk to use vma iterator
Thread-Topic: [PATCH 06/43] mm/mmap: convert brk to use vma iterator
Thread-Index: AQHZBBHVFu3dWvklbEa+O/yWENlnqg==
Date:   Tue, 29 Nov 2022 16:44:21 +0000
Message-ID: <20221129164352.3374638-7-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5321:EE_
x-ms-office365-filtering-correlation-id: 6ce2e79b-72c3-4316-230a-08dad228f7ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8XURLunfrUz9TAb/p++Ph5h6UoaPIDBO3DZcZd4xloEWu4zMvXcL1ACyqUpNwefqGx4XcCj98bn2s7oah1VpJlkK9LouSoSPqo9snzVlPcklmHgJhk+pFNEh03CYl4q1TNJh1rlIULVQfYzxphgH67OlEzVWhXvZRcKX3dhsxFr1zSaVIs/CVRrgoLsaZjrZT3RNqy+F701e5eNDlXpc0JFTc1sZBwwQMdCBJg/2GkE8zus9seVwVrotHPtGBCC8TCuL9m9GEtqeEV1vnBVt+0rsGgjzIAUNw0znn4T8uZnRaY5zE/u27deu9yQMsFQVkcODdtuI4c2LAd4XgpRNyK3OVzl9F3v/AFRc4I1HqPS7SnrGTQM8A0BWz/eCpSltSpN5ajt9A3iGFIQRbPCvHshbXs1sRQiDDF/kUMfKRu8mBRD9H1G9+ymPCUPolt/Ihv3AP2N0E0j9SSw8yEPMdZR0bfTnnLN2xnlexBFGw9oTedWauwzfZqrUmpYfiy8PvIrqKKDzj+9ivEML0vSeewF0uMqFoM6QJrorgpKNe41M+zYo5W6N5YImXt5WGlLOGTfOVb4etuHlR0z9oVFOmMmsnGODINcHvyaMKgnQzqoDFumqV2xWboZDUZo+aazhwpqrYXIpaxlfEVB4D+Ng+7bMXQYWxRWzGLMh2iJYvJGpPYMNqfmVPrEALf4wWgWSSHY7NM8otgxu22qfowYNrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(83380400001)(54906003)(71200400001)(6506007)(107886003)(110136005)(6486002)(86362001)(36756003)(38070700005)(6512007)(38100700002)(122000001)(2616005)(26005)(1076003)(186003)(8936002)(5660300002)(66446008)(478600001)(44832011)(8676002)(66946007)(66556008)(64756008)(76116006)(66476007)(41300700001)(4326008)(2906002)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pCmVH57N45iy43sy8oQOv5ucsDYOAgihgp9614grIX6RMOyLPKbOXZHpKP?=
 =?iso-8859-1?Q?y0OFbIxWfuPkj2vaeHsJh7aTYTi/saC68CBfrJyMNZ+JloNR4DbsYlcZHt?=
 =?iso-8859-1?Q?M2WM4wNKIhzXNxo81Ep65Gg8U7ti7BUxDHPAs1+/IvlcudAzvyfarb98JL?=
 =?iso-8859-1?Q?gwVl8kGv5OeiqsGDjYzSpBMmuDhFKoxs5xezNp9a8NpzIZQEnb+yzMay05?=
 =?iso-8859-1?Q?+lKVaF9f2zwD8AGt+mtHJ86AbYdxutDk6qTIiKZhUxD83IsQO0M3gi+7Xg?=
 =?iso-8859-1?Q?PSDbWUCmjFVyUi2ZxEtadvAezj/QbbO9Vc8Xi0bffvjmiku6l18wQqUqjC?=
 =?iso-8859-1?Q?Yuu+iZtb5maUxOEPdy9TIbD4LyeLbSgtmEKNNg3868eWTk9hS1Ws+W5pbT?=
 =?iso-8859-1?Q?/HCrLb9eQQ6liFivNK5Co09FkSZRK0kch4l2RpJu0QPZYQajXUCOeGesBk?=
 =?iso-8859-1?Q?FpUYGk9XnmGOSKGRCMe9uN2pWY11Z7O/vpnunHgFCN7w3hb0Gzec1aBaN7?=
 =?iso-8859-1?Q?O1hiD3xwLGcaaN5UrVs2qMA3sIgxXJMZ/dbkyurIcY/jUxXqJk2Vy5LMSc?=
 =?iso-8859-1?Q?cIkbw+2QV8dlLQ+Qg+7Fyp5gVB/RkTLK1WjDPC41XSkK7bQwy5XtWPpBUf?=
 =?iso-8859-1?Q?wB6CYYE2oWDWrrcDHywQOuO4GOkDJt4tiHUe6oBMKm/ptBeN45wTvN4uCY?=
 =?iso-8859-1?Q?jHC3X7wZr3Wq3tV8QREC6+CmnP9can7SQc2CisvaxeLJ5u4+dAfiMIujsc?=
 =?iso-8859-1?Q?NqPUqE8HFzxX7TeMJ6W7+6QsFteVbaFLFUdSyoWkIOiELUIm/W9vJw3smW?=
 =?iso-8859-1?Q?HmNxAbeBdydHewhJ4VcVtx86KaXUXp77FfhW2AvKTAvFocHTdQoBdLNVrR?=
 =?iso-8859-1?Q?OWGQu+tJ7NH6fWcbXnNvL2RAGbgjpz1sWz5aBzSgw5lYSZ0bJgzalYB6AT?=
 =?iso-8859-1?Q?V05pN+1ccxp8W/Nve0Fye5rscIUU17Ui57JfqX7UCAefRFKZ+h0oqx9CsJ?=
 =?iso-8859-1?Q?1rEEBE2cvlLda2BgrlNk6aL3w9tEJmidCsHH+V1LSDa1/EH0NugjURsQ5F?=
 =?iso-8859-1?Q?PPTOfKzzI3NY69uVgQN5+EUdVC6kX1EcN7ekvQ3uD9qrj6r2JsqFI95r8f?=
 =?iso-8859-1?Q?nkT1PmfhnFjetgZXlZADZOQo/uQq8f8uqtzXdBkpFGKYlA0En1XoguQRB2?=
 =?iso-8859-1?Q?updQV9HwDeZjF8aZ9rk+bBhd3LZwAxUg++ZsEmj2ol5sqv2lUKE5zUgshm?=
 =?iso-8859-1?Q?6haMA8O6/Pxx251FxVZHCSn90bG9Gi3WCHlozM3a9siHWJtkexVcqzzQOT?=
 =?iso-8859-1?Q?v347SZ7ANdkNcIkrFfZCIV2y895O0rqWR59lKny1I1RR1b9+PeTCNXeTzk?=
 =?iso-8859-1?Q?xtotEC5eTx5EEbLa7Xj/V5Eponuz7rYBpjY51bLVtJJRPmfbGbOTNpEhHj?=
 =?iso-8859-1?Q?j6pNg3AbaRYO91m/U9xwQ8Xa6tmjF9AxqBH7PkA00btademnCMn62BJw9v?=
 =?iso-8859-1?Q?cRwwNLy0H0KNlIRKwPbk8WRRiVG1x3LEGEipPt4wd7dI6tNBu8WxDv/sFa?=
 =?iso-8859-1?Q?Ksw0fcM3/KRNs4VKs4Kh7xLupjUvECoG2Nu13sSEGfP/JeQdv+x7Jivb7O?=
 =?iso-8859-1?Q?FvLZApWHs6Psydc8RlpFElL+H6Irq5ARtFA57hiRuZtJgGYbGx3OpzVw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H4aOooYZd7rgR7GnDGckBxxK8Biw0zi1f8ImB9dU6IkgEFfmJVl4l7R+FiH7wQItKL2cS/3mQMGRw7mCu61ietPEhYx1BXYmsjjXL6gIYFDRoHqdW7CdXKo2c8jyCCxq7f/RK1+R9dC6Ju6unMWyX5V004vJt6Z2/rtwyrIosS2K1ZUwc6i64gkv5WxcxI9icTDlu7xov6LvQoIjSw/EvIwBVSrNRfSxQFs0P4A3WdD2O2RWVixn0uJwmn/rGu/Z/EAJUGx9TcHBUQNqcM3u5VCSb27BpUtGOHiLEW3RcZZcNjG5ZDoN1SZQOO3khDlbzGBnyLdtHj1iU3nWv3FwtlyKj96Ko3/5BAyERGww4bYF+atszE+ktygJpiuUBKfuIQlSMrEwEWAO7+YBfUw0g90F/uO/38MkiBajK919XFiBc2PYbXS6aql+m34fH7e/g8SJrkC9AVbU0h2nb61X9F2mVN7qWhhElU/nDNr1wqA4W4TcSZSVoS//4NUSTxHLBgX5Ci/aLos0J5Lm3t7GzdhwvJmDR7+Qz111o/P3UA8JPfxgKkzUE9A1hM7ARYOtDfsClI2eYQVu0Fq36k5C+Zrn8Zu3wjl4cFD3jApNMvt/gWPZPCqyvOHErh1p/Y2HJU66c6s5wA+TxQ3v99yyyFMJQHW/m4qi9E3/F2DIe3O3THFxY2Ey0rbpJmwYhtlHtOV3fMV7qcptLSxMGV4OBFW9qXoltvyAsXTiHjXgmmK1ABgEVvzjbKJJcOgJV+/9js14bhMYePAEu0cNNC9vxqezulCgBR+PFIEq2wkkUm5QKZ5HdjpwjMfxVB2slbKv8tXHDIgSNYQt2rgYSfzqUqE3uJV6zglMCsWgRGsMk/C+GqoEyJ4OxT0EWsjzZMiFW/SFeNdZMuwTHOw16z1r2A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce2e79b-72c3-4316-230a-08dad228f7ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:21.9731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNpQh3du73d3RKlFEI43Dy2Wi9Z6+//fJ0MfmiaVFl1/JNfeZBbERKW1TGdYTb9/Gr608HohNlowv/AaZVRIvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-GUID: ZJOK3fIHbsUjKiuNJxOvZNNUsJC_NrXf
X-Proofpoint-ORIG-GUID: ZJOK3fIHbsUjKiuNJxOvZNNUsJC_NrXf
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

Use the vma iterator API for the brk() system call.  This will provide
type safety at compile time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8f24021ef5b5..054dd3e8e1a4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -236,10 +236,10 @@ static int check_brk_limits(unsigned long addr, unsig=
ned long len)
=20
 	return mlock_future_check(current->mm, current->mm->def_flags, len);
 }
-static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf);
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *b=
rkvma,
 		unsigned long addr, unsigned long request, unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
@@ -250,7 +250,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -298,8 +298,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		int ret;
=20
 		/* Search one past newbrk */
-		mas_set(&mas, newbrk);
-		brkvma =3D mas_find(&mas, oldbrk);
+		vma_iter_init(&vmi, mm, newbrk);
+		brkvma =3D vma_find(&vmi, oldbrk);
 		BUG_ON(brkvma =3D=3D NULL);
 		if (brkvma->vm_start >=3D oldbrk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
@@ -309,7 +309,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		ret =3D do_brk_munmap(&vmi, brkvma, newbrk, oldbrk, &uf);
 		if (ret =3D=3D 1)  {
 			downgraded =3D true;
 			goto success;
@@ -327,14 +327,14 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	 * Only check if the next VMA is within the stack_guard_gap of the
 	 * expansion area
 	 */
-	mas_set(&mas, oldbrk);
-	next =3D mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
+	vma_iter_init(&vmi, mm, oldbrk);
+	next =3D vma_find(&vmi, newbrk + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
-	brkvma =3D mas_prev(&mas, mm->start_brk);
+	brkvma =3D vma_prev_limit(&vmi, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
+	if (do_brk_flags(&vmi, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
=20
 	mm->brk =3D brk;
@@ -2964,7 +2964,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
=20
 /*
  * brk_munmap() - Unmap a parital vma.
- * @mas: The maple tree state.
+ * @vmi: The vma iterator
  * @vma: The vma to be modified
  * @newbrk: the start of the address to unmap
  * @oldbrk: The end of the address to unmap
@@ -2974,7 +2974,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
  * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
  * possible.
  */
-static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf)
 {
@@ -2982,14 +2982,14 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
-	ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf, true);
+	ret =3D do_mas_align_munmap(&vmi->mas, vma, mm, newbrk, oldbrk, uf, true)=
;
 	validate_mm_mt(mm);
 	return ret;
 }
=20
 /*
  * do_brk_flags() - Increase the brk vma if the flags match.
- * @mas: The maple tree state.
+ * @vmi: The vma iterator
  * @addr: The start address
  * @len: The length of the increase
  * @vma: The vma,
@@ -2999,7 +2999,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
  * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
  * do some brk-specific accounting here.
  */
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *v=
ma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
@@ -3026,8 +3026,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	if (vma &&
 	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
 	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
-		mas_set_range(mas, vma->vm_start, addr + len - 1);
-		if (mas_preallocate(mas, vma, GFP_KERNEL))
+		if (vma_iter_prealloc(vmi, vma))
 			return -ENOMEM;
=20
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
@@ -3037,7 +3036,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 		}
 		vma->vm_end =3D addr + len;
 		vma->vm_flags |=3D VM_SOFTDIRTY;
-		mas_store_prealloc(mas, vma);
+		vma_iter_store(vmi, vma);
=20
 		if (vma->anon_vma) {
 			anon_vma_interval_tree_post_update_vma(vma);
@@ -3058,8 +3057,8 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	mas_set_range(mas, vma->vm_start, addr + len - 1);
-	if (mas_store_gfp(mas, vma, GFP_KERNEL))
+	mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
+	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
 		goto mas_store_fail;
=20
 	mm->map_count++;
@@ -3088,7 +3087,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -3107,17 +3106,17 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	ret =3D do_mas_munmap(&mas, mm, addr, len, &uf, 0);
+	ret =3D do_mas_munmap(&vmi.mas, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
-	vma =3D mas_prev(&mas, 0);
+	vma =3D vma_prev(&vmi);
 	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
 	    !can_vma_merge_after(vma, flags, NULL, NULL,
 				 addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL))
 		vma =3D NULL;
=20
-	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
+	ret =3D do_brk_flags(&vmi, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
--=20
2.35.1
