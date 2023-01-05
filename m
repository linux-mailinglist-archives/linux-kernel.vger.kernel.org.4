Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F4C65E852
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjAEJzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjAEJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:55:09 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A70574D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:55:01 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230105095457epoutp02d3b517d5378afd306283d63356ea71da~3YQ2FMP9h2652626526epoutp02r
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:54:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230105095457epoutp02d3b517d5378afd306283d63356ea71da~3YQ2FMP9h2652626526epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672912497;
        bh=W+SRy8MGtF/uWSoWNbLUIib5kCtd14JoSOOEgWQDy18=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=l3KOklbKgp3n+SFnu6cRDM337SwDOIpAwOFYV4+iNoLV0z4dhGciyJ1RwPtq5WiE0
         ULTW77dtfKi1Ps60iRnFGsdB8oIJARaiuM1Zuq5d1Uzb+7kFjMO27s+4fHExnIwGBt
         o635bfY/+eAG/ecZQxDwy0m/IfHclYRqLmIc+ofc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230105095456epcas2p16340531e042f370d2aa756b83cdec060~3YQ1hkGO-1593215932epcas2p1O;
        Thu,  5 Jan 2023 09:54:56 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Nnhf81JjLz4x9Pr; Thu,  5 Jan
        2023 09:54:56 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.53.03803.07E96B36; Thu,  5 Jan 2023 18:54:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230105095455epcas2p3a630ad70db8a4782197f97213baddc83~3YQ0hOOJm2873928739epcas2p3s;
        Thu,  5 Jan 2023 09:54:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230105095455epsmtrp1174e9c159ded0a10a8545bf314dce47a~3YQ0gi4GQ1535715357epsmtrp1O;
        Thu,  5 Jan 2023 09:54:55 +0000 (GMT)
X-AuditID: b6c32a45-23ffd70000020edb-ae-63b69e70f074
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.4B.02211.F6E96B36; Thu,  5 Jan 2023 18:54:55 +0900 (KST)
Received: from KORCO118605 (unknown [10.229.18.192]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230105095455epsmtip15434e8f2dd3621cc4b9920327759d604~3YQ0WNK822374523745epsmtip1S;
        Thu,  5 Jan 2023 09:54:55 +0000 (GMT)
From:   =?utf-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>
To:     "'Linyu Yuan'" <quic_linyyuan@quicinc.com>,
        "'Felipe Balbi'" <balbi@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Thinh Nguyen'" <Thinh.Nguyen@synopsys.com>
Cc:     "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        "'open list'" <linux-kernel@vger.kernel.org>,
        "'Seungchull Suh'" <sc.suh@samsung.com>,
        "'Daehwan Jung'" <dh10.jung@samsung.com>
In-Reply-To: <c4e01a0a-1c98-3103-2b91-2fe0ba8c3118@quicinc.com>
Subject: RE: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Date:   Thu, 5 Jan 2023 18:54:55 +0900
Message-ID: <000201d920eb$c3715c50$4a5414f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHoaYWzl+91vPuYA9QqPKuxNdj5mgIxEgVOAi/I+n8Cu+PL3q44GoEQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmhW7BvG3JBvvfslsca3vCbnFnwTQm
        i+bF69ksLu+aw2axaFkrs8W665sYLbru3mC0WLXgALsDh8emVZ1sHvvnrmH3mLinzqNvyypG
        jy37PzN6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8v
        tcTK0MDAyBSoMCE74+g564IzphX7uo4yNTBu0uxi5OSQEDCRmLvsJFMXIxeHkMAORomtV7+w
        gCSEBD4xSjRv9oVIfGOUeL/nEDtMx4Orc9kgEnsZJd71PoVqf8kosfl+J2sXIwcHm4CFxNEZ
        OiANIgK7gIq6vUFqmAUOMUqc/PmCESTBKWAv0d5yiBXEFhbwkFiycDWYzSKgIvG34TbYNl4B
        S4kXzw4wQ9iCEidnPgE7j1lAW2LZwtfMEBcpSOz+dJQVYpmbRMv2LqgaEYnZnW3MIIslBBZy
        SHyYfI0F5DgJAReJDRvjIXqFJV4d3wL1mZTEy/42KDtbYteGN1DzKyR6+pexQNjGErOetTOC
        jGEW0JRYv0sfYqKyxJFbUFv5JDoO/2WHCPNKdLQJQTSqShxsvAk1RFriW+87xgmMSrOQ/DUL
        yV+zkNw/C2HXAkaWVYxiqQXFuempxUYFhvCYTs7P3cQITqdarjsYJ7/9oHeIkYmDERjaHMxK
        Irxl/duShXhTEiurUovy44tKc1KLDzGaAkN6IrOUaHI+MKHnlcQbmlgamJiZGZobmRqYK4nz
        Bm2dnywkkJ5YkpqdmlqQWgTTx8TBKdXAJLR5hevpl7857t6wD5y13UtkyabLG98+v2Eg2lz1
        7OCzGfvOGasGRVv8tFhtYzhtrd8MTXuJrZniameK5G+ohJwTnZlxW/F1vZ6pvLTtvY179W6K
        bM7juDyRX63lW11q36vQmdKrK3Y83rl4c/yPfOHPgS8XRs1iuvVuhuPmFZtjz930mdYetodJ
        qsJkr9XpyKwOQRvjzlU2d9vdXF55xgX96vrK81bLODVqYZmre+nNX/+jHBgjrkVwPtQrDTp4
        b9rr9wwRfPIMXif+TZqRZ6n3KqDtan588OqIdQ9+xdaLb2ZlzIn3l5nHflt067aTwJz8hPfY
        qr3rUyb2sW93mGiewpr3U2LrzoV71RMWKrEUZyQaajEXFScCAI9NpVYwBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTjd/3rZkg0VnFCyOtT1ht7izYBqT
        RfPi9WwWl3fNYbNYtKyV2WLd9U2MFl13bzBarFpwgN2Bw2PTqk42j/1z17B7TNxT59G3ZRWj
        x5b9nxk9Pm+SC2CL4rJJSc3JLEst0rdL4Mq4t2kRa8Es04qzFz4xNjD+0Ohi5OSQEDCReHB1
        LlsXIxeHkMBuRolrva9ZIRLSEjs7pzJB2MIS91uOsEIUPWeUeDjrHVAHBwebgIXE0Rk6IHER
        gT2MErtuPmAHcZgFjjBKHLszA2ySkMBXRomWv+wgNqeAvUR7yyGwuLCAh8SShavBbBYBFYm/
        DbfBangFLCVePDvADGELSpyc+YQFxGYW0JZ4evMpnL1s4WtmiOsUJHZ/Ogo2R0TATaJlexdU
        jYjE7M425gmMwrOQjJqFZNQsJKNmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/
        dxMjOMa0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHesv5tyUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwmZ5aInpVP9Pokn0ef8DXWe4Ls8oZrL4F3vmwed32
        R9O6dhTYZhy7zmPt3HI5/6/F/mu16YsKnIJntSuyb5moKHhvrvjp1vgzMtU8HmY7T9c8Wn9e
        8NautsAYq4iwDY7HxD9dXdv2/WZcyTIhk6/KN9jWPp06e/aUqd19aQfvzDssGHOoI2m69z9V
        xT4Jk2q1OQp/nGvlW1PcZ7pxntx47duhGIYo4RuJD1m/vN51pNKo0WLu4puTbZhmP+bea/ji
        /mVX9qrGG+/27PD9ojCxdfaUJbnei1e4rzteoNuysvfCT14FhTqRkImyvFpMXflOj1S3RnN0
        Hc3Vf1KlUJj+7oEtj3Yzi+NkphyJxfy1SizFGYmGWsxFxYkAN1vcWiADAAA=
X-CMS-MailID: 20230105095455epcas2p3a630ad70db8a4782197f97213baddc83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3
References: <CGME20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3@epcas2p4.samsung.com>
        <20230102050831.105499-1-jh0801.jung@samsung.com>
        <af32e2f5-de45-38af-2b4f-47c1ac21ea9e@quicinc.com>
        <c4e01a0a-1c98-3103-2b91-2fe0ba8c3118@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Linyu Yuan =5Bmailto:quic_linyyuan=40quicinc.com=5D
> Sent: Thursday, January 5, 2023 12:35 PM
> To: JaeHun Jung; Felipe Balbi; Greg Kroah-Hartman; Thinh Nguyen
> Cc: open list:USB XHCI DRIVER; open list; Seungchull Suh; Daehwan Jung
> Subject: Re: =5BPATCH=5D usb: dwc3: Clear DWC3_EVENT_PENDING when count i=
s 0
>=20
>=20
> On 1/5/2023 11:29 AM, Linyu Yuan wrote:
> > On 1/2/2023 1:08 PM, JaeHun Jung wrote:
> >> Sometimes very rarely, The count is 0 and the DWC3 flag is set has
> >> status.
> >> It must not have these status. Because, It can make happen interrupt
> >> storming status.
> >
> > could you help explain without clear the flag, how interrupt storming
> > happen ?
> >
> > as your change didn't touch any hardware register, i don't know how it
> > fix storming.
> >
H/W interrupts are still occur on IP.
But. ISR doesn't handle it. Because of this
=22if (evt->flags & DWC3_EVENT_PENDING)=22

This is event values.
(struct dwc3_event_buffer *) ev_buf =3D 0xFFFFFF883DBF1180 =3D kernel_size_=
le_lo32+0xFFFFFF883B391180 -> (
        (void *) buf =3D 0xFFFFFFC00DBDD000 =3D end+0x337D000 -> ,
        (void *) cache =3D 0xFFFFFF8839F54080 =3D kernel_size_le_lo32+0xFFF=
FFF88376F4080 -> ,
        (unsigned int) length =3D 0x1000,
        (unsigned int) lpos =3D 0x0,
        (unsigned int) count =3D 0x0,
        (unsigned int) flags =3D 0x00100001,
        (dma_addr_t) dma =3D 0x00000008BD7D7000,

*((struct dwc3_event_type *) 0xFFFFFF8839F54080) =3D (
    is_devspec =3D 1,
    type =3D 0,
    reserved8_31 =3D 774)

*((struct dwc3_event_devt  *) 0xFFFFFF8839F54080) =3D (
    one_bit =3D 1,
    device_event =3D 0,
    type =3D 6, << DWC3_DEVICE_EVENT_SUSPEND
    reserved15_12 =3D 0,
    event_info =3D 3,
    reserved31_25 =3D 0)

Occurred interrupts are =22DWC3_DEVICE_EVENT_SUSPEND=22.
If when =22count has 0=22 and DWC3_EVENT_PENDING are set at the same time t=
han
 ISR and bottom thread couldn't handle next interrupt.
We guessing connected with =22dwc3_gadget_process_pending_events()=22 funct=
ion.
But, We could not find reproduce way.


> > storming from software layer ?
> >
> >> So, It have to clean up DWC3_EVENT_PENDING flags set when count is 0.
> >> It means =22There are no interrupts to handle.=22.
> >>
> >> (struct dwc3_event_buffer *) ev_buf =3D 0xFFFFFF883DBF1180 (
> >>     (void *) buf =3D 0xFFFFFFC00DBDD000 =3D end+0x337D000,
> >>     (void *) cache =3D 0xFFFFFF8839F54080,
> >>     (unsigned int) length =3D 0x1000,
> >>     (unsigned int) lpos =3D 0x0,
> >>     (unsigned int) count =3D 0x0,
> >>     (unsigned int) flags =3D 0x00000001,
> >>     (dma_addr_t) dma =3D 0x00000008BD7D7000,
> >>     (struct dwc3 *) dwc =3D 0xFFFFFF8839CBC880,
> >>     (u64) android_kabi_reserved1 =3D 0x0),
> >>
> >> (time =3D 47557628930999, irq =3D 165, fn =3D dwc3_interrupt, latency =
=3D 0,
> >> en =3D 1), (time =3D 47557628931268, irq =3D 165, fn =3D dwc3_interrup=
t,
> >> latency =3D 0, en =3D 3), (time =3D 47557628932383, irq =3D 165, fn =
=3D
> >> dwc3_interrupt, latency =3D 0, en =3D 1), (time =3D 47557628932652, ir=
q =3D
> >> 165, fn =3D dwc3_interrupt, latency =3D 0, en =3D 3), (time =3D
> >> 47557628933768, irq =3D 165, fn =3D dwc3_interrupt, latency =3D 0, en =
=3D 1),
> >> (time =3D 47557628934037, irq =3D 165, fn =3D dwc3_interrupt, latency =
=3D 0,
> >> en =3D 3), (time =3D 47557628935152, irq =3D 165, fn =3D dwc3_interrup=
t,
> >> latency =3D 0, en =3D 1), (time =3D 47557628935460, irq =3D 165, fn =
=3D
> >> dwc3_interrupt, latency =3D 0, en =3D 3), (time =3D 47557628936575, ir=
q =3D
> >> 165, fn =3D dwc3_interrupt, latency =3D 0, en =3D 1), (time =3D
> >> 47557628936845, irq =3D 165, fn =3D dwc3_interrupt, latency =3D 0, en =
=3D 3),
> >> (time =3D 47557628937960, irq =3D 165, fn =3D dwc3_interrupt, latency =
=3D 0,
> >> en =3D 1), (time =3D 47557628938229, irq =3D 165, fn =3D dwc3_interrup=
t,
> >> latency =3D 0, en =3D 3), (time =3D 47557628939345, irq =3D 165, fn =
=3D
> >> dwc3_interrupt, latency =3D 0, en =3D 1), (time =3D 47557628939652, ir=
q =3D
> >> 165, fn =3D dwc3_interrupt, latency =3D 0, en =3D 3), (time =3D
> >> 47557628940768, irq =3D 165, fn =3D dwc3_interrupt, latency =3D 0, en =
=3D 1),
> >> (time =3D 47557628941037, irq =3D 165, fn =3D dwc3_interrupt, latency =
=3D 0,
> >> en =3D 3), (time =3D 47557628942152, irq =3D 165, fn =3D dwc3_interrup=
t,
> >> latency =3D 0, en =3D 1), (time =3D 47557628942422, irq =3D 165, fn =
=3D
> >> dwc3_interrupt, latency =3D 0, en =3D 3), (time =3D 47557628943537, ir=
q =3D
> >> 165, fn =3D dwc3_interrupt, latency =3D 0, en =3D 1), (time =3D
> >> 47557628943806, irq =3D 165, fn =3D dwc3_interrupt, latency =3D 0, en =
=3D 3),
> >> (time =3D 47557628944922, irq =3D 165, fn =3D dwc3_interrupt, latency =
=3D 0,
> >> en =3D 1), (time =3D 47557628945229, irq =3D 165, fn =3D dwc3_interrup=
t,
> >> latency =3D 0, en =3D 3), (time =3D 47557628946345, irq =3D 165, fn =
=3D
> >> dwc3_interrupt, latency =3D 0, en =3D 1), (time =3D 47557628946614, ir=
q =3D
> >> 165, fn =3D dwc3_interrupt, latency =3D 0, en =3D 3), (time =3D
> >> 47557628947729, irq =3D 165, fn =3D dwc3_interrupt, latency =3D 0, en =
=3D 1),
> >> (time =3D 47557628947999, irq =3D 165, fn =3D dwc3_interrupt, latency =
=3D 0,
> >> en =3D 3),
> >>
> >> Signed-off-by: JaeHun Jung <jh0801.jung=40samsung.com>
> >> ---
> >>   drivers/usb/dwc3/gadget.c =7C 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-) diff --git
> >> a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c index
> >> 789976567f9f..5d2d5a9b9915 100644
> >> --- a/drivers/usb/dwc3/gadget.c
> >> +++ b/drivers/usb/dwc3/gadget.c
> >> =40=40 -4355,8 +4355,11 =40=40 static irqreturn_t dwc3_check_event_buf=
(struct
> >> dwc3_event_buffer *evt)
> >>        * irq event handler completes before caching new event to
> >> prevent
> >>        * losing events.
> >>        */
> >> -    if (evt->flags & DWC3_EVENT_PENDING)
> >> +    if (evt->flags & DWC3_EVENT_PENDING) =7B
> >> +        if (=21evt->count)
> >> +            evt->flags &=3D =7EDWC3_EVENT_PENDING;
> >>           return IRQ_HANDLED;
> >> +    =7D
> >>         count =3D dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
> >>       count &=3D DWC3_GEVNTCOUNT_MASK;
> >
> > how about below change ?
> >
> >         count =3D dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
> >         count &=3D DWC3_GEVNTCOUNT_MASK;
> > -       if (=21count)
> > +       if (=21count) =7B
> > +               evt->flags &=3D =7EDWC3_EVENT_PENDING;
> >                 return IRQ_NONE;
> > +       =7D
> ignore my suggestion, add Thinh to comment.
> >
> >         evt->count =3D count;
> >         evt->flags =7C=3D DWC3_EVENT_PENDING;
> >

