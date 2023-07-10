Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECCA74DE18
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjGJTWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGJTWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:22:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9ECF2;
        Mon, 10 Jul 2023 12:22:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ADMOit002924;
        Mon, 10 Jul 2023 19:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ZpC617bWKiv0G22jkK0jpEqAzHr+wVAxtMhBwJIg8YM=;
 b=TBLhbDKHNXg7B7V8wIKmMS+l0LyqF4NwAXEfanYDJQHtPHEoxATrXQGicZkntpsX7q2l
 1hcw5ZZYXUHbQeKa7/iW4fOOG7yamQmhe4qnDHeMolt4H3f5O9dK5ddjpoNFRaxRkGAH
 1JZOuhAGPRk2UaXBNZYhsNbZS1TDkiYowzY3A2pef6NF/A99NHILKv3en62xQgBGExgR
 8ugBcFscYAT7s8Cv190zYkT/NeaZOctkNV0VJJV7Inf77rnNBpbDOXr9MTW9nvl6DiEJ
 reU4iCeMdByQsOBjAu4rVmpVuWtkacHYtl06HKXvgp9lYk9b08w59Tz0wh/IAc3+LcIY kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr8xuhrp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 19:21:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36AJGPZZ030911;
        Mon, 10 Jul 2023 19:21:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rqd2852dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 19:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INfe6eWlmKg5KvSO459Bwko34/2K6HlswSpJbp0LSVnyk5BNkayOQeKz11I26+s2tUnU0RZG9VcUkrhU3dSu9llDl09eutG8RKyNp0UPZl5wqMeBA8YN3L5JSHOnwGMKelszwD3azkDJ+I5Pmj01n4Sqd9WLr3mNXVSTIcpBkOWBr5l19er8VaL5TLxs2kLcGn7keTcZYpTMOslXnc84Zgc/egA42ASmvC1NSwQBX+AdJzcNEhdyfurc4HlD4n9qlG5Gs+XhhTtHTcUWjtZrpdXYjzmyrx8cec1QtX4A4XtQ0ByeOIVB8KC+lClT/JyGwzFU4RbHKKSb7E3ZGCrT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpC617bWKiv0G22jkK0jpEqAzHr+wVAxtMhBwJIg8YM=;
 b=KaVLKz1OWS+90Dm3zejm9wKYdZfN562PB8n3iVM81+I8JS5QEeJC+08bJ8+9JgkxhZOlfWaGFizGKok23lXc0qdJYVMR1atuCRnn0CMDHw4lN2jOhEzqbfz34yChhTpknv0IE1RrNskbyayABJPjnKs9Pv8rjEXa8EqZI6sIr4RcIGk5+Yy/98J6i5D9LXLDrphpG54Mhby4SVJOi0qzLeTDxF3QdvxX1J0AXI0av+vcUBv4q9YQFhgYWISg1B/TcGsASA4b+ijVA45qMyRxRCgjA8yDlDZ46i53RszZoGElhhKrgfysO3fi2uYC4sRLDAz3A8j4DDNEGUEsjgzUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpC617bWKiv0G22jkK0jpEqAzHr+wVAxtMhBwJIg8YM=;
 b=zBTO8wh3XMNIvb0HkHEk19VFbqT++L8JnGUC4TQqRJv8eKGfsNL/QwFfJ70XeFzn3TVYnAl4SltCoSfWIHLaxsfQUb8JTU6ulYb8ibRj2+iGnn9BAQm2WjPTnJzDzE94z59tq3pzu7Ay414aTA74y891lGj7OE/tn3ZND1XZBuA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7332.namprd10.prod.outlook.com (2603:10b6:610:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 19:21:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 19:21:54 +0000
Date:   Mon, 10 Jul 2023 15:21:50 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, akpm@linux-foundation.org, david@fries.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        zbr@ioremap.net, brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v8 5/6] connector/cn_proc: Allow non-root users access
Message-ID: <20230710192150.vzb66clppgvifj6v@revolver>
References: <20230708021512.3929237-1-anjali.k.kulkarni@oracle.com>
 <20230708021512.3929237-6-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708021512.3929237-6-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a28c8c7-86c4-4639-01eb-08db817aebe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwgHkKzNVIoKR3141ooo5HWImDgguRmI3vkMrXJRCKZVfuT1dz1SCGhO7r0ZNpATV2My9nRuqa4pewzGJLSILTAf2HCsExV82xbmwCY7z5mdoHtrs5I86hG+S8nd+KhHlxeyAJxD4auEeNRArgAz5lnFPCRs5fyKYkOEI98VPLWiKZZwgLWRArau2xW3mYGzcoYPFwOITRT6QIGmMZV92Zn5hhKeiAl3s788u6mNU9GKj2NmdrsJzgndcG5zmDoIKFwyE8UnGvfanDOfHLJI3nEem/aOA+s2ww2pXdusDjFRZw1thQHOTYjDNUdjKA6k8aKASfJqiQNxRaOSbVn5q/+MI0m6qqRxy1zi2HMc7FbOdH5TaHOoUxIP6LtmHHbW9Ny/7ztl5l7Au0W5QF37tJ1zzS0tRks03Pw0PPK6WZ4eaZREJPYf/kavN7YTWs1iqWDjx2ZmkccPvEyF2sq+J9vBoF2QwL/ezejYJrzCjLyNhpr9JlVnrioD9DXhjc22iZR9+aPrd6TVMuezeMMdM9N7SFVoSqyuBtGo5E7SjgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(26005)(83380400001)(2906002)(6666004)(966005)(6486002)(9686003)(6512007)(478600001)(186003)(86362001)(1076003)(33716001)(38100700002)(6506007)(66946007)(4326008)(6636002)(41300700001)(7416002)(316002)(6862004)(8936002)(8676002)(5660300002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qq+WgGt1H/aW0s21vgQsiz/CJxnBNbfBnLjuddsvuDm34S3/Vmc5FYS6XGVx?=
 =?us-ascii?Q?35BPSl48E06M+l8v/Mv8i5JAR6tXKQFc2SWIxptjPdcYbxGVPip75Tv0l/kh?=
 =?us-ascii?Q?99CXJvoyZpX+1jdlRb3YZwhmT8/4qRH8uOkXnjzA8GzHh06r+KqtaD2NX/0r?=
 =?us-ascii?Q?hAR0DzhRoXEOSOrXYf+qjcaLVAUStdopC46CNGG6NQpz0bXtP1ScJ6fRcrfV?=
 =?us-ascii?Q?gW/BSm/U1542chtmmTA+YAnDCW/juBVAHK3bBSwJ0B7pw+KepGDlpiTQbehD?=
 =?us-ascii?Q?XOi5mcp6XXPMcgOCvTCwvOQmFlbqHKLmftf0//emtAgxrAiRr+9niUUGdfys?=
 =?us-ascii?Q?mHq3caS+AEQ01kCkc5d+ZupBJoCxtfP1rwo8dPvcccB1TmNpgq5UXe6HLFpl?=
 =?us-ascii?Q?tao/fklax6hPR7EFJf/H0jjTrCw5Z3ubnwWmBAzkj1zqJPMPUakhj6zJlxXf?=
 =?us-ascii?Q?0gascw+PZUeZ7luVYorNVgftRAi773AxceDUf8zrabG/1tlylQk4d7TTKxh9?=
 =?us-ascii?Q?jYjqzX9jBR7jgpvqgO4UeO3iKkLZ2Z5f9r8oWpQQ9Pu394zzujZ3U8saB6iS?=
 =?us-ascii?Q?ABpTn5Lb7ftTy8HQdXVA57i6TkAa7TEyVLlYqvaIfMkaGAtEpZzOO6jXrazM?=
 =?us-ascii?Q?LUE6XvSnaUn57BsOn04sIBWjvowC5izq8z9lFdUoQX7RFJoGeBsfOzNwSUG0?=
 =?us-ascii?Q?LO783h7+JlxLH4I321Yi94DkJKo++Vo7iNgtxK6C+6tnw9LvJo49IYnSDXES?=
 =?us-ascii?Q?qpGtfr5vgdiSqFs5wO3GKwrlsZY8U4z9hvAWPDQVyVZ2HxQHaJ8ykfjTdGM2?=
 =?us-ascii?Q?LXfUm2dy+2TeNblJN75GJjBhp0k+/t9N00AdXB2Q9an2o8tuRU4e/Xjv7sGU?=
 =?us-ascii?Q?LvGqGXXM6z4lkgXMUtgH0+S8P1QjOce4OGjSPW5jfUs/P9iOCguDKN5auoV4?=
 =?us-ascii?Q?6t7IubEBoR6R/R6jdg/PVOAIpAPMLr9EUxXCkJu6LGGZOhyixrvm9BnYS/HK?=
 =?us-ascii?Q?Lz7QoKEBV+J1TBe3jhuVtdB431epxUEQ5MAdMFvuDpFyTxRJ39E00q04z3/a?=
 =?us-ascii?Q?pbIzNpnXHmTsUPVqs2avc6EUZWPx79uhdkxCyTBA/DzNQf3bpmM8y5f8kqfo?=
 =?us-ascii?Q?4VfnJaJ3z968uGio/5+3I5zbD7gAGZ7kQHCnLJuQOXFa160Mi23MtZIgeiis?=
 =?us-ascii?Q?BtiC5oRVlm742UkQVZ29lGo4bBMv2MwqTnPlZiduiia8F73//rkEmp3v6hRY?=
 =?us-ascii?Q?mG9eeNQKToBAYASi2oFco5OcGYpXsVlL26aHIlo+zDQEseWnT3bvpFxZBXYG?=
 =?us-ascii?Q?t3wXfvE1ZpnaApyOGkXJ6oXWACyGYTdlBJ4OLXmoOJ/G0s/bbaSil+nvG/LA?=
 =?us-ascii?Q?TcDYSphU761GSx9o40zGDAe+DDzaeUmGpdwVan2lhMibaXQfuKLwXvqQGaGs?=
 =?us-ascii?Q?XLYgOGFQvE35LYsQyKbMuVJHBKo3PEVf0mJnc+w6VOsuWDLDSR2sIXEZV1Ib?=
 =?us-ascii?Q?ofBdlX8fl3FA3O81tQM9jdlKPUZmJW5MqC7aBY2wSRPZEvgQNUmN/5qngbSp?=
 =?us-ascii?Q?xCIQXU6H+nZX6vNj/6Ik+IqXzye20jqolMQnahk4Plp1Beo/BIuykeI1RFlu?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?16OWR/1An+AxwksKAoYycZgRUhLW47Jtytr6k6QEuLk/wDmHJwCVh30s4imH?=
 =?us-ascii?Q?/WSlHoWfrAF6YSDPZ+as/+LgEZy7CPRM91L3+HFgQCtWZSVojqm7etWVv/Kd?=
 =?us-ascii?Q?xH94xpZZyce2fqPE5GGMjkdp1QLW0wTAHMCo06W0NWnmWsI1ajeSs/LDiZfb?=
 =?us-ascii?Q?FQnj7CyyfBUA7x2kRVTQWoP86CrhHbx/U8rS6xlXMniBCM9fA6rFh+C1dT9v?=
 =?us-ascii?Q?pevAW5uKle/IkiYs3ut3hlnqD3f+daBLijW9hK3vxKkD5bkM1NLXT/Onqix6?=
 =?us-ascii?Q?csGWD4iKKz1RPwl7HuhLeqqfLgRh3ueGNIXjln2uI0G2Y2W64AcIDEWuearm?=
 =?us-ascii?Q?jSCgvb8Rm1z/KZUluAvFJDcLhOHH1uX5bV8IIecl91BUMh6iE39w8SzpYna1?=
 =?us-ascii?Q?1m/GyX4wC714B1zcsuKVL9TH6LGgCUnLSZfgo0q1ony7iHfJtFU9J5lGneIn?=
 =?us-ascii?Q?ljjpF/VWgd7bKT6wLdTKPy646I8DIU3iODDxef6DUYqylw+7gXwQzDST1gWT?=
 =?us-ascii?Q?WZg7dlEKfx5Gioi6E32e4UMgv9RYraJe3RR22DOKPsktiDhdUqHAJlJ6KMyi?=
 =?us-ascii?Q?fMxa4jhGHoQ0iF9SBy//UVvum0IscZB3ScRkPbJCzv7YxjWhxTGQpeel++OS?=
 =?us-ascii?Q?dHcYIU19zTzKQMCW6ZJXTGj7rUIOiPT7ozDrCKSf9esGuQtIUCFwhO6vk0+d?=
 =?us-ascii?Q?3C3T51wrnhqxhiOPO0KCLCzJZp99EUeXx5rL7e/34mI+znU9poFGgJAL7yFf?=
 =?us-ascii?Q?RnVqvspXIiIZPXXYGASoTdN06pQODpx/M37PYSnCRsa/Zitd29bJb1o7eK38?=
 =?us-ascii?Q?i+LauibefdfAy23yHnJP5GMadxf7bmKg4htYhng22VsVnAgI73HqsyakjCgI?=
 =?us-ascii?Q?BzpIXZ9kUvk4WCt0C3U+9nEeQWVe8ZFCSNN8LVSBXUJk4LLKgw53u8AmVJ/+?=
 =?us-ascii?Q?OB4NTXltrkS06YrVWhQFfXnqAILI8B6Z0lu47rlZwXnWHqP4sgA/A/zbVdJM?=
 =?us-ascii?Q?Vvp9cySYXVToNQcighE6VSR3HWnRIQ6UVdwP3QcKKQSDnD2yDfTbT3mqoZ7W?=
 =?us-ascii?Q?qiPf6cwCnV70tCOtV0r6dNtcDUIM1x1q+v4LTpgq4Z3plAxRU5pu1Hw6IGJ0?=
 =?us-ascii?Q?xXWvsdc+fSMu1KzNVdtC+hRpV3y2H1Uf9NA0RnUzUuVZgeN8fRHpcOE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a28c8c7-86c4-4639-01eb-08db817aebe2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:21:54.9053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00wmHOeTC0b/J+g5zkexfNfsh17eQAeIq0KAf8tUVUxFEb9frRvzZMcWoSXqx2doZ+U3LntmjkBcbaXfOWhndg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_14,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100175
X-Proofpoint-GUID: x0n1mThuQwLdRCufg0HJaqbxwJUdiRH0
X-Proofpoint-ORIG-GUID: x0n1mThuQwLdRCufg0HJaqbxwJUdiRH0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [230707 22:15]:
> There were a couple of reasons for not allowing non-root users access
> initially  - one is there was some point no proper receive buffer
> management in place for netlink multicast. But that should be long
> fixed. See link below for more context.
> 
> Second is that some of the messages may contain data that is root only. But
> this should be handled with a finer granularity, which is being done at the
> protocol layer.  The only problematic protocols are nf_queue and the
> firewall netlink. Hence, this restriction for non-root access was relaxed
> for NETLINK_ROUTE initially:
> https://lore.kernel.org/all/20020612013101.A22399@wotan.suse.de/
> 
> This restriction has also been removed for following protocols:
> NETLINK_KOBJECT_UEVENT, NETLINK_AUDIT, NETLINK_SOCK_DIAG,
> NETLINK_GENERIC, NETLINK_SELINUX.
> 
> Since process connector messages are not sensitive (process fork, exit
> notifications etc.), and anyone can read /proc data, we can allow non-root
> access here. However, since process event notification is not the only
> consumer of NETLINK_CONNECTOR, we can make this change even more
> fine grained than the protocol level, by checking for multicast group
> within the protocol.
> 
> Allow non-root access for NETLINK_CONNECTOR via NL_CFG_F_NONROOT_RECV
> but add new bind function cn_bind(), which allows non-root access only
> for CN_IDX_PROC multicast group.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>

Thanks, looks good!

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  drivers/connector/cn_proc.c   |  6 ------
>  drivers/connector/connector.c | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index dfc84d44f804..05d562e9c8b1 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -410,12 +410,6 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  	    !task_is_in_init_pid_ns(current))
>  		return;
>  
> -	/* Can only change if privileged. */
> -	if (!__netlink_ns_capable(nsp, &init_user_ns, CAP_NET_ADMIN)) {
> -		err = EPERM;
> -		goto out;
> -	}
> -
>  	if (msg->len == sizeof(*pinput)) {
>  		pinput = (struct proc_input *)msg->data;
>  		mc_op = pinput->mcast_op;
> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> index d1179df2b0ba..7f7b94f616a6 100644
> --- a/drivers/connector/connector.c
> +++ b/drivers/connector/connector.c
> @@ -166,6 +166,23 @@ static int cn_call_callback(struct sk_buff *skb)
>  	return err;
>  }
>  
> +/*
> + * Allow non-root access for NETLINK_CONNECTOR family having CN_IDX_PROC
> + * multicast group.
> + */
> +static int cn_bind(struct net *net, int group)
> +{
> +	unsigned long groups = (unsigned long) group;
> +
> +	if (ns_capable(net->user_ns, CAP_NET_ADMIN))
> +		return 0;
> +
> +	if (test_bit(CN_IDX_PROC - 1, &groups))
> +		return 0;
> +
> +	return -EPERM;
> +}
> +
>  static void cn_release(struct sock *sk, unsigned long *groups)
>  {
>  	if (groups && test_bit(CN_IDX_PROC - 1, groups)) {
> @@ -261,6 +278,8 @@ static int cn_init(void)
>  	struct netlink_kernel_cfg cfg = {
>  		.groups	= CN_NETLINK_USERS + 0xf,
>  		.input	= cn_rx_skb,
> +		.flags  = NL_CFG_F_NONROOT_RECV,
> +		.bind   = cn_bind,
>  		.release = cn_release,
>  	};
>  
> -- 
> 2.41.0
> 
