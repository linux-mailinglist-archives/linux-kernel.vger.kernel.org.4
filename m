Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1985BF43A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIUDSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIUDSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:18:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC306F253
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:18:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KLO9AE006581;
        Wed, 21 Sep 2022 03:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=ocEWT0ccW3bpxgznQm0Rh7Tdh/K6qTcT7hjjEeYMiPQ=;
 b=0E1uP1gHhSX7nGLy+XU/MQtYlnayd/3W0xtRSh7x4gg5uWIoM1anZ4e80F/ka7SDfaVH
 Rh02ukuPp1kz99lvwZNp5W4W5flLKLr0ipXlZDxj+S51yJSVJZWnUw7RSJr9A+H1J6Xp
 lJQ2Oa3rbUuVP6RyUCrH+8ijxCXycwxxsuYPaUhSEmlGoGFuvjczYALSM/D2WiE3numf
 dZnW32YZIaj+OhNNiEVscIG0spdHnIqmj+rRAex637E8qFPoRPYuYi1SWm1HAJKgXkCw
 W2PRPdAjzTNCthc6XDzNRjLRVX+OGyN0QxdQW6xAq2xR9Pi+wcQBbACnIG1lxNGEIjIA HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69ks0m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 03:17:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28L27YY5027850;
        Wed, 21 Sep 2022 03:17:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cnyqvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 03:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPuJQEzGVOl+Tc1xTLLorCUTCD9/C0AuSVfJAwA/T+DrAzhs6U0dBqbrFAzCjgr5QqISeplX+ze14O3z7xmLv5FAlx4ZE3tetwvE+tY/q87L0YxzY6gOxu+DrF7PKmWzdG9jg1WxiorQQ9NaSGCEvLRUSvGLOVMblcQFlQRrkWChABfmRQu8yVyZbzMDwbtPYSoY9kOGfkenGLmiiDm0NrBoYDIcI/CxZvTht3vI6UYWiZO6QKv43cmlAU+tVsWXDcDN7do9AIbO+Ywua2ebszkhr8Gl3ObdiRXUhR0oOwfZDRvqyZBdPaJT2D+R2mEHLy59ZUgrgKq/+svbmpEXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocEWT0ccW3bpxgznQm0Rh7Tdh/K6qTcT7hjjEeYMiPQ=;
 b=MlQPUeRd4KEkI7/vg2gLIwurUctkAl45BQxhLkCTnQDg6BsqmJQpOqCxd5UcZPF3axjECmiMmZdQyU7n7grNiMHm0/h5MSubRggHlRMlmKED5ZSHnlGhV14b5DxkJMmRe9liDMDXAhPQfTs+0B6YJ/QPi2UNvPH6QXg4ko0DOuKZgYBc5rwTM1KQEt+RYDbjKbeNMlBVD8iw2mqKYa01/f0S+nMmoncTLMfnnDe3oX+JlSsBxMcbM0VTVYkPN3tbeQVWodGXEbDFtcXvpxf8pB6hpdWSZNo4q///JGr8keD1wVW0URr/JhX9STq1hTv5jT2/doDjo779LyUwAAEYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocEWT0ccW3bpxgznQm0Rh7Tdh/K6qTcT7hjjEeYMiPQ=;
 b=y5lElzy2yS4oZIIK7Sej+f2ZR5glKaIqPfFk3UuntZ5IwrodyuwhDf08AMmFwcX2szGV2lXekheAkIgsgo4Hp5LGhyO2tH8D5Ltmscu1NJBppm6vHmpMMJt2fIpzaaW86K0Bq0UbG9vells8x6DIz/Pxs5rPgvTZyn4S3WyEc+U=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB4932.namprd10.prod.outlook.com (2603:10b6:208:325::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 03:17:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.014; Wed, 21 Sep 2022
 03:17:34 +0000
Date:   Tue, 20 Sep 2022 20:17:31 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v2] hugetlb: freeze allocated pages before creating
 hugetlb pages
Message-ID: <YyqCS6+OXAgoqI8T@monkey>
References: <20220916214638.155744-1-mike.kravetz@oracle.com>
 <20220921014810.GA2053328@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921014810.GA2053328@hori.linux.bs1.fc.nec.co.jp>
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: b340c23f-29c5-4524-9e61-08da9b7fd373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WenjAitcpiQKaA9fMctlqK9nGXSCd1FHsOEONxuyEljxue4wPPQl7ZRe/Q60DUUd2wDtrdkDRy2jFsNQT2ipZ+etCTCbvmz9eNXvvD8Y4tCtXHeKTYQNr08f7HpdqBWGKujAFyTCNJVE6Pau5DjYOZg67fXDI7OPVTXW1dGhJ/f+h2rZOJkJ+zoUNLPvGjMFTCOMc5IfhDuzsfAjvsedpRWTshfceV459sAoUWWw5Jq4I2eLtT/IA1epvxaa8bgC9oxdsuQiwMlLQqM2vTIrSpMlSoNwOL62BnjvMoYZnCfXReEu+InxpoDWQMd3ZGE7NkcECiL/rggYtdw8KgnyASJRjPAeCM7dRB+oIFl1Etc5XPe3L2o0YJJHWcUEHlup4WCzqKoBDa2jIiFWqguRZ2f/EWdZ9lxHfK2r2WlGgO09QM0OtMgJpCOyT/cQaK8qp2+b3APqXk9WgZuNjsOvgSMkxLDcrMapv025mUSw+JGcWqzRUxtAm70bATUU2NfHIJFjsjJdc+/SlFr5IGFsGNUY+XV2MPc7Aee5SUmTNkPq18FtPXm47HRrXeB6x077HMZv0MlHh6p6fIE8+nqC4H4+FL6aLNr+FAi7ZPFp1F6TUvclRCt8cSGlTVdPmShcntexjXnSSVAn4hS2McvqkUNxUEcbaebCx3gW38kfWMwozmbqopt/UnDoFT7TwosTN5zLIqRbQb2gjGpUAvMVt32NNQmww0LpuhZa/rN6Zk3rhc6hFuBnbUVLjX8gok5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199015)(44832011)(33716001)(2906002)(6666004)(316002)(38100700002)(4326008)(8676002)(5660300002)(66946007)(66476007)(7416002)(110136005)(54906003)(66556008)(86362001)(9686003)(186003)(478600001)(83380400001)(6512007)(26005)(53546011)(8936002)(6486002)(6506007)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjA5Z2gxR01yMWkwK1ByNVNUNzE3WE5MaWZKc3YyMmRpTEo2aTk4NVdoR3lT?=
 =?utf-8?B?UEVidk5FMzNiSjRQZHZQbEthaVlzWTUrT1lXK3lCdUJWemR5dzhtaDNaODl3?=
 =?utf-8?B?cEhwMU5CemNVTHhvNitESDM5S2lENDFob2p5SUVmWTc0dVhvUDh2RkFSVTlp?=
 =?utf-8?B?eHZQOVYvL2NRcm1LdmpHci9lbGVyWUJKenpYd0JrQVh2NG53Mm9wYWJoaEZr?=
 =?utf-8?B?NUVsL29xeWU2SFU3RTg4SEEyV0VmSlBSeEU2ZXIybEFKQUh0RW1JeHUvMjhz?=
 =?utf-8?B?WElBTTRMMUEwK1I5QU5vT3dTdkhNV1BOVGZ0QUJEVTd2eThvcHdFT0l1SmVl?=
 =?utf-8?B?S2ZGRzV4Zm5JbEQxU1hxVWxOS2pkSVk0YmI5MEJQZlJKeW1GM0tmT2tXajN1?=
 =?utf-8?B?OHA1YjVVeEN4dFR2L1pCMElubWUrbEZWQklBUm0zYUd5SXdUbStNUWlHMTFG?=
 =?utf-8?B?TWdxTjBVc0RkTGFxa0hHeVk1THFJbE9DN0w1NGhJbWFCZ2E0NUQxdGxYRE4w?=
 =?utf-8?B?WFFOSDNlV0taUm9BeTRVMHRMMk5GRndFS2dZQjFGQVFtOE1WajBnYldOOGRx?=
 =?utf-8?B?cnRGblhWQ3RFeTFZdTZCbzNZcC8yRjR4dnJXL2s2Y1ROU1VHSEdLYUp2S0dR?=
 =?utf-8?B?SkYyaW0wSE1VRU5xTDBYVlBwQlBZQXRHRGlxSUlJVjBlaWx1ejNCMnE3VTRv?=
 =?utf-8?B?Ti9vSVdKQi9qQm0wVGJoUHdFcStVRHhGOFlVLzcxcHEvY3EwRENnUzhPdWRm?=
 =?utf-8?B?TWhxYUpGMXRFdmRMbnhuRlAweGpTZEI5STcvTXBIOGdsaTg5WEJnaTZCN29Q?=
 =?utf-8?B?eDZnV1N1MFlSMjZKQW9EQUxncWFxNWtoNDJSeGNtTVM0SVFCVXc2S0VrMTBv?=
 =?utf-8?B?ZU4wU2Mzd2NhNU4zMkk5dnNtU3hCbElNRXJFajB0YWd2aXFmN1l3S2g2dkk5?=
 =?utf-8?B?LzJKNXVudXZhckRaMEszemJSN002TWh3cUZ0ZEsxWUFIM3JDakFKTGNMVnpE?=
 =?utf-8?B?bGJ4dDNyZUNTeXVFQWY0T2pQSFo1YVJOU09aTGFEOE5GK04ydzkyMjUzY0J0?=
 =?utf-8?B?SmhINjltSVdTcnVmN3A1TzVucGZVLzFvcUY1YTVXK1RBUXJDeFFEbnc2aTdC?=
 =?utf-8?B?V29tb1FjbzYrRy9JaTVGRXlWVnBhWGJCSjRtWnVlb0l3QUNydEJFU0lzQVd0?=
 =?utf-8?B?OVkyc1phdlo5ZWpWQjIyN1kxSHNheE95VEJVcHVxTmVoY1JZREVuNzhub0J6?=
 =?utf-8?B?VExCRWNnS093ZE1oWnBkSERNOVpONU9VWlpjYjZiaUY3cVoyTE5sT0twWnBq?=
 =?utf-8?B?MVNaT3pUVkgrVTRWRFhJQ0s4Ny9ZeXBsWVFLS2FVWGpxbHY2TUduY1crUHBm?=
 =?utf-8?B?MW8xSi9Fa3drNHdQeFFmUGFMY0ZCVzkzMFBqZThUbnZoYTNRdC9JenZUSDBn?=
 =?utf-8?B?UmNpV2g4aDhuemhNK0huUFdMMUdnTWtURGpubkszL0ZzK0dNZnRpcGx3WlFw?=
 =?utf-8?B?Z1djcFNCTHU2bDZZKzVqZzNzaXZpTFVjaFQvMTFwbmRGNmJ6UzVjRVdDVjBP?=
 =?utf-8?B?RHdoUW1RNHJ3MWFDRm52L25LTkRab1NJa1pJOTFmTUxyQUJXQ2tnQ0dtNXpX?=
 =?utf-8?B?WmhXT0ZxYzg0ZkZRNW15bm0yY2Q2bERLT2UzdXZaOGowWU1sak9WcmExTUYw?=
 =?utf-8?B?NUEzUTlYVFp1ZXAvWnB3UENjUEpxZHJBcjRMK3R1aGtVSFg1MC90VWo0a1dI?=
 =?utf-8?B?STQwYVpML2praDFUdmZOZWwzb0I5Q1Z5Qlo0WnI4VXowRnhBWVROLytSQnEx?=
 =?utf-8?B?dUFDdGV5K3grSG44T29OaVUxbDhaRHRhWGs5QzRFc1FxS05jYkY3UWZIQkFF?=
 =?utf-8?B?OHVOdWh5aE1wWkRCaUErdjVZSlcvazRQZGo3RXByY3hmRjlVWnQ1VEVYUStY?=
 =?utf-8?B?a0VxNEIwK3VoTy9ORGVlZFRsRjB5SUNPNUlXelNicTVuQ00vK1AyTVZQWmFH?=
 =?utf-8?B?YVJwS29ub0FNNW45dmZMM0VBbGE0ZXNmYUs5a214SGdHZk9lOG1TdWNzamVz?=
 =?utf-8?B?cEdELzRzYVdnOHQxY015MWtlSENSVXhobTFwOWRMTEZORmVZbUloU3RJdVF5?=
 =?utf-8?B?R002dnhXcXp1SngvOGNoSERKRG5LTk81Wm9YbzRDV3hnMmFCRTRhU0RLSVRy?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b340c23f-29c5-4524-9e61-08da9b7fd373
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 03:17:34.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlFCoLrxj36pIvd7G5/mhogqRqTol4gBkUExei8Va0DEkqLP6M3FSC408qiqC539GcSck6Bo3g12WCHXTVkpIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_02,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209210020
X-Proofpoint-ORIG-GUID: zQAZDb1zHDC9GArMDXEwI-iDyeCGvO0K
X-Proofpoint-GUID: zQAZDb1zHDC9GArMDXEwI-iDyeCGvO0K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/22 01:48, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Fri, Sep 16, 2022 at 02:46:38PM -0700, Mike Kravetz wrote:
> > v1 -> v2
> > - Fixed up head page in error path of __prep_compound_gigantic_page as
> >   discovered by Miaohe Lin.
> > - Updated link to Matthew's Allocate and free frozen pages series.
> > - Rebased on next-20220916
> > 
> >  mm/hugetlb.c | 102 +++++++++++++++++++--------------------------------
> >  1 file changed, 38 insertions(+), 64 deletions(-)
> 
> Hello Mike,
> 
> I accidentally found a NULL pointer dereference when testing the latest
> mm-unstable, which seems to be caused (or exposed?) by this patch
> (I confirmed that it disappeared by reverting this patch).
> 
> It's reproduced by doing like `sysctl vm.nr_hugepages=1000000` to allocate
> hugepages as much as possible.
> 
> Could you check that this patch is related to the issue?
> 
> Thanks,
> Naoya Horiguchi
> 
> ---
> [   25.634476] BUG: kernel NULL pointer dereference, address: 0000000000000034
> [   25.635980] #PF: supervisor write access in kernel mode
> [   25.637283] #PF: error_code(0x0002) - not-present page
> [   25.638365] PGD 0 P4D 0
> [   25.638906] Oops: 0002 [#1] PREEMPT SMP PTI
> [   25.639779] CPU: 4 PID: 819 Comm: sysctl Tainted: G            E    N 6.0.0-rc3-v6.0-rc1-220920-1758-1398-g2b3f5+ #12
> [   25.641928] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
> [   25.643727] RIP: 0010:alloc_buddy_huge_page.isra.0+0x8c/0x140
> [   25.645071] Code: fe ff 41 83 fc 01 0f 84 54 94 8b 00 41 bc 01 00 00 00 44 89 f7 4c 89 f9 44 89 ea 89 de e8 7c b9 fe ff 48 89 c7 b8 01 00 00 00 <f0> 0f b1 6f 34 66 90 83 f8 01 75 c5 48 85 ff 74 52 65 48 ff 05 03
> [   25.649006] RSP: 0018:ffffaa7181fffc18 EFLAGS: 00010286
> [   25.650215] RAX: 0000000000000001 RBX: 0000000000000009 RCX: 0000000000000009
> [   25.651672] RDX: ffffffffae3b6df0 RSI: ffffffffae8f7ce0 RDI: 0000000000000000
> [   25.653115] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000c01
> [   25.654579] R10: 0000000000000f90 R11: 0000000000000000 R12: 0000000000000002
> [   25.656176] R13: 0000000000000000 R14: 0000000000346cca R15: ffffffffae8f7ce0
> [   25.657637] FS:  00007f9252f2a740(0000) GS:ffff98cebbc00000(0000) knlGS:0000000000000000
> [   25.659292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   25.660469] CR2: 0000000000000034 CR3: 000000014924c004 CR4: 0000000000170ee0
> [   25.661928] Call Trace:
> [   25.662469]  <TASK>
> [   25.662927]  alloc_fresh_huge_page+0x16f/0x1d0
> [   25.663859]  alloc_pool_huge_page+0x6d/0xb0
> [   25.664734]  __nr_hugepages_store_common+0x189/0x3e0
> [   25.665764]  ? __do_proc_doulongvec_minmax+0x31f/0x340
> [   25.666832]  hugetlb_sysctl_handler_common+0xbf/0xd0
> [   25.667861]  ? hugetlb_register_node+0xe0/0xe0
> [   25.668786]  proc_sys_call_handler+0x196/0x2b0
> [   25.669724]  vfs_write+0x29b/0x3a0
> [   25.670454]  ksys_write+0x4f/0xd0
> [   25.671153]  do_syscall_64+0x3b/0x90
> [   25.671909]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   25.672958] RIP: 0033:0x7f9252d3e727
> [   25.673712] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [   25.677470] RSP: 002b:00007ffcdf9904a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   25.679002] RAX: ffffffffffffffda RBX: 000055c6ae683210 RCX: 00007f9252d3e727
> [   25.680456] RDX: 0000000000000006 RSI: 000055c6ae683250 RDI: 0000000000000003
> [   25.681910] RBP: 000055c6ae685380 R08: 0000000000000003 R09: 0000000000000077
> [   25.683373] R10: 000000000000006b R11: 0000000000000246 R12: 0000000000000006
> [   25.684824] R13: 0000000000000006 R14: 0000000000000006 R15: 00007f9252df59e0
> [   25.686293]  </TASK>

Hello Naoya,

My bad for an obvious mistake!  Note this change in the patch,

> @@ -1951,7 +1953,21 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
>  		gfp_mask |= __GFP_RETRY_MAYFAIL;
>  	if (nid == NUMA_NO_NODE)
>  		nid = numa_mem_id();
> +retry:
>  	page = __alloc_pages(gfp_mask, order, nid, nmask);
> +
> +	/* Freeze head page */
> +	if (!page_ref_freeze(page, 1)) {
> +		__free_pages(page, order);
> +		if (retry) {	/* retry once */
> +			retry = false;
> +			goto retry;
> +		}
> +		/* WOW!  twice in a row. */
> +		pr_warn("HugeTLB head page unexpected inflated ref count\n");
> +		page = NULL;
> +	}
> +
>  	if (page)
>  		__count_vm_event(HTLB_BUDDY_PGALLOC);
>  	else

It does not check for a successful return from __alloc_pages before trying to
freeze 'page'.  It should obviously check for page == NULL before trying to
freeze with something like this.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index db90658db171..a092dd639687 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1961,7 +1961,7 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 	page = __alloc_pages(gfp_mask, order, nid, nmask);
 
 	/* Freeze head page */
-	if (!page_ref_freeze(page, 1)) {
+	if (page && !page_ref_freeze(page, 1)) {
 		__free_pages(page, order);
 		if (retry) {	/* retry once */
 			retry = false;

I will send out a v3 (my) tomorrow.
-- 
Mike Kravetz
