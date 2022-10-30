Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCA361271B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 04:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ3DZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 23:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3DZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:25:12 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2089.outbound.protection.outlook.com [40.92.99.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5859433852;
        Sat, 29 Oct 2022 20:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZVaP3gBFKV5mZhKv63omSLjZjcRXwOyr82OO5/qsec9l6WTWHIKysNeecqd9i4cYPRnfqmO3UQSk5+3ygjWIQA8hf+e4cDcUoh6OutT+OSu9jno0F7tWqpDOX1OMsft08UwFwgfWyUJDA+YtpUEADN/wdQj4BLStTX5/gO37WSBTZJn22Aqk14MH6HNp/X5Jj8QKn7fTkpVWwFxFVovj92SShgeN7jqjOXWd+6dSdaDdq4j9/9ZTH3v+LZBBphzD2sYpggPa8td6BHyD1aApzgPddWFEFeKbjYDXcggOENgVFGjFhRZqL2aOFcWqplfQXnhAVwFVOeep5bj7QU99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6fSKGp5DKLmfpQ89xtSDQmOMrqAsN5wSzcmI014/pM=;
 b=fMZZjKRpIL2obK8BmuCwHpjfp8EspN4nnhF/bnVCSg67q85M1p2kLjWvqW7uBYzrgQw0HDf1GYRsyWuhbfH1fHU0+MW9EZr/lRC8U0HBglA+V+rBPbUSbd8TkmDsArlImXbZgKZXrXSaik/UqX6zWSLQX5+S+uFfoqNMc4Vfr/Gbkb6u4HO51z9Skviz+pdjijg3tAy7TelLVymeAyNeYKLxnWF4irkA/A9SDShwtd2UKB55awXohPY6Nb63vALJ2pVrMlLZh8Zo/wzSl2SzEzlqlICV6zp6b0bSai+4bGmBe5hflpv7NeKslllxps3Mbqg3B/s4X7Sra7hJLO9VSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6fSKGp5DKLmfpQ89xtSDQmOMrqAsN5wSzcmI014/pM=;
 b=RFuFM5/5kl8g4ogYtr3aDfIP1CSkNDdo8J3EPojpFNv1esbDLRo8TWsPy+/T19r+0G9H9eu7hqATjWW4D/w5nXg62/DmcSOtBLGEZHJIejYUaahElKIsygWtSFEQOYTpHeB5FXZHjwRp74MYtPipXhhdIbWE693I0IAKjNVTkLcMbnceUWNUQGNHWKKwIq4xsYRNPRKC2casvLIJ4o/eahCOOOQWPnQN6diWM44ywJ5KgMcP6lh9Pnv6Tcy90ty9ROopWJh0h7c9RQHtKMruk7sqQcfhX7UN7GaGAtvCqyJqmld6yjNDMARIKUVrCBGKIkf8PUqVn3uT5tc5PSU81g==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Sun, 30 Oct
 2022 03:25:07 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c90e:cbf3:c23d:43a5]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c90e:cbf3:c23d:43a5%7]) with mapi id 15.20.5769.018; Sun, 30 Oct 2022
 03:25:07 +0000
Date:   Sun, 30 Oct 2022 11:25:03 +0800
From:   Dawei Li <set_pte_at@outlook.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: simplify blksize_bits() implementation
Message-ID: <TYCP286MB23234B5C344600A604B17242CA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB232371C798BE0500E979E24CCA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <8ccaabc1-2834-dad6-7d46-19bfc2adcc9a@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ccaabc1-2834-dad6-7d46-19bfc2adcc9a@acm.org>
X-TMN:  [h5pvC4UsdR4vk+d1+7VYNZGB8xqJTI1U]
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221030032503.GA56525@wendao-VirtualBox>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_
X-MS-Office365-Filtering-Correlation-Id: 0816ef14-576b-4c4a-78d3-08daba2657b5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLSDSo0FHzmE5IEvU7FM4izZ8EOF3Zdfsa1LKXsJ4vjG34H4Yru0/AOZG1wYYBYEeacGHxInPZhixDyWzCJfoZudu0Ig7UxOLXm7GyR/gSalWKXKL8PT82BxxlD2kdQmYJJrszcyzfRGmyWh3xGjvrl4t9zk4s9uympX+kVNk+uiq15f2eUdw5MqNJ3OSdBKmz31x1tADYqEEu28d5tcC7kkJ5qyXkcemqJzGGzL4DvnyLYP+CbYNjsOh7d+cnXfR1wh/4Nz7ZDRLCv9iD+sQtWQlXarsuIA6LLj8MFR21EN/6uHMnYmndF67gIReB20gYqUTzZvVAKwml0nz+vH58qDKVVeKrMbq/xSqq6VKR3z0UVWEvvoOW4CwiaC1kRYlhd9Li6VVi4QgiubkTVcwddsfbQIiqwYS+BlNy/wKGmQM/Lqr/4dq43a4iUlQuU6wgbUmAQq4k3TGECx2NFxBd6deIz+mFWNpEmzC1svq+FejKn9Zz6bGu4aAhUZnJP57LyCcjBgqCIMDzwqMdpINKzvI9vR0SBSpZaU4354igIk9lsTqSTPIzeCLW4CPlRIIaP0ryEv8nTZ9nYzdfb7+UKvAFdLr/cuMd24CHBIwtGq2oBjF4rf35k4n5nPwSoFFM+OMCY3iXL3FDGKxCkT+VxSjs4/nGQi52G4xshgjuaICsq41x8PclAbq3CCtVJo
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SwBRsnmtFuzmLbAJvmIcBUUu75rLG0bwqqDBpKySNJcc5g+nTWLBe0spApd3?=
 =?us-ascii?Q?R7nly3Me1Q/HW9UxonMfUPkRM6CL6R/5bpYdYm3KkcAebhTaJ/NU4OvtBSuz?=
 =?us-ascii?Q?y74v74LFK7UXbk3bpzOOkcplbhfjK5FzJujdozSVLWFPWezPCwweJM32ezRD?=
 =?us-ascii?Q?+QLjLPl26rXL6Upk5qHPDEO7Fmcgp/3WQV6fquKSv6wRn1BJn0rR+kovEPYn?=
 =?us-ascii?Q?RdcJQAKiiAG9z3CheZ5qExH1rGQ2VBw+/icFVym84FqC9UZoYt5K0cHHZz5c?=
 =?us-ascii?Q?lA0zda1MPUFAeUkwUHikMcDIwRFhmFbLuFyy2xOqgBnYV4HQYIA9ygQP9BXl?=
 =?us-ascii?Q?YKHE90GCj7ZgMNLHnUrprXz7YPzqvWDnJTPVkTLLxGzQEKyET2Iw+571D2dx?=
 =?us-ascii?Q?4+cz/+YBjW8rJ8qFrUrO/pDfMMR+zg4xtw+KYmNOTHNtEH61//XmGfK9ERYw?=
 =?us-ascii?Q?GiwTur1/H5+pFnUWGcm5PyTGzX21LN2Vp5wtw7eDnoLdvdyMbX5UaLow0EGd?=
 =?us-ascii?Q?OIRoJ94yEtlRa6ZzgZdaTy23x2pmUc8tLc8wvkKPM69Yj3PiMpCLvLhx4+1F?=
 =?us-ascii?Q?9OJn8QqYHF6eXQtBMLXx9rdcUmawAdO162fPOgxYNZZBp2ca9xCUZGcTjqyX?=
 =?us-ascii?Q?LiwYOaoSM/6FExw4S+drqWuq91WIMtfdpBUAM6X237g4u5q1dRI8DDq/IPld?=
 =?us-ascii?Q?zF3lDNmTnF4JpRCvo3qKH5s2qXxPzB9Nzrk/JIDQnR/vVIkHPgsEtA7iLd0u?=
 =?us-ascii?Q?o21Z4cF133QyeiijavBor6JHZNls+m/OWb2bHcI03HRvVE6IjPCVeOiu6Etq?=
 =?us-ascii?Q?Wt+42itCA/nLnnsMTZfKqn0rJYj6Q8ggIbSwroifjDag9Jemy/pI4gHp7Mx5?=
 =?us-ascii?Q?O5jnC6W7fN2Vf90omnb43SZiMbeX24hg2yEOFgTuFNG6L49V3jrVj0K8p2qn?=
 =?us-ascii?Q?/WBeJMopohbo1r364ohbLWTk3A41lsPtqfHdCcxRNM7vCxfLg4mQmNZ9t4Qa?=
 =?us-ascii?Q?Fj1E166n9NWPPFwHGbkUhbMhHblTRlKl+jjiZGq8I/HfPCeqb4l7kVHYToXZ?=
 =?us-ascii?Q?wmc0ee/ZQY91Z0rh8EVfZX/5ERHfB3uCIloiHmXWmB6Y3taDpqw6bpc9BSLn?=
 =?us-ascii?Q?dx87uIMIoOjmCePT9HMuKZJy9W3kIaQN1nMflY7vCPKg1FNeRjkYduU27wVI?=
 =?us-ascii?Q?4/4ZKjeoV79Ayxk11KJ1ayBjpEw8/H3pWtr1PHlJlelMQlap7X/di8eBPzgv?=
 =?us-ascii?Q?dG31zSpsIzFTvgd/U023zPNj4V3rF1WrZleBRJmhyw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0816ef14-576b-4c4a-78d3-08daba2657b5
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2022 03:25:07.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 08:00:58PM -0700, Bart Van Assche wrote:
> On 10/29/22 19:17, Dawei Li wrote:
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 57ed49f20d2e..7b537afe8b38 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1349,12 +1349,7 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
> >   /* assumes size > 256 */
> >   static inline unsigned int blksize_bits(unsigned int size)
> >   {
> > -	unsigned int bits = 8;
> > -	do {
> > -		bits++;
> > -		size >>= 1;
> > -	} while (size > 256);
> > -	return bits;
> > +	return order_base_2((size + SECTOR_SIZE - 1) >> SECTOR_SHIFT) + SECTOR_SHIFT;
> >   }
> 
> Why the rounding ("+ SECTOR_SIZE - 1")? The blksize_bits() argument should
> be an argument of two.

Yeah, that's what's supposed to be.
But I thought maybe a "just in case" is more robust?
Should we consider these corner cases(!is_power_of_2())?

Thanks.

> 
> Thanks,
> 
> Bart.
> 
