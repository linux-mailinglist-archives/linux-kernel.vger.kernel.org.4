Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54D963FA03
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiLAVr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiLAVrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:47:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881F9286EC;
        Thu,  1 Dec 2022 13:47:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AC69B81FC9;
        Thu,  1 Dec 2022 21:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C51C433C1;
        Thu,  1 Dec 2022 21:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669931267;
        bh=FjbFtLjBLre2tSCiguVTfVS1YZts86UT4GzrvZvOP1s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=obbEMI0pt92dyFY5lpuQCgceXgDkxlEE2ShYPoEdc/P426CsVWIcjgmPMRYswwxgn
         BBKnCfXgIGQsI4jOuJoKrp3Ja8dmaTFE7Me83kMEUPF+o5H9yPyzkv/+WCtOgDl3eT
         40/icYTQMJaWGEwD4/A71vGI9u/VAv3oJqrkGT69GpH8hUbPveWgpDfYnjVf+aSaw6
         cejkxr92dmMRtNcXwAigI8fg+Qp6sClCNdN2t28Qatkbsfy5rkES8UNWlCLkNoLZOt
         T0pZtA/BBdgpUK0HN3UC1q4NWqmROmKjQEU/taTOc6yoxPDg8bisJuN2645mBteL2G
         vUlDuhLjreExg==
Received: by mail-vs1-f47.google.com with SMTP id g65so2941919vsc.11;
        Thu, 01 Dec 2022 13:47:47 -0800 (PST)
X-Gm-Message-State: ANoB5plQm2qxDMkF3lRiVXLbdaDjtb7j/tN9jehRCdKnwO5+H0Je8Hy7
        dPjd0RRsBLz/y4Oa3ee1jWz6t0aLp/OufBdRJg==
X-Google-Smtp-Source: AA0mqf7Jigle0AWJmRQV95TfPPYMJwWCAq6GVDzxqoXbAPteNeIVtf7Q/Eo7yOqALF6yuk+EjekPrVDjoTXS2VUmpVc=
X-Received: by 2002:a05:6102:5f7:b0:3af:68c0:1c2e with SMTP id
 w23-20020a05610205f700b003af68c01c2emr30953439vsf.26.1669931266812; Thu, 01
 Dec 2022 13:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz> <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
 <20221130191905.GA2631320-robh@kernel.org> <Y4eufPCzKbfp9k3z@duo.ucw.cz>
In-Reply-To: <Y4eufPCzKbfp9k3z@duo.ucw.cz>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 1 Dec 2022 15:47:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK6+Yyn29QNV2tjUM-zm9WbuW57Jb=LKmqCLXHmvEoJYA@mail.gmail.com>
Message-ID: <CAL_JsqK6+Yyn29QNV2tjUM-zm9WbuW57Jb=LKmqCLXHmvEoJYA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Marek Vasut <marex@denx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        kernel@dh-electronics.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 1:27 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2022-11-30 13:19:05, Rob Herring wrote:
> > On Fri, Nov 25, 2022 at 10:26:30PM +0100, Marek Vasut wrote:
> > > On 11/22/22 13:23, Pavel Machek wrote:
> > > > Hi!
> > >
> > > Hi,
> > >
> > > > > Mark the label property as deprecated as it is mentioned
> > > > > in the description.
> > > >
> > > > Lets do it the other way around. Functions (etc) don't really provide
> > > > good enough description of LED, and label is still needed.
> > >
> > > Can you please provide a clear explanation which property or approach is the
> > > correct one for new DTs ?
> > >
> > > So far, the documentation states that "label" is deprecated, and users
> > > should replace it with "function" and "color".
> >
> > 'function' is what activity/operation the LED is associated with. It is
> > a fixed set of strings which s/w may use. It is a replacement for
> > 'linux,default-trigger'.
> >
> > 'label' is what is printed next to the LED for a human to read. 'label'
> > can be anything and the OS shouldn't care what it is.
>
> Unfortunately, no.

That's why I said 'shouldn't care', not 'doesn't care'.

'label' is also not just an LED property. It's used elsewhere, but
unfortunately the LED subsystem makes more use of it than it perhaps
should.

> We use label as a path in /sys/class/leds.

Yes, or node name if no label. That's still not really caring what the
value of label is. At least the kernel doesn't. A well behaved
userspace wouldn't either and doesn't for most classes.

> And it looks like integer
> "function" is not really adequate for describing what LED does. There
> are too many LEDs and not enough integers, and it is common to have
> same function ("activity") on multiple devices ("wifi", "mmc", "eth").

Whatever the problems are, 'label' is not the solution.

There is a way to associate leds with devices. 'trigger-source' IIRC.

Rob
