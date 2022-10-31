Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612DC613E88
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJaTpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJaTpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:45:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837FB13DF1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:45:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJc005001192;
        Mon, 31 Oct 2022 19:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=N1qDk3SRQ2UISwmflARrVS0q9AQZ7NnfXknPn/LX8G0=;
 b=Q5Asn9N15cF7ljLuaC1pOiFg7giI6pVvmNt4KiaATEVAbWr9BQLL39RGvhl5hI4Sw97C
 fZ3e0zGx4bUDBZU6Y93ST0tz2zQ2Ww3C+OyXfH4KBMbYa5xkFPO0BOtM1JNuvpMyQ2h7
 oMRkvAmOVP0xoehAZtILUgtPZbIHtvDuMcPIZzPMKhQaK9wm166H542/VPZb2s/AN3Z/
 TsmnbNzofzUO0XhJLz6NsLDH6bpUVyz0FffOYjncdSTt0txkBolVdhWONLu2epMLDEi1
 Oyc67Ee1K+UypacBIdBvTjbf8nZMIAOfUJwnxQpUtwN2LEJ5O8RozOMLXVPLQvGiK8NE 2Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtcrkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:45:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VHTkr3019171;
        Mon, 31 Oct 2022 19:45:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9pqb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:45:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSLNkT/eXp+ZJYLlMimpCbc0HqvFlJ06xFauK2OhLxTJRnEvYv6p0V1aA9PIrw6sTLDwu2FygZpNRxKUfmlYHNFCK/TD6DwttG/1BKMVoP2yhblyXfokd68MfVPaT3dJXcV4jUoO1FnF+HZXYnAzHeGVI5M0u8XQadY1QpPvf1DMw28/e5m9/yhEIYiVB61HY7jhwuKWtRt7fMh/SKEKMes71Oojh9HxrkgrN0LfczHNAolx/4yGJbKmDupsaoVgV+t8ux7Jt/1XyB+m3aXqMo7KMQL3yd9sENXSpXmo+CIJIOXAtEM1b02mrI3swqLlPWbBzRH+YG5S2RsUh+yg0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1qDk3SRQ2UISwmflARrVS0q9AQZ7NnfXknPn/LX8G0=;
 b=mczmcPo+adnIVTm0FT7Chtxn3TScf8XNT1mgNo6oLLHktP0a18pN7b8oO2u9V3991XzKEo8lhGd/dTA7jNfS93uHq3wB0Mk/fThTDFAUxQBYnBFUj2EgzRicheoi24OFikIZLuiqjW9oIfXc1ElDoJMoVQyT4eXdtXss4rnn77oHSPu0IvVyktusUZ2setv7RcFDIoN9leurzOi9RBz2keIwdQPZcViHCi9335VM3a7gXr/mFW8ls5QHFJ+yI0MXBehRvCrKktk6fXfaJ3hs16ku7CD6SQyBu0+/5872JWgkCzVbXUk1ejJyfk6gtpQtu3xPCYzpLuVY9sdxqT5qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1qDk3SRQ2UISwmflARrVS0q9AQZ7NnfXknPn/LX8G0=;
 b=obq88EcC/W13RoaNlzFMBhLD5I7fdPHaurv5E6KvQJLW+ubjxfa65CNbaP4GiaX8ws1O/ZubnLlTSRfNyyyBqWkZifbjjz5K3JlJxyE3Vij+5r6R9OXqh8l541FF+OmZJQkRCNs89E4GTK7K++YtzKILcziCw7MJkvXnmTS1JBE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6804.namprd10.prod.outlook.com (2603:10b6:930:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 31 Oct
 2022 19:45:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 19:45:02 +0000
Date:   Mon, 31 Oct 2022 12:44:56 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 6/9] mm/hugetlb: convert free_huge_page to folios
Message-ID: <Y2AluO2/LNyyNKdv@monkey>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
 <20221014031303.231740-7-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014031303.231740-7-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0137.namprd04.prod.outlook.com
 (2603:10b6:303:84::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: b180f086-b65d-43ae-3a75-08dabb7866c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHiof4HFCBiPPsyM3mgEdfP6DiMeupHZ/o58+QjjMypinxOg27GyRo0OpKv2e24PC0wTp9q4Z9sYNUiPUI2f7Zt9ifPCPLu2Ccw8NCAtOvuHTntyAXUZNsnpFRq7AHImDwBVDRHv2jNM+crwCTAsQPIoNOB5/kKvyey1XJfwNZ9GgM4foh5fA5rpfQxjxfSiN6fOkPx9tAieRyDBs/cfgu8lcJaLDPJAQYOcYKu8ZmEjVN77St5/faTOQ/dfvsd/Sdz+cQZRIrutZlsZ5fCOudYr+B4yaPCPuCtsYkXROz/ws9HXfeubBk1qVB67xHxDrjQo+jPfq8cx1hg/flNLQQDyNPMiWG00Xq/FLsMqxz6dqIGA1hU3UINpu5ByuwiKLbBj3fkolRdqUqRRwZiw0lQ0moo7fum/Es46CIrG7394jxl6LxDGQjZ0dXaQCnafwc9Bj905QS6ahJezREFVYs+6iFvpVAGh4UBRjwjvvLeA0vUJldHKsB4PU1YQel1tMbe9aOqdnRKi+vGE7j07AlgSLxuUMwvWUjRY9rSCf4LlGpsy+o6e83V+HTepePwCRpwCAHAv3Lipqtay+oSNPzXvKsTcoQUUHowAw1tFzoDgOTdDcFIpFhupIpx7SCQqHcomCw82KDtTVZtjdwys2OKPwDwEoiVtX750BOlttCtZuWuTsYrn3MG6qmU0p5s9zPb7G8C89rDRjeqwihhFLNlio+mXAN5bCaohHc1z0f4fB6ysacGdxixrPpLaIk3p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199015)(86362001)(316002)(6636002)(478600001)(38100700002)(8676002)(66476007)(6486002)(41300700001)(66946007)(4326008)(66556008)(4744005)(8936002)(33716001)(9686003)(6506007)(6862004)(6512007)(44832011)(26005)(2906002)(53546011)(186003)(5660300002)(83380400001)(6666004)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k+Kx2252bGs8EitiwB2X9sLvg7ByciMtGxh5FQO9OIvJD0RCSAvvjV6+PcZR?=
 =?us-ascii?Q?BZi5kDODNYkEvM2IN+u9Jq4MKUQnYqZD+QB5iEJNRCrnjlPHESjAvuh3LGFG?=
 =?us-ascii?Q?4Q9igyMU4Z45gKIwucHGX3zKx/ZH7oQBq4TH/XJCH08hyGEf9rpkid2l9qRS?=
 =?us-ascii?Q?SZM4KkefgjmqEYemVg0phgFMaj2UCM07/IQRm/+9EctLACF6+++EJom1GaXO?=
 =?us-ascii?Q?C8k4z7WmhBViPwHr7mfuqFjPfj/3o22n05wQ9791nYeuWEV3GznGmP7RXpmz?=
 =?us-ascii?Q?6iDeDWNWxvfzPvo2MIYUyfDjUbNEnnqJ/Dpp2lSPBv4OYvC6FVe21gTauYy1?=
 =?us-ascii?Q?kIPkr98tAsI9iM5Wkk4GOZxB4kJU2srev1YdmrS0LMAA6Bqr4dqq0lpvR6sO?=
 =?us-ascii?Q?OdfrnXszG/pTZYAx90fZzonQBWD6fHsUB0teuDknjcEiTwkyu+qjjBwzQ3Tm?=
 =?us-ascii?Q?PBN/B7h2NjWyD4R3/7LP2m9uvHXXI1WQuoxmq3/fSzL1JZu65QJMxf73nUoF?=
 =?us-ascii?Q?EYwj4IITUNNQCmP+0LLHUq0EuhBxE1y9ze+AMDVx/Y6h/rZwL5fLUF1cKnn2?=
 =?us-ascii?Q?A/j8KKGs0ktxMLQgAEn0s1XPvO/kv+vFqzctHqrbUZ2fr36wxXr7dQnd+YMr?=
 =?us-ascii?Q?OsfbGkoBfTFbBHT1EWYJvNjX6UKw+9dohhDGGtKi5tjlNbj0+56e9zx1ooIw?=
 =?us-ascii?Q?zkW8I13a3GmnRDvKMW609oTwFSpQe9hvNC4lVQbX2jEp2K7jnhnAdrXXM1Jh?=
 =?us-ascii?Q?mbDAsQvFNfI0WcfpkBC3X9kBXeB59FMmbjH5kMujFjAyihywE0e16gVpyv1l?=
 =?us-ascii?Q?nmnUYB9r1g7BdFo8DgU8IH0xpCkMz2UxrRTayhbTU0AbFNX3yGudZ5QuKEmk?=
 =?us-ascii?Q?1Hignf7ItUnnfNUKGM54gjcy3dRXAJw+l4huiXa/6JAKi1y3HDGjnLDq7Z9o?=
 =?us-ascii?Q?snRDge345KOAgWvu2KRTEcIHDwmxX1zIHGC/0c2+gL0DR6945I/sCdEXbhtR?=
 =?us-ascii?Q?QC3UAOjO/s4sHTLJgN4jTMwX0/0gP3bp2+8MHqNJYS9eyLbJWpGjU3zvNpk9?=
 =?us-ascii?Q?v5SO5FouGLNXz4RIz/E2EJKT7NJQ/C1YCU5IfY4/EXyu/NsjcoVdB8L4pgdx?=
 =?us-ascii?Q?K5ocohIyaa991a0v+PZEcfoMbSJ+BFQoo7az+QXGlF/l3KcMy8MLoO5QZjHB?=
 =?us-ascii?Q?AteE9jlLwTQQxm2EJ0KNblVTNycagl+xBNdvriHjk99Y3ErW1xRLK8RC+DZO?=
 =?us-ascii?Q?DX7Yp3cHdUM6tKq0ZWrQdBhPnF/MV9HK+8xdXJFos8drm7eBACF7coh/j0Xj?=
 =?us-ascii?Q?VVw0e0yqqoUhEKl0wLWTamUDDrlJLsTkdhibqltfIQHn5HEcWVaybhT5j4Oc?=
 =?us-ascii?Q?5Kyw3sEVas9YnviicvN3D+VTEa9MKfpcpuVSvyuJFnZQNJhbyzwzFE3YOk1B?=
 =?us-ascii?Q?JmrDOCrpN5cmvGD39jrbQrqTv1qDiIr5IR/U1w7vftRhGdBU8M103fQTFqv0?=
 =?us-ascii?Q?ds4OVkXdcqNmILOCbdhc1vpPvR2DknXh6ZSSqpIKgJLpMz/WP/voBGXi8Dds?=
 =?us-ascii?Q?8EXbVOz2+pTo2s6PhrUkXRSBf514kA/KfeFm/Xw4+aMgMWDnBjcXI8yUpDKw?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b180f086-b65d-43ae-3a75-08dabb7866c7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 19:45:02.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REWg02mbj9baqFJ9cRJRPvC5YGz19Tu1EyzPs2+HHPB4Wnhfo4QjwaYjHAh74AtSLG6ujdTxSn3zT/ixkoVtjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310122
X-Proofpoint-GUID: nGlnOg0xRA5JnWhPAIWD40FVp7oHZo3g
X-Proofpoint-ORIG-GUID: nGlnOg0xRA5JnWhPAIWD40FVp7oHZo3g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 20:13, Sidhartha Kumar wrote:
> Use folios inside free_huge_page(), this is in preparation for converting
> hugetlb_cgroup_uncharge_page() to take in a folio.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)

With change from Andrew,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

TBH, I did not notice that when first reviewing.
-- 
Mike Kravetz
