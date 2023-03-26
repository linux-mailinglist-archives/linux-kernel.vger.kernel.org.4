Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B76C98B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCZXbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZXbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:31:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8646E4C10;
        Sun, 26 Mar 2023 16:31:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r29so6862320wra.13;
        Sun, 26 Mar 2023 16:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679873489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS4fLhwz//kQI/SKHwIiN/58Jw75aYaj1Sbbq5p+eGQ=;
        b=jerRZlU3BpTNtYbdGUEJdQmS2i9kAY3UCns0cLhsue29BWOuYY/gLTL2DahonvvQxU
         El7ro+wWQi+q0QDOHJZvxXrF2jMJQaS8udmX1XHxGYj1VAYSp4u/iw7PH8a84A63gqPf
         bRVrh8LNfJSbHh03yPGo4E7eWGKKndRDIUMcYpNDB4Mnjl7Vk4/VOCi8jMCOLZIPFOyo
         x2PvwrDaa1cW1SuGOWuKbSwrDpvyNkAzOJbRIZSuFRJSpwjhV6q+0cDi48+GuuuzMz7u
         1x/7hgYxLmvFgcmldJVblVyuoQk4TVb/KWSRguYSuszzAnjMskIrgbRAnMsiChH+9Ie3
         hhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679873489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS4fLhwz//kQI/SKHwIiN/58Jw75aYaj1Sbbq5p+eGQ=;
        b=fkRe1dfpGzB5wmrhY6ApZ4/nFfePc2D1JMW8w2rRzeHj5tyP0sJAPAjO0oHgQuJQ3+
         Adyr9f6p3qnk2qSBzDKUBUyas9Eq3gA72JiCiQEdAOsvSGbFxN8cVmAP8uTajUfMIw5U
         s/qP7RHmhb9bZOSxPbSZQsUSNUDXWAtFc1Pzfh2J5RxdmWcjWro9IYEi8/YXPZT+RzAZ
         41DkDuAxARu2/ouc9NVEqa1l2DxmVX1xA03b1sLJFpEFXxy9FFSrzy0qIldz43NsMVKO
         DCyfN5u40GAlUF6pQFu5dtHvYX0vPr7dybYBUYQsLFtRN3N6wjXoLZjBeEWbomMSkx3p
         BDDA==
X-Gm-Message-State: AAQBX9dej2K0UTUyJY3gPj0agN1uvie3PyeGiONbUsdmdAcnJwAsw8n9
        5Bf5HD3TFJAxe0kZjG721jzqWmMiMgmB9p/c4s8=
X-Google-Smtp-Source: AKy350bMNcVjpAEQLEIScGOgPhjtRtiiywRIfkT7s6Bxs4K9aKYnHFq/XBB9/Kkk54PtXNBg/zioVJa2QC3Cs8HUgv0=
X-Received: by 2002:adf:f4c2:0:b0:2c3:be6a:7614 with SMTP id
 h2-20020adff4c2000000b002c3be6a7614mr1958745wrp.2.1679873489230; Sun, 26 Mar
 2023 16:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <20230326184040.33008-1-bigbeeshane@gmail.com> <20230326184040.33008-2-bigbeeshane@gmail.com>
 <0711b320-6c36-6564-70d2-35fc76ac1ebc@linaro.org>
In-Reply-To: <0711b320-6c36-6564-70d2-35fc76ac1ebc@linaro.org>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Mon, 27 Mar 2023 00:31:18 +0100
Message-ID: <CABnpCuC1PLYT82A2iMPkPgRPB0mzGUfF=wBzPpAp+YMN_VfGjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: update rk3588 clock definitions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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

Hi

> We did not finish discussion yet, so sending new version 50 minutes
> after your last reply does not give me a chance to respond.

I was refreshing the patch set to address your comments on the new DTS
setup for the R6S, I did not change this portion of the patch.

I apologise for missing some of the rules here, I am just onboarding this
device for a personal project, but will leave it here for now.


Regards


On Sun, Mar 26, 2023 at 9:04=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/03/2023 20:40, Shane Francis wrote:
> > Some vendor uboot bootloaders use the target kernels DTB image to
> > determine the target clock speeds for some PLLs, currently this can cau=
se
> > uboot to set the clock rate for gpll incorrectly on to cpll (breaking)
> > RGMII.
>
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets.
>
> >
> > This change starts the PLL clock definitions from 1 to correct this
> > miss-match
> >
> > This could be handled by uboot bu updating mappings in that code base
> > however not all devices will have a replaceable uboot (in cases such as
> > when a secure boot chain is implemented)
> >
> > Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
> > ---
> >  .../dt-bindings/clock/rockchip,rk3588-cru.h   | 1442 ++++++++---------
> >  1 file changed, 721 insertions(+), 721 deletions(-)
> >
> > diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/=
dt-bindings/clock/rockchip,rk3588-cru.h
> > index b5616bca7b44..d63b07d054b7 100644
> > --- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
> > +++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
>
> We did not finish discussion yet, so sending new version 50 minutes
> after your last reply does not give me chance to respond.
>
> Best regards,
> Krzysztof
>
