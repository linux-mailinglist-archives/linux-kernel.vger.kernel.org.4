Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA97076C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjERAKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjERAJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:09:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502E340C7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:09:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGsu3002441;
        Thu, 18 May 2023 00:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=65NAKhAZazjSXDH16xLwiVEclPupW8833e1/Sa9H//w=;
 b=geEHUYYLqi68ghCM4ofmVN27LmhDF2SHkMEbZoNFIfwJjbmB+CkxYwDUQYgKWf3TTLwP
 dsn8DfDM2yiYrZQtKGobkb2GfgWSD/CSYt6u3bQP4zRTLuaXxG5Dr7jZr/0nzfinuM+u
 1cSWzlRr1ygqOuRcZ/x40M/hBtZKmfuP45Ae0m+NnUoG6CRasWIdSQXiD2V7nfJEHBJe
 SsKdF8ycMHRo2Ho9fFcyW2ExlhjG+2lA1ZKnBRUh7t2K+ToU9KximvCCwR3/MlyjsGyR
 wyRk/n0bG5usuZXqTDh+l7sOtEPEKGLBEUNYkz6zPFyY0e/w7u94nUpD1wnNBRqduO2+ bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxps1drh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HMFhSG032130;
        Thu, 18 May 2023 00:09:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10c4kxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTIQiAvrB2Im+ZY1Z9msBLCHHPiP7Fse+vqXYgnCMFZNeQRzPtSAQprWSYaWRI1P9CFST/B014MvBBeZ2QBOKnnxl0avsxw2gbUF/bMiA7DwEfUVJFWeyGdEaWehEjJ+UEGy1YDQSWoNFMSmHUOlZFifI67liyFInj1cy9VHHn3R9+dbQDD+zR7Dd2cO/IevfLvHLX1b02mNl3LpeDgIfpodOpwSjHCCfKfuFolj23ey7U4n/ebEOA2LlyGjgnuhkwcUvqrK6inr28+u9t+iQ285clyhtPjkHzuGnQ6Y7Lc1L9JTIs7Jmtqe6X87x78cMbVyEKV6EgqnATT0fjeKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65NAKhAZazjSXDH16xLwiVEclPupW8833e1/Sa9H//w=;
 b=WaEJ5+96VhiTEbhiXRkhE0/ibIFrOkzZ38IgnRryTyY6sPQeBhaWPjtQPAurZPG+M/BT1FiJiet16nMcl+p2ThMm8PWn06EKSVPQdY8WrpYsNyjlxdJSax2+8Lh7fb/k/1qT1FTM5FmHh4yw6CIuPGcenuxkfiw99N4drLiprdjV2JILP6ySG52bgQtmCE4rv0aOMmfzqYyLyFM5QJaFPv76krpD/HWLunumhnK8wmUfpQz0RpsQfPLrcss65SNqU3p3NBAPjp7tUdeZRshQIltRIjyvjmI+fdU8eI/Wlg5S7+cS03wISr5DV68H4OSQm78URpmfeNoftLw36kWwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65NAKhAZazjSXDH16xLwiVEclPupW8833e1/Sa9H//w=;
 b=Rmf58F86nNpzSa5sZ0PGqHYBhXzPD0Js28O92nYtDvQccLq2q8dlf+byDnnXVaGiHU+sLaBX5itMYBzq75LDihISFVZ+O8IsPL/l3FR0TgEkdhCj+/82tyi6sbUmBhyyU3ZhwlE1SYzKnlgZTkMon5ZjmhDUbNilP3aWwoDXN6o=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 00:09:34 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 00:09:34 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [RFC PATCH 7/8] vhost-net: Add callback to stop and wait on works
Date:   Wed, 17 May 2023 19:09:19 -0500
Message-Id: <20230518000920.191583-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518000920.191583-1-michael.christie@oracle.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR14CA0042.namprd14.prod.outlook.com
 (2603:10b6:5:18f::19) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d327fbc-f245-4cda-d749-08db5734290a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ii2PCUsu9zc9pzmstZdlau4MYT69vNlUAS1F1Br+qaGjQENFRqu1MZV3gB3AoiWLVk9sEmQWOQhTNefJ9c0ezI8TjIBAXGd78o8W2XTgtqbPUURCbCZAYfX1svgbsdGZRu7HhQji+CLpJsmYLqWz7iDSV/CK6qNiWJgXUh5xsR9cvtjhCF8FrRYDFbMSAPo4dufeUwOaGMX+weC97GKAHqMtPwn4fP+j4XAiyl8vPSrqqhOyqB3l73nFEKODDRAyCJ+SAkePAXqlqKsgzJetPi+F+fUzSP48J9jAl9hk6RctBY2aeY/t7I3yYbdeguMpLyWjVTvxaPWVJQlLauHVuPirGKnCIbZAajexrVrpj0/fx8aJl0w1RYTEUHq0GNAT5szvnfFr7A+hQ1naOt+8QyBjepPiC5hSPB4dgfnRUFPgZ8Kh80k+Upy90OeSG40DAA8PQGshRE0ANTMj5vdi3TtgX15aYirupU7Isj4Uxw8L8XexYYCFRxbpGof6RJWflyRExjTVGSq5Sx4lKsn+q212D41vyzzeZlvlzFBzRIKdlignrWV5lOlTRQrfXTT+ZwLCnsHrYa702GTzed52zcFKljEBSS4gXFKi5dYrvdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(921005)(8936002)(7416002)(38100700002)(5660300002)(86362001)(6512007)(26005)(1076003)(6506007)(186003)(6486002)(6666004)(107886003)(36756003)(316002)(2616005)(83380400001)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LcwC5F4i0aL4EmT/ROgrfC7BDquSOquXnplUQo2VLJIsQb5zZ3zlpQ6oaxtb?=
 =?us-ascii?Q?Ry/MnshQDkVJOTTmsIKANPkJWuTwyUpWSsMAPs4WzFu/aBDBRYJ7UY6rHO54?=
 =?us-ascii?Q?FeMabRSzudo5yFTSQ+a0fvwckw/JcezU6Oa0u58YRmdxtp65Y6rnUfqtJ9v4?=
 =?us-ascii?Q?lQi52ne8ilLXEus68LI09vl6Bx+Zn7Pz4pMNrVgZ09vj4cagTtUZInnwAGL8?=
 =?us-ascii?Q?s9lTP3FEsOHQrWXfpTBHcsGcSlkQl47o+Lr+IVsqaCycx5EPoKPfJVCxyQTm?=
 =?us-ascii?Q?UzJ1RaIGYX8EXqp6snwUQqc7LcPdfUMFh/VOSUDbWo+zOd9Lsv5VsZO65Qpw?=
 =?us-ascii?Q?+G1h+V2eRiEvmSuaZ7rbkbu9XpM4frE/rqcJEgqU3/ibqdJWauEzUBSDyFqy?=
 =?us-ascii?Q?7D0igmWJ6Mej2dz/iSB5tXkxtv8sPurWr79yi7+jBd6a/wKSDC+eaGNjoBKO?=
 =?us-ascii?Q?Hc9KaVX4DMtDYAW04egbe5U398V4Kc1lygD+yqxq9gi4vOdok6ilShMQk1iP?=
 =?us-ascii?Q?3+6MyJvf2Arr/PZm5N39C3KJZTzl40R9/GQbNxf4YsGq0Mi4y3I0KQm9KJeo?=
 =?us-ascii?Q?vYSBVgoMx7UqOtPc52T3FJeMVegsoV7GD/tJ+McuYSM95+CNqAwScW9/FXbH?=
 =?us-ascii?Q?S29crRzDzJgcm22JqGCBlavKB8LQvkMpUNWJ8Zvuv87hU4gYZpxcda30kukP?=
 =?us-ascii?Q?7E6NQO9Hg3UobrXYAWENMjlM3kjMPQ+UP/3d//IW9xgXvQKFVjSsA6DIyMvg?=
 =?us-ascii?Q?M8NkdijEoPKKNmhiHemgbwBKyTK1UGT4HCZR8yjIUcsFZWim9YNU2Vmz0iwk?=
 =?us-ascii?Q?Uo0PgHHmgUyIa0phLpozK6+5iiYEjpLtR3HKtmFSy37O7guYGLIYvxPoh7zq?=
 =?us-ascii?Q?6qCH7NIi+P/4oBlTJ2cAITmN0wkdhe+EG3LSX5UUHojD1EI6iWLJdntvqi/0?=
 =?us-ascii?Q?ax3KClTvt75Wq6UAnqiR6Fhgo2CUDaEa84fX0WKP9JrURm0hTAJ3STJ4XXMp?=
 =?us-ascii?Q?ir/E4DIXJi1NBPPjmnot8nOHqvq9Y/QwSoBteAi2E/H66SOV9nv0NWHKH12c?=
 =?us-ascii?Q?EzBbZLKUoNN5VNiM0Cywb5L7Dreoh9vXSN1O91Wo7p+LBRk0ymk5rgjghBvm?=
 =?us-ascii?Q?bx7doMuVCqDmSoqC06G4JXAeJIsxixVhs/BnKb8Y/imLTDleV7i5NomlvI+H?=
 =?us-ascii?Q?cqaiB7XH4S177a0ED2gABlpyLWx/ROq5l3VTlyl53VQiQnwSfDk5WjlnoB9f?=
 =?us-ascii?Q?E2sUtra9laipu4Y44sHqi8wzkxVR/TDCrRJSXMB8/+R1galql4UGf+DQMiEi?=
 =?us-ascii?Q?d6M6Is+BJWAmbnF0BDOH2emVJ8wJHqT9otBvlJRFBd6KXgph0GmeyZzDnsLE?=
 =?us-ascii?Q?qNXQbIdcrCXL/2WlIgmy5E4eWiBmjz5eJW0qyfkhAXOgAf4ENa+dukWtaMud?=
 =?us-ascii?Q?HSfXg+bTPqnkWA/VVtpGQtOAkgKCDGkDooD6Yrci3bTy0vU4dJBIkyI9qjkP?=
 =?us-ascii?Q?90FLrrCk0+X3+68NH45cj7wmTY9TTAoeVVec0AG0nWNXVEAc/ZzKTbq7s+F6?=
 =?us-ascii?Q?UdPhKJ7SPIdDyoZ4hJ4t5nJ/mRpGVtHFL2GUIT3F8tNV9AY1csjo8Zwe7RgG?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?holUjMP8kuZThqZvh61WyAT+eFAwm18LO8e92cIU7t55CBOsDG8z7YCwW/lY?=
 =?us-ascii?Q?DqYlgoyuKpGEkJ+8VdldvHqk4ueXVyW9K3TndBMBaeKt8Nkx0lEDD9thCAL0?=
 =?us-ascii?Q?+wjnSLmGzoquEN8QFkbXLOmDHi9ClVq3DUKiGnjol73YQXjhOfDjEfqFZoHO?=
 =?us-ascii?Q?omelwSRKc9/ZLJN/YL5woicGtJUMcSs0oDVZ8K8Rw5oWMoBUnICAenFrcAXR?=
 =?us-ascii?Q?rmgcWfJjjeB+VhhlgGzUuaJneCLTgz6sRNTUZhY3uG1llLNbn4VvKY8p5QTP?=
 =?us-ascii?Q?GLMy5hsQ0WRdqkiN9xKXj9M/9hVgZz+D7CxG0g7HSj14hyKlLUzB42KpHn/v?=
 =?us-ascii?Q?9iqFe1i0+DeB6Nkrtl6v6TZcCUxZGvmwCabO+ClXpF9F3Gas4lAdK1z+7q5e?=
 =?us-ascii?Q?Wqlh0+59QycKfHaSguK2vKj003T6AjNhsgbWEHoFVOixUpPxsXdaM0vHzvIo?=
 =?us-ascii?Q?elVdwN8wyAoTmQwbhz+EARL8rklecTHDsGgtKLfiGIdsKciKsNiPvnCirhOx?=
 =?us-ascii?Q?O+d4MMwhSf0L0Z+PydqiCNGNSWHBPUkz/TRDuiY3/wduNUawbrObpjpug9i+?=
 =?us-ascii?Q?hC856XdLqgtNOlbI38Fv60BBtB4l7Fsk0qV+gDbgfO5JxZgTGEkUaSTQT9ew?=
 =?us-ascii?Q?uLljnA9dIi8U54Uz6IZlRS+CNfAZjTe4eaHJE/fMT7tJWy4aCbGE6TOC2pnm?=
 =?us-ascii?Q?pzEoSs88bxrv3WVjyjKlLMpQ3U+mPjeexm5c0tb/I6bCjx4SdubD/Usv5kbJ?=
 =?us-ascii?Q?uU7HJFDN0NNMAl1TGuL4FpPnN2PNjVZDig5X58qUYKHBaRaOwmZIDCtkosjI?=
 =?us-ascii?Q?F4rt8hdupeSYF5Oz4f0XHYMoRyxvBZowZuEtv+XCQhe9ot2Z0FG1ackuc8A8?=
 =?us-ascii?Q?AR8iASMNkHIsBOn0S1Kkg1CYUqkyOWnwQBmSJ3vSSWWmwSXy83ihU7gEBaj1?=
 =?us-ascii?Q?qfc8XXir7mngv0rdq1lqpxpUQavNONmw5X/B8qZKWnAc5neAyVEchLwi4R02?=
 =?us-ascii?Q?pXv41YuN4b7C6pDt4GGuXgZBunHywWcA8ZYs5EysRTqA+9QlLXHKNolI20b6?=
 =?us-ascii?Q?+0ifsfh4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d327fbc-f245-4cda-d749-08db5734290a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 00:09:34.2766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qco2dMTyGfy3Q4E1sH0GaJmj8r3k9pRgpgENYt4NAA/hCEU+mmY/xX3ySAhfSHqJ5VVjQG5KfkBRlA4GgIGf2GWD7uEnxjrdAM+UezqRDxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170199
X-Proofpoint-GUID: 8arPQ2tNYsJCjPTQ4ZsiCXWBUkGyFKIP
X-Proofpoint-ORIG-GUID: 8arPQ2tNYsJCjPTQ4ZsiCXWBUkGyFKIP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the net code we use to stop new works from being queued
and wait on running works to a helper which is used by the vhost layer
when the vhost_task is being killed by a SIGKILL.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/net.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 90c25127b3f8..f8a5527b15ba 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1325,9 +1325,9 @@ static void vhost_net_flush(struct vhost_net *n)
 	}
 }
 
-static int vhost_net_release(struct inode *inode, struct file *f)
+static void vhost_net_stop_dev_work(struct vhost_dev *dev)
 {
-	struct vhost_net *n = f->private_data;
+	struct vhost_net *n = container_of(dev, struct vhost_net, dev);
 	struct socket *tx_sock;
 	struct socket *rx_sock;
 
@@ -1345,6 +1345,13 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	/* We do an extra flush before freeing memory,
 	 * since jobs can re-queue themselves. */
 	vhost_net_flush(n);
+}
+
+static int vhost_net_release(struct inode *inode, struct file *f)
+{
+	struct vhost_net *n = f->private_data;
+
+	vhost_dev_stop_work(&n->dev);
 	kfree(n->vqs[VHOST_NET_VQ_RX].rxq.queue);
 	kfree(n->vqs[VHOST_NET_VQ_TX].xdp);
 	kfree(n->dev.vqs);
@@ -1409,7 +1416,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	vhost_dev_init(dev, vqs, VHOST_NET_VQ_MAX,
 		       UIO_MAXIOV + VHOST_NET_BATCH,
 		       VHOST_NET_PKT_WEIGHT, VHOST_NET_WEIGHT, true,
-		       NULL, NULL);
+		       NULL, vhost_net_stop_dev_work);
 
 	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev);
 	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev);
-- 
2.25.1

