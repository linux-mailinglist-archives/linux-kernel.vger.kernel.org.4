Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5FD6A8786
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjCBRGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCBRGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:06:47 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612C8410B6;
        Thu,  2 Mar 2023 09:06:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3PdW8sQfoZ0BXy/weVoKA5UC6Oz9noWWv+Z/SURYGd3oenwqPsPTclqZ3Cv5aVp2nZRF4QrwcWGzGIwMHsvUCFEvgWtyRcnE4PWOneVfv/W9vnBVEdJoXrRVM0uCc/2uv0Wz6+TtSG3H5bXYEKSxA+CFs5cH7Qrr2xvs24OnKwvTPFNvhSoIvJoWuPTj/HzhpqPyganz6EW+Noa7Hyarc0IbSAJXyXe3ndW6p8D9HMlqdoq/RNeLSmPjJfIyGBV52BU1zbjhKvlg0iAr2XM6X9iq27Wpy2YWrVHMdehcwXt9DO5X3iykZ1EQ1Jjo8Gle9xhbyjz0j1pBS/30av6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uc5s0DUPD6OoFyo36GaUdqA+BSAUvLQy43e1hGUk6hw=;
 b=nlAIcshhjw9NUbrt/2v8oxZedOei3cEtpcCr7sTuTtfKkIL0112J+3lzUh4rwqB3Y3HiDsz4r9vArqHjNegvC6oAwI8NPy1GWtLU1wKSUs+i6Y0hxZFvOmjejJoh5LiM/wsDxutQ0sWQbsE6mJiWPF0MY+wRJeyfQBRIYp+WwwW+xEH5Sbe/FOtoVu4XQdx/jMiswRx9vqE23lbtGCaVktBTCjXveMkaileHoiKPT84QkYXmh/EhXxJihXtjijTb0sZKeIwhdjVp7YnYWTq0KpxBMm7mvFl5IWOzVxJczrdC/fF4k/+S6EA6ixSBO7HDy7+D8nMd7M/g3wcola3yAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uc5s0DUPD6OoFyo36GaUdqA+BSAUvLQy43e1hGUk6hw=;
 b=LSUjGwiELmq4j6FB5/4ntXbwdiF2Ya2mw3atFO9FMrAVpHmOXKNuKACYLwM+hCJgN2fHySaN2bE45TOsxZ8UpoMQ8gNyiVoAQA8EOIZC1kjTyuWENgAYr3fwQo8YOk2+RdFzs9Do83IQgtFm1FJsELCHAXRBClcyH1pRBc2jCYxl0F9Zo7fdSb4FOyQbXwL6iHbU6FKAnv/SYU8ptvDkRQzQ0uGLdv+Nmsi0SJgRG+elJqNuFx/4Sy+y/Iiz9gk8OZUX5EM7tIR3fpJMEzx1bslKGyrDSa45p9JfkLVivsUA2Wnw40Sa8ZvkiDHWnEOFsrn8pQwDQxZhQy4k13f9tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by GV2PR10MB6959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 17:06:42 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%6]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 17:06:42 +0000
Date:   Thu, 2 Mar 2023 18:06:32 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 2/3] leds: simatic-ipc-leds-gpio: split up into
 multiple drivers
Message-ID: <20230302180632.289c9e9b@md1za8fc.ad001.siemens.net>
In-Reply-To: <ZADNAQbmxC3hdgl3@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
        <20230301170215.23382-3-henning.schild@siemens.com>
        <Y/+LLICwh3T25IGv@smile.fi.intel.com>
        <20230302094009.74b5d368@md1za8fc.ad001.siemens.net>
        <ZADE7kBB9HzTlpul@smile.fi.intel.com>
        <20230302165824.4868f6da@md1za8fc.ad001.siemens.net>
        <ZADNAQbmxC3hdgl3@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:610:e7::30) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|GV2PR10MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b95d309-f25c-4898-e693-08db1b407edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSzr8DVdc2N84AJRqaKvhJfTPhNWhyx0v877rjp41um37GCH4Gp0tXjGwllLhmmpMJ3Wbrk2qAm4mN9Qvl5/2FGZZFwpvJaSUw/vFTTCP3QKkYw6t6NIW7eTE91pMo6MXaVkXheQOU1rw4y3ZI3EWL3EyqlH7Ct0LzuVvTNqT0abfI4QdiJoXt4Z4LpbsDKTOW2F5GLYgLGHtnvEwOJ2SsWQLusZ1l2s6yuViJBwg44ssCzub2Slv1TeGRA7mnpGZ9hoBmTig5riRP2bmi4ksURA6H7DAJDrYTToi5o6OIdRiJU3yck3EbaB4Q3Lw7mJC99/lbOKH/o+ZHpaU8w1Y8ozO0QN4kDOBEZGftV3o+tBCGyF/iJnlHrLGo1VhcxTwfOf1VJmRdaYnLMPSptGYdC946JRqaiMMYB8OnC1SEshKSY7fbgj9Uizb6jr+b3/d6glvZH6SjeUSiDwumXRwJNOnMhCPgfc6E884hzCJmGQiZJXdjtSrztj7WNAD6oWmq1S1YIVoaguxAR0FJ3iVTU6BjVFF6hiFpOp9pYq3+txn+sMIaB60A3nfEU2aXPIYeriPIdif/UPTx+aQIzEnMa2YUdfBoQ0wdjN1vNn11W075PuKHnsHB5Jjvif733d2m6qUkW6+AHOv0xHsOrazQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199018)(6666004)(66946007)(54906003)(8936002)(44832011)(86362001)(5660300002)(6486002)(82960400001)(41300700001)(66556008)(316002)(6916009)(38100700002)(66476007)(8676002)(66899018)(6512007)(9686003)(2906002)(4326008)(186003)(6506007)(26005)(1076003)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFRwaHd2cG8xL1lCSDMzWjRLMDlUVWFEcWFudzlGSnJlc1k2Q2RPeWs1YUhC?=
 =?utf-8?B?WThqSTlzUFMxTnpBMjhYd3M4ZU5LOXgvNjZNQ21mN2gxRjUxUzY5NTd0UmdG?=
 =?utf-8?B?M3crQ2dvMHkvVW9rTFJKSkxUTXFjbkNJTE4zMkNDdUd4SVNCQU5zUjZSODBV?=
 =?utf-8?B?eUdmSkJPSmpwWnVrdnlCenNPdVFlU211Z3A1RE91Q1ZDVSthRjAxNXplQUZC?=
 =?utf-8?B?Y1V1MS9sa283STZGNEk5ZUpXazc2SjU4ZkE2S1daQk5MUmMxQzJqU3lFVHlu?=
 =?utf-8?B?bGpNanN6M3VtN1pQK1NobmFUMFdsRVh6UmM0QjVJZFFHa0tib0FXck5xc1hE?=
 =?utf-8?B?V0g1OVoyN09vWWxTYm9aQ2R2RFZTTFBNV1hBTG1xQ3hCM3RjMEdhekcreWV0?=
 =?utf-8?B?UVRQYjlPR25JcGNrblZCWEpWaFhRRVBSeE40dWJKV3JhT2pJSFJIK0dYWnFz?=
 =?utf-8?B?SFZPT0NEU1hUWjEyNW9VTm1PN09EL0VleEo2WlFxRXN2QWszdjA1ZzRTRE9B?=
 =?utf-8?B?Smt2dUlNamVLcm1VU1U3RTdiejVnL1BTVVhSYndKdmJOczJjdHJKV1FaNHk1?=
 =?utf-8?B?TzZDaVhjbjZNemt1eUdKTnpiWGI2dWdXT05Bb0xaaXJwVnVLWTJtREx3LzZM?=
 =?utf-8?B?NEFRcWNHRHdnZ1FWazg0VEJRbnRXNFpQd1V2SFR1T1U3RGM1eVJVNmh5bFVI?=
 =?utf-8?B?RUFHVlhWdit5ckt3TzlnMG1WRCtnQmRDMTdPUjkvanlydFNVaStFdzYxS1BV?=
 =?utf-8?B?QzJUVmNZOTVWWER5eldWem1VQk1nR0xlQjk3elFmaVY5WTd3cUNib0ZELzFq?=
 =?utf-8?B?QzJjZHlHSklqNFAwMEN1UVdPcElRYUNTNXdYSGJWYVRpa2ZSb0Zzc3VlS2pY?=
 =?utf-8?B?aFZCbjZ1U2JFNlQ1b1hxMjE2NlVUYnRrdzhSVkxSZVZRMXp5bng3NGFBRVIy?=
 =?utf-8?B?dkhEb3hseGRJampuWWM3UE1RaWVqOHdGMVdmK3AxVHNWb25tSnc0bVRWbTZ4?=
 =?utf-8?B?VlUwc2F5WGYzSDlwM2JlRnEweFhlMWprY0x5SmR4YmM2Zng0b1VhUmkxc1dI?=
 =?utf-8?B?MUhaRDJGNXBnWWJpQ2tIckFjYy9mYjM2T1FHNnUvMTAxdzF1YmZabXJ5d2NR?=
 =?utf-8?B?VzZHd3RvQi8yZmZNbUdvWWhTVEU2WExsSTJYUjMwb3MzcG5OYzAxYnZnRnps?=
 =?utf-8?B?aDcvRS9FYVBGOWNNUi8zdFZwVWdFNEVTM0xhTzFZclJrcDUzaDBLSFc4UXAx?=
 =?utf-8?B?K3YwUTJlWk5MdE9vdEVIamh1VEt4N2RHYStBWmY4Skc3cnpEZ2NyM3NLcTVx?=
 =?utf-8?B?QUdhWlJGZFFYT25wV3N0L2RQeU0xbDhUQ3dPaHR1aXUrYnBTQkpGUUZVdE9J?=
 =?utf-8?B?SnIycmQ4aXF5MUpqaDduOEhRNzVGZG92R1ZzRWJTNG5DUjNmamxlZ2lyOWtB?=
 =?utf-8?B?NHBiR1YxTzh0bjk2ZlFNeGF6d01TUVBXOFU2RElsbEtrSXZ5UDVFOTZ3eHJC?=
 =?utf-8?B?ZkMyT0J2ajlZdTFRY3ozYXFrSzBteDQwS29IdURiVThaZ0RKOG55YVdrOTVF?=
 =?utf-8?B?TE1VeTg3OS9TdHN0M055MmZtS0NocVJIblY2MlF2YnoyaHJ5SThmdVpTZXl5?=
 =?utf-8?B?WHgrR1ZIT0ExMllxdE1TT0VpdjZFcmZzV0JMd0U1bTJXcUhSUFhCeWd5b3FW?=
 =?utf-8?B?MGprSUltTXVYU25ZdFEyYVJhdFdSS1V2cTFDaG84aWFhVDFXcjNBMTFyWlhj?=
 =?utf-8?B?TEtlL2tGdThIQVBPTU4wTEhBeE5MajFBUlZsZjBqVG12QkkzWHZML3IxSmZ5?=
 =?utf-8?B?bXRWdTNhcW5VYmpHTzBPNGVpSXhjdTdKNmFVSzhRbUJFY0NRMzBiUXdmNHh0?=
 =?utf-8?B?NXJRcjIyd0RKTWtab1RTT1hLbWdoOFVxQm56NGRCODhQMGwzZ2dwVCtjSUdP?=
 =?utf-8?B?OGQ1Vk9vQ1Z0c20vQXFaUkhMN1EyS3l3R3Z1WnU2NE80aVYzUWZvblBNSVFq?=
 =?utf-8?B?bU5sWm52L1p1MitmNXFDMjRNUnVnZ1F5TzBNa3ArWTlmNCtYMXh2SXltL0p5?=
 =?utf-8?B?K2t4TXFuSUZxcnd2SVRnVEdsSzFFajFsMGpJM05GTGlSMkFkYXVmaVBsNngv?=
 =?utf-8?B?bjhseU80N0xnbDdUSmpmaTI5ckVuRzRqWDR5aDVvME5KaEUyZmczYXZBQWt3?=
 =?utf-8?Q?oZZnadjri7R3xz5Z019VhTU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b95d309-f25c-4898-e693-08db1b407edf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 17:06:42.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRCO7JHRhDk5Reocm8Tqldba0DNtC32fi6d66Kb0ckYnAbuIHePgHlufdf529P7gbV9rwNoK7B1DtzjtQDDQ5oL+EDn355pJG+N0DCQSECY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6959
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 2 Mar 2023 18:21:21 +0200
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Thu, Mar 02, 2023 at 04:58:24PM +0100, Henning Schild wrote:
> > Am Thu, 2 Mar 2023 17:46:54 +0200
> > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>: =20
> > > On Thu, Mar 02, 2023 at 09:40:09AM +0100, Henning Schild wrote: =20
> > > > Am Wed, 1 Mar 2023 19:28:12 +0200
> > > > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:   =20
> > > > > On Wed, Mar 01, 2023 at 06:02:14PM +0100, Henning Schild
> > > > > wrote:   =20
>=20
> ...
>=20
> > > > > > +	.driver =3D {
> > > > > > +		.name =3D KBUILD_MODNAME,     =20
> > > > >=20
> > > > > Strictly speaking this is an ABI (as something may
> > > > > instantiate the driver from the user space or elsewhere by
> > > > > this name. At the same time this may change with the file
> > > > > name change.
> > > > >=20
> > > > > Personally I prefer explicit string literal here.   =20
> > > >=20
> > > > Switching from one module to three the names have to change.
> > > > People who explicitly loaded the old module which supported
> > > > multiple machines, will now how to load either both o=C5=95 know
> > > > which one to load.   =20
> > >=20
> > > Wait, are you telling that now users load modules _manually_?! =20
> >=20
> > No i am not, the modules all load automatically. I was trying to
> > construct a hypothetical case where the name change could affect
> > users doing unexpected things.
> >  =20
> > > > I personally think the ABI change is acceptable, the assumption
> > > > would be that the drivers load automatically anyhow. And since
> > > > there are no params i doubt users will have /etc/modprobe.d/ or
> > > > /sys/module/ stuff around.
> > > >=20
> > > > And with the split i guess an ABI change can not be fully
> > > > avoided. Whether the names is explicit or implicit is another
> > > > discussion and just a matter of style. I prefer to stay with
> > > > the currently used pattern, it is not un-common in the kernel.
> > > >  =20
> > >=20
> > > The problem with that pattern is possible, while unlikely,
> > > renaming of the file which triggers this to be updated.
> > >=20
> > > Under sysfs the folder will change its name. If user has a script
> > > relying on this, it will be broken. So, I prefer mine. =20
> >=20
> > Yes, the name of the module will change ... and the location of
> > module metadata and params in sysfs, both not a big deal here.
> > Because there are no params, and there is not need to modprobe
> > manually. =20
>=20
> It's not only one folder AFAIU. Also folder in the drivers will change
> its name. Parameters is one thing, the folder presence is another.
>=20
> Yes, the case is quite unlikely to happen (to break anyone's setup)
> that's why I started this with 'Strictly speaking...'. So, seems you
> are staying on your side, I will leave this to maintainers. If they
> are fine, I will have no objections.

We are splitting one module into three, so we will end up with three
names. Or i miss something here.

The only thing one could talk about is whether that string should be
hardcoded or derived from the name of the c-file.

Anyhow, thanks and we should probably just wait what others have to say.

Henning

>=20
> > > > > > +	},     =20
>=20

