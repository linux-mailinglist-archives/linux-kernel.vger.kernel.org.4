Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6ED63C56E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiK2QpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiK2Qog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E47B391FA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:36 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPo8Z012293;
        Tue, 29 Nov 2022 16:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xhabUoomI33CKrWaeZkUPrrW6+G0JIovywvm2M4c3RA=;
 b=QKzj2ubKzprgVA2vYEPU0+RBNGy1N2/ug5jdiJqkq4OlyFxCHhVhoBkmOoxVj05W8DPP
 F7dKqibYUQekpIFimryud3kq+URyh7N0KXTDJpbJx0OfYXX+/pFjZC2uXE345cgeCk7q
 u3BS83pWXNrCVbwgwDN7KFRG+AT4F0Hp22jpsEI5sxIUozsz59VMKYsPyOSa0RjYkxOI
 cB0oNbZuzy1vzysCKDl408D7FNs+a1BmbvvNHUhWDADumMKFSNslPooqEDYZGlikjKPm
 Gd3AF+FWdUR7nkxzjQcWjHFAURBdzbtx3pfnFg60/rU7zKCiv56KM6TWcdasL/d5+mF1 hA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdn8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATG7rBW030968;
        Tue, 29 Nov 2022 16:44:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398771pv-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld2Tlc7FSndcAU4kCK8OrTXp8T6N8ZmuQg7miBEzon7fuzGXb+Q68S1e9JH0nH9n4xKFVXfK/78SuFOVT+H35ujM96szzqq0Qtw71C9nJRlpLsMNYltlbA86P7G2HdzjMUEgnCzgRt0YIlPw/vEPAEaIaoPcEHGGHYtui0F7TQjdstlbwVGC4rYnOv6uVzmQnzfxWV6Qj3NtmLz0aN3JqwZShrlooWaUVvmYYvgxEzfAZDqFfIGHRhtg65z3KsLWambX8DarhWwhGbSqApSYe5bVilkC9ROoZDy42QQSOB2sBwW1ID64/IO0Z2ehIAIiNiKxJo2gDBy5i2+A2rGn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhabUoomI33CKrWaeZkUPrrW6+G0JIovywvm2M4c3RA=;
 b=iZloEAnUmnBmq96UN0ZRxfAAQjl3qyLW5LhMcbDQuhl8D+h5aWcZ6n9ToUtRTjs5moH/sIGChZz+HbTAq0ZB7MaIAZXRun22oY7KOsA1YCF4ehyT2vbFDelh8uzIi3ZsN2ePbsHRT+n62HcVUt7c8im9xoTN+e5rtB6thMVe73h6IQnB8V847gaA3t45+5vuP0MTl+4OEJls9+GP3OukVlV9cXpL84LssklkIGtUQyvPTUMGXvB3da4zXiDG4G6v4J30oFFq8hfWCOQrkR5syq0dzAef+dN8u2H3pw9Ao0+iSEWgrYqgVQOeI2TRnCijJ3RqFM7k2cQZ2alczL0SgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhabUoomI33CKrWaeZkUPrrW6+G0JIovywvm2M4c3RA=;
 b=qwz5LsO8eIjM9WjnxwkwkB8rsSlb7W4J/GnBcVENf23VKM0GIWHenIB4WJxYbGW/PbT2PvypG7XdNosBWG5S1YShqniJ+VdK8kBROsdTTzdRBdnoVmmUHBXPjyHI+bAckx2aY1r8Ijicon2XQen9438PkNimSJZIJM/v33ztdUE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:44:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 04/43] test_maple_tree: Test modifications while iterating
Thread-Topic: [PATCH 04/43] test_maple_tree: Test modifications while
 iterating
Thread-Index: AQHZBBHUEYb2GHCqzEqTyyGMfUs5Uw==
Date:   Tue, 29 Nov 2022 16:44:21 +0000
Message-ID: <20221129164352.3374638-5-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5321:EE_
x-ms-office365-filtering-correlation-id: d8c10260-f7bf-4527-b5e9-08dad228f75c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmiZibVWkH4595dTDVKbMIocxTQ61D1gDg4z9a3Me7yIrfnJqSlyxE6pLy/5556emO77A7Y5lIMwL/Z4hUxNzP/QUPoIK4AfxdF8wQPQlW0cDYvzaSQ0iMN7OHogcBPGc3gCuy1SlhQNa94BNSjB2M8Pac7NtdwytGffytTEMk5kQg/Lk/9EnMChzXCxPeyZi99b4eB9PlGumKuWpy28G97W77AuWCr9U72M6jAdsasZpPmDo0FK+35KuOCBB5Uw9bN6tdkY/PIZJASzLuuLKHFLFxBAtv1VKxGWA9YcTixzecHuZYxJF33nYjRCuCRV3noYouNGnYVbHRyXHiJEJLTEZ7Ecet2yeUoajaz8MP9ECKY9VOiEAq2b0gkB2hKZ/W4/Zb4lzYe8fWFBvyUFjAcbsUknCReTcklclZY9XvU9NQennWGTDF8HVGo87EWSNiHme4Ig4OfMXIfGbqwmeX60VM22P0B/UNzLulzCpwc+NmHQg/ofgsoFA4akt77v+QteR6a3/h1nByz+P0ipsdRKBKOtCYiJMJMlW11PsvAS1u8r2xuFR4HwfTMlQmui1q1FAdlThh9SBS6ddorkd4Gdk8e/9jADN2TQQ5NFpmrevILQQRyyMAjizsqbo1oqKhIjHmg/If/cuBNsI03Kx6puFWJfdDSJXnwKwAmfIIIg3uWbldu82crVXN4AvoYzsKDE4bG+PKOd69Log7YFCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(83380400001)(54906003)(71200400001)(6506007)(107886003)(110136005)(6486002)(86362001)(36756003)(38070700005)(6512007)(38100700002)(122000001)(2616005)(26005)(1076003)(186003)(8936002)(5660300002)(66446008)(478600001)(44832011)(8676002)(66946007)(66556008)(64756008)(76116006)(66476007)(41300700001)(4326008)(2906002)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qyUjUPaKBYSfoX4mlwHt15ajYsSALIOAsyzHlrk/vYEINVoGRKbfsL3wwd?=
 =?iso-8859-1?Q?se+iFw5BtxOIq28jHQoQEiLH6JOvcoSBUbZTZ6RbJR1HtKXk/DdAq7Wbz0?=
 =?iso-8859-1?Q?2zVrs+i66tQ2QseVYpRgCHk4aEV4aqZvGsGwfykpvjdGnydXiVzj0uU807?=
 =?iso-8859-1?Q?KQ4FdnvRHJmnqGKJ1qU5ZzpuJQcg6VT/ZsuMQSvVElJs5P/6E4flrpcpiM?=
 =?iso-8859-1?Q?T+vxFhv92glST7YrX/9fvjFQXVoEgbDasjc7s64Q282X+KRSYURT6iUCUh?=
 =?iso-8859-1?Q?B1HaoVSt0WEU5xFc/VtTdt+k/5O/aDTAfOSh5Q+XGyX8eBjPavbxzFGiS7?=
 =?iso-8859-1?Q?RiJ2wd9GfGx16wYMjRTTyl9umSi+5C7QoRxBxoDQcWaQZW6r1bduCnuzit?=
 =?iso-8859-1?Q?aCN1Hexo/8uzGZR/UAfoypDpIlm12+e51R/TXys+2gUJLrXuzvCjUF/Gmd?=
 =?iso-8859-1?Q?yVctKzWkXQFXIFzbGCNTUraSuDGmdLycUKT8Ke4xfFD8SgtO7RViA5gLDT?=
 =?iso-8859-1?Q?/l82xN/i1Mljfg6Fg/DoUndOeVpxzHYzZCjB7wlAAiU9+Zf6C4ZovgVNIS?=
 =?iso-8859-1?Q?GNxu6CbaR7GZkxxSm41kXx3SdVAYGvGvHQqMPhpVhUp22F3pO53kvBEbv8?=
 =?iso-8859-1?Q?uoBh2Yu0fUggRBrNIuhXXIIwp8Kl7Vf2VJXeQvU1rzjExopeMnvqa5hZib?=
 =?iso-8859-1?Q?u1aQ3fev7kutXqrMYD3yPs6M1SWd8ajdNPVQKpzYNDceIqEZC8whu+9IKz?=
 =?iso-8859-1?Q?cOkwNAZL5B03LXi+RmMTRtWxJVIC1p7fWVedYmtqolsVlBfJFsnJF1uBBN?=
 =?iso-8859-1?Q?6QEtQijpJGE+lIbucp23LuMnpmgMDlyXQ30WdahuwGcJKbn2rlMxUMg/Bv?=
 =?iso-8859-1?Q?h45iokUki/8WN3sTr9azB1LsG1fy+S5NFbGqyVx8qpzkNxG0uAaqq6Dx2S?=
 =?iso-8859-1?Q?dinVMQH0lT4bbFUNbf9URs2lCHb9quW25sm6W1BacmOYDX5NK9Rh2YFbBb?=
 =?iso-8859-1?Q?IJC5D5WHqCwG7r4mrlqyC+FCReLQQE6/VWMTLGax3qbWSdZOSCDwfiOvKX?=
 =?iso-8859-1?Q?bu2rgOOsN5G0Xrh+i5uNbOudwAVV/82OhK56bZRXAIsz7DGl3QlnDd/SVd?=
 =?iso-8859-1?Q?psgsiEM8aE0tnRLEOYFQpbFDO9Oi98CKqyHDsVZoXhLR/OlIsi5R3f9xzC?=
 =?iso-8859-1?Q?A9RGPxiV5au8CdcICB3LOF9bXoV4X8n4e33m1SDxtn8tO2JXLJ9lTYKgQt?=
 =?iso-8859-1?Q?0t+fJJmWalo+8FdwjNxuILkwMIqlnd8TNDz/qIAdKrHsXWDTs3laa5oHz5?=
 =?iso-8859-1?Q?T4tLc7U8LlVutWLIdg7PfZon8tQypKgHLu1fY2GQJ5HceQC2buiBFVMlqK?=
 =?iso-8859-1?Q?IheUZPPui0znl9uoMCeNG7dGQYU5Wi7qBcy6NRRwHN6kTYynfDiEhOeT8b?=
 =?iso-8859-1?Q?ERPnvd4hhCqgLrmNh/MKLfj5Cdndqdv50xg2x8OnNeOeygPvSVGojb5qkf?=
 =?iso-8859-1?Q?CsHyDHY6XhX9l/GQSJJQTMTxaU2lq+Xkhqd7W+cgoFfBrdHOdBQoj73s0z?=
 =?iso-8859-1?Q?bRmcRE7HRXvFzBgKBSDl7fEKb2dZ6//oxPyzLjRG5ipde/l09IRQdjldDn?=
 =?iso-8859-1?Q?DKjMVKeWCXW1p794obqOFBcuWsZ/KwJepXhPuOemb1dlkk49rEYxmZFQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sbUyVG+WqqT1UtMRWBtwmLufnmWd6yoquFGMlbix/hoJ8n6uFLBqlcG3tQsFp4/W8LQ6mZnFfJhXdQg9HZkN3rpFYVGGkLDFAq2JLbu6BdUTJdaKlHk1GDlZ1W+uOJy+PlTcaKiyMDko/0E2s8+DFjY7HbpvfqnrQjJKJ9J5VAT/P968OkxgzTSvOtdWRbXtrgPaWYJaTLxSwtYocc2Bjg5YnkdkcXVQI8JTddFdtcAkWiDZQPEkzt7vwGuX0U3nD7Bf9pDL4o3g09l/UGiWtrFvcnMIEwjKe6Hoaptt3FJfT9muIPZ5jyw65rTqdeHF+vyvqDyy4fNtvB11kH/prH1y5gIwCi2CyA3NDFqc3SF2RIIu1CDOg5/9MhE+FZE7j1diS6f2PcfIBE2h8MgFZjnnvSsxEv6bUo2h22FO+xX4qHJ9C/rTEzd7zEG1MxogbUXZAy7EbL4oEHUgxr9jKoOMX7u7d6vSJgDIGQSLqh5TSTG4zJnf293sMLgpQiqjhuqY1alKZJlolmb6sB2FuziYRoRewRSmk5MlhRyKuZnliI5JQ3yMHv3oXvXa7TwX4wC1Jqwust0VoQ5MI53Oy3HpJbLC7qmiVxLQNfuHYizGAEmgRZdkF9KvEkBNqUynZMqKrz238RsJN3OV81IBquehVfswOF+ujsJ1W/+TlIGXMTOKWc2p4qkmn2LGIZNGInD/Q8RdO5qSlbuMSyItFyxhEm3plCG4JgwD70AiF+j+ElMSvU+UOYS4zcSBGkB5aDKjt4jI//BCaA2FT/WSFysdsZbFSDybtQ4o9G84ponCYJHBQeT501y139URfg1XEn1mTl5KI65/j0hxo49cbZz3pfW41ZmswUx7S49mvc2n0aB0BmbCx23zmL5sxPdZNStnQP74UCa9eirMsTRymw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c10260-f7bf-4527-b5e9-08dad228f75c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:21.2857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjgYCXDksjshxA8kGfhbU2wS9221DKNLUdzbTdkLg8Pw5swM18jWWBiWw2eJYpgDznBat+ZEC6RxNX/YxVOx3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: Yex7T016ZFWgS6uYas_95cqyAj6q0Sri
X-Proofpoint-GUID: Yex7T016ZFWgS6uYas_95cqyAj6q0Sri
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

Add a testcase to ensure the iterator detects bad states on modifications
and does what the user expects

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 72 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index f425f169ef08..ff471fea0194 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1709,6 +1709,74 @@ static noinline void check_forking(struct maple_tree=
 *mt)
 	mtree_destroy(&newmt);
 }
=20
+static noinline void check_iteration(struct maple_tree *mt)
+{
+	int i, nr_entries =3D 125;
+	void *val;
+	MA_STATE(mas, mt, 0, 0);
+
+	for (i =3D 0; i <=3D nr_entries; i++)
+		mtree_store_range(mt, i * 10, i * 10 + 9,
+				  xa_mk_value(i), GFP_KERNEL);
+
+	mt_set_non_kernel(99999);
+
+	i =3D 0;
+	mas_lock(&mas);
+	mas_for_each(&mas, val, 925) {
+		MT_BUG_ON(mt, mas.index !=3D i * 10);
+		MT_BUG_ON(mt, mas.last !=3D i * 10 + 9);
+		/* Overwrite end of entry 92 */
+		if (i =3D=3D 92) {
+			mas.index =3D 925;
+			mas.last =3D 929;
+			mas_store(&mas, val);
+		}
+		i++;
+	}
+	/* Ensure mas_find() gets the next value */
+	val =3D mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, val !=3D xa_mk_value(i));
+
+	mas_set(&mas, 0);
+	i =3D 0;
+	mas_for_each(&mas, val, 785) {
+		MT_BUG_ON(mt, mas.index !=3D i * 10);
+		MT_BUG_ON(mt, mas.last !=3D i * 10 + 9);
+		/* Overwrite start of entry 78 */
+		if (i =3D=3D 78) {
+			mas.index =3D 780;
+			mas.last =3D 785;
+			mas_store(&mas, val);
+		} else {
+			i++;
+		}
+	}
+	val =3D mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, val !=3D xa_mk_value(i));
+
+	mas_set(&mas, 0);
+	i =3D 0;
+	mas_for_each(&mas, val, 765) {
+		MT_BUG_ON(mt, mas.index !=3D i * 10);
+		MT_BUG_ON(mt, mas.last !=3D i * 10 + 9);
+		/* Overwrite end of entry 76 and advance to the end */
+		if (i =3D=3D 76) {
+			mas.index =3D 760;
+			mas.last =3D 765;
+			mas_store(&mas, val);
+			mas_next(&mas, ULONG_MAX);
+		}
+		i++;
+	}
+	/* Make sure the next find returns the one after 765, 766-769 */
+	val =3D mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, val !=3D xa_mk_value(76));
+	mas_unlock(&mas);
+	mas_destroy(&mas);
+	mt_set_non_kernel(0);
+}
+
 static noinline void check_mas_store_gfp(struct maple_tree *mt)
 {
=20
@@ -2555,6 +2623,10 @@ static int maple_tree_seed(void)
 	goto skip;
 #endif
=20
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_iteration(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_forking(&tree);
 	mtree_destroy(&tree);
--=20
2.35.1
