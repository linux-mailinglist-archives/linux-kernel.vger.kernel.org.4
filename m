Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1F26E7162
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjDSDAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjDSDAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:00:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D666F44AC;
        Tue, 18 Apr 2023 20:00:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ILnSwW015763;
        Wed, 19 Apr 2023 03:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=hyWs7BZ3y2hs4zZTBtYY8uj+T1dzVYUQYE4wymM88Ns=;
 b=gYTpghE/xoWHRAGdW2qoUGLNZvdektZUPATpkH568JG41aKdPj2p6iUdMMgawLsPaN7x
 jnE5dWYAsbJq0OIqwNI0G9JJhzCpT5863wNBu6yfwo563XY2pZbeI7eM11F8wFandFW8
 BZ11J5fD+OTY6Hxb+n8ALQ013pIEaKttpRqpT1/Q3KQ+sgEfe5GgfG3TOY5VK6kKpYU1
 R1Iq+F4UiAPjh5aqUPbtSKABoLpH0PhB6mTYnp+aykkJFrNDwMNuWm9gufdeOtxFlPtv
 Lfk8EnSE2tdELoMpT9YrspVL1e1ORcQeNyAWvOPR7T3p1a/ixQFeA04hRfQf7R5aulLe vA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjh1q94u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 03:00:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33J1sCB1037106;
        Wed, 19 Apr 2023 03:00:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcccf1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 03:00:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk1MSpACaVyx0vORIpAYMCVq0IOSle1QMQGS3dCAjraE1d2z1kkzviy+aGPHCjKt7dRg2o+bT1Sa2busdzqyrTh0yzX0vnJoRVPo4G98+OfhsOR0QLtFpJJWfMmm+ooooA18TRn11toIhHk4GkFegIE6t4Bk06jtoYCGPvghDOmLTH4U8tPLQqXGalW6W5QXZtfApZWDZ+JZAebrGUkSBNDiZv6qKanx0/PO+7MjHOCGx7kcL8B0m61vOnpOZO7vNMfQXszUhydsDtQjTRybivSzmGIT2ud0WzTF7rAPThA2L7gVPrDrlCHcMDwXnyLmr2eKaRSPcxF7mcAolRIFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyWs7BZ3y2hs4zZTBtYY8uj+T1dzVYUQYE4wymM88Ns=;
 b=djB9lZJFVTLn9dvj7GWt+AVVim9BeRp635MpLXOiTaOQ+JtSrQH1JHV2wA1QNs1M82BXPPAT9Xeo3b6skRv//rFD4noX/Ng9Djz8z8Zj6MDTgqHxF1prD50c6x71W699Sg0W44rnd59uo8qicBrHURiOQc7S+RBHM3XUZPQfWPJyag8GSy6iJAI8tC06zzzMQyrSoX/nk4ubxhbFR2xe9AIY/KpsWycoR12A/kxs7fCOTFCuOW8Rjl7TruYuV9ZJ4x7bxcU1zB9jjuvxDM4NBv5nj616PD2z+VyO7K9K45NDER+rj97a7B6SBnumMlZ3WDRdpkWPS6AeAiNbVNkJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyWs7BZ3y2hs4zZTBtYY8uj+T1dzVYUQYE4wymM88Ns=;
 b=yrutsf2PcNnqh43Gjq7E3SV+7f0WiTUZnCzmneXk6TeH5LjEufHJA9/BJaCGQId3+syk1AckVCVB5F7TVrxHjl1QYwS2JCjcTq2RLnYpQDyqjqzLWFpVdL6lHBVCIjAnvCymhVmrOVreF9xDvoD1bEtMtJQ7cjW+YbTDWF+sbU0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB5011.namprd10.prod.outlook.com (2603:10b6:208:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 03:00:38 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%6]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 03:00:38 +0000
To:     John Garry <john.g.garry@oracle.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH] scsi: scsi_debug: Abort commands from
 scsi_debug_device_reset()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qkgr2yf.fsf@ca-mkp.ca.oracle.com>
References: <20230416175654.159163-1-john.g.garry@oracle.com>
Date:   Tue, 18 Apr 2023 23:00:34 -0400
In-Reply-To: <20230416175654.159163-1-john.g.garry@oracle.com> (John Garry's
        message of "Sun, 16 Apr 2023 17:56:54 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 205e85d9-96c1-47e1-afb5-08db408240bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OX800ggM8hPT0feeqxXyIbj9JZiyeWWzTof1MIBpV3eNc3viD3lCD8RTvshOo/vbP+TEoSxMERKHJE+bg8lL+g8p+m7FO7hCfcUKlp/8RXw7T/d4M2+b8jnze10Ahfg+85w/kQab0HzhuzK/M1iMxXdhUg8LRGmhFTuFYoUUVwZZ5YyGdq9/2MmnIjEo4cUztyens3yj5KKgYzhMAcoLLODMQ4JKitCtTa8HR7/eiBJN1cdN0ONnAGs0RKSSfR602dIXVVDl0jVv1vp2+BUph3IX9LA+ESVRktiYNR0lrv4KDUZI0lg2I1Nr9sg9HNZ6y/HZYCqKxyuysTt/C1euaOIMThXci1PwARDhQvKGRZc6nqI46V8r47cyODV2X7d6q6K0Vl+GNL6y7Kpfy4ARk/hUX9kfjOrdi9ua7N7n2RLJ8ROBWqEST6pPHDeY7oTVuiFft6XROnE5BoZTQn63QlCW/w2jB9RyRP5g3nTasMAjCdp+6AMKNxrxwfnZoWEcQJKqh/b3w0VXCc6e4hZvBPJjXviDr4CNG1et+/0dkOrdZmXxCYx1pAkSMcC/e+w8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(186003)(4326008)(6636002)(316002)(66946007)(66476007)(66556008)(478600001)(6486002)(36916002)(8676002)(8936002)(6666004)(41300700001)(5660300002)(6862004)(2906002)(4744005)(86362001)(38100700002)(6512007)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pHosE4Hew9Z0JfB1IrsuxSRRRnce8PNVzkVIpk68UBqmxTGEQUKhwU5Zd++A?=
 =?us-ascii?Q?TvZEjShZgizocbOudN6UUnaQZravYW9qCaFKOpBc2xCc6R5znneov5WCHj2s?=
 =?us-ascii?Q?fLmlUB7npjeMJJECHz7LRJagJ32xSeiebg/qdoeHGZB3cdfCEtQQYG2gDeeY?=
 =?us-ascii?Q?lMvNoYwDnwnv2Lwl28/vMYzluF6/0HUNxqaAwFjAIp9paISmkK090R+OKTv2?=
 =?us-ascii?Q?y54fJooVmjg/5LAHwYG7JMoo7r7pxGPc6RQlUxmnWXyep8R5/Uwvvo25E2Qk?=
 =?us-ascii?Q?C80whn6F28aQVLalVExBRJQn4o91eye32NOSHyMqtTuMJaJCvQ0serp3VeGM?=
 =?us-ascii?Q?Fh8dMBXw0Tqs3cR06VrgXCOL1fesE4NfIuo+Jlo2MRz6ENrYaw7auPk4VcHi?=
 =?us-ascii?Q?eDA9Jv4xlf+hGd9QBElF0bWEfStArQlibZDjY0uiW2wcTx5Ek+kjeafOYDKc?=
 =?us-ascii?Q?CGnC6dz4hF4AVICI+2hDHf2iw5gE+gz6kMu3uoRFXlvv0diZDermY5cLXAPF?=
 =?us-ascii?Q?xlAtYD7wSAytlt4EEEo9xOwRIDKiL//zbUY684spDP+HFsLcsv37ElxP984Z?=
 =?us-ascii?Q?ZWSJoWVdplFxq8iVt+XZW9h6ka3EGbyLEf9C4+kpfZ2NxtimBjYj0TND3k2A?=
 =?us-ascii?Q?qy3ogX8mxH96XPViwcTNsEeOizIwZmurP6Lp4qwximIGDv2oOKdeGICrq92a?=
 =?us-ascii?Q?inTAmhgIAM+qxfnW6UwdquZqvNdFJ/BB9E11ezzKOdffKSeHOaayx7Xe+Zlo?=
 =?us-ascii?Q?emc+oazpJD3c22/Mm98ngbB0m4NVVzTvRllFCbbI4x8QbTGoAyxU1FbfwkHC?=
 =?us-ascii?Q?A0tpxdzM+2Qe7Pys9ZCZl8Gzz7ZtRD0fdOvxX7Gy65Zr11fEBsFEfd7TdExj?=
 =?us-ascii?Q?/cVPS+nl6vYnHmUyV7tlr+BwVFe1ppIrdlPiiMj502N2MCPyiCxXu6bQ3Fwh?=
 =?us-ascii?Q?OKM/E1jMgV2GYX5cwOqRx9pEeOLxFSqYP6lYiVpzql1/TEM80gkw0RRzpwq+?=
 =?us-ascii?Q?EIb6NKdjvnOEJQ9JnVQVunFejXvTfvolLAYJpakHHFh6vxfpPithDKyB4w/h?=
 =?us-ascii?Q?pAq6v3rybAM10yh/jeB6/N0PrblP1E3PEO7T8gQ1ANviyljWNDkuJECnWeFv?=
 =?us-ascii?Q?zGE0Z0c5FROBv7AG0iM8GH4pMfzxW3dqW+5uGbTyYW9Ja5jLs7n1OPURxpPV?=
 =?us-ascii?Q?8XyiIIpsoxVcg/2X9EwJXtpxK7RLPsoNefZqMeosuWIqEAhH47tPiR9ageYn?=
 =?us-ascii?Q?/v14lzuzf6J2Pbzi0lBVx7+aXQ60XlbVRE6VQpJHp+z3Ttmbazuf/A8vGkXl?=
 =?us-ascii?Q?SksiU7P6w9f4ghfWT/yJJsIKiyJEfv4jZIK+lh2prUjp0Tdep9f8kW6VHl8x?=
 =?us-ascii?Q?iTIH63TEKkAD+9wKji6HpX+/kM+RIrZ9EE8LyFkQBZ5n1BLaUTFHjFrNOpjK?=
 =?us-ascii?Q?B3UK3bOS1A3UEMhflhkrnUmR0nb4PLaU5h3IYZPp1bmgIJ0YCO9LvfZ/b+5V?=
 =?us-ascii?Q?/6Xeh4Y84CxAfakUKLuijUlgD3fzTWMEIJMAyTt1EyGPZJnu88uauXtYrLYE?=
 =?us-ascii?Q?r/+b3MMt6+VtSaJrnI6AS6hmFr0uh/NZBlTbdajOu9vJsuM8pa5euMYs5oxq?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gTc9P7kKWsu4qC9e6BUpXMyNyr3/AGOaf1RI68+ZRQV7l2ZeyYlQKGLc3S6U6LYSJ7CJRsVn2cQsGA44m60hO6RyLDhmjVElNc7tXPvWsmIS9OLNgD0yhHc4giXVTpD59GaIRmXRJd6CPub0NBrB4iUQq2ZUg/DID10sA+h3E+PhTR0vQSpHHazc5pul4Az9rFD79Y05cGYjlEStttMlYtyqNIg2oVgpkJTXVNSYu2hSZr9/Qk/J8Qw6k2yJn9zVruKthEo9BKFhn3eXQiSuoUnXAXHK/UBpukJxXlenG7VM1qBIoUyzePfUPPz9INk4oBVTr1fhtG8+vy06oHq5Dwhsr4tPM8ecnSI3Kdv5wOm4TyIr19n0z4TOPqc2Q2DkTbNJL2bw9P90B2Ne/4N9RG+ScCGHx25KiOSxEIjUhnZeYVJohJ80+tO/OcGALOU3Xc7QEFeMsxA2DPFat85JWtRXphJVoSfc48xVba9qqFGoy8F9ps+HYB5lKhdl92P/XmVbLfRu19vGFObZ0hts+mhKdwhKv5dSv6WgYS4ZZSnDxzUf2653g26vhUeh2sl4FWFSqJfZ70foc+9GH1eeIZHoPsogk1TKcBlM5g+FSW7LEnrR2RMy3dz17Wa1iTYSZ7us5mGamuZzsH0mR9Kau68dCrJKFt9Tz3mzXdBJ9bUd0lYx7GHauowp1hMpNJ+MbckP65F9MBvMqzx0Z6+QfV4nWB3vN2Nq3NGnu7PgLPDSzVwL26D8VUmsswHs6u3wCyOlirRm44w3Hgb4DaymNPRpvTgLKum0vWUVIjke0uXNmEjStK9eUj2hJM0j9vvUrkUU4fp+oeiNIVv+trSke64DtpISmDt55d2kbshIb+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205e85d9-96c1-47e1-afb5-08db408240bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 03:00:38.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLQOWLovYogaL7EtNSFdzTSvT9be+78rsqn0AeU2M4A9wrMyywZrCuaG8wJB4cfUOyQp3GMCynMHAZhFp6xt5wdKhM4w/Hz+sAVHDHwuWCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_17,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304190025
X-Proofpoint-GUID: 2vdISWVtMjsowDyPTBAa4oFusEfx80-O
X-Proofpoint-ORIG-GUID: 2vdISWVtMjsowDyPTBAa4oFusEfx80-O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Currently scsi_debug_device_reset() does not do much apart from
> setting the SDEBUG_UA_POR ("Power on, reset, or bus device reset")
> flag, which is eventually passed back to the SCSI midlayer later for a
> "unit attention" command.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
