Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B2169E294
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjBUOoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjBUOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:44:07 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAF0A5E9;
        Tue, 21 Feb 2023 06:44:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBnvO5S+ItUao5aTrY1+0/decnkmk0DjX8uF+UlA2avQQLGpLDo7Fc+FHcArznnoPTVuul7KXbUOWQpfDYKuYVbP2GbuYVno6A8dsNuOUbBfrjJn3u9dtZ39nrKI8ZcWN6PBLqR+E347fx4ZJxOidAweAYwCvTBLr/SiXHFQC5vNjvCrAvNcXC91Ooum6sRjZucWAXAkEWL72c5NV5ui7d7E/A1n8gIv+Lu/s+M0PYqlo3z+idfGnzLLwgNR8PmMfMOtlDHgp9dpryOl10efixz4xtCVUX1jjNDSWfE32i27NzDH59/RBCdt/eSvED7eQiK0pDuD6Eegleiz8k9nMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WURJ3BBlFum2CvX9EhtyYNtpnHIJwZ3Z4ttrJtOYDbc=;
 b=gxSn3RHwOvU/1oV3cxkm/Cgeq0vxeAjl4AnKxm/IkhI8wMStHuQZIj8fS2RwQQEr4bK0zDsauMqH7wHHsVJzOO09gI+sRQNmv+l0ahgd1/uweIuiN2WzIGHCc/+QqIPHlp+URboGGx2pkBxCvNsm8PVfgS9xglmq+2p7Qt7MmwtKFhpHgHmV8rrRQ43mSx7fn8dC9CPtFh+CySz+bK5lvDFmi8/x3SMmEjXVlIPGw2A/L4UMhTzTPtEGkABEYHm8dlRhcyMgODKFQ/fn+COXbabgMliGabFUVKLm91mEJgaPyYZGuBVprcRUgbO+uEK0izbe0avxt4zbPwEB25Pp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WURJ3BBlFum2CvX9EhtyYNtpnHIJwZ3Z4ttrJtOYDbc=;
 b=DvX5JhKsI0xALYuyKRSmLPHET8X5xZh+j9y4NxPHarfZALce5wHx2F/SYyNJujqqRNegg6flt5oaZ+5InaJi/3J1EeinBwHMx5VMeiSFm5Ryzmahye6ZeLdtsJiFfD9ZfVOTjggbh9lkMv0wbeQF6hz8ro2MT+o0oYAKbFU1m7QImLOeeahrqLpK+FCtMQFF623SyJc6TrgqhRbAG3YA3/ddE5Nd4/s6UdWXLo+gdBaQ/rz5Ywck5CENw9nEuMRbdyc/y0+tXAFisry1JPu+AlzoI6y2MJifG3EMUfFM2fi1amI6JbtwbptTeN0wOBx4REf6uB9B04mqdENEgMZBKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU0PR10MB5432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 14:44:03 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%4]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 14:44:03 +0000
Date:   Tue, 21 Feb 2023 15:43:54 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/3] leds: simatic-ipc-leds-gpio: split up into multiple
 drivers
Message-ID: <20230221154354.290ae938@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y/TMR0GBUr69KiQ5@smile.fi.intel.com>
References: <20230221122414.24874-1-henning.schild@siemens.com>
        <20230221122414.24874-3-henning.schild@siemens.com>
        <Y/TMR0GBUr69KiQ5@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:610:b3::17) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU0PR10MB5432:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7b8d01-4b63-4398-7151-08db141a13a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vX1PTapURbTAE42qY8f+t3m+0bHk6w7hjHXg2ldjMwxZQ+Ta3ndXp7jsn9Yi2ac9XZN4otbwv1iajc3kI0lvmQyxtv4b5BYbCqPuAzik57TP8KNMiwlLW+/UuvFekcQ5PzLYVnbLgioYhNHXE8p4bHUAW8n0XWvVLkI6o7ERLPOQURAEpqFhyo6s/9Te1U79nWbDQ3jcmHt7v7KxHg5I/dg5mCmdp+iH9hh4frEMSD9d9Ba9B0yWfMsEukIqVKJ9Y26V0Hy37x3ZFxff73C7+7EjdZRwTAoWfOX/PDCB/3SmVzAJX5/huVQpm1fLWtp5JxL1zxxX7sRV1MgERx59pKCENZ0Ar+4AwoXALOk6vWxQ4Ys/eooJ7eu8Nm8P6sNzJRlgv/lXSo7jIzuSED5px8/5eHcbs7TvC1BsauK3HdRR/z50bFJxhItW3nOQaog7znNriqju82Y+Z0Vg9XIzTeCqkgKuDJPVL+y0lFFJBj04zbYFFwp42Og+Cs14bHE25nBE6utSfNaOundtkkEDFTOeCoKtf1P8rfAehcAftfbKnDmykHKMa7pF9gDA+RBhbFRDpn4MeyQVXwUCbJO+5STw+C+LkrwxzkW/ymv2YFJLObLaIJykYls3M7cpX3KnXZpMCQw/j96wmU0kC/siA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199018)(8936002)(5660300002)(2906002)(41300700001)(44832011)(6916009)(66556008)(66946007)(8676002)(66476007)(4326008)(54906003)(316002)(6506007)(478600001)(1076003)(6486002)(6512007)(186003)(6666004)(9686003)(82960400001)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LmGVb1s6Jy2GTyb5D/5AK/6dEEdXZp/HLEsHzp8YUFdJYko1jnwmmXsbYUha?=
 =?us-ascii?Q?s9uPlnYWeG2xw8Xey2BRZNGev1ze9dxufLVxQZGp9v4Km0t3UzVT+5KB/JHg?=
 =?us-ascii?Q?4pYG9CDJKDQgkAblqHrb2YF4lDlT+bKi4LD8GjCS8im9CzWcKg9aRhfG95xJ?=
 =?us-ascii?Q?Nadb/y7kXzUpsEspKBhVGT2FvYIlZBUNxjuS+Elbltb791GfIkp6P7uEueKY?=
 =?us-ascii?Q?dCNxrR8FS6Ij3E2gXxOk9aNLg7Tu4WFhh5oVECTMXaq83AUivyLqmhk/i0gV?=
 =?us-ascii?Q?90C5Y2+/Wbjtlmhgmfyp10DIIBC9LL+SRhCh6yb0Fd/96ICEzNnJbPHgzmAe?=
 =?us-ascii?Q?OAOoXXzdnOLFhuOxRPxaGMdqCEn/mgrJDHlKvmgjd5NH68ytHdFireHsBWde?=
 =?us-ascii?Q?ibnaDwC7OaDdb6P/paZRZj81JiiZgCLPOVYZfuPXCK7l9baf3EzuF/aXC9CM?=
 =?us-ascii?Q?U1F3hTKIZaFT8M/OOE32pLvcTRrxIuCj3wuGOmnzbK6EGNsBjNm+TQx6c/tT?=
 =?us-ascii?Q?omUoT1Y9aSDthQxbWJQrDGwEsuJ/rNV8WjLhg7AKrk/8tCjik16ZuL/rIm0V?=
 =?us-ascii?Q?+cyS0lrqdO0V2EW0adKBbQIKFawyIVLluZl7NsUntNCBNbsfUaAelMp3QG2I?=
 =?us-ascii?Q?vfaDiFoZX8aKCFk8o1IaX6gW85s5MwTJzcZJS6yVh6jx1UTxpmS5Njm2p8hj?=
 =?us-ascii?Q?0wDcxLYELedW9Tr22tYi0SKS/Z12oibVXqY0nOU54z/NaUt0w3afclyy1Lnr?=
 =?us-ascii?Q?q2/zMwTPjzcgBufBu21mLVodABevqfyx51h/0tOs/sNfzBpjs72oqyj4kDmx?=
 =?us-ascii?Q?7t9JjL/TuHKWrBEea1VwAtWcZ/cpxMTjgdvyPUf+mPFT2K+eBxIvoJZb58dj?=
 =?us-ascii?Q?hHHiXsA7ENe3nafkq+eSyjXWLfe5d68fG5nnSEnVSnv8wzIXVec9tdic+C/4?=
 =?us-ascii?Q?dU2S/HbX1Evk+AZ6MYMW41vj8mkfTm5vTigusA4yGNt/hjG9vRzAzlcUJpIh?=
 =?us-ascii?Q?QkQWDk5wnRbtTddwXwbl/ATLn38DSkJz+m1AOG24BnJe6Taxvlzz6pk05C3h?=
 =?us-ascii?Q?owvZWNEDa9YSK1LFgG25wCbqmJkVBkvRAFW8U3ZS0XzKhlOxI1FM7E4vFV+S?=
 =?us-ascii?Q?3kcGQ8cHz/BzwTGSlYgXwyMlpbOy53TJZ70bOVDdI0kj1A9uuRztV226J3Jh?=
 =?us-ascii?Q?QDvJgdEfvo0xwsbN6y0FHcJndkvD5pPhWl2UayHSXfTpB6U2v5+aep4YNDdt?=
 =?us-ascii?Q?kZjAClk7e5zdtkX/SHS6jchVwqzfRsGwEF5Of+aTxQ4csoUJyHjetV/5PVMm?=
 =?us-ascii?Q?wgn0H085jHELLPUhXqseu9XCOgn8HMq2vgmzz/5E2bO0dbreF8U0KUq4G+yz?=
 =?us-ascii?Q?Bvhej/zSvwqrws0kwXuLzEOr8+2nN/UDmcRgTMolViw1xDzo9MHN9u52jCeE?=
 =?us-ascii?Q?FQ0lIUVDPWYAZ/mYr+8dEzbkxCxq3G+nkGZrO4w9zK/hO4fkZc7I85XPmPhN?=
 =?us-ascii?Q?xE0UZBjMhoRbINnYufg/hiJmLX6UkRf8uMsEvlIkJV2FD1Cz0yiwR9bPpoM6?=
 =?us-ascii?Q?sLSf52nM8sTDTjxG0dlCyMtge5z4KeAJZ111IBPPRBt+Ku0Qgv4BiOzoat79?=
 =?us-ascii?Q?n5jEB5jOde9RisQWS8XMMvmhzC2GGRHXwPKvBR5Dvzuez6TLSY75gFh4xwUp?=
 =?us-ascii?Q?ChO24g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7b8d01-4b63-4398-7151-08db141a13a1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 14:44:03.7234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 227m+Ag9cMJ5riyJYfwDQOrOBobu9bkwKC65Vxjs1U1bMUyE87JrAvGiDmyjxzK7xSyPlGwO6pHD7cXh5xvtnjiqgWtKOFDox5twsGk1F3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5432
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 21 Feb 2023 15:51:03 +0200
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Tue, Feb 21, 2023 at 01:24:13PM +0100, Henning Schild wrote:
> > In order to clearly describe the dependencies between the gpio  
> 
> GPIO
> 
> > controller drivers and the users the driver is split up into two
> > and one  
> 
> one --> a
> 
> > common header.  
> 
> ...
> 
> > + * Authors:  
> 
> (everywhere where it is a single author, 's' is redundant)
> 
> ...
> 
> > +#ifndef __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO
> > +#define __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO  
> 
> > +#endif /* __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO */  
> 
> This header doesn't look right.
> 
> Have you run `make W=1 ...` against your patches?

No reports.

> Even if it doesn't show defined but unused errors
> the idea is that this should be a C-file, called,
> let's say, ...-core.c.

When i started i kind of had a -common.c in mind as well. But then the
header idea came and i gave it a try, expecting questions in the review.

It might be a bit unconventional but it seems to do the trick pretty
well. Do you see a concrete problem or a violation of a rule?

Henning

