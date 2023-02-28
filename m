Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04CD6A59C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjB1NFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjB1NFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:05:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAFA25E1D;
        Tue, 28 Feb 2023 05:05:07 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S5rchx025872;
        Tue, 28 Feb 2023 13:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=EU8ZZcGTiF2MKt5h/sTLk6jrz4iLvmXhm9ryUVcqpmI=;
 b=u9k3BRZjuK6P8bslqh5eEwTLWi9n1Q3ItA7dpU+/5X9Fn6zJ0u/gIT7MGrjTQtP3HUYa
 lfpiA059l3mZGuWa0oHtLqaLVexp27yzaCllVSFo7YlpIgxBMZhVsVQvRy+3TK5/KnwD
 Urxu0l6q8NaJ83lF+y9S71V8LCaEdmqIa2J/S0iffG21jS9ueZ5cDlykwPpkG2bcExXs
 wQ1Lb3VNVpRgSQ4nx+tz8JiB8Efq5J9uhq92QUDggWFmZdEWrj9rtwIsrzSdN34J/ch2
 m2AZaKKeIN+EM4d0+y/peGhYDtNGuG/8n7Q0Q7H3nQxnRl3gTS0JF3tdloln4BGhN3q3 nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7wp4cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SCtTGe000438;
        Tue, 28 Feb 2023 13:03:13 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s6gf74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DypiqwciCR/uTPDsW1A1u6OOUiJpBpmemEiq3275jcUNs55iSUUoojlhAM+/baniTCtvcQpiRLtk+s6OFlU/dLzNMTgjHLHivjbQVK4+mH4XVnqfYXmqDIfBRkJ1/ev8p2nRaYZQany2g05FtC5L6nMV8nouqKy9oUhpa2j1lHhCEYZ7MXEF75t/10RmGmDiULuVu7DDa8VAe7CLz0vOdtUxFa9cdAqLlo/MzmAzWPc5HUR/UrgrdHI4fV3xshCB08rAupVQVaUyuxuv5fH4yKGCDx94JZUYvjIyJBG6k07VDiTf5zranHXOQSMrElaFqiEqmhp2KStFOAMAlI4uBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EU8ZZcGTiF2MKt5h/sTLk6jrz4iLvmXhm9ryUVcqpmI=;
 b=UwQBeGn+Yu+EZtZzh3G7yVdkCzW5PsJdfDyrhnJdVcmBwFeEU8qGMmbMHnmanI5im+W2LE+v5y2n9apr8kRtoLvbnl12tT9ixyitMDBgFTkY7nnqyRlMadpn3dhnphdGE2XZPuzpisQUjNil/U828gYT/sNRDI7wzrc0T6zWo+lK75AmIkK0v7NjDx0C1Klg4jJhQGhV4JA3cXwakKsv3Q6JOO46LEDxGq5+Wkg/ckEbE6CLIcr3Fm7GQMeVdfEtXnrjzFK6Es0XBYs1lIiIPpDLT8O4+lJrhmFGv0g9fgiT9EDvkAmkk6yv+F0oILDS0100kX+6yLT4uUMVyi3TBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU8ZZcGTiF2MKt5h/sTLk6jrz4iLvmXhm9ryUVcqpmI=;
 b=cL4o4TIdbgajObwIU5sqCAVowpdxGEpUfEsz93PxbeAdb9xZdx14EtQa2l1sLppb6Kx2D/5O7xFh+IdxOQfmtrNp+rmMH6Cga62IuVtwVBHx2pWgLaFxC4EifwPBwU4DrqsaTEFk7dLiKc3lyX6J66TcJwjl2jgWZPfqpoSGrIY=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 13:03:10 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:03:10 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/20] reset: mchp: sparx5: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:05 +0000
Message-Id: <20230228130215.289081-11-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0247.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::6) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 01aea1e6-0272-4749-b8c8-08db198c2480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kxQK0BJnuXEckCmXNI5RbSDcUgse2YLNZciRmGWtkI6f94lk+GFUaQkPWvBOr0s4kSXp7KW/g3Md+5id1UDLClvB7rGlsHNwuRfe4NzVcsJCog91KbJ/W4INhYBtc1wcnUy3KoQ1PKrVQ9iRZE6RFovH9rhGst2b1neC7W5SStWY2XFvhFQLmUoaUWGdHbSI1BmOBsGUfFrBisGMJXlAeSzv9/jQEFqsAA8/2J/ag5r235JpyduWyZAV/3XH00NUZztaM7x+veSXGwCa8HYCDeHZ3JE0uxRHXFFO+DOkQbKH1ACxwEvTW3zNH12Lc5jtynVCz+XRJnvWhKv/nOTvcGou61c/uXZxDv7NpOD+53hpQlEfi43W6tKYVULvnNyBL71MIAp5eanAzSPgcPTIxG5QEMs//iXTK+94nlXB+0vx7Abq7uqSYeqqtBgMmtVagNcLCraoqUTWoymt1HkPivRqpFPBmK3nGcNEbjzAq4icYr5vrGIQdTeik8W7TsmjPEQXtHwaX/kxc1OpzHEe8ldW4TXZu0h3G9qfMs6FDXDCbwv+akdZck1VVn7Ch3G1986IBOTVrvtZ/s+WT0By/0WVO2Z4ByStK+6DUu7EbFSfIkFGl8ic4HUKtKeXv0SdiFxrNbg7qo5WOQjSTUyHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(66946007)(6506007)(66476007)(66556008)(6666004)(316002)(6512007)(1076003)(186003)(54906003)(2906002)(478600001)(86362001)(6486002)(36756003)(83380400001)(5660300002)(44832011)(41300700001)(7416002)(8936002)(8676002)(6916009)(4326008)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qoKXDVncMevpWOfjYjwgb6UmJvu0jpwwzOvKjiU1Q6NOy0bX4s2SEbRu3pSq?=
 =?us-ascii?Q?tWiVzVxUq0mrzmGUT3XVUwGiDjayaH8l7shqQysu9dXU0MdS2zn4u8Ha+RsY?=
 =?us-ascii?Q?ZZJWXHByF00fgnivCOPCOUoZxFHfbwSbIJnODOu8S5twnwOXrA4S7C1aOifN?=
 =?us-ascii?Q?D0w1pZur8Jk98apiDExOu4VcEnLmZrqZjWCv97Srd+ROn6iQSRgecL4Cpp8s?=
 =?us-ascii?Q?yVnY88cUoA/ZZWJMXpukctYQtgdh+HDui9sNAUVsr6sSjVSqYNnWf/MkEaFp?=
 =?us-ascii?Q?EX5tqQ3rQp+tivHdQCK861QtKrtZlHkFcUN9rbbHAnFy2VdFXqQl7Jg9Ru9d?=
 =?us-ascii?Q?w0CWITYff7nUFMEMIuh1x3AQmypmiWX5t9f7LAL/ggCdF13GXhP29H2uus/P?=
 =?us-ascii?Q?ggHjNbACCFYVkmvwaEyD2t1HtI0QgNy0OADN9E0L4Hj3R1C++udQA0KOyHfz?=
 =?us-ascii?Q?NRdY98OJdsIP45+j+KCq4JpW9H0KfKIFu/qOgT0x1MjJ1o+ZwvcCqzSRu+e5?=
 =?us-ascii?Q?IwH8OSkQLKHO+q+nA3uTEBtTreor2rkMbE3DtN55T6OnsqxKdLIiyKo/XREk?=
 =?us-ascii?Q?LgSHhyOr4+bR7UIxR/Fta17eDH9C5qRfoe3Ei0k2+qF+oAkXtuifr+mPUt//?=
 =?us-ascii?Q?fH3q4AR0hRCi9rxDduNrTUNF0ociQTb8PA42ukYL0zynRzRRwW7ywuHaqcrL?=
 =?us-ascii?Q?Zd7CMukPNcrLL2UX9+3xnmVT+hu6wS/UKVLywPCftee/h2n3snDQLqdBlhdA?=
 =?us-ascii?Q?znq8ozpFLVbsqmPPgHs6vI8yIrk75jAaHgY3LGU5QKHFnxbUgqZQvTg7PBCV?=
 =?us-ascii?Q?As1yVLhnQlIRAe37nxMoDGC6YVT0AU0MLitVVoCUueh3/ZVT5EOUvST4+20H?=
 =?us-ascii?Q?DHNy7CG1drUJw3QxGZKWhjkGZs01A+2kruIwKwdVgg1H2oJ2hd1C4tB/IeAC?=
 =?us-ascii?Q?LOCtjo0ABMsQH0KNNbmdunnB3pb/tzRkWBPr/eI3to/RsbEa1qZp695LpAyV?=
 =?us-ascii?Q?R6wImSbaqQmmNQ7tm43AaCebdCQybJkayKVhyoQfVPdHyJfT56/VdQx9kQPz?=
 =?us-ascii?Q?ryQtB4AfXSLZVSd/5XSDkOt8ekZ9qJtsGGASBhgnVq0eZeFw7TiVyWmmjrHS?=
 =?us-ascii?Q?EkASy6iGX3Xwwq+HV3PX43vINPkeATz+0YcFYgPisKG76Lzjj1OuLvKQtxme?=
 =?us-ascii?Q?zXr7dlzAjvmCC48vp92LkMUPzdgkChKvv3q47/QHl9vDklJL9uNuehFw3K6h?=
 =?us-ascii?Q?9aQFLmNUe/MBsmSF4P/XpHzSKwk1qGg/RV1lByPESgWtTDeelPMYUeYta9Io?=
 =?us-ascii?Q?8Jufiaz39gBb0nu8M+HMnHaSasvztp0hK7hduHSBdMJiUYCBYf8UuDYWNzeI?=
 =?us-ascii?Q?Qsk9a4hJBUFJcpgNz0y7V9KCbCQ7Fc5rzLeFK0LJqMX+iHy0tI1VjwA3h9UH?=
 =?us-ascii?Q?kb6gxEMMP1ynAfVBZz9o3Ald6XnWpwE6N++UEqb+0N8EUlgrVStB6x4d3KCc?=
 =?us-ascii?Q?tVsXUp8d6kYsd9G0lV6H+HOu1LdiaMoeiBCJ7sxnK6JhTAS9HBd7nDJ9HpvC?=
 =?us-ascii?Q?4aeK9O/kgkKfYgrq0WO7eGjepcaoI8uaOknhraSaF6/uK//LQXYFYPbn7XMZ?=
 =?us-ascii?Q?DgWrIlwrTIyBuI3vr1quPfA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?utfSj//47acY/jKNMh+MMhjLjjvOIF8y4VuUhw3i8QgOQXjpbObtSPLRaTeC?=
 =?us-ascii?Q?wwmYHZvKY14xZEpMMq1YIcHu+BUXxqaC+u5eeSF/3B/LXXTUK3Dh6x2hUMKS?=
 =?us-ascii?Q?EKoDE78EyOUDXML4axHVyd1YGL3pYWw16pwcv+YITUT+RHwuWnRoZUzwFWDS?=
 =?us-ascii?Q?XJ23NRbqeQvbKJmqKSMR+djvnrWeLdRuGvR9xTqDCqdXwSEDJwgcjsAysoE5?=
 =?us-ascii?Q?PVFZ+UlNG6hVTn+IpOSK31WALctX7UMnxBcLfMJ5puahhoyAed/n8I3XcBbY?=
 =?us-ascii?Q?9Hucwu56JnACtwikJMLjytwF039IZMb5tXerAmzq6rib82XyYFj6Me6VXjn6?=
 =?us-ascii?Q?LI/QLfVSD63FzdQ5Cd4vXBJZIJrUhLRkdvaJZBx+nOqjHQlZvEKsgqLQlNM/?=
 =?us-ascii?Q?Q6tXi4li52XJW/seoaH/pBkFHfkP/8b/YlkJXekUhKF8/fVJvB5QlmQqdZ+Q?=
 =?us-ascii?Q?18lgcdJ1wBQ6dnB338YE36loMkwknabg1rK5F0xoingHaz1YM91/SuhE84ls?=
 =?us-ascii?Q?WHnlQtbLeBWR5I16slWnxs8jCEW3wB73dQ9j5oexwtIVjs84i7YG159xsCO0?=
 =?us-ascii?Q?G0uO0BaqMlK7xsfFqx7eRa4eoftzweiC0fgMZq0AXiskWTeukauwRcigjTr6?=
 =?us-ascii?Q?DZ9ep5LHT5BCK/HObcA6egNtyFv6DA3AtzjEgh8haTKu0MhKHhzE+vld31EX?=
 =?us-ascii?Q?X5FHiKx5+chIjxnEkSedjnkmVkr7ygbu4zWcCfcgvFPP49srpMYgrW2qqvfB?=
 =?us-ascii?Q?k5/Ss/JKREuFE+7eJN2D9PCnDawJUHnp3fE/V7a+eP+jWfSwHD6I1h6rlWc0?=
 =?us-ascii?Q?jIQaM7F44m/pxmX2ukoztxIzgiJgmNAud3VnZLHE+3K4nHgejB4gEesSIear?=
 =?us-ascii?Q?RjnUfAu0okVkKVsQ9lzmy8QxJWgxaKoXhSruVPUfWpt9ayWeeNhmf7IK2HxB?=
 =?us-ascii?Q?h9FDhXeyqrlQqrdzStt80g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01aea1e6-0272-4749-b8c8-08db198c2480
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:03:10.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68F2pGtPbBpC3kfRRujbEWftNh3z/axPwaxPEP2i8U2S7p35luQt4CvwB4EjN10fCgol7MC0Tu25kAt9I4yozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280106
X-Proofpoint-GUID: o2WfAXjyU3TX5aK7E62YpEcM2sxsEQRX
X-Proofpoint-ORIG-GUID: o2WfAXjyU3TX5aK7E62YpEcM2sxsEQRX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Lars Povlsen <lars.povlsen@microchip.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
Cc: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/reset/reset-microchip-sparx5.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index f3528dd1d084e..ead25942061d2 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -179,4 +179,3 @@ postcore_initcall(mchp_sparx5_reset_init);
 
 MODULE_DESCRIPTION("Microchip Sparx5 switch reset driver");
 MODULE_AUTHOR("Steen Hegelund <steen.hegelund@microchip.com>");
-MODULE_LICENSE("Dual MIT/GPL");
-- 
2.39.1.268.g9de2f9a303

