Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B52A5F3467
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJCRX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJCRXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:23:44 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B341938A11
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:23:40 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l5so11967676oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=WKey60YWMOJ0s2xAWRb+D/DMHBUrKOtpGet3ccL9Sr8=;
        b=WHU0YN5qU8xbngr8MyPaaaE25995ybk85tXIW68PY4TIm/ka0afmNjFLGiACLKTdFY
         7HK4drMXV33Gd89C9y4yRuvWRxoxWi34aZ1x2f3qTSPBElStEtmcWcfBj+jh0oGwHbNH
         WDdIhPvcRtQFT7Fr0H+cXioj+UkL24J1p7USIzTfHAlGflIlbrQ7cbChqbTSPPIpUaOm
         +l+fihzrocEZG59boUAEbWKJnEBt1EADlp4ef3qQ05AMhow4wq2uDYula37IOD3U7veP
         hW2ME9ZYDhe9Lwaj/TZWylRLvZbm8XmYQdgMJX6APN/3PpLOxx+IloFWa2LvjuNtjSO1
         rDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WKey60YWMOJ0s2xAWRb+D/DMHBUrKOtpGet3ccL9Sr8=;
        b=X5bsPeAE5w0hLqLoy0VbN0X0X7bq+7rPj4XzJbM/kAlxCBlrerJrNhLzx6ixCdCjb8
         VBT7k1vt+xMQl3LaKnsdTELasL6I7fWgfj/xd2T/VY1Rc8aUB2GdGtlvm/PmM9n3pjC+
         eEMB2rpa9i3il3q3qsQVyIoHyFbfTHpqVOr5NEz5pbzNBGbFVi6GZNIF0GroJzbD5yey
         MUPvBx8OciAjY+VggsHn+z54Y7SkH6AkUEJ7MwySXnraEplrNI7121huI/JiQdV7HPza
         v06SY1JVHwghNIZIJxAenn5F2jKsP3piewn4qYahiPGwt79HAqfHGuu7sqCvqwIZvmj/
         7eiA==
X-Gm-Message-State: ACrzQf37p4m0SKloH9BUPkX/0ujgn0ha9a8SX0VNzOIb/C+BD5Fz06a5
        xfEkZueFHFNy6Kfvpd15PJ15aP69dS4eT+Lp/rpjUQ==
X-Google-Smtp-Source: AMsMyM7jPgXBDmT/7rRqaEII/upsFwR9G0JeouCOL3p09bLGZpxJZcIvaBh1+ckedWWSprPCqdgpWA1JBoSMCMm5YMA=
X-Received: by 2002:a05:6808:1495:b0:350:e28e:e31e with SMTP id
 e21-20020a056808149500b00350e28ee31emr4524220oiw.66.1664817819904; Mon, 03
 Oct 2022 10:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAPv3WKcW+O_CYd2vY2xhTKojVobo=Bm5tdFdJ8w33FHximPTcA@mail.gmail.com>
 <20221003170613.132548-1-mig@semihalf.com>
In-Reply-To: <20221003170613.132548-1-mig@semihalf.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 3 Oct 2022 19:23:28 +0200
Message-ID: <CAPv3WKe__WcqEXtYf6YQ0Cka=EZKFyaBbFSMsg5U-MoVyERUfA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: net: marvell,pp2: convert to json-schema
To:     =?UTF-8?Q?Micha=C5=82_Grzelak?= <mig@semihalf.com>
Cc:     davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 3 pa=C5=BA 2022 o 19:06 Micha=C5=82 Grzelak <mig@semihalf.com> napisa=
=C5=82(a):
>
> On 02/10/2022 10:23, Marcin Wojtas wrote:
> >niedz., 2 pa=C5=BA 2022 o 10:00 Krzysztof Kozlowski
> ><krzysztof.kozlowski@linaro.org> napisa=C5=82(a):
> >>
> >> On 01/10/2022 17:53, Micha=C5=82 Grzelak wrote:
> >> > Hi Krzysztof,
> >> >
> >> > Thanks for your comments and time spent on reviewing my patch.
> >> > All of those improvements will be included in next version.
> >> > Also, I would like to know your opinion about one.
> >> >
> >> >>> +
> >> >>> +  marvell,system-controller:
> >> >>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >> >>> +    description: a phandle to the system controller.
> >> >>> +
> >> >>> +patternProperties:
> >> >>> +  '^eth[0-9a-f]*(@.*)?$':
> >> >>
> >> >> The name should be "(ethernet-)?port", unless anything depends on
> >> >> particular naming?
> >> >
> >> > What do you think about pattern "^(ethernet-)?eth[0-9a-f]+(@.*)?$"?
> >> > It resembles pattern found in net/ethernet-phy.yaml like
> >> > properties:$nodename:pattern:"^ethernet-phy(@[a-f0-9]+)?$", while
> >> > still passing `dt_binding_check' and `dtbs_check'. It should also
> >> > comply with your comment.
> >>
> >> Node names like ethernet-eth do not make much sense because they conta=
in
> >> redundant ethernet or eth. AFAIK, all other bindings like that call
> >> these ethernet-ports (or sometimes shorter - ports). Unless this devic=
e
> >> is different than all others?
> >>
> >
> >IMO "^(ethernet-)?port@[0-9]+$" for the subnodes' names could be fine
> >(as long as we don't have to modify the existing .dtsi files) - there
> >is no dependency in the driver code on that.
>
> Indeed, driver's code isn't dependent; however, there is a dependency
> on 'eth[0-2]' name in all relevant .dts and .dtsi files, e.g.:
>
> https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/armada-37=
5.dtsi#L190
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/marvell=
/armada-cp11x.dtsi#L72
>
> Ports under 'ethernet' node are named eth[0-2], thus those and all .dts f=
iles
> including the above would have to be modified to pass through `dtbs_check=
'.
>

Can you please double check?
The .dts files use labels, the node name they relate to should be irrelevan=
t:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm64/boot/dts/marvell/cn9130-db.dtsi?h=3Dv6.0#n122
(BTW, for A7k8k/CN913x example please use updated names, i.e.
s/cpm_/cp0_/ and s/cps_/cp1_/)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm/boot/dts/armada-375-db.dts?h=3Dv6.0#n167

Best regards,
Marcin
