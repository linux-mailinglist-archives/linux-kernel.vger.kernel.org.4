Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83BF5B8F01
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiINSn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiINSnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:43:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9093479634;
        Wed, 14 Sep 2022 11:43:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EIUtQs026519;
        Wed, 14 Sep 2022 18:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=OyeFm6bnERPJ30RlB5vaLwq3t3uNQr23bGheHrRS04w=;
 b=x/YvSSLqAcDXsgVfzMMLsLujRRhvIJMimoi6iOhMnvenhnz6WE+0voHrpcrgmb1knu8Q
 lPpnVuLgN+ZXVQrLR6un2cb6wvSy7KLaLKagym7k+SR20teKvY2x8q/147qqL68CyP8w
 AjSwQcpVekxmqnMAhU6umy4AB7FK4QqaLPDF+oL12aiejj6N8Z3/bTJlJjhJbW06EAxa
 OZQx++5ulI0AJK/+zd36sLvCySAw9QcEo2PqLVWQ21l+CveAy10ygkxEAxYthB0bF1Ni
 hOK9O3x6EmI1dEUgOx4SpqJBMQT72TAeIfa4pEJ6QHzZdrcpyNZ8OXrQ7me3se/TdIat Og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxycb68t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 18:43:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EG9XT6019446;
        Wed, 14 Sep 2022 18:43:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjym4sk8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 18:43:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLBL+VV6h22xIJMS7dQ5hSYyZYD/QWPEgrMlBZsKJ3CHpb1flgEfDzRPFosNjDmZ3qf6quz6zEYcgCnwVKuENVeJ+CMzP1V3c4RlZ0CaD7Y9G55TLK4UCfPeu/SY1jUFKLYSRk0cCAQKLTpn7OpGkCn5p06pGAiMHZ82rko6jzj0DXFVWfw9iIkArkxB70CGrZRHh3mtpaKwfVGYKGgCr3tMblPrts+3YSfdD20MQpiSTEJ5uFJYmfqxN+mwPlHSl4NrLz9SS7DcH0dmYyMSnheC3q2az3kW/AcEkuB1V35gcoAH7EhwlRGOhnb2hFSQB5t9/pnYxIKibgwSlFkR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyeFm6bnERPJ30RlB5vaLwq3t3uNQr23bGheHrRS04w=;
 b=gru3g4pnspXGmciSl30BDvZBMpIZMrSO2NfGaTzR2o55+vPaIrLvqpaa1qsM+xYtAE9xX2+ZkZ36T60eRWZTYxd3OsWKtf4w5IBzNFeHEVD1cI53TuyDPxATsdKWv3DOd2qe5Ru6mLooKMjdGtL8c+30vqERf40MJSQludUlaD+hqBNdDnEWsPn5X7EDu0H14iDroc/jH0jVX2wYAtbiqFOikgvRF2+kBJ4AvLbiah/mOVZqLI04bOEly+cEaEEM1mj2qwqMdBQW0ilKrsE4osLxIY6pWmyGhRN7DY3ogfDfmWpsVKKKr02UWcrJiMTX83LVsBNHL6EDcR/Z4L4hpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyeFm6bnERPJ30RlB5vaLwq3t3uNQr23bGheHrRS04w=;
 b=e64pzSSQ4WZ5jRbmqPgAHhJzgr3Omz68fgtBWaO0hbPlPASj8+xsVGBrrGHqZssr0aofGZwBK+FE3Xqn81yNb9E5/quUTFHar2u9w4dwODleKTd+zLdngAtmrcy8oVVfqEGiyCNmird3+eE24Sjio5AL4E/IWuHJfONzJjAHvUA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB5993.namprd10.prod.outlook.com (2603:10b6:208:3ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 14 Sep
 2022 18:43:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 18:43:09 +0000
Date:   Wed, 14 Sep 2022 11:43:05 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Doug Berger <opendmb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 02/21] mm/hugetlb: correct max_huge_pages accounting on
 demote
Message-ID: <YyIguZbB1KzaOJRo@monkey>
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-3-opendmb@gmail.com>
 <YyIN+bpKdCb3JuuY@monkey>
 <c4d40567-6ac6-d822-7098-a5ad1ae567ec@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d40567-6ac6-d822-7098-a5ad1ae567ec@gmail.com>
X-ClientProxiedBy: MW4PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:303:b8::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5257a5-4447-4576-e44c-08da9680f807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUyvpxM/xRlFtaqW23r4qmyIqFMPe9+vgj8p7w1nhIpjqLdqWPGcpKPwDDKt+jg7/FQ56PuLLhTnq+oCxsucI59vD3OgC4dQ/CL6lTfldb2o8wghznfxc4EPaEfKb5lGXIf/4dGkPqU8S1wljWj1pTcS9CJGYonR1/JtvmMEq0kFdOajfAU6PSBQjquFqmFmBJqYQGKESxzmUH1dlitzyicsFBFqDxmXZZ7Itz3aXUIojA/5dgVGMR0nZbCYXm4T41lcDwZQFidje/OcmrzStoCvQYHQLXr02pHIBQZFS282KJXmdUxZHZGzLO57YGUQFYYs1boyOp2x7D8m3+2B3riUZYO2eM1gRPPdsm+dAUXIt1ad3K/5SG+6E5LkE1S5niFmJbguqT8NqID/rdh4sOgMyE4Wt74XhTnTwuDDAm0iuWNps2HHr0me1f6q4CaZVfkdlQfFgwkJwxSWN/T6VJwtzPxR5bKJ6mtXN3ftjLWjhkUVtoT7FwTmgDuYAIe6cUfTUvkK6Epj6GkH+rR489Sm0kYf03oHH+uTqa3RORNekRqJTMuxlojd99xshPnjIzF8fTcF7ORrzbJQoAtN8ryBOQnGNx1NAl0L1F6bz3M3M5RG4wmaYKyl/GtwArrri4wwICPoqsfROq3KJKimXP6QVyrsNWcP50C+av746G11NPL1GShjd38L9v0iqu6CsJhdVv8KdQ+FzKw19kgkbr8whBwYTNPUeHMn1Jcwmp1jsMSHmqw3WSOqH9IQgR6nJGg4JrVeYf9WzQDrn/HQ5Ff10LEkbeqD5bzzGoEe/U3ys4hb5DYD/ORM6825MRoT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199015)(83380400001)(38100700002)(186003)(2906002)(33716001)(66946007)(44832011)(7416002)(8936002)(4326008)(66476007)(66556008)(966005)(6486002)(316002)(41300700001)(53546011)(9686003)(6666004)(26005)(478600001)(6512007)(6506007)(5660300002)(7406005)(54906003)(6916009)(8676002)(86362001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q+6NI2FzxfBAe0ZwEVHt5yFlKNC15j/k5nKtHwy6uKD13nrFMjqeEaC6Fxiu?=
 =?us-ascii?Q?8gS+gxKr2g6tfs7w8FoxZNIh7Od+0IXx7xiSDCsrZlIcIqGQtXkATYPZ1xdn?=
 =?us-ascii?Q?gpwzwb1RgI0dEvd/vIsYkdCN92xlSrgvFQkZsfaVfjtxEQ5ZOkKqfZNlnvPM?=
 =?us-ascii?Q?Xg3+5ulZoPySvyTj3H5Dvo+lNC6GgccraebPUGBchXsC4N/5odaPmh/zIE+8?=
 =?us-ascii?Q?kneJZ7EztFt3TNYZl/vwkYrZ34dtw+Zr12y6Haso5k3FBys8D1EOt2LIRfZU?=
 =?us-ascii?Q?IkO9xiBgFGq4g0u6A+LHxF/SfOgB2bbJgaPCZJkSl/zBszfwvFK13WlPqueG?=
 =?us-ascii?Q?TR7CC3VH/t8Qgbrp7RmAZk0bqsjgelc+ZdAExX4mI9GgYW/fVHznYobMRh/y?=
 =?us-ascii?Q?xrDSxWFfq8YLBy3JT6nCZ4gWghdumjYVsffimiZJbWc43pjIoqa/aYLZ15ZC?=
 =?us-ascii?Q?CsITMC9sefYN8uTheTXbAY0Fy54pAwELSwjub+RlPrU1bG2f2dskC6V9PaYS?=
 =?us-ascii?Q?phBnAmMPsc3BqG9iqOyBVMt1BYrWdql1Ttr7DlGcdEZbz0W9tS2ZNY1+BP2Y?=
 =?us-ascii?Q?wpGDokZgoj4flvJajQXUizKeWahZ7x0OvgPmqhetqVhgfnWIdD9aSkwwAfw6?=
 =?us-ascii?Q?fjCXNfQVcUENHg+jMccvnARCVHDxpR8QWdQ9lxB0AkfvVTULBil/5bciWGOM?=
 =?us-ascii?Q?s43pOu1d5EifVwyxfxNcDS7G827ZZ3z+yZWTsH87x2D+Z0WuzT2+i3kH+rNm?=
 =?us-ascii?Q?Mm8Dd2ckDVtRWI8B9RAG6N/VF6TrWDYQxXhGRwrX0RQ7l6LgB7ou2qTBRSQk?=
 =?us-ascii?Q?jd7udsOVC+I9KoLbYpVt3Znbbf3UiVP6MAueiRaJ5yxr6qYN8Sbd9Pl/3uVN?=
 =?us-ascii?Q?s8u0rdUu09H2vwGYigIc1nk2I11ceppEtDg1Bml1j5+iCvUzXBZbVja7X8Dm?=
 =?us-ascii?Q?P1SH4bMvKUd1nY3Ublp8nkwVmHI/R5Tc68QO+7Fo94iD7joGmlAnoXKQNfTH?=
 =?us-ascii?Q?hNc4ym536UmvA8XnOiTx4ceSkb71963VUSEO7Z3p/CAiVvlaTwDTrIQRjQoq?=
 =?us-ascii?Q?mR1cCLN+4ku2lwiVWSHM1ellF7q2IFcebgIdLEoPmZVZNjkAPSwMCITeQsKu?=
 =?us-ascii?Q?LtWm4wkac+t0eGhWLJzATR/GCoy3TD/1vPymfcfPxPBsoneXw3/6u2dp43be?=
 =?us-ascii?Q?bfOIAWZXJDRASW2teNn4lslkY8knB272zJWrzjXoJ1m3z7E1YLdG2bkHelZN?=
 =?us-ascii?Q?dbU48RI/42veaIDvYrw3+WN75/Wqeh8gFzEus4LAdABtSEpzsSbv7yHesT+u?=
 =?us-ascii?Q?1qtD1Khu93vtQigdNtAupI7YhkfN8EluGWhymXrwa1tZgEZwgcBfC8g30tY+?=
 =?us-ascii?Q?wdG0MxgbYIH5zRSwkxHGMAc5Pc4gHYlOqijey+RwCoE5drV62NLb7FPsXSLg?=
 =?us-ascii?Q?/C1lA30HMFTLNmxCuKd873lbwCayepyOG649BhrnVCnRuusK/HUcAIMV5eLL?=
 =?us-ascii?Q?cV0XygwW2pTpqWM2p9/9wz/MpzyxGJDiy7uyKKXfDT0KtGtfbo5qAFqxptj5?=
 =?us-ascii?Q?PvaFcDW9LoTrVV06a2utJSq5gnqMYAOVBcSFFJdPY1V9v0oOTYuU1EvX3saH?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5257a5-4447-4576-e44c-08da9680f807
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 18:43:08.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaLVQjtYO/JsbYqnMjeOPQKhvOAH4Gr73QoMJ7288CiSt7LspvwoHv8BKuGb/3CZQM7f4T2s9V2vZJtVsGCEFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140091
X-Proofpoint-ORIG-GUID: Z8RCslhV6s3LIf1jjCumYZUEKnnSqjHw
X-Proofpoint-GUID: Z8RCslhV6s3LIf1jjCumYZUEKnnSqjHw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/22 10:26, Florian Fainelli wrote:
> On 9/14/22 10:23, Mike Kravetz wrote:
> > On 09/13/22 12:54, Doug Berger wrote:
> > > When demoting a hugepage to a smaller order, the number of pages
> > > added to the target hstate will be the size of the large page
> > > divided by the size of the smaller page.
> > > 
> > > Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
> > > Signed-off-by: Doug Berger <opendmb@gmail.com>
> > > ---
> > >   mm/hugetlb.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index e070b8593b37..79949893ac12 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -3472,7 +3472,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
> > >   	 * based on pool changes for the demoted page.
> > >   	 */
> > >   	h->max_huge_pages--;
> > > -	target_hstate->max_huge_pages += pages_per_huge_page(h);
> > > +	target_hstate->max_huge_pages += pages_per_huge_page(h) /
> > > +					 pages_per_huge_page(target_hstate);
> > >   	return rc;
> > >   }
> > 
> > This has already been fixed here,
> > 
> > https://lore.kernel.org/linux-mm/20220823030209.57434-2-linmiaohe@huawei.com/
> > 
> 
> Could we slap the Fixes tag when this Miaohe's patch series gets accepted
> since the offending commit is in v5.16 and beyond. Thanks!

We could.  However, this fix/change does not really have any impact on
the way code functions (unless I am mistaken).  See my analysis at,

https://lore.kernel.org/linux-mm/YvwfvxXewnZpHQcz@monkey/

-- 
Mike Kravetz
