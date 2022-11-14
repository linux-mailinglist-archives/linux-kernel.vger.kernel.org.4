Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBE9628778
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiKNRuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbiKNRuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:50:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAD8165AC;
        Mon, 14 Nov 2022 09:50:14 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEHPfUU006525;
        Mon, 14 Nov 2022 17:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=hyuN/jMumAdi4wywLCptX9813PFV28UT2Rr0GRdGqDw=;
 b=BdzLFI+WJQOdJ7+sKbSExHm4V3qmThZX+iyNJRp5pXr3vy68hI5nqiZumw9DzJQCDBaE
 aSONBEt7Wp4t+gvnGJ7srZisq3mQnG2VMdVXcRr53rplgn8nYU8EloRiB/7RTyPdERm9
 Rx+XRAPK6SbOaNfcCeQBZln0tU7n/POQ24jPoCQLgs1YfQwY4oGnnmJwYGZUolWR5sbt
 x4IXsfHHDcj6pZacYPYpSpRcVct9mDEMCAvPL9s9Pw0oCxU3JZHsBE0P3zO0jxaX4Qou
 nXkJf7vdwQjDbTFjse9avDXXdANCXhEW4fwjAy8ksLXIyyAtqA0cOnEJIjbLBDRm7UaY 0A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kut2d831h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 17:50:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AEHk2B9032398;
        Mon, 14 Nov 2022 17:50:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xahay4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 17:50:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9FxdYZ39t/GHcG0fxAi0rQIJAR/zIa8CgtN7J1+YrhRfk1yAwPD/5lgPKzUrSyByc/4zlws+VUcujww3oPRbvS+5fmTxPgdq1qoRuXcipJzI+670m9AUDH+VyUncZglriMsbGwLMlvrYvQEhJ2hWVcOpemerBafJNTvN7ORfLnJaUh8j0HzLkMzwMTYQFtY1WxttEkpwdgauqHiImlssd49XdQc8yKUSj8c0fjIkwfsiP6lg9eOyUSi72ccZTPKu3FofytPIITMK012E4rNUMohd02TWcvl9rnQcgHDxYytfG4F9U0cYSswd3hrPxjDZaQ78AZbmMsAtTNi5i/yLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyuN/jMumAdi4wywLCptX9813PFV28UT2Rr0GRdGqDw=;
 b=iXe9GdGS68HwBAPa5D5vacJhe0emMDeAMrkKG7Exk5grjaD4KHtlEZ9vGDuopPnZQRhv0x1oT2q0J9cIXZw3bCcwRU5Q9Rac8WbT9d28yajoblWqGSwHTOAP/CDx8QadZqx8suh3Tn/8oac1h0QyQztwzheO2h/DyLGKbcb1cWArjxz80i8SfTP6uk09lL032rDERuz8yYQwMDYMqfSUe34I/hxJeJ1GlR+EdTrXrrLIai+GfUBFeZ6G2lk1JluHTRU6Jslap1cVYTRZObyzV6Bg1RDSK5TZq9jj99FY4zDplDR85hVrgigQv6KWaBSXNntauX+JADCK/VyFhtON8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyuN/jMumAdi4wywLCptX9813PFV28UT2Rr0GRdGqDw=;
 b=F9TW+T9DipY9Ugcou/kXrOKDqr/eoO+KrXa6lcYs88mf/Tyd2zAIpU8DP1BXqcF6sSPqGB0KsWV9X436Cw75EU9Ecsn1RcbYttxPVgvk3uuAq6ZpKzNl07Wi8T74X3fQZDpNCI12MgBERbcQ7a0q/kPX3gI9v9U2odVodsxY/6Y=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5381.namprd10.prod.outlook.com (2603:10b6:408:128::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 17:50:03 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Mon, 14 Nov 2022
 17:50:03 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 2/8] kbuild: add modules_thick.builtin
References: <20221109134132.9052-1-nick.alcock@oracle.com>
        <20221109134132.9052-3-nick.alcock@oracle.com>
        <Y2x22mKtaZvC7ZSk@bombadil.infradead.org>
        <87h6z5wqlk.fsf@esperi.org.uk>
        <Y25mXAGty35I5lQx@bombadil.infradead.org>
Emacs:  no job too big... no job.
Date:   Mon, 14 Nov 2022 17:49:58 +0000
In-Reply-To: <Y25mXAGty35I5lQx@bombadil.infradead.org> (Luis Chamberlain's
        message of "Fri, 11 Nov 2022 07:12:28 -0800")
Message-ID: <87iljhv321.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0110.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: 63106222-9a14-417c-396a-08dac668a838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTK8jkvxOUqtUsCMjE82MjBSTMKX2AQ096qLa/CIYpNMy6f4Kpht3y3+gp8RaheYpQSL3o6jGqtkzsAPL+doTkgSj9/zQFTcu/Z2t7WkzR40CDdzXEVxkIovQFm9n/iBngwTrt+PdRH2x3eQEQ/x7oMm+QLclk+8WX41vgYkxNhuk9325lfPxc7FZJhrv6PIcNkaRPR61baMliyX0kvejle9OTgwYkUtqId2O5dTyW+FoLJDW1DC0L2o9IAxnw4x0N/G325q5YTH1lUFIn5FVnu1vxMqbyfnP07o4wtRcTw1mx0+d0lPI3sHfG7YHkdh984xaMt6aZEMejE3xXTjCVGXrBXOQf5ythsFXOGDWIYYbVtaXZFXLkFyIA3F3STl9dKBaxer/vVVRYXyccXplyiySAcT9D0mqYcxsxG62OfICD25ZsbJ/7Vy60MvnoPrUNsP6DUxP3mPGzXbaY3kazesPOgKCvhvfzFe873ieSnDHDve/KeFyF8e5hI0Y8IwXVaYK6sEmKdi3B3tdgsPf1ViZM6svhljy2ekiewpWqZf3JJm20b2lpP/vDASmLAJR0RuwN5sEZ9rvmQYTrEikjdyJBrPLKX7u83DiZdUc4b0Nitnk7P6E3P31ES0aA2oHHH4HCeUZHJFOS+Yqt7vThR6+O/9aq/1jeQpOCcm/2XY+HR9YwU5Vi76scMMZk/L6CWqLnUXP8/NQW8rsWRbxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(36756003)(66946007)(66476007)(66556008)(86362001)(38100700002)(83380400001)(54906003)(6916009)(9686003)(316002)(186003)(6512007)(4326008)(8676002)(2906002)(44832011)(6506007)(5660300002)(8936002)(6666004)(41300700001)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NJxo6z0AWpFedlU3y1woPRnaCdBxHe6MMV7BHo76VMJ6vBN9kTZVqtHNL5fs?=
 =?us-ascii?Q?kNgsIF4OhO0wOJyUnP6DQo+KRzECgCSR6iclolE2/mokOj1Wft80mRcDrUgR?=
 =?us-ascii?Q?/wPo4GiV7BMB5+mvLLDP8/aTJ8IPsm0kbcp8JfSdMFRr6mYLu19c5Wf3h6+D?=
 =?us-ascii?Q?Iu+wz4jz3WxZ3BloUxThFChZ4hBbvkVJYiqQsbb+6utYtqlfGTpc6yZiSTJR?=
 =?us-ascii?Q?jPwg1jYyqByIFvQXsYYJ+zS1b3AMu3HNW+gfozLqKiOG6D4S3/BsdKXlu0p8?=
 =?us-ascii?Q?x7kCglroAXBxnq+20r5rJMsQcuKJpuiy6IZYloAU47Q80I15bSpED2/lqAc1?=
 =?us-ascii?Q?zEv9YVvvBD3yORxt/7Tdu9eIhfLriPX7lCLEIh859TS1jJipzCZNmlefRTbp?=
 =?us-ascii?Q?DXiOqw96/0zLXy7xgW/iQ4OOd3y7XEMYZ2hVdbHYsa1tbvzEgYsPVHoyh5F0?=
 =?us-ascii?Q?XPS4/or5edOCqlduvVXf5aUhaJ87DhADqverxR9PkAHHlOE2OEjKOdXbD70j?=
 =?us-ascii?Q?sA0MvOYfHD2YqWdqMeLwQdbBclaiwcn2YH9wmB231Gw6aCEbm/2mkddwHH06?=
 =?us-ascii?Q?bHo4tmVErL67Dt4a1IAbXiPNxNUW6CSzwkaGJCDQfh8pKIzvVKspwLpUT5JM?=
 =?us-ascii?Q?FdHROv6+OGafmgAh7WpIFa1C520GK4j8cjwLaoZC2AIPZ9u4S9ULcsFUNBxj?=
 =?us-ascii?Q?UXGykGXF+JAS5csQQDBq9+Yz830Ps+GE1eDz47B/Hkc+1Etcz5zMC4h9C08S?=
 =?us-ascii?Q?QNdWnNyoNLVG+XSBDZWBkp1EkW+XohcXtfZhCXjzlraSF3rhBMQ/xk3wfQ/6?=
 =?us-ascii?Q?CBHJnEk5uCIhoDQhZ0WapUUxuMjJ4MXjt/m/7vsU3hw3EHh1TDuuaCTra00/?=
 =?us-ascii?Q?G156hXE9/5ORFmyYTvmuT35WpqTxxVfPlww7iLHc+RD8Xc0OJ1bsd1AaoewV?=
 =?us-ascii?Q?kFPQlJV3/yvYsga55AYcNxys0lKXpGIJCtDSFZ9gU2FNgU02WPzb50sv3a8K?=
 =?us-ascii?Q?K4SX1kaoYM6+E+YaRxF9csE7bN2JacILqOOHit+E7f+w8nBHi8VobKV7N+/e?=
 =?us-ascii?Q?8vsOtYNNRP780tlzKnB7YyVE9dCANSmME+xmc/r3fODYOXTKk3JKrmpAO0sI?=
 =?us-ascii?Q?zZRKOydC6Mf/rxQOK1JwFd2psm7PlMHKmZ06Mv5D0HbTPX6lzGYQ2Tj51Bm2?=
 =?us-ascii?Q?WTvWcF2cz+EgZtTYDGWlHmwiZ1Wlz484YEPuQOazTTrryhYDb+FXsQEGojtM?=
 =?us-ascii?Q?7ZRQwTZ9j2cqARbW6/yWj7iESNCZ05TRNXeh9ZEMk+uZnZxfO+Np7GU3poyc?=
 =?us-ascii?Q?bDpFyZ3d0xYwAy2XEP6En92G6/XzOZ2/3wjSiGaYiEJMsn5tRPmLdfV1ILXs?=
 =?us-ascii?Q?mQCljVxAOfeJnZkvSwYWy1Jl0NVRMkbKRYihKU/EgNqLBa4PkDmOxQoVp/f/?=
 =?us-ascii?Q?YTjqmVCLgerW6m1yyBF3qElCsZeuPC2cqjUvz2jiTqihsFJsJzS5azblqdAs?=
 =?us-ascii?Q?m9Jp/6OFEbCMYSVe0yYQkdYYZgpRpOdBOahzBvcAqBz1nzYM0AYEbIpvz/xc?=
 =?us-ascii?Q?kusIisrJBDf/HafRrJHrs+DlDHGB/w8DWt6gLXQGMtY+mejlnyEzD034LO2S?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/BWHy6zlCZR0QyzYsmbUsVyPFCJb/TfpI7pujXKbotWuYXTp0HdgiS/FHvrn?=
 =?us-ascii?Q?H5qve8bV6r6FxKOcSFoD6gOOb32aBM61+/B1cN+Gc6/CzuNEkphEADz42oUD?=
 =?us-ascii?Q?lsHsb9vG3Qw6QdC/BUAitp/zAtpdfLKe/xjp920NvphrOajH9utG5IxxLKJP?=
 =?us-ascii?Q?8OuDPz2XY/6i0IKEOGUz4vPS0AnHTKN1k1gSDQqPi/W+P1R1s2hRwoTEN7oa?=
 =?us-ascii?Q?wLWdoi/Hwh9ndY8wznmHQirbZENJ3Ub32/HzqiZLQ7y0n4RjSbnPbFeCvuLN?=
 =?us-ascii?Q?3fCTBrajwZLjtUmzZKAQyvzMeVwSYa8kQyz7d+AHQnHzcYJ7TEC7ypO4kREQ?=
 =?us-ascii?Q?IJXKZmP5dIN84VH3KGC+aU0ecZxcODyNvCWsYuRP9q401aP6tUdqZcM0pbc/?=
 =?us-ascii?Q?zB1dmZSnxtN5PMSFoSUIG/SQz+EXoIwSNd+QHR/9DsjVR5KqxBXR1DNWvGQ+?=
 =?us-ascii?Q?D20EdJ5YxwxvWyRliVOjnnbhPAXdf2/+bv3USbl7sA96PlfpC071TK2jjdwX?=
 =?us-ascii?Q?08pedPJLLwYdVJXWQ840GKfsheglh3jjGNKNPCFUx1177lS1qfNxNl8f7rY6?=
 =?us-ascii?Q?bqvIWvBQGyxstzg8C0Lj3tFRt2vMqz/vJTvx95qEjx9FDxvlbiJcwLK4oY/e?=
 =?us-ascii?Q?uU07piJVhvFJdR5/bn+FZnWa/fCsaRqIL+PWL3QuG1N3p1IN2UF7wVrIMvfB?=
 =?us-ascii?Q?w5f7i5N+wHgj27ZPj+ANOfyEje+o6nqGeLfAiT9vC9tOawFRBqqgcOJKGJN3?=
 =?us-ascii?Q?LWT2MA8ck9dQ86WWpc0TksjAuG1PNk8l0IO3zpAYNL7Hl3hektD6SCQUwo8Q?=
 =?us-ascii?Q?bpzcTyxYiDJb8/FSEduWn8LFkH04P/XUHydHXdYr87sHZR+4WLDF0tTZvoru?=
 =?us-ascii?Q?dVONEgfe8twSgUWAhMfmMncSpZNlfuJ9GBdRGkzI0q2Jdx477n+xhjowLyWo?=
 =?us-ascii?Q?0enRSdgsA7nAo/F+LZ6XEvndMyP8iVEqkoTiPIgOYuU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63106222-9a14-417c-396a-08dac668a838
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 17:50:02.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0i2MxpVmj/OMgCOA9qe24x3hqZIql8NHljU7qKAGeau7lSRBf5uHffoIkOz9OWHqOXwsoiZgdufSYDA8pcwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=710 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140127
X-Proofpoint-GUID: 7IR6R_TTU2ZA3zmpTCgpbdoKU6-7XZbm
X-Proofpoint-ORIG-GUID: 7IR6R_TTU2ZA3zmpTCgpbdoKU6-7XZbm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Nov 2022, Luis Chamberlain outgrape:

> On Fri, Nov 11, 2022 at 01:47:03PM +0000, Nick Alcock wrote:
>> +arch/x86/crypto/libblake2s-x86_64.o: arch/x86/crypto/blake2s-core.o arch/x86/crypto/blake2s-glue.o
>> 
>> But...
>> 
>> obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += libblake2s-x86_64.o
>> libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o
>> 
>> config CRYPTO_BLAKE2S_X86
>>         bool "Hash functions: BLAKE2s (SSSE3/AVX-512)"
>> 
>> This cannot be built as a module.
>
> mcgrof@fulton ~/linux (git::modules-next)$ git grep MODULE_LICENSE arch/x86/crypto/blake2s-*
> arch/x86/crypto/blake2s-glue.c:MODULE_LICENSE("GPL v2");
>
> Try removing that.

OK, that works!

So if we're using the presence of MODULE_LICENSE to indicate that
something is potentially modular, I guess this means I need to do a
sweep through the kernel and find everywhere that cites a MODULE_LICENSE
and cannot be built as a module before this will say things are modules
that really are.

Should be easy enough to do semiautomatically, I hope (by comparison
with the output of the old thing using tristate on a make allyesconfig
build).

Hm. Maybe we need some sort of checking target that can use something
like the old tristate recursor to detect this problem to stop it
recurring. (Said target would only be run when requested, so it wouldn't
slow the build down the way it used to.)

... assuming that people even think the presence of a MODULE_LICENSE in
things that can't be modular is actually a problem. If it's not, my
chances of getting fixes for all these cases in seems low.
