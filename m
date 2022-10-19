Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C639760516E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiJSUkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJSUkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:40:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9C2104D2E;
        Wed, 19 Oct 2022 13:40:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m15so26964660edb.13;
        Wed, 19 Oct 2022 13:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SHoyPeO+yKlHEZz3rBetsZcxV3gDKtY4M4wZKqAJU44=;
        b=UzNgmdeOVI3wCoSDtw5phtRdCh6LXmWV7A8EjSQV4rzEUqMqIXUXjcVZgP+e3OMf6p
         ot77V5gUbJhRgLGtNoahckKs6LxDl9OWpYUlGi1qCIbUYOaSRvo5IiHv51DUbB9IreiV
         GT/z6+lboMwwuLfc0dBSdp71HnobwCLTsgtPY94Zfv4LmLwO7MCmTV9f2DbUv1roosYW
         BLs8dT8DoWLdQqFiyJW0jqumgfA3HJyXl52I7DY4p8zWwUFgguzpKn6CEHXmHXs8trx9
         biE7f0WeMOZPETXTNszAMPNNp+MFlUd5W1rL72ZdjwWRcaFoJvvbqmPoXThjWrdLvPhx
         VIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHoyPeO+yKlHEZz3rBetsZcxV3gDKtY4M4wZKqAJU44=;
        b=cNgvfmtbpzs9GkfEvmPiagitkCvo4CKJmA/Aty8an0Go/YS47LN61ZxFh/x/AtFtRr
         ATKpetHJ6ZTMBKc9ZKhptm918hc0u5ZiJsOYkFRWBAwSRSSllCQbF58FmceX9Ef2dSQV
         La1puPLI9d27mubFrnTCB+h4byZ9w6lMS800zmWbm0Q72bOq5sX2pzpnK6GCGqVgET2O
         q0KtUDgeRfAWZ2/QWktoBZUSoEswyHcJDCCrDCsKR9kodoQEu87ZcFYf15OofPu7wO0s
         mi1psaV2AVLYZLx+k5gFXYBn6tlCjM2n9xhmBAIKC6NLq0XGhckTz+PX3JaziEVxStEl
         BYRA==
X-Gm-Message-State: ACrzQf1pF9WakIGDe8nj7jN8cOO8jXuqJ7BO2ryzRc7GHMlZ1V7G1heg
        e9EAthzZXVkHZyGpan7bPq68is5Y7iFTg7YAppk=
X-Google-Smtp-Source: AMsMyM6fJRPrr6+1iw5zNkf08dPmy3usxyt57frb+bnuN14stIeda86KPRYBoRUipDmTmUCZddfWX5FfeSat4d6+8rU=
X-Received: by 2002:aa7:db07:0:b0:458:f6e5:ab71 with SMTP id
 t7-20020aa7db07000000b00458f6e5ab71mr9373877eds.330.1666212030128; Wed, 19
 Oct 2022 13:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221018195122.8877-1-linux.amoon@gmail.com> <CAFBinCCqXBk9Xq0k=NA3zGi8spwyPQN7dMVWcjE+pXkXYf+FKQ@mail.gmail.com>
 <CANAwSgSR6jHRQR6QgzUop_B4gcOsQnfc6LoUXrP0CSTasZkVfQ@mail.gmail.com>
 <CANAwSgRLZfon5qUFeKW9U9AbHvSa=uKVaVgqghVk554-H1LVKw@mail.gmail.com>
 <402500e8-b4fe-9b8f-d634-e329191af1b8@linaro.org> <CANAwSgQhWrzeRcpQSSAmfp+i3966dUQdtCLbcWwifQk=1ce=og@mail.gmail.com>
In-Reply-To: <CANAwSgQhWrzeRcpQSSAmfp+i3966dUQdtCLbcWwifQk=1ce=og@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 19 Oct 2022 22:40:18 +0200
Message-ID: <CAFBinCCyEVbc4N7TUEi=sbLFv7Rc-L=y-h8xBuZK446x1oLc2g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: Enable active coling using gpio-fan on
 Odroid N2/N2+
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     neil.armstrong@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Anand,

On Wed, Oct 19, 2022 at 7:17 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > > +&pwm_AO_ab {
> >
> > &pwm_AO_cd not _ab
> >
> No it has a conflict with CPU_B (vddcpu_b) PWM
Uh, you're right. That's probably why the Hardkernel team uses a
software based PWM implementation: [0]
In hindsight they should have used a different pad either for VDDCPU_B
or the fan.

I think the most pragmatic approach (since the "GPIO PWM" driver is
not upstream and I don't know if something like that would be accepted
upstream) is to use a GPIO based fan as you did in your initial patch.
Not sure what others think though.


Best regards,
Martin


[0] https://github.com/hardkernel/linux/blob/c109dec94e7e819554830acfac4b6ed96e230179/arch/arm64/boot/dts/amlogic/meson64_odroidn2.dtsi#L356-L359
