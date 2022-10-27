Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA360F1A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiJ0H4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiJ0H4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:56:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19A6D38C9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:56:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R4DDsb022179;
        Thu, 27 Oct 2022 07:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=907s8o88iJc+of+k2bj26zqn5aVM9rysNI+6tl+FlzQ=;
 b=LMC23ToREcspkp67qD6Pnzo0jCF7EsfadaHyt/y9f6RfexNXDEtg0KolGmDWCNdxSR0G
 BGUV/l7O3a2Q9WzypmNAi5HIDsHvSLdGV7a4PLl3j8yjtq9oNuId4UREaI9lMfnE8e1g
 /Hmy6Ct4+62gr4TkTxpZakYE1QdOQptYRVlY5vNuBmrDK/Jv7n1kYeZe4cWrR2ay2G1E
 kFlSOe7SkzK9XWE/N5dd2riEkwKx37HzJPCCyERUm2G1lE7r3DeyBl5B7gr1nG8iM4WH
 OxgFG25Q7Nruti4AlZG8OyzaCIV+HH/ZUZcDAlogqikRd3uFWIjuN+IuuJMsHCgzHG8R JA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfahe9byh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 07:56:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29R7PV95017521;
        Thu, 27 Oct 2022 07:56:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagg76un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 07:56:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1opdI+M/XeJ4XD5ZjLNm6keJSjwoOLyz4WFQtuFDIm3omfNd1zjhpYdnN65jSs0K9+DFr1X21J4GDrcEaAdod5dWDbtGbjoOtneQhaQuGwKVpPF1e0knAVkmObNwnjqeZgEcL3OTDukTnQ0uzAI2hkwEhKJvQO8sFql/kS3tBsZTicc7xN1FY4kruY8OUehbaqknJVb5Fvu+HCuvCg/rhHnkqP3sQxw2kKF3ucoz6r3+RV0DI4nEidENZE+0olqAZrayL+soMSvHwM3EFe93PPU/olr1Fy8a32OC6S4CTSpxv+mRyW7lD9v6NychAbdtHFij7jvwDtPvmVzA+/2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=907s8o88iJc+of+k2bj26zqn5aVM9rysNI+6tl+FlzQ=;
 b=ZGyxiLEbgIUwwZ6/zWRFJDTX81jVTff5QV2qSl55/VKW1xIo9EkgL3ru/hIiT/k6Yz/b1SbwuojZIKd9DUwiBv4zESlTmOS8+XdNpsoqTFZLnt1fvHWYeaTqHLVOcMVE1T1mLKE4rxHPYr3foWq/MHxqX6JK2ykekMvgeM+8hdQoKdvGubjFYEbQz7q6S8s/WiLCbwiG2Es22JzxQBwDrhnxuD6V5zaVOTSi/W7bNSZoY6wxfaF7whkzbG/Cwr+HyMXunUHZwMjcgZpVcMTFqEZr0oREPcbYOKQ//uDu9+UxZeOxhAUdNZ1FycmQCs7Kc0w2KwP6b/9qP4prxifCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=907s8o88iJc+of+k2bj26zqn5aVM9rysNI+6tl+FlzQ=;
 b=WlqMUarERWox+QNrjM8FJwkm17lBugi/dm4leZ2DvLeSZmrnZYjr+pto4WoFwR/+n6ZDUjH4gWjJPeAiD13+nAZTSdFDxFKzMl2MuvZpiVJ1KR9hLR218nPLlVx1iKO91XuLAq3NN1dl05a6zXUiJtPYwWe7EwtxP8QNNo58oSM=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CO1PR10MB4564.namprd10.prod.outlook.com
 (2603:10b6:303:6f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 07:56:26 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::7dee:dce8:921f:d623]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::7dee:dce8:921f:d623%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 07:56:26 +0000
Date:   Thu, 27 Oct 2022 10:56:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     UMWARI JOVIAL <umwarijovial@gmail.com>, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] Fixed[ERROR:trailing whitespace and braces around scalar
 initializer]
Message-ID: <Y1o5mktrnE5rbtCO@kadam>
References: <20221026132838.GA44037@rdm>
 <20221026171430.GA5592@nam-dell>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026171430.GA5592@nam-dell>
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2358:EE_|CO1PR10MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a409e01-4c9e-4928-077c-08dab7f0bfcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fH/BxbQI0nNdwhf9MD/XPMSVPGnVZF63BDXLJa7PTXPndfeF/HMwJ2GL7wM11VKTYgaqxOKKzssKhqUIR8r0U4TbW+TU4NJHWucqDBnimU0dG1eh3uvxbf2aM6NhjOb0pR3OJjDtnbhz8Ap8kziDlBPaGpu3PF//IOFG6iwxe3TAZFuvm+C9AhjkH/up+quDTykC7npjXdvjtnCK/AjIKBz1/Ap5s3+YgvqEPmV9w04X1h1yvokUTTHpGiatMp+X1+cEGRZpU/bfKtUNNIdv3fOiWqxsLHXaSdTZshDsyXxUKpHUtvciBPOl7Y7ExsyEwtM/y6WJI/8ja5nvseFJ6tv30/lGX4c6HDzaIDp/UYJ7V4t3eJTHrrFpAx9InqzTFe+4WB2qSh0pOSM8PR7WE7kxLr765STZYKkeBUMUHey0OLrzKPinuxP3y/SEqRmUewd5XATHKqITZQilXoN5l9VVAeZ1KNdXqehlEbcltY4ai5it7UoRjKeNVL+6R/8d0UJdvdMt2KMv8ME/3yAJzloJgEccV54waQu2GP1Tx4Ge1apQ+fh2VjGXyTWkLNTirqCChcSDz//sMW+IEFgctA+OWCHSlvPq5QcPTxWQucBNE50vJg2kyeu1uhv7SZtmdJ+081uaXejqK87TTkeMN4kIovY9ZSA6q4S8aLgriJMTuwXlFvsnQeqn2SxjpfuY0HVHgjIgMX+GMZPzrWGdKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199015)(86362001)(8936002)(44832011)(5660300002)(41300700001)(38100700002)(9686003)(6512007)(26005)(33716001)(186003)(2906002)(83380400001)(6486002)(66476007)(478600001)(6916009)(66556008)(8676002)(4326008)(66946007)(6666004)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DQ3D2vyfssrUrU2rS7ke6Ihvc8mOVnMkJNmV0MxcjLB7LPDPaMAZBrT8r2v?=
 =?us-ascii?Q?UqtgUegLO9k7Gze6ZRmGa6+QXjcXQ7JFjATsi2TT4jN+pIJu1QLAa9W/x+na?=
 =?us-ascii?Q?p9mW+65aLlh0Q5r+LgdotExS++7AX7iYK5xjqQzCzHeVZ6WezvqlsNbACAXW?=
 =?us-ascii?Q?aWLBnkTAHWa5W4yO50HcxoDrEyVTFBFR7hCS6PkPKeb83hFl8F3FnAi92id9?=
 =?us-ascii?Q?D7pImT8RLjOlEX/SHEqAw1iuLrRZudO24OKnybOSn0HOT5qkXCdtWsHwx8Cf?=
 =?us-ascii?Q?Ze74xdT+S4Z1EfPCH40S2xiQi3HAQQdzbp9Po83szoOfhsrRavEY8JBJ1/2Q?=
 =?us-ascii?Q?sSGGjdssBC9vM15dyiOh3tV2kcQSidODTFDy60yxI5JnR2Iiul+ruvEo4iQl?=
 =?us-ascii?Q?jdDMG82tsF4i07CApGSUb2jAuUDhcSrnFZXrUfmzHtRCf8o+kI7yBqR0Pb4o?=
 =?us-ascii?Q?6eR4g1rNWajCJ9uhJ+8Ur/yJEy30QBu3niOg3TVRp99RF57QSHgENOuR9fFE?=
 =?us-ascii?Q?JqHlEyrNMFQI0RAhwe0abecriaqp7oQKD+Q/We62apZyk031Q5AkNjLdkDNO?=
 =?us-ascii?Q?JmSZs9ZbCueZfvhDzkxRAfuc51bwWfXizWyhOeA0in3vHDw20MbaNrxrbd/6?=
 =?us-ascii?Q?VaC5vko7wNhQq+M4MYjy7JFG3skRjC73v28Nx+jxqvUDpbNsAoOuY8PfcfJe?=
 =?us-ascii?Q?fkw6tXu0YSnJpLzpvR/X3qpvvkRBdjsOHhGZVvZLrF0p/eWSCxENCai4DAgw?=
 =?us-ascii?Q?aVMWzIMp6TQmH4n34bsyQ8Je+cIMNgb5LF9FWKmJQslEINXoVzVtvzQXX0os?=
 =?us-ascii?Q?1kYMesgB3yGCqUioY+u7rpSfr4nHvvdH1eNagQAOEelIYSBRIM5HWvevoOdS?=
 =?us-ascii?Q?Wu5cFIqgltDXc7IvORgkIXpPAmjjo4868jXixfzPtard1GVZSpkBmSjny5Q3?=
 =?us-ascii?Q?hmJdWkU1oalofh/A0hQlEKvMXxfTCzkvo+kbOt5lgHmV63bQhTQfnOJbgRxW?=
 =?us-ascii?Q?omerGBVZW2z30TB+nukOFahKa6BnMnhPBfYkIqgj1vjrJvkyX6/hjglv8vTy?=
 =?us-ascii?Q?nSEW7JwQ0/8JZiRhvbTw3X87BCfbHuJ/NPL9SRm6whySypwxW1pJx7AQDw47?=
 =?us-ascii?Q?1d2d/bQnZJL52QkiswUa7YWcskW5iUjsr5kWFrL3H8qJ+rym7yOaRzo3Ck5c?=
 =?us-ascii?Q?LlX0bWrdNCUggJ4uJIzEIvmwXbz1cgbxDTv9wrzK89RQUM27bJ/GNckYzJD+?=
 =?us-ascii?Q?yvxldYpva5cUbbAf0px16Sg1spzzqNDWrQ/VqlANtVCymabi5koworI07Bua?=
 =?us-ascii?Q?1a2QocvZ2cpaO/rXsuNgV40/1ze5qu3nETcAH/FgPVT0pF7Iod7iE3kVHJcN?=
 =?us-ascii?Q?QX0Hj4niZ0SdV6Tc3W6RcnRYFQ6XbqCg+R5gSIen8RrcrwYvRcPD+Zu9ftyV?=
 =?us-ascii?Q?ncbzCkjt61rrmHDK+vBVmIvlbUiXuQl1oVMWd/zsBF8rXBBAOK/Lkdl3f01X?=
 =?us-ascii?Q?BuF+xFb22UA3wN0nd9LdrD1e4ySugQgs/QSyQ5NDCi1GGTTKApiB73ad8Y0N?=
 =?us-ascii?Q?x9RphD5vuj5N83oDIwcRjrUpBsll3W04K1+spD1M37xqnQWV40Jmh63YGxge?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a409e01-4c9e-4928-077c-08dab7f0bfcd
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 07:56:26.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9GADk89mT1so5/gE+rNWQprZ1RgsL/9gXImqRwyulEM1M0LjS5FftHA5d0mMcvRCYbGUEL4e6KJLvWwUUxy9bGcodAopoeKizCPsLFKwZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_03,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270044
X-Proofpoint-GUID: JzvFobdXena6jzMAC9GHPmLfiaoF_zPP
X-Proofpoint-ORIG-GUID: JzvFobdXena6jzMAC9GHPmLfiaoF_zPP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 07:14:34PM +0200, Nam Cao wrote:
> On Wed, Oct 26, 2022 at 04:28:38PM +0300, UMWARI JOVIAL wrote:
> > Using the checkpatch.pl script, found the below errors and  fixed
> > ERROR: trailing whitespace
> > CHECK: Please don't use multiple blank lines
> > warning: braces around scalar initializer
> > 
> > Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
> > ---
> >  drivers/staging/most/dim2/dim2.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
> > index 7a5f80e637a0..28259ce05024 100644
> > --- a/drivers/staging/most/dim2/dim2.c
> > +++ b/drivers/staging/most/dim2/dim2.c
> > @@ -987,7 +987,6 @@ static int rcar_gen2_enable(struct platform_device *pdev)
> >  		writel(0x04, dev->io_base + 0x600);
> >  	}
> >  
> > -
> >  	/* BBCR = 0b11 */
> >  	writel(0x03, dev->io_base + 0x500);
> >  	writel(0x0002FF02, dev->io_base + 0x508);
> > @@ -1084,7 +1083,6 @@ static const struct of_device_id dim2_of_match[] = {
> >  	{
> >  		.compatible = "xlnx,axi4-os62420_6pin-1.00.a",
> >  	},
> > -	{},
> 
> I'm no expert, but this looks like a null terminator and probably
> should not be removed.

You're absolutely correct.  Also I tried to see why checkpatch.pl was
printing an error for this but it doesn't print an error for me.

regards,
dan carpenter

