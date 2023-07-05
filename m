Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF71748ABD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjGERhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjGERhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:37:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF681996;
        Wed,  5 Jul 2023 10:37:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365HZNig029054;
        Wed, 5 Jul 2023 17:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=AianEGOOI0S0OitlRl8T/hXzed9SW7dJ+z6I5UuopMM=;
 b=as/d2srH87aHiZM/oJRv55sAMr2WGItspWaO63YKz3nnetm+KloW92/XBal+x4vjOQN1
 E7G9XA3K2N8ENndMf+3JMHUh4Or4eiFbDeCAZlpR/fckAhTQRJD7Eg+sdp8KUNrUZHM9
 rW6dL8mVdWdBIcifdPSimcLy3e3rebiEVhLj7bb3r9vqmQTlgk/T/yg8CxFyy1rR5rbM
 qJ+JEQUzfvjpSyL0Ldi45XS0U7DQwE187aTyDHzy8c83rPm6nx8Fh3GI60zrqbIhsE84
 9ZvnhlL51/t1jmt974ILS/Ku24i9bs3HaEpCmq3qz+YiPWm6gfpzmx5dkAOawL5s+7jV Rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnc0xg685-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 17:37:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365GgmDH033374;
        Wed, 5 Jul 2023 17:36:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak654k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 17:36:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxugfoj7BabPXaeZv+IpiOg0czbVwSQnGv+J0cy7Gi/tDQaB3Wk9Rl5QFycnWbWIBImY93o1u+0JwuQci9PQvkqWJOczHCUY68tMYmSz+4OMDD/qagRoxvVJNiQtCW/n4opIsqNSyvQ78n5smTjgFZ8q96WVLSuIFG4qXoAer95K5HMQPovZBucWk8F53xtR+AJE6otsa9N0sLiGJttmBFeiACoR2nKCkMeaR2KTq2Z2bKLI0MTsbVmcGSA9k677VBXYQivuQGi0wYs7qsIbeScYdQQC5Btlj0lYiVvtU7VMYC3C02cbQAUjlbYD+4SK78MlWCXYy6Yy50NmuwXUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AianEGOOI0S0OitlRl8T/hXzed9SW7dJ+z6I5UuopMM=;
 b=ShJf/AVRMw+6wdE2Pu1hLbm47ohdY/jBLRI6IQ1cUdDmEH4P69XR0c9h1EItClMXh5oiEyI+Wat15+zIW82pquyT+NyRYbQTunukvZo/TYSOFkt9DCNLb0poYYicn3PDpn2rZVYkphmaX28BwOUuUSJkvbHZUne7tYWPdN1fuNtgNIhirIt12R68KM+zmMZhZTzu5Ir9sIWmGLcbKnjZ9wi68Wp/j8v67Pw0/zdlyerGWk6wzIR5GIekpSl1Y1zmG7Enfv3JAjBOtIEpWsqK5fE7s+/QJ1YghR7QpF09xHXu62wVZm9s/moyzo+MtOe037s5pmyGd4HFJCRlwSha7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AianEGOOI0S0OitlRl8T/hXzed9SW7dJ+z6I5UuopMM=;
 b=D0ul9PADv0tOPbgoSo54PRpMXmKC3QuKn66Ruw+yDMlvSKC73tbZpyAbOBVvZQfDyhdiLmCyR6NDuGO3PU+a4SnGb9r1T5eoyCT/hgPGmHZvACP4Z0iO7BnctpRV48MzO3qZGc2gNahnSW8JcQ33blrUH5pK6UWXusMBtS6wvGU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB7055.namprd10.prod.outlook.com (2603:10b6:510:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 5 Jul
 2023 17:36:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 17:36:56 +0000
Date:   Wed, 5 Jul 2023 10:36:53 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 6.3 00/13] 6.3.12-rc1 review
Message-ID: <20230705173653.GB6575@monkey>
References: <20230703184519.206275653@linuxfoundation.org>
 <CA+G9fYvf-sw8tCHjxhoMvHrtzzdE69EwvB2PmypUkGDdCFFASA@mail.gmail.com>
 <2023070411-steadfast-overtly-02a3@gregkh>
 <2023070416-wow-phrasing-b92c@gregkh>
 <37f9e884-6535-1ed7-8675-d98d0a6d8b36@oracle.com>
 <2023070444-untimed-clerical-565a@gregkh>
 <db4bf839-df6a-c2b9-a03c-3b9d1680c2a9@leemhuis.info>
 <2023070446-sublevel-humid-7b01@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023070446-sublevel-humid-7b01@gregkh>
X-ClientProxiedBy: MW3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:303:2b::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 36660b9d-b9f0-4f6a-9995-08db7d7e6dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fpx1IW2T2Te7540pQJsHZOMLIoyz/JP8x9eRviXF5PbDffdDJxJBFHP4UnmLrrRHRFEIkG7VmTqOWbn0Qj9/s2/T0Ci2eXEXPyb+GsHZAZpydig94RC/0HrkM12LDluf8MVvbB07xMW0o7CanvlntpfuQLjNgYgDQhy2SzZ67RQFqjxal0zeGqZU17orbKFbeh9LNoaTuORpW71ttwMW2HzdwKSKWCwsFqwPWvq2KSJh0b5K/tiwgZXLBw39vG8lVpMACubO4eL0QTus936V7KX2AfnXMNX01F6qvvcXldwHRBxh/anqLOR2P0FHmVN+76iBIe4WjAlbQhmBxz1aIQnkZKVvv2HM2KK5FKjL+yHPvAUiTvIYFCislnxO2n9P0bHVcJ+bbfIfouLDO7zEn6NmMw07WAWeQ+mWIEaV6zP5C0kjEjF2HcFOahtDefGQM5Dfb1npQ2WgEPvVdqP5rgAcuYhrmdzdP6HkP0cMOxrslyW8NK8hpOe/p7XxuTs1YsVREv13fX5FfbfX/vJteKP3fWW7H9Ai3+FLesl/DK+qkcNhObZAtspJgmoaexSrAebgke/a2TunYiByW0M77Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(41300700001)(2906002)(33716001)(6486002)(6666004)(38100700002)(83380400001)(107886003)(53546011)(6506007)(6512007)(9686003)(186003)(26005)(1076003)(966005)(54906003)(86362001)(4326008)(316002)(478600001)(6916009)(66556008)(33656002)(66946007)(66476007)(8936002)(8676002)(7416002)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xDF1HXahDevjVRfS3JGpnCo7reVY0DiWkqvuaw86+OcptdbDXsTMe3zMSxLy?=
 =?us-ascii?Q?2hw/Ng0j7NxJlLkCq90JF3FYv0QNYBbax8/f0FWo+SAe2XtdtCV5rLU4R4Zl?=
 =?us-ascii?Q?0FQKp03ECMU+5UsmEDqgr2MsdNp9IcCQ7EJAROhC7MMya2ewmpDaO3xmcDnu?=
 =?us-ascii?Q?x4UCK8Br4CuLWhOG3YGw4d8M05wWUl3HYyBig2lfv0nf6dyccermAJ+O/KNe?=
 =?us-ascii?Q?+oDEKqEkmdYYLxMAfYKYBl2zvux/9Dz0FVmbK+tZJFN+fqNJIp0UgKVH87dV?=
 =?us-ascii?Q?CxVbovEkctLh1HOgXuyDhNZjPlFXmL94eqjYXSw24bTgjVf/b5BONfehAb3s?=
 =?us-ascii?Q?659aH3yZi2Zb1M11BE7NnmaAnnAukGevjxZLtnsmLctdxH6VB/zREAfB43z6?=
 =?us-ascii?Q?F4D2upIkH48D3nxsUzW3djwjGMt0B2Xiu44FODJZolooWOfqiudeLLRy08dH?=
 =?us-ascii?Q?fY4sjupFpkh/+AmZX9/7gk/S/HZMcF7CmqqAl87jOjGd6x+1UlvBWWX8eZ3o?=
 =?us-ascii?Q?eIeteKXKC2RYR0bWbIFSB/muEyi4W+lwMye5nJYhfXdKWkqL7ZeQLMPbeOpn?=
 =?us-ascii?Q?RKhi4QZDaj8IbskrS2QAdxtECs5PGmlBVyN5x33tVLXbf92q+bO8Z1FbnR3W?=
 =?us-ascii?Q?sb0LEIgnllMsDqJC4HMy3Bk89/ObVvfZRrcKqyh+oHg+RfDjtGv6v7ECUHQe?=
 =?us-ascii?Q?hasjHWXhh6X4WARPzzJlZB7aKPQ7vj+nh9QVohRtE2P6mOltks152cR/Ty4G?=
 =?us-ascii?Q?fv/hDhCvyYLvHG+mgkt8dlalfq+BijEYn0Zv9QJW+kRaS7xnQWMgeSbWFCMR?=
 =?us-ascii?Q?jahSezwYvjqge7DBWYxZ+h7u0Gg/IFr1g+F9k6cMHbcvZLSkazOTkl1ROgMz?=
 =?us-ascii?Q?YNuCAbv0YqYctVcQpxx488IFRnaR4KoKhPlyHnzcsZg4k9RdgEkJucrFZ4TB?=
 =?us-ascii?Q?SfiMsGtvGrVTMzPkUVa3RasrtRBUEs0MyLKjB1WcdDtXbUK9FxsrDs7sbMk/?=
 =?us-ascii?Q?EvyglD3PQnFrOGokXLl5PJ6oZugET5iK7NwDrwEIlrlUamqb5yM6LbhtlIBR?=
 =?us-ascii?Q?U7cZgZeBXxhF06HetqxDc3GLwFxvLrUcoowaYXZY9rJxkzkD5sXpr7Dpjigb?=
 =?us-ascii?Q?YKvylZ+W8vQmLyKwupKa8obymHSU2Ke4Fx0JhOZpzs989eF4N220OG350GJ9?=
 =?us-ascii?Q?jQ4FUVhoXfupuXvR4QRE46Y1tmYyIMUxlSEXmXWWe/Q2phzuOfPGP5ftUfBm?=
 =?us-ascii?Q?oFT+w/EZV1yorEJOHSNGNCp57bCsfCh2pJeDbdKi6ynKSkK55mng15YZRk/q?=
 =?us-ascii?Q?4Y+vNl9NQb3bai9Qa0xSFGEX/3NZxvwjP6lDnz8jMrejAfGiIQRU9QjS2YX4?=
 =?us-ascii?Q?2ERGKR7hzGVODLijrt5sc3iHKbt9K4q5unkSM21gOnPhJYMoWMObgtXcwQf8?=
 =?us-ascii?Q?Vf4I3cwBI5tbBWGXolCkbHcKxzULgEL8jafcrWLupy0QO7rfTh9trbNw/Fxb?=
 =?us-ascii?Q?ktTOMLbxlBpqSLIRiruYp/NZ0ipLawbXXuKqMRKt8W1zonTDvJyEzAKciNOi?=
 =?us-ascii?Q?aKxGVlxS3LeJde/tP4kosfMCw5n4SISIdNN/5+UH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VeRvRTBpEOYmJg3AshPHo1kWVmLr7UaiJaQfw09S3DjX9aEPDpKgmcGaKm5z?=
 =?us-ascii?Q?h4EMSmVxUDSbssm2Zv+scdzMIbX3/WBrf1HsLOguuavlHJveAKP+xCTrshn7?=
 =?us-ascii?Q?F8vTOFmbe+6+LkPxEe9PHX8z2gflYhLfQ8JSEHZJuxqJLpTdOegksDDySu8D?=
 =?us-ascii?Q?I16+mQXcDWyqvGkkSayuHE1EN4EWlYccA6LwdEnhT6NI9n+hrrhh+/v6hLn4?=
 =?us-ascii?Q?yP5VkAAcf6HUSamq9sjjz+AOV92q9nZjnIMBrqiB//I54P7N6BpLMuTyB1d1?=
 =?us-ascii?Q?Pq+taM0F/kEIAoaSzs12NKsjJIbKUHfi3RWvUVB3/w0ge7O5N26YytNH8ZjO?=
 =?us-ascii?Q?DNy2kNQlQcJjcn2ilpdcDhVYckRyk6wnw/HH4RzxveaDjzPyNUoJdr6xCQnT?=
 =?us-ascii?Q?FXnl2DLfBWmtGIGHzU/DMGTSzrxe91zi2h6aEVp8Xi+94eHhAq/kSvUZTSDR?=
 =?us-ascii?Q?F1AuWAPo9z/Ehk5hN7MJJ89obqciOLtBsOQp9BeJkc+paPuFg7joc8RwAhcn?=
 =?us-ascii?Q?h4K9lVB6O3dHtg0STeuOJnV5a1tKmH1RvUlkCwPU0rdHQuRiDgwTYlNco6DW?=
 =?us-ascii?Q?nnbu9jOWbvWu5nwhT3XtWURkEvm4b5u4ID1eSXxn0JqUH9+tZw9YY5CWhWJJ?=
 =?us-ascii?Q?Kd4rwYzBMezK1/NvoZVDVWlhntqR3BwWFsP7FeA25+NpOFIgtsWPy6syZaab?=
 =?us-ascii?Q?L712S1XV24I902eiSGfGtiqVZhZHfG/8xmE1yhMLajZrNV9QA0FfGwPzFtC3?=
 =?us-ascii?Q?27XbMBPirwEiKIHvdjqA9mpa2XCIGYw9gCGpokR9EzMrIABzj8saLQLPaTOI?=
 =?us-ascii?Q?L9W/BwBSfcCG7M3r1hEC5hmUUs0Ii/jeGjO4Ic7ejlmu5qi+JswGuWJwKdnR?=
 =?us-ascii?Q?vr9aQfF7mKqoZgLS5+mbBhuVep9LHLdRynmC/dQgRdcBVeK5ey01YWDMxjZM?=
 =?us-ascii?Q?ycHOPc4SjedSAYoh1nGXcJr5COPGFnb4+TrjEGDsIFQGQFMKldqGO0SxDNsC?=
 =?us-ascii?Q?jwu5+Rgtez1E1tBIVyLm5qLASMPAxcAN+1oS0bLfuCy+2mO7Y8vtKAMl1DXF?=
 =?us-ascii?Q?2hzPDqNCOUv38469cAX2DHvZWdFkOdBXEd0z3Oe7K1nTUCUQ/tsQrcGCMsd6?=
 =?us-ascii?Q?0AEBdX5wLkNtjJ4qMggeW5wk7uHlpPDJHr/595FWzkR6RgzcJVkGPaZZmATv?=
 =?us-ascii?Q?FhW2FQzLAeLU/WxIpc/G0mthZnSbqPwVMw2DuN0N0xNQxggG8eZLF8T7ZsSJ?=
 =?us-ascii?Q?KW1SJgcGzue6IQyGoVvu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36660b9d-b9f0-4f6a-9995-08db7d7e6dfb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 17:36:56.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5v834tq+AqpGMDJ9pDG/cAWbmhrJaacq0lohi3VRMXAE8LE7dZ5fN7c4paHoM1qIMoCCZgHRqFITBD0VKwTNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_09,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050160
X-Proofpoint-ORIG-GUID: 6Nom3ErRrIJSi4mjVVsKOWPsRGS3Belp
X-Proofpoint-GUID: 6Nom3ErRrIJSi4mjVVsKOWPsRGS3Belp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/23 13:28, Greg Kroah-Hartman wrote:
> On Tue, Jul 04, 2023 at 11:56:11AM +0200, Thorsten Leemhuis wrote:
> > On 04.07.23 10:47, Greg Kroah-Hartman wrote:
> > > On Tue, Jul 04, 2023 at 02:13:03PM +0530, Harshit Mogalapalli wrote:
> > >> On 04/07/23 1:54 pm, Greg Kroah-Hartman wrote:
> > >>>>> While running LTP hugetlb testing on x86 the following kernel BUG noticed
> > >>>>> on running stable-rc 6.3.12-rc1.
> > >>
> > >> Have you looked at Patch 9 of this series:
> > >>
> > >> https://lore.kernel.org/stable/2023070416-wow-phrasing-b92c@gregkh/T/#m12068530e846ac8b9668bd83941d82ec3f22ac15
> > >>
> > >> Looks very much related, it also has a note on Backporting.
> > >> As I think it could be related, I am sharing this.(But haven't tested
> > >> anything)
> > > 
> > > Yes, that's the offending patch.  I should have read over the full
> > > changelogs before doing bisection, but bisection/test proved that this
> > > was not correct for 6.3.y at this point in time.
> > 
> > FWIW, I'm preparing a few small tweaks for
> > Documentation/process/stable-kernel-rules.rst (to be submitted after the
> > merge window). I among others consider adding something like this that
> > might help avoiding this situation:
> > 
> > ```
> > To delay pick up of patches submitted via :ref:`option_1`, use the
> > following format:
> > 
> > .. code-block:: none
> > 
> >      Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
> > 
> > For any other requests related to patches submitted via :ref:`option_1`,
> > just add a note to the stable tag. This for example can be used to point
> > out known problems:
> > 
> > .. code-block:: none
> > 
> >      Cc: <stable@vger.kernel.org> # see patch description, needs
> > adjustments for 6.3 and earlier
> > 
> > ```
> > 
> > Greg, if this is stupid or in case you want it to say something else,
> > just say so.
> 
> That looks great, hopefully people notice this.  We still have a huge
> number of people refusing to even put cc: stable in a patch, let alone
> these extra hints :)

We were trying to follow "Option 2" of the stable rules with this patch.
Because of the issue with 6.3.y, cc: stable was intentionally left off the
upstream patch.  And, after the patch was in Linus's tree a 6.3.y specific
version was sent:
https://lore.kernel.org/lkml/20230629211817.194786-1-sidhartha.kumar@oracle.com/

To complicate matters, a bug was found and fixed in the upstream patch during
this process.

Apologies if things were not done correctly.
-- 
Mike Kravetz
