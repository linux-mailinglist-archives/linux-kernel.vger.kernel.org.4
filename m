Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9B632723
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKUO6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiKUO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:56:23 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727C5CE9F0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:46:56 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-39ce6773248so45454647b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulFUKCXAc9aqxzSy5N0/HB1Zcs+rWuap2uwJAvIalXY=;
        b=E3+Ab5ymBjhRv+mPQJsnLPZIUqlEY50RqereQhANaVN+0Uf8zUE9qEmhkyFg9YbgoY
         XZrxBVNnHIRsdUXCq51HwP1XE6ayGuVklfNJYVwT//yxtQug++UxpjUooF4W44/qx95V
         R+yBMfLpKu4xjrTWEoOwbSbuVSG+N7aurs6ZL/GUG/A28VS3hELpuowlVQyDWD/dBavW
         GQKf+r7C0FoIZdlMNhUnosu/gXKKDjns/oL77HkDRCIb9kI6yTLyFshfHzRbC53DpmCV
         7Nf/SszYnGjcR/YcmjjPH290oLtMTo22A5B+/WTpl/RZZMLCXAjN3OAijwajceDzv7mQ
         GMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulFUKCXAc9aqxzSy5N0/HB1Zcs+rWuap2uwJAvIalXY=;
        b=X0+Q/WlXb7cI7yeoUESD1s+pWnb3sr/a05lMOMgsuxxmpdZ/dmmqy5roCFPv4G8amq
         9J/K3slZzVqm/ZcSYLcmC6SuPSuS2774pCB3vAK4Jwt2KKmFPQE3zZFSwXqY9nnxh7Ze
         gc83OpXvIIMf6zeorPqqB/Qaz9XGrM9gvwVonVfgS/XnU7dx/RY290GaePVB5z3PXMlL
         eAuL3BhnU90trO9DoHusuKOeEm8RV46hPzlIdE2+MZIUNXqLUWR1rwDJqYD7wa6+/raw
         EqUHNDi0lAUkIb7osvo0bvFu+HT+QQOYRtwLmXdZu1nouq11T67cLdLe+yX5jpOMZDvi
         kYFQ==
X-Gm-Message-State: ANoB5pmD7TKi4kRovhAfnqEchaKi2bP4pHq7TSQ43vRhdO9nTuCu46ME
        jxW96YvkTLwkiNWHxaLU/BFpS07D0vhEjVHw40Ub1g==
X-Google-Smtp-Source: AA0mqf67GSNoHFtEMWoa7PQwZkXnx8oBOgaiP3Qk0ae9QNXF+lKDNVeKAdZ++WEoIc1A7cDg/0qXZF55lJEASemST8M=
X-Received: by 2002:a81:520a:0:b0:38e:3015:b4cd with SMTP id
 g10-20020a81520a000000b0038e3015b4cdmr17831033ywb.87.1669042015544; Mon, 21
 Nov 2022 06:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20221117215557.1277033-1-miquel.raynal@bootlin.com>
 <20221117215557.1277033-7-miquel.raynal@bootlin.com> <CAPv3WKdZ+tsW-jRJt_n=KqT+oEe+5QAEFOWKrXsTjHCBBzEh0A@mail.gmail.com>
 <20221121102928.7b190296@xps-13>
In-Reply-To: <20221121102928.7b190296@xps-13>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 21 Nov 2022 15:46:44 +0100
Message-ID: <CAPv3WKds1gUN1V-AkdhPJ7W_G285Q4PmAbS0_nApPgU+3RK+fA@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] net: mvpp2: Consider NVMEM cells as possible
 MAC address source
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Taras Chornyi <tchornyi@marvell.com>,
        linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 21 lis 2022 o 10:29 Miquel Raynal <miquel.raynal@bootlin.com> napisa=
=C5=82(a):
>
> Hi Marcin,
>
> mw@semihalf.com wrote on Sat, 19 Nov 2022 09:18:34 +0100:
>
> > Hi Miquel,
> >
> >
> > czw., 17 lis 2022 o 22:56 Miquel Raynal <miquel.raynal@bootlin.com> nap=
isa=C5=82(a):
> > >
> > > The ONIE standard describes the organization of tlv (type-length-valu=
e)
> > > arrays commonly stored within NVMEM devices on common networking
> > > hardware.
> > >
> > > Several drivers already make use of NVMEM cells for purposes like
> > > retrieving a default MAC address provided by the manufacturer.
> > >
> > > What made ONIE tables unusable so far was the fact that the informati=
on
> > > where "dynamically" located within the table depending on the
> > > manufacturer wishes, while Linux NVMEM support only allowed staticall=
y
> > > defined NVMEM cells. Fortunately, this limitation was eventually tack=
led
> > > with the introduction of discoverable cells through the use of NVMEM
> > > layouts, making it possible to extract and consistently use the conte=
nt
> > > of tables like ONIE's tlv arrays.
> > >
> > > Parsing this table at runtime in order to get various information is =
now
> > > possible. So, because many Marvell networking switches already follow
> > > this standard, let's consider using NVMEM cells as a new valid source=
 of
> > > information when looking for a base MAC address, which is one of the
> > > primary uses of these new fields. Indeed, manufacturers following the
> > > ONIE standard are encouraged to provide a default MAC address there, =
so
> > > let's eventually use it if no other MAC address has been found using =
the
> > > existing methods.
> > >
> > > Link: https://opencomputeproject.github.io/onie/design-spec/hw_requir=
ements.html
> >
> > Thanks for the patch. Did you manage to test in on a real HW? I am curi=
ous about
>
> Yes, I have a Replica switch on which the commercial ports use the
> replica PCI IP while the config "OOB" port is running with mvpp2:
> [   16.737759] mvpp2 f2000000.ethernet eth52: Using nvmem cell mac addres=
s 18:be:92:13:9a:00
>

Nice. Do you have a DT snippet that can possibly be shared? I'd like
to recreate this locally and eventually leverage EDK2 firmware to
expose that.

> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/driver=
s/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > index eb0fb8128096..7c8c323f4411 100644
> > > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > @@ -6104,6 +6104,12 @@ static void mvpp2_port_copy_mac_addr(struct ne=
t_device *dev, struct mvpp2 *priv,
> > >                 }
> > >         }
> > >
> > > +       if (!of_get_mac_address(to_of_node(fwnode), hw_mac_addr)) {
> >
> > Unfortunately, nvmem cells seem to be not supported with ACPI yet, so
> > we cannot extend fwnode_get_mac_address - I think it should be,
> > however, an end solution.
>
> Agreed.
>
> > As of now, I'd prefer to use of_get_mac_addr_nvmem directly, to avoid
> > parsing the DT again (after fwnode_get_mac_address) and relying
> > implicitly on falling back to nvmem stuff (currently, without any
> > comment it is not obvious).
>
> I did not do that in the first place because of_get_mac_addr_nvmem()
> was not exported, but I agree it would be the cleanest (and quickest)
> approach, so I'll attempt to export the function first, and then use it
> directly from the driver.
>

That would be great, thank you. Please add one-comment in the
mvpp2_main.c, that this is valid for now only in DT world.

Best regards,
Marcin
