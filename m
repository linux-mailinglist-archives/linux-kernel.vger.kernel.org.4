Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7B8654250
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiLVOE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiLVOEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:04:53 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A148E6466;
        Thu, 22 Dec 2022 06:04:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuJdUtNQylzSGGaTyB7zPP6zNm4TH33nu0AMSvA+LRYgZPnflecT6/NJTPDiNfrYWDnUjCXbVRWtou30AXWnknVpVEuiV9BJyao2P5c96UHiKxBhKHDSh5h45YzwJN2mwWdftA+qvPG5bfOJSTruG/LwRMuhzkHQaE1d47393zCe+KN/TgI9EVG+wjzCM8QvaSh7PXDfW/1SI6SUvYt9HFY1wSsA/jOQqzNpxMloK3yLgN69+WOt1HhoaYxN6ziQDAK51BWj86ISf9gOgz1bwlsE+8otgu3Wd7He7novic3YMy7n3WlaYBz4BE5Cu+tNX2DnC4IbiUfUdr2wfJK77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ7fRqKtKd4S+J4ICeVGsUyN3FLjIfaicpXb9z7HxTs=;
 b=gujBOG6nMUz1/lKDVgE2Y9xdr1L5sR7xPAtxvcVPyLI5h0Q4pwsMgNB7ETDQ9X4cmrsaOOIzvqVF+1YSKTku2MAY9958L10uIz0G/IbTyvihgOAWvRH1zNyWjOqvQPJ6Jif1bTWcl2iFhlpYjSS+MGnOC9wmOqBXz9CQ8qvgrAlJbOOy3444EtXvTCzNIhCwpzHX7ZDK2OAeV2YxQADF54yWEdfP5wy90eX2JJs+A0hidYnLe7Mr8Y2fv2B55YTjcSPeXDxOROS3qflDjqwWHvymeg1UTKO9ePTStcb/OXk4b1Q9UXL5GRsg82hKC7TJYx1VGBFFoLMNA0csXc3WHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ7fRqKtKd4S+J4ICeVGsUyN3FLjIfaicpXb9z7HxTs=;
 b=ovfcmjHgZncip1Rnlf0msfl6z1VyfYjAbFjU2/0iuTgUYqb8UzVIOM7jUO4Px9QRzNvWxIjeAH56vYvy06/DMZJRMYRyMWtPRz/M4TYhzk8BtpD5lpibNpLcDBcq/O3F2Bb83KkUFh+B1gru7LiSx2i+v0PHKUlHCLc+GQo4QS2WxnLzM0ngYYENA4mcVtTTfQv32M9ycdIvQtWovJs6erZoeW+v3QATqXD45gWI7HMSuWZeaOLzgst01rflJJQ1QvMbtu9j7dbXuefPuU27z9qaElr/o0YkEg/2TTMKuB3isrs3F/yXPcMP7hOS9TLrh7OEO3SsQkqww5dfDfu8AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB8PR10MB3750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 14:04:50 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 14:04:50 +0000
Date:   Thu, 22 Dec 2022 15:04:43 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/x86: simatic-ipc: correct name of a model
Message-ID: <20221222150443.722e5bf8@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y6RRInVaXtOGr8hA@smile.fi.intel.com>
References: <20221222103720.8546-1-henning.schild@siemens.com>
        <20221222103720.8546-2-henning.schild@siemens.com>
        <Y6RRInVaXtOGr8hA@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:610:50::33) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DB8PR10MB3750:EE_
X-MS-Office365-Filtering-Correlation-Id: f2adb2a9-2f1e-45ad-e4b7-08dae4257d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CQJuwvhckmdkZdTv+2+aC13ePXE1fkSB6ifZdOxIxC2uWRckvC5dORF1hxf086bbBNkqJNbM+4PX/6t47qHFNzISoA/MASzDM7TgtuKeY7b8uhKV80kkThiHIJvILukkn/TjOxMjihroCOBI+zMA0tofk1dGff850kT/L29pRbCc+0xpSFTId+xsSneQJZLgZHcFt6F0yObH9B+EMDsebXKJ2M6mCH6me2ZHmnWiMH9uvSQoZGRfzDu6yIPhs5AEBveGi7ooVCXm/4j2zmZ/UueI83LOxpOJlvXbdVKMAuLaK7Cw+rccAjS68IqAQ+hjkjXM+6JNeAyEXy6KtuV/Lt/aGMOWi1wrjL87gwoi+++gHBCYFNbHT4ZSewut7IeJ33L/oUxg+44TMdVFbClRh698EyYQ0tslSoBeXl7Rvv+R07Xvx97cOuWqmtzuOFCtGuRunDNv615ugWU1b++aHyhaOqqACbHAShfUdKfuls7g7Qm7B00rQGYU61niD/YKwkMzQvqL7+FUjsSfeqsueonLrE4ZQdv/R7H5BolQeKgCWAnjO+7N69B+1ouwJqEXwuKWoZf5HkgliNrofhTSH1pq31or68AXxmBPJc3C2ALYud3VVrIJEZDV3NO+om6/GkRQvnBkQz8LtXuXQ3AYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(83380400001)(2906002)(86362001)(4326008)(44832011)(82960400001)(5660300002)(66946007)(66556008)(66476007)(8676002)(54906003)(1076003)(9686003)(26005)(41300700001)(8936002)(186003)(6666004)(6512007)(6506007)(316002)(6916009)(38100700002)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?anUVV6oODDO6ck83MDJAkYp30b56gtJNIMVIPfcX8OuDWtr4MvB0hPTSXVZ/?=
 =?us-ascii?Q?isG61Cf6Iv5pTv0fk2JaT8b7SJ+7G3/dDi5Ox9JLtsUDdzMF+vZnsDl8RY06?=
 =?us-ascii?Q?S8+BigxhschcxOC5xrdn3g1uZglSwY697fmiG1zhcLRqD5dWJT52HsH0krAF?=
 =?us-ascii?Q?pIIU8wPskgfp2a8aVl63PS/6hAsS/hznEVgE8Ped67EqKxf7aEiC1pkw7HOn?=
 =?us-ascii?Q?TQhXxb4OkM0KPCJXlmigSQzg+5Zmcf1Vfe3HwmJ6HAHNlVUfvFA0OoXo/mJ5?=
 =?us-ascii?Q?qzd+eEksSlcW6TdfaziJcf0tF9C7YyfG0bmwyDAlDRTKR8EfbhQJ7gmRNx6e?=
 =?us-ascii?Q?QiGiRNRumG4xlbbOBLlFE5Z8AMj8Z8jSW8mxepAyXjfp0CVFNf3niF67WbJ5?=
 =?us-ascii?Q?7LifhT9fGyUSKNf1QzcDAyXItVjED4APPJTyDC49fMW7enbPKOhDdKS20agi?=
 =?us-ascii?Q?jNsFHgqNlP5DsPPh8U3BXVQ7p3sPVUhepPpL/s5cqi0ZhdiKk8oFqA0QX6PK?=
 =?us-ascii?Q?LtBaC3Ptty4AWmzORZV3oHphjXBDi56pnBFvd2zN8de7tJenziifekc+0Ory?=
 =?us-ascii?Q?cyk5b7MYT0Xao/2gEcqJfvpNkVCnveRWULsSP8Ns5om8aJaVRdHlbTIt7EgA?=
 =?us-ascii?Q?+qD+pXQJHNSUp+WvpEvW44dFajsxkjBhNXRRjQ/exJbL/uJgjBYuv2z9qXQF?=
 =?us-ascii?Q?/IMWYzqAsgQhHTYo8tKpU/XFziJq1m0ZVL8TqkV926WXGaFQkUw41l0FCjXB?=
 =?us-ascii?Q?OiYuIbFwWQesuZa1RIHEBuAfT4aY5DZ4k1ZJKN3tQhd02DqVhacTN1HmRpmk?=
 =?us-ascii?Q?H1tuJ1nkrjrle80rUtl90EB9bkeD1pRDUHZrQy+07jdTIJeTpGj/zBoWmhqb?=
 =?us-ascii?Q?1gkZGLupnn4Uzt1t/gA/KeE4WmaRtaD8V+qQ/sfwQcZAalprGXRf7Uo9vCrU?=
 =?us-ascii?Q?Q7bK8p3Sp0cyT1Gr7uncQ/yqbawITbAow9UhrqXOXi1AZijLasnJVsfhLwbd?=
 =?us-ascii?Q?lCcfMfiw39cntmYADTmCA0yZ1+68P1H+g3j7KIl69Wf9hPuN6k5sZS0E2hp/?=
 =?us-ascii?Q?wyxTYYPWG2zVTJcaiFvLSAdwmi64/2aO+wJy3wkSEzw9yxc0QtgTY5bZLs1Y?=
 =?us-ascii?Q?1QmYCJXUv2qlrrbl100babMDxgoSR/deQbcK/ir8JzGnVptVkb5eoQy6g9IL?=
 =?us-ascii?Q?WQI3jx64pVIchiuSL2A/2BtNYKdzMXS9ZRAMYPMzDlXDxmFzruQgnY+wAEPs?=
 =?us-ascii?Q?JnJlGDW71HhS7U9DFAuFK4GE9YcQA4tayr+bIy6zu0BvtnkJTMpSQe6WE81g?=
 =?us-ascii?Q?o3Et0hWR29sW2uxnRmJQhhgJtU7ihCoATsmYzcbpzWaesRiSWVOjQCsZxxzQ?=
 =?us-ascii?Q?7pkhIeqB4Thmi0JJmSQMD2k/Wb2iP9LFTpbs2df+8Z5EUtfUVaf7cMVBeuaj?=
 =?us-ascii?Q?h7I1giJqCl1somuyqihvq5UK30EV4AFtdfXjJhXHaZtdJxpU7HlWYJtJ9wWF?=
 =?us-ascii?Q?nkGq8Jwf0r3nJfIBjZVdYvbEvzEQoy3rS7LDcp2ktfvVLbnX4iHsyNIH51BH?=
 =?us-ascii?Q?FyuD/35wrsyy9z1Sa8NwK0NzbaDlznb4uaVMxI42grAHR7JL7F+l6pKX67Wh?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2adb2a9-2f1e-45ad-e4b7-08dae4257d96
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 14:04:50.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uswXDTsaElvJUHs3Uua7aMz1QQEn4kiPRM7sIVEW23g4sHR5ubMUM2lcSg6HxGxw1dZv/5uTYR+kpoC+dQhfxCaIqIE7hNiFz0crU1XIbr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3750
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 22 Dec 2022 14:44:18 +0200
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Thu, Dec 22, 2022 at 11:37:19AM +0100, Henning Schild wrote:
> > What we called IPC427G should be renamed to BX-39A to be more in
> > line with the actual product name.  
> 
> Can you tell what does the current name mean?

427G is an internal prototype name using the naming scheme that these
kind of machines used to use for several generations. For some reason
the naming scheme was changed and the public product name is BX-39A.

Please do not ask me why. But if you would happen to own such a device
you would know it as BX-39A _only_.

> Depending on that I would consider either your approach here or
> perhaps just adding a comment in each of the places.

Mentioning the name 427G, even as a comment, does not make much sense.
Since the box is for sale it is called BX-39A and was never called 427G.

I used the internal prototype name and only recently learned that never
became the final name. And this cleanup makes sure nobody gets
confused.

Henning
