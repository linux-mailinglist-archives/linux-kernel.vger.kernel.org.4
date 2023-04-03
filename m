Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E9E6D3CD3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjDCFXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjDCFXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:23:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F14EB45E
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:23:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332Msls0031744;
        Mon, 3 Apr 2023 05:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=1N6qbt+qhUVgQy2JQLXyJCdS15y0cyZtppYubbAlJkY=;
 b=hOua9Es/E4R9NqhhOatqoqZs0Rk2TIVxG8ieeM+AIaeT8PTbTG4f6aG5P3XYQebQckMh
 Q7tqwvhoRemGGUJtPBiaXpXX4V/HUdTJ+9RvIUoIYlgUMuFpztsuaRrXhrTL6sm6eK3m
 j4qgPoHynHSCmDO0iGTwMEh+j7jopfyWrGGuErQ9vmx7vVm1JGrQvuvLcc7LRxohv3m/
 65SDlRj3p7Xl6yO04aSSGdpOBlVU11Dchg7rBGytx0iCmLZYnsHog+6cgqKr99MpN9P8
 8idfndT1TjaLUodlXT8BYpXl1BwWbJWtWqL5Z7ArLAzN2eWJz2a8/TsglHor0XvlvMkS cQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb71j7h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3332Pl6K014039;
        Mon, 3 Apr 2023 05:22:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3djufx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgT8+ZSkRpktst4jWPVexS1fiEbuJ1OI+a6c/rkVxC6U0BGuhmHoLA7Fy5+gxiZX1o7ove0JeJoNkyP8OSIJFmLdevl4jCBVtNUfNdDKuoj2ECLJ+6FCF3bKZ3+Kkjn1cA6ktMrwiPgCIuHj6c5y9GrpvbJ0lOouJatJ9oumUVvRQ2Cl2d2fYHH1GkWY1EF11S9apULhbUB5L9j3LKScKDPRfMg7GZhTgq4n2Gi5w/0yo1CAXMAQv/dN2peOduXGuyTxr9nvaVA8sJWFtnDAaDKnvcivTsdr8VYMDJX4VNrvIgCm6i1vQh3BDj6wC8fTHg7AwIvJcYgwEF2btEa/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1N6qbt+qhUVgQy2JQLXyJCdS15y0cyZtppYubbAlJkY=;
 b=DPwVOGIGxn22GTFqi7mQAzNX0gJiWj1Ft/Ehqp5+9ArhjiEvq+iDd0yOR3XRsH+3mOZUndGU3hD9TZ6DeVst7kYoq1jIPSCyjp5YfdXxQwIqeod4lmKlXWuJrmHwFQ7O7jYdiO61UfwU4dWj5iSQYrp0YsVnl8LIErgGA7d4yHTtmxvgsPNHzMY7ruxi1HVuavqH3hkp1ESnZguUwUNaUdgIhO4VmdPwO4Kb0Ufk+7ShnYWZMB2doKdipX4gv/Hu0TRgMWXd6qYShY33iYmJsj9O7GHvTpXJxgn5WEwXDEAUdwwNLoXqPJUUDFo78opItjHn47P0p0mJW5Tyg/9z9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N6qbt+qhUVgQy2JQLXyJCdS15y0cyZtppYubbAlJkY=;
 b=Hy2ugkgh/AFwOS0PC/TBdVB5Hmafo3mRQA0a9UhGsOSgIVsD5vG3FifpRaW8hATHCe1RSAJym1FN+01vEBCVZis+ayoopfIy46YB66jSKtkNYeBirdwGDgrXy5cFlkcG9cy2UMkuAD2ibjM3YYTGa4FnwNPSXPjj5oiHDmwUK3E=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB6398.namprd10.prod.outlook.com (2603:10b6:a03:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 05:22:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 05:22:27 +0000
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
Subject: [PATCH 1/9] huge_pages: get rid of process_huge_page()
Date:   Sun,  2 Apr 2023 22:22:25 -0700
Message-Id: <20230403052233.1880567-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0267.namprd04.prod.outlook.com
 (2603:10b6:303:88::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 45791c6b-8e75-4f74-8949-08db34036a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YD1Wo4q6FHinxM29vI1SsUONfNcIqT9VEQ0j15jqAUFM/+cbXdp4DWdXlZHyKcLQsbrFBn5s0nqALWiE6HEEvJccQu4cfVJ5l3y5ukUiX6qYZX2rtXREyE0L9R7bNEFOAZgnEO1Py+HdkN9qTQNxxRVKGfnQJ+Eeayz+XBlv/9G2GVVdtCGeXj8TWS83KxHhuecD1l14vYQJ6hSh7+/+79sMvvdlWO+x2XqIA/yZgo7SZQva0r8lVNRbb5WDvqHhtCQUmBk1PMtTAzu5U97KHYIgTbjVfSYxOJNuPVvfGCQBji5S2+Sg7hz3g3Hgw32e58YVw8oxAAI2q/JJV8qzwJ93gb8eOpKE/2g7WGkuZFT5VrEgUffc673O3l2tOjsOrDWPGeotzZLNOynELxAk4iYb2Zlp8fCwx42Wr+gzSmIKxRQFEbJaR27Ns51bn2IXToSs/4Xruj+Jf8zqFZnTZ/1VVhPNWKUA4eDpn7xWWsJcbi6Tpu9KWgtwe5JzeWgfJZorDWt8AHOg8BBX56IyM8SGGvHqy80Bv9dXP+9lPBCBGejQeml+FfAQEHsJEOihXo06jN0B+3lkDmvlxzH+I0xhu3fZclILX9tiszBa8DFXC30ePmmkoXDpdgUUfPMH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(2906002)(8936002)(38100700002)(41300700001)(7416002)(5660300002)(103116003)(36756003)(86362001)(478600001)(316002)(6486002)(966005)(107886003)(2616005)(1076003)(6512007)(6506007)(26005)(8676002)(4326008)(83380400001)(66476007)(66556008)(66946007)(186003)(26583001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xLIrrbNyKGOhvDeQ72mC7nMogOYXdEbwUTXgTaGJnbwqAAdk5HV8hqRh1w1P?=
 =?us-ascii?Q?Yb0nFE3Z+T7Ujw2t2NcGqeW0+FTrzKQz6iv0QyDmy9MGkdmAuEbptn6Zm1zX?=
 =?us-ascii?Q?RXGUogXxunRpf9R6bIQB+X1jRInCrpiX7SqnozmzKL4jPFEMwl5Zd2ssoOHp?=
 =?us-ascii?Q?Khw82NI19yKK4irvB3oxUuPqy+3emd6igEiBGuYIG+tC/8GqHPFNLYFKSD+w?=
 =?us-ascii?Q?kU62LC+cNpTCXABdhMMu1jvg0o9FKaveaFFDOHpfWuFBDAwyisYaMd8I6qZ7?=
 =?us-ascii?Q?ZIRNS8vkHnBDmcF9aVNFcWxqYPuA5LQHb3T42kQrva+Pqy1RkIrk33VdMpcj?=
 =?us-ascii?Q?FADhv7IoH9Qms/iM3phL43nPvZ/kpS0H4TBLg1odXUoOqEiIpbZxcIcJcpVT?=
 =?us-ascii?Q?/aggxXoD+IAlBfJwzutINURmwBDdfLLesSZdxi6uEoAEzx8T/1NkPZIw5tZs?=
 =?us-ascii?Q?lAiphFbivg8mYnRLyCPpIBqkdebXTkKR4UtktxKaiYyta7KaWkfOv2PSCySB?=
 =?us-ascii?Q?5MWlYpifmgNPUza/bEBW+FeAXQlGmxXsGYI2OCYVJH5ukTXKdDnmexTJfHTP?=
 =?us-ascii?Q?jQARNH6pKHJVOYzO1h5sz5oHsF5dvCuOHRYgDzNZlZLYS2zy0Nc3iwn4omnD?=
 =?us-ascii?Q?gPyF1gHzsESHyO9GWe/h7lPpJUCIDyitwvNHSh+vZUmMNfzGAPwwowV2Y1uL?=
 =?us-ascii?Q?Exv/wDPsxjpyK2hDXbbqzgIUeAXaZ9A7f6CetEc++lpacTbyT15ElW0uOIc+?=
 =?us-ascii?Q?RG5x1WMlfs8e0qGHQKnHWliBdu60v+1o1megK83z8+blplS/H5iPK7eO49+x?=
 =?us-ascii?Q?wizjhOFmWxJW3FNipsrooeLm344j1xrFgLa8yJ7HMg12xbXKo6Q+TMJOmaXd?=
 =?us-ascii?Q?dr6i+sGXjgE9YkBsle7I4JXK3Qegg12Zpc3KFVS/ANMcfLVgRqwhZBBA8ug6?=
 =?us-ascii?Q?ewOZ0OD9ic2rZK7wayucB2u5gT9yvs0VCjJb74vkFVpAxquEJwJvHev9wPHA?=
 =?us-ascii?Q?BfrJra6spzS7xtRIF8VxxRi8eaLJIf/+w8AzemMfythu+O/Em4lw2s9HB9kL?=
 =?us-ascii?Q?bDVpcDqDYRouG64k/IVEzFD/S0zVUETYOunPDIoVql+I1J39pJSu39ExyQFn?=
 =?us-ascii?Q?HnDSRMxnkab/5UlW+eoTtRNhXcfaMASii1OFY8AKYvCXmLxAaa9wLyiVFLDv?=
 =?us-ascii?Q?EHVrXr4jv9RQbtyRtUNuzPTgs3Jqf71jnRI8yVHQS00iHJddYDkE2YtoeXLG?=
 =?us-ascii?Q?bFtY7490WjGWYMmUDwXBTmM9SWncqBi8MJp78wdH4DrMsDawTqYaZChHaUV2?=
 =?us-ascii?Q?u1IfSW6giRWQLFW/BvqJ4PNeSjLQTStA5Ui0DC6XNcgatxrFnY6E2DFSCx1R?=
 =?us-ascii?Q?HTDWdjNxgF1xwbPyPsp8zUNDcdZOzNI5r+AHQlKsB+PpCJHbl+vilfrxl3M0?=
 =?us-ascii?Q?xEnqGm70SRx9VSlV3hyzbgxTD3Q/bsvft307mOHHW7O3/yQdwsuOQmBfNFHs?=
 =?us-ascii?Q?TGmkbINSu3USC2Sv7BxXnGMmjvvKa4TL90KWKqXUg/xY4sfO80kLIwnY2ELS?=
 =?us-ascii?Q?mWx6vNt4MMzThOvcVdyFUP6oRVenUXaylgGgrbaO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?V3NALSOKYpCCpvh/qyzIZhyKL78AqK4EIAxQBe3+nkeExfNerw+O8GYUl4gm?=
 =?us-ascii?Q?cSI9PV83/vqx0AJa1NJox8G4NXX3KDoGkbVZdvHqhxSDIb1MnXgzFDSwDCx2?=
 =?us-ascii?Q?7i/mQsrhqgMS/Pp3Wn2C4NcBzi8+C3Km0ZoyaYdQ00yOso539jEdaV8onZ64?=
 =?us-ascii?Q?oQLO3F9qWW+NCHFxkSn4hQD8s2w+F3aKJNNkbGLxoo04yVduGatvpr+AQW6s?=
 =?us-ascii?Q?uF1agXbBlIVflUxJF8t9x9kM5S2bEkTZfOXCg5ub2SNejfy+YPmKRsCIPAB+?=
 =?us-ascii?Q?03BbXliRRWnoNEwhzhaKQjPQjrKrOQVitx3UY08La1ZmEpi5+Pxfb8Mr9RLT?=
 =?us-ascii?Q?6+GB/1gRO4bReFNKt/pUxWjOBO4FdzdCe/zQp84bt9FquOboByLpnz8Z3LML?=
 =?us-ascii?Q?7vLHH3m90SsDUu7q3j0e0YFHeg5RxGxZ844qdEsiXCPUVxdH2UeCy5tJzfTD?=
 =?us-ascii?Q?HQolIjaeZ3Bhj3gtoSO9I88bKndBsXM6MB+t99f7EwMmgm6ocqmrL5ulDO2X?=
 =?us-ascii?Q?dmVpR78BfI9FhSLqaL/bRAjIoqwtGiYajhim8WBNscUbJs86bF+EznsXRjX3?=
 =?us-ascii?Q?w7CQ+kD6LxJSnK5krHSdnguzUYvJhIHzCsPIOt6D7P1LNPQrQIvlwTPDdW/R?=
 =?us-ascii?Q?SeQ6vAqmygaZup193b6vmQA+as9duYhJdtLPoZFxTfb6v36ctWnanMulzS9y?=
 =?us-ascii?Q?x+/k+/1Hvu3V7lUviYgIqbNtaj2M58xfTAS5Y3fLw+b2zWersQW2Ffs7QeMS?=
 =?us-ascii?Q?7FMkx8REuB/Xe7iC2M46I3hvjJmqctO7SUeRqkPMQujY/qhNri+MsVzZqIpB?=
 =?us-ascii?Q?S51xOAdqs9D95ejv0xLfqofBW64CuFI6pLIART2Y7Dtl2mnGSuvPEZKVJEL+?=
 =?us-ascii?Q?F4HbEKTK1FXxyg4jUvZW2bXKIzChhBMwyrm4Um+f1hfPx8WG/wOvKlDfojqG?=
 =?us-ascii?Q?eO6SI7lrGxh0MN2EPhg6kIjTL6IEj7zhAxsDqHPv+REBnytAU9Mk7gNzNNYH?=
 =?us-ascii?Q?jxYfIEg53oCgmfGsipiEdaLVukW1zXi+npMBsTtZSOqMyIZCwIoEFqgQSDTL?=
 =?us-ascii?Q?Ut2cy8nETOWhCNPxFJ/oB3z0M7mWJZWyphwdNpB/dG6RK5/3kl+nLJRN0JAb?=
 =?us-ascii?Q?Pgm6wUc2JMmAGT/Bse76zDdngZZScmgylI1m4mC4fPvuQ/3eM6YC/wU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45791c6b-8e75-4f74-8949-08db34036a2e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:22:27.5865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QocwTopNBygm3UVFFOScbZPlsMlf7MXtjZkZkqwCu5BuBnY9oSMBt0zKthnkf45CgCdJ7F9e6AKy+TyaJX9fK1tThqOLe03lq9uozJEXAzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_02,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030039
X-Proofpoint-ORIG-GUID: qoiaRtD32JN3hRfot9KfEK_SPa1ULIEs
X-Proofpoint-GUID: qoiaRtD32JN3hRfot9KfEK_SPa1ULIEs
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

process_huge_pages() (and the subsequent call to process_subpage())
translate between base-addr[index], struct page *, first when calling
clear/copy_subpage() which then translates to the parameters
needed in clear/copy_user_highpage().

There's no runtime cost in doing this, but it's unnecessary complexity
for something that only has two users.

Accordingly, fold process_huge_page() back in its callers.

Link: https://lore.kernel.org/lkml/20220606202109.1306034-1-ankur.a.arora@oracle.com/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/memory.c | 126 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 73 insertions(+), 53 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f456f3b5049c..d54bc27a35ca 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5629,63 +5629,13 @@ EXPORT_SYMBOL(__might_fault);
 #endif
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
-/*
- * Process all subpages of the specified huge page with the specified
- * operation.  The target subpage will be processed last to keep its
- * cache lines hot.
- */
-static inline void process_huge_page(
-	unsigned long addr_hint, unsigned int pages_per_huge_page,
-	void (*process_subpage)(unsigned long addr, int idx, void *arg),
-	void *arg)
-{
-	int i, n, base, l;
-	unsigned long addr = addr_hint &
-		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
-
-	/* Process target subpage last to keep its cache lines hot */
-	might_sleep();
-	n = (addr_hint - addr) / PAGE_SIZE;
-	if (2 * n <= pages_per_huge_page) {
-		/* If target subpage in first half of huge page */
-		base = 0;
-		l = n;
-		/* Process subpages at the end of huge page */
-		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
-			cond_resched();
-			process_subpage(addr + i * PAGE_SIZE, i, arg);
-		}
-	} else {
-		/* If target subpage in second half of huge page */
-		base = pages_per_huge_page - 2 * (pages_per_huge_page - n);
-		l = pages_per_huge_page - n;
-		/* Process subpages at the begin of huge page */
-		for (i = 0; i < base; i++) {
-			cond_resched();
-			process_subpage(addr + i * PAGE_SIZE, i, arg);
-		}
-	}
-	/*
-	 * Process remaining subpages in left-right-left-right pattern
-	 * towards the target subpage
-	 */
-	for (i = 0; i < l; i++) {
-		int left_idx = base + i;
-		int right_idx = base + 2 * l - 1 - i;
-
-		cond_resched();
-		process_subpage(addr + left_idx * PAGE_SIZE, left_idx, arg);
-		cond_resched();
-		process_subpage(addr + right_idx * PAGE_SIZE, right_idx, arg);
-	}
-}
 
 static void clear_gigantic_page(struct page *page,
 				unsigned long addr,
 				unsigned int pages_per_huge_page)
 {
 	int i;
-	struct page *p;
+	struct page *p = page;
 
 	might_sleep();
 	for (i = 0; i < pages_per_huge_page; i++) {
@@ -5707,13 +5657,48 @@ void clear_huge_page(struct page *page,
 {
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
+	int i, n, base, l;
 
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
 		clear_gigantic_page(page, addr, pages_per_huge_page);
 		return;
 	}
 
-	process_huge_page(addr_hint, pages_per_huge_page, clear_subpage, page);
+	/* Process target subpage last to keep its cache lines hot */
+	might_sleep();
+	n = (addr_hint - addr) / PAGE_SIZE;
+	if (2 * n <= pages_per_huge_page) {
+		/* If target subpage in first half of huge page */
+		base = 0;
+		l = n;
+		/* Process subpages at the end of huge page */
+		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
+			cond_resched();
+			clear_subpage(addr + i * PAGE_SIZE, i, (void *)page);
+		}
+	} else {
+		/* If target subpage in second half of huge page */
+		base = pages_per_huge_page - 2 * (pages_per_huge_page - n);
+		l = pages_per_huge_page - n;
+		/* Process subpages at the begin of huge page */
+		for (i = 0; i < base; i++) {
+			cond_resched();
+			clear_subpage(addr + i * PAGE_SIZE, i, (void *)page);
+		}
+	}
+	/*
+	 * Process remaining subpages in left-right-left-right pattern
+	 * towards the target subpage
+	 */
+	for (i = 0; i < l; i++) {
+		int left_idx = base + i;
+		int right_idx = base + 2 * l - 1 - i;
+
+		cond_resched();
+		clear_subpage(addr + left_idx * PAGE_SIZE, left_idx, (void *)page);
+		cond_resched();
+		clear_subpage(addr + right_idx * PAGE_SIZE, right_idx, (void *)page);
+	}
 }
 
 static void copy_user_gigantic_page(struct page *dst, struct page *src,
@@ -5759,6 +5744,7 @@ void copy_user_huge_page(struct page *dst, struct page *src,
 		.src = src,
 		.vma = vma,
 	};
+	int i, n, base, l;
 
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
 		copy_user_gigantic_page(dst, src, addr, vma,
@@ -5766,7 +5752,41 @@ void copy_user_huge_page(struct page *dst, struct page *src,
 		return;
 	}
 
-	process_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
+	/* Process target subpage last to keep its cache lines hot */
+	might_sleep();
+	n = (addr_hint - addr) / PAGE_SIZE;
+	if (2 * n <= pages_per_huge_page) {
+		/* If target subpage in first half of huge page */
+		base = 0;
+		l = n;
+		/* Process subpages at the end of huge page */
+		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
+			cond_resched();
+			copy_subpage(addr + i * PAGE_SIZE, i, &arg);
+		}
+	} else {
+		/* If target subpage in second half of huge page */
+		base = pages_per_huge_page - 2 * (pages_per_huge_page - n);
+		l = pages_per_huge_page - n;
+		/* Process subpages at the begin of huge page */
+		for (i = 0; i < base; i++) {
+			cond_resched();
+			copy_subpage(addr + i * PAGE_SIZE, i, &arg);
+		}
+	}
+	/*
+	 * Process remaining subpages in left-right-left-right pattern
+	 * towards the target subpage
+	 */
+	for (i = 0; i < l; i++) {
+		int left_idx = base + i;
+		int right_idx = base + 2 * l - 1 - i;
+
+		cond_resched();
+		copy_subpage(addr + left_idx * PAGE_SIZE, left_idx, &arg);
+		cond_resched();
+		copy_subpage(addr + right_idx * PAGE_SIZE, right_idx, &arg);
+	}
 }
 
 long copy_huge_page_from_user(struct page *dst_page,
-- 
2.31.1

