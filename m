Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C6B75079D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjGLMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGLMK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:10:29 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe13::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE5DE4F;
        Wed, 12 Jul 2023 05:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtEEJaiEkjRZbwNGMovCiIEt1C9XmigHQy65Y4bqpctjULK8nOLhxzc3Mxc5cIJVFO/Dg/h602YccGW7RASEV0u0XHqmv5fGu+fE3hBv4UzmOXXfhE9b3QFAxrjlurC11p/3Z4ETjsxug8LN2QxfFluhFe/+WeA0dPUMGUQMv1Kf6TaqwvjYFX11kLJWCA7HxNaQmjHXWNxDTe3UBlHhKLT58zbULFnQCcNl/pZSXRmxbg8ckTv8p9ir0cxBdGys2W3cxr4ZnfEGFwiTESL83WPpeNrKpcRgN0omGvOOmDQylfivYOMWwBuf8YbKlnwKVMTn9ELhQDbNzoRh1PlEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d+tfSDgIBt56zkqyv62nbE19/E0Tfi3cYUsA0a1S4w=;
 b=l27vFxW7NFVUySW4TjZDQIJz1vQcFbAoXpRvYDN1DB+/pxkz707mTm5cBYKRu+fMjOaig8UrQuagNSATu4Tn3uLrF37MZhnZYV3/s1Pd6FDvovXtf0Kbru+MhKxuOejt6orlGXsMy9uefj2cCw34dlkqUh63xQS3tPICCs02a/lVjilZ8F0IER2KLJ6CPMJrs8n/Fw0/6xdw5N4GPI0rrHZjZ339VYHUMVBZqCMvHwQI+n3K2/IMcJ0eoNGmmTg/x4StiW+5/4Wx3btQeyYLbS/jBwYf47L9JM2Tm61g89DeEzm725Vv22PJ4K27oqKzlHObFd6StCbXyRcrZpiySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d+tfSDgIBt56zkqyv62nbE19/E0Tfi3cYUsA0a1S4w=;
 b=YEriBDkVuZHLzQuNUM+OCJbfOHJk7gW2iMxzM21iFwumrnuTmMWrFwuMZEOSakgpQENwiltT8Y49ZL3ccTZEbyz2SrBMHqMOXnR6l9nOXuFJ5znR0fGYwqXYbPZ9GD53vGmtDy7rktM5rnZQjQnAkzIy3srKCXz4O5F0Mdt+IwpmNXSmP5Uk98Z1/G8pI4NEKOim72aPVsHW0muo3NmlX5uz16SNycvVtF/2MJ49mU0vhfOtvTvcky59Im6Ofe8KQ+BJmJ/uoApDqnj4Nc93VBSCjCGPX40xkIPMThLaTebN5HgxsVTIH+KQ8kC8hAQ1ynHfcrheCEcUFszHoHlSyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU2PR10MB7693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:492::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 12:10:25 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 12:10:25 +0000
Date:   Wed, 12 Jul 2023 14:10:13 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: simatic-ipc-leds-gpio: fix comment style in
 SPDX header
Message-ID: <20230712141013.67140778@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230712115252.GA10768@google.com>
References: <20230706161040.21152-1-henning.schild@siemens.com>
        <20230706161040.21152-3-henning.schild@siemens.com>
        <20230712115252.GA10768@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:610:52::27) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU2PR10MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: b45cecad-3367-4c8d-7a46-08db82d0f911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPWb81kTgnN7zfw1Vcqe2O+lufpAxX7uhT9wfc04liIQNN4ZMUYWocGtEUjqwVoJjS7a+ZGv3EwtYeKr1TUmYB/S11IgvtHQ3zkMD6bjtgvqZfZs3/r2F3/SgFXeyQuJKt7JBStj+QfTW9/n9gum/hzapbCMQ1V/Yz5Z+0ckW+pcNG/Zx3jKuWy14rmQC55iZC+IwwN1rRry/TXkoGD4sx4INl0vWiAjWBck8HXzaQ8jioqQCG7SWMq/IJivpJGEQ9lSCH3K6XeVxFEPaSMWNf7M55YUEfNQtODVsRDrHDU2aPk91CQ3ffXDK5ZlR4jkBufFWU+A9BJOAqFCgoHCqxUNa2Yg81TumYptvPXwNSuxKPTsyRC/HW1UUp5yanvEPyiiR9SZB5afKtS2Z1CB/wU1nwdTPa6Vq7aqyQ0XoQUdejG+/vfihbYFEbuzYlaGraFEyAmIcm/ARCvQ59vbdziSAz8AZRDPHy0yltEsAZWyDpMXoVQSkXCoT7vAlneiibAooWxgUuW4X3GoAumjUzOOUl7SP3U6eAQLG8HKsZlmQA8qXxs9SppAcY6SBrsk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(6486002)(6666004)(86362001)(2906002)(38100700002)(4326008)(66946007)(6916009)(186003)(66556008)(66476007)(82960400001)(478600001)(54906003)(316002)(41300700001)(83380400001)(6506007)(5660300002)(1076003)(9686003)(44832011)(6512007)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G1jkC6V6xnuLgaC1a6sOmMc60BMmNBgTk15liiODrqjHmZnroHE+emO4Klss?=
 =?us-ascii?Q?3fBtxrtkh7rYGL/K9nWRKxaBX78xebHmzKGDE8QcRvf1fQRTQ72LcvpuzONB?=
 =?us-ascii?Q?WvTNEftpKTzKYl+Ks+uo4gA6l5iOfb7qc4L6uZWQiTIpi2mSEFMgLjrpTDys?=
 =?us-ascii?Q?tmc6RxUbZsck5vD52bYZNQN5FYmyLHseqcHFYpRBPlmuaECmWiQGDoOPxq4q?=
 =?us-ascii?Q?9UI29TsC+G3SmE21Chh7VrQk7k76kX7B7+BvVx6JuSF/PjVJWS88DvxrtX2v?=
 =?us-ascii?Q?jy7esBFGaC3gTPPdS0faTOHYrGycGH/fb00uaDMUhLvdkScjDVxIHFXeI+kJ?=
 =?us-ascii?Q?/rEzU97GOR8VYHR/EfdSmwakIo1z0KnKYpdnrYOIMcSF+JNC908zAB24uU18?=
 =?us-ascii?Q?MRkI3jzoCGI1Ui42Bo6mFXhzfEpklCOqbz2w8hMJeHIgX4KhXCT4FNWnnL9+?=
 =?us-ascii?Q?UjwTmadvV+/c27+c4XTRi1A7nHH2nDUCHckOd6nplfm3XJJP9VIG4Cf6J5lo?=
 =?us-ascii?Q?R5a3ayXQmtXKK6rNrvSCRjhX+SZeBuXakaMnRa1rqwCGIZIGu3W7+wJR5aDz?=
 =?us-ascii?Q?yAEvJZJ7FOncSHOcH33mLC+1dRFkkkQBJB7OBN2z2rpMhPJTnhtpa4OyU4Ge?=
 =?us-ascii?Q?yR2OLhh8+G7K0l0nchwUjaGJMo4knG5f+Pp/+sVX1xMidkUEp93CiITgU+SD?=
 =?us-ascii?Q?mSrbgbyGpVZOqEzQRs8c7ICioD2xVau0r0zqUfbMx7/+JEtFfcXS/mCGAvFM?=
 =?us-ascii?Q?76xz/u2nQBJCGIgwhPMpqAwUFTQAbHXhSpaxJjijYbTUVvj7eOAeNP7mhONg?=
 =?us-ascii?Q?eAP2si5uZu6hATj3QKom2MrjEXFNy9t5wIvUqYd78K13vlZoSmIFPOtk/11Q?=
 =?us-ascii?Q?5lRUEhYJFL7UQPnbR1fhYnH9llW58TaLqy8pKDJLJpUnYQc0tk2w4DWNTxj6?=
 =?us-ascii?Q?syPgi1hb4fxioZy/qAXII5nyiwWun9RHhEk4dqtTe+EdF0TqkHk7+2+Tgqgm?=
 =?us-ascii?Q?nfhRVKeZOmK1rs0xxdxJr7lyLhCb+PhUaEKPzRKHAwAYpTj+je7zevNVydqx?=
 =?us-ascii?Q?oQdiwHE5XKRUOzziEy9LfusgTP5gEJnebyjiBJr1zvPztlOv2RSmKZQVQF6o?=
 =?us-ascii?Q?GeggvRN4KnJOtrDpDTNU/jKVWyZ7X+0SeY75FPTrnwQ9ogXzzVrvtfuRieaQ?=
 =?us-ascii?Q?UrET5yRSrj9PMhCmLxfjkiO4o5QTcC15u/t0tOgdeVVkTGnnKhlcmMEcPwaa?=
 =?us-ascii?Q?//rcLLjogMFSCdzOH5bFNHx9OtybblzMlW/JCV2SSw6M+URIzbCZW2LKUei4?=
 =?us-ascii?Q?1rtqP29FKrkPgkcGEGGf+IZkLY1tAex+kBbpM8NZSs7/cnlQNSqmEenA6kw1?=
 =?us-ascii?Q?WCk4H5Qi+JFRyhfQMdz5VeApJ/Tliw/Clj6F2LG+epbzjDgRFoLouJrny2HI?=
 =?us-ascii?Q?3cS0OXRPcPnoDkWbMYrrrZGNhZUpCTZsh1zmt0YSeB5RvzrUvgwQRirc5KaT?=
 =?us-ascii?Q?zriyvI222YkApruXKT4jBWmROC+6vKHqfwFivzRG+VYHCF5/eMWpXB2fvxif?=
 =?us-ascii?Q?OY4BJnpnNUmc25LIbw5hwwZvQiGmuMsReHFon2PuTZn23bxI6ubSngoGc0Dy?=
 =?us-ascii?Q?QstyKhoYdUZdx/8wPGaBa/gJJcpfzc/U5AtxKQL68eh1Vz+J+uC5GNNUkVTg?=
 =?us-ascii?Q?Tl5CiA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45cecad-3367-4c8d-7a46-08db82d0f911
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:10:24.9195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxK8eokbu4s9SBiY7DxnComBjI8jGouvHhnqDk2O5IrCHaurPzx6IgIC95q9scoPpmrkYHSeMN/DKKj00DTWiLsQu3eI9/sbHyqWjl+Q7Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7693
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 12 Jul 2023 12:52:52 +0100
schrieb Lee Jones <lee@kernel.org>:

> On Thu, 06 Jul 2023, Henning Schild wrote:
> 
> > This was found with giving the file to checkpatch.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  drivers/leds/simple/simatic-ipc-leds-gpio.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.h
> > b/drivers/leds/simple/simatic-ipc-leds-gpio.h index
> > bf258c32f83d..3d4877aa4e0c 100644 ---
> > a/drivers/leds/simple/simatic-ipc-leds-gpio.h +++
> > b/drivers/leds/simple/simatic-ipc-leds-gpio.h @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +/* SPDX-License-Identifier: GPL-2.0 */  
> 
> What prompted this change?
> 
> % git grep -F "// SPDX-License-Identifier:" -- drivers/leds | wc -l
> 117
> % git grep -F "/* SPDX-License-Identifier:" -- drivers/leds | wc -l
> 2
> 

./scripts/checkpatch.pl --no-tree --file
drivers/leds/simple/simatic-ipc-leds-gpio.h 

it boils down to header versus c-file, not sure why headers prefer that
other style

Henning
