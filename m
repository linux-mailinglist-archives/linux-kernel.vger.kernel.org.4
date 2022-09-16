Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14DD5BAD0A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiIPMKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIPMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:10:35 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFAFB02A9;
        Fri, 16 Sep 2022 05:10:33 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3452214cec6so257204957b3.1;
        Fri, 16 Sep 2022 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CRuPtm9mLoySIqLzdHqyZ1IbgS4zBvwylgrMlMJv3sc=;
        b=UClSsp/C4HO4xWEczUQVssGecEPz0RD9ZApnbexavm4RlF6z6CrTtavcEvw/7Vr0TT
         WNQDrrIOiA0BtoHXo8Ns2fRJITmenLUOsFOjKykiaJ6luYE7puP+AXhbbL65kSmMI2yc
         zazhXXGzwjECxqg6hCH0sSmAGtECSADbzwsoaAS9YBHDM2eQEAwSDqcKTfQcTJvKd1In
         QWPfySLDeFuuiDxjenxqzsAL2yBwWT3mT0eR5j9nzcY6z7am0DZmSvEHpvNbMI6OOrbg
         Xv8LHYg867e07o8aKiQfN5uhfPGNQxvMtwbifvRAy4dtK06qvbz/24lVjp7g2qEMF3F4
         Xpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CRuPtm9mLoySIqLzdHqyZ1IbgS4zBvwylgrMlMJv3sc=;
        b=h63IRUlU+5TpF88TRYgzhTfl05X5+4lgvTLaGOCS+ZIse6/YkTPtpE/QeVgHvfxXVP
         xTDt7XcZZM7TE9Nv2OSiGB04yxUDu6j9/oqgL1EX9kncfjJ01OEu/nUjMYxBvVLV5lBj
         OTGYHE4OHKttLp6qCtYb/3j0YRCfHqxGZ3Kk9aNahnxfiOpjTUyVTHIKMMQAXOuQxDGx
         m/fU+ay1u3VvHaqGHDRFKnogD/ANGFLMqfUHEUJTX3mGGXjo493BFstLgUpPa3BlqntI
         SHC1CbVLiLUy74FQM3BNYItYaHzHgdmY59QR7ySqR2a3egLgk2QJCOUEpwsVmzXbGGBi
         XFvw==
X-Gm-Message-State: ACrzQf3NoibEU27v2kQ2DTwJ0DxdHo9aph1LrEzzYNFl497wgdmLzEl5
        AsG6MA/75hqGqDq63wv0LQZNXuoKGMTfPj9mu5Y=
X-Google-Smtp-Source: AMsMyM6z53ELXSU8V4/Wie2GOwlyU/rWfkuGiA4kczX8ggJiVxz4SbnIPqprzBbRn+wB47ZDO3hcxlVMj4irzMUXpPc=
X-Received: by 2002:a0d:d883:0:b0:346:88b5:f4ff with SMTP id
 a125-20020a0dd883000000b0034688b5f4ffmr4053722ywe.355.1663330232764; Fri, 16
 Sep 2022 05:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220913160224.14951-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <YyRjiY5XRPglSHuN@paasikivi.fi.intel.com>
In-Reply-To: <YyRjiY5XRPglSHuN@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 16 Sep 2022 13:10:05 +0100
Message-ID: <CA+V-a8thLoy1f0-GK05958Qg8CzQ4wU3QHNwSW8-D_DmcZRoYw@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: ov5645: Convert OV5645 binding to a schema
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Thank you for the review.

On Fri, Sep 16, 2022 at 12:52 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Tue, Sep 13, 2022 at 05:02:24PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Convert the simple OV5645 Device Tree binding to json-schema.
<snip>
> > +        $ref: /schemas/media/video-interfaces.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          clock-lanes:
> > +            const: 0
> > +
> > +          bus-type:
> > +            const: 4
>
> Please drop the two, they provide no information to the driver that already
> knows this. (Unless of course, the driver supports other bus types these
> bindings do not document. Some OV sensors do.) clock-lanes needs to go in
> any case, and data-lanes are dependent on bus-type being 4 I presume.
>
Agreed, I will drop the above two and send a v2.

> bus-type is also not present in the example.
>
Ahh, I missed that.

Cheers,
Prabhakar
