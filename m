Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEC571F05F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjFARLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjFARL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:11:27 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58742184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:11:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bad102ce9eeso1141145276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685639482; x=1688231482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RYUgEYxXFi1ZF21Col8g6vBwno/bBmJUkRFch0DaQM=;
        b=UVdnJ7BpN6sHBSdOMr7NGH8HcUdYjWOQtQqoEA1adtfZsyom8iNmq5UdedDkfDhRer
         9b48g/Ii4kszW54ESZgZmO2/RpuYOW3IPzGNPBubY/a60iKbGmaafPracLZ48Gfws4bk
         A+nQd1fxmjI1afLhCh9Df8fpTdmCXGx5WNdfGH67ftg5rJmtGJ3S6+nJfZBPpkp+L7P5
         SsTvCWOfI7Si48vDoM0KkkDJ06V2IrimJr3gvaV81Sa5sRmQthRFwfcLD0dJfY1PoW4c
         Add18Zi93boaWSz/M+ZWU9WO5Lg9CqElBiXJP+G2PNQggV3w45Xc6a+rkkJqMdQ8yE27
         Ff1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639482; x=1688231482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RYUgEYxXFi1ZF21Col8g6vBwno/bBmJUkRFch0DaQM=;
        b=bwNNF0Tb8X42lH00JZg3wO5n8GY37ABolnwezeOhjvQXjWmV//UAG+7Aw4coDia8kg
         208vJxjIZYxlLCJ+imCgwJ22ciW4I6r/cxgynfTF2UfxVpP3miQqG7Km+OfZcgjRUSAW
         Ie6ZSjvzmw5HUgE3QTjyzCG1pgWAqaQiqJP4hWWuYc+3lczPIwkR27C6HjRGGKtP5mqS
         geH2N8gFWrZ29jUtVxf+KjPSfcoq7AizpIlcncGk3RtMAnMI99T+vc2UGSv5fvLr9LvR
         WULRu/gxEheWr0euiTVrYaCui6uXYJ0wivBmse4bF0MxvfC62290CWTtFk7Ly0vhAy25
         PdKQ==
X-Gm-Message-State: AC+VfDyQ8CuipsZYxAmzm922yvbiC0pJ95EvcgslPTxmSCk7ZUI8Hc1H
        EwrYlN31/a1eiOvdqmsqPlOms5eCsSvbLIvdWjxn6w==
X-Google-Smtp-Source: ACHHUZ4lFj0bWB6jMU3gvWBHimujzrWTdc7mbWeL3/S54GjekR5BYZtKjoQH7YngQMCdyLxjtsgfE3wU8mHqvj+RSKg=
X-Received: by 2002:a25:b099:0:b0:b99:53e9:ba89 with SMTP id
 f25-20020a25b099000000b00b9953e9ba89mr459824ybj.50.1685639482511; Thu, 01 Jun
 2023 10:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230531151918.105223-1-nick.hawkins@hpe.com> <20230531151918.105223-5-nick.hawkins@hpe.com>
 <07b2a2f7-5ddc-0f10-6b1f-184dc21fa580@roeck-us.net> <DM4PR84MB19274F575858CBCB2FA5C23E88489@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <b1d8f851-4e87-333c-229c-b9dc37ea3c40@roeck-us.net> <DM4PR84MB19273A008BB11589CEEF697188499@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB19273A008BB11589CEEF697188499@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Jun 2023 19:11:10 +0200
Message-ID: <CACRpkdarJCSCif+r1e_jXbbAgv03OgGAO6pkW9x-yiYZJxdGeQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 5:48=E2=80=AFPM Hawkins, Nick <nick.hawkins@hpe.com>=
 wrote:

> Thank you for your valuable feedback with the solutions you have provided=
.
> Before I proceed though I have a quick query about the fan driver.
> If I were to let the user space "own" gpio pins, would it be permissible =
for
> the userspace to feed a kernel driver data via sysfs?
>
> Ex:
> GPIO Driver -> (OpenBMC) -> Fandriver (sysfs).
>
> Here the GPIO driver would provide fan presence information to OpenBMC
> and then OpenBMC would provide fan presence info to the fan driver.

But why? Don't be so obsessed about userspace doing stuff using
sysfs, usually it is a better idea to let the kernel handle hardware.

I think this is a simple thermal zone you can define in the device
tree as indicated in my previous comment.

> If it were permissible to provide data to the driver via this method I co=
uld
> apply it to the PSU driver as well. the PSU driver which requires presenc=
e
> info to verify a PSU is inserted / removed.

It feels like you are looking for a way for two drivers to communicate
with each other.

This can be done several ways, the most straight-forward is notifiers.
include/linux/notifier.h

Yours,
Linus Walleij
