Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A286B6334
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 05:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCLEmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 23:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCLElz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 23:41:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57833B0F9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 20:41:44 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32C4G3hO023637;
        Sun, 12 Mar 2023 04:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VZXYi0uMroE3ZrGubcE/Epemt7XlRbMyBd2+1LdzwMo=;
 b=SOVMmmztBda94lf/TbLpsnQfklCdgS3FEWT25lpDkOwWwe6DlXZ9yAagNNT4heoHADB5
 dxXUyQ4KOB7Xzr8+l8+bl5rxxmt4bkLZ1P/QKatMuxbv/TFY3YvS8deO6TKpr1gljMWA
 FxyyHBIG5EA/vRBGrZeHpAg+N61+Vkmq8wA/mQ1cS0PDdq6aIWJS2qSzArKRCaw1N5j8
 2MotsW/cV57iJwmfODb6NcHlW5zvJjYKAc6hKgfJwjVwDEUOpdlat+C/YYSlMEIhSPRo
 HvnBu5bfEAtdUjztNvsIh3XB1nKMRVLTqWES0VfqCDKiPWfPkn9io6pZ0l5ACkCwypes qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hha8w9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Mar 2023 04:39:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32C3e3fq008154;
        Sun, 12 Mar 2023 04:39:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g339sxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Mar 2023 04:39:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/dTEDiJ81ZgA5ysWkVt12w2anpwe7fAOF8JrX1qnEfP4z88yTqsppIKGDtKB0UOMzztG9SB5pqDFIThUbR9aaZyc95oRQA5lsoSRP98dFokXOiaCYjp5gZ4iC66QXjnmrBvwaYRlfZgGqxWLATkiHwJqpABN3bDcE8m6HZsPEwZxmsRRRPmHxkFLVmpYQGYenkgKwfIJfR5HTaiY9I1DQxP5kUScAZYDHqTYz0TJzT465aOjeVI1apjrlGF7FCbtkLgoD9gnTj9iyXbMeYLl0xYT16qH7Oo2NHKofyvWyII/+m7I7gkGtdUOcNF2rz8aEnYJ4zHTQ4T5NSFzjALiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZXYi0uMroE3ZrGubcE/Epemt7XlRbMyBd2+1LdzwMo=;
 b=WKkw2I/eUrxyK21ww8/2tj90TeZvXGx5phL8fOc8PjLKiPCzIpesrE9MQLL6zUvXBR5SRx8slNX2l01s6VRRhqieJdB4/OCdu3itAGfafrA1WSJ2IrjRd/S4ogxqKOHfCLvzXtaxZ5PlSWgH036d+KhnYuwjRyA4+V9la1xBCvXqQp1F2/cHqRppXQ7jALPNBpxpRnSbicnQmBQLLPyp+x6/TXtZofimuyhkMTgLJjznDPgTbOTyISM+fFbYTCEMvyc9rw3ikUEQa4GAXPUbhi8Gd2mhFx0chgeMWLrZD//S5p5cRP6jbGeQ8PAtaw9RJ5JskmmcRIPwc3xXJsrC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZXYi0uMroE3ZrGubcE/Epemt7XlRbMyBd2+1LdzwMo=;
 b=vpYkZmq4j9onQYYJBdWBUSIxP7fqvHpDKPoMjZ5irvbIgeesh1EyfV8aVneD1x8O9//QJA/uvVWzn/Wyt0jl/q3mt1TejeRWmDxibNCRG1AZgJtLMqncgWLG+XTW3dLZJQ9pC4xoKH3lE69uBEKU49GU8zSpH2e18zD9V50GyyE=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by CH0PR10MB7481.namprd10.prod.outlook.com (2603:10b6:610:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sun, 12 Mar
 2023 04:39:05 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::f1de:9c09:166c:4e89]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::f1de:9c09:166c:4e89%5]) with mapi id 15.20.6178.019; Sun, 12 Mar 2023
 04:39:05 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     David Hildenbrand <david@redhat.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>,
        Mike Rapoport <rppt@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: THP backed thread stacks
Thread-Topic: THP backed thread stacks
Thread-Index: AQHZUId6EUNxRdiQ4UKEGoIYcgiIL67zHhkAgAAI0ICAABpxgIAAo6sAgAGi3ACAANHVgIAAPmGA
Date:   Sun, 12 Mar 2023 04:39:05 +0000
Message-ID: <3A5D4B5D-FF0A-4AB5-8E86-24893FE82A9A@oracle.com>
References: <20230306235730.GA31451@monkey> <ZAaCISgq4A/GnkCk@x1n>
 <20230307004049.GC4956@monkey> <20230308190206.GA4005@monkey>
 <CAAa6QmSdTo77dP2q2nU==C_2PdyF611+PVF32uPOTUQbp1kc9Q@mail.gmail.com>
 <20230309233340.GC3700@monkey>
 <CAAa6QmSiuFF6Oe0-j+eD0ma2tZAbhZuwENDYSZQSBrh1oeaLdA@mail.gmail.com>
 <9F855331-33B2-4366-9375-988B0D3DAC98@oracle.com>
 <9f44de08-b484-baa7-80c8-0a02a7abb717@redhat.com>
 <20230312005549.2609-1-hdanton@sina.com>
In-Reply-To: <20230312005549.2609-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.21)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR10MB5559:EE_|CH0PR10MB7481:EE_
x-ms-office365-filtering-correlation-id: 536609bd-6815-4d33-288b-08db22b3b644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6+MA15rq6qBEsCO37XdUYCncJXsRTA/lGJKPZV0ZhcvCWgP5EcDT3irbme0H1y+swqd2FRAjgfoMDSTPO/Xaorvoq1/51yJtiHFkZ2P4ljY37LjLVgCVympJ41KnKAHrYwKCLlCXhI96VitmmBV/ou5uwqD4r2YzlN52MQ1sySrn0sYPGY7ctV/MFhbQ33AZFJ100qarwUGH91HmPJWEflDeMcW3y9iM6r+a7dGLyj1Nu5S34cZhGyw9778vwoQGlQfz+h8x/msZOrN0g2e8wHClcG9PBpmpv+YwotA/bfIMtPR+Y4BogD0C6V9NQqBL84hd58wQL4mdjmtY6Mpoy2JB+V10RDwKt7vx5ub2LMNmd5c/kGBDMnXI2f7iuhhe/uRidShalMZ4i9QEbVFgw25gYijwKZi/BJqfzH85ZidI+HmOsMc4aFEUJhQwHX2EWjHkE6fipSATGTpQYkzlnLYLyCDDBRSvuqQXwUZb04I50dGh7BFKn4lOZNP4Pv/Ifp2CzGRDMSxLEQfFHxp9OGHytdlzuzvuAnRuPmhH2YLx9IglCZQcnzSx1+H4WW8PRjzu0/OIGSH4+wSb2DBuZjM++oq9JbwqH4bIGlkADWsT6dahisnvezN0e1omSTexWvMNbvDgBmdCIbNX+TB5Ub0yzX79NiH2DqyPvUHAtftd5sCTKbtfb7ZEj+UflA38Jvi0gIGUkwpYrRsypMcYwx+xGszBYPiWA2nhnulHYE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199018)(54906003)(186003)(6512007)(53546011)(6506007)(38070700005)(6486002)(5660300002)(478600001)(71200400001)(36756003)(33656002)(8936002)(86362001)(2906002)(6916009)(4326008)(3480700007)(2616005)(44832011)(91956017)(66446008)(64756008)(83380400001)(76116006)(66476007)(66946007)(66556008)(8676002)(316002)(66574015)(41300700001)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XcHwdfF7ML8p/TLkTuK1GwSEBYwFf54WP6TGIE4DLtzjq8xojXkOoaGtgiGX?=
 =?us-ascii?Q?4b+SRdBU/kOYqthEKcIc+lori1G7GFFVXy6SU6g4ob9iKl+tfGjQbiAegDOa?=
 =?us-ascii?Q?ASv08k30p/tFvEBAKfLkXWKclFndsXRVzcTRM0LwPRw45cx51g9+1d+iaK8B?=
 =?us-ascii?Q?Pz+4kMbdgoOqrTuuiNmiJKbl9eh0YPNjTQhhTjEHBGlzDAIv+LENbYjglWZt?=
 =?us-ascii?Q?VePUzlsWonGmpzDt3iUlwAn106Hru2SG66l4ua9gNYmSHrAm30HleNz05MWp?=
 =?us-ascii?Q?XgN1FPlY7mepFBzaSfe+rxqvvpnr62kDBEWp1+5EF4HCpko4ZWy+CkvMFsja?=
 =?us-ascii?Q?rKR4FS7HuadyQaPqBO8ikeVzmiu91cHqWghzMCH8TLTEyWvK+8GD0g/H6ydd?=
 =?us-ascii?Q?pE9Pz7V8pWZjsqXHHeg3D1qQdPmVig1mwXrNNnre1ZqaLrNU6wTas8p2clcc?=
 =?us-ascii?Q?iRot117uo5dVLt7wFwP0zUiQgTaR6eVWsVJf76y7eVZFimyW5XyEW6UOTMJ1?=
 =?us-ascii?Q?mx5pFegCFmwBevEk+cehz/iqsJLtocg95WyBbS/q02iDzVmx8D60oMYbDjSG?=
 =?us-ascii?Q?VMZrryduBKSfuFmKl4d6uHKTQkOv9bSw7zfqn8lrDthPWcnJgvxbLADdqJ4A?=
 =?us-ascii?Q?G6cxyBrR9uxWs4EeP34EDwVjO3Za2nwUzHLDnWEY2yZf5cQV/2VTuQtvba/i?=
 =?us-ascii?Q?77r2IzSlxbx/+zS01NHSpLwqcnDm9ZMr/tblNYayRYUMwQ/wZjLUN6I765rl?=
 =?us-ascii?Q?qSTv+QG1yZZwmMIUst4//MBLpWeYlgdxk8dElS61paiurThj0Yho3IykBFFu?=
 =?us-ascii?Q?X+jvn/gcV8RrlNLEknSr6COp4559AlyvPjhU6/iHkkI1/fiD/hjFrR1k8usy?=
 =?us-ascii?Q?EGfFPW2R9Itv8msKO+iDt+25e4mY/Y6gy/UjbnfuCMGlarzwA9PXQcIE98zd?=
 =?us-ascii?Q?XvvQFRbJy+iIwXBEWU6E5+pkFHAHzOaZqte+Ir9KSe1x1UcaPU+OufVJ/DvX?=
 =?us-ascii?Q?5s9LXPMxoMRNSXv1HmIIeqvYQ12UDAoGlzEJwnmKIbgdbuX9HWHW12bEIAdk?=
 =?us-ascii?Q?febojGno8M3qm49X6wR2sYj6BgJOuaTsUFZ163bxdI3EZAtA07k+CmoQlmZ9?=
 =?us-ascii?Q?BVwb8N+YOYh4Y6qulDvovILTn8SCYhAttqcJ2VPysFPqWPGTJnT3ktxWRHmx?=
 =?us-ascii?Q?X3vGwFdysi6OuK2AEXDXVl1SHUYrQWaVZRIhVf0SHzWF1hUuZFlkSoJeZgHF?=
 =?us-ascii?Q?ggeVdpBhrwCZ1EoDq9CPAtBY7F69TToadqdPjA7evWr3g3/rg5PWLaEW4QNa?=
 =?us-ascii?Q?YeFxDKCYVSWGS7ZPjIWi5A8lVeCU4zkdDeiPfy6KKexJyPNEn0uJUm+F4Qbp?=
 =?us-ascii?Q?SrsKjhviJS+E1ytHfkQCYj6lAAkDKajf1OZ00aqFIhv134RewapodHvps7jx?=
 =?us-ascii?Q?LcXRf2ujc0kGbPaNY9+1dEkOdNJPMeb+aFiYEPGIBSWZDeT9t7q4Mou6+xOI?=
 =?us-ascii?Q?cPLA7Pk+Jyh6HlmExd9lY5ip4NJEitJzZJPegHpVXZ/KI8rtZEe8Y8g6vnEe?=
 =?us-ascii?Q?yoIuXGHUX/e/yZB7zIal+JsTLsvZFb+szzYk/kt9T1fOtR2Llzo/WbGhI+it?=
 =?us-ascii?Q?d9vF+421gG92ZoKKYJ+hIZcM1ctWV42B+eAnZVQjZyaptiWlFu0ctVkWsWxt?=
 =?us-ascii?Q?3DvFE4Vj7LlsX4gnI6z84xCvJ+k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7904E2C6C8F464E90C1DD5FB611906F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2nwesG+4rjfSO8uP91Jxg92LU865rXvJxB6ihQbcBUMOrUyPtIaCC2kKQrEK?=
 =?us-ascii?Q?QnKYqTPgjvAPzxbFlHI5fPBJzuBjrHOzbz4DDN6vCoKqxIuw3foO4fpRoM/M?=
 =?us-ascii?Q?fh3pg7uygvgSo0OOJUq/8dzuYzXroQ2xIJnTMp5onrkJQzy8ObxvYgi1U+R2?=
 =?us-ascii?Q?lBFRhYuQB4HFQozhwvOHvRKVeT7Ju1Zw/LzpOZIzkuO8SIZTqYCxU0qTJ8xY?=
 =?us-ascii?Q?4PjlNPFiTXX3GDFuYmyz8h6ESsNXUUDNq5NK6KnktHuPbgaE2jw9L2MqV2FN?=
 =?us-ascii?Q?OPpYwmB7h66oD9wGfUQzma2H2PyHNP+xA/qmSekIKK4m+INR5SOfG0We0aqJ?=
 =?us-ascii?Q?K22Ob+SlUmlqtgVb04kABmo+ez4XF20s81YL20Zqtwok53Ml0lJzFV/3JO17?=
 =?us-ascii?Q?6YbZS/w8UkdZzbPVumRMZMaH9cI7ZLgd2AhNaiMlQbr4taktklP96uScJnan?=
 =?us-ascii?Q?mcGUBwtY0WpvtgLMFbfM5jyve2i/Ci0SESReqw45C2g9hfYDuLTpMrjNTF/K?=
 =?us-ascii?Q?H3Sf0v+RyljtW4Sa/dooHWkWhJPaKoegEN5Ooq0q7RXW+1TBUcqsWPbgIvl/?=
 =?us-ascii?Q?eNIGrcLu6xJYdmDYmgXEG9EcyNNcZTeOghu49eKEBePt1svdQDDhFinClZKy?=
 =?us-ascii?Q?oMWS8uSO14bwp6FeMIbURGR4pq9Wnsss4H3vgUbUBvKmjbSSZWF7IwpgQX8S?=
 =?us-ascii?Q?2EMUiGsHOC8fexOWH584CX8du3l7q694z4f/f0xYTjRy3F7Ew7Xj4vp838rh?=
 =?us-ascii?Q?Ix8u5Do+boLlYrJwBPkLU/NHZSfKegT7azTqrNnWcxXD4XERlC8J1BZYDk9a?=
 =?us-ascii?Q?fJ8yt3gYzhPRApo79yIUY1ivJYd/OTll6c2eEG5wR7j+kmUwJF2xqUOHvLU0?=
 =?us-ascii?Q?ZrA8ntVy3LjacC/4Dkg7lsLi20stmCg5QqxXW5NXlTyGuEB2rWHcKVWCthP6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536609bd-6815-4d33-288b-08db22b3b644
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2023 04:39:05.4841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BoKlQp8T1bGjeDVKzgUD/aFkV8WmupgwN9rBrZ70OgEv10CgLxjYIikeX07ePbmloSBbTe5pZQEOqLy2w1ErcpLOE19IAyY/eY6kxfp01Qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-11_04,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303120038
X-Proofpoint-GUID: HZWl6gFklb0XjnoSF5sUVci82CYPyRrm
X-Proofpoint-ORIG-GUID: HZWl6gFklb0XjnoSF5sUVci82CYPyRrm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2023, at 5:55 PM, Hillf Danton <hdanton@sina.com> wrote:
>=20
> On 11 Mar 2023 12:24:58 +0000 William Kucharski <william.kucharski@oracle=
.com>
>>> On Mar 10, 2023, at 04:25, David Hildenbrand <david@redhat.com> wrote:
>>> On 10.03.23 02:40, William Kucharski wrote:
>>>>> On Mar 9, 2023, at 17:05, Zach O'Keefe <zokeefe@google.com> wrote:
>>>>> =3D20
>>>>>> I think the hugepage alignment in their environment was somewhat luc=
k.
>>>>>> One suggestion made was to change stack size to avoid alignment and
>>>>>> hugepage usage.  That 'works' but seems kind of hackish.
>>>>> =3D20
>>>>> That was my first thought, if the alignment was purely due to luck,
>>>>> and not somebody manually specifying it. Agreed it's kind of hackish
>>>>> if anyone can get bit by this by sheer luck.
>>>> I don't agree it's "hackish" at all, but I go more into that below.
>>>>> =3D20
>>>>>> Also, David H pointed out the somewhat recent commit to align suffic=
ie=3D
>> ntly
>>>>>> large mappings to THP boundaries.  This is going to make all stacks =
hu=3D
>> ge
>>>>>> page aligned.
>>>>> =3D20
>>>>> I think that change was reverted by Linus in commit 0ba09b173387
>>>>> ("Revert "mm: align larger anonymous mappings on THP boundaries""),
>>>>> until it's perf regressions were better understood -- and I haven't
>>>>> seen a revamp of it.
>>>> It's too bad it was reverted, though I understand the concerns regardi=
ng=3D
>> it.
>>>> From my point of view, if an address is properly aligned and a caller =
is
>>>> asking for 2M+ to be mapped, it's going to be advantageous from a pure=
ly
>>>> system-focused point of view to do that mapping with a THP.=3D20
>>> =3D20
>>> Just noting that, if user space requests multiple smaller mappings, and=
 t=3D
>> he kernel decides to all place them in the same PMD, all VMAs might get =
mer=3D
>> ged and you end up with a properly aligned VMA where khugepaged would ha=
ppi=3D
>> ly place a THP.
>>> =3D20
>>> That case is, of course, different to the "user space asks for 2M+" map=
pi=3D
>> ng case, but from khugepaged perspective they might look alike -- and it=
 mi=3D
>> ght be unclear if a THP is valuable or not (IOW maybe that THP could be =
bet=3D
>> ter used somewhere else).
>>=20
>> That's a really, really good point.
>>=20
>> My general philosophy on the subject (if the address is aligned and the =
cal=3D
>> ler is asking for a THP-sized allocation, why not map it with a THP if y=
ou =3D
>> can) kind of falls apart when it's the system noticing it can coalesce a=
 bu=3D
>> nch of smaller allocations into one THP via khugepaged.
>>=20
>> Arguably it's the difference between the caller knowing it's asking for =
som=3D
>> ething THP-sized on its behalf and the system deciding to remap a bunch =
of =3D
>> disparate mappings using a THP because _it_ can.
>>=20
>> If we were to say allow a caller's request for a THP-sized allocation/ma=
ppi=3D
>> ng take priority over those from khugepaged, it would not only be a majo=
r v=3D
>> ector for abuse, it would also lead to completely indeterminate behavior=
 ("=3D
>> When I start my browser after a reboot I get a bunch of THPs, but after =
the=3D
>> system's been up for a few weeks, I don't, how come?")
>=20
> Given transparent_hugepage_flags, how would it be abused?  And indetermin=
ed?

I was speaking in terms of heuristics, if we allowed callers making THP-map=
pable requests to have priority over khugepaged requests by default, it wou=
ld be easy for callers to abuse that to request most THP-mappable memory, l=
eaving little with which khugepaged could coalesce smaller pages.

This is much the way hugetlbfs is sometimes used now where if callers can't=
 get the allocations they require, users reboot the machine and make sure t=
heir applications requiring such allocations run first.

My apologies if I am missing an existing mechanism preventing this, it's be=
en a bit since I walked through that code.

   -- Bill

