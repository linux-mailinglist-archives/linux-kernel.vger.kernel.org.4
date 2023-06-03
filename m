Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5587720C83
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 02:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjFCAIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 20:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbjFCAIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:08:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E6E43
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 17:08:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352HfSRc028365;
        Sat, 3 Jun 2023 00:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=NiklBp8F/GFehFjfyt7bt1z1Dqw9oRYL4sxyd7IYwqw=;
 b=oP6hRpXTke+S+PugfHOA3RoS+rz6o7hbA7SobixlBlPBE+EJYglLYp0AR4t3TN4NAaN1
 RjXjw9FAY1NxMbXXRy3M8nUEDkqyJreYP4hfMy18fA4HLO9RO+tVwE1SyJ40VnxFYjtA
 /X98pzR9ALwVlaw3WwaF48sqyE0YVB91bUcXf8jY5ZP/INVpDi9Ca9HMhMLi9cNG4feV
 ttLLcdlb7bOo7OYFhLKFKeNiCEkTn8NfcW+6n291FrnXKLUh/cuSllwrLskaJUIY+Vjk
 T7HaOPOA+gq/SUR6zJdCnGoREbqcRmCvAfKXe35TGo6MuITwSG92U225aSsenDIGWKtU lA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkv0ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jun 2023 00:08:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352M9Q3K035157;
        Sat, 3 Jun 2023 00:08:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a98taa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jun 2023 00:08:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq41+ZPbhsGHZDfEhGAYgIFJtoSL6uix+C9eoKXgIXgek/k/wOeb+o4lvM0l2eBaafEN1gmp9zEWHxVWkijDrTPvUSk7unqIKO776e0mG/pzM++pUrONSRRhs0jcvrHAE3oh2rrPyK9H6FfQo6Itb/AbUiWcwsm66mHsXFhB+u5fS4SY6JQ6JZc4L3zGwrCSDNhiCEwabdf509E1NGbu+sWcz4g9lO2sKDxvPbefiWT+iuaorqz1eiHJByH6qQ44oUqUBOzOljmbzR6hw+12aDzPVg9FDDC1mdcPbn0X6w3jPngfltQp2XAVP/kU6VyykzC8WuwVbCFxYldxUwEsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiklBp8F/GFehFjfyt7bt1z1Dqw9oRYL4sxyd7IYwqw=;
 b=XlKzs1znOlGe2srwy1FppQd+yyNGuTYUj8jKYcO6eQiFmjANLT+UKPbCf/rA5kbO0GAdIptmJRoGYI+B4p6DR1Z8I5JfF6WoxiFCwV8R5i0DpDBtxLbxtPCRVjOiOZbzyvZPZeV26kjUBjE/Gwd1RGCmjyaersXYnjfsPlSAnfE03LMsw3Wqtaxe8VqQKML1Evv8yUlLGHHPnhY1B/pSdWTvjYSMMIdP0hJ4VKVWVcGZsRKwB4C2TuW7ZE4NcsraeEBnWgUIfJGvD76AVTnwto7IMcOdLNw2G1gdTLq6Fx2tTwvtzjM6N5ch3pYZaK4tFfd0k/AlUYBO/M2GYAki6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiklBp8F/GFehFjfyt7bt1z1Dqw9oRYL4sxyd7IYwqw=;
 b=IOUaNYfwvUEN+oD0wYSqFqZK2j9la6ChMV7XliKM5K5F0efYt3+kbUloHjB3BeeiRbrLsPQMzXnEsVXceUuGM0B9zoKsgf+Q+yj7ghKTGOlHrINQrecQQfKrwxypEJibjUJ8imwp+cEzuBeOD/LpLhauwhqERKDFu6I0w7uHP1o=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5774.namprd10.prod.outlook.com (2603:10b6:303:18e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Sat, 3 Jun
 2023 00:08:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%6]) with mapi id 15.20.6455.027; Sat, 3 Jun 2023
 00:08:12 +0000
Date:   Fri, 2 Jun 2023 17:08:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tarun Sahu <tsahu@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        aneesh.kumar@linux.ibm.com, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com
Subject: Re: [PATCH v2] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
Message-ID: <20230603000808.GA29961@monkey>
References: <20230515170809.284680-1-tsahu@linux.ibm.com>
 <ZGJo4UhdyakGFwP7@casper.infradead.org>
 <20230515174513.GB3848@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515174513.GB3848@monkey>
X-ClientProxiedBy: MW2PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:302:1::37) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e017dd7-b553-4fbe-18e5-08db63c69e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrKL8qCVTjbfaLudJI9dmSRJwtefFoV3VQAQjYRMxSm3h2kgfFEiLc8ATGoA5sPpb6XkdAUaIzJXEVvTV0i9welTLb4sXyW1RxrWKRiZxSnD5gb+4ma+/6N/eX845oSngmc+PCVCkLxu2p92YCg7yj7FxgpJy8YekivRUSFYqch60Yg7+8YQedtOj9BlNmFj7kU/4nHoV9IDUh87fqn5AuXpJbCxnErbai+szQxMlGRKgf++iDzOE4sdOsDzvlf2zoUPWUTHXfjafGObq4TgYM7+DFmpdM8z5qRRmg8VHw0FxSFjzhp3EwWSPqvxIYUxcnCPESTpjFt+eqmaxvzJ813Kk2PlfZ5mjnthTDcsz8WnTOV+fHZHPBq1T7cC6McdRZLnwtDUjINi0MT+auzhwbi/bqAli3ljkGO/kGzllVBSd1eTB9bt7Rguov6IfmMicV5aQNiZjpNOenHK2JHs2p0ifT1MtumW5pPlvsq6+ec9bJyKru11xGTU7H/CFdcDAtqAgmZL51/eOStZjYj+3/SPFsClEw6afR2i0nmviWebpPR4lfwv7eLTyEN1ngIg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199021)(66946007)(83380400001)(33716001)(4326008)(41300700001)(38100700002)(316002)(6666004)(53546011)(1076003)(6486002)(6506007)(6512007)(26005)(6916009)(9686003)(33656002)(66556008)(66476007)(8936002)(2906002)(5660300002)(8676002)(44832011)(478600001)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WAMDpWyt+rQWpYIJ1r1DmFRVJCdGzJ6fY9OMDE6Dt3Dk/wIMMDI+DiEj3XWa?=
 =?us-ascii?Q?76aYNCJg0qL2enHqVlGQDEZSj94hVD03fITQouJ9XDEdOIFDpoiU3EWQx6bv?=
 =?us-ascii?Q?uF+Hi4ur9wceltDZ7eVVicJw+Mi/vfkZ1o0NUlojk7Xu/MQJsTCQ3A+7eq9u?=
 =?us-ascii?Q?JfHusPKauZ9yKTNb35kCWkxtfWNv6xwnTeuGSn9bP0l4hzCItHtVEVkstSvI?=
 =?us-ascii?Q?oD/5rNneQIB/yUIz860Hx3D0obb4BJ3VDEslBvg5DiRAb83H5YvQGPqlNkim?=
 =?us-ascii?Q?2c1FAmvcx7NyIEarVChnpLd1IytGZxPjdpFlvWLGXCrCVBOhd1deAzytdlEM?=
 =?us-ascii?Q?O+Yzow6kZblTC9MiAF4VUzm29PZW9EnZKKGUP96+T19Bppdho3MYQXEZIZ9L?=
 =?us-ascii?Q?J3FCktY15YZYW7M5hNwWmvNC/iNa+6jGyo0yYvVf3v3VNd0hEuQ7/bjwuxUd?=
 =?us-ascii?Q?QDv/DNs/DrNgC/ZZ4mCimXj+2cBELLCUbA4lR1QHAHQln2wJUTeOn4Gs3sJ7?=
 =?us-ascii?Q?haFaqigvcrXk/jHS73eZRuyCoAPIhiuecNIAHF0nIcGKAQrog5f/IkMr7pFv?=
 =?us-ascii?Q?N2sd1CmI6skq8iGZ3QjbkYIgIpBZXH4UV0PE+onJas870usmKR+RykylC2jQ?=
 =?us-ascii?Q?EvVNFVn40LBex5N4aI6MQsSKJs73l6iDW1PUlF7aYNTnyaz67uSWvGCOytRv?=
 =?us-ascii?Q?gBoIe4mkwPg/EKa7+8HYGSl37MMB+g0xQ1qSoydf2X8d6tJYiPU1cTsEza7Q?=
 =?us-ascii?Q?nTD9+hGT7pPyIFijL5gjFPQ6s/XftSD16ShbcHLZFcbkk51nbzFinGPhTQg7?=
 =?us-ascii?Q?DxM0U2gUyYAwZ1yNvxieEDvg+rYmrzCwSP5WXHbdufZguy9zAjQEAmX6pBDZ?=
 =?us-ascii?Q?DNDic9ohfDESyjrcIIZow7suQOumqlVAVPVVcgwqwggSeGco75eZMmZCHNEo?=
 =?us-ascii?Q?i/POfcpSLCfH2qY0nHD8Q0PDq7/9OMdvW6dDxZGsQAGt4qgyXKKV53G02NCN?=
 =?us-ascii?Q?llDRdOZhtKt74EzM+SjMOPJ/1npuPq95GJP4/4/JuF67n0tyTLyRdaXiDVo0?=
 =?us-ascii?Q?jd4T4zm8sQCS0DmLlkRM30bmkhJDilJlUc+ApsWQGpPv6ByruzHH+PojEYmp?=
 =?us-ascii?Q?lx0eflr0TfFzb0vCynYyNm1+FSCkUFo376j5kEcxkg9fRmp1Pckv7PpFw5Vg?=
 =?us-ascii?Q?DV809/dZ3fAIBcvKEeJYdlVmvICjjiG7Xk/syIhrMTWdYLMorTDKXdqayLP5?=
 =?us-ascii?Q?MZ+Xz7oPh4Zkm0+HJP9EM+RauKE3WNSa9+EhuPI4sffCVDBg/5QTDiicF/JY?=
 =?us-ascii?Q?FgSrHSjFMGoitgun8JexQ5CCdAC3XlSKiktlBCePjtIl5X8kK3flG0n2uo86?=
 =?us-ascii?Q?d0P3QQ1hGP6eFjlhOntInJsGcagZGn8lniRFx5NUeafm+bcK1qOFwnOjgXXx?=
 =?us-ascii?Q?1Fj65G5fub+FL3xpEoJv0VlQmH7Vy2OKtU720nB8w9oAE5nB3/GoZcsakg5+?=
 =?us-ascii?Q?YPRzi0ATjXhCoLL/BVlq2Ng+EhzBropoLaE3iuCgRuTdWwEUPjAgfiavX+f4?=
 =?us-ascii?Q?jrir9W6CVCHqpzyXsX1jVaYOppSVVaQCrLzTVQMt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UiY1IZtvjHrdSMqdaDZyFYKv62+RikznxdbRk4itBKlBQRpxB09ySWhWRmK5?=
 =?us-ascii?Q?KspoDWxMCeIBSyoBA/hiiOnfvlJkkfPQh3IwhYEGuMShXFW8FaLYuHRqfF2R?=
 =?us-ascii?Q?i4R9alVD2n+OpCI+7DhTnVaHaTkKNZ6r4Nwtqhz5GuTY254SMWIxzgmyTEEz?=
 =?us-ascii?Q?EeUAkxhikg3V69xicacQsL+yhHRKHnrOE5MKDQRj3H0wuGHlU1rr8xw3RnBF?=
 =?us-ascii?Q?lKOzRbBjGaismM/D75yFj02a6Nvc8PDwiGo5sgiKIzoszsGF12E6dtLJmzKe?=
 =?us-ascii?Q?I0h+l9XkWjJzQH11TQ74aasdR8QGbvxDZYWCObTaMCPcDxy2I7EDxCMhT2Qi?=
 =?us-ascii?Q?YrSTGccCMoPEFNrtTIHUxlPELSgTyeFGaBlCpXllQFVKb3vRYIJbyxA/c8V7?=
 =?us-ascii?Q?asJWJoKauGwGL+5laMFxHCk7+6wUK4X+NTto+TUtZg1Q2cX5kkKWOH/hUY2P?=
 =?us-ascii?Q?GfddJndtzzkiVDtmMrFdj3jdkjWxQQg+A+dUFnS746HemJmYpVbQ/ojJAsLI?=
 =?us-ascii?Q?T5TxItj1vnxVOS2ERyftOUVU7XqG6ilSbpfDFw7QIbaZBFb7ngyz/WaYK62S?=
 =?us-ascii?Q?qKVjsv50uB6xraWRBagnH+FW/2pJQQ2fPX73+kOv1a0O05rN7q8EMoow6FWe?=
 =?us-ascii?Q?ogdRCx0op7O1ilet7P9vh4fXYQHtGxb5ptqBWKGVci0X8YezXOmTeQuaIDQG?=
 =?us-ascii?Q?b7WCDPzBAsQq3CA0cPGR7PUQ7PIZc96lHzeIY4/jIlnrFfdKf7+8704Jgn4Y?=
 =?us-ascii?Q?DPMQ6SgUq11wGMZv4QVeHFK3ao3MW3y6F7dRbcb/QlrIw0QHNMFtsASk+bgX?=
 =?us-ascii?Q?y1tZBjhBaQw+d+51eyTSPPrpr3QMUC+qPDAqz2K8Jki/6vRCzrIXONCUNcX3?=
 =?us-ascii?Q?F5m20SXRIblnv2QWUoFzmmwRFvOw2TclV7t2IXL3DNFgpa31nf82H514m/hv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e017dd7-b553-4fbe-18e5-08db63c69e71
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 00:08:11.9277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4tSo2ROcXdOBjar9ZPdwgxVQ2ZA3wHH5G4DjjxfRVp/KC+QJtWrTpIQ/EbLZSudr0DPTu9CAUE+ElzjYStypQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_18,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020191
X-Proofpoint-ORIG-GUID: YfwqAshmsEkX2BYZbrvyxzjjuaT89bvc
X-Proofpoint-GUID: YfwqAshmsEkX2BYZbrvyxzjjuaT89bvc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/23 10:45, Mike Kravetz wrote:
> On 05/15/23 18:16, Matthew Wilcox wrote:
> > On Mon, May 15, 2023 at 10:38:09PM +0530, Tarun Sahu wrote:
> > > @@ -1951,9 +1950,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
> > >  	struct page *p;
> > >  
> > >  	__folio_clear_reserved(folio);
> > > -	__folio_set_head(folio);
> > > -	/* we rely on prep_new_hugetlb_folio to set the destructor */
> > > -	folio_set_order(folio, order);
> > >  	for (i = 0; i < nr_pages; i++) {
> > >  		p = folio_page(folio, i);
> > >  
> > > @@ -1999,6 +1995,9 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
> > >  		if (i != 0)
> > >  			set_compound_head(p, &folio->page);
> > >  	}
> > > +	__folio_set_head(folio);
> > > +	/* we rely on prep_new_hugetlb_folio to set the destructor */
> > > +	folio_set_order(folio, order);
> > 
> > This makes me nervous, as I said before.  This means that
> > compound_head(tail) can temporarily point to a page which is not marked
> > as a head page.  That's different from prep_compound_page().  You need to
> > come up with some good argumentation for why this is safe, and no amount
> > of testing you do can replace it -- any race in this area will be subtle.

We could continue to set up the head page first as in the current code,
but we need to move the freezing of that page outside the loop.  That is
better then the existing code, however I am not sure if it is any better
than what is proposed here.  I still believe my reasoning below as to
why this proposal is better then the existing code is correct.

Also, that 'folio_set_order(folio, 0)' only exists in the error path of
the current code.  I am not sure if it is actually needed.  Why?  Right
after returning an error, the pages associated with the gigantic page
will be freed.  This is similar to the reason why it can be removed in
__destroy_compound_gigantic_folio.

> I added comments supporting this approach in the first version of the patch.
> My argument was that this is actually safer than the existing code.  That is
> because we freeze the page (ref count 0) before setting compound_head(tail).
> So, nobody should be taking any speculative refs on those tail pages.
> 
> In the existing code, we set the compound page order in the head before
> freezing the head or any tail pages.  Therefore, speculative refs can be
> taken on any of the pages while in this state.
> 
> If we want prep_compound_gigantic_folio to work like prep_compound_page
> we would need to take two passes through the pages.  In the first pass,
> freeze all the pages and in the second set up the compound page.

-- 
Mike Kravetz
