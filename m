Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD53D6C7951
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCXID4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCXIDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:03:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1EF23864;
        Fri, 24 Mar 2023 01:03:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eh3so4462702edb.11;
        Fri, 24 Mar 2023 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679645032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdPfVznn1+cmnWLd3joAMKzC5IL6oKT3yPikotdBwTo=;
        b=ZDGfVVLCGkWZUzZiCRqGteeqkaKWetao4CofMCmxQWl+nVuqaKJ9Z853VpC11tQPrP
         2fCpJLLFPKHOuevz60rn2UNBgDKrZhPrXTZYZFt8V/IG6gaDVo6ammZ4M0Cpo31pdqN8
         macbIvU41vGNWiqA2gF89srr85ROsTkdx2G5I3l9Y/Wl8Q+zQrv+Y//lVTlMPr9M+Kux
         sPAgl9D7dIpVwAkvszwIS2Le6nz22kiGcdOQjqIE9bM5d/64chSiaDtzcyGWKvSCbuEU
         dai1mQ8ezO6sT40rNeh/MA652xJ3oJ055fWPXKu258MQcbAQq/eIYl2JRJBCmkimsFc+
         J5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679645032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdPfVznn1+cmnWLd3joAMKzC5IL6oKT3yPikotdBwTo=;
        b=gyxah4JIoXVfWAFFo0S/OsDuN/bxvvhCbJQYr/Rhl7qnqIl9stJ20gLggUkG0jVrWY
         00WLcbPQ7DKK5hQx2CpRPYJhFPSYKGwHuQyAoFUEyALQTqfm3wkYPrylI7H/k1bxsc2T
         diB6aFNPQ0q1hGs1L5b499koNfgj93zpyOPhgqJybbSqqb7uSUaOTg0hxjM9Fp8dd8s/
         X2KMwYrHTiwjMrijmSImr76M/LksxrOz1YjtdNT1pyhaBajopaRM7WIFVWhpBfvnP3Dt
         w3EpvwWO1wyweb1WPUw5X3RrmvzAoZDpn+kAAO5wFHSJUkMeMC7JNGGFByTTmVliGxyP
         iCbQ==
X-Gm-Message-State: AAQBX9e1oPj5w5+yNDrvkxXNvGpknJm5hYHnkJJcq3dEOOhpszVjqe/g
        hAah/Z6p4DhzW95xJ3Db4Ki9c5Y7fWM4GTdB8YA=
X-Google-Smtp-Source: AKy350ZsgN9BqoCkjFLRhe/ETXRYHC7790A78K2S00e9Slpv5Upu4pOEf20dq2DZFMQhGRN0grToelfSXDUJdHXvQlY=
X-Received: by 2002:a17:906:1744:b0:930:4944:c2c with SMTP id
 d4-20020a170906174400b0093049440c2cmr952299eje.12.1679645031882; Fri, 24 Mar
 2023 01:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230323123807.11882-1-cnsztl@gmail.com> <20230323123807.11882-2-cnsztl@gmail.com>
 <CAEwRq=pwWrXAuHMBaWzZE7cxmVMGuX=eqi5Esjxpe-jPXWF+0w@mail.gmail.com>
In-Reply-To: <CAEwRq=pwWrXAuHMBaWzZE7cxmVMGuX=eqi5Esjxpe-jPXWF+0w@mail.gmail.com>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Fri, 24 Mar 2023 16:03:39 +0800
Message-ID: <CAOP2_ThsN9O8su2MMFVZRMC6SQ-MQ6qxwXeGXmK2ySMxSGfMRw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: Add doc for FriendlyARM NanoPi R2C
To:     Vincent Legoll <vincent.legoll@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Yan <andyshrk@163.com>, Peter Geis <pgwipeout@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Thu, Mar 23, 2023 at 8:44=E2=80=AFPM Vincent Legoll <vincent.legoll@gmai=
l.com> wrote:
>
> Hello,
>
> On Thu, Mar 23, 2023 at 1:38=E2=80=AFPM Tianling Shen <cnsztl@gmail.com> =
wrote:
> > -      - description: FriendlyElec NanoPi R2S
> > +      - description: FriendlyElec NanoPi R2C/S
>
> Maybe do like for the following one:
>
> >        - description: FriendlyElec NanoPi4 series boards
>
> - description: FriendlyElec NanoPi R2 series boards

Sounds good! I will apply your suggestion in v2.

Thanks,
Tianling.

>
> Regards
>
> --
> Vincent Legoll
