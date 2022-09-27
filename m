Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77C45ED0A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 01:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiI0XA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 19:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiI0XAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:00:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F33B58DF9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 15:59:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RK4OYk027172;
        Tue, 27 Sep 2022 22:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=B8gyiiT7o/eJWsn4vpP/IZGXm7jAkz2ji8IbM1PQvzs=;
 b=HVni21xVlCzyvwQybtIq3CKC3iKUAdn5SpueTBswPOKGgLi+OKvck91rMKfGZUXKI/nh
 3hWdfsUImi2jqxKL6d+km59ODyXA4xK6dII7+RuHP5X5/s4pbxam0C5vuFfjcRNtorl2
 RbDnzLfqVCE7P/zxEBFigFidMhb3g88O9fJKi9nIvP4l0maXjjdsStf1k6Ia0KqGoEik
 59EulDK7Lox1FReugqmSd+dZV7J+IglDtEZz/F6sTAUAQMnW++g3q6qJttYcRJdkku1M
 coT3d2SZ/S2NwPtrvcIZKHeEpElnqDZ9M1K+4thuqEF6AMqBQgo766Fhc7A5k0M8wNN6 Fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstpqxsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 22:59:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28RKmf0W001421;
        Tue, 27 Sep 2022 22:59:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpv0yphf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 22:59:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kej6ZI3/TjT1Keeu0czSMfR9sWUYA4L0G6OnSmmMiBhWUZdIDhqpJ+X1/sd9NdNoc+AYhchgCHBNoCVaBfMD9ry9hgf2x0NveVTlplnIZxCcWpFaMMQwN4vOUB6b+xe/F2aF7npirwfHS2C/ekL2gmXVwY4BfD9G4cKFUkZTO5Iq1XU/eUr/HfzbEYgIWCUfFNCRDOlcMjXpOhcrjPY1vXl3Ik18yQcyEKjnATq4KL2tbrCdGhZHPjRd92deBb68oWIapwW7eBfBd7xIawKP7AAUloATBtGLvo5nyZHseYF/wHPWox/roXy9qy1D47x4RDlJCIifeAbi2/pQEl3/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8gyiiT7o/eJWsn4vpP/IZGXm7jAkz2ji8IbM1PQvzs=;
 b=mEshahV7X7RrN6CawR157eSDt1BhFkX21uFtdVzWhkM4uSloez8Ml98D21AItOvxU92jNl9aq8nU4vT4IuycnTz7IvSCVyDorM+QpmOiSxVCvdYVnbF4k0YkbdnDXtUAeHKALewO6HJ7IVxBfwcB0lVRiXyGP3nwUTb6EY0VpNUmPqQ4AcBprCM/CBaF17jMqpRoJCzXwm3tr2HbOPsbZJZKCqIM1mLmoi5ku2KDyOICa/UzgowlSCH1spmdeW6Qr8+PpS5l/Rsbx0P0+6I6udI4PcGRTVQ5bkg6hEd/uLs8wvtN1+R8ZijNBrc4sldVbEKWCb/m8q37BcysOLa5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8gyiiT7o/eJWsn4vpP/IZGXm7jAkz2ji8IbM1PQvzs=;
 b=RGgQfg4FPq1SD8sK86Q9IqkB3PAB1XCMCF7Z7cUDdX1WOxU5NIPKefSdHPY2UZzHNgnAGtbNRuHPJ6a8QRZdiK+oi+5LRg6A3n+Qav/7YBh/4t1Comk7mOYgdbFYzMC6Kf3lQ0FyVMLF/mWl51aG6o5u21Dc4KwiZM6K6/KjI2g=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5175.namprd10.prod.outlook.com (2603:10b6:408:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 22:59:47 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 22:59:47 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-audit@redhat.com
Cc:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH 0/3] improve audit syscall-exit latency
Date:   Tue, 27 Sep 2022 15:59:41 -0700
Message-Id: <20220927225944.2254360-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e15367-1d86-4cb6-0650-08daa0dbf957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wwgZiPNkQIFt6iNlTix7kFryWCW+CGkS34jzsRLv4BamjjP99CtBueVLhycZThKdXGesd7/8IIcJZxSY6htGI12E15v8fMGhznv92XmkDDcOfKP+qpJMRrYz3T0p4MFgY869+Gg9hfSzZ2yUDdE50W0tWnNhfrtfG1vVSS/U6hmHH39l7/yCOPJeXo+i/wYlvDcijITCXcoLc7DzJfSZDf/AYjIKZHiiJd21HECcBokd0EDAiJnbiBLp4dH9s1CcCaPkNSSUu1SbOOyHKEzZIsiOx9pVbeLtxqNMvoHJr8hpRxkBroovHGtTFCSGzXjlHo/KFRuORKLhOWgDe5ONXOgbnh4YpeQ4FuoFnW0z0IyFJmVHBuysWdmOdqzbF2r0Nrzg2lfAJB95a6MCVthDZTEKy0D/sdZIVZukH8GgmzwZ9+g/490+hmtZmLEL/6krPm9vhQ5F1QFofCqgrjMQZRary2CkHDH08rzA6LPSMw15ItoS1vlBIcyDGBfB3tP5dMWD4DrnUPaSIJ1NJXzlDKgmsQGOG7QyjTHINUQWMlPS1L/CxQKyRMFJu7vzRhN4rXI3tVo0KPZmF4dbVLeGqaq/vJTx+kCVikFyMTOkBoSOS6yrZ0YGlHAAPt5nHHr+STOCB6HfnpPLtbKZK7OsOU87eWF+c/SYvaTNetYeVqs0t96hJTZ5WAjKQhmOAoDVOoJme7RrRxvUogjtSihOuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(36756003)(83380400001)(38100700002)(66556008)(66476007)(8676002)(26005)(8936002)(4326008)(6506007)(41300700001)(66946007)(5660300002)(2906002)(86362001)(107886003)(6666004)(2616005)(1076003)(103116003)(6486002)(316002)(186003)(6512007)(478600001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?13vXfGq0Ht7Wjr4vwCOHDm1E6lwRqoz6nZgl2jHJS/YFCV2fdSt49UvuMMAi?=
 =?us-ascii?Q?CEmr/Jdvtr8LTR7rOstEY1ir7WCU8fW0fflP8iwzAmta6o1hk1yHTOUs/HM0?=
 =?us-ascii?Q?TmrP8PwAJt5Z4Q9zcEADbUYE2srF7nJXG6X1N8VDj6xE6ZxwbCTXapM1G92M?=
 =?us-ascii?Q?97O9SAbPe76vMDEqJvvhhH3gZ0zVBd6zV+OX5u/dAKpOpcZnrv7PAbBZ0+Cq?=
 =?us-ascii?Q?3sRMR9XTdu391csY2GbxKKdH2VXkanLUzTIEpS68+SIU3468aeL2T0n3yG5D?=
 =?us-ascii?Q?MDfaYOPi4cSa4OFnzKNAdthVGJBnAyztdRz+6EGMBlMdwfepy5pQuPG9OZiD?=
 =?us-ascii?Q?hJ1ERW+Bn0hGjWde6wK/ajptfEhI4PTawTYoMI6rjOdXRMiC99ZNouPRcZEJ?=
 =?us-ascii?Q?B0k2MSXmLknUGKRB1WsgRu7IMQdDQwYilGfTjdXVHVOTrcvD22GZPkNpBgbt?=
 =?us-ascii?Q?vaW5EQkCxl4oFRs/zexxUfcC6COmoOkjCKGk+nj7ouUWVosl0gbKK+EU5RiY?=
 =?us-ascii?Q?xnvfocmxjjPfMKIlVHMbcLEIp5nTW9nuiHfFUJkCch89NxDzv9a7jmQrKMpA?=
 =?us-ascii?Q?EoRUkRvt7ZjJdujH8t4KWkeP8Iu0SMXmvQa6H0C0IFcGrD4lMph+V8jbZB23?=
 =?us-ascii?Q?YAkciluRN2PJQU0fUTEBKDMwxW8Z9ceLliFkceecvtkRcXFbEGHsRSZbl5AD?=
 =?us-ascii?Q?jFQBOsi+By9kMe7VlXBtLxCQzzZkWduk8VoK5u/Y7ZvvEveR7HkowBPVSL3x?=
 =?us-ascii?Q?zLwkX9yTLPO5wng604GQep8vBH93WHQS9ONdZh7fOjxX2v7Y+hSLw//jBnpo?=
 =?us-ascii?Q?0d+fdbsS6c7+rVap3HTeaewVFOeB4AewSu2PQy7lmkiLyAqSa5jwR9PRVZp1?=
 =?us-ascii?Q?iFSOeNJp0yUzp+vXylqvTW+kBhov+XfeNYceqxxXhM9AbdXuu5p/4cWidp1U?=
 =?us-ascii?Q?HEwDwJflrn8STo5NmQuvMUG7d5c/p2iZdnvEsJ+s9mxvFzgpcUdha613wha1?=
 =?us-ascii?Q?SBLPDNQtM5xKvfNwpkN6RcTP2t9tJ7B7yE9hycxEeTEFWj8gYZsCaWwL8h5x?=
 =?us-ascii?Q?odWReWbJTec4b8cX3ePXVNOF6oNjH9Np10iQgWbhl28OqVdLbw+ZlHIYCeOB?=
 =?us-ascii?Q?C138Rd4nso5XKCBKLzNKAaYEVYag1J5SLqBybCYQZYRbGuZWwMoqv3G55SLY?=
 =?us-ascii?Q?tGX+8JlY1LJI17wzni+IAiwowlP1AdKIjQZNS7nNNyPqyH9pVdIuHNma9h6v?=
 =?us-ascii?Q?ZV6SXBBGUZtntSmLJMfo0zNsV7TdQuFqikXDk9DQJ94J1I07vwdj/YnpuzJg?=
 =?us-ascii?Q?w7rrh8Qefs41STX5/wDOTzzN05B77C5mVC6IKTcR+Gp6iD7DVLcKynouNqUT?=
 =?us-ascii?Q?5EIm/7rYhfsHocGS+DziyvZ1sqYeh2iV/+FPEAG176a5HYvDIeIAklT7kRie?=
 =?us-ascii?Q?MrlrmWJ0HZNsBdQA8yFpuSho+gBGRv6zOPdDltIOSFhIoFHTmiaTh6rXnIfy?=
 =?us-ascii?Q?I9xyLEwEQDudBwHNIBzYg0YzHHAaccydoRN8MCB+1eC4s345VHf6Ju0dbLJ4?=
 =?us-ascii?Q?E4Ml9tKXneLRT3+07DCDyt3LrjHF9V4zJ6mUSVAI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e15367-1d86-4cb6-0650-08daa0dbf957
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 22:59:47.0514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhiNhfX/04kLdIRa3azeVDn83IjxhB4qn//cdZnUwkFcQSiRBeu0pGQVAp3NB2G4DQl0qpYIbckgDhRham2bm1Go4zMh7IbMAd4D8bNhDhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_11,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270141
X-Proofpoint-ORIG-GUID: x2ImYmQfliJQWW-zgWB_SC1WYY9Qxdq4
X-Proofpoint-GUID: x2ImYmQfliJQWW-zgWB_SC1WYY9Qxdq4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to reduce syscall-exit latency in the audit path,
especially for cases where there are a lot of audit exit rules.

From profiling, audit_filter_syscall() takes the largest chunk of time,
specifically in this list-walk while processing the AUDIT_FILTER_EXIT
list:

      list = &audit_filter_list[AUDIT_FILTER_EXIT];

      list_for_each_entry_rcu(e, list, list) {
          if (audit_in_mask(&e->rule, ctx->major) &&
              audit_filter_rules(tsk, &e->rule, ctx, NULL,
                                 &state, false, x)) {
                  rcu_read_unlock();
                  ctx->current_state = state;
                  return state;
          }
      }

(Note that almost identical logic exists in audit_filter_uring(),
audit_filter_inode_name().)

Comparing baseline performance with audit=0/audit=1 with a user-space
getpid() loop (executes 10^7 times.) For audit=1, this uses an
audit-rule set where the audit_filter_syscall() loop iterates over
42 AUDIT_FILTER_EXIT rules which, for getpid(), calls audit_filter_rules()
for 5 of them (we use this set of rules in production.)

Test system:
 Server: ORACLE SERVER X8-2L
 CPU: Intel Skylakex (6:85:6)
 Microcode: 0x400320a

 # v6.0.0-rc5.baseline, audit=0
 Performance counter stats for 'bin/getpid' (3 runs):

            734.10 msec task-clock                       #    0.999 CPUs utilized            ( +-  0.03% )
                 1      context-switches                 #    1.361 /sec                     ( +- 66.67% )
                 0      cpu-migrations                   #    0.000 /sec
                53      page-faults                      #   72.152 /sec                     ( +-  0.63% )
     2,838,869,156      cycles                           #    3.865 GHz                      ( +-  0.01% )  (62.40%)
     4,174,224,305      instructions                     #    1.47  insn per cycle           ( +-  0.01% )  (74.93%)
       890,798,133      branches                         #    1.213 G/sec                    ( +-  0.01% )  (74.93%)
         5,015,118      branch-misses                    #    0.56% of all branches          ( +-  0.05% )  (74.93%)
     1,231,150,558      L1-dcache-loads                  #    1.676 G/sec                    ( +-  0.01% )  (74.94%)
           418,297      L1-dcache-load-misses            #    0.03% of all L1-dcache accesses  ( +-  0.68% )  (75.07%)
             3,937      LLC-loads                        #    5.360 K/sec                    ( +-  3.76% )  (50.13%)
               510      LLC-load-misses                  #   13.39% of all LL-cache accesses  ( +- 79.89% )  (50.00%)

          0.735018 +- 0.000275 seconds time elapsed  ( +-  0.04% )

 # v6.0.0-rc5.baseline, audit=1
 Performance counter stats for 'bin/getpid' (3 runs):

          2,158.81 msec task-clock                       #    0.998 CPUs utilized            ( +-  0.13% )
                 2      context-switches                 #    0.925 /sec                     ( +- 28.87% )
                 0      cpu-migrations                   #    0.000 /sec
                52      page-faults                      #   24.056 /sec                     ( +-  0.64% )
     8,364,119,898      cycles                           #    3.869 GHz                      ( +-  0.11% )  (62.48%)
    19,996,521,678      instructions                     #    2.39  insn per cycle           ( +-  0.01% )  (74.98%)
     4,302,068,252      branches                         #    1.990 G/sec                    ( +-  0.00% )  (74.98%)
        15,135,694      branch-misses                    #    0.35% of all branches          ( +-  0.16% )  (74.99%)
     4,714,694,841      L1-dcache-loads                  #    2.181 G/sec                    ( +-  0.01% )  (74.99%)
        66,407,857      L1-dcache-load-misses            #    1.41% of all L1-dcache accesses  ( +-  1.50% )  (75.01%)
             6,785      LLC-loads                        #    3.139 K/sec                    ( +- 12.49% )  (50.03%)
             3,235      LLC-load-misses                  #   41.29% of all LL-cache accesses  ( +-  6.08% )  (50.01%)

           2.16213 +- 0.00288 seconds time elapsed  ( +-  0.13% )

perf stat numbers for each getpid() iteration:

		  baseline      baseline 
                   audit=0       audit=1 

  cycles               283           836 
  instructions         417          1999 
  IPC                 1.47          2.39 
  branches              89           430 
  branch-misses       0.50          1.51 
  L1-loads             123           471 
  L1-load-misses        ~0          ~6.6*

  * the L1-load-misses are largely stable for runs across a single
    boot, but vary across boots due to vagaries of the SLAB allocator.

baseline audit=1 spends a significant amount of time executing in audit
code and incurs a new branch-miss and a few new L1-load-misses. Also
note that computed audit-only IPC is 2.86 so the baseline is not
ill-performant code.

Patches
==

Patch 1 "audit: cache ctx->major in audit_filter_syscall()", caches
ctx->major in a local variable. This gets rid of a persistent entry
from L1-dcache  (audit_context::major) that had similar alignment
constraints as a potentially busy cache-set (audit_entry::list) and
allows some of the error checking in audit_in_mask() to be hoisted out
of the loop.

Patch 2: "audit: annotate branch direction for audit_in_mask()", so
the compiler can pessimize the call to audit_filter_rules().

Patch 3, "audit: unify audit_filter_{uring(),inode_name(),syscall()}"
centralizes this logic in a common function.

with these changes:

 Performance counter stats for 'bin/getpid' (3 runs):

          1,750.21 msec task-clock                       #    0.994 CPUs utilized            ( +-  0.45% )
                 3      context-switches                 #    1.705 /sec                     ( +- 11.11% )
                 0      cpu-migrations                   #    0.000 /sec
                52      page-faults                      #   29.548 /sec                     ( +-  0.64% )
     6,770,976,590      cycles                           #    3.848 GHz                      ( +-  0.40% )  (27.74%)
    16,588,372,024      instructions                     #    2.44  insn per cycle           ( +-  0.03% )  (33.34%)
     4,322,555,829      branches                         #    2.456 G/sec                    ( +-  0.02% )  (33.40%)
         2,803,286      branch-misses                    #    0.06% of all branches          ( +- 26.45% )  (33.46%)
     4,449,426,336      L1-dcache-loads                  #    2.528 G/sec                    ( +-  0.01% )  (27.71%)
        63,612,108      L1-dcache-load-misses            #    1.43% of all L1-dcache accesses  ( +-  0.50% )  (27.71%)
             6,123      LLC-loads                        #    3.479 K/sec                    ( +-  8.68% )  (27.71%)
             1,890      LLC-load-misses                  #   26.69% of all LL-cache accesses  ( +- 46.99% )  (27.71%)

           1.76033 +- 0.00791 seconds time elapsed  ( +-  0.45% )

And, overall getpid() latency numbers (aggregated over 12 boots for each):
                Min     Mean    Median    Max         pstdev
                (ns)    (ns)      (ns)    (ns)

 baseline     201.30   216.14   216.22  228.46      (+- 1.45%)
 patch1       196.63   207.86   206.60  230.98      (+- 3.92%)
 patch1-2     173.11   182.51   179.65  202.09      (+- 4.34%)
 patch1-3     162.11   175.26   173.71  190.56      (+- 4.33%)

This gives a reasonable speedup. My testing was on Intel Skylake, but I
suspect this should translate to other archs as well (especially on less
wide architectures.)

Please review.

Thanks
Ankur

Ankur Arora (3):
  audit: cache ctx->major in audit_filter_syscall()
  audit: annotate branch direction for audit_in_mask()
  audit: unify audit_filter_{uring(),inode_name(),syscall()}

 kernel/auditsc.c | 86 +++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 41 deletions(-)

-- 
2.31.1

