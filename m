Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3813A70482E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjEPIvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjEPIvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:51:37 -0400
X-Greylist: delayed 67 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 01:51:36 PDT
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0EB421D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1684227094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UfrwO3I7Wntgx4Yq1x3zHJdd64znZ5MwlGsGgBB2mMg=;
        b=iX0yMSeXHNYE33rtUXhHX983TOQ1mv9cAQauTtoiEsANBDf9gX2A9yRBhVUuWLX2rdrmnb
        5BPUHLCBa9Au0/Z2ZUCorbJTFq9PP2haLgOlrZb2W/4xBowTzQEaVSCCSjasDMHajDhjan
        NLMnDAaayQxthZPyHstUK7OxhY6CmDo=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2059.outbound.protection.outlook.com [104.47.20.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-229-QQvvDjvIMjibtnlqK_cf7g-1; Tue, 16 May 2023 09:50:15 +0100
X-MC-Unique: QQvvDjvIMjibtnlqK_cf7g-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWXP123MB3064.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Tue, 16 May
 2023 08:50:14 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f%7]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 08:50:14 +0000
Message-ID: <a27271d5-6d28-d994-b06f-905eea0514aa@camlingroup.com>
Date:   Tue, 16 May 2023 10:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] Revert "sc16is7xx: Separate GPIOs from modem control
 lines"
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Drobi=c5=84ski?= 
        <krzysztof.drobinski@camlingroup.com>
References: <20230515160206.2801991-1-hugo@hugovil.com>
 <2023051551-quickstep-outshine-5526@gregkh>
 <20230515125155.bf6d64c292ba96f4f6971ac0@hugovil.com>
From:   Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <20230515125155.bf6d64c292ba96f4f6971ac0@hugovil.com>
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWXP123MB3064:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9c4c15-8c17-47e9-a175-08db55ea9095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: FHXsjIwmJcqoZqVE7k76MM9Dmlm2RjBAOVX1uTyaNSaelgiNhQu2gf8ehsXonnFNaU2uSGu12D1TruA4TgIGgm2zWg5/z6Dxruz6Q1viAPiXSeOKj7tDqsW/PTTbhAuU15xXcAzfxhY2RX0nrDm8YP7sEiLZ7rey5q4idCPgDueDidmRLFzfwE8stiDUOoMXBdC1kq4GCX5pU0tH5YuxgusRYjmw3uFNZyb+PgJLWOak9WiuuRRQ8Tj3DUBadwyjA8FlOolNU9fwcCR3eqQ7c6PWqcHvkFhHxUIvV2nw+1oA4ssBKdniXaj4lkk6YHTowpZfg0/NklvCA5L0XA4DWE3bndKu2HWYOMNxd3arGH9Rl2ZVJuRx0/zIEYON8XjjgsZYsYvUBz+FmWQRASFPHj5XYuQtSTiBWnwcsxwPA18Imy1b9YRFfIFobBDPZNgFVR7WEfQ/3JiTY2kNsfWTxsyXJMGSTgRaIhrsbbf9DSKphS3Ci6s8YNLYhtaiExMZ0vy7hWrAR2mDe9ySUPSYq37xirXUqcZmgNY5H+k7Z56IXQUdnS05XpU3a+Afu4qIHC+z1AnoeZqMjH7LoXVNW9COy7SxpKDQw3BpOwfyr8rkHE/dvqLXSPb+B7jd2gFw/tsPoB0KePQ1eUXa+x9mm3vqWwdBzj7boG+2U6n22uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(39850400004)(346002)(396003)(136003)(366004)(451199021)(2906002)(41300700001)(316002)(54906003)(478600001)(44832011)(110136005)(6666004)(6486002)(8676002)(31686004)(66946007)(8936002)(66556008)(66476007)(4326008)(5660300002)(966005)(6506007)(6512007)(107886003)(26005)(186003)(83380400001)(36756003)(2616005)(86362001)(38100700002)(31696002)(43740500002)(45980500001)(18886065003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R6RHyZjOEzLaKNSBSfRyIHQ5qYUtoDqqJ7QiYmbAUyuHyUuVcpv9h69pqYwA?=
 =?us-ascii?Q?6RaJfHKLrMv1WfS9Wreg0nJTLLUI6fSBv840l+Gw78xCcRCLyDKFhcStsQrZ?=
 =?us-ascii?Q?J7StZjUtD9Uu5PXljNY1TS9GAvGDhFEA26S4t4vzdM9wGt5ErtEERhpXuvO3?=
 =?us-ascii?Q?7LGCEIpN5SSB9Jrv9p436/WKDOXtME2Xv8Qtb09v6M0PUQEKMFb5922HKIZH?=
 =?us-ascii?Q?DuXqvttB0TIXeDh0IPZc1e1DejZ/rOr/IiwTvHJ8IlIlc03EDLLNIo9S0NMI?=
 =?us-ascii?Q?6uKKWNacEAHk1rFJvfe0gH3QAIzzvkN1izvs4IjqIsa+N3ZRsbTPNlpe60SV?=
 =?us-ascii?Q?AB2gQiIO84EvEPHpwxfrhgH6DxSJ5DEdLamMrIQ/eDI/RafoBzdBlLqqiAYW?=
 =?us-ascii?Q?pCmgjKrYqSucG5GC+5HDX76uFhNQwIFxW0RycN0qrKu7iw5aHEaYFIMgCF2n?=
 =?us-ascii?Q?gU5ld8vOxo3tUthRSqdrEu5GR3ruSPe7If0lnVhb8SYjKwkOZYA+SaJMjlX2?=
 =?us-ascii?Q?ZHs5hhbSOA6XUdjCmD3nPQKtdrjJ0dVOt94BhF+aNbQVSCfvpZXQLzuPlQHR?=
 =?us-ascii?Q?AAmGAc72N7vGRr7jOE3DPi/YgvUyCce77JYocZgtwg7IbGCroaxJaDDolxzF?=
 =?us-ascii?Q?lDGLzg96PUFqBhPrw66AQUTFds0iteWRKanaHgwBz7nuNvPkdMTmMHcknc2v?=
 =?us-ascii?Q?m7aQwL0kLc8iWII0NFVna2AUyQK9DWR3O0nOebcS4A2laoQt6BGi30i5yPQV?=
 =?us-ascii?Q?8Mpt9efXMPhnPfz1p2ML1QiT6ItzBKZ4lQMNfE98AGSpdoR9cfjzB2BAI7Ii?=
 =?us-ascii?Q?H2S6KUQ1X7AKQqfPwTjcdbEKY9x90RUKYnWKBJujdAtfm3ELA5aoayMFd+dG?=
 =?us-ascii?Q?P2y/pS5tL/xps8UyJr0tnG7hW9PlnG3xXs2o2gmPky+eMuzHR3BLVkW0dNhG?=
 =?us-ascii?Q?Meuuu7jvMlhH3z9s3BIVZPh3tUyj2cROhlw5dJWGjhpAfbJ2ngsQGa03MtzR?=
 =?us-ascii?Q?fzxbiNcL/4bwoby7sfSNFqo0v1K/GO6LbwGYkMriIA+PnboB/Emkas86/LbF?=
 =?us-ascii?Q?uZC+ujcvZN7Lq4Vbu7h8i0UzfQupxcb724numJCGc/fO68Ihntm37+f5kx9c?=
 =?us-ascii?Q?o2rsL55ImaEfI7KXi224KMJIGO/ZObgFqNkar1CrTfv2N8D3FGr2fkGRCHKp?=
 =?us-ascii?Q?PKavpNJYKk22fK+RRbKJSslqg5MTVb9HJy4Efy/SGqUrSV7Gewx2NS5cNab0?=
 =?us-ascii?Q?9SNKmydKXc0RZOmsAgEgMnX1MBJqSBhEtn/GDJLxzJBCForFfgNW9vIdVby7?=
 =?us-ascii?Q?1ldVAO03+1EeG/R6lfqwvq7AnLBOKl/29XfbP6nkmVe/pOrSJ0kPY5t7Nz1N?=
 =?us-ascii?Q?YsJRxcrV5Rm4G7TVdSP8ZZjpOonvJMM62xFh6Uozslt/rHsIUBcQywUJkGS0?=
 =?us-ascii?Q?08INaO/PjWaxO8vMDK5ZgnXYNNhuyi7Dm41Nmgj/OVJMPJe/GpUR0AatQGiP?=
 =?us-ascii?Q?0c1rLg+8GWAbL7FWB3gaFJtumGR769DGAl95gXMP3S4H9J3pmso7vPPsUpqa?=
 =?us-ascii?Q?7LHzPD4nqVEgNFJn5XIOOrvCUDa0WRbF4LhJcAtqo5RKUy/4pIrckTxAgFrx?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9c4c15-8c17-47e9-a175-08db55ea9095
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 08:50:14.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEacQMigrSVeGO0d6DLSEjzHhipzSRFIS8iTb8j/26Pik2wveyEtBg0hogmM1vAWZ5qfuJ8zTZupr419leNGxc6f99UeVe9945rFHQTtFYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3064
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

Please see my answers inline.

W dniu 15.05.2023 o=C2=A018:51, Hugo Villeneuve pisze:
> Hi Greg,
>
> On Mon, 15 May 2023 18:20:02 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
>> On Mon, May 15, 2023 at 12:02:07PM -0400, Hugo Villeneuve wrote:
>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>
>>> This reverts commit 679875d1d8802669590ef4d69b0e7d13207ebd61.
>>>
>>> Because of this commit, it is no longer possible to use the 16 GPIO
>>> lines as dedicated GPIOs on the SC16IS752.
>>>
>>> Reverting it makes it work again.
>>>
>>> The log message of the original commit states:
>>>     "Export only the GPIOs that are not shared with hardware modem
>>>     control lines"
>>>
>>> But there is no explanation as to why this decision was taken to
>>> permanently set the function of the GPIO lines as modem control
>>> lines. AFAIK, there is no problem with using these lines as GPIO or mod=
em
>>> control lines.
>>>
>>> Maybe after reverting this commit, we could define a new
>>> device-tree property named, for example,
>>> "use-modem-control-lines", so that both options can be supported.
>>>
>>> Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control
>>> lines")
>> Please do not line-wrap these lines.
> Ok.
>
>> Nor is a blank line needed here.
> Ok.
>
>>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>> ---
>>>  drivers/tty/serial/sc16is7xx.c | 14 ++++----------
>>>  1 file changed, 4 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
>>> index 5bd98e4316f5..25f1b2f6ec51 100644
>>> --- a/drivers/tty/serial/sc16is7xx.c
>>> +++ b/drivers/tty/serial/sc16is7xx.c
>>> @@ -306,7 +306,6 @@ struct sc16is7xx_devtype {
>>>     char    name[10];
>>>     int     nr_gpio;
>>>     int     nr_uart;
>>> -   int     has_mctrl;
>>>  };
>>>
>>>  #define SC16IS7XX_RECONF_MD                (1 << 0)
>>> @@ -447,35 +446,30 @@ static const struct sc16is7xx_devtype sc16is74x_d=
evtype =3D {
>>>     .name           =3D "SC16IS74X",
>>>     .nr_gpio        =3D 0,
>>>     .nr_uart        =3D 1,
>>> -   .has_mctrl      =3D 0,
>>>  };
>>>
>>>  static const struct sc16is7xx_devtype sc16is750_devtype =3D {
>>>     .name           =3D "SC16IS750",
>>> -   .nr_gpio        =3D 4,
>>> +   .nr_gpio        =3D 8,
>> I think this one line change is all you really need here, right?  the
>> otner changes do nothing in this patch, so you should just create a new
>> one changing this value.  Oh, and this one:
>>
>>>     .nr_uart        =3D 1,
>>> -   .has_mctrl      =3D 1,
>>>  };
>>>
>>>  static const struct sc16is7xx_devtype sc16is752_devtype =3D {
>>>     .name           =3D "SC16IS752",
>>> -   .nr_gpio        =3D 0,
>>> +   .nr_gpio        =3D 8,
>> right?
>>
>> Don't mess with the has_mctrl stuff, that's not relevant here.
> Sorry, I just noticed that simply reverting commit 679875d1d880 is not su=
fficient (and will not compile). We must also revert part of commit:
> 21144bab4f11 ("sc16is7xx: Handle modem status lines").
>
> The problem is that the commit 679875d1d880 was incomplete, and it was (u=
nfortunately) completed by integrating it in commit 21144bab4f11 ("sc16is7x=
x: Handle modem status lines"). The relevant change was only these 5 new li=
nes, burried deeply into the second commit:
Just as you noticed, this was required to support full set of flow control =
lines on this device.
The commit you're trying to revert was a preparation for it. Disabling has_=
mctrl will break it.
I kindly suggest to suggest a fix, instead of hurrying a revert, and waitin=
g for a proper fix later.
>
> @@ -1353,9 +1452,17 @@ static int sc16is7xx_probe(struct device *dev,
>                 sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFCR_REG,
>                                      SC16IS7XX_EFCR_RXDISABLE_BIT |
>                                      SC16IS7XX_EFCR_TXDISABLE_BIT);
> +
> +               /* Use GPIO lines as modem status registers */
> +               if (devtype->has_mctrl)
> +                       sc16is7xx_port_write(&s->p[i].port,
> +                                            SC16IS7XX_IOCONTROL_REG,
> +                                            SC16IS7XX_IOCONTROL_MODEM_BI=
T);
> +
>
> Therefore, I should also remove these lines if we go forward with a rever=
t of the patch (should I add another tag "Fixes..." in that case?).
>
> And what do you think of my proposal to maybe replace has_mctrl with a de=
vice tree property so that both modes can be fully supported?
I think the proper solution here, is not to invent a new device tree proper=
ty for every single use case.
I would start by looking for other drivers, if, and how they handle similar=
 cases.
For example, imx-serial driver respects "uart-has-rtscts" property, as do a=
 lot of other controllers built into SoC-s.
On the other hand, other devices which can also provide GPIOs, respect "gpi=
o-controller" property.

According to SC16IS752 datasheet [1], respecting one of those should be eno=
ugh,
as GPIOs can be enabled in groups of four pins even for dual UART version.
Every group matches a single port, so probably this can be probably selecte=
d per UART even on dual-port versions.

I'll be more than happy to assist with that.

>
> Thank you,
> Hugo.
>
[1] https://www.nxp.com/docs/en/data-sheet/SC16IS752_SC16IS762.pdf

--=20
Pozdrawiam/With kind regards,
Lech Perczak

Sr. Software Engineer
Camlin Technologies Poland Limited Sp. z o.o.
Strzegomska 54,
53-611 Wroclaw
Tel:     (+48) 71 75 000 16
Email:   lech.perczak@camlingroup.com
Website: http://www.camlingroup.com

