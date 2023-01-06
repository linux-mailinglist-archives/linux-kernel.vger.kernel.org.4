Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F86660A12
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjAFXGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAFXGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:06:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BBEDFB5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 15:06:29 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306N5hUu028118;
        Fri, 6 Jan 2023 23:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=d1VIkPFkTWO2vdIM2apSTVhUfbMxcq9lkPE20rpPpy0=;
 b=tfOgNbrHw806G8f/q3dFsArnok3fSNhfZccGvE/Ap7pwkHYPNj98PjdIq2vtKIFyoohn
 r7a21qT+xdhjVz2PF7uDxvojod81JNf0AQarcI7o/itBp8U+ayRLKZMsWNmYbz3Pz7tQ
 XP14rOsnALU+vF9F1CadiBFaqP24uvX+dc5gQHeFqiuoaFJA0FTNRfw9smEkVgdy+4QU
 jk+GSQh9EcB0Qz+75iM2/2wajqDWtTGA0PmxV5VIBWkib6VSYnInxkjavH9Pk1DqX4Si
 HTrnff7a8HVZ8u3PWkCt8rQgXZMGEZTBpUzXH2TvZOrnYTYnnt7QhoqQXrgXLTz4UgPm zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtv674-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 23:05:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306L46Rm021006;
        Fri, 6 Jan 2023 23:04:25 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevmf21h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 23:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEGJWolpuZwHcwvz3sRDkdCRHXLIaUeu5AxkE8c13Od0ZzTYF2WpknjraWKIew8SsWfweS4n2sL5jMA9k9Q+hLehHTfF2SzGx82kaRJPMEoqJmD3lPgfNovxGzThSQDx8ngbfmX2ARSELNTD1zWZZFLXaBUpdW2VzSS8PzN8wqxnqLiXxLZlBdfffM+w3qIW5xK40EQslWxmnxOjtQMmlbKO94NrFWCTRB/guTrZUyqeyFrB1vERnflF8uWFVSC3vvGmIzG48t4dh8m+CYW/oNo8YJhGUGs3UhjwulAngajzhP80WYaD/lZokbBxZT0dJgi1+lt9+vZVFmYOMAY0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1VIkPFkTWO2vdIM2apSTVhUfbMxcq9lkPE20rpPpy0=;
 b=XfmXQA1mP+mswda8jmTAxTSzMjhfoiRJbiXjj/3jbBGPIIf8l47zGLLrGIGpXB0wxaqPwRWHjm/rITBvezl0tzpSN6vlqZ/rSn549rwZjVklkG/1r/hgdMYK9ivWjM4iuJLd88LUEH/dYf5KdkMCkW+XsFnh4UNCUORg/kPdEHG+zxpOv4E/ouinnyIWsmaG4v0YHT10GFTQpeWPkDKv5zVwdfQcXEArEsFkt4qWacOoTHRkkYiMRecHoedMYbY216jagVlt8xiRMDLUUcxZyM6jYLl5qRwDRNjXBZkmi7uWF0OzzLI4tXY+Gd+hsQiYpbnOh9X1GUSM6HM9YPz5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1VIkPFkTWO2vdIM2apSTVhUfbMxcq9lkPE20rpPpy0=;
 b=mnqsBntBX+xO3RCqOIEo8SxSDH66ns+oq2DJ8gipKPjkvCDnVZR2Ox0gOU/2u0wxg7JAHa/IMrSBptLHTxP9SnNYyinz8rVMm3fl0ZFoAg7rA5phED/gKru/e3aILVjXA4IqNQcL2P2dBFmo89xkAXyimxOFQWSba6bzcBUsSM8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ1PR10MB5979.namprd10.prod.outlook.com (2603:10b6:a03:45e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 23:04:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 23:04:23 +0000
Date:   Fri, 6 Jan 2023 15:04:20 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 1/8] mm/hugetlb: convert isolate_hugetlb to
 folios
Message-ID: <Y7io9F28IslCAVNV@monkey>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103191340.116536-2-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:303:b5::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ1PR10MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b54e0f-d5a6-455a-b33b-08daf03a59e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Z3R+5sTeF9TMq3vW/JZu4DBDhF8KABPPfEnk86HlsXVr72wfr2An5N852lRvS/+3nLM8lTKI/ahX0pJe4cfs62QSA8I+yzsnY1bNNQvEx+xwnJEpZgCjITAqVaRpyF0/6FIblJuRstVXy3pQiyQu/bFf3BG2MPEKJUdE5HiZEaTx+cWyMzx0KX1VPNBN/TVXZsBB7a7OQVRHB+V2zfLEmLbyXlTg6yB9HbtdBoY/izwLtFoobP9C7x51vGV3YXyq6KsXq9zd1DIXq7xCMqTNFIeN82TmYCRqAOK1x0UTOjKnqxpp7GVmWAuDL2Wulabxdazm4n22uXxZq/aCycOGm0JH2AY4Oz/4WWFRRH03hh0X4CTdotIGjwcCX8XnAacj5mlCJYjtKK1k6PSUWUY3Cr39Ns3isaNGBcTUrtaYHW0Zw0/SllCj3Jv1G6uuI2mRuYjaSpGAyv9s5yfxUsAiPJkxpDSlHHmUiYxCo8QW3tX8dLCczZEJ0s2gP/O/J2jQojfP9d/3Oltwg1hUdF3B88I0nT3uFPrmvd8eQ6w7SCcYQ5bZgv+ZdTssCuf8OfYCrE5lLWyI8ca70ffg3HUFKkOVKnZGNDFIj5DDvjQbuKBokYJaRYxB5AACY1c9ccAOD8XA6RLBgwD6dQjPWwk7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(5660300002)(2906002)(44832011)(41300700001)(4326008)(478600001)(6862004)(8676002)(8936002)(4744005)(6636002)(66946007)(66476007)(316002)(66556008)(6486002)(26005)(9686003)(33716001)(83380400001)(6506007)(6512007)(186003)(53546011)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7KDEyg5wVkSnr23QLX+evQhDdGm5GdazpNWaciDWJEBmwFn4S81Ff6o5TEi6?=
 =?us-ascii?Q?3cLozbBVjvcRsJ68Sx7iAReBF8Jp8wcvDdHy88GbNkAUR/iiW1KdKYe0qE8Y?=
 =?us-ascii?Q?qBONuoM6wOVu6bezVmrAGrjuR6G04jMHQ+uAl1v/gEIocBLqU4cbJ8ZjkyiE?=
 =?us-ascii?Q?xpeKwWOKh5VpxViaHFDnU2jwlHcucqjPGgVwarppURPJgc7Q+z5JaGv95wxm?=
 =?us-ascii?Q?dTyjDGYm32hF2j87AWuwsV/6hr7pgoKbhAfveug+XCdh4IkoS+eEci4K8oe/?=
 =?us-ascii?Q?CEsbR+0zLEarsJZcqw7VQwErirWN979KdDBc6FTQ8HoQLGvY/E1/TA6lzl0/?=
 =?us-ascii?Q?3xoizH/EGuzgQL5T/KbDLuyeAPK+7UOqA+hMQFWJX4IH48k10Ttffzskt3fM?=
 =?us-ascii?Q?tgs6EWpbZztdkjruatR85iYmZfIN48ZAV8upGEpDjQ9y8F6ye+3dQc/p1nvw?=
 =?us-ascii?Q?uBi4Vi2Q+vBbSYmxrFVHt7k6F24uKAVNmnT4fCdYs8jnHHm8YLDvmVnjGqlJ?=
 =?us-ascii?Q?/mDm9ru1Ioh5TmZ8WXcsVqPeUbjlb2EcOh9t+dQxPIGarjzBxi/QBuIKd60s?=
 =?us-ascii?Q?sfliSh2IrJ7qzWnNJ3o5jfABqf8n7dJjjwS9u46eqyWfTCXhtqVcNp2IwrU8?=
 =?us-ascii?Q?++6bg2M3UPnL2CSt/BxEE7K7yuxMTUEqZh8UcO8AmbaUNETeifpj0Fr76+0E?=
 =?us-ascii?Q?GGc3HKcsoOu/qlBTmDMkRZxWvkMyaem52ZZTJxZMTQ+OXmwXXRBEUBp6m/js?=
 =?us-ascii?Q?4oddxWEufNAUuyGtMeI/+jvnIl1mnk4O8QgDG0HmWGSVi0Nlz9Fws5E2lOWw?=
 =?us-ascii?Q?ofp8QTQo7PPfdtEZbQMsV3CPwxjYdDy/2xwU/x7K8EQwH1ALsdUGFDosRTOn?=
 =?us-ascii?Q?t9uMEhrmWcbKlUUy9k+OzGR6MXvRZafRIQisLqYp3irnOLj6HOLeuUsHY7FT?=
 =?us-ascii?Q?WRsxqPHKJiHiAXiVX/ce5URnILQMwMfb+1AGbNEJYhdJ4XI+gmc7KhT7WsWX?=
 =?us-ascii?Q?UjnA15FSh9k2NWIJ/ixY6JoM3LPIrTul6PkktmXhH6NXoYNwtQ6dsVkzS3B9?=
 =?us-ascii?Q?SiFXAbrz9tCeuyDU/O5hD4VpdwWvie3RDr7PAXl8Hh0f/TwlF9lG5QXThu4L?=
 =?us-ascii?Q?oGl6px+MUVgbBrz8eV8UgHdUaOGOTCJ8qtpM+qlGl4023dxeEnkYfvGsJw4N?=
 =?us-ascii?Q?zFTUgPJbI2bfXtL0xOQsJ6fyXf9V5yEhEIf9peSh9opn7WR9CyUlOYKmk7rP?=
 =?us-ascii?Q?xooByhX0KqCBBEOQw0PjH69PN7rsKtiWtIqN7h8D5QRMlDVKFXa5CO9adPWg?=
 =?us-ascii?Q?EmuHxY3exx4eTueffjw4UQsJXK8XizMsFKf7iI90/9LRUfj/N5pqZp+o472h?=
 =?us-ascii?Q?YNy5uJgkxQA/ejzALJiv5npyMF4DDWUdHNARk4O0CCutOUpmwJ1jpzYGeaHo?=
 =?us-ascii?Q?LHwWCl+LaF0z654wPMnp+kOzJn9GzP41AmTGnDiEOSmzzxtcx+XSUXtCDpQO?=
 =?us-ascii?Q?JfA5vxVO14DO6iit6Zwc2yESDpecQ8H0b9rA3EKhtoqP5byNAMj3CqjRVA1P?=
 =?us-ascii?Q?2tfRqUq9bm0GO75OU4X38ZA10VfzPQHYZsiw9SdmZZZgLYiXwSnj+1GGQIDg?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EMJSHePUy4PZoyQdG4bMixMEYIFPN8co7JOxLCZcfMFsw5/vQ5lHmV8SGyvw?=
 =?us-ascii?Q?v/lHsZAB752piMIK09DphuCWjDg3tyAaOg0Xy/lBZuI+ERH+khMAkCcoma/D?=
 =?us-ascii?Q?MoXEnD6Z3uNqf+WEWlx7C7YdYFKfchYMwJ4lmFSHubtKwqz/wXkH09Hzongd?=
 =?us-ascii?Q?rb0v+Cw++C7C3lNNZ3W8w9NLsPPjTi94H+7sBy+wOZMs6t//55VizDEQidJB?=
 =?us-ascii?Q?JtOpw3hRiCYtZxHG/y5t+facYxng/ecIeCAot1ksN2IFGgRTEFcq+9ADpUOk?=
 =?us-ascii?Q?QyYIxYcQdAeZsxidYgUv603YoGuiRjCLfmKD/tEIsmjccZeTbu9T5wUq3TJL?=
 =?us-ascii?Q?HL20yXWKwK4y8of96l/JQMCDkzxdd7P0pLKYaGLXoQrWxMNRWKQDqhZ9hy60?=
 =?us-ascii?Q?AmwOMv4f7q4CFZ6WLWlHpmcoWC64eGZIYUXum/5L2uSCZ/g+SsSEvEHjN+Ny?=
 =?us-ascii?Q?Ho13+KpIRBE9XSGmKKBWv79S6PY1VMIaa/I6Sddx0pKemD2PZYiCS0Dz/ri2?=
 =?us-ascii?Q?YmNCesZYbYgUkq+P4hPecaaKBI7+zIPZyBlNPsTtxcezgLtfveVWA9lDw8fb?=
 =?us-ascii?Q?GnQvjmHwOIs5rL1UITIKBN4TmL2YRlznv7NgsjsAcKNgfbjfRc2TDgV/zG7/?=
 =?us-ascii?Q?9I0visbJJa9NrQvIDKZRgSLb9P27HWs2KXwqE/oUNf2E1erojXyHHQZWCgBX?=
 =?us-ascii?Q?jgEEHZl3evIcpwKC8nyjyDbA8hiGIB8L22mq/zKN/UFY+eGSFwlWyif06Vyz?=
 =?us-ascii?Q?gB7FXeNZB7WqY+7vcoglNnOUBYhfu+9H8GYwabmlsaIGqgVhyQWneCMkDtMW?=
 =?us-ascii?Q?rpQRLfMKE69rQpI9Sep2Z1WNM4inPNRZshUJYfR0wSVGrV0sgpD9L+Dm5R2G?=
 =?us-ascii?Q?fQs60eP4qW+II/dyK7sEo0P3zxFy+Swn9YmDA+4NEm236dv2yu2zBT9I9bAv?=
 =?us-ascii?Q?zkri4D2KPVkKheV09Pftfhl/KdFsQEG7r1YGd/OcPAM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b54e0f-d5a6-455a-b33b-08daf03a59e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 23:04:23.6349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pPQv704BjgZ5SDjPjDb+vtdmhEeji0ADWG3Lz/4m9/IOYC0kn6zpJe+cZ9wEMg/WtxQC3ekyMxhhkQZ4sD3cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301060180
X-Proofpoint-GUID: T6pUAiR9GKhNLNyUGIn4E5G-IXxt0GL0
X-Proofpoint-ORIG-GUID: T6pUAiR9GKhNLNyUGIn4E5G-IXxt0GL0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/23 13:13, Sidhartha Kumar wrote:
> Convert isolate_hugetlb() to take in a folio and convert its callers to
> pass a folio. Using page_folio() to convert the callers to use a folio is
> safe as isolate_hugetlb() operates on a head page.
> 
> Also add a folio equivalent of get_page_unless_zero().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb.h |  4 ++--
>  include/linux/mm.h      |  5 +++++
>  mm/gup.c                |  2 +-
>  mm/hugetlb.c            | 16 ++++++++--------
>  mm/memory-failure.c     |  2 +-
>  mm/memory_hotplug.c     |  2 +-
>  mm/mempolicy.c          |  2 +-
>  mm/migrate.c            |  2 +-
>  8 files changed, 20 insertions(+), 15 deletions(-)

The hugetlb parts look fine to me.  If you address the get_folio_unless_zero
issue pointed out by Matthew,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
