Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF861273D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 04:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJ3Dwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 23:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ3Dwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:52:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2041.outbound.protection.outlook.com [40.92.99.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789092AE24;
        Sat, 29 Oct 2022 20:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9iynGuoTq9meHC3bzKkbZwhkjni1Wx8GZtYVos+MKxIz3a8GzeLBpzv2VUpqpd5IlG+VvjibfoR0JcYqCn+7K4afO0DCEOFnIl+iEB/JSpl7frD2SrZ/tkvhy99TWCaJa82hBua4QIOiUTnsxR6iQsK5MZQW1AKiuV7rSJ3kXst6P8MdvE9wzhiYwf0LVvdsQUeGeZhNcUUq2qKAmcZ3TgSvkphGsql2/7qGu+l2hJr0+7k0FD9pVXoicBq6gBfQ4eiqiRyiVw82cqTxqUYVRBqOxjhDNDsbROh8u2mBkBjqMNtuNMn9BN8icMrhcYk4xqc65O+GqgqD/ZSB6oqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0OvndSt7oFEO4vMjd8BZ7d8V1L9kaexl39BSuRCmHo=;
 b=it4OkzH1ksR0sLbEV/d+4RzjLfP5f2L/3EAXQ01K+iUyZaY6uuTK9YaW8hhqi9CyoMK3HKpgYfNt7UaOJ8H9QDvK73pT9GmNXuZLRf/hT5Y9rc1eK5D0hsmg4OydhfYtNmoA9fy2fFDzt6Z1DXrKPKFjrRvvbqGb4oXJ0oySPo0KDGPYal7X7eZmWPAuUTKsOpRNaoE/jjbgEFUxP3a7wDyKG9OQ+Dvp/YNBW7hZkmynoV2abyczOXnsFa8Ac33UMdgQNb8vSWKzmVzMWPJnVuZ1xglAD16xL14VjZxztS37JH3hgWynyAMFcHJ8i7HgbR8Jxk3IFp60mydBzh1J3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0OvndSt7oFEO4vMjd8BZ7d8V1L9kaexl39BSuRCmHo=;
 b=bHilFWby7QqCFqW/hOx8zivdbuENAv8uQr3fTzuWdCpK7EWhFknnFXGDswyHZz2pMDfWXBGAmHwg/ZWEOCw2xaVhk3e/zIPolxSAlcFAKcxGA/UlWl8Kx0IFC2XUQRSoZhk8r42xm7jR8Uhs2C4uy6YODXAqwcBj82grN/fyTpJ4Yra2wP2qAibCJLtCHaF7QG/vnYxLMvmVCyZ1lbt0tmNgZEojYQDATzWCohDvOARxphJYLQ0xYgfFJ49v1ymVbzcGJeIrwDbKnthAgKxliZlxdBvnQ/LSCJd3Q12D11JDyv0d9EHj3VowIFb22ktY7hybEiOX4LkeNLJzS2ZWkw==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYCP286MB2606.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Sun, 30 Oct
 2022 03:52:43 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c90e:cbf3:c23d:43a5]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c90e:cbf3:c23d:43a5%7]) with mapi id 15.20.5769.018; Sun, 30 Oct 2022
 03:52:43 +0000
Date:   Sun, 30 Oct 2022 11:52:39 +0800
From:   Dawei Li <set_pte_at@outlook.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: simplify blksize_bits() implementation
Message-ID: <TYCP286MB23234DEAEAE3D26768BEC381CA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB232371C798BE0500E979E24CCA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <8ccaabc1-2834-dad6-7d46-19bfc2adcc9a@acm.org>
 <TYCP286MB23234B5C344600A604B17242CA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <bc8cf710-c0ad-24e8-7849-6282c8e3bcff@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8cf710-c0ad-24e8-7849-6282c8e3bcff@acm.org>
X-TMN:  [3r7OqP0nHvZAiAS/MRZkCIRS+WikZQma]
X-ClientProxiedBy: SG2PR01CA0173.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::29) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221030035239.GA56795@wendao-VirtualBox>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYCP286MB2606:EE_
X-MS-Office365-Filtering-Correlation-Id: a20598ed-537e-435f-e1d3-08daba2a32b7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFUBlpfthgLYR/drq53DF1p6M7SLYIkwGqzxsnbWnfZ+OH+IQbUnXpY1tisxuiSiw6GztoY6Vmg6SpIQwWsBT8KfyntyIp8M/v96KtfmJb+6ZH5fhPL2fjZ7bXBoXbhuOx/3xcUNAJgjLEuv1jc3AAgmPjdT29EK3RcXP1pP+hcHBj9UBkhjmamv2f3HGWF9c2EW7KM9AYp0yLCsL+VqnWzMF5mReyCXNL16sBWXbTCxCTZ3+9yEhMhFs3YwsPEIKm2a9EzMohqUJMp/4C796h04Ka8Qs7ViCH3ZwbzkbTBA4JdudLcmo4ljbiNuxXTR2UGOoxrbFpBhwpFt1P+FC3ftxha/wozYEXZPSyTQ3MdLxv7qbwviPgdC09iZyX8RjEdTtEnUCH8t+qEKqramX+lr9Uw/s8i6y+fUCU8idJ7kbJfGEZ1qvBx0ERIavmgJu7oP4FNDakl2UaxfFfMpyZwuDPf2hik3MHQ/+EhpR+53t8fCtSXzfIQpNsQc2Hdf+HSdHzkckgXTaIk8ibvKSpbTmHI2HOrqhUsyGHQQEFinvlXAGFhnDAECmXF/xeX5wSOq43enL01byUIVyP+r/IHT0s99D37DJSvrNZFTOpnCotiL6ce8Yl2Ntorv9mmSor4vP1y0ujWJ4hPwscZlOuNDDu7TzLmsUGR0IksgXaRRDq7A8LTr/+yit5ZId14z
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DSS02skHGsyORPxxkDvizxILmZhH0ERMTkTASoQwv5R4weFLmnjatjs/6P6M?=
 =?us-ascii?Q?+nU5XkW+rBvn0CiylnsyzWoO1Ou9lNzizYvTG4nVM8OGGtNQwqb8OE31fZQ8?=
 =?us-ascii?Q?ItmKSpCsqJBPzxA8ZAY0SDqb7v14IkWN0QZA9TxGGFKnUGkki8KEp2ceSBla?=
 =?us-ascii?Q?l/3YdhvbLv/rtwjSA9AZKTaW26Sr2DJrS2fdwYbC1YmNqRGJaCC+xt0Yr3oR?=
 =?us-ascii?Q?akbeH3icqiXUrN48mhDHUv0jwSYTzn3BYMppHqiklswveuGqEyiYrq4lm/tw?=
 =?us-ascii?Q?RxYeSRCJqgeg+vJ+6jv8KVsN4P+3hjuMHaQmyCsVBKK5v3pivr/k2ACicE2x?=
 =?us-ascii?Q?lIhTgCjxa6B4gT/bXtx7SH6lV7CeZViCwOe3m9e7xS0Wq45RgF4arhR9fFps?=
 =?us-ascii?Q?T0zIXMe4yrL/DxHvPht3xk/Hp+l4yHHP6gHbjj01XUCg3p1Bm2eVISoMlRHS?=
 =?us-ascii?Q?ioVxReBmsVAEUDG8NqmWgFzxMlr/SA94DiW6+5cYWHneo8K8cf6g3DZmACYU?=
 =?us-ascii?Q?uZh5D+Gjw6e+5NmQHPV/eOpUvfb6+s3dKDQ8ZfS9MiVRtUU+VrVNHHMQ8cxW?=
 =?us-ascii?Q?4zy7yX3MHxh0L01S2P8FQRnyjH13XtkElGQQAqLV2Xgq9ehzKMLAMRnaCLMU?=
 =?us-ascii?Q?FderholSW95BZLDJJmQxziOX7rkUe4jjAf5a7vW9//dxvuIiyK5XaHa/ot9l?=
 =?us-ascii?Q?AHO3a57qu20pfj5QBqKxmYNpQl0nb7wgVd44UlFoj8kPF/tLjVVjtd+PI3xb?=
 =?us-ascii?Q?LrPs4hHwPaXYJpm9xvMXvTYkOAblaCSswXrDubE+dxZJyQoS+nLNhq2bBbtv?=
 =?us-ascii?Q?ufM21UEqnQKiARerT7pK1ETHCQR3/Ub6UUEOcxY7Cu3yu9PuJopDgoHeNpzX?=
 =?us-ascii?Q?8zFvkWu82EsqogDdK+Pb4++zk60vcpaX1Jb+6Fz5E5xLrwr247Y65/ioyz3B?=
 =?us-ascii?Q?r/9RvJPWuMK8na6tl1eyj+D1INOhZjBkixMOzl2Y1gjiDw8IR+1o92DnIWY9?=
 =?us-ascii?Q?7ssaRaFW/jnoGo9j9afKoNayoaOXNCX1X1U/8OZnLukutCaf7MqQgjYf6DmZ?=
 =?us-ascii?Q?NaOuIS0jkJERQHkaUTcmkIPcnGGdArGJq8YG/XAOF9iwlrAYVhZcydpE3ax4?=
 =?us-ascii?Q?ibN2ZFSGnRGdfX522VROaCEzF84k/FRBDB9baRArQM+CG5elSXEChRSPl5Y5?=
 =?us-ascii?Q?Uvu62pVGj0F/JWDnfjJjZG7E65sNsM/WQwL7CjPsQVc/njQN6P1TSSQo9ai4?=
 =?us-ascii?Q?CGVVSFsEnuVFgj4iv1F/cpO0FkWCsmzegTBrFgY+gQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20598ed-537e-435f-e1d3-08daba2a32b7
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2022 03:52:43.1451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2606
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 08:33:22PM -0700, Bart Van Assche wrote:
> On 10/29/22 20:25, Dawei Li wrote:
> > On Sat, Oct 29, 2022 at 08:00:58PM -0700, Bart Van Assche wrote:
> > > On 10/29/22 19:17, Dawei Li wrote:
> > > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > > index 57ed49f20d2e..7b537afe8b38 100644
> > > > --- a/include/linux/blkdev.h
> > > > +++ b/include/linux/blkdev.h
> > > > @@ -1349,12 +1349,7 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
> > > >    /* assumes size > 256 */
> > > >    static inline unsigned int blksize_bits(unsigned int size)
> > > >    {
> > > > -	unsigned int bits = 8;
> > > > -	do {
> > > > -		bits++;
> > > > -		size >>= 1;
> > > > -	} while (size > 256);
> > > > -	return bits;
> > > > +	return order_base_2((size + SECTOR_SIZE - 1) >> SECTOR_SHIFT) + SECTOR_SHIFT;
> > > >    }
> > > 
> > > Why the rounding ("+ SECTOR_SIZE - 1")? The blksize_bits() argument should
> > > be an argument of two.
> > 
> > Yeah, that's what's supposed to be.
> > But I thought maybe a "just in case" is more robust?
> > Should we consider these corner cases(!is_power_of_2())?
> 
> I don't think that the Linux kernel supports block sizes that are not a
> power of two. Hence my request to leave out the rounding code. Keeping that
> code would be misleading because it would suggest that the blksize_bits()
> argument can be something else than a power of two.

Thanks for the review, bart.
Will resend the updated patch.
> 
> Thanks,
> 
> Bart.
> 
