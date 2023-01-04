Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C260D65D615
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjADOkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbjADOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:39:40 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9589F62DC;
        Wed,  4 Jan 2023 06:39:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yjk81pUwJd5qEqfhQmE+gQR7t//GIQK/oU0c8k69n2IZZBFcc8woZj6/vAhe7FBbREiJSfQSZSJHeP0kNNuHBhyhPpjLYEqXt4NrTvkhokrfxK16UHwpTht3MbidpxW5ljgSgu0d/cJR1F8GEZnJHrD7jQO5e+5rsXE+5H+fK1ffSjiNg6oAmQzS326RzWEfV2+mJWbXqc+r0kZhdyvheHLi48WjvW1AFEwkTZ6kve0S1Kv6JyYzTWqtfSzWftnvjViFTIak34Rdrd+EaT/ih3RKRXkNn2RQf/yqCJX/Eg/tOLFxgIgJ3qhntsDDZatrRic83vInh0W/x+wSYUqQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxbZeQ6lhh4iYWZiSJvyHARvjE7MH0ZQZqFnX/IrPaw=;
 b=UJhfguIsaiPMhKxarGtha5Sg+DgFFLKNobU4wEySu6h7NCmUOn9GM/b0hJVzuN4+9JMBwMaC0phg1ohaaT5zehesT5bKNNWZ47Aua11fQxf/2vIC+TQ8u/RZYCaZ+21gczdU0eO+V3ikS3AhBpiALyILqgiLRVgN7s/CVHdaMWtUFGXZ6n3Q/IAN+q4hE8efuX2qDW/R+euDo8Nn3xIaNzYQa4SRZgAE1q41LH+JJpdiqsles/JeIWefcGwlxz/6mBWsJ+BTtGnuzLz2umnO2FV4DDf2CM1GpY8hhEDyPBGjuAPtllajsOrf/w+V9I50CAqbY8RhcfsuBjUgYshlLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxbZeQ6lhh4iYWZiSJvyHARvjE7MH0ZQZqFnX/IrPaw=;
 b=SuhwztXVKB4xIYkK10vXvP5WUqFizNY3Y3AY6J247rwk2w8vhwOFK/YZa4manax2w79atpuiWm+8XrY8X28dxhq+rbgw6Rq/BzpW39EvTJ6W2gP2aZqR34/1LFaCGewxKGevMUeCTmHgBnsbjLsH6MycagwsIH2JPWuePWUXCs+yDMXB2BeVBj7lp7YGQcNqHtJWAUPia80i+V7U9dufc6g0uNT5nbqb9DzFpT3ciYi2Oajo4BJDzV20qXImxnahBn+TAbV6YxZMO9NoWcw8qcs/hD9lGwmNkn6vRDjKLUnGPjBH31xNnksPEt2urzIcgubUDVl5nw5wm/v/L1+Hwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB8PR10MB3832.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:166::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 14:39:28 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 14:39:28 +0000
Date:   Wed, 4 Jan 2023 15:39:24 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20230104153924.0b92c52c@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y7WMHl1Mv1alXadG@google.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
        <Y6WX1Y9GZmvxqlCc@google.com>
        <20230102162227.523d2a73@md1za8fc.ad001.siemens.net>
        <20230103212059.5c80fecb@md1za8fc.ad001.siemens.net>
        <Y7WMHl1Mv1alXadG@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DB8PR10MB3832:EE_
X-MS-Office365-Filtering-Correlation-Id: 3374e820-ac1f-41ac-689a-08daee617bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzFOsbc6P/aELWb7ASoV7ijmcz5EzTdba0GeVvRTV1Si6JMqVMPXFqhiZapULWW7+o0/fdQtj41oT5At1+JmOg6ImgNv1FDpuNku2DIUbIHHAfmtHhILDaum7S1JE8JlnQq5Yffk7k2AzlI9x/VQyo0oK0Tb1B/0pj0BhIx14scGi7lsipl9qyeOgL62C26QAGOh5BWTxEyZNdOhjcuTPGimhn2elmQU/34QSjWO9/kiUaNyED6zueXzsudpN52Xs2HKqokrA4OQdMBkYm/S6dCSrYiWJ3YPLmjECpBejddp//KkMTavYrsEZ+u+/R2/KL551A+Zfe+4xpNgdU+wz+bvnQG+7NaDeRsnUl+D8kJgtgXetwFjW0V5ADe6QFwo0tzH35NksOVMEnhoTM6+8qLXAW2MJzPpMXz5rdncHfHnG7letWBq65JYKy0gpEavvwTpEWjEFVrZmyd6rXg01tE30jUM/l3HcT3zdybgI7bmTdpWVWcVp0LBJ3wI27/Z/JcHSoUYKwZlyxOtI5Fw1DWG7bmJNvceJbn/0jn3Ts/R3esLsikAYTwEpPINxzOwCIx0gfvpho9NPm/4ydvDU901t9D8sR3zqL1zplGJN2DNUx2Bws+s4zb8z2aQnuTVySkIUXVowzHPzl2zk8Y6Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(5660300002)(2906002)(44832011)(4326008)(8676002)(8936002)(41300700001)(66899015)(316002)(6916009)(66946007)(66556008)(66476007)(54906003)(6486002)(478600001)(6512007)(186003)(26005)(9686003)(6506007)(6666004)(83380400001)(38100700002)(1076003)(82960400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWtGYTRLSExPZldubEowT2NHTk5wMXZXaHdKZVVENWhZa1pYQ3FmcTluYXhs?=
 =?utf-8?B?YjN4ZDFaRGRONE5MdHFubVNwQ09haEQ5dERud3BQTUhmbnEveXZBaENid0d3?=
 =?utf-8?B?dm1YZVJWTVlRci9tWmVjaGJ0RXpkeVZPWlpUNnNYYlhOaEN5bmY2MklqQjhK?=
 =?utf-8?B?TVVEYlV3cU1PQkpZTXBuTWtVcWFhRnlXUGw2N2EvWlUrUnhNL0JHN0JPLzNO?=
 =?utf-8?B?dHRVTTg2MW1kSGx6Um9SWFdzM1dyVWg1VEo0VW9zUElja01mNUkrYi9McXdq?=
 =?utf-8?B?UGhOYjRoODFXeUw0TmtZOWFiRVpIZDFlTXhmL3kvTkdoZ1diNzdGVGd0bTJQ?=
 =?utf-8?B?d1Z6dFdRaUVaKzh5UFB2aUQzZUVJcXpUL3FXSzY0ZGVPMkJVQXc4dUlEbFZI?=
 =?utf-8?B?TG1VVCtFSWtmdUVXSGhYbEowMFJVejUveU9zUEM0eVJqU2Z5Mmc1NjVlSk93?=
 =?utf-8?B?UExZYVpRUm9pSEdlYWQ4RitxOFE0UXhxNWc1bXYwMkdPVGgwMWhtdk56UmFF?=
 =?utf-8?B?WFF1K3RzS0NGNTBINy90bkMrbXY0dE9KdUR1RjRtMjVWWWtrRHZTTFJ1Qnkw?=
 =?utf-8?B?NisyRkF5MFp3QlZjNEp6ZENmZjFRZUJ2YUpTRFA1R0R6N2taeVRuZDVoM3FV?=
 =?utf-8?B?WEt4WHFmL3cza0VsU1hxVDVMc2pJV044cWUzOXJ5M08xWkVKeW5NQVJ2VEpx?=
 =?utf-8?B?enBZUnNGczMwcjFDTTdWNDUvUXpwQndlTHBzTDlGdUFaZUdabllMR0JxejlH?=
 =?utf-8?B?U2xUaEszVmxCUm54T3VSTDBaQ2UzRmdrY0VHWmtKTHNMVXV6aVJuWE5YSHRE?=
 =?utf-8?B?K0VGTXIvTStuUVczTXNnenQ1NmVPRzZBQk02c2JjY24xUE9FOXl6aG1hYlZt?=
 =?utf-8?B?WnM5R2ViNlBZUVdVOTc2Mm90aE8vL0RuNmhuT2YwOTFqMlNIY3pWejYyeEh6?=
 =?utf-8?B?RWgvNHFqa04zRHIvZnAxVHJkK0kvdTRza3ZVU2pQV3QzMWpCVkVNVmd1bHlL?=
 =?utf-8?B?S0hTdUxZblhRYXErQnVMbVQ4ZXd4RnpDOVI3ZlpHTjZ2bXJKbUdqa3NwbG9P?=
 =?utf-8?B?VDVyVWE3RXkwSml3Vk9DenB5TWtyUTZ1ZU84eHpZYVIvWEJPa2ZRczE3R0tq?=
 =?utf-8?B?dmpKd0MzUkc0ekk4clNZako3a080dWxqMnlBWU4xRXdHek8xOUdvMXIyOFBH?=
 =?utf-8?B?b2s2SUZ2VkdFOEN5WEx0cXF5V2F0MllDL2F2Z1lXOGNsRWpYK0VKbmdoZkwy?=
 =?utf-8?B?ZHhvTE1wVUgyNlp1dWxjUjNvNld4K1UxcWZnOEJmanNKa0RKZHlLREtDdk9L?=
 =?utf-8?B?cjYraFZ2TWl6WVJKVkRzRnpSU3lFMTFvZWd4Q0l5OEtEb25OczlSQWEwNUhT?=
 =?utf-8?B?VXpQMXQwWGpJaEhpOHRRbGFtMzVZZTRjRDJzeWdUVnI5SWZaZjloaTVTb3lR?=
 =?utf-8?B?b283YXYyc2lNcDhYTXJvSmU2dG5STWxKNjYwcTZtQXJCaWRhQ1lTTDd0YktU?=
 =?utf-8?B?T2grclg3VHhiWUViME5vNDdoR2NtSFYwMlo4Rk9hZHhMSDNuVHdQWDZMczQ2?=
 =?utf-8?B?VDlNcVk5UHFaTlY3eWxvRmxicUJiYmJyaHlJWVNaalF6VFNIZjJ2TnpxNGRy?=
 =?utf-8?B?U21GcW0vVHlqRCtzUWdsLzIxWHdPKzIwVDBpVTlyMDdEQzR4V2t0WnBhYjl6?=
 =?utf-8?B?d3J0Uk9XdEZzNjlpSHVUQnJpVUNHK1BxK2pKMXNoNFJGbktydzBlc01sdTNK?=
 =?utf-8?B?enJwdjBOSXdBck41eVlMaW9BcWRMWUlnTGFrQWdwZ1VzRlhiV3JvVFU2WUVm?=
 =?utf-8?B?aCsrTEMxWm5FRzRYSDJJRFNiZ1FPcU45R2VFSEFZaThSZEEvMVlrTEZOb0F0?=
 =?utf-8?B?QlhaYWg3amh5WjZ2azZMdDA4Q0hrSUdRMHJudE1kMmtnZVFkd1hRMVo4aW42?=
 =?utf-8?B?ejBQaG4wNkk2Q0djRVpTdzhKZ3hGV2NidDdWd0MzTUJUV00xbDU1SzJEVFhx?=
 =?utf-8?B?SjhhbjRRb3d4dDRTQmU0WXhwK3JlK0tHQ0srWU0wNXYyU2I0TGRUb2R0TnRP?=
 =?utf-8?B?aXdkdy93TG9oaTVjVmpVMEVGbGoraXBCQlBsT0w5Mmx3L25FWmhqbHVmRTFi?=
 =?utf-8?B?bWdHV2oxYTZMNTQvR2hVZEZTdncyeXU1SWhQVXhJVnNjeS9GY3JPYURVUGM3?=
 =?utf-8?Q?wYgP0jxe+GrZQeAEh0iWCMA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3374e820-ac1f-41ac-689a-08daee617bc0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 14:39:28.3198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A9M+/NxXsZ5/RmXyMx4bDVr138sEE9gynktlTrytL6UNq9L0emTcdsqxQ/Sbcb8hd03M8mEXsJuIiPcgRc5HiBTfYnCW6p9g5Z8sFTaRwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 4 Jan 2023 14:24:30 +0000
schrieb Lee Jones <lee@kernel.org>:

> On Tue, 03 Jan 2023, Henning Schild wrote:
>=20
> > Am Mon, 2 Jan 2023 16:22:27 +0100
> > schrieb Henning Schild <henning.schild@siemens.com>:
> >  =20
> > > Am Fri, 23 Dec 2022 11:58:13 +0000
> > > schrieb Lee Jones <lee@kernel.org>:
> > >  =20
> > > > On Fri, 07 Oct 2022, Henning Schild wrote:
> > > >    =20
> > > > > If we register a "leds-gpio" platform device for GPIO pins
> > > > > that do not exist we get a -EPROBE_DEFER and the probe will
> > > > > be tried again later. If there is no driver to provide that
> > > > > pin we will poll forever and also create a lot of log
> > > > > messages.
> > > > >=20
> > > > > So check if that GPIO driver is configured, if so it will
> > > > > come up eventually. If not, we exit our probe function early
> > > > > and do not even bother registering the "leds-gpio". This
> > > > > method was chosen over "Kconfig depends" since this way we
> > > > > can add support for more devices and GPIO backends more
> > > > > easily without "depends":ing on all GPIO backends.
> > > > >=20
> > > > > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO
> > > > > version of Siemens driver") Reviewed-by: Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > > > > <henning.schild@siemens.com> ---     =20
> > > >=20
> > > > What happened in versions 1 through 3?  Please provide a
> > > > change-log.   =20
> > >=20
> > > Not too much really, but i will write a changelog and cover letter
> > > when sending again. Mostly commit message stuff and later a
> > > rebase. =20
> >=20
> > Lee please let me know if you insist on that changelog, in which
> > case i would send that same patch again with a cover-letter that
> > will carry a not too spectacular changelog.
> >=20
> > Or get back on the rest of what i wrote earlier, maybe we need
> > another version of the patch and not just the same one again with
> > only a changelog added. =20
>=20
> The change-log is not the issue, and you don't need to provide a
> cover-letter for a single-patch set.
>=20
> The issue is that this 'solution' is a hack, built on a hack, built
> on a hack.  There shouldn't be a requirement to check Kconfig options
> from this driver.  In an ideal world the thread handling the
> -EPROBE_DEFER would not create spurious logs to trouble anyone.  What
> is it that's writing those logs?  A User or Kernel Space thread?
> Dependencies are almost universally controlled with Kconfig
> 'depends', which is how this problem should really be solved.
>=20
> Taking into consideration the large backlog (nearly 100) of reviews I
> need to do and the fact that there is already a precedent for this
> behaviour inside this file, I'm tempted to apply it; however, I shall
> not be doing so without giving myself (and others) a little more time
> to think it over.

Ok.

For the future we can see how to improve on all that. The simplest
would be to have that driver depend on all possible gpio providers.
Would not allow to build super minimal kernels in case one wanted the
smallest possible ... but will be easy to maintain and not cause a
jungle of driver config switches.

As we speak i already have the third box to eventually support, which
will likely be similar but this time around with PINCTRL_ELKHARTLAKE

If that "depending on all" sounds like a plan, i can send that instead
of what we discuss here. But i prefer to keep that for the future, i
will be back with more patches anyhow.

Henning

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> =20

