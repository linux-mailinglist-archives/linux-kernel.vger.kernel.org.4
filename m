Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C63763CB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbiK2WwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiK2WvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:51:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DF47119D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:51:18 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMDeUa030099;
        Tue, 29 Nov 2022 22:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/nyUBV653HdMfEXofdg4opZvn8EmjMhZwLoDr0pH2UQ=;
 b=KU0B0UMhy+EZfFttGJw2vZjbMTx/WL4K/1XtkdPMohUdEp0Mj9XGB8rFWWSPpsGDg5d3
 aU7BMg4Je802/FmKwyozBPv2PJraHgO+Nz+d7GsrFEfpK/0+lh1qTVOlZeIT3DiG8deI
 IgtbLVlftGLdKseEfkX/z1W20FdgeMMDKsEt4FPeUg1LAw4GbhvayoBDH93ySsnIx553
 Y3wLEupPr/UuyPBQGDPFB3SDbV0vTqKq/ALDbtCft812DtXlbXUKoOl3yhHZBX0gdwQK
 7iP+vC67hAXQzrcqRSCPLZWKDOG99LxIjdGrvd7WfdyfGypVchbB3yytwOaVJqp5dzZg WQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3adt8g2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:51:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATLIULN028067;
        Tue, 29 Nov 2022 22:50:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m39881gw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAOfcyI/6DEduTw9JaSEPlqDy8jaXkeD3OAJzcjFmyhya1RNyLxD4piWnR0tOyFnUB6ZR+yInsR7AVLL25SXMXw4Lutu86ukwL8V3WDP1SVofJIRiQl6uRKXNIUHWox6tr/8Md0Hqvi2FUVfqVgdVlcGrMzi02jNRorHpzXRP9f/CRG1MyGhT6Yx8rw230b1a3bJfuhbnfbKhfhWtM6i0CPiVlQSPYKMs6/VEt5zplczmbAQwe+wwzVmvrvCXwYiUD8AvjlD9bDPCM3UfSUPIJaC7Snjo4iIAQmHsz5hIIqssRgUuBozLGMxAXV6GIor22/ZRJxeEBYvhxt5apjpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nyUBV653HdMfEXofdg4opZvn8EmjMhZwLoDr0pH2UQ=;
 b=gtxPqGR1YcNtxIllcaDoIxMK1Yi8WgSzjIZS3V2SVXL7iGIehszcUHwKke2iQCxvKwjNkN8uY+U/Fmf/m82XvMR7A/CugG+/GhaynqcATXuV5a84sHD5vkVpI9uXrfE4tguJvhsBiofuKBXhM8v86+UA0r6oR5mNGFfefIPp0pxbuLmZQ9jpOX3RClvSrieYJ56fu8csbe9bMlxiI3uX7PjdtqEjeR0JO4QlS5GwX+uzwVWW2AE9nutDJdWtXXRfSjDbYrPe3g10Pij380+s3GLCNPxBz0790BHQJ3BMWRm0CNR2ih8S6lEiCYQO5U0eudqf7wlGBugPSAJXrIkIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nyUBV653HdMfEXofdg4opZvn8EmjMhZwLoDr0pH2UQ=;
 b=yJmcZByX+oSHbbAu6uSlkcapXnp1AwWaJy7MN7B1HnaSw37ksB4a8Z7DGoI2qKmBVoHJQ9HtvRHGlm4PooZ248lCpwrnBLVaLHcSGT/BohVIkGHVcOqqkuAZTk8DUlG96NEygtMf+wgXqLl/Qhux0PnH7o3lf36FNsBEQzfSlBU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 22:50:57 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 22:50:57 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Wei Chen <harperchen1110@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH mm-unstable v5 10/10] mm/hugetlb: change hugetlb allocation functions to return a folio
Date:   Tue, 29 Nov 2022 14:50:39 -0800
Message-Id: <20221129225039.82257-11-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:610:74::23) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 456aa78b-29ea-4205-c064-08dad25c2d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twHrm7wf0jDnu/x5iGDnpf0YoZC9HBdjCAJqKIces/7QCrm2GHRl5aHXyebdC3aBJMGhvF081fkLpg+QyGIDTsTX9bp1ThbJCY8zQmQ9kgxMnTTap3ysXMa0rGi5lDuNBF1NVMpPFA2darBlrC7xiHmu/eu1SEbNznvil+6JReyTdMJ9Cx2MrbGpk9HjFEuosXBvr8vWZwPxtJqx42IAeSwBSI82CtbQCQW3NcUtgMk2q7bUE9EuSzqXG0pk7m0EoD4vKt+ycu8h+Pc/RVEb3zrcRyvckAP+/2hhZaDkgwUKlygnAMwv7N+XO4ouady1bfMxdYbUBeauhCFG1PvEyW6GbASjtei1bb3262ntJZBz0Jo80QW99qnPKYn69ACRrxDsKnQWY4t4V5+Vx5zvmhTSbAQk3Tfu04TkhQammdC9kR+g7bZ4P62Qd+CiBZFj3rlQLGX/QVB1qQlLbM8ome2+cm7W22uF6u8youhe6UzBkA0FRgYUuWymj2BwwR5hnQuFPbiN4DwTmaDWs3SHsuiavpgJAueAN9Z22OZJPhAbcVS8nurnWOm/CK04VNvbVDOF1CsrAVW1BZsxMv0pqpwx41ayCdXQTLaiH188iDS1cKqpOa/FEQmATV+2U+kdEYC2CNpm1T3aVS4ay/Gy2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(30864003)(2616005)(6486002)(186003)(41300700001)(1076003)(478600001)(36756003)(6512007)(86362001)(26005)(7416002)(83380400001)(38100700002)(6506007)(8676002)(66556008)(66476007)(4326008)(54906003)(6666004)(44832011)(316002)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FSyG+LPhijQCO8iLthrdzP52zqx3Mi2OyFEI2prRNpi05JgFl5tzvS4fAgzK?=
 =?us-ascii?Q?ulT5lEo/Q+L+Za3XsSu6fpjkI21dzeRQ9X2GE8YkU/d50CqgxxztF5vr2HC5?=
 =?us-ascii?Q?YCNkcH1g6S/eJVocFTy9JVgkrbOPOqBFphz/IezHeCbhUvBlEMkxvfNKEB0q?=
 =?us-ascii?Q?grHVjtXdtqx3MpB6KlyEM1hZPo9BecrU5Y783po/BHclIZ7mcSCGfnA0fl1D?=
 =?us-ascii?Q?+6UeegT+D0DNWsxPqBmeFb+HVKB6B5NKSVhrrFmAOt+J4ZRJAH6puwI0DcUY?=
 =?us-ascii?Q?eV6hInnl9PIRmj4knmiCwOTrzIRa8f5/aOCPF2CDBe5UyNcYbvsh2C3wWXNf?=
 =?us-ascii?Q?uKnOs/zL58qA0oxsAsrBEL76LWOz2h44NRtmwFyqIq5Nhj9nIcwU5NKICaBZ?=
 =?us-ascii?Q?ka7D70bykKHWsQWvQwqXStyOtD2cJFmKMhO+0ccIFEE/HivHC8XTsRPinywO?=
 =?us-ascii?Q?6mXYEt1jTz3NZ4aLDXnBQ1EkzCAGmD/GIc4jso0A8AXNeTvwCoSfEll0VaW3?=
 =?us-ascii?Q?bhr6NdyJg5scxmN3BSoPGt/CLxhbhF3hl0m7dLkzTRUTRfUujjIomGBnqNN1?=
 =?us-ascii?Q?p6zigXHQq+MUR/w1Tf67gSSiLMS+WQa88+k/eKukr9NgnOvSkQOfoz/yY3hR?=
 =?us-ascii?Q?vC8HbxLOvnewsRjV7vIriMDogqeK7z1y/tH3QbzgxUUpAKF3arpPSJtn0Hhj?=
 =?us-ascii?Q?prvY2I3ofwvhZbLSW2OWSEiERx1Vh01by7TBXZBOUXsAFqTfTIe9PjrjLsIv?=
 =?us-ascii?Q?9zqxTEwvZZ0wAOcw4kfS5XcyEuiarTo792KkL20h++gu1C05dMOSJMGNYf5f?=
 =?us-ascii?Q?9nwfIrLzRcSn39qkMRsGospTEZj6i6pYhIq8lR+ULCxKAgXhoM+Z1ok6FPYH?=
 =?us-ascii?Q?CWMXcQX4+az/hFRi5t1u4x6TeEfQca6zZv6vJsRgwzSDJNmz/9kOaQ9ZmY1g?=
 =?us-ascii?Q?OUn6RMk0m74Fmz75WOoPib3CBPZgGdJe9WLtjdCZxQM5nhrDRe57nro3vAzA?=
 =?us-ascii?Q?cGeaeU5CELLJ7nf7sFTqZONhPTJZ0+9uCEpaIhZIze10PlchMoZfDcoujMJ6?=
 =?us-ascii?Q?xNYX9rqPBk2Nn5lpBqq7L2StuhJo+bEuWFHZrf44aXyM7j7jyCiPQilCsXHj?=
 =?us-ascii?Q?ato0nzsavVEKMleMZCr6csuj/NLGhkfMF3jc02sFv7rriFpDR/D5hkUhYxJN?=
 =?us-ascii?Q?cBwpDo8G4xizL0X5d+Ny6g0t38BaI8JyXu6ch982sLwzrRUGXebXRHSj/q3n?=
 =?us-ascii?Q?ZWal3ceyWsxw18WURfnrQALsms3o5kLS74ZvXWWDPrKnU6SZoucA2PRaXEXA?=
 =?us-ascii?Q?vsFmolUhSYyd+mes/KJnkYWllJliH7AEn524W+XHWvjnJJ8EEuFYeIElF/Wp?=
 =?us-ascii?Q?N6PwSPmgYBqMHDDyods/cTOQB9CeaLtMlPcIDhizvAnmqif5xAxihylzLzmk?=
 =?us-ascii?Q?mQhQ8mfMdKPxp5MTGwqbiXbXxLc/YtWNHT7A2A9CdK4/oZmc1sEI5MisVCnA?=
 =?us-ascii?Q?0+pxG0pzFIM8V1Nv9gRjZiVFyIKd6kIvPMTR3dBAMUw7pULqlRa9HucbDJc9?=
 =?us-ascii?Q?D1udVEoMVUlQ6cx3ssd1eUjWbASdz+gtugRUNH8JmUeQRlwda1FaSEG9Whpj?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bqMXquP7KTk09bxpXOzsOcSF6E6Q6sKxS9MdAOtnJFTdQ1NbzH07T0Dgckge?=
 =?us-ascii?Q?63t2D7YeAm/AhGLirL0lVMQ3NuLrKgIktoJNiMgZLycMo6j7z+BJuMXOpFCv?=
 =?us-ascii?Q?L1UePeEqiyvhkw4g6s5Vl7ClEuZjLzJXq3FYXMYFNkpMG1jAlJ2/T2aJFVmb?=
 =?us-ascii?Q?Yb2g/LEjuhOdHgX6Z3T7y3FGGohCOa2C5jnaJHt1EOQHvY0BQMpEguEknG0S?=
 =?us-ascii?Q?bXtVJ7i4WQbfSl8JPtWytlhBnvhm7dv24nS1ZSDlYYpRfzAn/jWQxQFpJXT1?=
 =?us-ascii?Q?WKa1w79sl9JNht0EcbHIi/f95HRlEpJgeDq5EBA6XTxNO/diqnaXiu5ve9xK?=
 =?us-ascii?Q?6I2SPNtRY/64js83Zx4BPccLP5jIBIgGtCOqQwhm4CcYCJMuf4ASLnjoOJQc?=
 =?us-ascii?Q?9XQbPPZm2nohoiuH5ML5D919r3y7hAvdDVs1mI9KJO0jbfFcZJfaVSbQ0nDy?=
 =?us-ascii?Q?BWDRwCeksPVuG1Na5QEJf8PA2DQFyY19imgi+bPqJyAbgTIUb5PJ9Aj4iNJ+?=
 =?us-ascii?Q?c+dMlT1AfK0oC9QfyV9UpMjmmp1BDGVvFtTGZKKRBJxbCdK1XldYMJR8ffyw?=
 =?us-ascii?Q?3nGxZD4CZslMH8iLBt7r9WARk0Gge/UbbADqtLU7Sqwer1fqswiioEzU/6yI?=
 =?us-ascii?Q?YxjrHs5rA+LrNBQ6wLSV+vROurObOH/679sDaJTVK/2gob643XVZqDopS9hm?=
 =?us-ascii?Q?tGI5Y76KKdQZEh+x1JaYTUnpMIqap5mKbWyCVdKnz8+0vDfamRpyg2x2mnsf?=
 =?us-ascii?Q?3+YjVIkSJDFgvmyJXxTOOFuvh0dYibd88PxbWBiPcw2Oz2+s7jehYaMmI9zQ?=
 =?us-ascii?Q?rtINI0DeUT6+0LFrTJcEYy8WLyCkg8UacM0kGkQIm+8rZ56V5KR3/q056Ogl?=
 =?us-ascii?Q?Qm9Ze1WD7bFR1lBPoqPGF6e2gNACWqxsbHXaf1D88OxwMff7o893PqQPz0aa?=
 =?us-ascii?Q?laoDdOepbFbgG3MwiPI0dHftuA9QK+s0BU9TeugWEZZcEkVSuZGSWcPvNSod?=
 =?us-ascii?Q?4aa51kVbDvVrbS/fzH9Ftgb1wWR7ms9OTMogsBVZRUCGwWVKO5B1ZL5T5E3W?=
 =?us-ascii?Q?W3tysiknNC+kjFIJ7aBB8Njrgx3pg+G05eD3gbmXGlopkVjT5ek+P48CZLj0?=
 =?us-ascii?Q?U8FMjKi43E6UbvGWxFwocJmHEuGYAqMA19jnlCvkEwAgQoEhLjyaUKqIuESp?=
 =?us-ascii?Q?VtWHtnWidTm/uZCs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456aa78b-29ea-4205-c064-08dad25c2d8f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 22:50:57.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6qrMS49xHc/gPNLCWI7tv5r8t4/S+CvTAtuCpgZqq9+Dre4fGthvYVSYUI8U1LmJhBXmH7DWABk1SNy19w5EvIWCX0SMHJIgNg9QlK/hmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290137
X-Proofpoint-ORIG-GUID: AIdDRBPvLcSbCh6jv90sP7bi71BmET4G
X-Proofpoint-GUID: AIdDRBPvLcSbCh6jv90sP7bi71BmET4G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many hugetlb allocation helper functions have now been converting to
folios, update their higher level callers to be compatible with folios.
alloc_pool_huge_page is reorganized to avoid a smatch warning reporting
the folio variable is unintialized.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reported-by: Wei Chen <harperchen1110@gmail.com>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 mm/hugetlb.c | 120 ++++++++++++++++++++++++---------------------------
 1 file changed, 57 insertions(+), 63 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f61b4eb58cde..944e1222ea7f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1378,23 +1378,23 @@ static void free_gigantic_folio(struct folio *folio, unsigned int order)
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
-static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
+static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 		int nid, nodemask_t *nodemask)
 {
+	struct page *page;
 	unsigned long nr_pages = pages_per_huge_page(h);
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
 
 #ifdef CONFIG_CMA
 	{
-		struct page *page;
 		int node;
 
 		if (hugetlb_cma[nid]) {
 			page = cma_alloc(hugetlb_cma[nid], nr_pages,
 					huge_page_order(h), true);
 			if (page)
-				return page;
+				return page_folio(page);
 		}
 
 		if (!(gfp_mask & __GFP_THISNODE)) {
@@ -1405,17 +1405,18 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 				page = cma_alloc(hugetlb_cma[node], nr_pages,
 						huge_page_order(h), true);
 				if (page)
-					return page;
+					return page_folio(page);
 			}
 		}
 	}
 #endif
 
-	return alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
+	page = alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
+	return page ? page_folio(page) : NULL;
 }
 
 #else /* !CONFIG_CONTIG_ALLOC */
-static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
+static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 					int nid, nodemask_t *nodemask)
 {
 	return NULL;
@@ -1423,7 +1424,7 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 #endif /* CONFIG_CONTIG_ALLOC */
 
 #else /* !CONFIG_ARCH_HAS_GIGANTIC_PAGE */
-static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
+static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 					int nid, nodemask_t *nodemask)
 {
 	return NULL;
@@ -1950,7 +1951,7 @@ pgoff_t hugetlb_basepage_index(struct page *page)
 	return (index << compound_order(page_head)) + compound_idx;
 }
 
-static struct page *alloc_buddy_huge_page(struct hstate *h,
+static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
 		nodemask_t *node_alloc_noretry)
 {
@@ -1988,11 +1989,6 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 		page = NULL;
 	}
 
-	if (page)
-		__count_vm_event(HTLB_BUDDY_PGALLOC);
-	else
-		__count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
-
 	/*
 	 * If we did not specify __GFP_RETRY_MAYFAIL, but still got a page this
 	 * indicates an overall state change.  Clear bit so that we resume
@@ -2009,7 +2005,13 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 	if (node_alloc_noretry && !page && alloc_try_hard)
 		node_set(nid, *node_alloc_noretry);
 
-	return page;
+	if (!page) {
+		__count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
+		return NULL;
+	}
+
+	__count_vm_event(HTLB_BUDDY_PGALLOC);
+	return page_folio(page);
 }
 
 /*
@@ -2019,23 +2021,21 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
  * Note that returned page is 'frozen':  ref count of head page and all tail
  * pages is zero.
  */
-static struct page *alloc_fresh_huge_page(struct hstate *h,
+static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
 		nodemask_t *node_alloc_noretry)
 {
-	struct page *page;
 	struct folio *folio;
 	bool retry = false;
 
 retry:
 	if (hstate_is_gigantic(h))
-		page = alloc_gigantic_page(h, gfp_mask, nid, nmask);
+		folio = alloc_gigantic_folio(h, gfp_mask, nid, nmask);
 	else
-		page = alloc_buddy_huge_page(h, gfp_mask,
+		folio = alloc_buddy_hugetlb_folio(h, gfp_mask,
 				nid, nmask, node_alloc_noretry);
-	if (!page)
+	if (!folio)
 		return NULL;
-	folio = page_folio(page);
 	if (hstate_is_gigantic(h)) {
 		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
@@ -2052,7 +2052,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 	}
 	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
-	return page;
+	return folio;
 }
 
 /*
@@ -2062,23 +2062,20 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 				nodemask_t *node_alloc_noretry)
 {
-	struct page *page;
+	struct folio *folio;
 	int nr_nodes, node;
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
-		page = alloc_fresh_huge_page(h, gfp_mask, node, nodes_allowed,
-						node_alloc_noretry);
-		if (page)
-			break;
+		folio = alloc_fresh_hugetlb_folio(h, gfp_mask, node,
+					nodes_allowed, node_alloc_noretry);
+		if (folio) {
+			free_huge_page(&folio->page); /* free it into the hugepage allocator */
+			return 1;
+		}
 	}
 
-	if (!page)
-		return 0;
-
-	free_huge_page(page); /* free it into the hugepage allocator */
-
-	return 1;
+	return 0;
 }
 
 /*
@@ -2237,7 +2234,7 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 						int nid, nodemask_t *nmask)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 
 	if (hstate_is_gigantic(h))
 		return NULL;
@@ -2247,8 +2244,8 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
 
-	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
-	if (!page)
+	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
+	if (!folio)
 		return NULL;
 
 	spin_lock_irq(&hugetlb_lock);
@@ -2260,43 +2257,42 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 * codeflow
 	 */
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
-		SetHPageTemporary(page);
+		folio_set_hugetlb_temporary(folio);
 		spin_unlock_irq(&hugetlb_lock);
-		free_huge_page(page);
+		free_huge_page(&folio->page);
 		return NULL;
 	}
 
 	h->surplus_huge_pages++;
-	h->surplus_huge_pages_node[page_to_nid(page)]++;
+	h->surplus_huge_pages_node[folio_nid(folio)]++;
 
 out_unlock:
 	spin_unlock_irq(&hugetlb_lock);
 
-	return page;
+	return &folio->page;
 }
 
 static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 				     int nid, nodemask_t *nmask)
 {
-	struct page *page;
+	struct folio *folio;
 
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
-	if (!page)
+	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
+	if (!folio)
 		return NULL;
 
 	/* fresh huge pages are frozen */
-	set_page_refcounted(page);
-
+	folio_ref_unfreeze(folio, 1);
 	/*
 	 * We do not account these pages as surplus because they are only
 	 * temporary and will be released properly on the last reference
 	 */
-	SetHPageTemporary(page);
+	folio_set_hugetlb_temporary(folio);
 
-	return page;
+	return &folio->page;
 }
 
 /*
@@ -2745,19 +2741,18 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 }
 
 /*
- * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
+ * alloc_and_dissolve_hugetlb_folio - Allocate a new folio and dissolve
+ * the old one
  * @h: struct hstate old page belongs to
- * @old_page: Old page to dissolve
+ * @old_folio: Old folio to dissolve
  * @list: List to isolate the page in case we need to
  * Returns 0 on success, otherwise negated error.
  */
-static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
-					struct list_head *list)
+static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
+			struct folio *old_folio, struct list_head *list)
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
-	struct folio *old_folio = page_folio(old_page);
 	int nid = folio_nid(old_folio);
-	struct page *new_page;
 	struct folio *new_folio;
 	int ret = 0;
 
@@ -2768,26 +2763,25 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	 * the pool.  This simplifies and let us do most of the processing
 	 * under the lock.
 	 */
-	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
-	if (!new_page)
+	new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL);
+	if (!new_folio)
 		return -ENOMEM;
-	new_folio = page_folio(new_page);
 	__prep_new_hugetlb_folio(h, new_folio);
 
 retry:
 	spin_lock_irq(&hugetlb_lock);
 	if (!folio_test_hugetlb(old_folio)) {
 		/*
-		 * Freed from under us. Drop new_page too.
+		 * Freed from under us. Drop new_folio too.
 		 */
 		goto free_new;
 	} else if (folio_ref_count(old_folio)) {
 		/*
-		 * Someone has grabbed the page, try to isolate it here.
+		 * Someone has grabbed the folio, try to isolate it here.
 		 * Fail with -EBUSY if not possible.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		ret = isolate_hugetlb(old_page, list);
+		ret = isolate_hugetlb(&old_folio->page, list);
 		spin_lock_irq(&hugetlb_lock);
 		goto free_new;
 	} else if (!folio_test_hugetlb_freed(old_folio)) {
@@ -2865,7 +2859,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (folio_ref_count(folio) && !isolate_hugetlb(&folio->page, list))
 		ret = 0;
 	else if (!folio_ref_count(folio))
-		ret = alloc_and_dissolve_huge_page(h, &folio->page, list);
+		ret = alloc_and_dissolve_hugetlb_folio(h, folio, list);
 
 	return ret;
 }
@@ -3083,14 +3077,14 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 			if (!alloc_bootmem_huge_page(h, nid))
 				break;
 		} else {
-			struct page *page;
+			struct folio *folio;
 			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
-			page = alloc_fresh_huge_page(h, gfp_mask, nid,
+			folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
 					&node_states[N_MEMORY], NULL);
-			if (!page)
+			if (!folio)
 				break;
-			free_huge_page(page); /* free it into the hugepage allocator */
+			free_huge_page(&folio->page); /* free it into the hugepage allocator */
 		}
 		cond_resched();
 	}
-- 
2.38.1

