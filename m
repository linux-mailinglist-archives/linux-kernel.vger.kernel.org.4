Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8BF60651D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJTPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJTPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:54:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2866354679
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:54:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KDwvWv021245;
        Thu, 20 Oct 2022 14:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=TLZ8+SsreuD8ENu1wLc/DHE/eJea13/KxeJfV9nZKWw=;
 b=esnDHuyC+mqC240scfH1jR0yuGCGGFXn149n+nAiZPR4INZbR+HIdu7CJZcg3H9LC6Cr
 7517nW1zxMEOEGY4Ax1tBtvsOQ7LmEcfjz0fVSDfcFQ3vfWRpjPJXrmoM3wfgEQESk/e
 piJFICuhGBIUtBST3HP9HPnG9rNvKcVizFOUWU3N+QgGMeSet/LUBIZr4wRpwX2G4rT2
 gAWsw0QaGkl8ziCMfqPuUO2MmfrX0B55+27NHPrGt7KCAiswHXYoVt2BV5danELXJjSR
 yK1BdzB8SjQnaIzGaIhIuwwDxHC3EJHzKlxgb62OQcUdAL/jRHuMDpkeotYwcQAya+zw TQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu05r24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 14:52:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KCvEVN038600;
        Thu, 20 Oct 2022 14:52:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr2awey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 14:52:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+/nwPG7sdhFbWlsgjh/tHQAOXdPXPb3pGzBPOLxzUaU/DJ8yfYrQRk4olmCEx0pswMjTB62HsIzLZ5LFuyx3fFwiMqlBxyTLzY1THs6X2+gCz8tVySIc3o78vonPcQz96Oqr7PAjJtajSJm5oQMfTw4UI75kR2cbSyIja6YgnwyC+MtwvcS8KHheIHMf0E3Cw/hK8hy70tqMjENs88IPqe0H1Da9+cCHmVnWKelF1OPNTJlS8gEZnunAlLyg8u37u7evuT4XIbEFPCi/YyVcTQdNusUA9Et0VqEtWk1XEjmeBiPpoAij4lYXCIXhXcXAb0lNM9PFZanLEBza8X84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLZ8+SsreuD8ENu1wLc/DHE/eJea13/KxeJfV9nZKWw=;
 b=YlXf+4ozozqruPiU6BZ6vJmKgUxaHEGK4FoszNZb4eDRxLd0gKWxs1ua6hic0sdbr05tX7UzDnm39J4JnNnbeyyk2dlYd93yC4LDiBcG4Ln0Y0hoqG3w4IEVCyRmPnCnNf/FOtL3WBlseBA7gMuzWcD+vT1FaBjF6AaH+FNPt1pYcZxDMJCoNex0gFohPlpHUD/4pS+oFyXiVbguAlus+UeCT5nEG8QcliDHNxYY6nQPADS+rQYWKi8LEodMuMlphEQUxe1NMUVSQKTHg3TPsj/cwb71QbDgqjWGh5ptzqUpk4/3mpfLrfmmwQ9B3BupQ+OvspcKduO7MAu9ZegwpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLZ8+SsreuD8ENu1wLc/DHE/eJea13/KxeJfV9nZKWw=;
 b=lgknr43gIXK/9yPvW/Xz11DRDMIe4/AWnckLZ9DtaH1Sf/ARMSLFIejr2iEr/0DANxcZBSvJ9ZxXt+qiMJnQRqre/cH5FtdWGIEirWfzh1UIoEelIoDhWvxCnrtdD1whfWnwdOJNt9CRZr4+LBIXxardodb6IXvRCc+0TxsZKJY=
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BLAPR10MB5218.namprd10.prod.outlook.com (2603:10b6:208:306::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 14:52:24 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::93:846c:dea2:6743]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::93:846c:dea2:6743%5]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 14:52:24 +0000
Date:   Thu, 20 Oct 2022 10:52:03 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jane Chu <jane.chu@oracle.com>, pmladek@suse.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        haakon.bugge@oracle.com, john.haxby@oracle.com
Subject: Re: [PATCH v3 1/1] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Message-ID: <Y1Fgk1iDnhL7VtAl@char.us.oracle.com>
References: <20221019194159.2923873-1-jane.chu@oracle.com>
 <Y1BfK6LpDJDlUYKp@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1BfK6LpDJDlUYKp@smile.fi.intel.com>
X-ClientProxiedBy: LO4P123CA0551.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::19) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2999:EE_|BLAPR10MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 0103de96-72be-4adf-53ec-08dab2aab2ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYqukP+9YBQqlqfeZpQmI4kvLiiFtxNXvrWLcI8hiYpsBa1r5qgdBef1lyGueWMx9dFBiIe2301/pUqeO2O5ExcjvoLDiUcm/UmEgD4euKI43+ZdUsQh1CBdLaYyL2FdtRIysHJ3BQXhCErJWQEurPotRuAk/lr9UT34GAQKvuQJDtqtoGEZFhVtnMfWxivzyVaK/2g9a1aBjMZouCASERINJ+qq4pnYuBtxTuBo0Yx4YfwHiBYr/5JFdJlHFnljom9d8FPNjfuMHI0FOSYboAIc1iLtaiBCy9G7agGoqYZAeb/qGbqhKIJmvfYtlSGFx1Xqpy+F09+F9kBkcaQo/t2pQnQSPjoPO7R7ZYjVf3T7qONJJNe7MLb331PWrWNoqADXvpPtJS0WR4zwhlk39dVpcX5IMPyV5PvV/FfwR/w/W2oPpiSPg5XV1HGAS8CrBNEhq7pVKHD/gLrVs509PE3aNBDiEDa6FM608pjAQwEABPwS24b11l2DQIazcxE8P4u0GDY67r/mrw1qM2tXUyZ6r6gf1tq/NidnfSWaXJ7bE1+j67cCOSamLdvHTE7WOKU8PX/ZW6XJWl8n8TORdOGllMd381hxE7Q6N0t/B8qvxKONHcO2B8hUss7Xf02rvxERkT9rNVnkVz6FcAeJgrjgYzdx+LuETg8m8UE4Jpfm1d/9NXaov0zI6Zgx/XmWRYyEz+IbumfxAQDqS2e3lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199015)(107886003)(6666004)(66556008)(66476007)(66946007)(8676002)(4326008)(6506007)(316002)(6916009)(38100700002)(86362001)(83380400001)(26005)(8936002)(6512007)(41300700001)(186003)(5660300002)(2906002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KreLm34IZkU3xkDw3XptT3O9i8ZyxaZNYS+o+3hNrzNszFTM7moCIQf8uSUw?=
 =?us-ascii?Q?4yEws7xIkset+N+hN6TaA9G8EMa+GSMcdjXgQpOzz6kisabZl4lxl1YPX2ON?=
 =?us-ascii?Q?t9KjIahc70/Z8MQvJJt/FGXjCo7SlWOCrBifboau8lWfxQnPEXpMz/Qjwdfh?=
 =?us-ascii?Q?mMy7hAw0Ai6a3VVGL7K3LmW8x9hKzGftGNq93lE3pBUmEatHILsRoDcXACAb?=
 =?us-ascii?Q?JqBMntIbFAE3WjRNxJUrLtIzMva3qFPJqWnkeH2MU3FswQMhSSIC50V+vKHu?=
 =?us-ascii?Q?A0qiuASlG0Lg/m5isrPtNbQQqmfymduMhfAT+e1GFKeepoqdoV2Ud2TfBEkM?=
 =?us-ascii?Q?CyfBitUiEshEVeWzhFu4cANeDOBlXXuLgrlUiKQJ93yy5P3X3Xv8DNqQCX7W?=
 =?us-ascii?Q?DUX95uwl0JvaGYxnQjVsb48Q0htxjolrS8E5muXs0ZilAbwGKhh+McYDY2de?=
 =?us-ascii?Q?MqMfdNeyLUPWLMF/RP5tMs5FwiThWWSst5q0TAVqYiE1unzX6S6KiZos7T4Y?=
 =?us-ascii?Q?+BRAw+wt7qCSEn2hSOapkhfP4nZC5v3F25g3k0VCDxwW2IYc91PUYAZVf/Ho?=
 =?us-ascii?Q?A1NDf3YWoFVaxGV3/NYbLvk9J6XaYVTbcO5Je0WhrTK5oHTnl+6yXz4jjD6v?=
 =?us-ascii?Q?eHs7TJUgHTEnD5XKykC4iKw24SasIW7dNP3d1gNc8RTnmHCzq2VwK4SSg5hR?=
 =?us-ascii?Q?//GZHPxEDE6MhDczg7pmRoH1VxUEB5EhDW5tqhAnpW28iR9WFWAmLZRC3JtM?=
 =?us-ascii?Q?VDqM0neQiWl+yfNhHsDUY/FcOrHmJs+q6cEIiQGG+agjwBfF6v4IZTAEozzT?=
 =?us-ascii?Q?ebVdG9qkjFTbUvEaRLigv2YQPb7rBBDS5kp05vd+3L1HmoZBHYCcXyWP+AFn?=
 =?us-ascii?Q?qg8qOXVV+OdWeViwcSFYhUCPblF5obHm+2Q7DgVrXLYTNmoByPq9X94D0lWc?=
 =?us-ascii?Q?q+xaHNoClMr7UGxL5pUtfAKFK1u/saH1Vmn0Q8K90L01YLXbIf7Ab95WQ7fA?=
 =?us-ascii?Q?JRoIX8AvFpAZjrLwQoTKnrLhAUKhC3oXkkBH6wCFD/iIOl6Mu+xesk4VySPC?=
 =?us-ascii?Q?U+VGAuEJdjrWf30zwjY1aBfVwlmVmniKcKdKoJI1yKicb4M/8iObS2gi+O4c?=
 =?us-ascii?Q?pw8pSskmhr1UWgsuW8SeALtZu2lH+MKUPQRijZeMetiKciYh4PG23aQ7W+5B?=
 =?us-ascii?Q?LvJEZ7qujuS471EKhNNdtc7O8eWSbB7IC6Ek7BcwOTUAgFN0PvOPJjjbmxhv?=
 =?us-ascii?Q?K01aBVOHGG6LqtgMMF/9sPEu60XlLIhe7Ie3EMaD1OVvRpMuonEip6MR+nVy?=
 =?us-ascii?Q?xtO5hgyUKRq+1XaqbssafMsvxKiXoulyKzlC3SaGOsR3tQtETvPXdnm64SHc?=
 =?us-ascii?Q?OG217Y/2PrS+2f1XcdANl2V+LBIkrseDSmKFOznjCgtjzAiy+7L+ufTx6zfv?=
 =?us-ascii?Q?SI3knvC2m/afU8Mtf5b61SR1dJIxNxn54CnO32aJP6LoN/0FS1NLdrXFaX7o?=
 =?us-ascii?Q?cCJ7b+BxvFotissXwPxfiqvZiepr8bYDUOlawuFkpPPRnvDSZZfgE+DxcziZ?=
 =?us-ascii?Q?G0iRs4ULyMWYsexJwmccApGmmM4kYD/MJR3/Wbj+T5RQXCN0j1Ly4/uFi+04?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0103de96-72be-4adf-53ec-08dab2aab2ae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 14:52:24.1737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUavx/9uW44oZfpA07KkcKusMc6XwcN7ipqAWfIvxJbfe7+fmFlVDIi2DQtCs/97l53bEs3HPlbA6fCtDSx5Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_06,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=684 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200088
X-Proofpoint-ORIG-GUID: rkk5zapVj9BYrt1SxcoapYTHiScvZrYO
X-Proofpoint-GUID: rkk5zapVj9BYrt1SxcoapYTHiScvZrYO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:33:47PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 19, 2022 at 01:41:59PM -0600, Jane Chu wrote:
> > Having stepped on a local kernel bug where reading sysfs has led to
> > out-of-bound pointer dereference by vsprintf() which led to GPF panic.
> > And the reason for GPF is that the OOB pointer was turned to a
> > non-canonical address such as 0x7665645f63616465.
> > 
> > vsprintf() already has this line of defense
> > 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> >                 return "(efault)";
> > Since a non-canonical pointer can be detected by kern_addr_valid()
> > on architectures that present VM holes as well as meaningful
> > implementation of kern_addr_valid() that detects the non-canonical
> > addresses, this patch adds a check on non-canonical string pointer by
> > kern_addr_valid() and "(efault)" to alert user that something
> > is wrong instead of unecessarily panic the server.
> > 
> > On the other hand, if the non-canonical string pointer is dereferenced
> > else where in the kernel, by virtue of being non-canonical, a crash
> > is expected to be immediate.
> 
> What if there is no other dereference except the one happened in printf()?
> 
> Just to point out here, that I formally NAKed this on the basis that NULL
> and error pointers are special, for the bogus pointers we need crash ASAP,
> no matter what the code issues it. I.o.w. printf() is not special for that
> kind of pointers (i.e. bogus pointers, but not special).

Hey Andy,

Do we want to have user space programs crash the kernel?

This patch leads to making the kernel more harden so that we do
not crash when there are bugs but continue on.

Would we not want that experience for users ?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
