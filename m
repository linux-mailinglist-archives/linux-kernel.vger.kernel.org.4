Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B72724862
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbjFFP7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjFFP7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:59:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BF2FC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:59:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356DDqk7022036;
        Tue, 6 Jun 2023 15:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=S/bxCQ0+j7f6s6Xl4mn/P27Y/LwTKLEG7UCAr7muZRs=;
 b=RAVWvio4Xqx6n4mQi9hKVDDtCQvAhHIk3bho/APqxWUXdl8BqFHuB5xAZvsT5lP9i8MC
 4Aoh4NBzRatOxbACC6h1xn9DbRVrB2E57t+NuAzmTy21+p12h3i9EX/kIH5SnIhaHlQP
 5mIFCQlYyNcvN7OzXTk57HTc99TKZMOymGdR2kDV4rArLj/Prgqlv8LIeKr/847ZALfb
 CkuO3RFcZCaPuYVfms8rd6FGJf/EFRxXeh12535zf8VK+y2BmYcVdcxw5ooGkNRHSEFq
 d2RZWuQAnr7WvK5/ba3mC3aSA1/rdYix1Rk0uFkoPD/Nvs2oLBLhSs2wg8haGuerpp+b 6A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2n5nqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 15:59:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356FiDVL023881;
        Tue, 6 Jun 2023 15:59:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tq9cr9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 15:59:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Luoj3kedxaeW8aERcAPT4dE7EIELbUgvcbqYs+omtl7fZvi31fw/eJ2r1Z6dkB341DnmC9IUvFFTDiMqXOV3OinLI/qaa+boPfJXI+a8DegKIKGkCtHGGzWD/WA/g+MeBOouHJ4HXJcI3/g2Z2WiVamO2QcoAmI8aHK4Qpw70Vg0dvMBfZ9ZzQZVd1pYUR3sgKyObD/u8s2xZj2AoEhgIAgfaVVjdWVfIHtRkHVhUKwuX2yKaI5JahRBFx5083lraTl1QkLqI43FQ4Zu9XpNLkeyI2KsYjjl2AH0TGQKE8ToPcn0oOnV6akuF27J4o+QfgHOq7zir+VYHlQIFS4xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/bxCQ0+j7f6s6Xl4mn/P27Y/LwTKLEG7UCAr7muZRs=;
 b=QxreSDbHPwM9+UKLGSgw+bE47QfA70RFedRiT12xrooCNzbPBsZwaT1UmS9A4SKAo1RBV6vkR9ywKbEdwquCoZIsTBRc2RMQorn/E8G/1uQ1gkK+tMV98SL54gzspIZVYKeBPuQKoy14bZbpvYF86P5HZ6hExfl7kLWGwU+xLC2P/rEfIL8uxQD8M62HVIaUZe10L3CnzYPzCfF/gK3MFEbPvLjO6fl+L1sLS43zyr4a6usG9kvwSJjg+w/lwYmF6tWcRGzJaa0z+xbJXbCGnqUYR3a2UB13/P1R92sF+U7YJuheVkNmcd5SXZycNdRf54A+3bU3xLHSYdrC4BK+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/bxCQ0+j7f6s6Xl4mn/P27Y/LwTKLEG7UCAr7muZRs=;
 b=tWcn/B3FgbzdeTMfD63IM8vCT6RZRdtZcA/6oifKpOXw2UT2Max+K5IE6vl+FlZIuqVHFOUmIgJTi2aigMrASPtT1ZPVzV5kunCDuEZtsN1mX5qv6d2TwyTQEJe30AZdliaA02eyi1DAr923FTFOqTjxBL4Qwn3FA79Q+AyyP6k=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5927.namprd10.prod.outlook.com (2603:10b6:8:85::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 15:58:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 15:58:56 +0000
Date:   Tue, 6 Jun 2023 08:58:53 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Tarun Sahu <tsahu@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, aneesh.kumar@linux.ibm.com,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com
Subject: Re: [PATCH v2] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
Message-ID: <20230606155853.GA4150@monkey>
References: <20230515170809.284680-1-tsahu@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515170809.284680-1-tsahu@linux.ibm.com>
X-ClientProxiedBy: MW4PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:303:b5::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 9183eff5-82e1-4398-60cb-08db66a6eea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nz180KTXrPHCvirAxgWMVcEMOnTw0Q90kXa+PHY23eyTTFHk7hK31a74kaYxcqESuVlJQIxMMUBc7pgxPNs3n4dFbOkkjwMiUSzgiTuYsXasxxrj239zlvhp1mcnb/y694xbIFjHVlHyhsO9VKEz3j3toZDt+J//PE6HRaFWcaj2OU+o6qTalPAtTWFlZ4fXk7ZIF3sLWy2gPDGH46dLzo9U1xkUw6fPXKyVkOaN3ledXSpS+Bxov8IsGHUIOaRGhVf0UP3B+A4m7hRRrZeIYTFqHmXpkyU7ruwiUn7F4rcFH4sqJqikhjbyNa3khOPQBjE3Ju78TWJ8JF26vPW2zGhYKKSp1iw7sQi7vpaB55cM/CBvB13NHpm1UeyktfsMi6Zv/aOBJ0y1c0CSFMLbH3u4VpcDDFLPdwt+nymbDLSl+GJeUs822KycLA0E7AI9CUpr56OePLJAjW2TrbLzeCyoZEOxjggZMxlJr/Uq7xXNA5lU0pbU+aJU9htYPXITVxfH2ybU69HlxFeyZsrlUZoBYsAyJMs03QERyljQX2JohM0d4d72yF69k6UbxlNXT4NqNbFpDR9Al0G00xP7VYHFMiJ5kIJpAQVFOqm/Q/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(8676002)(8936002)(478600001)(41300700001)(6506007)(5660300002)(6666004)(316002)(6486002)(1076003)(26005)(44832011)(4326008)(66556008)(66476007)(6916009)(66946007)(9686003)(53546011)(6512007)(186003)(83380400001)(2906002)(38100700002)(86362001)(33656002)(33716001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P1ies3Gmi3xVzXdKq0vFShE3mhX7vSJOR+evmYFJwk1V9VXDNZpnxVLk/zTu?=
 =?us-ascii?Q?O9SrqR3w2jsIstR/iwTAkNHzFBQe1MRRbszn1ltmSij/Cxa0XYpHxTU9VHGB?=
 =?us-ascii?Q?aUhjOxNCzWRW/Uk6v2seXb6qlKJgxocub56sxjTNcqe+jlDLS9L9Cyioe6Vs?=
 =?us-ascii?Q?Yb2alkE9k6dAdybGXpBxvlYMf31ksyhnjgMpejI4U6ildM1JLZVdQzfG+fRJ?=
 =?us-ascii?Q?R+5SVQqBUlIL7aV+iLsxIXnhM5CEY04zQBfSZhF5VxWk4AjCtrfHj1tpxwFw?=
 =?us-ascii?Q?bCXj40YdhhfaidpHTx94EYiNnLnwDGV507p52MykHG0t2JLSsMCKIxfip4KU?=
 =?us-ascii?Q?vJ7ow3unWg71ISbEBS5n4mIUWoN0C7zLN6If8ObNjgWMFeT4FulNQnWlMjeA?=
 =?us-ascii?Q?AuTz1ohw6Zzez3AMg6OjEkBhKgDuhMVtPXbNM7M/vLiMaf0BFVSUFUEtqEBL?=
 =?us-ascii?Q?/Tnfjopcn6gxvWZiD3MhcTc94VRN9Za1Amh/O0vNcQPp46TNd8Ynf5RKCX7k?=
 =?us-ascii?Q?8CSeHzqXv7mpN8k7sgTu2t4/Z8o7ZdLdGYFF/PW4/G3/d7lw/3OcANf9uVnM?=
 =?us-ascii?Q?BzjNFyCuk7LMkceMXGzWR7dYgdf/CMj4YbTePREStsIauHSgDY6gAgF0kUK6?=
 =?us-ascii?Q?A4hq6NvzXBkkVTuJQe20k9uCXvqjolBo90T468XUolbXgG3pm/r5YNui6ySp?=
 =?us-ascii?Q?tC6NDHv6nW38g7C0FaY7MFjRIx+V72PYAfL7Wv9e6bgY835YzRVb1b3PB+M/?=
 =?us-ascii?Q?/XEDcmPXSok7FHAjywcxF0NPQjJKkbwKJIMHpKNj816hEq9d2kCAEDtHYIEB?=
 =?us-ascii?Q?L0bgxwNj+ipmpxQ9PUTLFwRJ/HExxlxmtGERPxnrd1lzKhKH39/FLNgSmDv6?=
 =?us-ascii?Q?pjSwbNHXdOpm2Yf4GbFAwzUsvxV/PMisXVtmQZKZYm73/XQguO4se+veIFop?=
 =?us-ascii?Q?1nSNN0JdtQH+Pw7CnuoG8VwMoQOdAEIbL9ZY8JBCnnwC6LJqXkcTX6t1wDIK?=
 =?us-ascii?Q?f+dGcoykwJkvuCzVRWiAI5hNo8o/oQusSOhuSpLu6Y5XksRFKp57XkrbY0Xb?=
 =?us-ascii?Q?wcKDxDtU45y2NjHsiES96z1mYbD6jnlKZT11jSzVtNPWiOKuI+u33CytYClX?=
 =?us-ascii?Q?KAC1lzbMnQVnFl6LjZRntPJI/IUfGv35kCXXPrJYHoDUibelVBWG8AEHcAqL?=
 =?us-ascii?Q?c0595C+4CoettdXVt6T41SPbZeVAoUrRg8s8srRJXbc+lbookbQjmDaFSr7K?=
 =?us-ascii?Q?3VBGMxXcNuX5GPnOSqb0acg6kpmdzt5gNYpjigAzRmqpVSyod+Z3I682eWET?=
 =?us-ascii?Q?yx9xXQ3jzwhDX0zc9Pi1eRAcS3KkZUBKrUDBpEzyWoj4XRngyNTsL7VxnisR?=
 =?us-ascii?Q?E2T7uNj3PiYktpCJLL3563RwDeMmQqxorn1UPQBes90zt3mQFGOelXfaU7+O?=
 =?us-ascii?Q?Nq00Pj1JAiHfF152btdpzyJ5vNMZWTx0zXLnrQl/oqYW7ZUjuk6wpdIeTZz1?=
 =?us-ascii?Q?yABc4VP5pTdDaDZ4WyOIY63rdCQftkyiQLlXc1j906JK7jEPaAQJ7nP17sZj?=
 =?us-ascii?Q?oY0AOR9LXdepxfIAiTdvr0/UoCs4RStsSjW3w5dB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aB1EpgB3kODgSwiJmgYej4GO0gwr2cdPoqsFiv5zYIz+LcuJ4EFDpkQOY9yd?=
 =?us-ascii?Q?VulIP8QztPlvWM0MbLKNI8k8h1cLFQ+vQN/C6SiOLIg6EEg20Or2Xp+rp1hY?=
 =?us-ascii?Q?hm85wlC6oaeKva1fVvWi5WF4DmzoSmu+xJBDe0o8jjPISQhnyYK/2fj2r7l+?=
 =?us-ascii?Q?ORyiiEoC2v68mwxH9lu/LXGD53WxV3D/aZctGNAGFzQCVfU+48/qryD34DBK?=
 =?us-ascii?Q?NFKIKJXz9n3Fpxvub5R5YQ2CUemrTvj7U4y3hCq33cmCllkm0ptO+YofSaFi?=
 =?us-ascii?Q?g52q/qatJ73SUz4rf48+Nq22CDp4Qv0Y8tp9NFkvcy/+GUCSUpgpKaVMxAyY?=
 =?us-ascii?Q?/B4dg4KRO2gVfzy6oqByOnS3yRkS6As7Vg2I/fvzHwEwbGdCC593eiHNQQQI?=
 =?us-ascii?Q?h1qGtBrC+5BFzTpoA1h/zl6splUxK65CuT6eLluBpGyHZp6veyed5kAgtndf?=
 =?us-ascii?Q?v5Z43LFeRgYGN8/jJW86STGzg6HOXypfHctyTEqKMxTIsqU6eiqJSE+q/E9V?=
 =?us-ascii?Q?bccBr/7DqdaN5xWzxfkWml/QY3kBzppP8xVl9dGU33JVZ4o516SoTDw/mWmK?=
 =?us-ascii?Q?hvQKayE5PUr7Nox5Pd0uF747eDk7jqZVISxFc+XVlM4Xl9s6NvXzwTHNwpNU?=
 =?us-ascii?Q?HvtWT8vMOXrtzgoynP+t2Yx4s31CIcqNVtCurq5PCYFsmSQFunDpU045Oc+P?=
 =?us-ascii?Q?k+xTeTjgdtgcnh6/zjLiq2XBvrfi8qMnw+9qCiBDXSRCow1vXjXzKrrBhoql?=
 =?us-ascii?Q?Y4w2aq5WafNY28Fe5mlr4+PRz/2xtKAz+j+X8Ymrj/toxpgPstne6x32LG8H?=
 =?us-ascii?Q?v3+yZPTXSAD60aVs+HVUcL6t3CuCsBTt1N0PCdguYlm64LBpkC+P8kYu/zEY?=
 =?us-ascii?Q?LJubp/PY/aJD3Wc3q/U6dtVAvbIBbnhh59+tqK/ERda0UpvCqAdt4KVXvMUj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9183eff5-82e1-4398-60cb-08db66a6eea1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 15:58:56.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trf+ytXiWQBchNdlQNfW7fNRcJ5FKoaeRd3oIfilz9mtX3VrGJ8kZR/t0A3kcs9fo/36K6KkojyFr3At84gq+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_11,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306060137
X-Proofpoint-GUID: rt485_fGt2iadKPwEEXqq7OiwC9Oqx9v
X-Proofpoint-ORIG-GUID: rt485_fGt2iadKPwEEXqq7OiwC9Oqx9v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/23 10:32, Tarun Sahu wrote:
>                                        
> Hi Mike,              
>     
> Thanks for your inputs.                          
> I wanted to know if you find it okay, Can I send it again adding your Reviewed-by?

Hi Tarun,

Just a few more comments/questions.

On 05/15/23 22:38, Tarun Sahu wrote:
> folio_set_order(folio, 0) is used in kernel at two places
> __destroy_compound_gigantic_folio and __prep_compound_gigantic_folio.
> Currently, It is called to clear out the folio->_folio_nr_pages and
> folio->_folio_order.
> 
> For __destroy_compound_gigantic_folio:
> In past, folio_set_order(folio, 0) was needed because page->mapping used
> to overlap with _folio_nr_pages and _folio_order. So if these fields were
> left uncleared during freeing gigantic hugepages, they were causing
> "BUG: bad page state" due to non-zero page->mapping. Now, After
> Commit a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to
> CMA") page->mapping has explicitly been cleared out for tail pages. Also,
> _folio_order and _folio_nr_pages no longer overlaps with page->mapping.

I believe the same logic/reasoning as above also applies to
__prep_compound_gigantic_folio.
Why?
In __prep_compound_gigantic_folio we only call folio_set_order(folio, 0)
in the case of error.  If __prep_compound_gigantic_folio fails, the caller
will then call free_gigantic_folio() on the "gigantic page".  However, it is
not really a gigantic  at this point in time, and we are simply calling
cma_release() or free_contig_range().
The end result is that I do not believe the existing call to
folio_set_order(folio, 0) in __prep_compound_gigantic_folio is actually
required.  ???

If my reasoning above is correct, then we could just have one patch to
remove the folio_set_order(folio, 0) calls and remove special casing for
order 0 in folio_set_order.

However, I still believe your restructuring of __prep_compound_gigantic_folio,
is of value.  I do not believe there is an issue as questioned by Matthew.  My
reasoning has been stated previously.  We could make changes like the following
to retain the same order of operations in __prep_compound_gigantic_folio and
totally avoid Matthew's question.  Totally untested.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea24718db4af..a54fee663cb1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1950,10 +1950,8 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 	int nr_pages = 1 << order;
 	struct page *p;
 
-	__folio_clear_reserved(folio);
-	__folio_set_head(folio);
 	/* we rely on prep_new_hugetlb_folio to set the destructor */
-	folio_set_order(folio, order);
+
 	for (i = 0; i < nr_pages; i++) {
 		p = folio_page(folio, i);
 
@@ -1969,7 +1967,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 		 * on the head page when they need know if put_page() is needed
 		 * after get_user_pages().
 		 */
-		if (i != 0)	/* head page cleared above */
+		if (i != 0)	/* head page cleared below */
 			__ClearPageReserved(p);
 		/*
 		 * Subtle and very unlikely
@@ -1996,8 +1994,14 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 		} else {
 			VM_BUG_ON_PAGE(page_count(p), p);
 		}
-		if (i != 0)
+
+		if (i == 0) {
+			__folio_clear_reserved(folio);
+			__folio_set_head(folio);
+			folio_set_order(folio, order);
+		} else {
 			set_compound_head(p, &folio->page);
+		}
 	}
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
@@ -2017,7 +2021,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 		p = folio_page(folio, j);
 		__ClearPageReserved(p);
 	}
-	folio_set_order(folio, 0);
 	__folio_clear_head(folio);
 	return false;
 }


> 
> struct page {
> ...
>    struct address_space * mapping;  /* 24     8 */
> ...
> }
> 
> struct folio {
> ...
>     union {
>         struct {
>         	long unsigned int _flags_1;      /* 64    8 */
>         	long unsigned int _head_1;       /* 72    8 */
>         	unsigned char _folio_dtor;       /* 80    1 */
>         	unsigned char _folio_order;      /* 81    1 */
> 
>         	/* XXX 2 bytes hole, try to pack */
> 
>         	atomic_t   _entire_mapcount;     /* 84    4 */
>         	atomic_t   _nr_pages_mapped;     /* 88    4 */
>         	atomic_t   _pincount;            /* 92    4 */
>         	unsigned int _folio_nr_pages;    /* 96    4 */
>         };                                       /* 64   40 */
>         struct page __page_1 __attribute__((__aligned__(8))); /* 64   64 */
>     }
> ...
> }

I do not think the copy of page/folio definitions adds much value to the
commit message.

-- 
Mike Kravetz
