Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FF76AFAA2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 00:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCGXlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 18:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCGXlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 18:41:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BC08F719;
        Tue,  7 Mar 2023 15:41:11 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327JwnLC018505;
        Tue, 7 Mar 2023 23:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Y5NtI8+MP8YaTJhzubCmCktYEZZssFEEARrQdFvWMOs=;
 b=cRO3L+RF0Ch5FqO7uSco5bilQrmVkz7kIu9mvzoPGb88ucGTr9ho04k3V7Wamqb/Th8V
 ACp2Rls/tSu0mapKKlTwj0iJFMxAkFyQNbhYLauFA8h/H42ye3wTfEF+8QUtc1tiIt5B
 DaMQZ+L784aZEaIjaLCSREBC1KJ4UR4M0MOyeFLxawoJP1rgPE24d1EW8zSWTzKzOjAv
 HBs8CVoUhq+b+b+sRgbJ8OxjitC9cJ/T6XRzqnDXxIa1SILZw+o/Lvnebd88MoFU63+X
 X6dtRPOZ129EfSpHa4EQiwNqpsHJ9PAgROHrLio3I508F6/jM34JAprIzaHgy4ufxOSo eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415hxyma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 23:40:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327Mj4DB016365;
        Tue, 7 Mar 2023 23:40:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4tus12p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 23:40:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgG2LRvCEj0syycvlNbY3A0zv9H6GmHQAzS3lK4BfM+aYVI5KBQ2NVhfZz0lwA//wn4KUcnVLD6RXU+aWfXurvrjVprM+BLaSOLnq+cAeHhsPMdv0Iq/05SWJCr6lsvZ6iKuDhfZb7oK3GECeTOG9JZCA6Yrh26pJzdhLxpRf9QKjvXA84i6sNv4UjNz0rSbEPJPKSjclobbcF+EXRGdKwpu4UoN3nZmH2RiY7x/B61iPou9bbfiDcP93zCEmkW/ZIBiKjZ6WcTVN6xz5OC/hq3Abyy9JdExVAAm1F+4jqceVD2QOwoUCTHDbsM+3qWdXAMOwXfxRHk5CvQosbjnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5NtI8+MP8YaTJhzubCmCktYEZZssFEEARrQdFvWMOs=;
 b=hPhMCr5QKeJ2+l6ngilqn9LsmeIdIv+IaDRF+rY40dO7GZXLvJ+k+Bag9F0LluBoFq5tatQd9xcJHpTnmib9GG4SkiuCJVFh9bESCP2ttZqvndBAqpHiMKghrobQC5dSvhkLjlNb/JuUrYC5IogcPkqWQ1ZTM9K/jQFWwJXn8nzlLZZZe7mpNb+ZPhzDXJvR59cCEp1fr/XYBA0aAV7och59rPQA3pkbAX1CLvBIziZqZDPsfzYKWzFsiu07qt7QqDujd7HmBbulM1wWh8Ge6Km1BkoPhtBKFN36J6QyKIaBWKYcCK9t61Od0Bz1yj/PirSiGJblw6cYSHOZ+7+oOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5NtI8+MP8YaTJhzubCmCktYEZZssFEEARrQdFvWMOs=;
 b=ld/EV9yyG81BysxCZ1XceWRLfhN8YPLnUEulvRAc8Bk+MP4LDABFmJu8EZL9VJ1/krepTasxbfJPM6W25DX/hAkuUGBIB/NbQWg6zHIOauamFnUzwfvy8bkJ0DyU/n5/KWi7mSZ18K1GKCNmK2dIK3UtLChpaljlzwyY/NFP2FM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CYYPR10MB7566.namprd10.prod.outlook.com (2603:10b6:930:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 23:40:50 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 23:40:50 +0000
To:     Lee Duncan <lduncan@suse.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <leeman.duncan@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.com>, Hannes Reinecke <hare@suse.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edq0jg2h.fsf@ca-mkp.ca.oracle.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
        <88927435-ae58-c24b-e7b7-b675985de433@leemhuis.info>
        <86D685F2-D411-460B-A09B-6BE942372F0A@gmail.com>
        <yq1zg8pl1nq.fsf@ca-mkp.ca.oracle.com>
        <f8c5619f-1e1a-f759-6ab6-ea84bba3d635@suse.com>
Date:   Tue, 07 Mar 2023 18:40:48 -0500
In-Reply-To: <f8c5619f-1e1a-f759-6ab6-ea84bba3d635@suse.com> (Lee Duncan's
        message of "Tue, 7 Mar 2023 08:33:26 -0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR08CA0040.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CYYPR10MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c13fb1f-5775-40ce-7587-08db1f656253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rvt0dKOJs8Imo79zQb4ecTqCZE+9UKZchv27bPUhq4GzivljKVvkPU5znivjIwyNOejFTCEL4EPmDhHGqa4s9sonrcmk/3t6sHf0wa6p18J7HjxUUl3rvtjtAsO8L3+pVvL55rbDk1jAC3oAuCugzkyOFwmq+yVE+hM7DUsQaA9lILHvvXSwZo+oDtpmim4Rb2nPUU38XgVhQrvp4epvwWsdPhnPsIyS5MR9Jmtlt3BX8wxBpIUP063qdUGiFpeFYLbZVgyJ+8yfbu+G/lN7rsGT2bZmiREmeq1vXeDjmTfPM7XRH9h11NK7rYRGBpTwG299mfbM60LIclDiwdoMs0azi2UjnIe00MirNk6B3fSaRoa0ynIUE4mzjuE3qTRc4yivOZ3g+UIMcnq+XBgQ23F8ohgfr3sevM0f4DziecLlqOFkDdxVIpJncr7fNCw4jBQEYmLXk/ENzdwusoNyDsIVb2aU3KOsepBAFrCrMsELhyNwGvp1P6dNhVeAbiwAoR8Tpq4+VoFVshApOMl59NmdP0j197T7AO8GZGK7a4+Nac3DSgvmn/sLiyeDaKfR+NF8DxG60F/cO6/pdIoUSHmFgpx/YTdNk0QNI2Z2rwp/kK666nPPmjpNFQo9GZu/X5wTMKRtrgvnXwRXIL2Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199018)(41300700001)(5660300002)(36916002)(8936002)(54906003)(478600001)(4326008)(66556008)(66476007)(8676002)(66946007)(6916009)(316002)(6506007)(86362001)(26005)(6512007)(186003)(2906002)(6486002)(4744005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P0H+k0iLlzNQ+WaFUz+V9FiuSCTIFeYcdp/C4gCDf+8LSGNBn2jecZ4GEDKo?=
 =?us-ascii?Q?7i47sXWTuDa1cBriGlHx2btB6jwWHbF2IzWwYZUBN526HTxGHahm8MaXN7TQ?=
 =?us-ascii?Q?z83FWTEHH/lluAI63acV1ge4IRG/hOrKYFhr72bMeZ8uk5IUq6yq87I0Gkql?=
 =?us-ascii?Q?Fyl83yxUaEpt+FzVGWPtV9ornsIjSi/v+1iKTGc/VCp+bQfgvJLKU/qTAIJW?=
 =?us-ascii?Q?HY6ONCOpfEterZ6v7/PJF6Vvuj6AehHxMMyc70uYXbC3VMTTP9LKK61u9Bhk?=
 =?us-ascii?Q?2d1eU4BiV4m+VrYo9cwgs4r3pUYKNj5hiqRgmkNwQ3NT3+Pha/lhZsE1eK33?=
 =?us-ascii?Q?LWFF+HbN0N016vkSOjtdGOWLfCsLIwPsO5+PxAZPRwjDnftIeYv+2lioSRCi?=
 =?us-ascii?Q?w8AQpPlYCNNngLAt7ZRULtWnJZBkJuRuQ1YfbQXRJ3ItxcpG8HpBsxPn5ALS?=
 =?us-ascii?Q?1x6brnBi9U4KytRwgVcd7bgkouYisy90sayttq49BxQqWuQAzHRIETLZosSI?=
 =?us-ascii?Q?fzOnOTXVEYGyDVNSu6ABWXr8RIUB3oM4yS4LpbmxA4AfEHE+KWqYEzH4T/d3?=
 =?us-ascii?Q?4liToqBDSMqP//eB91S67EVoK8BpkQt/Jk1g871mkXuZ52n7A6/LCnQXAfeI?=
 =?us-ascii?Q?R+Dy1BkJiItZuouDrG8qvaxJZ2XSrKrimqaUa9PhaLo0m/S5ho0ekzqxPjnv?=
 =?us-ascii?Q?oK+Frdd8adKE5IxvSRoQkFe0uDy21v/FYvV1JAtBl0QQog674RXy3cCfNV6v?=
 =?us-ascii?Q?DjyxtgUy6FF4cREpRDotSgXtlUV67C40KKOnvNvojrxozJSzHdPMpBuKxQOZ?=
 =?us-ascii?Q?L/6uaVJ23DYzru3jXibLVgq+cruj+JzpUGwIc7jNVvmgsP4hb+4b40F06bM7?=
 =?us-ascii?Q?egSqE8eTSQthD+Nrg1DP2WkH+XlpV8sCsuwAEvSXbEpqLi8sSp6C9mtUq2aP?=
 =?us-ascii?Q?IN+lIKe6ctayljs5eAgZQ8AXjYy5SnPtdnUmQ6UEFGLQsg7d/52ZLyTEpuMU?=
 =?us-ascii?Q?T9Tfa/Qc6z6EjJfctGoPkVRu3Ag3iW/vbfA1nFggQzQgaP4YW+RtwklnmRj6?=
 =?us-ascii?Q?ROBoY8A62X4PviFMl2PVFeFwvsNG8jxU6qFZIf/Q5ADEyj/93EXaZvW2BteL?=
 =?us-ascii?Q?NVSRczRKrg0e3ZmHD0B2xBFKFM2tgr0GUHy9HzNoM178D5EV1nlwWZA2HjCr?=
 =?us-ascii?Q?0qU+DWvfwWLMVYRUKBsM8T52NXZhqsgw0WA51iS0YvUs9Gi98bNVUbfTGXTW?=
 =?us-ascii?Q?VjxQty/polwQdXpmKm0WS3OA+PiEOdH79PtCEA30hm+4ws5MisKW7XLj7rZD?=
 =?us-ascii?Q?x8H0+ZNUy7CTWt4onc8+h0tBZ3sxIKRnxjfP8TsA3JNCIhj67c2YB443XcXm?=
 =?us-ascii?Q?SYW9OgB2oy1xENBOyckCWf9uuD2ChCYiom2dFWxYu9lFjS5+BdXQ0kIPdeWX?=
 =?us-ascii?Q?H1xghXnR6BklLDdct321yRJn9X1urcAHgCDGCsNWf5t38XMqH9Y8rkXrg8B7?=
 =?us-ascii?Q?YIgIxjQrom8N6lTMReIbeO3BZEfYJyfuKK6lUUm3LoOOXv4D5ucONczD9dri?=
 =?us-ascii?Q?XeD7s0lkIhXcFGKSl19ejWQEfaEvgtptid+H3qoI1LmMJTNpIshLD14uIeEs?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Li1exKrXQsIvElTmyn4QrPvpvxLBJ3jZS4eEcYjRh03RZCb4e9bcF0b9MRtx?=
 =?us-ascii?Q?jxQC5Wt1+KuXqbAuxFopSZurAJRirD2yN99N3TsQK/iE9K6oBb7sA5f36bZF?=
 =?us-ascii?Q?glTrUcCrhHDLtK18ESQO7iuYVKfm8vLtPo9UGqXrOG/tPqfCthrN3BqmTOvl?=
 =?us-ascii?Q?voiEjQ7U5AtTdXuO3cD0YMEkDomEsHqotv91DPdYq/WTHQ8JR+jBsyV8IHxA?=
 =?us-ascii?Q?DuZOFzl11A4fTwL7fMyK/JGbpG8FSUz+efNHyNlLUaqtPzSUDjl3fwchTJ8D?=
 =?us-ascii?Q?Ytf9O03BNV5OGI4HiLWwU/i6NXUJAR56oRJBX5kNLf5LChPet218rT/s4+/x?=
 =?us-ascii?Q?cu4W40c1qiXU2Aoo4Yi6CgBi+FlujID2eDV+BkxwQcak9lrOIVkOFqQ3Yc+q?=
 =?us-ascii?Q?enAKj0QIyq+8cRVV+yJRdDfFHK/ksNiAnfvb8cdJv4C4xqYT+6Qvd7WA8wJj?=
 =?us-ascii?Q?Yz9uiECDntesXD5oUN5M1fCBCiG/tZP6rPEw2+yEgoL+Pnp6pYHkKfjif4mw?=
 =?us-ascii?Q?k6q7eqir+Ro6aQLKqYRLXF7LLzf/ZzA2lU2zE+QQ3ydjVMQKxu3JwJQ5kodo?=
 =?us-ascii?Q?FKuq8qZiaVBf0cDLzPPA4EepbkyRrvr80J5uJzomqFYZKJkz6Ia9JKcdK+QG?=
 =?us-ascii?Q?C8g4fZ80HPvRMC0Org1iDg3v8gDbRbtz0Mkm/01UdjeHNvBG15ZYtGKHtiVG?=
 =?us-ascii?Q?Cv3i4KUGxWYHWuhQfkfNZFswc4oc+jef36g16cRI1JvYU3blbxff+QXcQj/C?=
 =?us-ascii?Q?2u1gnUnKNrFq2Mo9NHgMiLUNwkWmJfMf5tiSmtOAg6NBI23T+A8P6n6Y9YGU?=
 =?us-ascii?Q?LNVV915bJxVo6Hkr/waR9+kg5Uh5JQfoj23pSZJfszKlsqmmyZo+b0/KfYwF?=
 =?us-ascii?Q?rqBCaEx+98/VMr6ouC4tYv31wbmhNgztThdFXC1YqnGB8zYvpNCPEYvdmWcy?=
 =?us-ascii?Q?xCBXedslzKqNPsYRLwoMRg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c13fb1f-5775-40ce-7587-08db1f656253
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 23:40:50.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpr1y0uJyEVoXCuC2j7mqsC6XlFSdlJv5cL6yXQ/InPAAz7PF7RkekRkeNNminShm0g/UsLtPer9pttok7TYYZR0ULuZ+AsL4daYFPSmz1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_16,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=875 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070208
X-Proofpoint-GUID: z45Hshh_dqBTKdx4Qr_T1trx_QmjoROn
X-Proofpoint-ORIG-GUID: z45Hshh_dqBTKdx4Qr_T1trx_QmjoROn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lee,

> My worry is that this won't always work. Looking at the code, the
> buffer sizes used for VPD pages include 8, 32, 64, and 252 bytes. I'm
> not sure how reading 255 bytes into an 8-byte buffer would work.

In the scsi_get_vpd_buf() case we will allocate a 255 byte buffer since
that's what scsi_get_vpd_size() returns for a VDASD.

And in the scsi_get_vpd_page() case, where a buffer already exists, we
clamp the INQUIRY size to the minimum of scsi_get_vpd_size() and the
buffer length provided by the caller.

-- 
Martin K. Petersen	Oracle Linux Engineering
