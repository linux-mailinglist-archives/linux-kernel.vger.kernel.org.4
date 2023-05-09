Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B20E6FBE21
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjEIEQZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 May 2023 00:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEIEQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:16:22 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6D32118;
        Mon,  8 May 2023 21:16:20 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-24e2bbec3d5so3862113a91.3;
        Mon, 08 May 2023 21:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683605780; x=1686197780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvAQIhgAcDYEnVq1YinlIkl9rbATxAJUPWPiLUKBQYQ=;
        b=k6ZzzJR4kIeqQgnIv0IghrjwrOzeZUi5uYz2p+h+h97X/gK8n2mZU7CqHp5lu3LtOu
         G7crtKZU0SqWMIW8eE5IQy2thO/z6xycTL83clkWbuQO6qUEMvoF7hVJQ9VIsx15INLq
         TYbwiluMDgFL2rvC4qtnQhOCQiAI4S+k4zjv6eTcTmPPWwPss8g/xfahTS8imQT49Aas
         EquR75kWxM9+RFryVt68OX7w67CKWG+9g8nSdFVZ0gVyOEqKjn2GvnwFgcbXqEO1GBp6
         oksQVw6DygviYRUsFoywl5U5Lj7fflQO3AQMfH6SyvYoOl1B+AgUYFY5x2kBHdbBO/H8
         jqlw==
X-Gm-Message-State: AC+VfDw5ikM8dhLm1V3iTp6+EBHN+cXqlcsHTiSEkbbguUnS1X5In63X
        /RZnpJ6sm1GHnM2eoccACfEFyNJ//lmonPU9BjlGFus0uVQ=
X-Google-Smtp-Source: ACHHUZ73k2ukC93LVdrt/5eg6c2N5m44E2XR/rSVIBhOn8BjH3N9n8pPGw2uHmSjtucMaOvmm5bZ0aqThfQtguPR/wM=
X-Received: by 2002:a17:90b:fd8:b0:24e:4231:ec6b with SMTP id
 gd24-20020a17090b0fd800b0024e4231ec6bmr12996708pjb.21.1683605779822; Mon, 08
 May 2023 21:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
 <BL3PR11MB64842FA5ECB64DD2C6C9FA76FB719@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230508-paralysis-disarm-fecee3f8a625-mkl@pengutronix.de>
In-Reply-To: <20230508-paralysis-disarm-fecee3f8a625-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 9 May 2023 13:16:08 +0900
Message-ID: <CAMZ6RqL42d04S-pKuMEEMwd0ZoKhrHc2EDci8fv0SoSJVTf3Hg@mail.gmail.com>
Subject: Re: RE: [PATCH] can: length: add definitions for frame lengths in bits
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Thomas.Kopp@microchip.com, linux-can@vger.kernel.org,
        marex@denx.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thank you for your review. You had me reopen ISO 11898-1 (haven't done
so for a long time).

I mostly agree with you. Many of your points are not related to this
patch but to the already existing definition. So I will handle these
in a separate patch.

I will prepare a v2 within the next few days.

On Mon. 8 May 2023 à 21:29, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 08.05.2023 08:54:18, Thomas.Kopp@microchip.com wrote:
> > I was working on the same thing on Friday but didn't get around to
> > sending it off, so here are a couple thoughts I had when working on
> > the defines in length.h
> >
> > The definitions for IFS in here are called intermission in the
> > standard
>
> ACK, and IMF seems to be a common abbreviation.

ACK. I think I will put a reference to both naming (intermission and
IMF) and use the IMF forward for conciseness.

> > and I'd argue they shouldn't be part of the frame at all.
>
> The diagram in https://www.can-cia.org/can-knowledge/can/can-fd/
> suggests that IMF is part of the frame.

ISO 11898-1:2015 section 10.4.6 "Specification of inter-frame space"
makes it clear that the intermission is not part of the frame but part
of the "Inter-frame space".

To close the discussion, I would finally argue that the intermission
occurs after the EOF bit. Something after an "End of Frame" is not
part of the frame, right?

I agree with and will follow Thomas's suggestion.

> > To
> > quote the ISO: "DFs and RFs shall be separated from preceding frames,
> > whatever frame type they are (DF, RF, EF, OF), by a time period called
> > inter-frame space."
> >
> > So, my suggestion would be to pull out the 3 bit IFS definition that's
> > currently in and introduce 11 bit Bus idle and if necessary 3 bit
> > Intermission separately.

ACK.

> > index 6995092b774ec..62e92c1553376 100644
> > --- a/include/linux/can/length.h
> > +++ b/include/linux/can/length.h
> > @@ -6,6 +6,26 @@
> >  #ifndef _CAN_LENGTH_H
> >  #define _CAN_LENGTH_H
> >
> > +/*
> > + * First part of the Inter Frame Space
> > + */
> > +#define CAN_INTERMISSION_BITS 3
> > +
> > +/*
> > + * Number of consecutive recessive bits on the bus for integration etc.
> > + */
> > +#define CAN_IDLE_CONDITION_BITS 11
> > +
> >
> > The field currently called Stuff bit count (SBC) is also not correct
> > I'd say. I'm not sure about the history but given that this is
> > dependent on the DLC I think what's meant is the number of Fixed Stuff
> > bits (FSB) . The ISO does not define a term for the Stuff bit Count
> > but the CiA did define/document it this way. What's meant though is
> > not the number of fixed stuff bits (FSB) which the comment implies
> > here but the modulo 8 3 bit gray-code followed by the parity bit. So
> > for the FD frame definitions I'd propose something like this: Renaming
> > the current SBC to FSB and adding the SBC.

ACK. I double checked the standard, you are right.

> > /*
> >   * Size of a CAN-FD Standard Frame
> > @@ -69,17 +87,17 @@
> >   * Error Status Indicator (ESI)                1
> >   * Data length code (DLC)              4
> >   * Data field                          0...512
> > - * Stuff Bit Count (SBC)               0...16: 4 20...64:5
> > + * Stuff Bit Count (SBC)               4
>
> ACK
>
> >   * CRC                                 0...16: 17 20...64:21
> >   * CRC delimiter (CD)                  1
> > + * Fixed Stuff bits (FSB)              0...16: 6 20...64:7
>
> As far as I understand
> https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=8338047 the FSB
> is 5 or 6.

Reading the ISO, the fixed bit stuff applies to the CRC field (which,
in the standard nomenclature, includes both the stuff count and the
CRC sequence).
The CRC field starts with a fixed stuff bit and then has another fixed
stuff bit after each fourth bit.

So the formula would be:

  FSB count = 1 + round_down(len(CRC field)/4)
            = 1 + round_down((len(stuff count) + len(CRC sequence))/4)

In case of CRC_17:

  FSB count = 1 + round_down((4 + 17)/4)
            = 6

This is coherent with the last figure of
https://www.can-cia.org/can-knowledge/can/can-fd/ which shows 6 FSB
for CRC_17.

In case of CRC_21:

  FSB count = 1 + round_down((4 + 21)/4)
            = 7

So, ACK for Thomas, NACK for Marc (sorry :))

> >   * ACK slot (AS)                       1
> >   * ACK delimiter (AD)                  1
> >   * End-of-frame (EOF)                  7
> > - * Inter frame spacing                 3
> >   *
> > - * assuming CRC21, rounded up and ignoring bitstuffing
> > + * assuming CRC21, rounded up and ignoring dynamic bitstuffing
> >   */

Yours sincerely,
Vincent Mailhol
