Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B131739176
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjFUV1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFUV13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:27:29 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2137219AB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:27:27 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso6340439276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687382846; x=1689974846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSGrXpDdr+ySzk2gG5rg7v9234imj6fLzZDG7vPyDLA=;
        b=onnUufPf0dJQ3lMOoRacqhbEXGB8fK737MzJqualg8YoJnW+J/rPFMgTFatwXn0U+G
         /2JDLwSk960OkrdDwo5+e820fhUDPykyJgxAMDg5T9JiifLTzwWi1zpSCeLtS7YjEFjP
         TbwaF1v61WT+HbLxsO3UZ8pDmEIp5MBCMH7U8oMzjkrcW/TzT58X9lgnivaFD/eyW/2A
         FlqV+liEkluzTvIqHPP3YCBA4Rrr9bkUyMa4itRpS6YOb7sX77U+Qc73vkwBCdkn0oia
         fVb2oWZDIPfntzSClJuSDclGd0by7+Ff2tl2dQga/BsgJf038KUOYBUNsnfS/doyh2yo
         xTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687382846; x=1689974846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSGrXpDdr+ySzk2gG5rg7v9234imj6fLzZDG7vPyDLA=;
        b=IpTsZ76uHOlgPPQFzHQXNcrGokWQejk/n8T6zOQuxDFPR0tSVdTsyoELloMbRGXrU1
         AbrEpCrLT/Oboekkd39ZvClBGa4TL/qz+wQtyJVgCbuYq2+jxTEer5Rd2H1upzClenlm
         XVDBXOJpwhUozriA4TPe6FrKeHTMOWPnPxS5XtdK3GnGFjTmISKTOEROqNq+yuyhLjfz
         V2P0v0ZwUhgqziUwY5PktR3GWuOkTEBTpQC/rjZcd/emIN4wXHwJ9e1492+g6IA7nzgt
         8H6/lsk2NlbQ88GEjHKq5cv57m23J1FlrfadMET8LYl9q4m3AptPha+UPs23s1qP4NN3
         w6GQ==
X-Gm-Message-State: AC+VfDwUyyFR0EA20/dEY6EY4tIOBOmr8d6vmkoQWWU169P5wHZu9nsI
        SjfME8zhJmeqIdQ1jywmJoj7LmIfEqFRIpfMtS0mXw==
X-Google-Smtp-Source: ACHHUZ5VzPxqRZ496GxcNAVq+z5XSw9IeUoRiS/KRa04dhsOg9FchyYQQezJAZLBAVKzb2mucCa0CX2MfFiWbm8855E=
X-Received: by 2002:a25:d8c:0:b0:bca:f2b2:cbf5 with SMTP id
 134-20020a250d8c000000b00bcaf2b2cbf5mr13640953ybn.38.1687382846209; Wed, 21
 Jun 2023 14:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
 <20230621191302.1405623-2-paweldembicki@gmail.com> <27e0f7c9-71a8-4882-ab65-6c42d969ea4f@lunn.ch>
In-Reply-To: <27e0f7c9-71a8-4882-ab65-6c42d969ea4f@lunn.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jun 2023 23:27:14 +0200
Message-ID: <CACRpkdZ514z3Y0LP0iqN0zyc5Tgo7n8O3XHTNVWC0BrnPPjM2w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] net: dsa: vsc73xx: add port_stp_state_set function
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 9:33=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     /* FIXME: STP frames isn't forwarded at this moment. BPDU frames =
are
> > +      * forwarded only from to PI/SI interface. For more info see chap=
ter
> > +      * 2.7.1 (CPU Forwarding) in datasheet.
>
> Do you mean the CPU never gets to see the BPDU frames?
>
> Does the hardware have any sort of packet matching to trap frames to
> the CPU? Can you match on the destination MAC address
> 01:80:C2:00:00:00 ?

The hardware contains an embedded Intel 8054 CPU that can
execute programs to do pretty much anything.

The bad news: it requires a custom SDK thingy that we do not
have access to.

So far we used the chips in a bit of vanilla mode, which is all I
have ever seen in the systems we have and it can't do much,
not even add a helpful frame tag, but as can be seen from the
patches it can do VLAN...

Yours,
Linus Walleij
