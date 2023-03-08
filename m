Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F896B0739
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCHMfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCHMfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:35:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0572A5F22E;
        Wed,  8 Mar 2023 04:35:30 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3288E7xZ013120;
        Wed, 8 Mar 2023 12:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=UNnORFSEMTAKF2RRgVwJhfz5oROmOYjUlJoB3fLZNb0=;
 b=CyzAJiLW/gh5tQ9nEgbg/r9vViua5zoB2ctWlBYY6wk0252RQREhTtCZ08G8JdELel6Y
 PmJliShYG+vo3srBgeRR0gCAQ8aKAec6h+ZkW1ksIcNkorNY0KoMv2Q3osqu86SeDlAy
 Eile1iLw8Wv9xNEx9yF9HYmJsNtLXESUKk20j0i9/BYRQsfOMG4yullFox1dJPQKgDfL
 FHPKiuvpx2BxCLfUQaBM6yHhkrr0ZAXO4HBqCS3tGlmL1k3EfScdxW0AbY1zSoxH3w8y
 pqmDFJeaBY7KGcnsL+dmY4IIXvyptwBK2kmdo2ryADTmD85U0StafSMHhhR8AI1XJf0+ PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn949ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 12:35:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328AjQiO022307;
        Wed, 8 Mar 2023 12:35:22 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fr8p3rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 12:35:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So7E+smhRzKr/n4DSwzIPWuN9T4meOpv8GchMwaI41kdxOPhAy4ZAdVBcrf8SDYjwZkokS4yCxgoS9+nFHvUucNOznPZJeEg11yEwXvXdq1qCZG7kGS4B+Oq3+fMwbNTgbWJb9ak2auCwwnvM1INqBsR3JhW9qD0k/4FJf23/0N6YQ2zlocXVOJ4u7prTS3wRFTEYTrl1s7bfgxYLycqw5DYwdmGAWxHDOuAq/pbF77nurkDoSxQtV8mex/hzWKa8RlwqJzgmRjrDGVub9Z1NpMP5brqjjlLBGYWIDMHHk3toZB6JCvk4T+61CcnwfqvnRe5CnYXK7RTkl0aRti0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNnORFSEMTAKF2RRgVwJhfz5oROmOYjUlJoB3fLZNb0=;
 b=HY0FC5UDLbSiuNdqVWwnCVB1EcatsyLsXj0nkw6qUpDWNvo8HwMSOIojWlt+X0W93afvtS080axKv34yQDOQ/8TDWIXHsWKxF7m3NGPXCYYsJJygag/hClvukeVT7EbXIPx9eS53dAXoGAbONzXXVPDsrcdpOip3r7YHIGSqwBBjYY3pOIOzDLPugYC2xbSoHz5EN73squQwRllA0vg8X6jr81jYoPDPfUU/gJHnOqMTCqqWDILV+Ssvi6dErXAKDJhNv95BdNsM/P6Liap9lHgfjfDcTsttv8iOvGh07UG+cS4agz50d0SvDoUHnQtego4PrD3Vy5edoRVx5GsnnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNnORFSEMTAKF2RRgVwJhfz5oROmOYjUlJoB3fLZNb0=;
 b=XXpbbQx3zwZgymwJJW9mdfZ8eDMSvoTFm9RCHPP6GCsoPljXkqxIf0HB5riyy0JUqCY1+DAAJiGcpn+flXmREVnTaoITxQ2CAHvjygHsClLxSuaieIJxttNENNwmL62zKCqrIKtz2Sh7tCpybHZx6jtxK9D1p7oC/BhvRJZ6FDM=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Wed, 8 Mar
 2023 12:35:19 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 12:35:18 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Lee Jones <lee@kernel.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH 26/27] mfd: remove MODULE_LICENSE in non-modules
References: <20230224150811.80316-1-nick.alcock@oracle.com>
        <20230224150811.80316-27-nick.alcock@oracle.com>
        <20230303105203.GA2420672@google.com>
Emacs:  the road to Hell is paved with extensibility.
Date:   Wed, 08 Mar 2023 12:35:14 +0000
In-Reply-To: <20230303105203.GA2420672@google.com> (Lee Jones's message of
        "Fri, 3 Mar 2023 10:52:03 +0000")
Message-ID: <87ilfb5sl9.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0196.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::6) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6603b1-576f-40ae-b58a-08db1fd1937a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tfD+yCP1MWTh1LY9PHPIV91iK/jer90Ip4DKwk4PfK+YhXytAbCLQkKGOsXLg5UB7UqGGdw/oFxdMkD9Gxbp98W1nhjDxxy7hYFpq321ioWW15i1z++cJSSoz/57tw3kxNFAtzZgZf24OPcRRXzINeaJ+/SaxIJWuZBl5h+1g3NxYbHDKqbPFtsKekWUzzVptannnQEWVDDBq56DPG0SlzWuHwj1unzt9aJV3zSyS3gpcpA06CV6/ZT3+v8b0ALGZlgxscA+W3EQk5S/iy5zqtKGY0LBs3c36Im6Eyeee4jz8nGIG73CVJYCNapLJCT2DyqPEwKSD+nj+tPYeW0/GEQv1mQxSpwDGEVlyrpkxb10C0U3d5H4Crynijtc633y9GZ4zVRVA6fDsXQrH2AVOCvvqwSnWncCMGn8r8kghLxvObkbgw87czk/4pQG5SBGK6yyc3hI4q0r1hmNcgVEOWWDufnF8XHg8KopD7C9K6eQ5mDU/EADZCgMxRNHu8GOrbzJPOnXlg3dUZae6Ul8V0q3fK9hw2tL6m1vThodEtV4CaVC/wUlegcPMFT7gGO1r6bqa0AC7Lp9hB1Q3Fx+MUfl74ENI8t8OLDNBn1wBysWgJsqlcr1uLLlo+fgxJMxXjx0Xtjp41w4R7rMWIKrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199018)(38100700002)(316002)(86362001)(4326008)(54906003)(8676002)(6916009)(66946007)(66476007)(66556008)(8936002)(6486002)(36756003)(478600001)(5660300002)(4744005)(44832011)(41300700001)(6666004)(186003)(2906002)(9686003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zir5Ky8K7BMFC8QVDdpt96uaYiMwheH35MFoMRq98ztnG0iG9HUO/CTzOZ2l?=
 =?us-ascii?Q?PyNzPxBePTlm4eJok4iBfOK8JNoUB2Zsx1W5/hjau5cTkD+/uVBebf1xgsyA?=
 =?us-ascii?Q?wbS+VEgJMtMyArK+uuomolekWqOwhXg/axk/P4CNKBFzbWh6WwLC6cD4S9CJ?=
 =?us-ascii?Q?pQiHs8gP168WEkjhYUQXbuXiIvNvo/sjZDgnQo46kNJrihscpKRnZMRS5Qas?=
 =?us-ascii?Q?/nP5id+EvdeZHn/UifVsRV3mj5H6KlP7iEcAbsyTr5G+mnjq7AmfBGz5hth6?=
 =?us-ascii?Q?BuRmEhje4srmVidfvgord7RfM56pqfVZpSwGSX0ybeq5aolB2ymlTsZvzQW3?=
 =?us-ascii?Q?V5LLMnvuGUv0tfUX9kEeUDRjCe6Rb1Y9zPwMC0mo0+WahZM0wmIGMLrqRFsX?=
 =?us-ascii?Q?3H8GW6Y0mCVaaR9LR/46sHDMaFml+H5gkBtleHI8WEFKgli/rQ7kebUIwTBF?=
 =?us-ascii?Q?Nr3HRfwxM10hIAbWRdE2hdTEi1nw6qbBs3xghv4ZjzygQN9Iz+/066U6WO2W?=
 =?us-ascii?Q?EFB5USSKUIg3KPbqrWi2UPY8336Gg545GDYSZ9Hclwjkm/S2ydBVeSfeUf0H?=
 =?us-ascii?Q?7JP1ndHo1rCQxRMI572UCWwe11BB37QZRObThOhLic4UhbjdyS+j4nN+2vB+?=
 =?us-ascii?Q?fumBsUeaQ+3jYwoUlckUbQHUpsv229ub2FoHRfrwMZTBSi6y+zLOt2uPOy6/?=
 =?us-ascii?Q?EQZAi0QszsMG8gu3X4b7b/LIXKtOV5rLwkQmr1rDE7Efn3skPmGU7v8znty2?=
 =?us-ascii?Q?Fl68mNO/v5jpoPN/qXrJgnepZNR1+DJA79e89Jg4YkwqfoHFcBWTYjcAVMhD?=
 =?us-ascii?Q?fMufvy6v6VHzt7hvyMQ3inbXwUw8VHFb1KFWwdZ7xIzVZdi7rSXJszYMVCmk?=
 =?us-ascii?Q?lyx73CmeGXFQqHWiDspB3dJyiq68y4o8F4NhmJzb2R3JWHiUVwye5SI4OS8C?=
 =?us-ascii?Q?lhjOK63JMQ+MeFpZSCml3nsK9b/QTAZL/Lqme1vqT21KMYm94DHhPhNa0N7b?=
 =?us-ascii?Q?E8d+di4iqnwh77zeQ1lXpCOQiVx0ceoKfaaGZwSuV80tb8InozOORhWXeOqe?=
 =?us-ascii?Q?wKQSTZ/Yv4d2dXsmv8lkghei1D+MXsfV1mst19hA7q9rOLzYj9BhwxCuwiLn?=
 =?us-ascii?Q?ZIO0wVhCHu5Wsky44fPIl7+86MlwsXjF51KPUbayjmyQCsbGCSFFZ+Ws5A5s?=
 =?us-ascii?Q?7tt8NG5l90pRA5uIWtxQMgeOjQEl3mhAS8DEEKHICXvGGIlKOEfSflc+ROa/?=
 =?us-ascii?Q?IOYY5zdR+walX3ZVTSS0WzU2RUxIly0UqwP2Oq8i/9Iihaym6unz0zNYx5Lv?=
 =?us-ascii?Q?VhQssn3PxDBNYzURrpxjZ5tpigCTs0Yx3A7bMpiEMseYqAFqZtm6X0AdvnVt?=
 =?us-ascii?Q?HEK1bWfVVmgZZrQeSvLCJTfZRVrmEWqNvT+VQAMp74EI7q2zk02/7r/yxwyG?=
 =?us-ascii?Q?Q5v3aE1Yh4viGjxFMoMma0RlEicylcMHDSUwVC/lLbS5kOWgSoKg8+U726e8?=
 =?us-ascii?Q?bEDRuLzFc73RdQ33zGKgLQPtVQErs7wNklhS1g4mctZDRKCLZ1oqKiNXzMN9?=
 =?us-ascii?Q?gG6yqr8PWRCfhTs9eIqwVXw9AnqSl6Yc/yGHQvNGmaHuIPeIRSYLf1hJsLrQ?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LANqienM6lsfcKkG6s8srR6vsSjM1t7Rnz0hzE+YqoEy9BCkpv2eUiGW0nJghQgAjOlqMJaH3hbF1Jmyt+zpLGQYEd+Pd+Al0a2EfYEMOYqhUMNzu9wZpo7ds7rQWDWIAtF8D9HijXaIZFRxOYWGWtkNRcgCCLKgL5Daomy0Fh+NMoGbTIJApFLAdAnZQlItMajfOv2OXsnCvUaSwKDU6lfdZJZdhQLCn8DmH0j8YcXjuJC535wu//D+3cPSYHOOUup3w11Spbr3ioUhl2srZGLyIiJginuL5JM1df7IR4ULPZBBMXS80wHDOcaXH8cQqzQgSMght2etMEHdNVx1fuGtpyWDq+cyMcae4inJFIBsYfM4CYaWiYX5wdRKvA82dQg568JUgxkvHoTRPVLxi5Ueh/RJdOFfzdPtz2SUEBue68nQlVH8Q4340UFQS0gYzSPxmHKTPmXLUhMyqYgzYZY/xkj6PBb5DrHjtVykB4gL33OZ9hE4EQCdjM+EvJCM5dPpq3QrkmyvrSLh9V/O9HQYMx8eKnmOJTX0USwcEyMlZIIGzyOoxFeUbVJYwHTKIA/Tf4guB7aDHYEklVADTuiP54C300OcEmLD2TyjqzdkTFZkdWjpurMMVqMayWHfZCoeIuK/sRNZefLFqvTyXDiZw6IIb7IMNbsfQ+OaveMMaf9xRMe0d0Jfvoqjo/4zDWAjG8J5lbCHNS2Y/hKqsyOk1lVkWHvAs0KGGLxsKdI5ob+9Nj/usHuLgcCYkvMd2e8dDXaW8+fcGToPdi9+u2AtVHW66VZVpxxMbRO75UgNxs4AxP8SZDyWtlWS08E/uLDwMKk06j8vEPRGDyR1mz+PV3up8iiXk1jQio52VSw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6603b1-576f-40ae-b58a-08db1fd1937a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 12:35:18.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0+aDmkuBBDQcHfFWtT1l+24TVxG0vtkg+11BTpmcxVBWI2U4XPHqHXKq3mrANuLdu/2a86ulZATvmRZL/e1YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=510 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080108
X-Proofpoint-GUID: Q7CdS1FKSxcjsbaL-81rIuqJOvmcgM4A
X-Proofpoint-ORIG-GUID: Q7CdS1FKSxcjsbaL-81rIuqJOvmcgM4A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Mar 2023, Lee Jones told this:

> Please adapt the subject line(s) to include the drivers changed.  It might
> also make sense to separate out changes to cover one driver per patch.

There are a bunch of other commits in this series covering mfd: do you
want the same thing done to all of them as well? (They are all in subtly
subsystems.)
