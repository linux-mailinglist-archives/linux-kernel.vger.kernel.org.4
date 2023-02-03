Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A409F689FD2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBCQ6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjBCQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:58:35 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0642128854;
        Fri,  3 Feb 2023 08:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hz1pRmGH3rwCJ+eZZ7aBSV8nBGl3yPT0KTlqkdXSViMFu9IXgTxRTJL4ugkmaojm15ymlxVR+GomObewBZKkBez0zEgqjSP+vOySxoaqUkD8Rh4WiMZeOQMJfY4ZHU4+TPiBhFVHPkWDV9og7Vl82rsG85fLEFKNDyJHu2E0/brOKTrj99NO4sKCYkb1pXZLjVpujM0Sy6WQeii/pFz8/8f5hBp+a2Ih8ULMkq6r292ipMFjO/Fl/P42PIksBxN2UJV2OC3M3Uikj8MT95ZkPIcpD9e7MqTCkm/cnBA71/wV0rGeGXAbeTL9TLiOOHiPIQEfrqfE8VVoSnKHX4fVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83hpU2DG8fquT5zEL2YXiztRr9qLFgPJCQ8pHZ+ieEo=;
 b=YHv8ktyykYtCljPRDcZrp20V3D9wMMvekso0AHFzSb8VPGZBuiDtErPVy4BJyoKWZcyw2ISXCpgMUXcshrnPGfCvKCFKXKz/F1c/WvVNwpzvABOR3Rqi5uklgl7/3njVV9Cgn1bISdp3/XVr6rRsJjbWZ9umz/tTFkZsVZtJd+YF3H7erliYvOR5gzB+hoOQXWJos4GYm3No0ihk/FXtTaIO1VJaZZkFKmnbEtlwDDwMWCyW2OqwBmPmLmXemsFDQO/rd+fCtWq38JXibnQktTkl6lwb0EDk2qmbfCVlPIXYiBZiOnxO96qm8eRx39b4uuF2btu10R4fKJ2LnOPQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83hpU2DG8fquT5zEL2YXiztRr9qLFgPJCQ8pHZ+ieEo=;
 b=GYv3j7yyrI+/mj1D65F8G423lWQ2GK8pdQ4zQwmuxrDS5XSNU1A0TAZUcEeRLrU23V8zqoS3TdooueqYjRWeOwT79YS6fHxJ+iOQbPcVNDzdJvZFEW1yhZX6+/hNKo94i2IrLU80ABihs7CwrcB1iJ+dv1xppAGIsoOJV1svxX3HdbbZP27QQBsEt5pEwLe/981anhVA2swZvgYiTSA7bwvr3mHyy5ArB39MKXl0yqcl2kXfGBkkk6hzFFcQQFzQrDeX4yw7YlvzVFoYc69Zn3ZHni1ymVfNqrZ1Bvh9Eh56WsVL8KBqeAkLwoST50V3upw6nTHu2Ncxt17K2c8svw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB5PR10MB7776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 16:58:11 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%4]) with mapi id 15.20.6064.028; Fri, 3 Feb 2023
 16:58:11 +0000
Date:   Fri, 3 Feb 2023 17:58:04 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20230203175804.2560dd21@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y9y+yOa1gxy3h+rG@google.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
        <Y8mv8PzL1UsP9gNh@google.com>
        <20230202205704.12a5fbff@md1za8fc.ad001.siemens.net>
        <Y9y+yOa1gxy3h+rG@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0381.namprd03.prod.outlook.com
 (2603:10b6:610:119::16) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DB5PR10MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4e5cce-75b3-4938-bd3d-08db0607d522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3gf9YS2QFldcfD3+ul02BPMruMEYGlBsMD600EN6B12LAfeM4LNcrL4q47pOcpFFHwFiVWz/LKkwL2npu+dbm0YjnsatPf9tsvZ4qk+9kaaFmf+9ic5kGhJRZAfQ9xQBvGTRLG9po3CRNtowiLoqXJts99RsqonXY+hqF4A/e8cEkNznNCkW1wdi5OLZU6ZuTqcPoVHQpiAW2GIPvQYENrtwnOo5Oe9fDMbJzRj4MbCoKf2PxNA6lwiLE42cqYJvfjHrmuNW+y9b2896Gj/hQSzMcfih5uzG9GNIzjlRwLLZEGs9pSKTc7JiDfmfv3q+viV6YWLxWWEG3EzP8CiacQR2x1SKlPSVwMX4ihRtxTJplOz4bjFmQUR61Cd/dE9b9IgKHq4f+y97MLtxw1u1LMuVcYmfHtuPWX9vefplsScGMST5vp+9DkrmE0bZjheoc2Sr65lfQFVGR7K/vN9tUpmVOR8xGS+WmoUajMpm0SJjPio49JX4PfBJc9fKmDsAje3RwbpuRquu0m41lGFROWP0S1JE1sG96gUn8Gh+rdBgo4xk/MqeGtmcw9Li6+WWCAwiiZG7AR5lqqq2GVyGdQ9Hq4yWE/ZS+EjJZuRRSwaCECint+jgtDg24vKi/PzE3Lz9Q9OyqtDpOMxnvMHZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199018)(2906002)(44832011)(86362001)(5660300002)(8936002)(82960400001)(66946007)(41300700001)(8676002)(66476007)(6916009)(38100700002)(66556008)(4326008)(478600001)(6486002)(54906003)(316002)(26005)(9686003)(6512007)(83380400001)(6666004)(186003)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qYHGCVBuohsXQ/KluWnPMretvkvD9ywz14RZfEl7lS/SM/+s360ZafQ0my25?=
 =?us-ascii?Q?s2wvHWCr/9QNsx6NvsbiP+TVodfbSXl7kQzIucwW5b4mZgrPtMCFvA00Yrjt?=
 =?us-ascii?Q?3JB1PKO5pO4FC3pww7lsrK3LsbK0hmNphKvTThXZ78hBFGPGzu0/AFL+OzlH?=
 =?us-ascii?Q?SlglFuzZd0tidQ5KdGrbHOHotC3ajmZRIelS/ZuUJVf71UjJEysOxfGBoeIo?=
 =?us-ascii?Q?uCCZk0m3WCBeLID5GgzMpjOU5Tc3/fI27XMe3t46Wv/48YvASQ5oIHYZgS1j?=
 =?us-ascii?Q?sOt0W6nM1LqxV4QRXMGchNH9PKcOfgCARq4mrlhWJztJwOk8zpUzSUWFz18g?=
 =?us-ascii?Q?5DYQlu9SCDekPohAr5lGPJDU9kzwDyaQgM20c6G3/uj0lASzUOzZEz67n8jI?=
 =?us-ascii?Q?g9eI3AA9ac6orZBNNDXCcK98pqOdFuEjr9cZJkTupgrBN1LewUlEMV2E96ae?=
 =?us-ascii?Q?DvQsPbr2l9MYDkLEvykWYhUIPd8hBrsoyLSpefkdHUyHnwd+O577DHSTq353?=
 =?us-ascii?Q?O9v8GK8t3+wWTokHPY9UWzxcGLVPKntMeCAAqttzpOkweFVbYC7AurgnZOjD?=
 =?us-ascii?Q?k2rW4jGYycFkPdrvNiPKFC2XuJRifBqNxKcgpcV3H4RoOp02GOvh28KH3HP4?=
 =?us-ascii?Q?zoc6QYA5+salBb8/vbsNYLvpD9akmhfXWlJpPoSQ3sIzbeirDOnro33wrjcc?=
 =?us-ascii?Q?mTnu53hNP8HhEdMsrWqkQe6jqARCZ91076uHPueh4FfMQtbUTZZWHkgivKXr?=
 =?us-ascii?Q?ZjfIIBbQXGy1U+sGXa0DfKb3n1MFC9yhXqhTKyFSWOYDCPiHDenQELcmZOEZ?=
 =?us-ascii?Q?rvgkNgA3p/zOqSGFU+sFiAr82+37fSR7ZJy8IHw5HxzDQbW6PWYW0B5my4rx?=
 =?us-ascii?Q?S0xZ5EWGAvHEWLZ1WApZ+pfrtoNxGKOPSY5cxcnpNUik36FBqVbsrt98ynWu?=
 =?us-ascii?Q?zDElTXA6KZtDZWwp2i5A20fCOUd2pj7eIq0qg9+D4F65xwZ4+ZMsBUrkjneI?=
 =?us-ascii?Q?ynW2q8UHXz1XuZOW8pLuAtDxQGMv9bExI36/1y4FDoUSrbSDmbvGqfj5JRjN?=
 =?us-ascii?Q?QGfNHFQ7j6m5zTwcztnXWqFHbyYjnBTCl1I0ypf4QL4OdEtnTi/3nI790c77?=
 =?us-ascii?Q?yTWgKLtMQRc10om/Y3CeayjcaZxbQnWDFB8hfOm3RqVoKUoZf7pvu2c29nUw?=
 =?us-ascii?Q?aCoPPiAR3XBZAinUer39bWjKwyGODX+U0XEWC9KNi5Xb6M7U7IISzOl+viSX?=
 =?us-ascii?Q?lyeUCHO/g5lx3kxmQde4f/EV2sjo8a99P2WfIyH5uwwg2jA7/SP8dUgLRRyz?=
 =?us-ascii?Q?uNGRClPOEajc8O8GeQNdVQudvun8YuAFfRP0mb7nkS543SnYZfyeWzw57kKj?=
 =?us-ascii?Q?QqFppzppOAhGv5OeuxkO8XvzgQib1BxuGQW/T5sg8KVD6n6TZ0Lrsrwfwhbl?=
 =?us-ascii?Q?Qhu+Cs84OnfJMsSRsoR22IBzcOcxs1ueHchuLtfcuCzMVRdNtBdP4/Wfi0Q3?=
 =?us-ascii?Q?23RGlB8DoRBns+eaI/iHIOHRrSXvdezhq8Vzl1Q9rltthypHui3e5ySq1gMO?=
 =?us-ascii?Q?iUJFO+gGkfIktbu+kYIjL1FksDnJnHqK0dS9glgGGao6jhol5BpA07Mi469S?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4e5cce-75b3-4938-bd3d-08db0607d522
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 16:58:11.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqLojECr2pcBSh5WonCQBfk4WIL8D15Mz1Y6S1QcgaklruocGwHS9oa+mCiua4WHy0upbxdaOGkJxThRqCBuAOr5cICP+ZaNfk2jSsU9tI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7776
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, 3 Feb 2023 07:59:04 +0000
schrieb Lee Jones <lee@kernel.org>:

> On Thu, 02 Feb 2023, Henning Schild wrote:
> 
> > Am Thu, 19 Jan 2023 21:02:40 +0000
> > schrieb Lee Jones <lee@kernel.org>:
> >   
> > > On Fri, 07 Oct 2022, Henning Schild wrote:
> > >   
> > > > If we register a "leds-gpio" platform device for GPIO pins that
> > > > do not exist we get a -EPROBE_DEFER and the probe will be tried
> > > > again later. If there is no driver to provide that pin we will
> > > > poll forever and also create a lot of log messages.
> > > > 
> > > > So check if that GPIO driver is configured, if so it will come
> > > > up eventually. If not, we exit our probe function early and do
> > > > not even bother registering the "leds-gpio". This method was
> > > > chosen over "Kconfig depends" since this way we can add support
> > > > for more devices and GPIO backends more easily without
> > > > "depends":ing on all GPIO backends.
> > > > 
> > > > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO
> > > > version of Siemens driver") Reviewed-by: Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > > > <henning.schild@siemens.com> ---
> > > >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> > > >  1 file changed, 2 insertions(+)    
> > > 
> > > FYI: I'm going to try my best not to take another one like this.  
> > 
> > You will not have to. I now understood how to improve on that as i
> > am adding more variants needing more gpio controller drivers.
> >   
> > > Please try to improve the whole situation for you next submission.
> > > 
> > > Applied, thanks.  
> > 
> > I hope this is still in the branches for a merge. It should be
> > applied. It does fix a problem but using a wrong pattern, but a
> > pattern that is already in use.  
> 
> What makes you think it's not applied?

Because i had that other one potentially replacing it so it was maybe
called off. Good to know it was not stopped.

Henning

>  
> > So this will fix 6.1 and above in the short term.
> > 
> > In the long term i will restructure to individual drivers which
> > have a clear dependency chain in Kconfig. I will use inheritance to
> > arrive at minimal code duplication and will use Kconfig switch
> > default inheritance to ease configuration.
> > 
> > Such restructuring patches will have to be written first, but they
> > will come. Either stand-alone or together with the next machine.  
> 
> That's fine.  Whatever suits.
> 

