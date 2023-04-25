Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C2A6EE63E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjDYRAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjDYRAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:00:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEF2A3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:00:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFxdol026308;
        Tue, 25 Apr 2023 17:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Tflh53qIFtZJBHVvMAE3nP5IxoOa2/zakFOEzBRUurw=;
 b=tshShbYNJoig1NJiBL3aa9PV7lEPfBJBgntBU6lMmuAFHZq8CIbpkJnMFLXwfuQhic9c
 awRRTnWrFBiQ4WVwJyIHUPOt3P3aeyQXTCKRTWpbpULK1OpWOG6VVJ2GRP9QcOSpvYv8
 8E34tqQq5oPjDqGCmBMMTKa7M+gsf2UkZ97sry1vFcVVa7RsTUet3XuxsQXBpz9IpMRD
 9Gli79b1TMVZDoRpSNGqe/S11BOEXQ80P4Fqu4Vxh2nX9FN1CshLmC3SynL02F9enkAt
 vBj6GtCAzWz058q18UjkXVOEvAsHlBvdQu8NJrYhfGKjf7yGUV9+f6VKPeEHOwMy6Glk yQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484upc2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 17:00:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PGL8wU008530;
        Tue, 25 Apr 2023 17:00:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616y8ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 17:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIpNkMFpRwz7P7JAKp+a0FKc1u+E9LdoKLbEIzb7cN6sIzlQT3N4ZG2CO8gpCvLylVbZVb8cB7FvtGtNAWW1trCaKKhxTRV/P5+qVE1rHWHpxHJas3LnOUoi+2NsGoFPJKRPbJ4Kv+MtNagH1+LhnKgnbt0Djr1rwg/Ooc4vUhTb2pTLCh4+8KqWoJLyCaNaPccBNfpLJtyZwddwD1J3HrVHuERdwB/ib9cWLaf4V3O0sDFJYNBJ7TJFsLH0RjG3bA3hsA7PO6ieoWbmBN2hCqrif7L2nN4J6wQy8vpfxFq1UCjwLRId9YxOyPbg421sC2eb4NRTc3WOqkKR3vi8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tflh53qIFtZJBHVvMAE3nP5IxoOa2/zakFOEzBRUurw=;
 b=n4JGMZ/Dy1z5ibLakkKSiYqrqZbZxH2bh21zDHusCqEt+8he93Y3lqs31y/1YXpuZ7rr+P5pD74D9nZ7h2v2BF5xhViUO6Q1Ro6o/3ZVeIIGUK42M5RhZcIi5u9ct9VfgIm51oH17FuQRxSl59pOf7FNoUeQz7a/bRzjS8NuN0JRe3qCnCfJ7XAbA3EfEyJXHjjoM3A0mvfyhkfqXS+J7j1tBhtugnBMt3dKvrXhjufYsLPlMRll0OONwjQ7GCb2crKCRJbl9+20V475VGchIX6WsviPDTL4B1zwoejiQvw2RZ3R1k5E541e0BGeEZSkh+ecIrMTA80Ifhx4AvH8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tflh53qIFtZJBHVvMAE3nP5IxoOa2/zakFOEzBRUurw=;
 b=oRaGGDlnT/9K8NaoLM/YPYDLzmbA0COSEYu32vJjUKBs9BaqLo+WD4nnbPxYaLLrqSBeb7anj7nJysvZr44lyrku9rV6b5/Hj/b2bHPWGHW5t3R5EUp8FfVdtrdgvGSuRXFbskDCR8zP/SFsujZEHgLZiKxhg8FTJEUL8ABCl1M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB7624.namprd10.prod.outlook.com (2603:10b6:208:491::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Tue, 25 Apr
 2023 17:00:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 17:00:06 +0000
Date:   Tue, 25 Apr 2023 13:00:03 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 8/9] maple_tree: Remove the redundant check of
 mas->offset in mas_empty_area/area_rev()
Message-ID: <20230425170003.5tbz2urecd4yjrhc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
 <20230425110511.11680-9-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425110511.11680-9-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a12ecf-9787-4ac4-2480-08db45ae84ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bbk/sk6FE0Agp2OTIK+IBBWHyC8MRy0T5nmYkzyMtTJKn7qFkAQtMIKguHyBWWEaJ6Ii9GeiopuPy2fViNpZulaSYDva3RszLxbDf3e+z5jXGqvLumzogLgd6ZhcNTvQh7EOMVdF7GdWwCH9dx04A+3+GRoTO/SYaXh2gaq8iqPDAJyLbh1OGeAO30XiMltJ2YO1d7QJKyv1xeSjIKux5gejNDXtYqRpmRycWp9+crW/edgkGmK1L8vTIsPoLQYVEuSuxQAgT+COIlVsYaRqTB/5IDvSihmNQCjgJ48zyUXOgxjzmHeEHMdDdYjgpiZJNyuiDh9pta0DQLSoxLzcCZi5oZPofPOWU+Qp818zZAMmiHcyiS9zhWQa4r6HOvYlTVFN8J0lHFgGRW+l5Txgcbo8N9R/D8YlCUu+USaJygaBMUMbJT9+xz4fV6yfs9aZToT3R3P0+kPEq+uM7r62Q0e6rJOZOeHd7ORcw8kgRhNYr0iy2AZnCHX1Foj1etp5L3hc9yWANDUswpR9lwguW6XjKA8BZWUQ78Yyu0iKWsgt68etnFRzTLzsaNjgoEXz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(5660300002)(8936002)(8676002)(316002)(38100700002)(66946007)(41300700001)(86362001)(6916009)(66476007)(66556008)(4326008)(2906002)(83380400001)(186003)(9686003)(6512007)(6506007)(1076003)(26005)(33716001)(6486002)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2vzOZaaYHWWxLkARg9VIWr735c5K4DJOemR4tNX3PjdlAS+3K31lluT94/MU?=
 =?us-ascii?Q?wC+VUzjqVcKz2I94ryx3Mq/QCx5M8KAqiN1l+G9yuiDSLuVMBB7j5CjUte20?=
 =?us-ascii?Q?1GrLGxaC0EVunnvppg7iJDoLH4vC051zqJqePKnbYeV2570ZGnCdBRQlQ7AD?=
 =?us-ascii?Q?8/bIe2H60yExOsKbIDr9Bs85rpYBaSuQ/cT/EZPP3mqHu0dKUYDhSO6CXeTt?=
 =?us-ascii?Q?wVUQCD7thxDvj1inmxVG0uaygFiKBdeuTr7QyTlPkicMdETRH2UcoSTeGk6z?=
 =?us-ascii?Q?Spad9jz0HeyxGyABsKkokyZXidL84niN/L9uslKARUe8DwdeZC0e3W2vDwa2?=
 =?us-ascii?Q?sQz+s+dQMPK5nHF3PjOhIV+OllX3sxWgq47wJQRBrX0iauG3K1hSktCQEwc1?=
 =?us-ascii?Q?aT6e5AQisCguKvhGgGmRtol5A92IB0fCbdO43L/wppoygm92XzzqnlCq7P5g?=
 =?us-ascii?Q?eK8AGybGtbU7pNW16XEl43KGbEUmgUEhmmSrjY0OtAWc/vOF0uGasrm/oFqG?=
 =?us-ascii?Q?RigpZBNLpVedvHqpF7x56puo+uI9t/4Z9/7rQqWFoTMJh7u0IgifPY2KNqOV?=
 =?us-ascii?Q?zFz5RGolsOE0tup6Woh29+6qjG6yt+n7XpFIOTuz8ECAkH+6F6kmUWJzl/Y9?=
 =?us-ascii?Q?VQFCOkIOj6os+XiZSlttp4gT6DrLSvDIK4M0H9k2M5iQrWubO3rCT+z/DUAJ?=
 =?us-ascii?Q?C8CeF1MpLyUC8gI+ySjW7o5d6/jeMIT+lpK43m6raH4+Bi/lwZ0WX7BVzu81?=
 =?us-ascii?Q?346SYpxwgIMnZAcBo6tLxXEWsKj0+hKp7cmSdy7RvvOoBEQezPjZUHiQAgUo?=
 =?us-ascii?Q?3lr1C9ENfWeL5FqVFPcIluHtSfrkWhFJv/EjZmzS0u6mqvcoar5lfIwyk+71?=
 =?us-ascii?Q?hTE+BUaVSCsBFxOfcEGbmdVnOGO3aOP4eNJquVwV2SYDefyup0zfXbuzwubt?=
 =?us-ascii?Q?T80z8EN87ulg97/IYMn9gMGrHLzixR5u6FbTkN05Q6l+KXQP/5FPVfjQ52Sl?=
 =?us-ascii?Q?BY1kcNn0i/7GEvclzpQn60o6GFZ3UJHoWz5CyOPRsprNuN+O/5+pBoM6AXdR?=
 =?us-ascii?Q?0Z2gwUX9n0Nn2/1E21yPRBzTI2Fc8Rm+aYL4VqTcCzUw1nqaGUcra+GR+G5G?=
 =?us-ascii?Q?5Tfrb47TT6OH5vL6NIVSRnlD96aelZht38nc7qDU9r9Bt0YygcPuZXq2x5hA?=
 =?us-ascii?Q?+4uQwlSTVYPH0Iq4r3KmZsAzDTq5lmm+SoPbb8L3sZWzprj9E4HeSsVodJUv?=
 =?us-ascii?Q?hJzYXnMIuqlKQIRTHbQ0CHvjKnfCGDH8jFkkIBEAKTnpvO10OMZpcwLuV4wL?=
 =?us-ascii?Q?6yPMLb0zISlW4+/EXlPCVmPZab4Z6zC570UMVn82/EXdBqtlk2HNE8XkCl7j?=
 =?us-ascii?Q?cTJVHftB2NIdjkf7ueMcKn08RO9h/zDq/THYIcD0/b6LnzmBIk7mzu/0DMC4?=
 =?us-ascii?Q?gnaDZ61unt2JtYK5GRw1+0/23ftYM54dy83JpOr+xqdDiadZJJEtn/RxI7os?=
 =?us-ascii?Q?a8hCmh/ZiJVJHxcODgwnu8oGe0Uv4ESkRJddP+G8JHS+CBs2z/o9+9kCHKma?=
 =?us-ascii?Q?5gK2Ps70Fu/A1ZKVAF2zvpeOzxCG3wbQr1j9PKqs89VJQRRVhB9xLGuQbje/?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mDJI4CWOpuTLufV4a7afDC2ETt4pwH1Ij9cM6i+kl7KQqRU07vMmOOui7DII?=
 =?us-ascii?Q?ekvTGktr5fQRuH1c5RQY9t6li10iHjjh417zD8M939vMeTcovwi6bfCbcSQS?=
 =?us-ascii?Q?FwT2NxQ+gHEcU/EUZmvcrwn98lm4Sq/M/o2+DVU1dyiZhuyHD059sYikucqb?=
 =?us-ascii?Q?Zunk4/YZqsVMG4ixdYUI9vYDGUkFWI8AGO4NHtCfj/kaJVKIbNVYrEXapgpS?=
 =?us-ascii?Q?l2SFCtMstCktQoinHETPzoQSsFlxk4IPS6J+YwCL4BtfuDCgB8g3atkqG14V?=
 =?us-ascii?Q?Et71Ari4Ye9tdu7DxWR9CZh+u7E+kucoqO7BDXVz2HiNTIZT5uaEhys5rCDc?=
 =?us-ascii?Q?UzToJcuknfH7mdBEeaJVSRLi0V6dMybGCLD5KVhlgTIFSf0L2qeUVtqMayIu?=
 =?us-ascii?Q?TgUQlZVCpFhTEqrAyOES1OoJK9lP7sqjSZF73Is/82LxLgPaBxL63clPOTRE?=
 =?us-ascii?Q?obGpVSI0Df50fA4OuxnLCd1OYkYBMTeQWk8mrmKLaN2rECG+OVPrVe2Uuh0l?=
 =?us-ascii?Q?CqEjyI0qmhsAkOD34IZ6TjtLhNuaehXlmNwMTIID0siOBvmzWG8a5ZVE9asN?=
 =?us-ascii?Q?wHnlNRzCd4cYq3dR6Ia3U1E+tWh+s2LQp2y6JzqeP+UQB0qYnMx9M3ed0IWk?=
 =?us-ascii?Q?VOJPCfDrhboYM8DksdkxraZ4sGcVPbEPrfFyqaHRi3ROQ1flHo8KwLMKqtbW?=
 =?us-ascii?Q?9XLvoC3Sl6WORre+yOoxTnV/QH6FMGmLa4DpVrWfq9+nBxFsLUe4zdF80H80?=
 =?us-ascii?Q?KSemL/TO7w3xXPjckxQB0ROMUF9wrXp2xMD95ofBRNDhNC+fMbArrQYThCg8?=
 =?us-ascii?Q?/or3r353XZn7paIlX6FuiMopoGKZMHxpJO5xm+VK2+LoJIGM3lz12c8+dulD?=
 =?us-ascii?Q?uwCwiutJfNXGTqchkSXP9tZ9owd+ocDXAbXSREe9WCFylO1BfifvNPW/ODdN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a12ecf-9787-4ac4-2480-08db45ae84ed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 17:00:06.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60doy0TWZBw2Ol9/7K2rYL0sq5QoAEb30GuBc5qWo/MmOM9RQjyWbgfd8ykNzqlIyw4i06uxR+NHf7xvuTNScQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=963 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250153
X-Proofpoint-GUID: -TQM9MU_2UwUXPJpzPRphw1kA8_b6Vr8
X-Proofpoint-ORIG-GUID: -TQM9MU_2UwUXPJpzPRphw1kA8_b6Vr8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230425 07:05]:

The subject doesn't need this much detail.  If mas->offset means
something to people reading through the git logs, they will already be
looking into the change.

> In mas_empty_area(), after mas_awalk() returns, if EBUSY is not set,
> then mas->offset must be valid, no need to check. Same in
> mas_empty_area_rev(), so delete it.

There is a lot of code in this message as well.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 8bfa837b7b752..964214de2ed18 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5305,13 +5305,9 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
>  		return xa_err(mas->node);
>  
>  	offset = mas->offset;
> -	if (unlikely(offset == MAPLE_NODE_SLOTS))
> -		return -EBUSY;
> -
>  	mt = mte_node_type(mas->node);
>  	pivots = ma_pivots(mas_mn(mas), mt);
>  	mas->index = max(mas->index, mas_safe_min(mas, pivots, offset));
> -
>  	mas->last = mas->index + size - 1;
>  	return 0;
>  }
> @@ -5365,9 +5361,6 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>  	if (mas_is_err(mas))
>  		return xa_err(mas->node);
>  
> -	if (unlikely(mas->offset == MAPLE_NODE_SLOTS))
> -		return -EBUSY;
> -
>  	/* Trim the upper limit to the max. */
>  	if (max < mas->last)
>  		mas->last = max;
> -- 
> 2.20.1
> 
