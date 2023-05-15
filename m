Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9E3703C91
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbjEOS0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243131AbjEOSZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:25:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F94716EA9
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:25:48 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGnqrF011049;
        Mon, 15 May 2023 17:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=OqzH2ENGPMsdemzGYlEkYbF3LSfjeKzaE2XAp18b5OE=;
 b=PToCCFGNk1kxWhZs0IYJFnUdTP258i9NjVxJ1pNYuqnfR+X911ocZ3hf+MJUqzyUn3a1
 U2EhuSGKfq32yzuQbgrKzdgM1TlPjvxYutXs1pU3SsZME0uGYXzfEWuPL0sfnPok728X
 yBWpvw9UKwHb08wFKANYKZ4cHpDZ0VtGtYpfZo3FLtxRq2YLiR3pX8Kyg1RzwsxgPnkW
 kL3lAJdjCY1Nz2YhjtTJWz0ULyDHYSQPHXG+TKyAr0wTQgl/tMK6INEBIYNqmgdDG5k4
 25cEBGD0pKGsVjDKy1HAdZhokvyWjSD4of+NN4y7LK2wsABySMSZz7ucAdPcqVZI4qih Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc0pbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:45:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGOAso029507;
        Mon, 15 May 2023 17:45:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj102yupq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:45:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQkk9x5Pg8YvOXIsCb+dEH7VqLj7BKxp4/CIe6x7Bm75WFbB1ps1DassoJ5tixMIU9sWceV1cc/21UsJQeKVxuQb2z8+L7sPEVpbLZJGpxa8DtdrsojB1yY7F4WEUwJbZJmXqDLdHrfA/OrNfmewQAiFHKJxc7EVp//7PJk75q8IcpS8mFnioERVSibyed9aaaKi/j6Mfa91yaZaAajppcT1G/Wa0AQuNXbbt2esjP86qSVJIPPmiNNqjGYwo3DICFEMBryOtuY5N7TmcyeN/NEk+Dn3dj57Q7RBCNhoKo19tkHHc2dbacJfda2Wy9rjfmHDbNVt4knTNM7Pa1jp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqzH2ENGPMsdemzGYlEkYbF3LSfjeKzaE2XAp18b5OE=;
 b=dVv7zAuPGFN+cNIKqSdMgi+j6qFYP0pE0UXfa4MK9jRNUDclziQoZhKEBjKOeAZGjRboMbc2k8rezsusbB5aifl5eTKMiyJrud+gZR1XEJ2sw27rhgaEsdSPZuedKBNAXM9OglIJdRmYum73Xd/gIpDdnezmshddRdaUuRUEJctpaMfBMpFntcJeRWLDAe8FZaIKTM9CxXXR1qiHWJ/IELhTJzfOFCGkSXa7/XapAaeMrN50TGXVGLndAd0poNeU0BruOhCbNH4r30KKGr+n2GYUfgKhwiZjFxUBVn2vk7WxObQrU5rjaJxKQzFd+c4Gb1OzLLgnb9tK3sJp6ugkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqzH2ENGPMsdemzGYlEkYbF3LSfjeKzaE2XAp18b5OE=;
 b=qnaGPILQo1QYbOoRNJ4NL+fSPjc9eld+HBUF3BGU+y9kFCz1rAKygZviDIFRqwAual/q+m+dz5yIs4NdTHPFTsDzTo0ozsfwbnAwlpW/3i/ihhUWFTigFy6zXDqQO5vMuydErBeIZDxPAPv0Azslhtrw7ZsJJGZpk+tAlslXA+k=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4387.namprd10.prod.outlook.com (2603:10b6:a03:211::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 17:45:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 17:45:16 +0000
Date:   Mon, 15 May 2023 10:45:13 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tarun Sahu <tsahu@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        aneesh.kumar@linux.ibm.com, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com
Subject: Re: [PATCH v2] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
Message-ID: <20230515174513.GB3848@monkey>
References: <20230515170809.284680-1-tsahu@linux.ibm.com>
 <ZGJo4UhdyakGFwP7@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGJo4UhdyakGFwP7@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0252.namprd04.prod.outlook.com
 (2603:10b6:303:88::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: 19df0e10-04f3-4042-210c-08db556c24d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Deg44HnmlRbFrAKTNaAY4ANMECKgEoq7oAxRUUephUDbE4HmS2NssKteBbA1H7VuF2KKdXFCW/mWg2H6ngeWifeA5zuSW5dlqpj4NoHKGY0qsnNKhQJX13HIA5YzYC5h71/CNkKJC5S/H+ZC6CO1X+2rvQHOgn/hkxPHc2PDIfuQ4w+v7Bj9+ugPACu3gm5YXlJ28yIxr6SErlsu2hoKCtEzGDZqCPSXpBjzplkp4ELd6h7oTyz1FPJPofw2M0/AMnCr88dgfjDGxXEhcyrSXmO1nHpcqmJz54UzB4fZl9OO/pH0CFWQBlwqTYrBs6a2/inMEs0jLhf+vydSXYzvTSrg9QeQfWh9hSs6s5aiU8SeNNW3ZGMlfakc/QyLGQ5Mb6f5zH7S6G2MKchl/QpTyU68bfv4z1n91mpaRtpjFoT6beVnZgJmJarr3kZarmkkE4atkkbljdQLsqXKVsON7w9PqnOTFg+ygTqSl6/5SEWi12/N7fDnPiqdPUIprcnXRtqBVALQTqBWnjen9BHxvJpQFeiiU03IBmlYMaqpT/jtdwRTqu0xLLvOleXTf3A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(6486002)(83380400001)(478600001)(6666004)(9686003)(6506007)(1076003)(26005)(6512007)(186003)(53546011)(33656002)(44832011)(33716001)(2906002)(6916009)(4326008)(38100700002)(66476007)(66556008)(41300700001)(66946007)(8936002)(8676002)(5660300002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VaKwbY3cmcF+fS52RZ9/BoJyWXYX1u1WNIZkWa25mbK6tJ0plNw2xok0c7i5?=
 =?us-ascii?Q?TOfpXsgnpKChVmPPpYSf+YgDt4YZU1xAa9GcNbipnZSLp5O9QXkv9hxnpT4Y?=
 =?us-ascii?Q?dsTuNLSiNqmn+0LXcRyFVP2sKmavC7Q+000JaljPLLseeMYPZIbrUZZRUNSC?=
 =?us-ascii?Q?Hj4c6VDtxvaf9MvJqJ7OHAit+5DhUA73q0LgaDAkDEU/mqhPggopPnUVdHpt?=
 =?us-ascii?Q?TNN59YyPBBJ9lnMbOjS4g8EwMY3pPLp7rqdCYWpoBoEL4M75U7iTy3QWwYMj?=
 =?us-ascii?Q?WuUlmwhIPVHUgksX/sI8M79fGtlwiIY0IF9mB58YKnYhTiQ1gW/aHDpf9Gtz?=
 =?us-ascii?Q?9AmCbdQ56JFim5/9Ob8OsySvRpZLeErVZpVrQ2Y/7/OHmSDoGAkdHGRPlCNY?=
 =?us-ascii?Q?5OmZILu+fbnEDEBVcCz9wfJujeAGVUO+cWP7825GolkSWLUoi5VpbfqWs2jV?=
 =?us-ascii?Q?IojvnUzivPU8cYpLi4vxxqByI3EVsg5BjsmtjCeA2Jhs+JwW5Jfy1v6XR1lh?=
 =?us-ascii?Q?lbaZFNvDDMA4yWT41ITtKR1/yNfB7o4YbXjubWgPqLlt1h7uXMu1jwMJ1bJF?=
 =?us-ascii?Q?bFXffg0EOWCWRsPvnVmzgvfdqyzsWy6lMovxF9KFm09fe5arg0vPBIt5Kvg7?=
 =?us-ascii?Q?23JRyHl+Q7U1EBEGTBwPVXOvVYNfNQ2KPWbOlu/CveDF/edXO6IPTf+QgyVs?=
 =?us-ascii?Q?wkNzR4a2F+rXXib7unP4jPHIG9NEe7H4yLeQo8F6scaccMaZVrikZswZu/Hd?=
 =?us-ascii?Q?PySY46Hr9PQh1nCPsy0qwP7zidIkiXe84v42el1QvfNLL9TGl0mPPBZqvKfn?=
 =?us-ascii?Q?3408REX5vF8O4VJMjKlCsv40ce5mDody4Tkzo5T/Lh/BFRy1/A3sUY6bWMCL?=
 =?us-ascii?Q?CN+PeoNaYsPmy26E6/f054/qO8KX3X7LK6VmCHqarWSu49QrEuoq5fbwBQIu?=
 =?us-ascii?Q?dlI0Q8X2lNVLS+nspHLIV339t1Z0adXVkI9VbC+whb43SbTKrpYz0IsRZEb6?=
 =?us-ascii?Q?1a4Vn46uNJeiKFoC7v6fDJ7n73FsFVNztHlrWnl5jdVqcyHtL/wrNf0OPIdF?=
 =?us-ascii?Q?E9QmY0xfReKaBWr+vQDuyNSpJwUJHs/43z7EtSUkNP+PcJHo33xmWmYy0UdA?=
 =?us-ascii?Q?e1izq4Zx65E1M4Q5SIJmf6VXeIQh/gRtEXFGgp43oG4YubwEjIVFgerOW6Q7?=
 =?us-ascii?Q?3sgjnSInM6w4Vsok4oV56jx1MXalyFDBrnTwZ6RE+8d6+AoCbcpHJq0wQpzW?=
 =?us-ascii?Q?pteMtRc8yXIeTJuHKtF1LC8LrtLKvqFHYRXGC+SeDloNE+g5obfRKg0aHcIK?=
 =?us-ascii?Q?bymUGadKU6WAFL50HTHH0VPxgd7yi0VgSeDp0AW3r7ynIFCF6dU3d3Fz6lJq?=
 =?us-ascii?Q?76iansabFmaNBWFiWeXSvJXm6QJPCz37WXCFgbokBDGCdthW4zHvKuySXR8Q?=
 =?us-ascii?Q?DLbfK8dppbNB8KnkomiEJkA9J0hZ81viflZmbVumHhb4PbfZpAkwk2uyZR2J?=
 =?us-ascii?Q?cAV9/zdafN8QhIkdH7jeSf1aCQQwhDiGRL566FgZzVZyBqu6GodHs7zyABsG?=
 =?us-ascii?Q?ErK/qsZmiA9CIPRCNbYCPvHk2bL+sLBEG/2wVHCJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+OGiWPFmUef92Q4dWwZBMmLrzzU5FB92uovIhPUvfC3eE1bOqZRoqhx5Yhl5?=
 =?us-ascii?Q?sA/b/LKpwwp4qmW2Sv9pUwxIiVw9CxqoO0AnL1WvqCSF1aQUxVwDpUO5BTyx?=
 =?us-ascii?Q?ztTUUDEL5oi43CW/x5am9pd2MVMkJ+YGq2Bw9QKDgBUi4/6727fdldDhgFhp?=
 =?us-ascii?Q?SrGdrzPw3D3GtHWOMpo3xK7CUnDvoAikO+6eaQ0LM/5hkvEKjFR/ZP8FcObW?=
 =?us-ascii?Q?QXME+fEzEZujBXjqeRI5CjZqwidHAi/akXK+r+XPwQo/jV9oDcKQdI/vT301?=
 =?us-ascii?Q?Iaam3LkY9eDtLVmMteedkzxIZ8z8oXJwcI7lpnnl+ooZJMr693sHsgF5xp7q?=
 =?us-ascii?Q?9Janbwky5OoJt4buuq9SiFidoRdNYAXf1ZkkeN4GcNHt4Luaw79DCDq/2nlp?=
 =?us-ascii?Q?Kg8pD3ziLbzzZ1EOdIJt1X1cKpoaKI06mCi6ea7eDgpjh9jdB6H2PPBoVkt3?=
 =?us-ascii?Q?su2Qo+QX+MUmNDxY7GGvHAcdFCjqSBnVuzSe6+Q5QUOABgyfqrEqXKB5nB7M?=
 =?us-ascii?Q?JMFPrJx+yvFZVKHn7XFHmlgzFiANZGQrSmXzw/HZtUlpAj5u/hJ/Biup4FSn?=
 =?us-ascii?Q?b56xHv/w+Yhnq55wWrSxXVTU33WoMt4bQSuOhrVo9gvAGV7IAOnUtRZBaVRX?=
 =?us-ascii?Q?4ZghyE0dwqq/L82NYA48Qf/8A6Be9JaaxtO2xXFnQLLXxJpsnr+b8pWBSvxj?=
 =?us-ascii?Q?m6uTqfNU1FEmXdOEoz3v8xc1v6EwdNqnzKW74wmRDiPmBr5bCBC03D8ET5kg?=
 =?us-ascii?Q?P30RQVKVqXqYFkXLWMhgTc2WFEp/Uly2y0qLlqPDb4mix2nczoKzIcCKNXzE?=
 =?us-ascii?Q?m3peERiue8pZSCiN/HhEeWCa74HBiGWfqmrwECZZmQnmrL+BiLmk0+r9mG60?=
 =?us-ascii?Q?NswLqw/2bl90qqPogBfgGLKk4nE4xzvrcjsD2qs55Bt5rhS9bT6Yk+jTYwPv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19df0e10-04f3-4042-210c-08db556c24d5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 17:45:16.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jtlp/8/PqCHgI2vgUY95ofJxXSFJgIxE/47J0VwZyfYo6Hwi+/TwMHNZ1vbpG1KobRmLQqAKU6fkDljJHeUoDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150149
X-Proofpoint-ORIG-GUID: ZNcqt4L6nGL5iv4QEeXq06V-hosfNhPc
X-Proofpoint-GUID: ZNcqt4L6nGL5iv4QEeXq06V-hosfNhPc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/23 18:16, Matthew Wilcox wrote:
> On Mon, May 15, 2023 at 10:38:09PM +0530, Tarun Sahu wrote:
> > @@ -1951,9 +1950,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
> >  	struct page *p;
> >  
> >  	__folio_clear_reserved(folio);
> > -	__folio_set_head(folio);
> > -	/* we rely on prep_new_hugetlb_folio to set the destructor */
> > -	folio_set_order(folio, order);
> >  	for (i = 0; i < nr_pages; i++) {
> >  		p = folio_page(folio, i);
> >  
> > @@ -1999,6 +1995,9 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
> >  		if (i != 0)
> >  			set_compound_head(p, &folio->page);
> >  	}
> > +	__folio_set_head(folio);
> > +	/* we rely on prep_new_hugetlb_folio to set the destructor */
> > +	folio_set_order(folio, order);
> 
> This makes me nervous, as I said before.  This means that
> compound_head(tail) can temporarily point to a page which is not marked
> as a head page.  That's different from prep_compound_page().  You need to
> come up with some good argumentation for why this is safe, and no amount
> of testing you do can replace it -- any race in this area will be subtle.

I added comments supporting this approach in the first version of the patch.
My argument was that this is actually safer than the existing code.  That is
because we freeze the page (ref count 0) before setting compound_head(tail).
So, nobody should be taking any speculative refs on those tail pages.

In the existing code, we set the compound page order in the head before
freezing the head or any tail pages.  Therefore, speculative refs can be
taken on any of the pages while in this state.

If we want prep_compound_gigantic_folio to work like prep_compound_page
we would need to take two passes through the pages.  In the first pass,
freeze all the pages and in the second set up the compound page.
-- 
Mike Kravetz
