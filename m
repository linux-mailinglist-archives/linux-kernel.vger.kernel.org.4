Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519CB6C2F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCUKl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCUKlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:41:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC1A18B27;
        Tue, 21 Mar 2023 03:41:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32L8HSSW022316;
        Tue, 21 Mar 2023 10:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=P9sk6GhVLUfSKhtp/9wt/a/M1LKjpHIxuhNivET3wwE=;
 b=O/GO7qUw1zu/xlDML2l6+03jF3ZmKyf3cAELxOBiUeYrjWYhT4iWvnc0so9+pAgvVsK7
 shhTHDgr7Oy3ce82LfZHgMwUvXAIFz0H6y0I8vm4SwC+CBtrCDZ309VCx2FoQMBmRouH
 l/ZEuUwWeMC3jBlHZfQ66f+I8rLkpO7O7O5yPHEP4yW+u/xTsUQSax983MUwS+koJn7h
 Hv0h3e+O9NUBVYm2NNh40QH3BQkhVHJChJWgBABUlPOT6kMYPsNJ5IAb97kOkG37+58o
 WUO8V378F4GThr4Rnhu7GyR7ywMfnHy6Z+7WSluh0C7bN+gK6QMg9380d6Vxln01S80S 9w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdnspf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 10:40:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32L9xmVj038673;
        Tue, 21 Mar 2023 10:40:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3rd1b05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 10:40:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5WGD9a1mGfpI6OOrn49erF6WHUYCLXFSNySozVJCg9/MBpayKqc8psA7+xdvWnn8pCOOri811oXg3+hXns9p3xDySmh+xdk63jG5z4Ft2xd3kPbsD0Ynnt+UQKhrWQy6yLgevGtzzDyUX1n9Sew3YxOHQhayLbECmI0V4jmPZnzliWK7BlMI/fHvoFEW0uQSgGAKsQt6Z5bh3lwj3EiYQdxbeU8ObvmyMA3Fb6QP337oAWZqsi8XQ+AJnLr52cg3Vv/IlGl5X+vIfmr8l4Co1rIGExcynxMzGS1YQHdfkCwEk4JQpdOSgpZDfCCT1gJ00CrAGTrqleo+m1ROMBuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9sk6GhVLUfSKhtp/9wt/a/M1LKjpHIxuhNivET3wwE=;
 b=oGSUbArN6G66JIuqKRwd3gEWRiWEvX3mHEpdchOfMe4OiH1XXJZdDkp2RuyTHV01Qbx0gH/ANDnoHJkvpxuHwuVtpMzOLp4Uqp0gQ0XBOQyrKAV7mo9HBAPFSXmOZWkacXvlS4fu64YA7tLDxE0fE1wb3lxQFWvE6QdCIwxaaW4gSAPlnt0TAOzjNCWmTD4SgKOZlO0E0EYY0Wxb53iGwde258HnGN8XKDTCdXp1Ns7Og59SJ/xegcSQdhPqVam3tAv9w+pjmjPQvwmqm/CLqLl2x1oOObFFM3/laufZBog+l+iryNiRgRdGHwqkAo/86j8fHgh/Ubzz+D2/nYe9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9sk6GhVLUfSKhtp/9wt/a/M1LKjpHIxuhNivET3wwE=;
 b=FWy6MLj+RlQG15M7SbRQ0vPPf9F3JzKE55huA3vf3D2LVoSqSJzQcGcHEvrmToQKCre7hmnJDC5SGfl4Gcgz7DtnM9EQXdpLkuOrnOzHQY6FQOAEhND+WvzBGuw+ahrLoNWa55a6lSDRSqSiyTiLV6Vi7SIdHZdiE/NYefnwpqc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM8PR10MB5399.namprd10.prod.outlook.com (2603:10b6:8:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 10:40:47 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 10:40:47 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, jim.cromie@gmail.com,
        linux-modules@vger.kernel.org, Aaron Tomlin <atomlin@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: RFC - KBUILD_MODNAME is misleading in builtins, as seen in
 /proc/dynamic_debug/control
References: <CAJfuBxyeKz3bsc=WfjJZDKgAHScC80_irQvmsecxPukjM-J8gw@mail.gmail.com>
        <6af9da81-7a7b-9f47-acb1-d0350bae7f3f@akamai.com>
        <CAJfuBxyoeuurDoUe2tLs=JbX=BbxGdYpf2yBEP6bkhtFh2XTtQ@mail.gmail.com>
        <ZBjKb8fXHOxnHuHD@bombadil.infradead.org>
        <CAK7LNASVpBih3iSHd=RXkKNZQ-v5LVzEOuZG3H_i3fcZfsGhDA@mail.gmail.com>
Emacs:  because Hell was full.
Date:   Tue, 21 Mar 2023 10:40:42 +0000
In-Reply-To: <CAK7LNASVpBih3iSHd=RXkKNZQ-v5LVzEOuZG3H_i3fcZfsGhDA@mail.gmail.com>
        (Masahiro Yamada's message of "Tue, 21 Mar 2023 18:03:01 +0900")
Message-ID: <87edpis7yt.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0612.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::6) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM8PR10MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: aabe8372-6260-417d-c82c-08db29f8bb0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MT24WwY/GlowjHRXSmt5xr+FCcrfv5w6vBYXg8idzbPqPsJBPrwVDq4F/JS1a8zEavV6vuZWCyyPW4v5YKkZE144Bao/J4P/vijd09enFxwNSRy/o3V+sWVnsuwTU+8aJJRhuZrAvC0r9gJDPucSU01JFekrOfpE4t3P41nH8xjZ1J0QIE6pJcgA3YlvHc+/5aJFCfNrJT7klNY1iZJva598y557qmtHb1KVwZ0Qwchk3wkqffbzIWe3WdzhoMnV4pNENnvJ46C6gU17nLRiC3h+hbK87twRZO3YWYfCDbOBjLpJMDQhrgjo9OO5i5/oZV7VafjW2lbTH9xinIptelNQNRZsG/h18FJLZ+1yHcwAGpLnSE5VhX/hGpPJwBqSrO5eMf0GvZAp8P6i3Q4T/GAmvUWnuqOOA+Ivfp08svbXjVytoehArAj8IgHhVTA06KhMVayC9mMa9qpxwKMIYPunX2GAOp799g1wY1Tn9FT705CqzIZwbKgwBJJ9XfyqgKH0lk6Nbs7egIcJQIzwuDZHIYfs2rihp+ph3h+keDMMFtXr3fh5/qRMBRiwQgt4Byb7mZrDzfzfc20jC2bROO9ZOo8s3a3AtvNLVslMBQa6p7tkBh1EIIbsD0UG/iXCnBk2OFrIqB2aLt1tFJ0UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(86362001)(6666004)(9686003)(6486002)(6512007)(186003)(6506007)(38100700002)(2906002)(478600001)(316002)(66946007)(54906003)(4744005)(44832011)(8676002)(4326008)(8936002)(41300700001)(6916009)(5660300002)(66476007)(36756003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tB8u5wglIF7vJqCwtIUZOwu692fdCJ8/cRIt62fobq9Xv4T8alUGPBJJgJRt?=
 =?us-ascii?Q?ofzJxpata7IxUsiVWgT6mRV1U9uDDQD4SDxojK92T5nVAL+lt9itiUJ3QP/V?=
 =?us-ascii?Q?hlpP9FsfM4jSA6DiRValp/edTDxR6LJ1c8nlrDg7MtVv/uu9qNwZR0im0nye?=
 =?us-ascii?Q?Ekos1gyCFVzzmbD8vR5ApCyK75emkrIDb0CD1S/i1rEuYjVOd2NwBCDzFYBx?=
 =?us-ascii?Q?ugvUOLSDVSMFpqUAM20wRIJvlEy7jbZZm478VhwLliZ7NqaGpCElomKH0wUn?=
 =?us-ascii?Q?3ebxUnx2uGOsFZag9DYY5bnDJqDosHYhic8k0c1UUI/ZKO9Ress/Az+tGen7?=
 =?us-ascii?Q?IvLNRfZVVbYGCuDTUaTPfEpcOHVidRqmzcPzsoDLPOBsDza1s50qOQAE2ZZY?=
 =?us-ascii?Q?Ktra4B35Gw5dpS3uTrwHJ2x4jsUt02OA7COsWtmO+k35tGHwCr7Jkn6K7W3v?=
 =?us-ascii?Q?4IxUfpt+R+R716UiRVejG9qhCk+KZJh4wXJvDknmBXt7CT8XD6oIXaBdJzCJ?=
 =?us-ascii?Q?M/tQ5hWVI26hUaJVC3Yqv8uplwLORySegwDutTa7AT98+DWIUbJX4XCHJINY?=
 =?us-ascii?Q?wOXzgSYEQSt83W5DYd9Z8YnoSkSCobs9bKO0BLDaOYj6x4tJ9ZdewT4ayMmo?=
 =?us-ascii?Q?GED5E9aFxpAynAQsFnuQvvmGGG02hFUXx1tYz41yFCqSJIiGRuBxD/OoA1AZ?=
 =?us-ascii?Q?ryxkXMtLqy8+RBOXNe7BQGQ01f4j4RwZ/E0SZAOgXQKiIh9O35dJYLaDQWaS?=
 =?us-ascii?Q?nG8EA8vq3Pl4rH4L0lONGzVME6tTL5Og2Ud9DIMuiBKj5aDvNs0zIyrccnDM?=
 =?us-ascii?Q?JjBgYkwQMm5gquM+2jCe6wR5RPPeOelZhxtgqXJecvjvCVTUHZhwh+aAUhG/?=
 =?us-ascii?Q?2yWcJxFgnRmHwG3Rt5M4Ax6tWHUv3+hM25mc/RxBdpyZ07OZ6Zz1Ailsfebb?=
 =?us-ascii?Q?4V7xTHTE/9dMQW3H8Su81ek0KIp4kOM4TeKCEuwRbauVxG/ABlE3fH0/Bj3y?=
 =?us-ascii?Q?LCnWdbr39eloB4AGbtNAg9TYOW/xeDO6fRn7Q9BiCOxAuaJpo1J3lVimBMHM?=
 =?us-ascii?Q?Yv76a4H8+9+cLqRBkVcGR4+6rsve9lo/wJYk+qZg+BMbvNKo0YK1lxFZ8e/U?=
 =?us-ascii?Q?VyTdZA+2fgxuM5hLR328Cff73BMlehZreExXgMsaYm9eISlfI1kq0nSIUU2c?=
 =?us-ascii?Q?Tvvzf4Dur+YkDeQUDoCo10qg9JsbX9emCZKg+RNsAqnHBu4rWrXgrrnUJICf?=
 =?us-ascii?Q?eC9PJzBgycVCbuznr5vj0+MqPi0poV719QzCRC4e3nJoXDWwSXTsM/CA/YmB?=
 =?us-ascii?Q?k4NUIpDqceQkawyOcXmEst59u//I/KQDZ72kgl2wx+txrwGPmZxKCP8jcI45?=
 =?us-ascii?Q?OdCnqXJdBSSQUhXnPIQCT6VQ6TCmu52On/mMKcAmPlOGdnkrB8zQm8SfNJVZ?=
 =?us-ascii?Q?BP8UlfmcOh2WWSf9s6V/ND+wYjxgcFtGzpnGlQh3+k+WW5AeB4vIPQqNZuEX?=
 =?us-ascii?Q?spFk31DF3KXJLqOQrsXW7qtDUdnyJfDJ+c8iYoSr33O2+IVX2nGMRYyw9OcE?=
 =?us-ascii?Q?6SZyxu+LNoHfejKOnWluaVRf5vfAuuxz9kgs/wjiI/zo4D1qSyTtZXM1bR9v?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XUpXPF9fKzVW6mj3JqHrIbZBxPYIjO71ZYwb6djTuQOTzUyzBb++mXOhSsrx?=
 =?us-ascii?Q?rBJYQsL0jnLhJZtD1yN9TyzJeR8K2PvrKRstIxD7mqIdR1GSLleNtSCNWTM4?=
 =?us-ascii?Q?6iyEiKdDF8c8gaz1WTbf+Uu3fzKDrCvIIWdVm/KVM+hTf1v9uxQwIz0sU6qS?=
 =?us-ascii?Q?cOj8MwQJB1fCAakddfAeD3Ak8yO4WWutdYojNMGu4VMJzQ6Sqm7WmDhXz1UL?=
 =?us-ascii?Q?uApQ3raGUljBvZVJoinPtSpCpzEjl3P+V1wfpdq4cnIO/Y//fS6wpFf7hCrL?=
 =?us-ascii?Q?ZZHB1BCD6BBQXmupEvVvQS4+HUxOAOsvpRt0658eyKeOqnCy2nRurARkNZxw?=
 =?us-ascii?Q?5mFH6rSm30PnTqOzzrRer66l60jL8T8hxhbYteaXH0ZXBwo7nLl95FWrhH6y?=
 =?us-ascii?Q?bxwhhP5WpdjYn808d3kmzecEgi8qsMa1m43EdAB9nZ0I4cLHpexAwghyy4+w?=
 =?us-ascii?Q?G6bksczydyLcBapkGS+kD0seipYdF4DgM7Lq9JomXG/K0EMIAwEuskPn2qkX?=
 =?us-ascii?Q?/jDP6RdQD/23WCxdnTxCWBpjVvHFikjX0+4aj7CnsZ6ebI+tVt0RyPUWZRJd?=
 =?us-ascii?Q?+UW2y+8RkvVdi81OpW8H24OxdqeZ7j0L5Zqn/c+DiSJKkZqpLBlQWrbacGMo?=
 =?us-ascii?Q?8Pn1m/TGN8jZ+xtz8H8eqXG1RgpzefIbT+urZheJWRJ83tvycLyfmHnO8fZ0?=
 =?us-ascii?Q?IIKTLm3Fo/zWo4zkZ9iszAMJPhQLRSG5tfqK0LG5uKo9iTYE+92v5nb5yjle?=
 =?us-ascii?Q?TwSwqL3gxS0BaiHcIh16rskGi1aChV/QMfl26R7xFP/dbEUYpZCyx0A4oAkf?=
 =?us-ascii?Q?qvx7jfTNdgHev1UBJcufgCl3yviDLAyKLHj3nVK1h87/Cx6CNZFl0OHka1LZ?=
 =?us-ascii?Q?7hifRzXh0pjFHTrOp/i9vI0x1Oid6O5otogUkqCLfgMB8cExHeJMaU6bV7Ei?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabe8372-6260-417d-c82c-08db29f8bb0e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 10:40:47.1087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vpfco5UPsU2PAWnupEX4mAO6Qx/jLZAYbEC/WkGj0Ek4XyDedaCm2ZCObl119zE8dGxQIZB7nZEnoJbUmqMEDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=683 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210082
X-Proofpoint-GUID: c0vhCaWtlVcmoB9HOpqbvGWO8LoVPaHR
X-Proofpoint-ORIG-GUID: c0vhCaWtlVcmoB9HOpqbvGWO8LoVPaHR
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,SUBJ_AS_SEEN autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Mar 2023, Masahiro Yamada stated:
> He spams with MODULE_LICENSE removal with no justification.

Luis a) asked me to do it b) asked me to split it up like that (believe
me, it was extra work). A good few maintainers subsequently protested
that it wasn't split up even more finely.

I consider doing what Luis asks to constitute justification enough to
give it a try in this area -- or at least I'm not going to say no
without a damn good reason!
