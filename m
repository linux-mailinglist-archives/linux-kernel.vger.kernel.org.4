Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8474A866
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjGGBU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGGBU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:20:57 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEE419A0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 18:20:56 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7653bd3ff2fso136695585a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 18:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688692855; x=1691284855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2UKbsXjIV8t0bNo3+5XMu9R1qmCrIyv3QUJNj0OXNA=;
        b=ctLmSZEpEcHsA8HF3QPA3OqInZwbAZJXzU0OJ3YK/RcPJLE7NmUbpxsfsnWop9L+BT
         7FK8pLuBU51M4V8uXnZx0UnUFBByZ48cNxu4EZ4gGsECUKw6wrLRMtlHXRPta+RgcLFN
         rP2GPR4COtW9JcWdW+zPcszEDAAYs492W5qspxnAt5sHSO1LTQsP8QIMthdSLWv2IMgV
         T8Tvj1LiiBTk7wrDKOe7T3x0bVxZAtLaD9P5uEYV1WvI4EGP06NXtFvOUvgwz3H7EMFg
         PpMLx9gRl9PRGVLmuaB8XTmkHAqRiPQldNDJRSOk2JAvCoXI+KWnz3+GYZopUOI8ibSo
         pBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688692855; x=1691284855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2UKbsXjIV8t0bNo3+5XMu9R1qmCrIyv3QUJNj0OXNA=;
        b=WH0xxHcnYuX5eCAZ5IfOtVDPCAAS0sGcVLBf4bUnfohtmWZrlwDap851NrCe/B2X+4
         1iU4panqZ75ar3ZO/Y3pyYXPOjqYIKtykQFAv9sUoNpaAdVi2ICNUiJHk9D7I14fs6Qa
         yio9AvTEj/NhxitQFaB4PO39GGbvgHOZJB7hIjht9Nmb6hlzoYfW8UMSJqcJTsGcSCnt
         mXEVJLNwO8yA1tGJUMRCf3jukKbUOU6quZiIeTdlQFy7kWXrND9SKRDYKftrfANYgTp1
         EDMtouP12yDgUOf1xgO0os03vhaVz+6wb4tFbuwMEbT2VR+pjD5K/0NyHhZ/VpcBzLRA
         Ty0w==
X-Gm-Message-State: ABy/qLZCCCctb3YpIOaUJUDXwdG4DfGgVLpR+K81Zag+p0txIfopgFyx
        ULo4k2k0LRFTHwiITfwjO7OLkvw4drU9QcYWSDN01w==
X-Google-Smtp-Source: APBJJlE4T4YIU8f3z0e/h2ykXYlpQ92wsSWXoQc9pkifXtirpugJMgP7Edi1IDhO+FGNLU62rrQW0P+SFbAz1NbW+m4=
X-Received: by 2002:a05:620a:2b24:b0:765:ab7c:895e with SMTP id
 do36-20020a05620a2b2400b00765ab7c895emr3870451qkb.24.1688692855395; Thu, 06
 Jul 2023 18:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230704050744.1196293-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=WNLcw2JbMf7tfob2KgjB8eXTC0p1J4OYnQL4k3Mz3mgA@mail.gmail.com>
In-Reply-To: <CAD=FV=WNLcw2JbMf7tfob2KgjB8eXTC0p1J4OYnQL4k3Mz3mgA@mail.gmail.com>
From:   cong yang <yangcong5@huaqin.corp-partner.google.com>
Date:   Fri, 7 Jul 2023 09:20:43 +0800
Message-ID: <CAHwB_NJbtvXNCFj5=NMBXWCt1S1_WrgGij2Kqdr1omno66kVUw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Add avdd/avee delay for Starry-himax83102-j02
 and Starry-ili9882t panel
To:     Doug Anderson <dianders@google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        airlied@gmail.com, hsinyi@google.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 7, 2023 at 3:32=E2=80=AFAM Doug Anderson <dianders@google.com> =
wrote:
>
> Hi,
>
> On Mon, Jul 3, 2023 at 10:07=E2=80=AFPM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > From power on/off sequence for panel data sheet[1], T2 timing VSP to VS=
N
> > needs 1ms delay when power on, and VSN to VSP also needs 1ms delay when
> > power off. Some pmic may not be able to adjust the delay internally, so
> > let's add a delay between avdd/avee regulator gpio to meet the timing o=
f
> > panel.
>
> Unless I'm mistaken, all of this is best handled via regulator
> constraints in the device tree. See the file:
>
> Documentation/devicetree/bindings/regulator/regulator.yaml
>
> Specifically, any delays related to actually ramping up / down the
> regulator can be specified in the device tree. Nominally, you could
> argue that the 1 ms delay actually _does_ belong in the driver, but
> IMO the 1 ms number there is really just there because someone thought
> it was weird to specify a delay of 0 ms. Given that you already need
> remp delays in the device tree, it feels OK to me to just include the
> 1 ms there.

The regulator device tree has only the power on attribute
"regulator-enable-ramp-delay",
not has power off attribute. The regulator delay looks more like the
HW voltage requirement
of the power ic itself, and I just want to meet the panel spec
requirement. I add regulator-enable-ramp-delay
in dts he can also meet my requirement, but I have no way to control
the power off delays.

Thanks Doug.

>
> -Doug
