Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C909A72D30E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjFLVQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbjFLVOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:14:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9532978;
        Mon, 12 Jun 2023 14:08:22 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNjvx020940;
        Mon, 12 Jun 2023 21:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=jJy/D/tGCP5LCjHyQT9mytgoujHldvFY7lgHb0sgTbk=;
 b=cTy7iS9i0ZrUKcI9kRarudplF9nrLZjlbjhLQ+yMepb6v4JfkGCo18gDOlB3tAwxEtP1
 xhP0bIh/wWpD4h08wClVVzcuQsuJ0yR1uRwKuwjV5X+T4/8RU2LdG3YnaANsPQ18koYp
 1aTGUG5MA/ohwQoLsv3ETw0I9xs7mQoHo97vPcKvuDlcmoh04NvYfYXCpKiYOhx8JpHB
 yiBXK8RKmVo9v8NxDSp/lxBajNH+5wiLjvUKESniAVQvPuJiScoJ4ZpG2HVwBHjyASd8
 RDbBm5E19lq/z5mBjIrkZpol7D+bfs4q9hMiE92aeezrw2ykuvS/dXzE/i9ytIZSjG0P kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d3vuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CL7jnI016206;
        Mon, 12 Jun 2023 21:07:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3a6xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJxGv6IQ6l0bIfdkKNZw5i1bwbAXLtldch1LbY1u1FXa/fKoRKqWaHmA3odlAWnbWKPGFyVDm9uAI7R36aMDCL+i4vo5vC8SAbMVASp9r+CwulN+VMnGWZeebF1ODs0CRonXBJvwqjWOxAYxhzamilrzh1qZVyPQ1rDoH/mb5pktLZK/67TbOlQTkQhq2a0aNyaWPA/QAvy+BUxalAB9pt0LT8mgHQ7mddhFZF+yUCt/08cLpYZZ63Kb9N4vNrkrGdE3tx0tEbrmN0S9ifgsKRhzpGNzklmHRhV5nppNNjcbOjDnKleQG8Ih+IEXLa+ZH0nyDpqT/Uzt6lYm9jw/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJy/D/tGCP5LCjHyQT9mytgoujHldvFY7lgHb0sgTbk=;
 b=Yky1qgWYjgUSfp+8RksYcz9363Sj3Su14aShvyMcqnZi5viVc0grly05Qvajrj9yTwuxXX7XdyH7iFQnzdMEkdB/knE+fs5z5hCq3hOuw6x2oDVglAEN6OiUD9rTinPJDNRqWHw8x7a75yU76XpMCuluspVfnOEJ4ELuAh/fg0MqurdmWPfkF31P4CzkvR9pc4cgxI0LxpjAPEp6dEE0IMvvvbDFpKSQdvuM+505vDrxhwiBRd6lxXEBwv7K0/WOJoMTX64Niz7I3W1oZm/X4sedfZGxPRtSA5xSlStzAOPoBwIjsgPKsN7FqyPP0vPl5DW6XnwmmP+DOcnwZrsosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJy/D/tGCP5LCjHyQT9mytgoujHldvFY7lgHb0sgTbk=;
 b=a+qli1KZffbFoKwF+tK33ArgD2F2Goi817F5i5NTzKMQI+jv5FymQZ1vOhUBAxfcJqRiF8DmxZeAbo8zh/Qt/0z84GQO68C/Stgt/9bfeMJlyIXvdBERpk3SQzlYv1defv/NEfDerNcWGtVgWYLTBugtbx/jIYyU6mUE5vpK9XY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH8PR10MB6410.namprd10.prod.outlook.com (2603:10b6:510:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Mon, 12 Jun
 2023 21:07:47 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:07:47 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v23 6/8] crash: hotplug support for kexec_load()
Date:   Mon, 12 Jun 2023 17:07:10 -0400
Message-Id: <20230612210712.683175-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612210712.683175-1-eric.devolder@oracle.com>
References: <20230612210712.683175-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:4:ad::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH8PR10MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c9ec9c-1058-45ac-26a7-08db6b8912f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEKEfav8uIXgIYbvgFDwcMnU4/PWdqAINiz43JwybwkF/HkrCAzHfOIag/5I58z3wbne2VceDQEAQImpdzG6Hd6FMAsmY7In4a9d4jtPlF98QvhcqPJs+1SCzwj+C2oiOslU/eEYrnsAeUvnY4y3EVttwZe0U8oRZcMG7gHAdAuQlptcsd23aa2J4i4Ywu+IVoi+1eWdyOMeOoz7OS/GczUEgLxtpxBeOMlH+6cGbQg/f3W+fL7hTMrR/an52L20PUP/lj5ALrQ2084wa6UpAoxUk4542LePcBGWhT994uQv4AqBH8azYjSOuQPP3bPmEr0RD2xo7fa7Brcv7jqLFhuLe4Co6LfyRr6UAkqNyqofoXxPuhWM9fGqJ698iyyzMzzCKy/Vdy5ouNY71xwCJY6ThSQKVfK4h/gJB7ryk7yrUSMxeEmIc6Lg5GYk77MgCo9+OiDFQc4e7j75hLOP4W22PrHmWXy6xJWS2MaGhQInsg4pgo2YFA5Wo8qJWFSPp+J0yVslJl+sX4aLvikItYlWKeIWfJwf7kScrRt5/nkHmnyC4M06ECVsP1+rF/a/N+1NAqJgqwKptR0xR5lxuUD6Qce3t5LaPrLJ2gEV5ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(66556008)(66946007)(8936002)(36756003)(5660300002)(8676002)(4326008)(6666004)(66476007)(478600001)(6486002)(41300700001)(316002)(38100700002)(921005)(107886003)(7416002)(6512007)(186003)(26005)(1076003)(7406005)(2616005)(6506007)(83380400001)(86362001)(2906002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rRiUgfftAk66H4XNSOxJzBc0lIBSKm2sh2gxXyMJBzIF3DSUTa89Mj62aofN?=
 =?us-ascii?Q?J2Jgw3bHHF27vk3dGQ7kFxLGhnEtR9Zu8YQhdU5R5yvaemBJHgt0avxr0J4l?=
 =?us-ascii?Q?4nS7hlckE95PrE/dyyW1GdG9fMJWFqf1ulHuqM/QnqE8wRmaraRT5LkU7WIU?=
 =?us-ascii?Q?Ks0LiuwGLENvDUZk3BuyvosMaDxZrUJN8Bb6IGkhisRieOWHCfUCj4ivxK/S?=
 =?us-ascii?Q?aH7X3h+2E4obM35c0+di/bcQygm5zHoZf/aYU0JxyPT9YayawtjqfIBU7Sgd?=
 =?us-ascii?Q?O/WEmSLCCeg6rt0nJQFsiFwsuuCfP+1YEvGTUZ3zSWi49ohBVsxEu51JwLsj?=
 =?us-ascii?Q?yB3GFVIp11Zuf9HtNk9hav5gYzBn8RGQFMBkSOoOtJXFO4z5wFgdiyuvVM+F?=
 =?us-ascii?Q?SFzbZtqDWAtj6/bye9BfXoI1A9gjRb8Zt1/Mihy7xiYE2WsyOEDPN24Q18If?=
 =?us-ascii?Q?QEZuAnmEMEz3nP3+GzgEYsDUTYppmMPrFH1YTztZZmP3PGsAer6HTP7D0YY0?=
 =?us-ascii?Q?jVCEFYGN4xRXjdQVqGHEoUx4bfelnD3iJOP6yWW8mT/zyjqEOsW6SJsHpauz?=
 =?us-ascii?Q?Z69CY7P2JElamIhdXFaRYQG/q3NMWXKRWw7/DZwtLb3SlIxLCkjL6zIlU0Yx?=
 =?us-ascii?Q?M4sZwRpDQsdAgkpKbKbUVYp5JXfIknqUtVyWOySzmAslqwY8n7nmW5hPudOX?=
 =?us-ascii?Q?dV4pomjL9I2Ms4SQiD0M7eAa7s8L0vOGrHUZPgrdy04nq/YZymsIxdNcQVJg?=
 =?us-ascii?Q?Ge8nCQ1ADHNA55jCTcaGWZ5xPYJB0kKCN1VEttqPXPK4uL1gcpHlVyekG4GT?=
 =?us-ascii?Q?uBTw517RTjIymwIZPYvAlcX5mOM6kM81DVsAjid95uluhUc46Uksm9EODAQW?=
 =?us-ascii?Q?ceNhWhWCJlPaSn+DrxqhZ7JtwiyJfgl0zZBCbeBICn46Wmj5QqikVSVN6/eR?=
 =?us-ascii?Q?Wk5NtB/vKNsUVAWXe+jGFW51g/HeGWRh5ISOT34TUfCtUbSF7A1mZJoV2mP2?=
 =?us-ascii?Q?Cjvw9Y7yyVrG3c05hz6gWTTItwcy6FD6j39f5fHceHWOxOiz1H9fYA3y/Ixx?=
 =?us-ascii?Q?clhr7O4fftZl30/4TSvfyME0s9FAtYWFmMJw9pq3uHpT+gav+Z88hj+rsPQJ?=
 =?us-ascii?Q?cHjFk308qQyg4yKetHMxZoHWSg52/iZ2rnhzjn/FAv6IML5xYmIyR8Hdc101?=
 =?us-ascii?Q?WqkzjQzLC+o3Dhe+JaH1+jl3joFJu0fupSi87VVEqnpH/FevfS7ebUYeEwh1?=
 =?us-ascii?Q?q4PbzSIKPtei1MsIwtef4odmFJD6a+yaPjJarH3DE41bQvbFNQNsNkgiSbeq?=
 =?us-ascii?Q?2FikVzXY6OMvkvLxrJFxmRNIm2jKlDaYTLLyZvZKB2Dq4MK/14m4bKsLySDc?=
 =?us-ascii?Q?puaGW6PpTMdfzAxoxSRV0e527AWI1nWlAkHDNy+hLJqPSCcW2zQ2f+uRBSHS?=
 =?us-ascii?Q?1bCKnZ7qYHyeyF9hjktxL7zXurQRRWItriqK8f05vzMJlfXqD+JHHrLqc6n/?=
 =?us-ascii?Q?XssHLD7Dpg2ZXS0uFTqcwO4YBQ5sZ71km10ETURZXIpgmQyHHcPwZFobo9j8?=
 =?us-ascii?Q?hC+n5kyZvTjvrQdeRT6ARGtcVRyd2ybApVwm+UR0kP9ULVB8PD6B9UMJ7B4V?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sC/0RWPI6ZC/O3a4MB1nbDg7XFLzSemjJ3sIfQ3Ss6iMn6ynid0STHrNamuN?=
 =?us-ascii?Q?jMThDXD/1AlENDlxWDvfbitOTRF3WwmICdv6hDEvr36jk/OBWNYn7GExWsUj?=
 =?us-ascii?Q?fJyKcEub7XZnMFwN802MsgZVQoX80JcD46/Nl/JQvaYbJMQnusxQH0BHHgvQ?=
 =?us-ascii?Q?ilFBLPW6S5woSvBHCufmlFTX54A7AuPWGf9LoVfpyzLJP7RSzyjjeAaRRStg?=
 =?us-ascii?Q?5dSxZ01TzOyV0adE5aVj19+Hqj+mbHtURuHzM3oILFVqATJ5TxNTtFlQbpDm?=
 =?us-ascii?Q?uxwy+SwxScmGgMZ4aZlMChdz6IWkIS3GBu8720ChQ6BQJAqt2fiExcw3Xk7G?=
 =?us-ascii?Q?Ob2mAFBHV8C8FhxcbN0CuuWie45OThsBiVWYMmPFz9oxNVR1MuG/uVL+DdpL?=
 =?us-ascii?Q?RZjsSD+gamN0hIg4pz/8KSJAKvaRj6Qe2ML/Pnd+uuq54pSKpVu4WxwxZRvn?=
 =?us-ascii?Q?n5IhWQijQGOZ42qinREZf16Bn3iNwPqdtAr3SNRv9+uYtZfz2RlHNJzBvizd?=
 =?us-ascii?Q?xqdyWF9yCMOrZdsHFDfDG2SIQDbvnmcnKjfTUva8j04jkR44yDYWHKCAJDzt?=
 =?us-ascii?Q?U0t/r3D/dWdJQMiSyIzzS82TMOlEjWBWvYeitlwX5ETnZ6m7BYASSy8TAIwE?=
 =?us-ascii?Q?Fl6X/C3cHxfKhXqhHREVqHsugSbAEhPk/GeZJZ4A8iTGZixAfHYxtOCa1n45?=
 =?us-ascii?Q?LwVKc1Dt6ci9RV5QX89AkYK46R1ldbPf0DqaRmh6qbruuL/4PsyN93okvW2s?=
 =?us-ascii?Q?/9uDjlh9oaJM+BY/lvueAHuwDWVJTy4TNC/cPqTu/Ryu+na9dYkH9JgoERfX?=
 =?us-ascii?Q?4+uTtur29WMxbOMCqAGNCWqV2Q99wtNpV3dVUyEx/11Lg+HkA458yxuvjVOi?=
 =?us-ascii?Q?MJBnMmveSj5izGjB9avuqI/JEmWIREVbKn5oadWz/q2vO5egfzTD13sOB1yj?=
 =?us-ascii?Q?5XEnNUjIAOK6CbERoMxYI0Lhd4qqWWwP0UHnatWHWUfnhDYlfLK9fch0TRWF?=
 =?us-ascii?Q?E35pjlGtmmMGsr9FN6JXcPBUBQAoSgVysVCI3rxfNx1V1t5QwdaLFsMkAhFz?=
 =?us-ascii?Q?eihIYrenUPzM8yIOvlqa8y0JgZ5Ve/Jb46kRr9prqfC4Gqd2nMxfA4ZVqNSv?=
 =?us-ascii?Q?MVG65452nIGQaufNkhqvTP7+uyqzectifs0JMV/sHicFJsw53QJZtUwx0rBl?=
 =?us-ascii?Q?Zl2b0IfGEHSXcLRMVuLGqYEHFQMIIMLLhhOASd/6GvVsAYlxj1IKLVgt3fTQ?=
 =?us-ascii?Q?VqyDZ2WTiE3dCEM6YEQbb4iI0OTI5eFkvevF4K2pgADdrKpcP7GS8WIa1P8D?=
 =?us-ascii?Q?h36eKjmjbqxv1Nz9TiTcZ423GkXkIuxyAIMEpIWLA/xXuo7lCC1Exp3MRhTV?=
 =?us-ascii?Q?2djDsArw1dGgWRusR72KrVCAprvDyxKFs9sXkstAi/enOFTWfJI+AFAH4fpO?=
 =?us-ascii?Q?fKVhGdfiLos=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c9ec9c-1058-45ac-26a7-08db6b8912f2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:07:47.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39QqpBMmq5Myqe0gvzcAto8x/DoiVnIq7oIjubXuVtHn9VdObmWJcwvNT36scz+SbJc8OaWZydIHpnH8jx0x5yPWq3+1nzM4HiX8C/ClXOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120180
X-Proofpoint-ORIG-GUID: 3MF584oOM9vdOWO_G0xEP1fFIE0LqmOs
X-Proofpoint-GUID: 3MF584oOM9vdOWO_G0xEP1fFIE0LqmOs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hotplug support for kexec_load() requires changes to the
userspace kexec-tools and a little extra help from the kernel.

Given a kdump capture kernel loaded via kexec_load(), and a
subsequent hotplug event, the crash hotplug handler finds the
elfcorehdr and rewrites it to reflect the hotplug change.
That is the desired outcome, however, at kernel panic time,
the purgatory integrity check fails (because the elfcorehdr
changed), and the capture kernel does not boot and no vmcore
is generated.

Therefore, the userspace kexec-tools/kexec must indicate to the
kernel that the elfcorehdr can be modified (because the kexec
excluded the elfcorehdr from the digest, and sized the elfcorehdr
memory buffer appropriately).

To facilitate hotplug support with kexec_load():
 - a new kexec flag KEXEC_UPATE_ELFCOREHDR indicates that it is
   safe for the kernel to modify the kexec_load()'d elfcorehdr
 - the /sys/kernel/crash_elfcorehdr_size node communicates the
   preferred size of the elfcorehdr memory buffer
 - The sysfs crash_hotplug nodes (ie.
   /sys/devices/system/[cpu|memory]/crash_hotplug) dynamically
   take into account kexec_file_load() vs kexec_load() and
   KEXEC_UPDATE_ELFCOREHDR.
   This is critical so that the udev rule processing of crash_hotplug
   is all that is needed to determine if the userspace unload-then-load
   of the kdump image is to be skipped, or not. The proposed udev
   rule change looks like:
   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

The table below indicates the behavior of kexec_load()'d kdump image
updates (with the new udev crash_hotplug rule in place):

 Kernel |Kexec
 -------+-----+----
 Old    |Old  |New
        |  a  | a
 -------+-----+----
 New    |  a  | b
 -------+-----+----

where kexec 'old' and 'new' delineate kexec-tools has the needed
modifications for the crash hotplug feature, and kernel 'old' and
'new' delineate the kernel supports this crash hotplug feature.

Behavior 'a' indicates the unload-then-reload of the entire kdump
image. For the kexec 'old' column, the unload-then-reload occurs
due to the missing flag KEXEC_UPDATE_ELFCOREHDR. An 'old' kernel
(with 'new' kexec) does not present the crash_hotplug sysfs node,
which leads to the unload-then-reload of the kdump image.

Behavior 'b' indicates the desired optimized behavior of the kernel
directly modifying the elfcorehdr and avoiding the unload-then-reload
of the kdump image.

If the udev rule is not updated with crash_hotplug node check, then
no matter any combination of kernel or kexec is new or old, the
kdump image continues to be unload-then-reload on hotplug changes.

To fully support crash hotplug feature, there needs to be a rollout
of kernel, kexec-tools and udev rule changes. However, the order of
the rollout of these pieces does not matter; kexec_load()'d kdump
images still function for hotplug as-is.

Suggested-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/kexec.h | 11 +++++++----
 arch/x86/kernel/crash.c      | 27 +++++++++++++++++++++++++++
 include/linux/kexec.h        | 14 ++++++++++++--
 include/uapi/linux/kexec.h   |  1 +
 kernel/crash_core.c          | 31 +++++++++++++++++++++++++++++++
 kernel/kexec.c               |  5 +++++
 kernel/ksysfs.c              | 15 +++++++++++++++
 7 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 9143100ea3ea..3be6a98751f0 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -214,14 +214,17 @@ void arch_crash_handle_hotplug_event(struct kimage *image);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 #ifdef CONFIG_HOTPLUG_CPU
-static inline int crash_hotplug_cpu_support(void) { return 1; }
-#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+int arch_crash_hotplug_cpu_support(void);
+#define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
 #endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static inline int crash_hotplug_memory_support(void) { return 1; }
-#define crash_hotplug_memory_support crash_hotplug_memory_support
+int arch_crash_hotplug_memory_support(void);
+#define crash_hotplug_memory_support arch_crash_hotplug_memory_support
 #endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void);
+#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c70a111c44fa..caf22bcb61af 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -427,6 +427,33 @@ int crash_load_segments(struct kimage *image)
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
 
+/* These functions provide the value for the sysfs crash_hotplug nodes */
+#ifdef CONFIG_HOTPLUG_CPU
+int arch_crash_hotplug_cpu_support(void)
+{
+	return crash_check_update_elfcorehdr();
+}
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int arch_crash_hotplug_memory_support(void)
+{
+	return crash_check_update_elfcorehdr();
+}
+#endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void)
+{
+	unsigned int sz;
+
+	/* kernel_map, VMCOREINFO and maximum CPUs */
+	sz = 2 + CONFIG_NR_CPUS_DEFAULT;
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
+	sz *= sizeof(Elf64_Phdr);
+	return sz;
+}
+
 /**
  * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
  * @image: a pointer to kexec_crash_image
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6a8a724ac638..bb0e614f2a05 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -335,6 +335,10 @@ struct kimage {
 	unsigned int preserve_context : 1;
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* If set, allow changes to elfcorehdr of kexec_load'd image */
+	unsigned int update_elfcorehdr:1;
+#endif
 
 #ifdef ARCH_HAS_KIMAGE_ARCH
 	struct kimage_arch arch;
@@ -411,9 +415,9 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    KEXEC_ON_CRASH
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
 #else
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
 #endif
 
 /* List of defined/legal kexec file flags */
@@ -501,6 +505,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+int crash_check_update_elfcorehdr(void);
+
 #ifndef crash_hotplug_cpu_support
 static inline int crash_hotplug_cpu_support(void) { return 0; }
 #endif
@@ -509,6 +515,10 @@ static inline int crash_hotplug_cpu_support(void) { return 0; }
 static inline int crash_hotplug_memory_support(void) { return 0; }
 #endif
 
+#ifndef crash_get_elfcorehdr_size
+static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 981016e05cfa..01766dd839b0 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -12,6 +12,7 @@
 /* kexec flags for different usage scenarios */
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
+#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 53d211c690a1..fa918176d46d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -704,6 +704,33 @@ subsys_initcall(crash_save_vmcoreinfo_init);
 #ifdef CONFIG_CRASH_HOTPLUG
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
+
+/*
+ * This routine utilized when the crash_hotplug sysfs node is read.
+ * It reflects the kernel's ability/permission to update the crash
+ * elfcorehdr directly.
+ */
+int crash_check_update_elfcorehdr(void)
+{
+	int rc = 0;
+
+	/* Obtain lock while reading crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return 0;
+	}
+	if (kexec_crash_image) {
+		if (kexec_crash_image->file_mode)
+			rc = 1;
+		else
+			rc = kexec_crash_image->update_elfcorehdr;
+	}
+	/* Release lock now that update complete */
+	kexec_unlock();
+
+	return rc;
+}
+
 /*
  * To accurately reflect hot un/plug changes of cpu and memory resources
  * (including onling and offlining of those resources), the elfcorehdr
@@ -734,6 +761,10 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 
 	image = kexec_crash_image;
 
+	/* Check that updating elfcorehdr is permitted */
+	if (!(image->file_mode || image->update_elfcorehdr))
+		goto out;
+
 	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
 		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
 		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f98776..107f355eac10 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -129,6 +129,11 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (flags & KEXEC_PRESERVE_CONTEXT)
 		image->preserve_context = 1;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	if (flags & KEXEC_UPDATE_ELFCOREHDR)
+		image->update_elfcorehdr = 1;
+#endif
+
 	ret = machine_kexec_prepare(image);
 	if (ret)
 		goto out;
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index aad7a3bfd846..1d4bc493b2f4 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -165,6 +165,18 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	unsigned int sz = crash_get_elfcorehdr_size();
+
+	return sysfs_emit(buf, "%u\n", sz);
+}
+KERNEL_ATTR_RO(crash_elfcorehdr_size);
+
+#endif
+
 #endif /* CONFIG_CRASH_CORE */
 
 /* whether file capabilities are enabled */
@@ -255,6 +267,9 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_CRASH_CORE
 	&vmcoreinfo_attr.attr,
+#ifdef CONFIG_CRASH_HOTPLUG
+	&crash_elfcorehdr_size_attr.attr,
+#endif
 #endif
 #ifndef CONFIG_TINY_RCU
 	&rcu_expedited_attr.attr,
-- 
2.31.1

