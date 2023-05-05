Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164D76F8985
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjEET3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjEET3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:29:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5899E46AD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:29:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhQDL029415;
        Fri, 5 May 2023 19:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=m1XoJINuB/ytX9HW2RZ/pPpctXFsSJN8144oURGWpoM=;
 b=oGJ0V3npRRbOf6wPt7y/svy6sQJvvgMyTM4D5lGoR1gQE2/rvirazEcT1/AgciFYeYnj
 MqrDy56jI8tYLvZYP+9O8EBkrjpAZ2DtODKl5roBWBgeda4KW7HTMIQilkj0S+PorYQY
 wPxGo4S7bPrBL/Ahfo8fIv3IabcwQIAlSL2r8nuPs319jRV86o08+8Ihndx8QCA/+40N
 i+OBwH2lVxw400pz12prAzdncbK/J6/HvD18ts9aCuZadj+fTS0h64YvPqsc5VZ6Yr6C
 lzxUi5NITN13Wlk0Vkosx+8TWN2ztn/GSjT34R1Y1jIC6Kiguk4e9YuSzlROqGCk87LO TA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1wmvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 19:29:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345IXXpn040442;
        Fri, 5 May 2023 19:29:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spaamn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 19:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfSoDtrS3rBi1o2T37uJNCKyOagACVPOvhSfgRy5mPhGdIInvSArPIyTxND8Ven4NMMAFeSRMBObZjjaWkuPbcVkIv2IN/6T6L4gh/hYmPJXw3l57VWdiTNC8rzEWRoqxePzr1D9wKX0g0ok6g5Ob8R0VqOZUr1G2rvBLEuzN1dU7ijnQbeZBSbautShncQm+Z+JKoGqvW2mMDbD3S/v1Bd9Hz4GGRlAgvCsEEJye4ucAWcx9Q3/lpCir8brbKVP8hUsue4hzPUE/6aXiuGqYOpWOEdsjO/oy6Kv1P7NIByRrouAIp7AlKYOj7OZCZHLsN6Z1mzP0/WyKQk1n2D7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1XoJINuB/ytX9HW2RZ/pPpctXFsSJN8144oURGWpoM=;
 b=PvAH1faVT9RFfPRDGajDvspeCpRCq+3a3bzd68mbwOBHgsS0/+AxlFwahrP61KmIctYiZtenlRhCeaonlkFkRdDl1cPXNL0806dSBD5j+uGwwnviEa3ITlxTINfiY/xF4HxYK69Nip1OaQx2DfBU68gTM9sHBeDf5QM0YmZ1USF6ydAVuUXwOMe4sUw02YZa3NV2qpSTxhpMDdGsw+hYp42V4zOo4XLL/Nt7HS+mpdmIrxGxzU6eYBArRv5dVTe4XPLG49H6AW5/BHRmQ2HCVyLBlwOqZ+JTdbqdq/plCqfYu9dBdcKk1mbR7jc4BmY6FTQkIEIYoKsvUIgagjE1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1XoJINuB/ytX9HW2RZ/pPpctXFsSJN8144oURGWpoM=;
 b=iLWN0WP/mKVoEqy3pLQXMjkpuz8AMbshVOP64cbxLkemH05NAt0AahUoXjnki0Py8xx2rELIzJ1anQhnp9ZVXNF4U/TA9ULU7UTsfgNhXUn93juD8C4vycdQmYzzYAqGvZPeMiEvLSGdCIkH/SLA1jwTHzY8F6oOQzgkukGGhjk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ2PR10MB6963.namprd10.prod.outlook.com (2603:10b6:a03:4cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 19:29:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 19:29:32 +0000
Date:   Fri, 5 May 2023 15:29:29 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 36/36] maple_tree: Add gap to check_alloc_rev_range()
 testcase
Message-ID: <20230505192929.52z5qfnvbdhoe627@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
 <20230505174204.2665599-37-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505174204.2665599-37-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::49) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ2PR10MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 17efa4ff-9dd4-4a4a-59ae-08db4d9f0d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sF07Yk1ZqSf+vuULrOd9LkllSTunJLAEcmCn4CHFy8exo09OV7uWWSf4BNUGD9LIXN8MGwm7LVcCtObujzdiDnKDTcotlmofmNIq7YyG1dv3F9DdLcWO8p8pfI4KWi4Nm9LA99OxrtszDByUzvo8Vudov2vwweZzGrT1klm2vJUfMx38xJKquLyJU7wnG0OcUfUFcNcY4OZ29JKezmuTf+DL1BmtIcPHGP376MvdY2reanzPfb+phbiRBm2gqZxfnC6RIwNH4dzLFbIvuXiDSoGCUoQZ/weYGCAC6Z8PrSIVgVoIS1FyOafVruD2KiNNDtykjP6tNhW7qcW8De6TDieP1VExT+JntvLdUxZyz5anGa7Dkng922bSQ8z3vLlDy4ewU4m0GNPhKQ41xu3OKIXqNHLn4NeNnfyJ2dwqtJxomghhnQ9528ERFRCgCjD+ilwDjAWJQOUCKUddEdzkwWgW8BRJ06rcCg2emyn8szm3VsHRDnHRYfWH86btkU9Ne3ZkiImeMKJlp/BpVRTErnmiFZ1q3S4YWmoqFdp/qVPvYdRCv4zrf/iprp8p5lAy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(5660300002)(8676002)(8936002)(6506007)(66556008)(66476007)(66946007)(26005)(6512007)(186003)(1076003)(9686003)(86362001)(41300700001)(83380400001)(478600001)(6666004)(316002)(38100700002)(6486002)(4326008)(6916009)(4744005)(33716001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oSV2z+BMnXcNvwLok4DAXj+OB20dMVRwqyOfcE43nUxcv8Q3y+3IbhJH9gIK?=
 =?us-ascii?Q?Yae+g2FqGpMmrQT09VCPPmLz47K7ZEu0So8dTZ82B8XjcTCuQe0+PvJOTkHA?=
 =?us-ascii?Q?YxrQPHfZsIPbST8MNHRWvbuFpXsIXPrmid6DIDsyJolwWKFACEWU7qVqukRF?=
 =?us-ascii?Q?ka2O8UF8LdjGP2oGNaVxc8QJiqatR0BrMyMZDSSmgRAu+NDbTM3krFIDsy6L?=
 =?us-ascii?Q?dD/UsTw+WRHmUl8zy9c0MEo5HdBW0m9U9/uY5PvwXg5ktFpKnmveSxetBP4D?=
 =?us-ascii?Q?c3rPHfdvyUa2AFhmfDf2gp+s7QZ3N4hrMprT11r02rwG3Gfa4qSBrPQJUCx+?=
 =?us-ascii?Q?6ipAQpAJUfhU1T/CFRUWayRjEgCGvgo6YLNAmE4gs4ZLhX254RC7p2UFrLG6?=
 =?us-ascii?Q?ebkkbBWmU68scN9Wd5GKi4F2/CBe4Tn+N1JK2VcYQWLO1bna6cQJ9jhoylGD?=
 =?us-ascii?Q?P3rhmHN6cVQc9Rk2eHCVAWqrUsYd53JmZ16JLPG6JDtECI65cX/ZxJM/mxlD?=
 =?us-ascii?Q?1yiKXJG6nDXTqbAGy4EdGFin+qEF4V8Qdt3zz5H/prcS5N4nGD8KEXegs/Pv?=
 =?us-ascii?Q?LM0iHvrM1mLQ3uXizk4NklRJkP9QCt40ltXMjDU0+6miIixIk6FqoqfLaGsG?=
 =?us-ascii?Q?tMPA3VgWQ/uO2hySwMRJdRm1rC5PtkcXPOfKoGTu0WpjJzQ7qCR2N8ySy6ox?=
 =?us-ascii?Q?46Xgj3r+62zkqKHqaSJL6sXgCd2uWqY9QUZ/4Mdgs9JOAnDX7KOT4rTkAHM+?=
 =?us-ascii?Q?ipwCvsJ3HMHrKvXXwaL11jlmvYS+7yZtFATeIOL2Q+MJjzJL5ZvS6iYIVzpJ?=
 =?us-ascii?Q?XBLESZsaiplWWp72sY9RffhUbVNTRyecPpdc4YZ/S1Ox3qn4gML8FNDmI3mP?=
 =?us-ascii?Q?63q+OhGakoL7dKC7BgaH/HrPelX+wLGETZwHB9LU7DPoH9ibEbTH1hUxvoUK?=
 =?us-ascii?Q?TDg9ST1M5ldRn967kNp80jm8wMsM3+PdFAOffxBIbweUXRJ1rdP74QA5/8Vk?=
 =?us-ascii?Q?FDXIgKKjISCUxQbI2AiWujasHTmNOq4MbpnigR2MQhzVW/hvK/Q0TeKW+uPH?=
 =?us-ascii?Q?KS9oa/t83cYUUwi7hb4uadTZZ9LLysgM2KcvvVC3EcOVMkmkEu7msy3Py/pQ?=
 =?us-ascii?Q?Mt43B4DXU7XTMQq3JP90Xuftb3F+M5gJFD1L1lBD2FR/ph0XwXdpMTpIXV2S?=
 =?us-ascii?Q?ct1x1o1Kup8kufBY70N9kVuFQdl3B3TV/JPDOKL4p8G7Onv8G6scMkH+o/jc?=
 =?us-ascii?Q?50ksnXnlstIILzKtLGRqmEjTtE6jVamwM6mvZv1kBaWQe30dx2n4DVpnTasj?=
 =?us-ascii?Q?WR5Yih2u1Nd0Do1DegF/gJ8ewR3oahxffdkRmsSqeVFv+SDjdnQ02yUg2Z+/?=
 =?us-ascii?Q?jgLVfrTS/Di8GKnemWqYoquiwFb1PnJCFknpjFyuULYDXjI8OntgDsPhX2ls?=
 =?us-ascii?Q?15AZ353hC9e4L6d7y02qftbTzpf6HbXL6WCGsUhzJrIUF9iWArzixOLDD2YA?=
 =?us-ascii?Q?XagMj3uJq6d2F62ZXq91At6l1J3KB72YaA4UdQJTKFpP45YlSPRFKMUWFpxQ?=
 =?us-ascii?Q?s8FR4DSzJ85m6PM2xJzTkcKf0M74bCG4vbOe/yGpTTLc4c70j6I0fVOyO6WT?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7pePdZ8XJyXQqHhlFDXHbadFXFNDwhVEWSBHrNDBPo4tToujZkA88qKePU8peBAt6HANAqIaE58IcpOjM7MLCHoI97QFzbQnCuenI2Sq3uzODDFysfTl6iLmbkdoC1jsNb153Roz6GjhbLdTGQ+8nfKCuNEm6EL+KSiLrqGS4IY879GtSV+IGDY2dJnEG4KEH5aZ+8eK6gW2aEm7c8fJIA2ZMg/KtV+ECSAI4+N9FFc5GRk2j8UcOHaczos8KjXOBwNOEstadBgAVMHJd9O5dio54c6kngJXgTKeFRT0EumOXawF4huji4HE8pGvTyT5yoE3GW+U8CjaIDbM0LK2SR2MvoJOQwJN959KXZ0mhhdt0/tMX++F/HBtEYCYkmtMjlX0wN36xbxyqeGb/r5cDlgCf7+nTLUJ40kQpvD9oRX053DWERfvFVaW6LlM6SkzR6OTQpBqLMmkpFNYIEBMA4FLS/UqdJ6algB33c32G4bwc14pLSwBcrNOwWObdOwYCHym4Ldq9zkhHS4EoDbOi0zVUZ+sG58ukq6sgSA82qzKDjMSGwxWSjiKHAML4SeTWtn0izBIYDhIUUf4aHG/kCa/cHiR4kFsS30TDQPhTkd/vOI9N/woUAKdBjP7HQx9M1W+1j68r+MpnFDejQ7T8ycMexpyb/BEk+7kT0ws0xlASwSXCdiEGhTgT9XRc2eANHwFHbdj5zjDrMagGAtNLP7Fx61d5FBPkzCRLhK4UflOMcR/CEVxHuMA0jtZVqu9p2Cc+B0Qh4mflD3eK0Xyt+MdU48zcp7Zkw1SM7Zk3uTZ51/wUpVAVdDhwRnMk4TLTECSC2GcMwPxKcD/X4nhfilfBpOQprLIFnwCtSWSVMl7IeD/prLCYT0iX2YT9aBmTAI3Cg5Zor41bDsOGtIWdg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17efa4ff-9dd4-4a4a-59ae-08db4d9f0d46
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 19:29:32.2396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8H27mytTDXrVqsFATOTtgUa8S4iP0VW7hKY0a+DIv2RoTnm6hvp0QUtdrI58QsW6ajvuoeTroQ1+Wis7hOLRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_25,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050160
X-Proofpoint-GUID: Wv0Ku3-_ERFu72jatpUXnfasqVCvg5fG
X-Proofpoint-ORIG-GUID: Wv0Ku3-_ERFu72jatpUXnfasqVCvg5fG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, I meant to squash this into patch 0025 "maple_tree: Revise limit
checks in mas_empty_area{_rev}()" of this series.

Apologies for the lack of commit message.

* Liam R. Howlett <Liam.Howlett@oracle.com> [230505 13:45]:
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  lib/test_maple_tree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index aa3c4fb9175ed..9939be34e516e 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -804,6 +804,7 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
>  
>  	mt_set_non_kernel(1);
>  	mtree_erase(mt, 34148798727); /* create a deleted range. */
> +	mtree_erase(mt, 34148798725);
>  	check_mtree_alloc_rrange(mt, 0, 34359052173, 210253414,
>  			34148798725, 0, mt);
>  
> -- 
> 2.39.2
> 
