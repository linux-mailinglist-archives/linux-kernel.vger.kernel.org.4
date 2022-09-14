Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0935B87DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiINMK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiINMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:10:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55B27FFBF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:10:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lc7so34290210ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FqrsaO7+mEwEpioRKATgloJ10+QM+/cB58bQ3+4dp5M=;
        b=3ZzWtVRdsZPrUXGxn0Qt6WlAedOqYVxlPHkp6kNc9C3ddTB0szCRpmIDODQota/WGL
         all8CziUkR78153lbchMPecG3kDeC3kZoAgFIYZKZRrzvDWq/b2p+wa9aBKBPgJvbH/0
         TM30WUNl9iH1tcAqq7HwNkoliE76c6V+JvHrzBXha8xMzLJCz8raV0O2It47jJ9gvfJN
         6LnfS8S/La2rMiNKpmivF3YJRzSJaZXFWTNOmRqV3oUA6VKKqacCGj4g8Zl2SdZs7igL
         kin69leUUoCFCxja9ttW/w+K2rsiYYYt6edwlYRgmduSDMeVEoIbLp98YWKMXgBKggPR
         Wtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FqrsaO7+mEwEpioRKATgloJ10+QM+/cB58bQ3+4dp5M=;
        b=DbCfHbLiTdzzLU45pC2z2DA9GJ7dBlFyqqCyQF2yhoL5qLFlAJrkfS5fJ+u8KLVuV1
         UhoYJ4dL37MS6rZ2NWrFJhlXCEC28+X84JrDtJZK2g2FyshK218lDrKao6FPJQKMTUTc
         jujfb/OLTZr4bfIMQtHQaiQS0hivGDabbBXeJyf91NUTDyB+Y//z0sOv9ERHVbd8D6PR
         xAxPvMzdTOviKovYQN5BAll0D4BhuIlzp+qWMexeoDc40ncG+px2RAm1j+qRxD+q5eVc
         9hu1KAYdbbUaNpctRPcFU1CAjrlJAw8vBlt7nSGF+i2PJ7z0kC/HRmg1ukC3Cv8WKDPo
         uGSg==
X-Gm-Message-State: ACgBeo3QZ2GtJ2XJQ0lNce/6otxQAkvB6ZzwvaZ9P0MRuTQ/oAvYlvsU
        R7Zr8ip3uiUpK701+5hSLMj7mZqZDffUb7phmXTnYQ==
X-Google-Smtp-Source: AA6agR6/wFqnDCY8DdjL30UHxs7x4T6E8GyHJaVBbU6IhFxLGUpqktPxpxHNPWftwHziaT0tpo4M0CONWbbdA0zPIDE=
X-Received: by 2002:a17:907:3e07:b0:774:53ba:6b27 with SMTP id
 hp7-20020a1709073e0700b0077453ba6b27mr20640334ejc.286.1663157432337; Wed, 14
 Sep 2022 05:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com> <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com> <20220906214114.vj3v32dzwxz6uqik@pali>
 <YxfBKkqce/IQQLk9@google.com> <20220906220901.p2c44we7i4c35uvx@pali>
 <YxfMkzW+5W3Hm1dU@google.com> <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
In-Reply-To: <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 14 Sep 2022 14:10:21 +0200
Message-ID: <CAMRc=MdrX5Pz1d-SM2PPikEYw0zJBe6GCdr4pEfgBLMi1J9PAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 12:35 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Sep 7, 2022 at 12:41 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>
> > Linus, do you think we should introduce GPIOD_OUT_INACTIVE /
> > GPIOD_OUT_ACTIVE or GPIOD_OUT_DEASSERTED / GPIOD_OUT_ASSERTED and
> > deprecate existing GPIOD_OUT_LOW and GPIO_OUT_HIGH?
>
> They should rather be replaced everywhere in one go.
>
> I think it is just a half-measure unless we also add
> #define GPIOD_ASSERTED 1
> #define GPIOD_DEASSERTED 0
> to be used instead of 1/0 in gpiod_set_value().
>

We've had that discussion for libgpiod and went with
GPIOD_VALUE_ACTIVE and GPIOD_VALUE_INACTIVE but...

> It would also imply changing the signature of the function
> gpiod_set_value() to gpiod_set_state() as we are not
> really setting a value but a state.
>

... now that you've mentioned it it does seem like
GPIOD_STATE_ACTIVE/INACTIVE makes much more sense as well as naming
the relevant functions gpiod_line_request_set_line_state() etc.

> I have thought about changing this, but the problem is that I felt
> it should be accompanied with a change fixing as many users
> as possible.
>
> I think this is one of those occasions where we should merge
> the new defines, and then send Linus Torvalds a sed script
> that he can run at the end of the merge window to change all
> gpiod_set_value(...., 1) -> gpiod_set_state(...., GPIOD_ASSERTED);
> everywhere.
>
> After all users are changed, the GPIOD_ASSERTED/DEASSERTED
> defined can be turned into an enum.
>
> That would be the silver bullet against a lot of confusion IMO.
>
> We would need Bartosz' input on this.
>

We can also let Linus know that we'll do it ourselves late in the
merge window and send a separate PR on Saturday before rc1?

Bart

> Yours,
> Linus Walleij
