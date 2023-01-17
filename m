Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9E366D452
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbjAQCeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbjAQCeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAB825E04
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:22 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H092rI001907;
        Tue, 17 Jan 2023 02:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FTs1PFHqjgRMD6MJ3c/h4YCmKn+JizCZMB/AfGy/jyw=;
 b=YcLf8wRC5Vz6cXZCMNXHnVmQnbTFXe2M7V1p/RIMdzTzAjSqasBMB+QN9WfHorZmsVFR
 geUJuYlodkJzWVmcZE668lMJdFFHAFqc7aaz0sfpsdCi9PepcdyFCB4jjJXj31HO0cPN
 kp7FePPLh4TdWvhH/EWJHOvP3OmcdYGdE4fNxBZ091WDIG9QKc41JBHbtrRnC22gBQor
 5taGx4kJwMayG5ura7oTXn4l6VNJeiWgZ63EdVf62ZiLkP2km0gmxUAZfVs8nwbcBcEU
 KfkwZSxOLrCjkLtIN1L/DI6tSA5KkmN0kJszT5c6Yh45HvPMJ1SpoTcfiAiQiN/Jqs2c jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6c3pqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMM4ra028480;
        Tue, 17 Jan 2023 02:34:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxkx-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+f8ITuUQ/1Up3HV5zrQeRpjF6j+Tz5n3hHQi5ouEP3HtrV+jlGrh2KL1aTN2evWtLef9Vj53xVjLk0aRUOLM6GBm4GVFjgdOzwTkxE5fZWxdWye+UMF8YlwfQYDD5DnHZ06QDHVtvCEGQCLZieW10/6QyqxRQ3zVP4jkcKHRhk7SSjCEgo4ucc5Exc2v0gpx7tAg9o7U1URmtwQ0Y7M6Ezy8L927YVGncEb419gxiMoyN6te2hE2n5i7PtGsehFVRUJ9YTS14xnDDeddQKnHb/4GNtxJJoBKcQJKCiCm2X+md3sbmkz3M2X+PyZGBz5VRl02dwy8jtxpmb7esc+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTs1PFHqjgRMD6MJ3c/h4YCmKn+JizCZMB/AfGy/jyw=;
 b=ZM6V7qwe19iq+eUzSpNnTZR19I6pUNeNNQ2c5+VO7/Jdxysp/ImXjGMzoz32qfN8AISVdVUOrXmUIyeA5mwE6xqpEQE+b4dAiQ4+YHjp9iZZXEqjl2QpulqIzW8mqtrV+VZ2pHeej9N3tIcktcj6wTZANBewTHjR5SPJ9vl2RIivLnohypVOr4o1SjO4gJyBRG2CathmY/49QJEwWSMIJq+gyBk8JFRlcyhbrPOADLfckJAkPDckYw9IwxerM4wHqRl6aCFUFhYwk7SPBN06eBE9Ge+wzVi9k7NTyfp6MvkECdS7epxgysg2LDF3h2E+/nFGLYpG/ZpEn8QsNJUMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTs1PFHqjgRMD6MJ3c/h4YCmKn+JizCZMB/AfGy/jyw=;
 b=fbj+n73bO7Fw3SGFwdMDZVui5sdNNBTPYP9iEjojwoJzAPgP7lZlvTFLXRfLZA3ihCGnjY1ZYwKh8bM/o/yGHU5t0dc9SDLbstKp0FmLW54M/EVacnDdKR7lGMXRAgGQw+LEPpDh3AWMg8RYFPHnNZDwquMELr224bmbfd11IIg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 04/48] test_maple_tree: Test modifications while iterating
Thread-Topic: [PATCH v3 04/48] test_maple_tree: Test modifications while
 iterating
Thread-Index: AQHZKhwuED1irTjJeEmDGgAGgOPqkg==
Date:   Tue, 17 Jan 2023 02:34:10 +0000
Message-ID: <20230117023335.1690727-5-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: c891935d-7f4b-4da1-c483-08daf8335102
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJPQdiw/GZfeEy8QNbB2qqdaLkMxYv1ogxiJlQIKpFa7Av7ZQgMMS+/cKTmhS6fMx62irXdM9QtY+1CrtoNwgqfqGjoxFUtDHVOnrTFVw/J6YxhJMESqlfzoKN7utvU/CKKh2iygKp4MnIPzk0WgcQeraIHmhXrar0KBh85fU/NL4/Ym3kCRg771C7pIfZOjp8XTGJ7pqWsdbLEJPaMGqTifmu4Y15S61OfwVZHqQ6ln9jbwEtiysKNFC2XCYab1p19w49lGxXSn4HATgIIc77t/UgMhCebvXgK6sSVQWS2Yo7VJDcLMGiAEcumeHB0WFCipodZNMVL25jDDANiSmlL5Z4FIKF47bpMtE4SB1kHJYw8iwEIY2rc/+B56/UdU0AqktfzGK3LckSzg+vIytCIy1V+Rb3clYBun4mApsZSqGXSkOr6gfF9l6mQFTnvZQgG7C5Nb4YjTx57xf72g00HVyDTFBJGXzeKhYpPT+UhIybKwT0pn/Peb+CmVJDtuyjWYrNqQNC4C+9pffJrdI1xpZBfsJctorpV8ArMIpebJ3mTwTjcZBmuHp2XHaR8BEU4lpyYXVcBwsmfZ9Wr/A+KyMpEyc9dVwxP/FaJx3GOcRcO1AiHNbGrk0CVuTgXrE5Xurs93w4myxraOaaKEnmc7iyXtvbt6B8eTqJHJo+yciupVMfhQsa8KVaNwhaDdj7Dbz3QnAdrEgKxveq/fsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lfsZvhVT2u6fnr0/CJEuK0iLf2vE9vqHZz3MfNeW++rnZUpueSSTuC8q3c?=
 =?iso-8859-1?Q?ZEEKGsilBUqK9UhbSjuz764xVbEkarprxEXyU/cRmoxvOONMamPLffkQCC?=
 =?iso-8859-1?Q?iYiqA/5A1LTBimwxIFnmJFzUhI9GEdXpLtToUFLEgX8DV4P7ZqXeIvxfgQ?=
 =?iso-8859-1?Q?1CV9wjSY0E8d7Dl6jcZ/O6CgIkZJwQtvMF/aObSi3L594E9JbfGTnGUune?=
 =?iso-8859-1?Q?ypbeJhz2y6pNh93EgSgC0ELs8oDv1EDz18wn27P6zb8AeHi5waMPa2jiwf?=
 =?iso-8859-1?Q?1CfJnN95v/4F59yF0brPbcU2d8Mzk8AWW1UnWGjTVPTfe1tptYDROHbMso?=
 =?iso-8859-1?Q?+TMQkmqkr3cGwEyYE7B653pnerj6gOydJzwh+sYC62WBlfjtqXCDU6IZjR?=
 =?iso-8859-1?Q?tEjCNXXHGZfTPFTlU71rrN59/9Nzjs65iL0LYKGNViJI4us/qa/2srfhS6?=
 =?iso-8859-1?Q?jAlBqESxmLun40+5DRO/BZisH4EIMYD3SgCSaD8VEx5P0dl57gZIEs6oku?=
 =?iso-8859-1?Q?axTOZPNIZntt7NoSIz8Y2QoK5YXC3eioCNlYsFB0fgNYmH85/FB5mn6sXh?=
 =?iso-8859-1?Q?OriGBOSJupGTOw5DGJmzyGFqXlTg6eTlb87ewh/s1IngfsvFXrDHxMPpqw?=
 =?iso-8859-1?Q?Z4PQ+02MeZmAhCyzC97qgYXWfTivjaGyv53Jb+AhY453IGJJvK4jm7dLpw?=
 =?iso-8859-1?Q?EFIwlp+MBwJYoJyfjCfUYiZlumBznI+z1JrHdGUTIEa+zD492nHAyOVc0z?=
 =?iso-8859-1?Q?izb/35qDKwT0xtsLZnJnL2IWtBR5+KaYFXPm6fB+YiEezq8Tuq1JbbXQMT?=
 =?iso-8859-1?Q?ypTvyoPM+pU1y7h6ub0w8sZnoIE+9inDbwZFnW9kp4F91HoGzmTHS3J8Vo?=
 =?iso-8859-1?Q?m3q9yV3nz3a6xAZ8U8SI+IulqfvYGAxhin3aT1rl/RGCTADfoyrQZyYylT?=
 =?iso-8859-1?Q?3fZXywlpGkIZ8bqeTzqmE3Pyp1Lz+PIKKtg1OiApgXMfmIyfM5mxsWpOTq?=
 =?iso-8859-1?Q?fgY+ohouCLQBv6a8XIzghzdyt9JRUGWv2cn+fUCnakYLYsh4+YY0tm2jjz?=
 =?iso-8859-1?Q?v8/Fn393+6BnQSJssIG3NyjpzMxwkAqVLItMg52TNeHRvz6hzy5IpXJcLI?=
 =?iso-8859-1?Q?dA7HcNDJYgwCvIKmWYFvV/RBmfdbPxhLecUAKDLnjtdURZIKbgmGSM0K0d?=
 =?iso-8859-1?Q?ipKymhDNhDMMGZRIUXU+UZH3rZT2Lxs1N4Rq/wVFJbAUwDUrsUSjQMPZza?=
 =?iso-8859-1?Q?dOdgEuW+/ieSgq7UohfqDG2eu4s95jJEtuFR7jb2wD/FkyF8GCZcqdsw1b?=
 =?iso-8859-1?Q?ZKpPfWMWAMHOhV4PpVkKlbYcksd3i/t3H8a2ZiA9rtFxdp0GYg3veoXSwD?=
 =?iso-8859-1?Q?EOi7Tu1M8pJuGH4SICZKqOUavjIT1mzezA0YRx0/6J9fcH5xj3A36rYbZZ?=
 =?iso-8859-1?Q?e2Vf0m6SlZw/PfGvb2by/7nw+bOkr8jHHjllQvgeoanw/sprLun+EXiAmi?=
 =?iso-8859-1?Q?mSL/M0IIbPma/9LLnyLKP02eGQ/zKr3wV6lJjAqAPgp4rNLF0zQP37Socn?=
 =?iso-8859-1?Q?9H3U4pHtcDYrbmnoLhlPG2pJ8bgzHnpt3oKiAJjmPeZHicegivlWMUN1DS?=
 =?iso-8859-1?Q?ITlcxGMS3QQFACvZ5KimkhuUKDGWDxt/As5kVV8aJIBWHxskViUTAh9g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YindGtna3Ydtj1Y7i2X0eyfhOawLbwzPoigSVmp2BnFdTfPTLoOlSxdMjAhdhRus1uY61wBeK+90cuT6XiR85gSvap6p9qddDab8Sg7kqZyuMdrrkbtlCuIqwP+Kg/PwMWho7i3X+pgavPFxQPuik0BuWEcREVUgyUN9pgoX08ppObMYIIFkP62QBL0aZOmS+ZMP1IIEXDHzGqyX4in+Doc7NeV/POC/BYlUjuuKeXt0JG+Ncj/57WzhkZKpSWFlYTVCRn5bDFOSoAHxMQ2GXuaSsxkf8sjnZ4Narh80cHgXtnN0CR1UJfaKhlTFfwA3m8hz3oPq96igj8IT4T4hHP0LeiV/IeHfvHdURO65EBO13jlDc2yZLxnTHwHPYhxncueEKcKgjd1CbHQuF3dApVDNbkp8grOeGZly7NvRqTPydmhYnycwR6AbMpZmVypryLWOm9Ivg/yrIc1BFwRvZwRgeS/YP06jaMZ/vUnZWuKyQceaAeeEdKuBnONUkFeV8tT8vG9/yqqkJfl5CbeX3PqGvKYRR3suc7qRhVjAfaR8afnMHwohQ/H3DbGlz3GQp7NCRt6J+UiCNlzXf+0EdhGE5k/12sGhiONqKkLMydiXgxq7jqFyv/yKxx4BKtyB94aG2WvG2Aj1MyzS8uxbWG3aIjX4YktnPppREZp7fHytoURk8/FCUceXkMIngmCXueKGFeIKmmLod1XymrpgJW1aOa7a6mCgyehJ/7t50mhWdP9iq8IdhsMy8D4akOVWoRlJD7BedQ3qZZJLv3Gkz5nFyFbfDoJHk8dPyY2NF7kGGfV5O5vt3xm09B6a810qRmYYrrGDiexpzTYtRl0WevNUsvvGoQhUc+Zs3uJ/QOKgB/DmxkGY1CU+STu/OUBUVX6rgTeqWIXxenI7mVCZpA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c891935d-7f4b-4da1-c483-08daf8335102
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:10.8596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDWO6rc7wgJIqvZ7XV5g+wjfU13yy3FHbg2+YDYQYYc1bqWkh1hqoLqfHsnV8a17u2/X5JLQsaGrL23IDza1qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: kJvbc0GKXx8R6GZwLlaJvrtjSA5x-8Wm
X-Proofpoint-ORIG-GUID: kJvbc0GKXx8R6GZwLlaJvrtjSA5x-8Wm
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
index ec847bf4dcb4..3d19b1f78d71 100644
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
@@ -2659,6 +2727,10 @@ static int maple_tree_seed(void)
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
