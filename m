Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F0A6BF3C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjCQVWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCQVWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:22:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A72C6DB7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:22:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HKf69G014642;
        Fri, 17 Mar 2023 21:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=lEFD23QmTLYYK8yQVsZjvDDMz2M6TsVx+IjtH4pAOEY=;
 b=xUBT7aQO4FOwCNXucJquHJztzdLWhRW93O0jNFwrcg7N5Y/kMGVhZkVGa/7ZOg8pohBb
 4rtHtwKrZDHYRoyDYiElKG+kUAoqU8dUtmEK0cG8ej/NwLU2xgtVA+x3BPzzSRa6bAAE
 WQvCPP62F9oLus/+nyAHdyW/Aa4QE88BCwrI+If37k8/pgx/BQb8cqbPL/xU0C5v7kJl
 AD+YZSfqZgBGKOmu+iKgOAEvevK6QYJY0m4z3DS1QGWZ3lGwpjkgKy2nQLSjeH2bcvNV
 1gnnd913drgFnSKSe5dFmTZo2ZhVokW/xX/uHM7+A3+ChsyrMsiW/xdsoMfeKLdGlnPi Kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29vscm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HLLeZh015579;
        Fri, 17 Mar 2023 21:21:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pcu2uc461-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1m2vmcpu+RWeTgQMFIbpbTl/iuUZJRLVA+wS9iwZegoUQzZMLiPpRq76icivr0wSCDz6hkG/wWzLKvga0q6gTCzd5obH7WTCQdFRN1IXE0uRmUWSkevAuFakEM3T/v3zRrYOiLjI6o4HTBEN5igk8B9c5mIzrKdw5AIQ2p8C43n48qyIaOSitnhZBDQ5zLNSVYbj8eN5NOMvf4Egakg6sh6rMO8Pu1dCT24VXrdOPbgquW138xmNRD2XJ4M7jRq1BkM9QeYVXG3J08kvJ0T9JGk2roV+1ZlU4kX/nwR8VHlShI7GHDhzvbp3hQ2TewalU9I8Bd+XkbWcsBWmVAm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEFD23QmTLYYK8yQVsZjvDDMz2M6TsVx+IjtH4pAOEY=;
 b=DF6cEG7wDiEhODcKQ/mM5AM/NZGOlmdGxJs8nCoK9o3wX8OLKJrdvcek3n0MAc8sisWzfyrvcYj+johsKe1AUpWEgZa+Klpq0GjcoNNKbUGx3/xpQVGGzYQKIoamH3Q9dmJ3xv2OuuL8faWxV0Wjrug4UydHuApraYH/l277H4Bp4hYQlSmMBCnMQnNg3hlyNX9mRR9zqlvU7lSD7EtELlkHM477oB2jQETgedsJ3Jxobqqes6N3/AepRPMBgTRMhTfdUOhZVz4+JsBpYqgjPnVsaQtxjY+ujmQ4U9YL6O6iBkdrT9dqfgs8fv9QxgpnGkl+t6G205xEP5TSh04aLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEFD23QmTLYYK8yQVsZjvDDMz2M6TsVx+IjtH4pAOEY=;
 b=p+sDKTNx4FHrr05mdoVuSrgc/OfZ+9mVaTnsTTHhq2ekR8dS2tvFsorrt2/ZXoCrqpUGD2Wp82I8MwmoTj9IHC0x25r9gag4PaKqTWkCx+z6+2DPFNDY+yUTdoB+eHbVoHnm4YCztEfH83eHthj2LWhvhCOx2AhHXLq2oy4Yc/E=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB7483.namprd10.prod.outlook.com (2603:10b6:610:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 21:21:42 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 21:21:42 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v20 1/8] crash: move a few code bits to setup support of crash hotplug
Date:   Fri, 17 Mar 2023 17:21:22 -0400
Message-Id: <20230317212128.21424-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230317212128.21424-1-eric.devolder@oracle.com>
References: <20230317212128.21424-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::30) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e562a8-87fc-4a24-b02c-08db272d9a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdZeykuIp8T7Gl6Op67drQbJy16LsvuJ8JAH2I1S6IJ2V5tFgWEWgVnJAmcQgGGMWmmQk+o5y+/Lk8pN7S2xjLxTxan+td5kLW1tM/YTGMdVB80MGN8XNP62kZinZjwM45TECxUzifNW4zC6ADR31ksMKkBT3PA7Saqp2FifhdU4rLf9Wfg6mL9Jq8C6zJcBq+/+YzBOU7CxKCvJForkRCYKb/1wlqw5L4FDCKQ0uncpMmkExjQ24xN2933IyAd8xzeVaRlvBgZO4RKRh33rJM8oEqPZcPgmyc35Ru73XocJJJCKsC79lh5lRNAO1V6fO5itxLn0RHSP82spb3loMmQTRTspkePSv/eVRDfi2OXEAqDUicAth0UZ4IF0G939tpLKzw0Ryl8kVVVcQpwPqA4fUzCK/G7LuyaIg4if2WtOcDPj6PNJZqz61c3j6idqO1ZGARfwi8bt6dkvARTlJhi41CTgLHNkUyd71Pk8+2i1rYOn+sktMb9HcP6geeoDS7tPUzxF66LjTIZeq9b1qug9nBINWTk7ZdJZUd3jRJCqq/aYwns8lZPiJsREWdVlCSEe1eGDz8yRqF/C/o4b9wBW/bBAVlL0fYBQjltueH/imIZMh1bzmsK3uj1g9Vq4MUKoLHohKu8QzrzEe5CnQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199018)(86362001)(36756003)(38100700002)(2906002)(41300700001)(66556008)(66946007)(4326008)(8936002)(478600001)(66476007)(6486002)(2616005)(5660300002)(83380400001)(30864003)(8676002)(107886003)(7416002)(186003)(1076003)(26005)(316002)(6506007)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wmydCeBvfa8V8s/KdY1VAEtZb/07ESKtPA6d9l3bsb7UhpO94kZyhN8w7B8K?=
 =?us-ascii?Q?PZebD3nC0IMJwGKbi6NViS96SL7mjwDj/TDhE0OisOPJIVSEAJc/9aMBMW7i?=
 =?us-ascii?Q?sGvelLB0iUrO0w2qLkmsui1L8+Ix7vQFupNxw97UWkOqviGMKkGSTkKR5fmW?=
 =?us-ascii?Q?qrmpM+Itb9dWjT1vRRYOPNB+EmiIXNJHhnKIZ0UshsuTKMO5Kt7KyRsu1YN5?=
 =?us-ascii?Q?LIJUIlUyJ9u1omNM3LxO3mW4Jwj1Jijz4olAIl2S7ezy9KfsTqO3g6dnanPv?=
 =?us-ascii?Q?oxy90F9Pi79S1/QLRrwpVLhfL1tvTRiNW30xbLUDZQzzA49aSLAEvFGjbsSZ?=
 =?us-ascii?Q?FlQJKUu5t54Ci0n/Es7d2qorZZjAvZfsQYko0rhuV9Tz+9hTspCs1xnaeNEk?=
 =?us-ascii?Q?ovpe1Sx5FhLLGoCES6Xvcic5q2qLBySr2HyC6w0KUioRN3XgxCirKe2eFD8n?=
 =?us-ascii?Q?P3dQzRXjVVHhGcXQU2vu2girKLMnH2+kaMTfwHrGOE2/coX2MJCEflEIQNiI?=
 =?us-ascii?Q?Muk7sG9uQcyg54YDXhPj8qhfYguBf8AmN4zCDtJZNl3+3G8eVtM/zbBCTAub?=
 =?us-ascii?Q?EGEHO7fg5Ho1D9TV4fhJ3ZLyOUxrzxPKO09InNTVtLxbZuxFqw0D7DaMfr1U?=
 =?us-ascii?Q?ApIwF5HcfDurEgZgUJz0kzMrL45Lc8IcLh/m5nB0awH/Bp0HI06u/AMV3RTi?=
 =?us-ascii?Q?HD5WXKmppb2ljgLf1k5CHxJLPh+i+E8O0m8OpfbtK2P8KXEmTBPkp2yCiPWJ?=
 =?us-ascii?Q?YK1JMrULjlR7jRT+xWbACzSc58jGo2rIsN8W7lbeVoSJRTQHcGrmSqkLlkP8?=
 =?us-ascii?Q?MTDBToI2+8PpmYOz+qHmaE3KA8yy74LU61zPpum+HmS48ilL8VBubcEMyt8V?=
 =?us-ascii?Q?m3sUILNEFlw4i5baQ+c8nQSefLl3sQlWctQLYb9kVBx2qji+abmIVwqq0Mgu?=
 =?us-ascii?Q?nSXGwy8x0EapVpKqMl4gQL67biC0TuOAfeGIilCwQVTeXsWNlgFSrhZ1Q8e2?=
 =?us-ascii?Q?4ffcNF52qGZed6a7Ei8hlVhF2MyQY3cZE9ZcXcV7tHRMDkdJtg098YcpAjWE?=
 =?us-ascii?Q?hIQhxikb5o5gvFWL1Vn8UyujyxqnDiBC3P5TOOOe5fK5SgK+Ul6QKkiujFPH?=
 =?us-ascii?Q?wkZKO1QyJ7pRLeBFiopedi3QqN1Ql6J+mtPkRiivbss1HzpCeHlgNkVENAeI?=
 =?us-ascii?Q?gllQ3cdbG4NNNsxS87OqqyoMhmvH4wfvdaowpiVNnVeAhL8hR9EBaON7+np8?=
 =?us-ascii?Q?Jo6dIE6jBtmMdNd+lRlK+K+Bs/tySbHf1lcWW9MLaEQv8X+xzshmUbaZYJj2?=
 =?us-ascii?Q?bi7mIdP7L6CpLVhXwfUOIZb9nIX1Jl7ej7w+tLXeF+xjX8Lga4w+dJSTlfw3?=
 =?us-ascii?Q?K1vIUWAjBBCKLA9bP3rws7obZ05hyc0ye4PbuItwus8KTU0MhPu9w/htC14J?=
 =?us-ascii?Q?HqlZbPw5pyVlX+mk83Ik+bVWMlEX69nVTUj5zQ8VYrA5n5XoTcYoWnBKK4Yv?=
 =?us-ascii?Q?+O6LyBZQFDRz/oDaEbTLkaHEiey7+hgPm8uOweDOOFhhLyvcMRAfL8W9uuKS?=
 =?us-ascii?Q?Q/hfw43LDErh76S8XQG2cG+5axxc7IkGDTQyDtaSFaCnthGmI4nXqzlepPU5?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZtEPqu0h+Em/PxM1v92GM/SXT4BPyGrtmCTnlgxen+i+w/Idez1hN8ZBin71?=
 =?us-ascii?Q?EtaWFHW4Ev29708HZw9iAcHmrHaUp+nk5GaLY4vNysZj/x48TMQ4t375qMsw?=
 =?us-ascii?Q?w8/gX6ISkYiv6qLFst2OD1bjk1iEsy69DPMcRAwuDGzxNtgFDF4GDQYjJsFp?=
 =?us-ascii?Q?F5xwgZ8zvqX9xsUxApzWqrGxkXhF2ILwKFi4kAy4P2rO2sv1gUYRbA7B2N2C?=
 =?us-ascii?Q?hVu1VzA5JiO3Zz1OxRFRwE4h6BhvXOrNa7iIDNG690LyJMzvJwCa7CMl3B9K?=
 =?us-ascii?Q?NrRuzC9bq26bWG/TJ8peWCmf4J68HiBNSi8Rva/elcBJ+owRyBRNhZbgPE5h?=
 =?us-ascii?Q?NX+UjXUfaNiWRuQtfEwie3Tq8cAKfsogjVxTQf3okaacAMNqdtxxzdFc6bdl?=
 =?us-ascii?Q?2kKYQVy5Sg1AOfRYzI4Vxfxid+xQx0ugOnw+g0a4ujcDSYoq+Zyq2Yx+rWlm?=
 =?us-ascii?Q?SMtu6711qGxbGRKcroPgBT49qmFVO1CViRNjyRqBOA6A4n0u6ExNoP9MUqpr?=
 =?us-ascii?Q?HpEWQYr9mV9hZ9570Ox7cetp/IpcW3ftXcyPO/mX0p6NprFFe1wSRy5mBA6Q?=
 =?us-ascii?Q?a7nUhrvdiDliYp/n3u3KM6B3votaTbVZCcXvh6B8N1Aq+6BF/gQWt+6EVg7G?=
 =?us-ascii?Q?PKTMoS1JjaqkLdMhJSld+ME6NGs3NzQO2cOlWZ/k1/NBeA7OX11EL9g2k+9p?=
 =?us-ascii?Q?GRvljzJfv9yS1WS4dL9NZef6piPSekS5WEEV1NfIE17rGr8WS/aREyvOr3kP?=
 =?us-ascii?Q?Ei8eGSONZtT/bMWUEzrnZoAK2TgkfeWxD6R7NJF6HDfhmKM+j4S1Und2IS7n?=
 =?us-ascii?Q?/j43lkYgCh4WFu6VfPuUp6h2RIHuG5btbGxSnL3YeqZSgShe0rchfV0ZvF2d?=
 =?us-ascii?Q?Dm4AUwq7lKyk04PPd6WJVh3b1/0vsN8zRQDX6q35Jg1x27ws4H+g+gdW4sMk?=
 =?us-ascii?Q?nC6oet47GzoJDLubBZpYk62xPTXW6TK12HiH9kbPg9m6s3T7C94hEMAutcGG?=
 =?us-ascii?Q?0Ej1HjqEsmCvp2Es0Zj6q1cNEHFstFTmDHXQpaRkFm5SxSyzaaUkgo7yyYm4?=
 =?us-ascii?Q?bSLKeq/o6BuBHhAOP4BACM/Yedb/5kGzP24hh3FI0YqjgTVrds/DDC8NDw5I?=
 =?us-ascii?Q?eg60YNrKIQ0DREexyF4pmHNX0vEg5DAbj+4sjv8KSq6ZHYkKs9Hl1YE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e562a8-87fc-4a24-b02c-08db272d9a84
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 21:21:42.6673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHNbhj4y+f4pZPSIZbQw6zeoGJ3ArI4VyxuwTlVp2nW8QfmdBSlpMP16ULIJhu6RTySSJ6oQZc1796gu2IJKoZTcKMTUexVu1cU5OlKby10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170150
X-Proofpoint-GUID: Eo9MuTX3IfEr4WLvdBimCSVDltD_mQdC
X-Proofpoint-ORIG-GUID: Eo9MuTX3IfEr4WLvdBimCSVDltD_mQdC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash hotplug support leans on the work for the kexec_file_load()
syscall. To also support the kexec_load() syscall, a few bits of code
need to be move outside of CONFIG_KEXEC_FILE. As such, these bits are
moved out of kexec_file.c and into a common location crash_core.c.

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 include/linux/kexec.h |  30 +++----
 kernel/crash_core.c   | 182 ++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   | 181 -----------------------------------------
 3 files changed, 197 insertions(+), 196 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6883c5922701..61443f8395f7 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -105,6 +105,21 @@ struct compat_kexec_segment {
 };
 #endif
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[];
+};
+
+extern int crash_exclude_mem_range(struct crash_mem *mem,
+				   unsigned long long mstart,
+				   unsigned long long mend);
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+				       void **addr, unsigned long *sz);
+
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
 	/*
@@ -238,21 +253,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[];
-};
-
-extern int crash_exclude_mem_range(struct crash_mem *mem,
-				   unsigned long long mstart,
-				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
-
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 755f5f08ab38..45d241aebe3d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,187 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
+int crash_exclude_mem_range(struct crash_mem *mem,
+			    unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end, p_start, p_end;
+	struct range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			p_start = start;
+		if (mend > end)
+			p_end = end;
+
+		/* Found completely overlapping range */
+		if (p_start == start && p_end == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (p_start > start && p_end < end) {
+			/* Split original range */
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
+			temp_range.end = end;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
+		else
+			mem->ranges[i].start = p_end + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == mem->max_nr_ranges - 1)
+		return -ENOMEM;
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..0b560064579e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1138,184 +1138,3 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	return 0;
 }
 #endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
-
-int crash_exclude_mem_range(struct crash_mem *mem,
-			    unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-		p_start = mstart;
-		p_end = mend;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			p_start = start;
-		if (mend > end)
-			p_end = end;
-
-		/* Found completely overlapping range */
-		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
-			/* Split original range */
-			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
-		} else if (p_start != start)
-			mem->ranges[i].end = p_start - 1;
-		else
-			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1

