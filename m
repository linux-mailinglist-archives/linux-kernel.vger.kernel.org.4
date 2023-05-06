Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B116F946C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 00:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjEFWAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 18:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjEFWAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 18:00:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFC821573;
        Sat,  6 May 2023 14:59:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 346LvwJH000397;
        Sat, 6 May 2023 21:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=FhTyFGbaiiBB62FUksvyn+VDMtS3yjcAT7BbZ0rJRDs=;
 b=x3wSL/Y2Qsaz4PLUfQTsjubYrV3shjf7bqv5bUHleEKR0K4XrkuhpUsRrgO68pA1FfFX
 QqEcGoPsBhGEX5MR06ibl4PmyVXrlwzKtLQty9buTe7ejQM3vOx7zr+GervsQVOxKFMe
 WLOrAp1GZ0j2nIpjSnxId5BBI8MPqM2M8YQKIAe8+ZfN6LiC/jsZleBlS1sFrLUvZFpz
 s88xdoUMmttYcN3ljfb5z/K7Dgx9QWhbBHAbC/yhhos4oLc1njm+0K2p8bOGniqaX2B5
 CCBjcOjU88lmgbDALC+BGw3oeUtctvn1U6iIx/7oNqf3ee3+OXJwZ4chaLs5Hma2CuS0 pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qddp4gy0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 May 2023 21:59:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 346KKEaF024227;
        Sat, 6 May 2023 21:59:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qddb3as36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 May 2023 21:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY95UxGQg0rZksXUm2Ze+Ib73JZy/aNCYu28wpt9IUs/7isfmeaOrm88M4kiU2yjnv+bL5ROPYh0EcR1iscRIBzCwpWEYSpFLgRRfGKfZSqN84w01AZk6zu8M6nGab1sU60DsOJUn4PZ0MfZxAz3+FKo8D+zsUlbG6cooblEqSs2l+56zuw9I3wxuzbnamuA9NVLkoBNI+nGg43oFSEDXNKX/j5NkVdyiHcv0JSPb+oruvzqJ/PU5lLFwZ4mpZLGEjSNVe9G87Ep9s683P1mBuKlm7fPyV3JYKcAHzTaXvVeoU7F7DS7lsL8GrkrgOxc1CorSLGp6IIJFcOHAR9ymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhTyFGbaiiBB62FUksvyn+VDMtS3yjcAT7BbZ0rJRDs=;
 b=b+3HyxFpcWwhzMinh9+u5s/bLEo0ItsvhvKOY7PcfuLDs0WDZ76aewKiiP5IKZFqgwl8H+/3czyNzEyNT7acxScvpi4v9RwnJzTm3Hd8h3C7ikNA7Vi2EiLq6aSZ0pWH+v7wcyRBFqt6PeIqd3+o0Es0+CVJnBGYbm4X7grPehsn0/QAWyvALa9V8gtENzwpbz+NBc/0XguCF2ORHKD1bfFm4iqnXn+zmgKRPp+g4ksON9KdZN+9kVDej+fbk4OYx+oBow7f0P7UUU4L4ZHNYjBHYz3uoHzDxe3VbwK0hz95a8Ain+fvqVyl2IoruMVBwrWGiAAUShak1An6ZYmbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhTyFGbaiiBB62FUksvyn+VDMtS3yjcAT7BbZ0rJRDs=;
 b=QnwUhCSf9v9J33y+MRVueH/DxJaKhDIfZftQmvgJXTGCn0ejcvr/Q24Um/J13ZvG7g9I7KK2W3HKyDTNx2kkOTQtV81/XHH8qO2BCx7nKadnYL+jUyO6lVoQuPhiqwv8KmcMxkCgDzeaIhDBTsmDZHVho2LxZ/dR3IxXLVkZ5ro=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by LV8PR10MB7775.namprd10.prod.outlook.com (2603:10b6:408:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 21:59:45 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6363.030; Sat, 6 May 2023
 21:59:45 +0000
To:     Pranav Prasad <pranavpp@google.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] scsi: pm80xx: Enhanced debug logs for HW events
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ednt3yuy.fsf@ca-mkp.ca.oracle.com>
References: <20230418190101.696345-1-pranavpp@google.com>
Date:   Sat, 06 May 2023 17:59:42 -0400
In-Reply-To: <20230418190101.696345-1-pranavpp@google.com> (Pranav Prasad's
        message of "Tue, 18 Apr 2023 19:00:55 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:a03:100::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|LV8PR10MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: f1583d3e-6367-41f6-f24e-08db4e7d33ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3YwTbxlpRZ7hK7UXdzS92paRakJ0h8xLH3gsMMsRUzrTlKmgCSKFs6Vg4FDsBEqgpnfH1caWrtwjkE6bvjD4ZI1wZX3F+WtGRTAu8Nb3pVJDvLJpOIf/quoJarN8MRzMpXrJK+ktKcHmo7zEiwVbYfjdZ1zE9evjtdWvydAqXpB1EBAhXmpgXRbyf+PaO+o4qAbU0y3iv7xjKkpihooVTMVVHFu9G5+vcAF6bxbpyiNCwumKaF0JWyCl5b6kT3COkqxd1dXcVzBP08HIi7iIhtC2yEhffhY8GRiRF+t/afbpJxYuRb4g2OHQeU+VIg2J+5BKggKvTKZDIkIc7j/WxQduqoa0NcGBZ7ds/8yA0ELS7eU5L5J2gHPWc7A2uG150saFq0tDH918OZFcP5z7pl6VlJoV0UHK88cz/c1oC7GCtG7cLZtcS1E95HUORkljklCJ1AspnDkLnxNVCf0cgy+Tjvh9cXib+LP1qN8u2jNh6uj3f95+fkvyaDh1DDLqzYbc88IHmDdj6HDKn8iJVZNVWMZePeqmJA2Ckb/J6Z0Do3bIhT3bBRYnM4soiUM5KK6jFDjIJSkfXObvL4K0Ze9w7uebC5jhVWoGZYXloE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199021)(5660300002)(8936002)(41300700001)(8676002)(4744005)(2906002)(54906003)(6916009)(66556008)(66476007)(4326008)(66946007)(478600001)(316002)(36916002)(6486002)(6666004)(6512007)(26005)(6506007)(186003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V1FGUPUX1d0T6y4aaDW7don2rw1qkPSZcRZPFF3RDaVQluP3D/RP0YYDNIHr?=
 =?us-ascii?Q?9Fn+wrLqi1iRiy9GwcLs9f3a6BfjC07VFb08rpQV9XiNBPRy+/Mwj94BiJza?=
 =?us-ascii?Q?F1np3SXnjiGPYM6ax6Yn4iRG2na7lQjioALhPHFEWcIrLSB2L6hfvQmQGYWj?=
 =?us-ascii?Q?V3A4N2aPupIKP36inVmH4jCoQpQkh8lVNko43v5HjQB0RD4Dz1PSO2jKtje/?=
 =?us-ascii?Q?HZHjAWSWn6YuEA4KsOvbH8lCmFtWgQ0xR7QZsvtsSXIh3UVMJK75qjLvted2?=
 =?us-ascii?Q?UKdvTeArlkLXvODvC5IkyTX0aZKwmKDg8hMYc+aRoHAenMLNzAFukxpLgApL?=
 =?us-ascii?Q?qS3CBPg0A3fIK91Eutdo7GHS6C5mr+xaR6esf99/teSxMlDNuNfmG1QS9QVE?=
 =?us-ascii?Q?6kWYOadRe3n0+Y/U56vMO9iqmbueK303C/9ZAPcKhkTmfiJqGblF/3T58iU1?=
 =?us-ascii?Q?Op3kscNdSp7/b76c7N6s6+0hg3+2GkQtrco0qYtVYgS7FgFFsV0QyUHycXK7?=
 =?us-ascii?Q?kDnu4mfgx+i+ZHLBlE+ZvyE5yDMZEfssLJxPCMhZPmwvK8v7HdZhVijepuXn?=
 =?us-ascii?Q?HiZExk91vsZQCKHhwUqLTT2V1IFYtnnu6Cbp/CYXax2QyGGM8+J8DXMb93Dh?=
 =?us-ascii?Q?rzdCEuQV9iHsDHZgFD2gY8AZdxovDlQyhqf1piP6rUg5SNMFClFE2ypcn6hJ?=
 =?us-ascii?Q?nxT+s8el7BDihxTwF4aNb5uZHXFEz+gtgiVWH2ol1qHXhBkCT01SIS1Tt7Bm?=
 =?us-ascii?Q?Az3FSM5Lzn9bS/2+otfFA1429HD9f/7uPhxV+1d6wW/bm7ww3RsyVnASwJZg?=
 =?us-ascii?Q?W7nZuhG0tozKcjwByGL2+7AoAKbBtGUELGRkNBNts/Os4OTqv4RoRTf+oiKz?=
 =?us-ascii?Q?BSKg/L6Pih0yITZmidFDC7vXAGqB1hX1xvLb4+XluVDCH2308HWaChoz2bTW?=
 =?us-ascii?Q?fdntOvgmWZBT1h5ZW2arAGxaeR2jlKQdq5vRqlMZhi/9h6EkkXW9/BUZ3L5X?=
 =?us-ascii?Q?qFnH1uDu0mVd6MYR/X1Z4bzRokBZOVuAe98JdiIjyimGvMy4X3MSczYLnncH?=
 =?us-ascii?Q?urMxa1DjDPM7R7WEViOcrfU6KWS0wfCVrsbFZzzeZob6jVUdSAWXJO/c0les?=
 =?us-ascii?Q?n8UYK1CByYPi+aR5RKLB/zGwueBFQzzljFWnv9AfpAjU8Aph7GPPuiKpC2uE?=
 =?us-ascii?Q?vykcxZFirzNVo7cSIyK7Q8HngrnkAer623Ef36jQuEhrHJU+ZmryDYCz39yD?=
 =?us-ascii?Q?23jpJWPH3eXCwzGpU8w31ot9tYfA0IiRTQ4YNiKv8tp9oYesDxO+kttaLkLh?=
 =?us-ascii?Q?x42omDttzr2kG9ATHIITc0jLDY/EGde8WQcfv85tbi+6o37kTsb/3FfHyBfe?=
 =?us-ascii?Q?Atq4gVtY1KwEha9OPMh7zXdv59SCFyZphT2/qBUtipn92wpFWwbY64Py0XfH?=
 =?us-ascii?Q?10jxVrQXJZ1D2TxtrRRTWgSYKOwMEQNop0i04JC7jK2kdzood4InwWkW+2c/?=
 =?us-ascii?Q?APvPB/TEBiwTM1pAYuJ6A+X9ZrD1IrIWTPfEE5V8U743QpiDkluZHPSpBoU0?=
 =?us-ascii?Q?T2PGs3qmOiPEyde3yHk0uda3m3KGvAVg1plMYmRS6YhGlpXL3KK8AI1cnucr?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oDzQD4STO7K7yz/q60QmgsvXv34cj9q/HP2ttzTIuEIVSoXm3krjJ/6pKeZ/LzUIHLmwPIoYgQsuHnQVFvlECI33Zj0TmTjgWvHPsyrRFh7Y4hVI8SbL1mzItzyA5CI7xH0duAJ9j2i/ti6HQwiYwtcQTlE93u0Z1ck7LubzQTkKch5HXWYgYh2mDrVXGoMMyZSJCB8m/9LX0eQRbiCMa0j7IPVWo1fYQorrLscjz5r9ggnV6b7BESW5poyplmm78LAj6CSiBf3aOEdMLjYKn0IVAvK98jUOtqVqotzYqLcCKP3/BxLpnR3iTF4zawFbS78hLjOBsy10Z8T68Wvt4ZMCDwc0bKeR/HS4L/sjAJR3HXlud1DvJ1V2D1ibKnBcBTBEwVvUZnsUQw5hCXEaHBfIeuevCsIp6jfGY+45MyGIVQAnEd3B1cHrIn28VfHrI47BBaXiR2qJoaHn/lP/c0f8TMGg5/PtsxAs04ZpsFNhi0Rmii4sPKC28TNB2Ac69czfVBWTJHzbfALSlx25s1zsNxgpDEdgVS7jSpe5nM4jAgStMCV2ABn+X9lIvtDO5323nABejxTqfX8IsS+lbw3yRT/e85irLAcYBXrXZpKxe3AGGTQrluDt+RyH+20Ea05dGYGRNwFJi3/ZfRi6Ox+Gtz8sKG3DWZChR2DhaB9tGjA7P0szdY0Xu8iKu9aQ32LLO0m43VLoCavNvQPDi+rDK4EhnzvnffNg6D6odiIA/q2jBLTeRipVaKNUPryAOBjjWfg7OY9JjA0ZjU/IOAVRIwVVfGaU6wDvq7fqM+inAWwwNM1xGRH8GI1m/cAG6v/E2fqq+BbbqPr5/ZQyz8hiCC/HPUWoWjFjEwksE6ZtuYPJyFLq0lgDe8LtDbB0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1583d3e-6367-41f6-f24e-08db4e7d33ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 21:59:44.9154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mC8VZz2OsclPQUCJgic8aZsn60c9J6yPUzjTbfd6UqTD6F5zioaRwiySK+lZstxZ0f57iUrBstqQEXzi1PwuVBHqvzA+TIrE03F/pd6PQWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-06_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305060172
X-Proofpoint-GUID: mgOzj0w6-2QWZiHBnk8KeveQeUIdqDzQ
X-Proofpoint-ORIG-GUID: mgOzj0w6-2QWZiHBnk8KeveQeUIdqDzQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Pranav,

> This patch series enhances debug logs for pm80xx HW events, and
> provides a minor fix in the case of a hard reset. The log enhancement
> involves changing the log severity level to enable logging for HW
> events which consequently help debug disk discovery issues.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
