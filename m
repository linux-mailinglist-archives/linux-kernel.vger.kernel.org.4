Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C8D74B3F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjGGPSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGGPSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:18:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A66AF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:18:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FFliW024733;
        Fri, 7 Jul 2023 15:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Ubiu/DV28QARfNVk2y/X7m09ZBRgrb1DNaZYhPiJw2U=;
 b=b5IAguEXzP4DPZv1+IxsxO76ZjyEy7C4PgbbYCaZ4RMTT/aLsRvloatWqL3OEV9l0Jo9
 bKPAbKr5HyYZQFf+LfIlKBE/aKqu2p/QjGx23amy/NK0fCTM6pwaNpnet73xdmjX/bQa
 InJsAX1nB3BhEc7pr21RYMeHiJmErV8ezSdWvoo9EVUubgNEViEwJ2gerdKRJsZlhj6q
 0F7qhvTwUhccOB+ptSzOYCI5bTdATgYf0FTtcwnvjRbo7VmKnAIYwtaFJ9veZUsnM+5l
 kB0/+osoLN2L+cZV05ohSfFjOkSC7qPYrF0n8ezqtiBXn83GKd5P4MyPWb0I5cpZ/75K BA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpk6ug9q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 15:18:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367DcUfe010324;
        Fri, 7 Jul 2023 15:18:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8j6k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 15:18:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSAeQOa3mjB5RE1LS1LckNVJpoavANBFw0wTuRVXvQANDCHkQgGWfRjIbYG7ljH8ebjOMWd5moAcfN6ugTeyC9Qk/GJzhnJ7Cle5GEJyhnm4tgErWjl0kw4PjAc0t1E/OToC3Ww0GJV3KpvUXg6MuhPEHLOwZaYywz0g9gMFVutkLwnFTlmyoMl+i1obYM6Ev073yTFXvQES4oJyn+/vD4ATQVyaYePSYeo8Du2RFZHEzwYDC+oLsLFy0NUA2150/43xitKxg6M30V7XuiNr4z+GjTzyKZNiwN6nnYIDL9HVls4ZrduTWq5VKxJp+uxPIqNu+RolcqLiMPRmCsJNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubiu/DV28QARfNVk2y/X7m09ZBRgrb1DNaZYhPiJw2U=;
 b=CWz+D+WMP05yIfOGwGJfGuzdpceafspKyq6oM1TyhcezsKjilCtRTItJx3O7XvVfxN+tFnUxlMjHpb6BY4LE6SYz7TZqXVQgTGmpSQtxIJjHqadHxkGE8RNI5rzg2ub7jthc9H61NB+mZOxbZxNLDJK3BDrKLX/GqeUqiXv9878OeTsKSEfXr+xy3QB/Nj2FBXt9B01eKUWg8X25a71xrEgAyNsWUZohAc/YkaDl1YKQcUrIM40I48pJSxZACO9GZ2nG0fIfqftSYGbh2EbkXPCWjYnbAxmthXmYnW8V2GtMGp2hu83GqPft4WkvD2mnMfKQOhRy/cWKPw2R8vQ0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ubiu/DV28QARfNVk2y/X7m09ZBRgrb1DNaZYhPiJw2U=;
 b=VvKplzffbYh7CUhDqtbmhCyFHPmp9+aopQHoVA6hcmmcFGIdonVPZYatc6jl6L+OSnspz+cfrGDf3MCupbOhzPLIYu4oKVGdSocOe/3nOBOxM4qVAXpp6yIZ0ZAWPeCyfegcIkvAk44ZqSfiMUjpqyu3I28d/aVr74gagG2T/sU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7330.namprd10.prod.outlook.com (2603:10b6:610:12f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:18:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 15:18:22 +0000
Date:   Fri, 7 Jul 2023 11:18:19 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [RESEND PATCH 1/8] maple_tree: set the node limit when creating
 a new root node
Message-ID: <20230707151819.d5rvxalhewdv62nb@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
 <20230707101057.29326-2-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707101057.29326-2-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: e291fc54-403f-499f-81f0-08db7efd66ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbyjkHv5r9uimwedjXeK3ZxaSzKvmdWB9wq/zSjb6J9+WanJE7ISRj5zbRcdEXOu5SIUXOGHyFnJdzKVFeee//z62RRY1Xz42w+etsgVb3UKyd6/Mhb1y3PoLqqUlJbpeptYawKkW/LnRadZVdIsjNjOtvootzxJ+6chOIGDk7PCQVUWmYUbOqp4mdBFzQUZaMrOGDNP/iBXPhUA8/hVbS032jiKTmU+DuJhOj2f3d+EUSZRJI8pr0s6LMf5wC8lmU1PSkxwC3c+28Y5j5KHAIacfafiDayDXdFFqo6lj0FVy0EErQdRYZJpT9co2oi6Xcf9vp63Imf27+b3QFZXYMn3BJBYZf96826Zz3yBVVQ2Uee1PmoEppbY1gLIMoFkxx6m+PLR3GqQOM5HT6B4Hgwxm2qp4DdhFAI4R3ixOpDQMSAWhx5bjsPWP99OUXAurbxltvyerdCuhNQvqDntq/CTCj1BLOYFIdBZYovRHxAJUQTOx6SdytbhT92ZcgYtaUHZpd67WE8sH6sr9lBWHvP2cm0JFAAMUVbiaGF9+RlVUgFAyAR1I338byz9ON4R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199021)(41300700001)(4744005)(6486002)(5660300002)(316002)(2906002)(8936002)(8676002)(66556008)(6916009)(4326008)(66476007)(478600001)(33716001)(6666004)(6512007)(186003)(38100700002)(86362001)(66946007)(9686003)(26005)(83380400001)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VxzAqcWVk13OwYmAWo0/fHAxbHs3IsKXyjBW0E5YkwjyVRg2grc7hAnk+m+f?=
 =?us-ascii?Q?yj/WKCa2DZLWek4BA9pdi7TXSg8qNxD3pTNGgAwW1ZUPob08KbXKdCfiJaNv?=
 =?us-ascii?Q?0AbfBd3p6vr7c7O1jupxBW1v6ymS9+AVTLWZEpgils2xIcf5iNMinenymg1w?=
 =?us-ascii?Q?YJP01iA6Mm9TsGl3LqLGPxUQusOlgI3GB5s/9Ho9j3gI96DgxkH96d8keeNJ?=
 =?us-ascii?Q?yALOJU6kQMc6rbhxj7u4doLp7Qiwg2KoAauDqD0dUyK6uCZY6Du/DhxKPron?=
 =?us-ascii?Q?W9spTERRXlVt0cpwbcAG8YVxzqAzbqVx/OTTD8Dw31iJ5iqgyIGiNR5jlWNe?=
 =?us-ascii?Q?pY8nG12VSVyfir9e4HwrDHUoWg0fCRPJ4J5gEOeGBg3wn/JKlR5LakHgJ41/?=
 =?us-ascii?Q?/Gpk03T9o7Z8qWCcoCIfvqsDjhV4azfcBoLn4/RjpKvjbXPEWsmBxNNFYk2+?=
 =?us-ascii?Q?r944gXbgnr/Pmi3tdUJ9mNS5ittAKPruSVrWBpfcuWQDkcTe0GBWmejd0AQC?=
 =?us-ascii?Q?Ngjo+JQC6OYQXsnP07oHYCjbdczqbyr+N7JJAosLdR2QHcAadMDROoO3q1QW?=
 =?us-ascii?Q?UPiC0eaE6hYnODlZAcJfkZZqt0Wa7aIwYScetqE0EanSxSLgrUOMmZyssL5z?=
 =?us-ascii?Q?Q7ZpwfQLtygXctBBD/5zvGkk5DV+yZ4yOOb/IpZgw+6llQelYlJ7jvVJOx5n?=
 =?us-ascii?Q?c7ZWbtCDX5fgvojfnRqz0uys61XRslReY7t3fIbyh7kkeNLZjupz62fk8s5m?=
 =?us-ascii?Q?cFD4qh+skrPGk+xZV7EwW/Su7jxjuDSQniAxpRL9IS0k/4Xphj7qpdFoYmEN?=
 =?us-ascii?Q?wwAN0sckzi2a6L/QSQRYbw+i47BZxGdJnoFsoHnsrlJLim4lM5b87PLGpWmu?=
 =?us-ascii?Q?kcGlqkFNsgMsEstLeKWBTzCbSVoSfnHh5I83i9WR00VqGlyVFx66U9MMmHYr?=
 =?us-ascii?Q?K7Shm62rS5n7D1igqrx4NRoZP6C+1hvZuUO5V7I+i3Vpuuexojt7IINmAcTp?=
 =?us-ascii?Q?2jdJLJciXzcB2v/wKqmEYpo2U8v4KVzfmEG4EnSYLQJO2G7GJaLR+DEgLwhG?=
 =?us-ascii?Q?xFYd1/ddgjSeexhtVJED+l3MqOvfW8h+QVa5zwdD84TuZXpwICukQgzDrPuH?=
 =?us-ascii?Q?JUvDy2UPa+O3MU7+8JsG/ITLO/GajAycI4zwMcSTMnZn9fVvWl+viOka/ndI?=
 =?us-ascii?Q?JV6YfDCOnPzegRawcACsuNX25/fh4aXeJwCpoNMXf1epO+1q/JdL7sRiixJa?=
 =?us-ascii?Q?g3+1/38GizA/lD9gATI5FuJYg1gqNj3fFvFYhBJsqWH0lNKVckcXkbydBqHt?=
 =?us-ascii?Q?4e6PfVpCsDvWvBrMHueusa8qERmSMIO8vRbifiZODZYbAzDwyMpfxbn3hJO5?=
 =?us-ascii?Q?RXsXrNJHpJZeZAIa4YiaNGNo+whj4zLEYlEu/wCDIGgaOwd3Ct+OK3yLutlE?=
 =?us-ascii?Q?dkq1KdgJz/rmyWP3efV1N/aXIoMG6xYIBxBBSI8WPz7nWQ8LFtalohEXfnbD?=
 =?us-ascii?Q?EMeZ4OrFAqx/Eh+rT4VUIOQKQaWc8uaQL7BViBY6cuMmJy9gq3lxFr37I6b3?=
 =?us-ascii?Q?6ZkkrhMhkF6Anul8drsKNR8J7WiMRBCgXqmgUeu+fO19uVbspNcrxpgm/Ehm?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bEAbYz+je8rcfndMTABhDfurxsrbC9LIFO4ejIEPF+n3TJC9f1xP4U6U5N3T?=
 =?us-ascii?Q?zqT5IQwAYK6jcbuhcYAFk5oo8s3fyjFJuOJEBStfT/sPLOoXF4CaJs8ypnrZ?=
 =?us-ascii?Q?Xz19k9o4Jnk1uZ8kUPhN2lXm6JgzrjGV7E2tdwdp+pI11oURAT56/X67karr?=
 =?us-ascii?Q?aHMKX//GyVlT57T8kido9tI6rLadL3cw9PuC/OdUzJO8S9cZtqjIAiEZWLaa?=
 =?us-ascii?Q?Qk+OjuuFwX8jZ3kmOTiUaqvKGJdvdTlynObTi8lBXvH/CE5VDUsTAL+Lq7zh?=
 =?us-ascii?Q?VS9oI7pq4uIi+48J72szT63ngZHoLi+EVduwptBgt6V+qro7OcpEtmGUNtWy?=
 =?us-ascii?Q?eSTrYpHL04t6LfoG992NeGBLTl+9VRVNcpovsBN/yt9Vj3rQ5qgNzoFA1t1h?=
 =?us-ascii?Q?a8ESyNkx51+G878ZXqRB4rWZOxxtbaMfQLrtltom5uxw6DfNykqJhlWo+Rl7?=
 =?us-ascii?Q?+gKWlFuesd9CHZuZxK++jZOhvtIXoMoxjDBYQn4FCGX4SEpOdXPSM3kbuPB/?=
 =?us-ascii?Q?UYbUGkZZhpH/PcFQYQKFzasbXJH6QovnbnWTXQ3/IyvFJIHpeh2YFEE3WNdI?=
 =?us-ascii?Q?/5DgdrqfQibJqCmt0pt6Wp1nhGp5H86sOFUcMdEltGQy+/u+DoGsy08ULvHS?=
 =?us-ascii?Q?8laz2ABcfxFz0x3BtXTyZjMyAOd9cygoU2LkOQ/cc9IyWrSN31EDbKOTeAC5?=
 =?us-ascii?Q?tA3KHqLnPj1lvX5tMILI8UM7y4Fd5zpxAiChbiF+EHfiZ0Chog6P+MqxyhwD?=
 =?us-ascii?Q?89o8v70CY3r6owm2Zm1JH15VvKmcYYCZhctmGWOJ2/2l3Zp/eLHTU6UH/sWi?=
 =?us-ascii?Q?LWP8zL8zwfvd1bpfryQ2KLdKNLNWKhWvWYavByCS07LQE7mSAXtW+f0aDDLK?=
 =?us-ascii?Q?vIFOiiphKA3f8MJv8d9usivv4Pu+XA2vuzc0wU2J9IN0+fAU4oiKRHRktz/w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e291fc54-403f-499f-81f0-08db7efd66ce
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:18:22.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TAqvNShdwclPjoSCOpgwML+wiRBwxMQbo8KFQAYpU0uPOH28UnM4WVDzbH6zeDNN6bSpUAc6DDhXkVZ3R6ZaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070141
X-Proofpoint-ORIG-GUID: bTAU09INGIYfXudDeuNNrpej2cr8Ru-m
X-Proofpoint-GUID: bTAU09INGIYfXudDeuNNrpej2cr8Ru-m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
> Set the node limit of the root node so that the last pivot of all nodes
> is the node limit (if the node is not full).
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

This has been on my list of things to do for a while, thanks.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index d3072858c280..f55e59bd9122 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3692,7 +3692,8 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
>  	mas->offset = slot;
>  	pivots[slot] = mas->last;
>  	if (mas->last != ULONG_MAX)
> -		slot++;
> +		pivots[++slot] = ULONG_MAX;
> +
>  	mas->depth = 1;
>  	mas_set_height(mas);
>  	ma_set_meta(node, maple_leaf_64, 0, slot);
> -- 
> 2.20.1
> 
> 
