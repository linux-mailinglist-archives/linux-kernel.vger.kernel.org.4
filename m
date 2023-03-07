Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0076ADC80
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjCGK5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjCGK4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A653D8B;
        Tue,  7 Mar 2023 02:56:40 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32784XGQ001987;
        Tue, 7 Mar 2023 10:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=fFRgwhv6dWVlXHwUpj0+8beE1l8ZZNr7TgoljdegmuM=;
 b=RNPpscNLIWtKuHXONSerX9tfiRJXy9zrCgxYlI5N6ILCajhrL5RzfE1qD7l4DUp5fTR0
 S/eVQMmQ+uDc2c9wqWbytueIz7AbTquea2bX3CiIfCH0ElZqyd5BEsu92epO266syAqM
 LAz0vSqg+MENkrYDDn+B5W2FGZGQQCh6XT1cC4JntTmne6cJyvvMTKapSstIJtC2/zH/
 rJaBGynjhwxDtyZJXnlcXuZfOOX1IuKm5msCoWqCzbJygtpNNSWEu0gRf6lZj+ynBCWk
 MCMshvZFZN8EZsIliX068jQCCNQso6EixVf3E22xA2wk7PHa1mbaWnPh0TATNR61PZP4 Pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415hw872-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327A0S67019086;
        Tue, 7 Mar 2023 10:56:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4tur3wkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnVgZRiokaFLAFPkQIf2WTLboJ6R0/6JdwKTVDX2+ovr70JYcDusF2rHp61zypF2eFd16G7DKoV1YKeUAwIOHJYedTlJDx8uydxMhVnQtYDxECHpiEhIFpp7AApbgyRP9tkO0fo7bjF07AKDESevMTEoN+zEko1FugRSJNKqXAUPCZwD46v+BTzchhhXphiCTLm41g0X9T9KYH9ZHa5naQ88NlyWQD1HaboBNjqvk5qxt9ttuFZAQOf7qsSS2crvj2iKZUOpRIjq2ggVOaagP16W8mu8GLcm8TzraAldlN14bho6j2NhuhEXUkOKdvf1+jPwzAHkllCVxIHlIHml4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFRgwhv6dWVlXHwUpj0+8beE1l8ZZNr7TgoljdegmuM=;
 b=ebZyvBpavfthK5ojxGFjisUwJqUwba+zN/uNLgVKxjYCdEoWIwdeMQMWT55g/E8Lk7UxDAZK3Z5AjZfVBNQRvKvZXhZIt/fZyBurkveAlfDJcEd6E76oWe2GVr+2pFFXM5ePfIPgSyOQRQDfkR7QBAGl211JUDOvn8R+vNU3CV2yqL6AEFw67rgMz8uoVK0e+1Y02lmSqS0+kb7CjxEhnCz0tOSKPDHXtdXD+WPC2ZEbd+WB0pyLMH9rEA/QnIsuLuhPuwx96LMjH5jxikC6kuYXnCzpmPijYLxFUlieT6lVyDS/xpWkiCsXF2u1ZWjiOowpwbFS/tf/UcKjMUa8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFRgwhv6dWVlXHwUpj0+8beE1l8ZZNr7TgoljdegmuM=;
 b=WEQHEu0YgYoxgsK/HAa5QJKQKb2YoTy4uWk6bwyuCBbvyRqTbl156nAR2MGZOVursu/kd8taWG1rVHdBb0iJlMcQE+hm9xnBjIRs9R4BNbshqTaTFylPt7uIJiFQIoerx+1uvpjbRH6O88dKKCoAXgyVlC9mdwRkeGG2Dr8dDQ8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:56:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:56:34 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 00/11] scsi_debug: Some minor improvements
Date:   Tue,  7 Mar 2023 10:55:44 +0000
Message-Id: <20230307105555.3745277-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:5:80::47) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: c876b516-d54f-4ddf-f0eb-08db1efa9de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAkA1VSjJgpBcMcZS2k950bPimClDzrPDa9hD6VfIx+nvWhtvijtiktcROwwVmzh/20WCGPqPTREg9SOrJClIm7oQOGJ+VZdSrpisKElBCiQTg+bDFWBsIvsgVi7KFNGawnub+smKHe4dJksne0/TMm8esUj5jQC//s4WGfk3qDziK4u7wHM+WQY44HhFfToh7s/KE3OC7xYP2z+cT2yV16NQFv5TBpVGQCueTYT58d+OBm12pX8kifQeRBeFpiackStzBHQmq9BzK2A91j6ZtV5ndS0Spkqs3v354445o/fsaujhOa7DhQvMLBvFbxalNETVGOcSkjwmZ6rF+tfWhFTKGuqeFtl4PgXKdXIeeWDRD5wK/r3BkoaXNRvWmmRIhaaqW57CeJRVeJeGABtULeMJVgNNv08gWwFemsYi6ipfqLmC8JWCCDP+nImShtDMRVne56ibxh2uxt3CHkg1dO6QkZ6sHKEQ/zdxl/mJYKVhARW9GFu5w47Ah4N38wWEd4k8L2BJClvCsHh49Zr8YgBE+MoEkGzfcIeFIxRu01Bl7apOQevDAc1Fu0yjmYnoJ0lh2TQFTZKr9VZoXas9OHUq0kTUKy/4+t/Rjm9th7F4cK7FsQI3/HLTldoA4C0KyCFmgGZYKdWKnHxtKt9sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(103116003)(66946007)(4326008)(66476007)(8676002)(41300700001)(83380400001)(2906002)(86362001)(38100700002)(8936002)(36756003)(66556008)(6486002)(478600001)(6636002)(316002)(5660300002)(26005)(186003)(2616005)(6512007)(1076003)(107886003)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b2P83IDHQsFxBm9MeJTzBcqLww5zXrD7ho/kb/ejFbBtDpbIXt5wRnDskRjs?=
 =?us-ascii?Q?c26BcTO1bHJegmSR76zGq7Lgei/yCorvBLjYSlE8JPNo5B+Wx35t1AB48/sW?=
 =?us-ascii?Q?Bt0+9LxxGQcKmsS6Bl7aXucW+ovD8RmDbK1yygCGt535pvqp4LrwK8C1SNuX?=
 =?us-ascii?Q?aB5kW6Ylab2MjoP/ffNb7PyIHfK8ZQP1eVDt/XkSFhi62+fs9Xag8/jkd0MN?=
 =?us-ascii?Q?FYPgWk5pXx2BUIA9aotliT+/q/T1oCYxwZTBFa3nj1PD/xfRZkmYiPZXGMVQ?=
 =?us-ascii?Q?kuyBbzIdQoTFBy26e7zBo1VaWiowRVr24/EbqvzsMAZjTi1ZAqL9aKyM6Qm1?=
 =?us-ascii?Q?fa8g1FNXyOH99a7UUwNEDEKrMZCO0uKM2FOhNXTF5d4Ty0VW7veiiuUIEjbx?=
 =?us-ascii?Q?1Pjojlgtou/4KLLI+YDv1cpAmaS+aVPyreCHhi+MHK8Y1umTFp07fzh0ZaH/?=
 =?us-ascii?Q?vqyFohjQ+29rZ2959WctztBlG4s+MI/WOBK9sTGELQ682huPHFnSS/CWfdI8?=
 =?us-ascii?Q?FT6Zqy843gKC7C/YcTZzh8K+qmxm3MoLf/uiLesFwTcjhYMm279i9bTIj1nt?=
 =?us-ascii?Q?4FmbpdCcabjX8x5cCqeccEV+dkTchmPSvSngZ8uHlPACL/m3lIL2QFmMGsbW?=
 =?us-ascii?Q?4yJEy+tMSIPY00jchTyUmkc/tr2X8M9vrqhcViDWfg5/QryjtCFa4SOeuV+i?=
 =?us-ascii?Q?4JhJIUwwlj2/xQ4uopi/FfQ1/CeyghwQZRi+JsrSGuKH8Ei+LRi0K3xx/AAg?=
 =?us-ascii?Q?t8bGCwWKag7n2NlHAH+Coss2x53npA5fFinasUAc6lNT0ifvhgvgR0zPn1s/?=
 =?us-ascii?Q?ZEuzj1jjYFt/SgKQba3MKxJMCrOONonnVmgcpYhCbhx1FN1pISWeW+lz6VbM?=
 =?us-ascii?Q?f6ZWhLjE+1BqVvFZ868gejUYp8CDV4s523lyibjBWyOgC9XhU5oAFfIuLQh2?=
 =?us-ascii?Q?D0+lEJEoUjkAcnICWVMKZyhC7LxM3s1IXsZHHLSOL0f6TQFXW8REsp83T4XX?=
 =?us-ascii?Q?DjYZX8d7CJb6L01rRppIgiZXnk4cBMx0jfxaMI4Cnjq9YOXdZ2SJpBJvtglm?=
 =?us-ascii?Q?Q3V6Z9cExsgFVfoKfAL/Vv/A+u17SzYYPy9OZyHtXVYSKgzUfubm0dt57Vcm?=
 =?us-ascii?Q?TpeD/YRDrbkQXdFLemAT5ykADCWefRFuzQvlukHju6RS/2Wk/j4/cktVIePl?=
 =?us-ascii?Q?iqgBYfwMdSX0StRwjyFjR3eKnvI93IgvglcMRKgl2XGFu95SVugj+DiuI8Mr?=
 =?us-ascii?Q?tto8R5Lqhbz/Jp0JCtBNn4oQ/otpLMDlk8tkYe4tMFC8RopSdNjIpKpbVuEU?=
 =?us-ascii?Q?HVky1Sbyr+xT2Ahwmba6mXCRugID14qBO4wzQlWGKSD9Bvi/irYd0WUwNVs8?=
 =?us-ascii?Q?dbGe5mgblckR6G1wRSnIs+WliaC2pjcdSg3oEZEnvSDUA9m8picdJjN1MzCD?=
 =?us-ascii?Q?xWlzNmEo9lKo8S72faYv+8qGQl8T8fkjiYZNGKMqO9oEzrAGzo74twTGMZIl?=
 =?us-ascii?Q?TkP8qduapaTZNOUGdqmrT4bvzyg0oWNVQIv5tREKFXSdqxS1QxllZ0XL19zV?=
 =?us-ascii?Q?1UyQzh2yy9mxDJU1VI65H/cGESEhaCAMdu3/zpCkxCgL/1T/pEvGgr9W4p5j?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RpdM2ueMKnznJ4bB/fdEy/KwD/UpFI6M/M/rkpQTV5W0Xz0oqjONroFKFL4bbkOGeCka5xcJT53Knfp3yew1TWH+RWkzdqtemdyvPF6eO75zzVKLzZj00xCaSb9ZImJemM5KpUIq2pzAFVGIfGAAwyYjdfFHYs0fNptKysMWN/QdsSMLPryYFVTeg+GnqFV+zhOfBYKYPjS0fvf68PvtocwuskUxwUrit0KIv6w0b6LIqcUqXywwO99ZVLlqVjlcCEN+72aD6ZbZ6yNuIEGiBo9dcRkDv2k7vEztHy4WpC776/umKZMgpqwjGM56ZGxZjosY6jwwYu3dUnMeJ+/6b+qA6zjiezAi90WpANm32fYkh1JshufLIXPzJVO6npi3ftaQyJhl4hMP46JgBwimUrqdwh4AdCMxhiOwD1/7jTeEMKtyBB0nrHjD4HU1LBMQN8sNC2JXDOS0t3xjsnXi+kcbgFgcXGH0N/ewmfKpuIbH6ZMu0WLvIoTeA5xc1UEbW7+4cDelXS4agJdLGTZ1FfBIM/1AnrCAwm3d7h7md+I2fj4nVxV/q6uOcTUQthXo9W0k1TDPIEX+eZVBmR4h1BO0nZZk8F7ISeX+Qp7d0gtttA1QVN1KP3xDW9//MdMtUAU2IAHkI4bvXVUuwqR+P6AOJ0lHtP6pmvYFGQcda0O3gmKPMkQ24PKpjLc7eyHY42VN36OIapuCvpRF0yXEQpZw2DCxwJlwsJHKcLSy3VOYz5whfa21q7DOCM2D1pKZfT/EvKACMQBKuNU/M2yBm+vHceJKZRnVur61nMMQoz5YgNDQ9M+AD4LgqI/dRaomROQDU9H7s0UCiR+jwQZ5eQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c876b516-d54f-4ddf-f0eb-08db1efa9de0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:56:34.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v03TAQdjKfoitWMyuWCYzhRDlB+HuYF3t32bWQaqYSa/YEx1kjkbjjcYbAzeZf09hMgwoFkm+KKttvCa9Gw+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=875 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070098
X-Proofpoint-GUID: aPNGr9s7qXIfdGZOG95Pws77psEMX7m0
X-Proofpoint-ORIG-GUID: aPNGr9s7qXIfdGZOG95Pws77psEMX7m0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a bunch of minor improvements to the driver. I have
another bunch waiting with more major changes.

Most of the changes are quite straightforward, and the only patches of note are
as follows:
- Fix the command abort feature, enabled with host option SDEBUG_OPT_CMD_ABORT
- Drop driver count of queued commands per device
- Add poll mode completions to statistics. We already have poll mode callback
  call count, so maybe it was intentional to omit poll mode from the
  statistics.
  
Based on scsi-staging 6.4 @ commit ffba85603c62 ("Merge patch series "lpfc: Update lpfc to revision 14.2.0.11")

John Garry (11):
  scsi: scsi_debug: Don't hold driver host struct pointer in
    host->hostdata[]
  scsi: scsi_debug: Stop setting devip->sdbg_host twice
  scsi: scsi_debug: Drop scsi_debug_abort() NULL pointer checks
  scsi: scsi_debug: Drop scsi_debug_device_reset() NULL pointer checks
  scsi: scsi_debug: Drop scsi_debug_target_reset() NULL pointer checks
  scsi: scsi_debug: Drop scsi_debug_bus_reset() NULL pointer checks
  scsi: scsi_debug: Drop scsi_debug_host_reset() device NULL pointer
    check
  scsi: scsi_debug: Drop check for num_in_q exceeding queue depth
  scsi: scsi_debug: Drop sdebug_dev_info.num_in_q
  scsi: scsi_debug: Get command abort feature working again
  scsi: scsi_debug: Add poll mode deferred completions to statistics

 drivers/scsi/scsi_debug.c | 201 ++++++++++++++------------------------
 1 file changed, 74 insertions(+), 127 deletions(-)

-- 
2.35.3

