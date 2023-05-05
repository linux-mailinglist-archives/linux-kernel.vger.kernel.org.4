Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024516F8653
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjEEQBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjEEQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:01:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3B160B8;
        Fri,  5 May 2023 09:01:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345EY3bT013324;
        Fri, 5 May 2023 16:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=8xwruN0+315OngySGcvhUL/NMMzDCnzsnG0Rh0AYNzY=;
 b=l6lIFjkEL5X8JT8Llm0lqb2mGcTngNvQEd73noYqbwZ83/KbNlM02v7R6fwjDfLWQCJP
 hKu2hzOi9jN6Rqz89LtQtjJVnmu1OUczmY79lu+5UAMhv1l16b0+CiYaP6IhBNNW9jci
 mIIw2H2zowE7HTTlJLQQ/SRN3oSr6XIVbyfMhwGlDg12stncK/C9ewCbxlTmO6gn7UCA
 NtjGumhxRZU8z5TWAjv7Wk/y4jkFcsJ3iPhHZubb6C7ShuviRekckUBECOFYHivwQyZt
 FFzLFyxy6RISaLHCfRxXUxKYm7K9IWELbGPCi93BYcaNDq8HLBzTRK3cQ1Jo/sgGebgy Vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sned6xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 16:00:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345Fe9lc009943;
        Fri, 5 May 2023 16:00:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spaj3gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 16:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBFMLlfPE33m2QEeCletugwO4ydmJAZ5scSBew5etFZqGUARbN+U/GGkOgJMSNgm6PPweb2xEdgfTyV/9brIw+j5Khmnt5MYJ1+pWnRjv6YV7cDuXwGQyc/pkp8+jfBHAzcd93I7nuzYhzUqPDin0BAeNB8E2ccyjH6b9VfOsvfVm1f9R9nrtnpdIqX7tiqpz4r42w3Ym07GssNnhUwMoJAir3a9PRP5D3GdUIoxBVIf69kCC6g2iViP/f1ySwHjzAESAUffJ1fa7HTGxz7sQkIT47aPFawVRlQkV1pAptF4f5dzKhDMhbfMwEUxafaw/mnhqpknIRZ0z+FNUXesIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xwruN0+315OngySGcvhUL/NMMzDCnzsnG0Rh0AYNzY=;
 b=I/bhT6YA8+5jCOCNGtiMVkiamqQLN/wwbRreEdgyeC6oooHqg5/6SdHVRNsplXIxU0Zdb05wScgvKChuhA2AfhMgxf60bfAOVQGyhPiLw50A6nsrEF7Tu+wW7sA0QvVcgOT93UmjV43PW8wVlFisQEfnm1GLnH074AdEUO093Iv3vAQx0znJ7nbdFJSQu1y6DARUHMGP5vaFxfqznXgDaaWOx3/KSRzKm43KU1vQmaUHYjzAKAVq4/wEMhN/oGYSQ0JT83z6HHZaYb1xm+VyDw50MgM5yQROd873SKT3Q6Zic2SWAeVx0YCQfcC64Cxt3ar2yKXUwijQjzZMGqoUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xwruN0+315OngySGcvhUL/NMMzDCnzsnG0Rh0AYNzY=;
 b=QtEyV43FIddRNlnuvWmTwUCaH4iCx859ifi5wFzrX9NQPteBU0kJwUMGVVkK+VSPjEeMW8nIoSrObjD+BhCfITDdvCJeMd3YSCykrbEAi2HwdVTYDl0bMJAONH7eb4hnk/rufWMI20MUEGfzJltq2ICUWCIIGhHS3RyErogwn5c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW5PR10MB5665.namprd10.prod.outlook.com (2603:10b6:303:19a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 16:00:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 16:00:50 +0000
Date:   Fri, 5 May 2023 12:00:47 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tad <support@spotco.us>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        Stable@vger.kernel.org
Subject: Re: [PATCH v2] maple_tree: Make maple state reusable after
 mas_empty_area()
Message-ID: <20230505160047.zn7l4dvvihv2qc2e@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tad <support@spotco.us>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        Stable@vger.kernel.org
References: <20230505145829.74574-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505145829.74574-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW5PR10MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da3467b-9ebf-40e4-202d-08db4d81e5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hp9369wuKtE3z4Xe19Wi6xtsjzKPmtHeYVndNEpy751coQFVqIc+SM40O8THb386hC7d9lCC0I8I+hFbddn5pHTFDuYDbXVIcUfb73oO+Z3NMa/zMEKht6hYwjSf7jNgDVrOOAuL7ZUuTktsa2rF3EyCCyRTDkU0zc6kibjfapl1MKcCAcSsb9hwqOsylJFzVgoKYgAZlnKDXPy3SpICxVdefEG6w6lr/eQ4mj5zKrrfqb+Xu1q+GG+vx4DuXpg7Sv9JsDGQJAdqkYohr2K005KXzEWphU2DY1UmZw7PoLILJGDbjuhwHiVgLnhNu5+ip2OTdyDFvY8AHc2ImZjVAGI4h0erXjdjZZA4dnmoW3ooI1+ZDEC2eXotWfs5a88ocPGt4FAtzehTcj1JaWbPcozwl7IXsIajGMN3tnsmuHOx/hfAZRlk/AuMosPH3jS5ChEwi4R+EkW/CZtwC4LB38EGGcRoxRkRcvCNNm0NR32F5PbM0VzASihR5BOrwnWULEUvXHQ2S/+nba5hB1R/VIjPcekHzrZjQLSODEXfRbQUR+r0FAb5TMymi+W8XpTwbSEnxEsY3VhVE+/pI+Fj4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199021)(5660300002)(8936002)(8676002)(966005)(6916009)(6666004)(6486002)(316002)(86362001)(33716001)(41300700001)(4326008)(66476007)(66556008)(66946007)(478600001)(38100700002)(2906002)(54906003)(6512007)(1076003)(26005)(9686003)(6506007)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TY+1Wuw4kyCCdN4xeH3Wpj/tqbNNu0TrYofa0UHsn+V/v1hAuLgziH5D4Vm+?=
 =?us-ascii?Q?eoxL0DDseLTP7yrIjnjFBJgJ34R4RWUtMYEqdgttOwE2vop3MSYxHDMIw5gv?=
 =?us-ascii?Q?XtRYtDo3Lm1PLGNMcuWyQF6ogBB9eI9LTAnl961xj3MMT/IN/WnPl9brgafq?=
 =?us-ascii?Q?6tP+3LFZiRkDCJQzD1+A6Qhqck48CON6K4LgkwejiRuT7I8oK63CSniaWmil?=
 =?us-ascii?Q?Hijvq6zASZQGzsCL1UrIk6SknXv34dWJ/K8dymZUKzk/eY6B/QavZvsHkTvE?=
 =?us-ascii?Q?iCDXkvgCADNUwaWiExER/fn1pC82bo1OpypA8rTG+h+++5YDpgETEZMwOVua?=
 =?us-ascii?Q?mhK2+y029YcBFRHo7MKmonORUu/DxclnKo234gb9t5eOv6xQPjO/0HVERXqZ?=
 =?us-ascii?Q?S8KdGnyXBh+laGPjpZOvHd56vLarni/8A9S13fqLqUm2RUssl+beaMibjFk2?=
 =?us-ascii?Q?s4UXK9uv8kcIFVCmxSt/IVQf109FDLMLyAyjPoaoBXDH2pvSZRQnuqt+Pm35?=
 =?us-ascii?Q?0B8brusU+zCcPlv8awbgQmInBRnvZdE6GCU4Izfpr5ELo83RlF3IiyoCW7L5?=
 =?us-ascii?Q?nSonE8cPzzHsEqyL4sCaRXqcctJF/KiMk1/100YlpdTRzQ/pCMDNxs5rFtU9?=
 =?us-ascii?Q?/PbnH0WkuImOFqwXDfhmQMJaw0bA6YkTv4K9hUEdAcIrIAE+5NwGQEyfW+kk?=
 =?us-ascii?Q?IUChYsnDXHHl1cmGgenrRKG2Da2VOLdbu5QpmXizLSXcbbr84Bq6r6RfOKOk?=
 =?us-ascii?Q?IXJ0gL3boQV/Fkho4/FoHiczvPLKgbBjIA40PpxzIIWTvXJuTczhAP4RpkQ1?=
 =?us-ascii?Q?C1zv+6qKzgMIjwcVqk8EgLN0iPI+iphL739Ae4zEX4MCynyE4OTtD45FSQq1?=
 =?us-ascii?Q?2lonedhaRepVbxJTXPIxqHUn5urruPlvujFJu0SZXgRykOCtlZzuelNNHcqO?=
 =?us-ascii?Q?ie5JUiHjWR2ec0/nBXDiNmhqQUCTWxzIX2OzBJUyVNV5hPz3TLWF8Iuxp6Bo?=
 =?us-ascii?Q?8+ukkvljoU3U8qfOdkZd0JX6XymG7dxM+bveuwb9VZmgISiBaWixuIb4fBCO?=
 =?us-ascii?Q?d+NMV5NzXyMcfzK5/IwN/8QeA0aq3yYsM89qnWP5VAamTnOw/hGe3JcbexPU?=
 =?us-ascii?Q?GSw4WcydbZlcNvBVbW/fmnriE5RGWRClWavKvoOxCYk37FdiPJ+kp0d/E3Yl?=
 =?us-ascii?Q?X3nw2rciLRZP3UYyG9YXrs+Z62Jra8PqB4b4k30kS1Xj/k54f0F1B3RAGZ/w?=
 =?us-ascii?Q?0xmgq5Pye8GhkcMy9LcaH8qomnBUTygMq3rsTMYoEI53I9GRRVxzBA25E/Y3?=
 =?us-ascii?Q?5X1YGxe1LBFxP+5PiUOR9r53lesxQJGbUw494pRLtQ7MTFlqjaGitWVal+0h?=
 =?us-ascii?Q?loja6SVd+VpvEkL8uIuCSt6+AZgri06WZb6mrz8W9uDASQK26byJ8zAALCS7?=
 =?us-ascii?Q?iDB35cOepD9snea+e1cBfdi4EC89chtj4a+Wu2VDuVLwWnCVFVcSWrr3BQLv?=
 =?us-ascii?Q?clF/McEY0TiMBPLy0kCbReuLWuqH1/JuraTTzWrrndGbWLzlhOeehDn8ecIQ?=
 =?us-ascii?Q?stx/VP/pu7Ih0t6hAp2x3od8TbZo9IgeDpDPM2omVWVMqq2nY/PaVBYpOYCl?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HyM3/VTBv0tD/ZfhlJw2suY6wV3/H9EoPjWZsEkB7NWGeNP3HHDcTAUCkYuS?=
 =?us-ascii?Q?2M3KnR4N5zkJDrai6scb+ezuqTGYGHFal11qb5FahfNWIhS8xru6bUIel43v?=
 =?us-ascii?Q?a291UwsTglFT0zY7WwXQWBMEEtZTQxzByFqtHGhKJA7gejt9XVu3MqULXptb?=
 =?us-ascii?Q?QSMKncW1esNgOvo1JiAa4cM50IHYFjIVr4R8y5wOr1VDDjr197r9q9QUX1Ph?=
 =?us-ascii?Q?Hm1CxjU3bUTBemBvspPvA+QLyI9Q2BOvu64Vuf3myaC2cWo9Ml/pZFm0qbwO?=
 =?us-ascii?Q?GE+/mF8YxRPRD4moyM5PiqFlxZeOA3zCLuoFqFPnOA5Mr2Sn+bEEHOekmGus?=
 =?us-ascii?Q?17JdWsuwQQ/EQPM3PbfM4lTKK1EzYzTgG/byzu+Xjpbju/lmwM8dkw/aeZV0?=
 =?us-ascii?Q?oERSAbYcwps8+gyaE5tRQHDJB4YI1OmX0M+8BJmbuLfWlNcHvnsRIyacAGlY?=
 =?us-ascii?Q?jrCklDMKa0zpb6Ui+FhV7NiScQ3I3pVN5Y+uAY8BQu6NIuP9Y5t4quWt/nTD?=
 =?us-ascii?Q?Y8PNSABemeOq1rXyVr2eZOmqiFQ2PtaOHN0RTE3UwHEQzbVWgxHUKADlKlC2?=
 =?us-ascii?Q?IN809k5jFun/1aJg/8r08OJRn7yTmbjYAU9NCbqJb7fk0mCB95ZvDbVnDR8S?=
 =?us-ascii?Q?NxlYKKaqJWBrJYM7wVoXrTRG4YURpiRf9y6Oc2IiJmYJ2zbFUv/DlWjd4e1+?=
 =?us-ascii?Q?UIqiGh+hjB0kQTQEn5xE8WoRzUfxc2UvxbKrYmAoJ/PWj6pjVfKwIGJLRTYI?=
 =?us-ascii?Q?K+YqdFhpN6czzIZUE79RDGzrcON/fvm/51lgDpZA262zRnf7IH+ODX2TRi26?=
 =?us-ascii?Q?x5G26lJFM1oK3eess2EqqpXJ6OJnfwnb6O3fveZOv4qqMEXO4sOTZJPbJGHH?=
 =?us-ascii?Q?njqbjJjq4kNPNoMXHoBhee2xEatEqfB1tqKB79ZtNwT7UbALAzDHACiYu7LI?=
 =?us-ascii?Q?98FnU3W2JTAxpNhhq76y71gHWMCZrOeDFfdr/Xl69CHS9HNetYRE48JIROco?=
 =?us-ascii?Q?1wyoGFtqIfTqWNtIM7Re6a7/INJICxd/aw8Tx9fwZPQ+YNU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da3467b-9ebf-40e4-202d-08db4d81e5d3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 16:00:50.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d69716NCNHy5y5ImoiNBFYNT4wbDG5UK8ndOo+WvZzm0TuQ4xLt7FfubzoOeRhRMq+rGuc+FjhM9G2L0kB5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_23,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050133
X-Proofpoint-GUID: fkHTub6URS0wf5zRvXwx04OGQSONJeyh
X-Proofpoint-ORIG-GUID: fkHTub6URS0wf5zRvXwx04OGQSONJeyh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230505 10:59]:
> Make mas->min and mas->max point to a node range instead of a leaf entry
> range. This allows mas to still be usable after mas_empty_area() returns.
> Users would get unexpected results from other operations on the maple
> state after calling the affected function.
> 
> Reported-by: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
> Reported-by: Tad <support@spotco.us>
> Reported-by: Michael Keyes <mgkeyes@vigovproductions.net>
> Link: https://lore.kernel.org/linux-mm/32f156ba80010fd97dbaf0a0cdfc84366608624d.camel@intel.com/
> Link: https://lore.kernel.org/linux-mm/e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us/
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 110a36479dced..8ebc43d4cc8c5 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5317,15 +5317,9 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
>  
>  	mt = mte_node_type(mas->node);
>  	pivots = ma_pivots(mas_mn(mas), mt);
> -	if (offset)
> -		mas->min = pivots[offset - 1] + 1;
> -
> -	if (offset < mt_pivots[mt])
> -		mas->max = pivots[offset];
> -
> -	if (mas->index < mas->min)
> -		mas->index = mas->min;
> -
> +	min = mas_safe_min(mas, pivots, offset);
> +	if (mas->index < min)
> +		mas->index = min;
>  	mas->last = mas->index + size - 1;
>  	return 0;
>  }
> -- 
> 2.20.1
> 
