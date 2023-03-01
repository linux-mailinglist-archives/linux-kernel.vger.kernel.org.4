Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A373A6A718C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCAQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAQvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:51:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3DA3E635
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 08:51:23 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321FwmiX028222;
        Wed, 1 Mar 2023 16:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=+T8Q6pSAfj2ReV2+do7UhvCpO0xIFCEU4M+rYuoWwRI=;
 b=erbX9kdKKx67y6/E3E+AfTu2t6OZQWLdw4azbMxfeXI+D4DGMroDXmsRtLklXLCy4Yag
 SqKaFq2b8M8Aik59qbu8b6iRf1V2RA4GK+zEMjKZVmtK0RBk3r9RKf3CwARCASU9DaAC
 oib+zxGMd/DVMprI8Zc+JDID2XwHCO3C0agWJBxrpYgh+hQg3cvnOGiIMSJDtEMUOGjp
 FaMEcdC7VtXFD2z50rZ8mgsS7SB7FPxd0Upykky+6I/6H+avDIAqe4pZqVZ8CCiw1hlQ
 ti2ymwdrUlIHypIfa2WQYolk9DBTDyJs6D9CtudGjsjbEJIGZc0vFLApT5QyzDgWMyae CA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72hddf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 16:50:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 321GBVMB028704;
        Wed, 1 Mar 2023 16:50:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8seu4gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 16:50:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AND2AfUv30nEts1qjwvpX4+6GYFbjm6kDdbSbaCivyYBsdIPFQdD27J/6GoLi+JZTSRxvDOUmMZtl5SE2H0aHq8siR80iS5aNvBqKntNU8rOnghZB1bBw0KoUWS8lX7+UtoUdqj2prJct72Psi7JIhnhCDP5Xx5l+AedfzbqMoCfZxf7QNO5og7JxodOjXowRtMsRP7KuNtwiOsnxKNw88zuuHxpufXVAYcujDymLITQDeJPdNjIqykIdjClpq/S4dxDdeJKqquRJOdu0azjWOk89PfOOOL54V872AHhUhOH1jZZBqw1FFywgburkjEJlWI2FtJAu0Y6IAZ4kg9/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+T8Q6pSAfj2ReV2+do7UhvCpO0xIFCEU4M+rYuoWwRI=;
 b=D8tGvmGVmCl/tSJtURntpwatJjUu5KUrgkz+5kRkYOYqg8sgWPRD0eEuRFjr9tmWPmJ0fj+YZkQrmKXAM0F94jHJe3Sp97IrRVmJ7eEoTI8INisLjFca5KLw/s0olvfc/mc9fp07CECCY9BZWgeZZmWptXFhen/lS2WRApgwuqT3AsesfNNP4ZFinqnhjTYDYpEB3u1iMS/FVOyCbWNgetVLFUa38z1CpHyiHwpr5Rm0ta6dl36ScoXnbI9//hwKN0ZMA/6TJYX/3gP7uYlykoh+dn6+hPSWxwo4VuLgvdPaSXRrrUNPMZ5FihwNrHePQQfTYFjs6jCqBcUR83Gf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5227.namprd10.prod.outlook.com (2603:10b6:610:c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 16:50:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 16:50:39 +0000
Date:   Wed, 1 Mar 2023 11:50:36 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [linus:master] [mm/mmap] 04241ffe3f:
 Kernel_panic-not_syncing:Fatal_exception
Message-ID: <20230301165036.mal6lkb6qhpjyz2r@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <202303010946.d35666d1-oliver.sang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303010946.d35666d1-oliver.sang@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f81b33-031c-4e09-ed51-08db1a751645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7LayZPVumVk/v+qGcCg+ShWjE+N0xXXJ6QNIFdu92C4liUpS92VpgknmGygUY/Yak5VCu841Wyp4GZ0hA+Ey7VA6tTTz402Wr+Hi2acdk3UmlQ616wsLXk9xuhq0zaiqk3kkVxpLzWNIcGhj6CKJzBKYtyhS/0faFc9B6SywMkT1SAqp8Ld5CeNELj5+RdxvGWS/+LQk4GHmyJSA2RX1W5UzGUyTpgoyQZnCRzBuUi+jDiIu5xc3F2b3cpN5ayVU7YFmojMsaJqFQN0286U0uCMVQNR2rOpsSjV0/JIt3l+KWsWm1Gt2UqiUTA8VdQ6IayTjRHlsRVkOF5+tQyau7V3i6hsDH+4pGS/0fldr8hxwHIww6qQEKrJFwG+gvkd/GPbUd6YR7xnKrec4snbcFeMIkOopqX5VeuRP4D9eR5ID8rBB00nCtQ6wfRg1HDT//aKHc1LzEnRbta3/I5esyyXrnRobW/4J+ySRq6TxAv3w0Z2oJGWICQLCvzVjcISMpl2GCZXYIDgfgK73BzH+6cwQ+iBMGyvu06BWM3T3oPQgJExPoupd7Os0GEXepLLCFEOqTph0rj7gUn5zH1+hNqSZU92CDIDMFktqqpDnC/xF+n3rYDn0uG6cYu2bgRX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199018)(33716001)(54906003)(316002)(83380400001)(478600001)(6486002)(966005)(6506007)(1076003)(9686003)(186003)(6666004)(6512007)(26005)(8936002)(2906002)(41300700001)(86362001)(66556008)(5660300002)(66946007)(8676002)(6916009)(38100700002)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mqtyKN4yJ2jBRoT8KIJz0pZeaO3jMwB5ixLgFZE9p7bQaq98USXCh8DSxn72?=
 =?us-ascii?Q?SbqCuP9y4nhZ0TJhjpv5idVb28DpDcpXGRbMPQhvJ1D/Hdnj4VIGra5rQM+N?=
 =?us-ascii?Q?odMHc11WOlTyf5wdkh1Zv94aP8Xx9JCralxYNFWo7TFoW/J7P/e8S1iEBpq7?=
 =?us-ascii?Q?ltZn/nxzemadGIGhQ8nk+h+mS/iJhx3sW3eotV4tKPQ/LhIzwO9o2IeDzpMK?=
 =?us-ascii?Q?1jiNGmPOszfEsoYBkC5jx76muvPzTnvvRUyZKztqOwOQTKRaL85Qh3QeNoyh?=
 =?us-ascii?Q?3UWBC5ikWkLJEZfEQ4K3pelVj+6AgN6ZyXxl0eCaxx8st5fYGj3LMubJqym2?=
 =?us-ascii?Q?nDqHZXxfNoRYDJodYtxcb+3S+pmKkzr1OwuQirV26Hlfo62t30w5MU0jt91A?=
 =?us-ascii?Q?fVpwPI4PyLhyzoazU4bZw8nR//i/mJH1cydSCwky2BVmC0u2qf8/3+hOQ8wr?=
 =?us-ascii?Q?TzYvUBB0FKGPWAcqPv9qXAuY15uceYvccAc5iQp366CcZBk2SpKAG6CxK0Or?=
 =?us-ascii?Q?INX6lvtfLlb1zV80B5Ri70h9lAG/268KjpMz/khYPbacfBNR/uI4nAW+lDNi?=
 =?us-ascii?Q?7QkOvQi7Dqov7CyX/3PmoVdQk6a+Mbl0f7WrGTDZ5R4UhBSyBPG5K1c5Da0K?=
 =?us-ascii?Q?VbuaGRqGLndZq4PimOFjiZIhRIBU9eh466OdGL3qtPRRyRYRW66wjotd3ycY?=
 =?us-ascii?Q?ZkkVoV/g2EjIBXKnoV4Clk9nxvpWXbzrrojnBfeEqIKGGrSWMnRNOt58vT7u?=
 =?us-ascii?Q?PRyW6klst9BI4X7mJEpHFH+cPmCS+D1sRyWfk7VC+lu8bxjOIu+AeV/Wy5Q9?=
 =?us-ascii?Q?FQHIo4cVQXMBXk2rJbDO4nb0V1jMAVWDZb9uF2R6rORq3je78Dzks0THTbhm?=
 =?us-ascii?Q?lyKU8W+a9ZHdEP5fqG4Tm7y2jkYDitlLXwGfCHFGc1KI/K36XXxjW+Ll2D4s?=
 =?us-ascii?Q?hImQOkpGlB5s1car9KhUUnp3tJOnJcKPyiKHpuMuQC87AdDvhAeUEX+7x+V+?=
 =?us-ascii?Q?tpoCGF3el7U/Ycjl+aiVShICoNZjxCmuhHZaZp8reKGsohf4L+tIA5GeX8/z?=
 =?us-ascii?Q?/+OCIJhYCJvHGsIIdafMRZpz7OSXFgrvQBikyLsg/eU3xva/ZeTekdBGTgOi?=
 =?us-ascii?Q?LRs9dDlx/vcTuf5fM0+r/ZFAc2i80eNLOt2++WD+w7Qd4wF/jUL6ECqZOUvF?=
 =?us-ascii?Q?PCdqWpoYB7Kkw3iX6F4n/EGHA14MmlSni8EpGixbxraTvr/hypWVmrjXFE9n?=
 =?us-ascii?Q?Mf+D83JMQ4RUMAdJcXulqk8tPykXBWgNcB1oVTfXRNSx6o2j3AxWKgfh3PRX?=
 =?us-ascii?Q?Y8/mMiUHB/dXeQABqJ0bL+Gn7OCnBzbUeJYdUzYaaUDPb0V1sWcJbkmexrWG?=
 =?us-ascii?Q?Y+AlCZlnM0F3lFs8HMQDmVMLtcdIKwt5U+PrF7sEYACsbxw2aAtp0DOu1oYH?=
 =?us-ascii?Q?DJRAmIZxHLS4H4llGKsx92dIYWTUBl7kDD8m6wMR55FcnloWHHLJHqeBmo3C?=
 =?us-ascii?Q?mXy/DCnj+sa7d1vpOd+pKWXkrqBQwlW65Twwq+owRqcA9Olf5nOO5ADhHVQ/?=
 =?us-ascii?Q?aYkA8TmQfYxRl+22Q2n2M4/Md22h+y7Q6gaXfFLFOPzw+ccl6qqaHocncYZe?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IuHTkn3AHrjSk/b7bq/pvcxrQQDf2pePE04PK1gb21HcMH3cb8+tzTFMo8CB?=
 =?us-ascii?Q?05laWE3JNbVwsBk/RxsPrJVg0Dm2b2GZNHPdL2Zx7XGrnZQ4pVLzv2p9sqH8?=
 =?us-ascii?Q?d1+Qby2/oouTyHvCwS49UjZZJSbAsTAFKqrabYMCTcDWT3OoErh6TBS4TIOw?=
 =?us-ascii?Q?v3D4weCqlORvxeJbSo0P8xsnhh1kRb8ksuBShskezflU1a3e+RqzA67aEFGv?=
 =?us-ascii?Q?4LVAOWh/TAE57hLa6GTrDnoZWVAXSJdb9CuJjSdoTAdjLfaGb1AyW0l5ATzs?=
 =?us-ascii?Q?8JCFoIHtDcj1Wh+UvorFx4OLdyenv+c06wI+hnYnz7ohGfeqMbB5GxPB6h1+?=
 =?us-ascii?Q?yFfHXsbd+6BumFhEN+7oHZRSzTq0DD246OB9SBZ+gnCRAJmc71G6398MrsM3?=
 =?us-ascii?Q?q4r+nBvujciAJooz8mIGEyTqZB0NW6y6aLbkjv0FCEMsLKbMtaVsrygZs8LN?=
 =?us-ascii?Q?GBVMoQacXUtGpW//Sqde3omEpDFDnRouBk7HBPLmT9HVWee5WG1o8YRjOL7C?=
 =?us-ascii?Q?nuUCHn6w1OYGeq19J0Bq8tsEk4ltskgTuzVdUKbCmE9LhiiGAwip0uh5w2g2?=
 =?us-ascii?Q?3vJO80Jip7g7H8NeMBSOa1G5PVPBpaPsA8f68aIAk1ey9H88G0PICcJFsohz?=
 =?us-ascii?Q?btYlXWqrGiyVjpmZlGXR+Rj9Jbz3LnTDySDGtkjCLd2mh6ZwERGqgG4c7l4a?=
 =?us-ascii?Q?ko8vx0gpv9mAMsbSE9LmjwfSPHhaGnC83OtA+urI9MAj2gEPUcSZ94vzDvlN?=
 =?us-ascii?Q?9qOQzt+fonpXjV7M85M5EKTpDVSQG1FeExV9TOkdMPP6kbNvPPURycz/Nbem?=
 =?us-ascii?Q?2QWdV7rGGHGNj87rey/ZxHU24kQkmNSuylmBoNRMUkD2WRNrDagyA9sRj8A6?=
 =?us-ascii?Q?eij2EFRRnglYELkfhRH+027EavJqnKdzrvXuELrYvW6jtSNnDYoti1SwzeR8?=
 =?us-ascii?Q?t0bKnn7lad9a9EnGSl2NEA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f81b33-031c-4e09-ed51-08db1a751645
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 16:50:39.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zn0Ha6flOsjw5/zKg/6OTU3CAZd8GJ2iFoR/O4oruOiXuiVdpUdFgCjH33iR85cqa93AGXYJS/TV1XBeEe5j1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_13,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010139
X-Proofpoint-ORIG-GUID: UxF1V9mFYu3ohzQ6LMBwRj6jrcPLgJIK
X-Proofpoint-GUID: UxF1V9mFYu3ohzQ6LMBwRj6jrcPLgJIK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <oliver.sang@intel.com> [230301 02:21]:
> 
> Greeting,
> 
> FYI, we noticed Kernel_panic-not_syncing:Fatal_exception due to commit (built with gcc-11):
> 
> commit: 04241ffe3f0458d54c61cf6c9d58d703efda4dd5 ("mm/mmap: introduce dup_vma_anon() helper")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master f3a2439f20d918930cc4ae8f76fe1c1afd26958f]
> [test failed on linux-next/master 7f7a8831520f12a3cf894b0627641fad33971221]

I tracked the problem down in that commit.  The fix is simple enough:

-----------------
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -802,10 +802,13 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
                         * If next doesn't have anon_vma, import from vma after
                         * next, if the vma overlaps with it.
                         */
-                       if (remove != NULL && !next->anon_vma)
+                       if (remove2 != NULL && !next->anon_vma)
----------------

However, that will not fix the problem in linux-next or linus/master
since this code is completely changed shortly after.

You need the fix from Vlastimil (Cc'ed).  After cherry-picking
07dc4b186203 ("mm/mremap: fix dup_anon_vma() in vma_merge() case 4") on
top of linus/master, I don't get this particular failure anymore.

I do get the "kernel BUG at mm/filemap.c:155!", so it might be masking
another problem. (Added Matthew to Cc)

I think the right thing to do is to include Vlastimil's fix.

Thanks,
Liam

...

