Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F836D3CD9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjDCFYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjDCFXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:23:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D893A99
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:23:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332NIh1B013542;
        Mon, 3 Apr 2023 05:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=AWtO26WrUxcC8Dr9AfFmU8r0+3TZoPF8bVvYSgph62Q=;
 b=QzWiclfTa84OJnoMiqC/7ngDJfU7OilahzGorX6/iDroF+VOt9o5E7YvMa0voGN9GMGi
 L/T5pVXsk7jDRfAs7svSsRk7spEwhTQFau+963l3607okU487LO2MlMNcIqeid/QU+z1
 JIAipmHfsYHs8URW3bpfWRiu2GNX8IT78Gb2nICU7cJLQBTPET8ijOcuhWy89YwgmqiJ
 GaelT/lv+yXyj+22lS1X1citlyXcHod7ULtxhQgX+WrIQVy6d75z3/GB/mMeHtkmX43g
 vGQd0ImiCp3A6cAsFjE7cP5HpE5c8fnv8GK7sJjkIv+N2ALnV8OES7PI1C20nQaIC4+V xQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcgaj5a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3332i7pt013932;
        Mon, 3 Apr 2023 05:22:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3djuqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMfTjRopugbMrhSsq/HHWJBSJZik/77H9g6QRhukxMC6LFF5yXoM6dkaDhJBX+3CkJtQ7TrzImxT6D6QeN1lPrni9zrpdXN+jbevC8kAg0jmWgw7k2X5IWjf3jnQnTGr/51Ap6iqVgEhDNnbbnhJyoSknL4UXc4UpXKOkCVe4b/eTpDtVBvqU63bhDeb9YNqMz6w5d/jcwV0vtRjlMMfnG8cKbhmmhXGQidA8vixZZJZEa+pmqBxMfWGW4H1gw0CFcJysCGvFy9E+CivKfp92KBsNZuRLVVhvS7wZKKWEJnc+EZHSgCDzvv46S5HpDPdcYxcWV/IkEyc6hqLYZ5+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWtO26WrUxcC8Dr9AfFmU8r0+3TZoPF8bVvYSgph62Q=;
 b=fpG7HBxAZfSNIkJ23oXjW8pfBDsAos6ZuomHiV3sgcsGHdvuPyqbuiVgNfFloS7Hyv34uLNInFhbYMVxYz4+DNEG4rSQrG51yPpjg20NH/6QGETJOVlL5FRIZb0kc8JFIHX78IvBNN1EpGYhq5SNyZ/sxo7GvHo/10Vn2M2S43qgsjiVc1TyCUo9XSjq9PQQzcjW6u6KC/f6PU+AGi2OB065AWblwpSmYGvpxazSFyCaJT21oCR60Bst8kWSzOSH1kTw00NVdlFAn2IiRqbIYLYTUMPX1birWvpyxi4GmEW8wG4Hsij9Nu7tto9t3bdeezeetfr8BTjIVXCqXRFyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWtO26WrUxcC8Dr9AfFmU8r0+3TZoPF8bVvYSgph62Q=;
 b=pc5h1iDO5I63MTP/JVPka1qQH1fKok4RVjVA60P+OIRd7FyTXOAlx5KDtGE1ooBdQzg880bOxouff4eRuD5IB2IdLVINdht+W/suw6OhBNdx8cckUIppCxX4ntmfeGyZJqaZR3WgeIIi9FZJ2QU13TuIJybzKbjvzEkh3dGyiQg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 05:22:45 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 05:22:45 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH 7/9] sched: define TIF_ALLOW_RESCHED
Date:   Sun,  2 Apr 2023 22:22:31 -0700
Message-Id: <20230403052233.1880567-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:303:8d::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 0187daa4-2b8a-47ea-8b48-08db340372f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+2pEnKRx9o049wD/LZjcRBZ5dXhBClqW6Shrj5mkMgFH/k2q6ngnOXQKb7FtFuMSSNO1In8SUP693EX4t+kl/1xHdXBvGqkGrsZmlgnzA0zSm6TGbMHf/S6/SDxYHqrwoMkVwY/wx8thwDWtg1A7YZlMg818SO1ttX44/7KYfMS2YeM4uaCO+wPSVWsFegPV1rLysE4oDM4Qwsqh3qMyVZDuhy7CT3wWyRD1Hur6hb+LGo3VlZIW9ybe7GVaIs6SWXhBGr3mH32eQRDGCtQdcTbzzOJvxXFOitwQmeezuvQGoEIbOKw7QbghRm1VWU7X2vO2NPlxkDJrQCRezyjslVb/SGrxwjiTdxNsVHL2rpaovryQROCol8+K3ixyUuH1SQJh2omXaSqlyCLQSs+PY3cVvoPctamXrNZER+prq36KY2TTZhDeDnQ8WfLRZOL1QZTvb+E8Bod58GvDNhgXXSeeqsbPjAOaFNWaJQmL3qhIuK/YbgJFxoNvwfi/mrtilrhsfoP3z3bsr3eQcXxjRJnFZ4PnoL1CDLT/xeT5x1Kdje/mJHkQ9za4OHGZ8Pd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(86362001)(36756003)(103116003)(2906002)(2616005)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(107886003)(6666004)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(5660300002)(7416002)(38100700002)(316002)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ahJtsEbR0Pu035xSPsiACxf6wPqKzntHhxV8lwYFiKOJ5IXr7E3AwfLMJCJ+?=
 =?us-ascii?Q?kD5ILdKgds1RrLPz4pca2iteRIzAxmCKACDLf7bsLn74fffJqKInGBId2mmg?=
 =?us-ascii?Q?cXwhOK4cg6dvJ8Q1Z2Thd3x99lymP1mu3U+vRuwuzqysWUQJY8L0CFDpG9zL?=
 =?us-ascii?Q?MnvtHphNvXhu6lc75UmDaGBDo/h7FQeWv0OKKFp5NemLeo55/2Uhv128LExD?=
 =?us-ascii?Q?WyyVlKAS0JX+4DadL/3g8/ultQ5Nr80NO/I6E31N5i45QBC8KaI52Kc73Z4z?=
 =?us-ascii?Q?xjfyjjt5aPOS9WXusKpCiYNJmmFeZ5EXeBFARu5MNMWeKjsEpp6rnctQjsKi?=
 =?us-ascii?Q?xYeOSbCzsjivtv/FkcP4gf5w80BuKzGqjtL98xfTSGS1U9LXwLtq1zbnf0Cs?=
 =?us-ascii?Q?ivCtONCG5ckAsNtqv5dG03yJ0mZhAh2ctgUZaPTyQqqRtQNA5jhNexXOnrNS?=
 =?us-ascii?Q?GRx8WHx5f1930m0u0npTOAc6WnflCeCQk7pKsTZEbbzI7+v3L0sGFq/T6cOj?=
 =?us-ascii?Q?5MbOfRw5O567vSGWkerDpJ0VTxFYNbUEgwgr5LNnPNAVMRfZoOjA9vxwRox9?=
 =?us-ascii?Q?JSIFUpAaKXn1O7m+zrnuDjmU7Gj0hHs6aE7L4cYm6QHqNxaBYrz7B+aIppR/?=
 =?us-ascii?Q?T2nMmL/f9ZZ2ZPnm2V57d1WZLziQlqvM1izLb1pcJXGr/1YhPSWDJ9Hn6e1V?=
 =?us-ascii?Q?AlRua4e23/umZc9IO5WkQ+Ib0h9o13UEcqxyM28eP/q0eIGfCHK9zLR1WGsN?=
 =?us-ascii?Q?iqZMs0/Llb/oMoqv4UVt1CN75XS5lbbuhC+CjdgHlYvwcQ7bff7WuIBOYc48?=
 =?us-ascii?Q?PNJNVMt6Uv0Ir4xa288WrIqTWADdVAXqPgcgicS/6fHrRR/gwTopnxor+Whi?=
 =?us-ascii?Q?3+OIFdJz7shHnlnlg/erYINnKNJAR7Oc89V02mDDK7agTqFLz4vau8PCSWEV?=
 =?us-ascii?Q?G8oVIpLeVSY9XsB+b0M1Kd+L7y0l4B5ySMFI8ULxij1r+CUC258sXurQKqG0?=
 =?us-ascii?Q?/zkk2uMckRvJa4evuDFyTH1XyjAEfCLqV1eUmK19xUl2gjNarNb5I68lWpkL?=
 =?us-ascii?Q?hx/Y5NRjxjCbTuhTz3hb1eKB5qGZk/fsAgeW0zCkAKb9hSGXg46aV7SNKQN2?=
 =?us-ascii?Q?SGIMguc2kruriOcbwW2wXqGSr+jNjCSXowHvfGTeV2Hrw6wyTekFPiFwYZxB?=
 =?us-ascii?Q?QWnBYcDEDumJ+9WyEYl64CSAeKQqq27PX96S6necIp3E3stRrCbg6zNa6jNP?=
 =?us-ascii?Q?7zvQjpWXA9wYS+ur5Zge1oCzIVFabrqtzAAX2HfPW4cSW1aKk9relzp+U1Z9?=
 =?us-ascii?Q?zi6X+leCNqjd45IgMBal0FrOJ8vrCSXPAEZeKWccv4a8M2f7Fb9HOxawJVSH?=
 =?us-ascii?Q?WfYX/gVqCfauk7rdJI5ice4DEGynXw+iEscDnwPzmX9GMtYLpXpfdUI8wHG8?=
 =?us-ascii?Q?fvVkFajEzI5v+dDw8OLOCMhEt4uKXwRwP4sAyK6EYWL3ChofGkDrB2GBc3Vt?=
 =?us-ascii?Q?Fu+dlk67XuHnOI9yApRfofROHoSUJTWxtJK6ZoyQvYEqmTixpl2SQVg+dQlS?=
 =?us-ascii?Q?Kpa4HkId99GyWUkNlUaw+arC8biS4dIav3rKwjiL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3r6ZE2sDejkM8UbH77cxDVrIGoYh+cGi9iyshzrkFpfEcbAwfl9Me7pPIyWW?=
 =?us-ascii?Q?ZZ/I1JIHpyzvQiGnb/IturQjewasADuxN6tKFrZqhuL1rXKqYJMvvqO54Vv0?=
 =?us-ascii?Q?1HuYeHw9v1mS3p3CynkSAnzWjgABRIfQdm7pgLq6PboArgi9bauSun/VWrhV?=
 =?us-ascii?Q?k1qr4GpoGWHEg8kEo8lA3yLaWDX+Z4C2ZaPJYyHGOjXPbF3NvUrOyjk+0GSh?=
 =?us-ascii?Q?QN+2PsXBQVf4y4yvw7iltqT12DEb3Dp5raC4Ckzx9oOvNkK9UcVhkAWMw/A7?=
 =?us-ascii?Q?u2lu+sUStulM+Ij7E7F8KyOekq5Mf2+Hc/tquCL0yqx5KmmxBQmA104R63YL?=
 =?us-ascii?Q?inuXqe0V1EDmttVRKsTyK6+tSYSgzwlOugSxdIsOguPg6PI5bYzXO0cLN4yD?=
 =?us-ascii?Q?0XDubdNxta3YjJlP/y50IY1ys5Sw52oRWJK24pWlXeRlwIs3fUuHKnkTNS4s?=
 =?us-ascii?Q?9FD28/zb2z/VlgHI/vV0TVZELnlSxWnI89vrcbO37ZOXppDGNHBLXMwnVcBh?=
 =?us-ascii?Q?nVwtdhG8iZHl+t6Q5JAPpIH883OhWs+ZA6cwkvmV9g0fg1ljwz1OqN0e6EZJ?=
 =?us-ascii?Q?ANanebwfQe8xMG6Qt+SVLFr0WDdVV+dMSIODOdglfTAj1B4aJtQ0Pf6gAKFa?=
 =?us-ascii?Q?W79hxqt++xtU9w6RSNYh5626h6pZfS81ZIUnPUFf6KULjMKI9+4vGMk9zr4L?=
 =?us-ascii?Q?YnG8YQTLHXLJaik1EKHVLrag3iMHc1UrZMl3w48vnCAngyxljjUrMQYe6gch?=
 =?us-ascii?Q?cxRUgN/PhnzfilydRE2BAIENFjwKoMBl76NUM85px6K0YwIbmZFNW4p+K7dt?=
 =?us-ascii?Q?eu7ZV1pDaXr05PTJ3JvV75U6lywb8vxU0aGQCIdjYRUqUonXRlVkReGw/qZz?=
 =?us-ascii?Q?yGJhRz5TsUDb5iS3U4GbzDgIHtW3swFZ7ho9vSJy6Ls7P4dvfldvrErdXlPx?=
 =?us-ascii?Q?ERhsR9yBnwxklZkaCcts/KDNVs6TowdRLJgtawie3zjIO8I7dx87JNgDbm/C?=
 =?us-ascii?Q?ci6Ub6OtCOxDbKvP68jJx8ZVb1Dp5Sa3lm4DlMdsWE/Ny4P83lW2RAOe78xa?=
 =?us-ascii?Q?fB2aRvH5Jlo909rIID9EJdA8dC51AybwmDtn5VteCXJmP5ec/1O3CqJjs/xK?=
 =?us-ascii?Q?KvGbGkGnGmjWukJolvVpPIsopYFl9Y8fC1D78ex4+WSkQKA6eByvNTc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0187daa4-2b8a-47ea-8b48-08db340372f9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:22:45.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H02fg1kyYkymzqYus/XlB3WnUpEHO0gj3BRTGe3t9rTYEGIfgBgvzuwIjlyrWRV5JaeGqodX5vMi6AG69uauyrbUGbThIjkeWKF4QojsDlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_02,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=627 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030039
X-Proofpoint-GUID: 3n25f6C0Vp3I69V4G6C_LKVTj8U4YkXk
X-Proofpoint-ORIG-GUID: 3n25f6C0Vp3I69V4G6C_LKVTj8U4YkXk
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define TIF_ALLOW_RESCHED to allow threads to mark themselves as allowing
rescheduling in the irqexit path with PREEMPTION_NONE/_VOLUNTARY.

This is meant to be used for long running tasks where it is
not convenient to periodically call cond_resched().

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/thread_info.h |  2 ++
 include/linux/sched.h              | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index f1cccba52eb9..8c18b9eaeec4 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -100,6 +100,7 @@ struct thread_info {
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
+#define TIF_RESCHED_ALLOW	30	/* can reschedule if needed */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -122,6 +123,7 @@ struct thread_info {
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
+#define _TIF_RESCHED_ALLOW	(1 << TIF_RESCHED_ALLOW)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 63d242164b1a..1e7536e6d9ce 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2229,6 +2229,35 @@ static __always_inline bool need_resched(void)
 	return unlikely(tif_need_resched());
 }
 
+/*
+ * Define this in common code to avoid include hell.
+ */
+static __always_inline bool resched_allowed(void)
+{
+#ifndef TIF_RESCHED_ALLOW
+	return false;
+#else
+	return unlikely(test_tsk_thread_flag(current, TIF_RESCHED_ALLOW));
+#endif
+}
+
+static inline void allow_resched(void)
+{
+	/*
+	 * allow_resched() allows preemption via the irqexit context.
+	 * To ensure that we stick around on the current runqueue,
+	 * disallow migration.
+	 */
+	migrate_disable();
+	set_tsk_thread_flag(current, TIF_RESCHED_ALLOW);
+}
+
+static inline void disallow_resched(void)
+{
+	clear_tsk_thread_flag(current, TIF_RESCHED_ALLOW);
+	migrate_enable();
+}
+
 /*
  * Wrappers for p->thread_info->cpu access. No-op on UP.
  */
-- 
2.31.1

