Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA1706403
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjEQJWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjEQJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:22:08 -0400
X-Greylist: delayed 74 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 02:22:02 PDT
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1969240DE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1684315320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDYPw34Kj49AIqJeQ82kevzLLePrQ5tWGk8sPMmQJi0=;
        b=AIdnXtNkL02PCeXPeAFHguPmberBb7R6eq47iwVRsWiTfhTJaTw185xUnoE4DIqTiMhYZA
        gmrRsxzKdGW36ZUGaA2EbkYVVXujpqYEwZQEfuolwvibJ4hg+86GxPw5jheBVyRnZ8+DK1
        nvUaz/Duh0oNqW8SbmB69dYWPePzcxk=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2055.outbound.protection.outlook.com [104.47.21.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-116-WvHBbwjDNJqVFu7_b8_c3w-1; Wed, 17 May 2023 10:20:34 +0100
X-MC-Unique: WvHBbwjDNJqVFu7_b8_c3w-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LO6P123MB6630.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 09:20:33 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 09:20:32 +0000
Message-ID: <35a79a3d-1fc6-5f18-fc11-2cee3c1da148@camlingroup.com>
Date:   Wed, 17 May 2023 11:18:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] Revert "sc16is7xx: Separate GPIOs from modem control
 lines"
To:     Hugo Villeneuve <hugo@hugovil.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Drobi=c5=84ski?= 
        <krzysztof.drobinski@camlingroup.com>
References: <20230515160206.2801991-1-hugo@hugovil.com>
 <2023051551-quickstep-outshine-5526@gregkh>
 <20230515125155.bf6d64c292ba96f4f6971ac0@hugovil.com>
 <a27271d5-6d28-d994-b06f-905eea0514aa@camlingroup.com>
 <20230516115906.9d93685696ae7dc02faff752@hugovil.com>
 <20230516180942.46a51d85746e4246a9a4bba4@hugovil.com>
From:   Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <20230516180942.46a51d85746e4246a9a4bba4@hugovil.com>
X-ClientProxiedBy: FR0P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::12) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LO6P123MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: cf05e58e-887a-439d-d6a8-08db56b7f719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: yYiDNKi1SHvGBmykK8b+vhA+8MmdZOTPNLtFB7jrynkWNo+EjiGHK9ro/2h4rdf7k+VQqFadAcOt5ibh8SB2MNmoDlafS7r2K8VMpo58SNya6EJMFD/0Ga+Ad3Hs4yWY6s4enzZpDn9/4jQDiwqANq11b2o8YuEGKJmNQjMngBT88tamr+q/wFBCiOi+BN0bALabCp8i2IYH9kCevBB33I1mgsrA9cED9pfHLdettcDbw+THMhUP43GKe5mcaoLhPIFFA4qlKRptmyFRA1K4oiauL7g2DmLsR23iGMGuYAUzYavxpLdxuFaAAxUD92hl/DoVnMv+OlByXUS+7gMP6PkhxRtXr7uYdLKW660rZeMWqcg/poSqxORqmgMBYuL73/VZz5uitDiOOW4OYzEu0wPQd665omvKSp5T+neYR6y9nmrbJcFitWqfoPePV/fHAMoC8SHu7jpoVT7/kIXXTu6I4TD/wpPkU7EqTBKndmHg1eu5pjrx5pV8wkgJlJh0CdKxpikwKoHSlO/lC3N73NmdZ6pQGEQmlaW7o7jtJ9AwiWF5KSevks2BwjeNeDlhDB/i9RhrIuE5zNFahKIqvmFPRGySqWivQi3CXiSRc3UWOt1tlBxXClrEZXmgm7N+M1e7TNca0FNRyogpnRi91Eh0f7ZqaOqHVx11b/SaVv2jtZ8mLiRVbqyXV9rQFlyg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(39850400004)(346002)(451199021)(31696002)(6506007)(6512007)(186003)(2906002)(86362001)(107886003)(26005)(83380400001)(2616005)(36756003)(38100700002)(6666004)(41300700001)(6486002)(6916009)(66946007)(66476007)(66556008)(316002)(4326008)(966005)(54906003)(31686004)(478600001)(44832011)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0EhVN281Wt7rK+4yKcwhKTQ+yZK/9alZUSihGuT1jkCm5IR54i6lKT8JkqwN?=
 =?us-ascii?Q?2+DMRV59xMQfWGgwKy9T/kEOO8fMcy4c2IgA8SlZ3tLxtcCnM1K82xTZ0NYa?=
 =?us-ascii?Q?yHd1PiyVCwb0POE9rBL+y6fSuSThGLMAP6ipxQYX9ySG4Opbl5Ypix5SvPwd?=
 =?us-ascii?Q?TK36n+mxVdBRyMUcFI0Dx7ADSIXMxHXXGqkl/M7h4znCC6bkjdu6ece8jzKF?=
 =?us-ascii?Q?pQcn6MQX93URxtz1AIc+3AiaXrtvRxpHvU2XoxAbq/HNLGniJFXi+xkErB5S?=
 =?us-ascii?Q?EhcQYG4pF+4U5cLmrNqqZ/DDwYth0OLxJZCGo6Aqjd7C81KKgm2t/hYNRBcm?=
 =?us-ascii?Q?lffQ42R5nrsieky4Qj9sz91uT7z1u1NNLp++Hdo44ASS52e3jLTyNAQaZS6T?=
 =?us-ascii?Q?jtXL77TTXAZifbvhYE0ZCnrYG0/7H3OoU2lqDT6rZ8IdpDqF3amAlRDIPBMh?=
 =?us-ascii?Q?cNNTmCnTKop25OnmCsSMNYX6K3dahvK1ssMvId3J+R0UIL/KngjBPuRoo9xp?=
 =?us-ascii?Q?dIh7EZQlQ7PWMDBOe9v0Eg/ldKxJOHjDyKq8i1csNnMruj4t3lWw+OIgGHRh?=
 =?us-ascii?Q?jidqkx9KBGorOEOHAKfofVmt9LScUhE+XdT33VygMVF597XTWyzvz4LVoWok?=
 =?us-ascii?Q?iS4kwZXBlAyGl10L1WhRJcWmWXnC3SJbJ4H0umAUeNT83YCUOUcBcRXMZgFE?=
 =?us-ascii?Q?IGcDucC6TMHbIaqJ0Q0/JMtUHQFPu82/RpPlAHa95tnKzRbZ4d0dXDa7sYsE?=
 =?us-ascii?Q?H7oWafCH34TVVrt6H5u/OrAUbyfXdHbnE5iRqYmynmo54OeY25VgeyFUkbFi?=
 =?us-ascii?Q?BwO7y5rIO+XvcVOUp+hxXSZhKaeKP4XY8S+usCdaTKkp3S4UqpMbc1NjBnDZ?=
 =?us-ascii?Q?69VQEMChOXQ+t58uDiYwvWwjr9wquvIr2t+zoEf+OdxWQMJYhP2VgnIqziE4?=
 =?us-ascii?Q?Rf2CDSVxu2zAR5JvTC6xbSdUkAtMixeV3rZBp5SHoYtiTwFHWMM8YqE/mBOh?=
 =?us-ascii?Q?VueNXA1UAtxWWnuklFBfbFWqjm17RFUZ/ISqdsZbWZ/Yl+GsrvJbK4bj5tJe?=
 =?us-ascii?Q?ez31aGt5P9K6Tac/OJ0ZFCnEVg9PVsR+w5sMaGTgiDg9CkIpQMQ6mLixW/42?=
 =?us-ascii?Q?6PsC6zT49XbFewELies1Tac6gKOcyPA1EcAco0ZZCZbcW1BZy5JovetqSJRo?=
 =?us-ascii?Q?cSlznjpqm29/3jQ1ZxgsMWnQ67Gstpv/ilSkd+CU2/gwM5pPul6i/4skJ8ie?=
 =?us-ascii?Q?ojmtv9dOBQcTqcULlo3swkDzP72qH6odB0uE/jevNKxcMLzCswoL/Mk5/wGC?=
 =?us-ascii?Q?SLqiBjBD6NWVNmG5GFATg8EysmRlB8lPZGcRH+ssA+6O82ObjjAK9+7ZUMQP?=
 =?us-ascii?Q?iesEi6uUTu/+lVs2d8JIoDSLTeTvoRdvyFv46L2dTJJ+tNS91Ak1zCaxVab2?=
 =?us-ascii?Q?bFmQaoxijiTNxNqyMmDaiKVwo5CqcewCjapIb0v3tzrsWMWyqTAG/Yn6FomF?=
 =?us-ascii?Q?fDjFe4Q9PBOwQTyA+wfQ67f+7cE8DD46Q9VOBWW9yTonQJsaEY96O84mgpad?=
 =?us-ascii?Q?3jLGk9/CCfKLeq+nNL0H5k5cP8maMf46JkdBMb76xyfgLslZUb2Ebm6Mnv1b?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf05e58e-887a-439d-d6a8-08db56b7f719
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 09:20:32.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: os+BPngnoM5t/Z9uneULAi/n3m6asYr/QA78yhUtK5zhqhrIqhdhSYqijyb7mygPA9/ek6Nxi5kYJddZjy/A2yNSDbysAIvF/NCUI9eZKWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6630
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


W dniu 17.05.2023 o=C2=A000:09, Hugo Villeneuve pisze:
> On Tue, 16 May 2023 11:59:06 -0400
> Hugo Villeneuve <hugo@hugovil.com> wrote:
>
> > On Tue, 16 May 2023 10:50:11 +0200
> > Lech Perczak <lech.perczak@camlingroup.com> wrote:
> >
> > > Hi Hugo,
> > >
> > > Please see my answers inline.
> > >
> > > W dniu 15.05.2023 o=C2=A018:51, Hugo Villeneuve pisze:
> > > > Hi Greg,
> > > >
> > > > On Mon, 15 May 2023 18:20:02 +0200
> > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > >
> > > >> On Mon, May 15, 2023 at 12:02:07PM -0400, Hugo Villeneuve wrote:
> > > >>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > >>>
> > > >>> This reverts commit 679875d1d8802669590ef4d69b0e7d13207ebd61.
> > > >>>
> > > >>> Because of this commit, it is no longer possible to use the 16 GP=
IO
> > > >>> lines as dedicated GPIOs on the SC16IS752.
> > > >>>
> > > >>> Reverting it makes it work again.
> > > >>>
> > > >>> The log message of the original commit states:
> > > >>> "Export only the GPIOs that are not shared with hardware modem
> > > >>> control lines"
> > > >>>
> > > >>> But there is no explanation as to why this decision was taken to
> > > >>> permanently set the function of the GPIO lines as modem control
> > > >>> lines. AFAIK, there is no problem with using these lines as GPIO =
or modem
> > > >>> control lines.
> > > >>>
> > > >>> Maybe after reverting this commit, we could define a new
> > > >>> device-tree property named, for example,
> > > >>> "use-modem-control-lines", so that both options can be supported.
> > > >>>
> > > >>> Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem contro=
l
> > > >>> lines")
> > > >> Please do not line-wrap these lines.
> > > > Ok.
> > > >
> > > >> Nor is a blank line needed here.
> > > > Ok.
> > > >
> > > >>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > >>> ---
> > > >>> drivers/tty/serial/sc16is7xx.c | 14 ++++----------
> > > >>> 1 file changed, 4 insertions(+), 10 deletions(-)
> > > >>>
> > > >>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/=
sc16is7xx.c
> > > >>> index 5bd98e4316f5..25f1b2f6ec51 100644
> > > >>> --- a/drivers/tty/serial/sc16is7xx.c
> > > >>> +++ b/drivers/tty/serial/sc16is7xx.c
> > > >>> @@ -306,7 +306,6 @@ struct sc16is7xx_devtype {
> > > >>> char name[10];
> > > >>> int nr_gpio;
> > > >>> int nr_uart;
> > > >>> - int has_mctrl;
> > > >>> };
> > > >>>
> > > >>> #define SC16IS7XX_RECONF_MD (1 << 0)
> > > >>> @@ -447,35 +446,30 @@ static const struct sc16is7xx_devtype sc16i=
s74x_devtype =3D {
> > > >>> .name =3D "SC16IS74X",
> > > >>> .nr_gpio =3D 0,
> > > >>> .nr_uart =3D 1,
> > > >>> - .has_mctrl =3D 0,
> > > >>> };
> > > >>>
> > > >>> static const struct sc16is7xx_devtype sc16is750_devtype =3D {
> > > >>> .name =3D "SC16IS750",
> > > >>> - .nr_gpio =3D 4,
> > > >>> + .nr_gpio =3D 8,
> > > >> I think this one line change is all you really need here, right? t=
he
> > > >> otner changes do nothing in this patch, so you should just create =
a new
> > > >> one changing this value. Oh, and this one:
> > > >>
> > > >>> .nr_uart =3D 1,
> > > >>> - .has_mctrl =3D 1,
> > > >>> };
> > > >>>
> > > >>> static const struct sc16is7xx_devtype sc16is752_devtype =3D {
> > > >>> .name =3D "SC16IS752",
> > > >>> - .nr_gpio =3D 0,
> > > >>> + .nr_gpio =3D 8,
> > > >> right?
> > > >>
> > > >> Don't mess with the has_mctrl stuff, that's not relevant here.
> > > > Sorry, I just noticed that simply reverting commit 679875d1d880 is =
not sufficient (and will not compile). We must also revert part of commit:
> > > > 21144bab4f11 ("sc16is7xx: Handle modem status lines").
> > > >
> > > > The problem is that the commit 679875d1d880 was incomplete, and it =
was (unfortunately) completed by integrating it in commit 21144bab4f11 ("sc=
16is7xx: Handle modem status lines"). The relevant change was only these 5 =
new lines, burried deeply into the second commit:
> > > Just as you noticed, this was required to support full set of flow co=
ntrol lines on this device.
> > > The commit you're trying to revert was a preparation for it. Disablin=
g has_mctrl will break it.
> > > I kindly suggest to suggest a fix, instead of hurrying a revert, and =
waiting for a proper fix later.
> >
> > Hi Lech,
> > the [RFC] in the subject was there to discuss about a possible revert, =
and/or maybe a possible fix that would allow both modes to be supported. I =
am not hurrying anything and I am certainly not waiting for a later fix, as=
 I very much want to help and maybe submit such a fix myself.
> >
> > But the reality is that commits 679875d1d880/21144bab4f11 broke userspa=
ce by forcing GPIOs as modem control lines. I understand that reverting the=
se patches could also potentially break things for applications depending o=
n these patches. I am simply wondering what is the proper course of action =
here: revert patches and work on a fix to support both modes, or skip rever=
t and work on a fix (my preference)?
> >
> > > > @@ -1353,9 +1452,17 @@ static int sc16is7xx_probe(struct device *de=
v,
> > > > sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFCR_REG,
> > > > SC16IS7XX_EFCR_RXDISABLE_BIT |
> > > > SC16IS7XX_EFCR_TXDISABLE_BIT);
> > > > +
> > > > + /* Use GPIO lines as modem status registers */
> > > > + if (devtype->has_mctrl)
> > > > + sc16is7xx_port_write(&s->p[i].port,
> > > > + SC16IS7XX_IOCONTROL_REG,
> > > > + SC16IS7XX_IOCONTROL_MODEM_BIT);
> > > > +
> > > >
> > > > Therefore, I should also remove these lines if we go forward with a=
 revert of the patch (should I add another tag "Fixes..." in that case?).
> > > >
> > > > And what do you think of my proposal to maybe replace has_mctrl wit=
h a device tree property so that both modes can be fully supported?
> > > I think the proper solution here, is not to invent a new device tree =
property for every single use case.
> > > I would start by looking for other drivers, if, and how they handle s=
imilar cases.
> > > For example, imx-serial driver respects "uart-has-rtscts" property, a=
s do a lot of other controllers built into SoC-s.
> > > On the other hand, other devices which can also provide GPIOs, respec=
t "gpio-controller" property.
> >
> > I think that testing the presence of the "uart-has-rtscts" to force GPI=
Os as modem control lines would make a lot of sense.
> >
> > > According to SC16IS752 datasheet [1], respecting one of those should =
be enough,
> > > as GPIOs can be enabled in groups of four pins even for dual UART ver=
sion.
> > > Every group matches a single port, so probably this can be probably s=
elected per UART even on dual-port versions.
> >
> > I am trying to see how we could set "uart-has-rtscts" for only UART cha=
nnel A or B in the device tree, but cannot find any example or documentatio=
n about that. How do you propose to do it?
> >
> > From what I understand, the property "uart-has-rtscts" can be set only =
for the whole chip (channels A and B)...
>
> After some analysis, I don't think that we should be using the property "=
uart-has-rtscts". For our chip, this doesn't make sense because RTS/CTS are=
 dedicated pins. also, like I said, this property applies to the whole chip=
/device, not to indivual A or B channels (like sc16is752).

Hi Hugo,

That's correct, my idea was to analyze what is available and pick the best =
one, if at all possible.
"gpio-controller" could also be used - in theory - but it isn't a great cho=
ice either, because it doesn't allow us to specify, which pin groups should=
 be used as GPIOs.
>
> The way to go would be to define a new DT property similar to "irda-mode-=
ports" (for the same sc16is7xx driver). Defining a new property named "mode=
m-control-line-ports" would allow us to specify an array that lists the ind=
ices of the port that should have shared GPIO lines configured as modem con=
trol lines.
>
> I already implemented that as a proof of concept and it works great.

There is nothing wrong per se in adding new device tree property, I'd just =
like to avoid jumping the gun in inventing one.
After quickly reviewing documentation of available bindings I see that it's=
 most likely unavoidable.
The "modem-control-line-ports" proposal with a mask of ports sounds very re=
asonable - please share your PoC,
it will be easier to discuss having a concrete example.

The general approach I noticed in other places (for example, the WF8960 aud=
io codec) is setting a register value directly.
This would allow us to control the IOLATCH bit in IOControl register, to ma=
ke inputs register behave as interrupt flag register,
but I think that if we ever need it, it would be cleaner to set it with a s=
eparate boolean property - I'm in favor of modem-control-line-ports.

I think it would be a good idea to include DT and GPIO maintainers and mail=
ing lists as well.
Especially the DT maintainers - they would like to see this property docume=
nted. They however, are not concerned with the code changes themselves.

BTW, the commit split between adding has_mctrl property and the rest of imp=
lementation warrants some explanation - this was based on my previous patch=
es,
which Tomasz reworked and submitted. The split was kept to split up the cha=
nges to minimal, logical chunks, and to maintain correct authorship of the =
changes.

With kind regards,
Lech
>
> Hugo.
>
>
> > > I'll be more than happy to assist with that.
> > >
> > > >
> > > > Thank you,
> > > > Hugo.
> > > >
> > > [1] https://www.nxp.com/docs/en/data-sheet/SC16IS752_SC16IS762.pdf <h=
ttps://www.nxp.com/docs/en/data-sheet/SC16IS752_SC16IS762.pdf>
> > >
> > > --
> > > Pozdrawiam/With kind regards,
> > > Lech Perczak
> > >
> > > Sr. Software Engineer
> > > Camlin Technologies Poland Limited Sp. z o.o.
> > > Strzegomska 54,
> > > 53-611 Wroclaw
> > > Tel: (+48) 71 75 000 16
> > > Email: lech.perczak@camlingroup.com
> > > Website: http://www.camlingroup.com <http://www.camlingroup.com>
> > >
> > >
> >
> >
> > --
> > Hugo Villeneuve
> >
>
>
> --=20
> Hugo Villeneuve

