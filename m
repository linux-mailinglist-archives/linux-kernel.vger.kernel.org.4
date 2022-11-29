Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806A563C585
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbiK2QrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiK2Qpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:45:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB5945A21
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:52 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPi3n017345;
        Tue, 29 Nov 2022 16:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5UFSEk5NWMUwkRVcsWr/X+7G5H1qm5MKYxeSEUpdMZ0=;
 b=vb49Lzj15yk9NOXHVPpWxxE7MOI++OqsBaRUielxdcrKXmPvGiX1UcaxhMH9xvTu1nFD
 Y2O5CQ1p2OyEpkB7OQ8uRFUoSxMJcQxsClFc1oR6dERHA97jBsiEcefR9Ouwi+3YPJOg
 ydI7PpP7LffJMLrrujQORFDud89Y/o90P4XZNTgJNyzasboltyj+37idVqlkZT6J9f+p
 +Y3gHA34MVWCLl31Wbx1uuwM+3/+H7ImL5WdQIdiV7GtAESL/LUUxocwyP6YKYbUsQ1a
 6BorrAm52uLqC85FZBVBztWXnqXc6qaAe10ELrAFE1BUAAi6k5yWrc8MOBNUs9QWMBXo Ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xht6hn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPs027963;
        Tue, 29 Nov 2022 16:44:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HluYyemgF6OTvUcG9RmXZ6SYAjyLTkt6bUxkkfGU9jSsW7HMD5u6U0eXwmehzfX8KYEQlVeTh+I55hWXWFScT5Qd4IU45XsnJVHLJNgaoEZKfuwUPB24QSN2b3dnwd6z7E1yDZf/grwwc7zDeJ69hRcBTs+CPWJmz3X61nX+QU56zjdPB/1zN2dgbXhagOeOvELK3WXQifxPUqNCtFUgIxW1wsP3a3SqRAxLwRld867r7sdGEReiHAT9nr/+FupmY7EsauPpfhZOBl+aNPZbM9jKch3vRWokVjQGLw4cOWq+Sve4j3l5FA/Z6o31iZpx9odL6SToV5D/AURBhmDAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UFSEk5NWMUwkRVcsWr/X+7G5H1qm5MKYxeSEUpdMZ0=;
 b=YW2zG049/OTRPC29+x2FpFrah0kLbyBpL7xC1DjAbLUDYQcQZopWMz7KVOMF8EtBSptnW9jYUABrYcUgUJMumQI3ySB0j3A6VBRzrTsRoftNyJZoNniLCRjTJLbt8kXmMutCfZWMs5N7vnFp49imGIOR7t6Ic3m55gdg686B0+ycJoRyKJSpte388OWJgRCu2QGRY2ycN8AKXoeU0eKTRcRL5ZChd0iCbTT0u8LrNtqcM6C/e0qMZ1oh8WxaPpxFUdlL2Xm2Xtoj0gda0Mmi8xwkhknF9hC1DPEx3wcR+SKfkBNT2qIxsVtT/qGSZgfrRurSjikJsJGKOOspVmhZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UFSEk5NWMUwkRVcsWr/X+7G5H1qm5MKYxeSEUpdMZ0=;
 b=Hqok8PXSLv0y+96GC+oTexZboVElzIPWZr7oLGMvROCs9aDYiGM5HL0NVJ+QSA1UgmJ+gp7K8HEEIIekz/cce336HP5yRtGSqXgzRyjaxiEPWFsHKQjXiV8sxpdEa1AXyKOsEqHqeUeoyYtgnqwxswvd9nI4yvlpb3NFQjO7DMo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 25/43] mm: Switch vma_merge(), split_vma(), and __split_vma to
 vma iterator
Thread-Topic: [PATCH 25/43] mm: Switch vma_merge(), split_vma(), and
 __split_vma to vma iterator
Thread-Index: AQHZBBHaPR/BZRzVsUaIyw8MJ+G3Gg==
Date:   Tue, 29 Nov 2022 16:44:31 +0000
Message-ID: <20221129164352.3374638-26-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 12e7a744-1940-4ae3-2d5c-08dad228fe8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IvnxrKiz3yi9L2JYAQVNUL5TbOW22YinFEy3/YcCqyY5HTmub14CJxMasGCxn9U/tRclfvXO6vlBbVFmeidJehBrNHJviffWwpb1GhAJdpx0/x5+aaAswRZRu0tX3/SMSJh702lFHAlyyIUm3dRfC01Z2DGuXyTsMjb/ULVnVjOor+cUyqfiNFTml0O1aRCRGpyRbezcMD6JSwjJOdfKIO3XGl+UetDAz1uNE6wVOUxWtQfHjKc7mKQL+GiIt3Z4WaVuA1XXe9bEYxUozKRWqQmpiJibBPRLyTnsF2dR3t/LC0VllM7mcYPQGNHsVJBgD5ntHaZt+410EQpqbt2TU655GkAkbA9/l2P5Bl7AkJImBC0cBPvNvc5bgt1nQANF2dINyX+BUhui7sVBD9dfnbAHIimizmUSgKNJMOThaOv43UD4D5nxX5m9j86HQ4RrOl4B4cpkVQVG6AIvm+ExFGSyn29SQcr7o5sC7XetDyZTQzuYzC92f/FBOPsZh8iGBZdIBSf2vn0HIBdkCnCV1ebEQuntweAmiGlTwvyoMVz914QhXNfinZ9TkSTQB5INvBB9pTrqGoEDHvLJwDQsGG19NcB5kSfeAdmwhT2VWWsOeXqHIEWWEh3Rk5hcz7aUhC/fWys6uL1R3rzZrmt2aRPH+npwE+5J7gCqnEcu8PX9V+KmJLh79SLnoR6IoiilpWQGKfsLIL5Ezc1D0RvnVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(30864003)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GKzrrHH9I1CJ5/tz4CXtX7fxDEKWKulCtmUzebrJW2aK9+Yhg9HTLFIAuV?=
 =?iso-8859-1?Q?EJZ6Cy8YoRLYAWWaXG4XNCUOSVHVb4chu6UJaYxayLS7FDH6pJJewmz4aJ?=
 =?iso-8859-1?Q?pSKzcoCGMATRldHnmldlki/Q+z8T8+ciCeLGxwzHvnxzpzmol2xA/Nstju?=
 =?iso-8859-1?Q?fnCn39cWrnCGBt0gFRk6Bq+Dkkk0wX/2g48uF8FWuNW8nT/BXSA2lXjwbz?=
 =?iso-8859-1?Q?lOdrOZ4n7HwYsiZsENQyZHLTLHWrgwYRKGC2YBSdp33KmFT0H6BlYBorr1?=
 =?iso-8859-1?Q?1WzNc7a1W2TdraX61g+9xwpXlCnuerG6uZeReEOC/JNa/Bxj4IlN75pEe5?=
 =?iso-8859-1?Q?LQFPzP4rXchLtBmys1Nu/4a1EM+F9+VgZGlN25zwZh1Wui6BdLYJN7oARe?=
 =?iso-8859-1?Q?T1QR1USHfcWJ7kXExE6ybjJZPHhTtchOGLAkYOFIXrnNh8D03NcanHAMB3?=
 =?iso-8859-1?Q?ubSzDRPG6VC/C5Rw2qafxTA952HSExr4jA6qvMs4T4FJDaGVNgz41Ap9Zv?=
 =?iso-8859-1?Q?J4bHdMw7v8+8owRCQX+0C9Oj+Y753JUTw8FMG3VpmnSfw5g0Qlv9yPhHCh?=
 =?iso-8859-1?Q?MGR8t3E49itXu2TqpnZOSvOqAd3mKiOQWIBLb5uuLCeufkphe6qf0zW1iV?=
 =?iso-8859-1?Q?apmf6otxNgMMWGHHu7169hqElesBM7N9saekrs4DTA2uSPCo8kc1TV8Lsx?=
 =?iso-8859-1?Q?pb0P5ydZcFpJRhX18sJQPGZSxNsvZxY/YOjLh4VcDogUBjIZ2QIusWaStf?=
 =?iso-8859-1?Q?Drk62HY7uYAUJlBX7wdfDj/4WnLJq84AuFFbDB81Bj0Hl9eyQc72kOP6+8?=
 =?iso-8859-1?Q?bApqDQKtFoUgTMc5GTwo7dg2CJEhuk5gBh9rsXbIriZZuTUpiARbQQffWT?=
 =?iso-8859-1?Q?qL8XElXudX5KrwNlPjQYFPIPbYhN5RF1/QaYPgvW9tUO6ABINpR8P0lpl/?=
 =?iso-8859-1?Q?+n5O8n3EcGpTdns0tm2G1HHewu0ST/tsJWqsgBwpqcbqLbEnNDK+uyn9nS?=
 =?iso-8859-1?Q?njPTAz0jiYyGjS0+ePD0iivIxxLp+XDx0nOXCon7sLoGIvU0MWN1YJo/Wa?=
 =?iso-8859-1?Q?ZO52YlVNFBXHGXh7wDxJ+3SeWtTEnSJIjX0Bqv788fQeSvkb2uwaUVZETJ?=
 =?iso-8859-1?Q?u2eUDtISVUcmi2hDe3XaQFMoNB+gnh2Y9FyrVY2HDzLcJVc4ybMuZUZKvz?=
 =?iso-8859-1?Q?tTEyITqHJgCISWpz2r2vQ1j+Gq4hH9I1rmXsb9D1HGBHy30wFOwYrWlcyE?=
 =?iso-8859-1?Q?mXRClTreNdXlqceTnOu0EfCGdMVz9EKVuSb54F+pEmPTGSUAT/dsnBU0rG?=
 =?iso-8859-1?Q?ojVNiM1woA9miOTtMsUm00MPyT3wtf/upEOf9K5PviG22KPLIaY+0/RiFC?=
 =?iso-8859-1?Q?XEejZ3zepynQekfzx9Co87AyELjyyMzQ4GHVXSFedUm9QxmAZkx7mwhZsK?=
 =?iso-8859-1?Q?z9m6z1FFJ2PBp8rjKYcvzeQobu7XCDkMjxEV3UuRfhSuXej99G2XpOaagb?=
 =?iso-8859-1?Q?IqvC6EUfdEOpEpA0GWP1hA3CBikF5hbrx8IIGg1dfAbzbFDAbwk4ieRUAR?=
 =?iso-8859-1?Q?MQZhDoFseJ3Y9UXCuYUA5o2ro0QTORv1jjUZSTf2p0+DYGA96rgM2UDs1Q?=
 =?iso-8859-1?Q?v1F1l4Bpj9u7X4lneKVwcmZpBpA8hdJK9r1Ja33NDQ2EiwGAE8MnMjCQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Vu+v8nw/o98vt/kZP8aRWECIas99ApoTzb9PtVrPnJHPJu0KoOkdubuIPnyIWtEBfH+QLQ/exftHOHw1k0jGs9TrQ8JOJ8kqU7tv5RzuzzT+aqayQuKyvxovcxz4JmiZgzIiMo8348YYpvrpHbaAxumffTEY5UUHP6fY6R7Lv8VPOaWuXrzMP2x9W1AbeFM+uVuIX8STpazAo5SDV5pQnS37KBxOcs+TLBjKhD/sP5N4jEHh/LhqT1ydT9nWkyzRTz++786Pq1Ar2llFc5lfulPFCFfb221wkfk7naMNs09RvSnbtEFYyU52rOvxWsr4FFr5R+H+HSjj9rppYS7VewzQHYmE4ZUAW4TaAmf/W3E4TMtX2F+q9wgSYH2dzMBB/UqnKfJK7kN5s2gsMTy3dh0r+Oi/EL+ElbZRwqk2zGVhwgn1S3plb7S1sSEf1iwtxpA41XsVzHUTZ3Em5gtdzLOyBcGw40esyPza76pLbmIpTuYuqBhc1Bvm85HZpBsg+nhp2S94bI5KoIFz1qoavuuWwvMXqvPDmCpQlTC8GoE/sSflwRIXph0KPlJPqPGS62kS0juk72b/U+F/KzACPBQi94pYiMWBWdw+r24uqHuaxhbgqrevK8KxaNKqnIJjCRj+qLMabKuru47UI+1Aa26UkASdVISQLDbUk4vuIqevb54yv518Q1FCfzJo9XidCntAClAEiywfdEGP3fdG22Yk7gNJrAR2vGFd6ighZboEFrONg6/LfQhM1ncd8ABXGDZLMNHtXSqPAkUBBzZPIZYxbmXHttru1yXctaAQQbUmMHFMHsbfo4dlSXRTDCnUg44OEBVhlrFLrC5VgC+MCjtou7esrARnBdlFW97+ODVe/fatlbo+9GGNF/M/r38Me3FKuN378SzeaavQfWBG7w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e7a744-1940-4ae3-2d5c-08dad228fe8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:31.5662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXNhFbQTWHyk6wWyRr20MTLNmkUxL2saLXAr63Zi6riso8F0q9sNEHPiTU2tsJhQjgst2P7SvUxxAUhqaCpUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: rKJImQPsKAfFWb9N5HwWw4g7x5vJ5MJ1
X-Proofpoint-ORIG-GUID: rKJImQPsKAfFWb9N5HwWw4g7x5vJ5MJ1
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

Drop the vmi_* functions and transition all users to use the vma
iterator directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/userfaultfd.c   | 14 ++++----
 include/linux/mm.h | 16 +++-------
 mm/madvise.c       |  6 ++--
 mm/mempolicy.c     |  6 ++--
 mm/mlock.c         |  6 ++--
 mm/mmap.c          | 79 +++++++++++++---------------------------------
 mm/mprotect.c      |  6 ++--
 mm/mremap.c        |  2 +-
 8 files changed, 47 insertions(+), 88 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index b3249388696a..e60f86d6b91c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -883,7 +883,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 			continue;
 		}
 		new_flags =3D vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev =3D vmi_vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
+		prev =3D vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
@@ -1426,7 +1426,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 		vma_end =3D min(end, vma->vm_end);
=20
 		new_flags =3D (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		prev =3D vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
+		prev =3D vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
@@ -1437,12 +1437,12 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
+			ret =3D split_vma(&vmi, vma, start, 1);
 			if (ret)
 				break;
 		}
 		if (vma->vm_end > end) {
-			ret =3D vmi_split_vma(&vmi, mm, vma, end, 0);
+			ret =3D split_vma(&vmi, vma, end, 0);
 			if (ret)
 				break;
 		}
@@ -1606,7 +1606,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 			uffd_wp_range(mm, vma, start, vma_end - start, false);
=20
 		new_flags =3D vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev =3D vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
+		prev =3D vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
@@ -1615,13 +1615,13 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
+			ret =3D split_vma(&vmi, vma, start, 1);
 			if (ret)
 				break;
 		}
 		if (vma->vm_end > end) {
 			vma_iter_set(&vmi, vma->vm_end);
-			ret =3D vmi_split_vma(&vmi, mm, vma, end, 0);
+			ret =3D split_vma(&vmi, vma, end, 0);
 			if (ret)
 				break;
 		}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 17623a774e02..2fa8aae4c4f2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2700,22 +2700,16 @@ static inline int vma_adjust(struct vm_area_struct =
*vma, unsigned long start,
 {
 	return __vma_adjust(vma, start, end, pgoff, insert, NULL);
 }
-extern struct vm_area_struct *vma_merge(struct mm_struct *,
-	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
-	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
-	struct mempolicy *, struct vm_userfaultfd_ctx, struct anon_vma_name *);
-extern struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
+extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
 	unsigned long end, unsigned long vm_flags, struct anon_vma *,
 	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
 	struct anon_vma_name *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
-extern int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *,
-	struct vm_area_struct *, unsigned long addr, int new_below);
-extern int split_vma(struct mm_struct *, struct vm_area_struct *,
-	unsigned long addr, int new_below);
-extern int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *,
-		struct vm_area_struct *, unsigned long addr, int new_below);
+extern int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
+		       unsigned long addr, int new_below);
+extern int split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
+			 unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
diff --git a/mm/madvise.c b/mm/madvise.c
index 2beced2d5eee..bf23d64515e1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -153,7 +153,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	}
=20
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev =3D vmi_vma_merge(&vmi, mm, *prev, start, end, new_flags,
+	*prev =3D vma_merge(&vmi, mm, *prev, start, end, new_flags,
 			  vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			  vma->vm_userfaultfd_ctx, anon_name);
 	if (*prev) {
@@ -166,7 +166,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	if (start !=3D vma->vm_start) {
 		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
 			return -ENOMEM;
-		error =3D vmi__split_vma(&vmi, mm, vma, start, 1);
+		error =3D __split_vma(&vmi, vma, start, 1);
 		if (error)
 			return error;
 	}
@@ -174,7 +174,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	if (end !=3D vma->vm_end) {
 		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
 			return -ENOMEM;
-		error =3D vmi__split_vma(&vmi, mm, vma, end, 0);
+		error =3D __split_vma(&vmi, vma, end, 0);
 		if (error)
 			return error;
 	}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5bf4ab8eee49..ee9751323c59 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -810,7 +810,7 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
-		prev =3D vmi_vma_merge(&vmi, mm, prev, vmstart, vmend, vma->vm_flags,
+		prev =3D vma_merge(&vmi, mm, prev, vmstart, vmend, vma->vm_flags,
 				 vma->anon_vma, vma->vm_file, pgoff,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
@@ -819,12 +819,12 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			goto replace;
 		}
 		if (vma->vm_start !=3D vmstart) {
-			err =3D vmi_split_vma(&vmi, vma->vm_mm, vma, vmstart, 1);
+			err =3D split_vma(&vmi, vma, vmstart, 1);
 			if (err)
 				goto out;
 		}
 		if (vma->vm_end !=3D vmend) {
-			err =3D vmi_split_vma(&vmi, vma->vm_mm, vma, vmend, 0);
+			err =3D split_vma(&vmi, vma, vmend, 0);
 			if (err)
 				goto out;
 		}
diff --git a/mm/mlock.c b/mm/mlock.c
index f06b02b631b5..393cddee2f06 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -418,7 +418,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 		goto out;
=20
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev =3D vmi_vma_merge(vmi, mm, *prev, start, end, newflags,
+	*prev =3D vma_merge(vmi, mm, *prev, start, end, newflags,
 			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*prev) {
@@ -427,13 +427,13 @@ static int mlock_fixup(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		ret =3D vmi_split_vma(vmi, mm, vma, start, 1);
+		ret =3D split_vma(vmi, vma, start, 1);
 		if (ret)
 			goto out;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		ret =3D vmi_split_vma(vmi, mm, vma, end, 0);
+		ret =3D split_vma(vmi, vma, end, 0);
 		if (ret)
 			goto out;
 	}
diff --git a/mm/mmap.c b/mm/mmap.c
index c22365727ab4..0c194a2a568d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1070,7 +1070,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsig=
ned long vm_flags,
  * parameter) may establish ptes with the wrong permissions of NNNN
  * instead of the right permissions of XXXX.
  */
-struct vm_area_struct *vma_merge(struct mm_struct *mm,
+struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struc=
t *mm,
 			struct vm_area_struct *prev, unsigned long addr,
 			unsigned long end, unsigned long vm_flags,
 			struct anon_vma *anon_vma, struct file *file,
@@ -1079,7 +1079,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 			struct anon_vma_name *anon_name)
 {
 	pgoff_t pglen =3D (end - addr) >> PAGE_SHIFT;
-	struct vm_area_struct *mid, *next, *res;
+	struct vm_area_struct *mid, *next, *res =3D NULL;
 	int err =3D -1;
 	bool merge_prev =3D false;
 	bool merge_next =3D false;
@@ -1145,26 +1145,11 @@ struct vm_area_struct *vma_merge(struct mm_struct *=
mm,
 	if (err)
 		return NULL;
 	khugepaged_enter_vma(res, vm_flags);
-	return res;
-}
=20
-struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
-			struct mm_struct *mm,
-			struct vm_area_struct *prev, unsigned long addr,
-			unsigned long end, unsigned long vm_flags,
-			struct anon_vma *anon_vma, struct file *file,
-			pgoff_t pgoff, struct mempolicy *policy,
-			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-			struct anon_vma_name *anon_name)
-{
-	struct vm_area_struct *tmp;
-
-	tmp =3D vma_merge(mm, prev, addr, end, vm_flags, anon_vma, file, pgoff,
-			policy, vm_userfaultfd_ctx, anon_name);
-	if (tmp)
+	if (res)
 		vma_iter_set(vmi, end);
=20
-	return tmp;
+	return res;
 }
=20
 /*
@@ -2287,12 +2272,14 @@ static void unmap_region(struct mm_struct *mm, stru=
ct maple_tree *mt,
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
  */
-int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
+int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	int err;
-	validate_mm_mt(mm);
+	unsigned long end =3D vma->vm_end;
+
+	validate_mm_mt(vma->vm_mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2332,8 +2319,10 @@ int __split_vma(struct mm_struct *mm, struct vm_area=
_struct *vma,
 		err =3D vma_adjust(vma, vma->vm_start, addr, vma->vm_pgoff, new);
=20
 	/* Success. */
-	if (!err)
+	if (!err) {
+		vma_iter_set(vmi, end);
 		return 0;
+	}
=20
 	/* Avoid vm accounting in close() operation */
 	new->vm_start =3D new->vm_end;
@@ -2348,46 +2337,21 @@ int __split_vma(struct mm_struct *mm, struct vm_are=
a_struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
-	validate_mm_mt(mm);
+	validate_mm_mt(vma->vm_mm);
 	return err;
 }
-int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
-		   struct vm_area_struct *vma, unsigned long addr, int new_below)
-{
-	int ret;
-	unsigned long end =3D vma->vm_end;
-
-	ret =3D __split_vma(mm, vma, addr, new_below);
-	if (!ret)
-		vma_iter_set(vmi, end);
-
-	return ret;
-}
=20
 /*
  * Split a vma into two pieces at address 'addr', a new vma is allocated
  * either for the first part or the tail.
  */
-int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
+int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	      unsigned long addr, int new_below)
 {
-	if (mm->map_count >=3D sysctl_max_map_count)
+	if (vma->vm_mm->map_count >=3D sysctl_max_map_count)
 		return -ENOMEM;
=20
-	return __split_vma(mm, vma, addr, new_below);
-}
-
-int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
-		  struct vm_area_struct *vma, unsigned long addr, int new_below)
-{
-	int ret;
-	unsigned long end =3D vma->vm_end;
-
-	ret =3D split_vma(mm, vma, addr, new_below);
-	if (!ret)
-		vma_iter_set(vmi, end);
-
-	return ret;
+	return __split_vma(vmi, vma, addr, new_below);
 }
=20
 static inline int munmap_sidetree(struct vm_area_struct *vma,
@@ -2447,7 +2411,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			goto map_count_exceeded;
=20
-		error =3D vmi__split_vma(vmi, mm, vma, start, 0);
+		error =3D __split_vma(vmi, vma, start, 0);
 		if (error)
 			goto start_split_failed;
=20
@@ -2468,7 +2432,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (next->vm_end > end) {
 			struct vm_area_struct *split;
=20
-			error =3D vmi__split_vma(vmi, mm, next, end, 1);
+			error =3D __split_vma(vmi, next, end, 1);
 			if (error)
 				goto end_split_failed;
=20
@@ -2749,9 +2713,10 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vmi_vma_merge(&vmi, mm, prev, vma->vm_start,
-				vma->vm_end, vma->vm_flags, NULL, vma->vm_file,
-				vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			merge =3D vma_merge(&vmi, mm, prev, vma->vm_start,
+				    vma->vm_end, vma->vm_flags, NULL,
+				    vma->vm_file, vma->vm_pgoff, NULL,
+				    NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -3303,7 +3268,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
=20
-	new_vma =3D vmi_vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags=
,
+	new_vma =3D vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (new_vma) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 994e8d991e78..bd5c04974bbc 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -602,7 +602,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gat=
her *tlb,
 	 * First try to merge with previous and/or next vma.
 	 */
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*pprev =3D vmi_vma_merge(vmi, mm, *pprev, start, end, newflags,
+	*pprev =3D vma_merge(vmi, mm, *pprev, start, end, newflags,
 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*pprev) {
@@ -614,13 +614,13 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_g=
ather *tlb,
 	*pprev =3D vma;
=20
 	if (start !=3D vma->vm_start) {
-		error =3D vmi_split_vma(vmi, mm, vma, start, 1);
+		error =3D split_vma(vmi, vma, start, 1);
 		if (error)
 			goto fail;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		error =3D vmi_split_vma(vmi, mm, vma, end, 0);
+		error =3D split_vma(vmi, vma, end, 0);
 		if (error)
 			goto fail;
 	}
diff --git a/mm/mremap.c b/mm/mremap.c
index 7302a71058ce..cbafea7fe895 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1033,7 +1033,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 			 * with the next vma if it becomes adjacent to the expanded vma and
 			 * otherwise compatible.
 			 */
-			vma =3D vmi_vma_merge(&vmi, mm, vma, extension_start,
+			vma =3D vma_merge(&vmi, mm, vma, extension_start,
 				extension_end, vma->vm_flags, vma->anon_vma,
 				vma->vm_file, extension_pgoff, vma_policy(vma),
 				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
--=20
2.35.1
