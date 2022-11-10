Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9786624C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKJVDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiKJVC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:02:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EC8BF43
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:02:58 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAL0Dpr007506;
        Thu, 10 Nov 2022 21:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=Gk8VTcWTIuOFOjGRYldeuAIjGoS8kTluR8SSQaGrNh8=;
 b=OH0YL/T1B6OOwd2qgoxTZIHcH3dW5b/knaNnfpx15rjHaoGkRZCl722y//1sW4IbttmG
 ajdszn4R0eMzP4pZQ5uTmwQ2RsFpMO8Nj/v/X8v8JOCNvj6InpZH1LVKRO7kDHayc/P6
 oLk+qs9pXjEenQqVNFeeqbBOHyu9MQzDH9mXnR0pqVY3CYswcHhrKiRGa7zaQAGDvXAn
 xs9AaXdlJxCRplxCdzR4N2aqG53f4qUboJDxI5l40caKrnVavjuHK06o7pmy8luyfrym
 HyzpnLmujcoBfYod41piYqP2RNxcE1Ss2wkCosEZN3PbgupilVIPdzAUoOzav3kSQzx6 Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks8a0g4c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 21:01:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAKfdT1009832;
        Thu, 10 Nov 2022 21:01:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq5h45s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 21:01:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8tEd/93XDR8PyQyVJ8L2T09HcDzGdn+8R2oYm1G7596rO9nwj8VfZx0GdM72TbPBJO/cZS+/YscHe/nrjiWGnFMploWCTVMQinHqL4sWiRnlF6BZaWFvmShvcfj24tvGv9s2XuNarQjud98g3bjRj8KBuO40r/YybFzcn90A3nlT/eSjPcL6dn0/wRv3aWqS8B0FRxYv5zeTRRDYWjB2zhFgbUdPaKIMIQNfgBOhak7uMJhdgLVWK253dV4HYrBmLtCMO5Zso/1yyUm5UqsE5r/dw/3Vn8TQadRO77vldXRCpEjv5Leou4y6iE0U1VnM1pLbFAqfcbBUMBWTP0mlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuHzNph+e9HX9A4wmsO3FoEfXE+CQilThqjxg5hyEEo=;
 b=czxEv3pFOXgVk3q2oKeccdkT8ejW7JDIjomWTT5bphswZ5MqRYTNtt6ru5iKtxoZo9PIJ/5fZepU4uvmrScxQL1OfUoxQKsRzBqpXIGUhzU0vvARgd9s8m0LyYhLsayPEoAF3G7c53nkxBR+496odNhFvWgtNQLeCW/L8Xt0jv+fJiXSe+N/ig0/1Na7ntQUbIG6WyWDn8bQW8ky0SVES+RP5/SyKbrslTvNYlVG+1Axwvhw9iPTIdQPO+BgWC3Og5y3TSwSdTgBJqJaZjvJA41xjTYhKt2mptDGirgE2AwqqCjhbIkoI42QDuQ72sa7/6PN2C2tY8OYkBTTH4PB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuHzNph+e9HX9A4wmsO3FoEfXE+CQilThqjxg5hyEEo=;
 b=YTuOESwjkb4BHil/eDd7heRXoR1sGVWFanUU9WaIS3NLVu96DEurNMnHr9qnEVQyLEjGmKAyrx2qGsmmgIuboSSk+cSl+Uf/NtZf/vNlT/w6+piIjUYRdAWMHMpN1gLSwXgQTdjUJuU2+33Sj+1UMtBXh9vMk/GwjtRTGZyzTo0=
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4480.namprd10.prod.outlook.com (2603:10b6:a03:2d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 21:01:16 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::93:846c:dea2:6743]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::93:846c:dea2:6743%5]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 21:01:16 +0000
Date:   Thu, 10 Nov 2022 16:00:58 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        harshit.m.mogalapalli@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [RFC] iommu/vt-d: set default value of INTEL_IOMMU_FLOPPY_WA to n
Message-ID: <Y21mitQsO2RG652t@char.us.oracle.com>
References: <20221108125855.2984751-1-harshit.m.mogalapalli@oracle.com>
 <dc463b3e-2875-8aac-aca1-edacb90e5650@linux.intel.com>
 <76cbad17-ab5e-3dd9-cf94-df2b26748167@oracle.com>
 <3a7f5cdf-640b-f9d4-a25e-8be845abd7ba@linux.intel.com>
 <Y2wK6kWHE1iah/IG@char.us.oracle.com>
 <0f1ad424-18b0-c27f-dbf6-745801182bd2@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f1ad424-18b0-c27f-dbf6-745801182bd2@linux.intel.com>
X-ClientProxiedBy: SA9PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:806:a7::20) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2999:EE_|SJ0PR10MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ff1f32-1be9-4ee3-d7cf-08dac35eb543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tO3xi72evjyArxik/2p5LABQcsCO9RZC5EvUIBMxkpeU1DcCvaHbdBJy99XDdn/p816sIyxsy1RxY6DYJzxKUBKjLEbYiotfkA3z8NJXKhIX/iAmuEqD6aVK+jkg+HgolzDH1aYkPSybsDmTonB/yIyGBsQtgbp5386u002DFNgog7zbpP9oGNJ6JKE+sKWv2eWBaSijc3xrhnDdOQqERp99CVyL+9Q2w2zoQ4L29pcOO4KI63F34uf9Q0PyUmB637BPajhqlz7nM9K2oXX02okhKKzdfmUErhehCHat2qsnM5MFYCL6L5GavudwLRBwDAsQHkDs3LfP9WHo+0uiiXl4lo23wYJMZ5UHq/RO7evC72IjcPiFlK4jllPQfCDJM92RRg/eFuBjr/gG1zEE1AP3HqIvXjsGVXalT215hSQgj67mGmsO4dmmAypdQB9j/wZgSl6t8NeS9oWSelVYgyLgo0LG2K4zATHsEvdgw5U1Bvg1r1i4mFPcPwnNf/R/53/Ko3DP6F9GIsrI6QbfdXa7xjIwOVWSKQ1MPIAKXfGqStkjS2eLsl3w4xm0Z+/mhA5Mdz5mPDA30M9v9D3yOBQR0FEas61nNFbvyrBJ/EuoyPQzD0kpUl8Bl4gs2a/8KhxcjKY20u+y8IQBY/gVhSx7dz+qtD1Kbr26V5U4LBPkmWIeKAc8fm+i4a7aqn7PXJjB6fc6d3DJPs4pvBNqUkVGk3DTRB5MLiJocqVlY48E+ETxPVX8w6Iu4TZpjQeqM6Gcbcm5i4RsF8EcZfsfgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199015)(6506007)(53546011)(86362001)(6512007)(38100700002)(6916009)(186003)(83380400001)(2906002)(26005)(54906003)(5660300002)(8936002)(107886003)(6666004)(6486002)(478600001)(66476007)(66556008)(316002)(4326008)(41300700001)(66946007)(8676002)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ie4yTMtHXg4RaUvkwOz+OOfdFBnThJ8AiK6qZlrigXXz8HstR6S9LyLkpl?=
 =?iso-8859-1?Q?yH5oq+gxb21yAOm4shs6LB4CKFN3jjBLI0D33rdffQzEdaE63OCaYjfdef?=
 =?iso-8859-1?Q?hQi8LPbRXkVvCevVl36p+RYleZPcEsu/nOzbcVUVcrwgvRK0+9t2BotPSA?=
 =?iso-8859-1?Q?KiSZ7CG5lg1GPhiB3R/o+WsOsxA5zF1ZdIEWIb96EfKzgVA0o70HMJK5bm?=
 =?iso-8859-1?Q?dU6t9FcszS02xWIxN6Ub+9xIg33ZBroyCPaD8FwzQJ/p7nEzfEzkPzkdvY?=
 =?iso-8859-1?Q?GPKfC2UmqSNwNmc2JHIKGlQbl+UjjofXJctBXYNYpPrTxjQAJgfQ8LIfME?=
 =?iso-8859-1?Q?FzpqBObUH3/fRbotgWPnMhe9RfU/VuWz+0GQRnNKnVkVEzcBeobw9isywH?=
 =?iso-8859-1?Q?1Gl6h1gM1xHeQjAX9YViSt+Zn+S04Lb5FmveBBq4UmTrq6SEKkps+IQYVd?=
 =?iso-8859-1?Q?N+JCo/9U2M7NE3aTv72qPM3p5UQNpoVL9ry4ZnLSkvKeYVmijl6loK9WFE?=
 =?iso-8859-1?Q?hlpG5/fL3eSJcbs46uTYF9gLixN2f81bZ5ZfVfJqCcYrhzzaAcSsoJKDBw?=
 =?iso-8859-1?Q?RWtlOaotU9IK7p+8IQ3d87B/m5UN1GqFvWpxnAxD2cRLD4fTeWlP7IGeMa?=
 =?iso-8859-1?Q?LikhNlLBgm67atpMYKNHRT0lCnpA4vPjPJ77jBbsojNyDv708s+0tlv3eC?=
 =?iso-8859-1?Q?e7S6lgs5r2K4MG+emLIHrFa9uRnMSNA+OVuCbLkggwO1X7XWzgrnVspcmG?=
 =?iso-8859-1?Q?fEnjasnBcaL+9QXU3idK8J+XMp4ABAySl1hsl7/jAPEGxbSoU7AlXRWh5k?=
 =?iso-8859-1?Q?eXDqzXV79OtPF975FL2gbkjce3kxTs0aBr09Od7rvOWfFnGJUGnRIhagPs?=
 =?iso-8859-1?Q?pcEr7EPT0vdP3TfMy3OkiQ1ts3QNP/Gh0jTwuTcDFt3FKCX8wOnEmm3CRC?=
 =?iso-8859-1?Q?1VLo46m/zR1M5TzzSg4xxQFNOIryRegXFoJ/LNkdYcpSuNEWRGrM3aj/WL?=
 =?iso-8859-1?Q?mNchOzWDqMoAaadG704R7PJoiNq42HDUEZrYKGpJNbPQKb8KKFFz+Lq9Oz?=
 =?iso-8859-1?Q?fIZpnGi6rGAdFZZCPUC8ZyR/ZSvBrmsHZ4ox8aSoFYydNll56xBbv9VqEh?=
 =?iso-8859-1?Q?HuWXQeXisbpKSpAGJvKXUk2YJa//Wft5HMQnCbwnf0wRf6Q92tGTnsb+Px?=
 =?iso-8859-1?Q?0bSg/tPOFj0qrjcuemMJyoFyUQ/HOC5+2IIF6lgLbNYFmpEJCnj4wAgjF4?=
 =?iso-8859-1?Q?fEmAQRZWVQiI3d+QA0jRb1gqlcbrcJkDQcvTrW8De6lmP4f/i1hI68esNJ?=
 =?iso-8859-1?Q?1EPbdwfIt/uD1nCu1O9rhRaqUZA//IdoQgT0GXTT8oioGCY0cxgAZ540VV?=
 =?iso-8859-1?Q?ZukJcimVCD9HUjVQbmWn/szhqKhSNOjmFWXdGRlyr4b1BE0r8wRs0N56aD?=
 =?iso-8859-1?Q?YZC9VC1/xdTbZiMTrC71fXzxTVPSCZ76COqzBqbb7OiJi7MtIYbsZEREn/?=
 =?iso-8859-1?Q?T4fuSSc4VAx5zE3kKROqYl61taxY/LJd+4kn1mdJCnyqG9ojxfNxpH9Nf7?=
 =?iso-8859-1?Q?yYjPfSMktElRfrFnsOOZTzyoKDyPA3yoaoQu4YYJxmSipFNq6JS65DXBDm?=
 =?iso-8859-1?Q?pdQjDi8/iyOT1ORk7LhXk0jhGAqoct5bqlDHwJp4SB2UA5gcKeYtLVmQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ff1f32-1be9-4ee3-d7cf-08dac35eb543
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 21:01:16.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QwZidBfdklmio/hIZkk6eUPu61YQpPe/pxmCMOrg2x9b/fllEDOotyiQb5Ac3vCi1eeK1+/ckzIKjWZI1Pcvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4480
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_13,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100147
X-Proofpoint-ORIG-GUID: iyvp-uFkJzs9wzmqLIeeadXYbfdgoVow
X-Proofpoint-GUID: iyvp-uFkJzs9wzmqLIeeadXYbfdgoVow
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 02:39:53PM +0800, Baolu Lu wrote:
> On 2022/11/10 4:17, Konrad Rzeszutek Wilk wrote:
> > On Wed, Nov 09, 2022 at 09:16:53PM +0800, Baolu Lu wrote:
> > > On 2022/11/9 20:16, Harshit Mogalapalli wrote:
> > > > 
> > > > 
> > > > On 09/11/22 12:35 pm, Baolu Lu wrote:
> > > > > On 2022/11/8 20:58, Harshit Mogalapalli wrote:
> > > > > > It is likely that modern intel motherboard will not ship with a
> > > > > > floppy connection anymore, so let us disable it by default, as it
> > > > > > gets turned on when we do a make defconfig.
> > > > > > 
> > > > > > Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > > > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > > > > > ---
> > > > > >    drivers/iommu/intel/Kconfig | 2 +-
> > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > > > > > index b7dff5092fd2..c783ae85ca9b 100644
> > > > > > --- a/drivers/iommu/intel/Kconfig
> > > > > > +++ b/drivers/iommu/intel/Kconfig
> > > > > > @@ -76,7 +76,7 @@ config INTEL_IOMMU_BROKEN_GFX_WA
> > > > > >          option is removed in the 2.6.32 kernel.
> > > > > >    config INTEL_IOMMU_FLOPPY_WA
> > > > > > -    def_bool y
> > > > > > +    def_bool n
> > > > > >        depends on X86
> > > > > >        help
> > > > > >          Floppy disk drivers are known to bypass DMA API calls
> > > > > 
> > > > > Nobody selects or depends on this. How about removing this bool? Only
> > > > > less than 10 lines of code are impacted and are not in any performance
> > > > > path.
> > > > > 
> > > > > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > > > > index b7dff5092fd2..5e077d1c5f5d 100644
> > > > > --- a/drivers/iommu/intel/Kconfig
> > > > > +++ b/drivers/iommu/intel/Kconfig
> > > > > @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
> > > > >          to use physical addresses for DMA, at least until this
> > > > >          option is removed in the 2.6.32 kernel.
> > > > > 
> > > > > -config INTEL_IOMMU_FLOPPY_WA
> > > > > -    def_bool y
> > > > > -    depends on X86
> > > > > -    help
> > > > > -      Floppy disk drivers are known to bypass DMA API calls
> > > > > -      thereby failing to work when IOMMU is enabled. This
> > > > > -      workaround will setup a 1:1 mapping for the first
> > > > > -      16MiB to make floppy (an ISA device) work.
> > > > > -
> > > > >    config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> > > > >        bool "Enable Intel IOMMU scalable mode by default"
> > > > >        default y
> > > > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > > > index 48cdcd0a5cf3..22801850f339 100644
> > > > > --- a/drivers/iommu/intel/iommu.c
> > > > > +++ b/drivers/iommu/intel/iommu.c
> > > > > @@ -4567,7 +4567,6 @@ static void
> > > > > intel_iommu_get_resv_regions(struct device *device,
> > > > >        }
> > > > >        rcu_read_unlock();
> > > > > 
> > > > > -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
> > > > >        if (dev_is_pci(device)) {
> > > > >            struct pci_dev *pdev = to_pci_dev(device);
> > > > > 
> > > > > @@ -4579,7 +4578,6 @@ static void
> > > > > intel_iommu_get_resv_regions(struct device *device,
> > > > >                    list_add_tail(&reg->list, head);
> > > > >            }
> > > > >        }
> > > > > -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
> > > > > 
> > > > >        reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
> > > > >                          IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
> > > > > 
> > > > 
> > > > Hi Baolu,
> > > > 
> > > > I have a question:
> > > > Shouldn't we remove the code between ifdef-endif statements?
> > > > 
> > > > I mean something like this:
> > > > 
> > > > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > > > index b7dff5092fd2..5e077d1c5f5d 100644
> > > > --- a/drivers/iommu/intel/Kconfig
> > > > +++ b/drivers/iommu/intel/Kconfig
> > > > @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
> > > >             to use physical addresses for DMA, at least until this
> > > >             option is removed in the 2.6.32 kernel.
> > > > 
> > > > -config INTEL_IOMMU_FLOPPY_WA
> > > > -       def_bool y
> > > > -       depends on X86
> > > > -       help
> > > > -         Floppy disk drivers are known to bypass DMA API calls
> > > > -         thereby failing to work when IOMMU is enabled. This
> > > > -         workaround will setup a 1:1 mapping for the first
> > > > -         16MiB to make floppy (an ISA device) work.
> > > > -
> > > >    config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> > > >           bool "Enable Intel IOMMU scalable mode by default"
> > > >           default y
> > > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > > index 48cdcd0a5cf3..2c416ad3204e 100644
> > > > --- a/drivers/iommu/intel/iommu.c
> > > > +++ b/drivers/iommu/intel/iommu.c
> > > > @@ -4567,20 +4567,6 @@ static void intel_iommu_get_resv_regions(struct
> > > > device *device,
> > > >           }
> > > >           rcu_read_unlock();
> > > > 
> > > > -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
> > > > -       if (dev_is_pci(device)) {
> > > > -               struct pci_dev *pdev = to_pci_dev(device);
> > > > -
> > > > -               if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
> > > > -                       reg = iommu_alloc_resv_region(0, 1UL << 24, prot,
> > > > -                                       IOMMU_RESV_DIRECT_RELAXABLE,
> > > > -                                       GFP_KERNEL);
> > > > -                       if (reg)
> > > > -                               list_add_tail(&reg->list, head);
> > > > -               }
> > > > -       }
> > > > -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
> > > > -
> > > >           reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
> > > >                                         IOAPIC_RANGE_END -
> > > > IOAPIC_RANGE_START + 1,
> > > >                                         0, IOMMU_RESV_MSI, GFP_KERNEL);
> > > > 
> > > > This code is introduced in Commit d850c2ee5fe2 ("iommu/vt-d: Expose ISA
> > > > direct mapping region via iommu_get_resv_regions")
> > > 
> > > As long as floppy driver exists in the tree, we have to include above
> > > code. Otherwise, floppy drivers don't work. At least we can easily find
> > > drivers/block/floppy.c which is still maintained (check MAINTAINERS).:-)
> > 
> > But this requires a machine with Intel IOMMU and ISA:
> > 
> > > > > -      16MiB to make floppy (an ISA device) work.
> > 
> > ISA device? I don't believe there are any Intel machines with an IOMMU
> > and an ISA device?
> 
> This workaround was introduced by commit 49a0429e53f2 ("Intel IOMMU:
> Iommu floppy workaround") in 2007. I can't remember what happened 15
> years ago, but I believe there must have been corresponding hardware
> configurations at that time, and the Linux kernel has been maintained it
> to now.

At what point can this be removed then?
