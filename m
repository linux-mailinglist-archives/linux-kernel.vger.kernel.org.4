Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63A703511
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbjEOQz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243200AbjEOQzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:55:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FC77292
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:54:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGnKZf022730;
        Mon, 15 May 2023 16:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=e745i9dUClWwOU51030xlBvW/fQegvEQxD5f5b4x+90=;
 b=iYbPixg4/ZtXszeXFslp1NM2a5Sxfa8I11lOrxvtOpHfgwduN0QvTl3M4H+HCNK9rs9D
 DXHnxp90BoLCroekgrj+krybBdsJgFWdW1z4G1lMLrR4sCxJeUrxdOw3AiedV6g0P6MB
 oqjppLZsJNrdlmEC4eT90W8j+8pVlvhCkWhd31H3PaCsJ7SCIt54arlfxF1KVJxJU6r8
 UVTn6xtzapMJgbiJfyil3v+fMZ53LggsLmcIZbqGgABh2xz6ouliqc4ki0IzjDf2NH5n
 Hcjy6JBORbkqzINLIpw+Gs05UDxrC/Y/ytvRIFJxZkNWtRB8oVOfgvnUWjujI5Das9Ju lQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1b3rp9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 16:54:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGfnFU022522;
        Mon, 15 May 2023 16:54:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1096582-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 16:54:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpkCP2pjEJ1epvnhZSdI1ImAMdamMsBlQ2mnW24pHjUnxWVCYbVunlG6DasqsC+pknLVtTpRiuvMwiUZhE9TfRscVHvoM/reHDoTANNugQaS+TZ1U9vJCJZL9yYH2WQzUkkX3aNKUi2aV4oJXZGf+G0lPinXv4/9Iadxx72/f4MjVhRLXZt1ni0iN+rMm/RPDoNvhgvt/kqAqB7sr5Aeyl8nb4sFEWA7y20JCJ5iFUwLAEc+PU0yYfcP2djWbLmv0/F7DcFp+qft/w0qvJbL0bYy0HsOO639GgSJxs9eAaKBIAV6Y22n5YDqWkE59Q9OfnKlxGIcFRCJQZVFcAzuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e745i9dUClWwOU51030xlBvW/fQegvEQxD5f5b4x+90=;
 b=eSZCYT5OoSR//qlH3AwyWo8rX9RFsBNM432pDs9Lx4Ff5GcFsDzCN9jYRnlc+bB5ens8b+TGJ162HxazRlX0tEMFZlGNQHTL/Cfyfe+Ijr9UGRjn365Vk624WHGsxIAEp6Snnz6nZyVHjqCiQbgaie12us+7dANgOFqTgTByuW5jADBj65e+aYPZDCUQeENF10DVrmnl/2TCCjqD9pxd3UgJbvEfeB1hFY0ml3Xxz66rO8uYQX9ekity7tqn+vWc0hMU4NpdI1Va0J0E5peKQUKVunSjDlKpDeA8qCj8i/12EUwkVURCcnnlVrH7nqiC07D7UhMT1VNT3MpppEKzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e745i9dUClWwOU51030xlBvW/fQegvEQxD5f5b4x+90=;
 b=MaRXjmfMDPlE/WKYWLlwJWuYrpzQuVVpLuKT39+IIYi/tsG3xaPoD8gamVVv8TitzK39W+Kv101Ih6/QbU+1WEflm7b7hFfqQRpxWcJN7k22afuNbrYu1LoeN17COSgYF+pNucYC1wQISFaPn6pHOTRv6KCxtHb4ii1f+XhFsps=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6312.namprd10.prod.outlook.com (2603:10b6:510:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Mon, 15 May
 2023 16:54:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 16:54:16 +0000
Date:   Mon, 15 May 2023 12:54:14 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 05/10] maple_tree: Make the code symmetrical in
 mas_wr_extend_null()
Message-ID: <20230515165414.6akosqad45fbr2f6@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-6-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515131757.60035-6-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: b392b15d-655c-46a3-ce73-08db556504ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XyDgBIqQHFUhd76cKmYkoAqWkaVxwE6V4EPuwzyilvE0vvgoMRvDcWcOf8+L4ORFMYXENjMlB/C8gsvAZpZjqYufUB0h2TMmL3WuAi9NYje7BdfJtBtTLGXKicp8zSXza7BoHHfiLy9aTw1guOrk7+1ApwHNt1I1cthLZ2dy3VJZtZCpac8rH0VjDrmf6Pt7dR0LFRwYmtMJh4fShxKbaR5Rrx4jhkw4Z7jWcI5wlmXBJijmeO2UY23Yy5aLTDqJ4N9m2ZAaAh9XFpbhpqcW2iG7hqOdptAJ0H6VfrJW7Z8xjN9niQyRKq9lMqORABmrgVJeIGXrLTpdQkAQEhac+CjKnuit4UIxkXcySMqn2sVwvY/aUpp7gQYvIL3VSXbjYXPWe+tTUWvvwVn4mH5PFJiOlaeTS0UEmXwS7KjuTqscM2ATP5PgLvfu2U+3oOlSFoomsYIIBe91rFZ8fGsiZtDW38CLnAqTxkwQLRbp6j5ScBAiCWpS1KogQaPNrJesROH5FRiSnZVN+liqM6Nm8locHaL3TF/t7CVkaCaZvWfceX+yn2rrug2Sp6irarBz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(33716001)(5660300002)(6486002)(316002)(41300700001)(478600001)(6916009)(86362001)(66476007)(4326008)(1076003)(83380400001)(6512007)(26005)(66946007)(66556008)(186003)(38100700002)(6506007)(9686003)(8936002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aLdrFtktLnUSyDaj2CvxhgHWq5klkN+qy48o6V42w9Tp4siskWNeHP7X8vvP?=
 =?us-ascii?Q?iFgIRWiPov75+cQsKFv5miStJR1lWXWSyFsvHqVycDEHm4l6OPmsTuWfzkMu?=
 =?us-ascii?Q?Capy4sKnvJ2j1hjd5okJ+XcaKxWaxfZ3eIxw/oD3lPy7/FcfWpp1oEUpL05D?=
 =?us-ascii?Q?lccLMSwq1QklCyvfvV6GWBDLPn+8zozDqlIaDgw5oxW7Oh12+siU+5+RU9xv?=
 =?us-ascii?Q?dBiZTYF/JzR9UTnGgsaEHODGSFxjrgvMygNBAayhIXnX1jq7MxFeOB6hk5ZQ?=
 =?us-ascii?Q?L2teeukhF8iaaa3WzTJZAYJZFicm3DZT1Rv8wIs9ODIsAXxqxicZHz1qvzne?=
 =?us-ascii?Q?MT3auIiUQnLvNfTv5BOpJ5xJwv+EmShOgWlrxowIuOWtRxT1UVaalmxhZfQD?=
 =?us-ascii?Q?s1ievXa0pN1gvawwfJyp2YF9s64JaP059weFMKsYqqPrFYNOj06tHL6LRsKP?=
 =?us-ascii?Q?QuRmZs9qG3cxTfIGFyLKwimYTbJB8GK+L3U8/P5gzLdm+PSSptVFAZlZ4pTo?=
 =?us-ascii?Q?YMBfIbaivWnZ7ZQzGT0PqyoXNTjTiv14NBU3ueJLYWttp0xWKZiIWPtMwwcG?=
 =?us-ascii?Q?fOx3B+q1ylzPN27WNqQZDFC3pv7+Sfm5cxNtXhi+3R0BL0h0rIytdvKD5Y1T?=
 =?us-ascii?Q?ixEn4kzfkPh7bpPBd6lT7GeSgM99ywsswkXDMuz4fmxzM7wvnMQPWiMQmf40?=
 =?us-ascii?Q?2DDmLDC9XLtAXrfctwpwpFQieRjgMg1WNKIbN7GTiJod9OvdJRC87xAS4cA5?=
 =?us-ascii?Q?oZi8hGpLC33+D9qItq+Xnuta5Y3UulF2jmSskDcwRrfSyWGNxPLkDwb/HnHz?=
 =?us-ascii?Q?lLDKyUG1kiPUfIOwiBSbwL1ELDdkqO13mDVBV2vmRFiU8Hd53y61gvMPAsPo?=
 =?us-ascii?Q?/FXTU0rM74fA/t2F0cfTiZoYSEbI+KwFkXGOToeo/iNhunauteCWyoAcNdsw?=
 =?us-ascii?Q?pu9Qz3W8gqwxDvU/26CH1iZAkV7l1rT2tGi/xCG4HWHH47Vi6uVv9h3izF0V?=
 =?us-ascii?Q?TmLMljb01mF7OR+tOYUaa/Vp4of2dyP+kWTFdqABtXTNUUVsB9Dc3QPS+wve?=
 =?us-ascii?Q?8GdaHrxeFxi2mBTTZzx6mfhgY5TwuvXg+enB7B7VhWPuvPEWIDSIevX09F3G?=
 =?us-ascii?Q?b/z6qO9VnJYeu9+3YEgkRREyDv6ux/89WWgW6oI64apv2TqWf2c8YLQSCACj?=
 =?us-ascii?Q?wV/J6YfY2J2aqT15KNPii2mANVgLyo4EKtw+GHt3l2Xvei9L7jSdquLzXctD?=
 =?us-ascii?Q?aaKhPhD97+C5Pg37csF+uSE7Xuvw1TW/VruS4P91pVqXyMx2+M/lquaCp//1?=
 =?us-ascii?Q?m3OJzugZsAaFse/R6JpYRscyLzdEWPQBW7Jhsf8UOHyHPzFd052S4AhUqjvZ?=
 =?us-ascii?Q?eXYNrphxqNMlZYMAM7IClyejBFmTy6RqceYxP4M3zXqGEgxoPlItVj3rJkBN?=
 =?us-ascii?Q?77ISoJTWRO4fPMWMYaSBmUwQCPrWOM5lfyyS6g7Ky5JI2xCES7RKvSkr6uDn?=
 =?us-ascii?Q?79T3rvZnn9/O6BUQCpbs8bcq2YIPBeoxt36b+ooskwXu/Cm8VX53rRV6Thw9?=
 =?us-ascii?Q?1mbmxcJgFFC2OwvJM4eq27LV/XZ6aZZWf86E6LbeqT6V9SJtsVvJ5qrpfOEA?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2K+1I4HzA+n2w12Vm38k6TkMsn3lNY9gMoIJX/Pi+5dcN83yGmYQtrmsBoij?=
 =?us-ascii?Q?NgtmtSE+C2KIzVducgpNZ4Ro1JKkvC3FkQwglG3K+6DwEAmUg8BI885Qgq/s?=
 =?us-ascii?Q?Y9zEn2Xv07g25BulXjMUyDu90+38VWbodDsibrz7qE56ha7rU9cVZgb1Krpu?=
 =?us-ascii?Q?pQWQekZ4yWbj0IkKS4/xmZFS0zpbqVSo0ZQqFgeM88gKQFDNj5INHbOIUklQ?=
 =?us-ascii?Q?1Klilyy4EKEfA0Dwcw5AGU7kqIeaeLBJG058K+IuCCaTJL+xVJAAf5SS8plX?=
 =?us-ascii?Q?R0JsQ3G4e9etlHv35pWdtvEJvefiWvgLajVWf2OQC2U6hQ8RPCw2XNyY17Qa?=
 =?us-ascii?Q?rpdx27oR3o1HkCOVwlvxsmO9YgVG4L9FhwNPrszaoqv9f9NWMxAG29Q/lT0O?=
 =?us-ascii?Q?RSYEP1J/8iCq9xFV6hfLEVh3zxEMG2UhcXrXYRoU6gNMxR5V+8kWdhvkmDgg?=
 =?us-ascii?Q?NB957jyEkvgXIBChTN9MYJ29aMD5I1t12Ii11z4uod9rau7Ms/CeZkDc8PMw?=
 =?us-ascii?Q?YkumXR+7R/ymldUSt7lrOc6WIaJEgEWPLEawQ7TR+QMCZR6/1qeo0BrIBc0I?=
 =?us-ascii?Q?piMxuCwBCQHhjgPo6vEqT/6FJHu2pIZuVmg3PRRQ/ViMChZe8BB3ylP+B2OP?=
 =?us-ascii?Q?SMwtHtnzZiAlIG4kgkkmI/yK+TsTwj5s1wYxyL6vUyz95DT4ogMCd5qeyTuE?=
 =?us-ascii?Q?GsMWbs6OHmyX+DmiKjoBJawDG0rj9ilMEms6b/6vBIVl+zZeAVIN+0UhoS6J?=
 =?us-ascii?Q?nYeUUF+gmrgSXEvRBqfEgipWcrGPVdaUowR37nz4DwRpLZISnDEMJT5YgUMv?=
 =?us-ascii?Q?NkA7Y6L3xSTpR+43dpmxb0Z33FPN1SSSEBtbPjaFHHfFERaZfAmS4NNs1WOz?=
 =?us-ascii?Q?/T/a8Y7YqF7mMUUMIThcQQCTPPeLGXcqqMa6UOfwtQArFutEIxn97qtvAxNY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b392b15d-655c-46a3-ce73-08db556504ca
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 16:54:16.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiVw5dgO+uPFXHLQ03l50dpKHWDewr5QQZetcVftM7OwD+vw26nQ+VgHvI5uRPBtGPtQ/3ZneElUmqdKGvhQ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_15,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=972 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150142
X-Proofpoint-GUID: nEVBNRpBSzZgFwWdl8PbIF6TTw_4iaoT
X-Proofpoint-ORIG-GUID: nEVBNRpBSzZgFwWdl8PbIF6TTw_4iaoT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
> Just make the code symmetrical to improve readability.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index fbb6efc40e576..4c649d75a4923 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4256,19 +4256,21 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
>  
> -	if (mas->last < wr_mas->end_piv && !wr_mas->slots[wr_mas->offset_end])
> +	if (!wr_mas->slots[wr_mas->offset_end]) {
> +		/* If this one is null, the next and prev are not */
>  		mas->last = wr_mas->end_piv;
> -
> -	/* Check next slot(s) if we are overwriting the end */
> -	if ((mas->last == wr_mas->end_piv) &&
> -	    (wr_mas->node_end != wr_mas->offset_end) &&
> -	    !wr_mas->slots[wr_mas->offset_end + 1]) {
> -		wr_mas->offset_end++;
> -		if (wr_mas->offset_end == wr_mas->node_end)
> -			mas->last = mas->max;
> -		else
> -			mas->last = wr_mas->pivots[wr_mas->offset_end];
> -		wr_mas->end_piv = mas->last;
> +	} else {
> +		/* Check next slot(s) if we are overwriting the end */
> +		if ((mas->last == wr_mas->end_piv) &&
> +		    (wr_mas->node_end != wr_mas->offset_end) &&
> +		    !wr_mas->slots[wr_mas->offset_end + 1]) {
> +			wr_mas->offset_end++;
> +			if (wr_mas->offset_end == wr_mas->node_end)
> +				mas->last = mas->max;
> +			else
> +				mas->last = wr_mas->pivots[wr_mas->offset_end];
> +			wr_mas->end_piv = mas->last;
> +		}
>  	}
>  
>  	if (!wr_mas->content) {
> -- 
> 2.20.1
> 
