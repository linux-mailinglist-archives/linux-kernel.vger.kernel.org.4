Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15005F75A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJGIyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiJGIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:54:10 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B055D0CDC;
        Fri,  7 Oct 2022 01:54:02 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d12so1238188qtp.3;
        Fri, 07 Oct 2022 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4tUdV4L/2QwWsOx6Ow7s9theIvasnIZi196Bm2gh3xI=;
        b=EX2xtvyhYNgRlqDmkYYZQ504HZFqHTVPP6pg6LzoGLh7XqQamLEFebaUb2zct/sfdE
         K0qJXsvZiT2B7KtfV6jU6656RMPokA3we0/lyfUP7RIs75uABHwdmt/2j99hEUCI5RMk
         Wz3dy/TLQnZ21Yqe4Imq6cA7RMx8WlgVyhLnrQWEmBnxMQBglbM5y3mF42ljUtRXuux7
         lnc3+CdFsJBKnlXMfgBHdKiMoQ52/hhh8/6s4HdnYPGfNrWsbjAqXlRsSdCxErHVn04D
         8bQfpH6aHTU30apSQ2q0LOhdBwLHjCeig4m7YYdPhSLyAv4GQZg5cJqopFkIS//rP6c4
         NQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tUdV4L/2QwWsOx6Ow7s9theIvasnIZi196Bm2gh3xI=;
        b=USei4lnm1lDvZb0UUrZdjNGeHqDtDl7xb97KAMVrsD8iMGZT2sKZNFDg1Bd9UFTQ29
         OviioLiRflAjH+y/QEBNEfOaStPgSImdjQgmFKp0P9LcaWWRLNkgud6GZoNGWUzqo70r
         WNSGswSBhC8paWwqmvS56iOjKedKypi2xgnPasUGdM4HcQQZuzs/r0q7kpbQ7m5DwU39
         8dkj8V9b7cToYqO0MB72CRirm0zj7qwL98vhacSTk/LjVY0nasYxOPf4ldsz/is8J8/P
         e09J548RF2YEJ9/hW0WkR3HH39qon+2atEMeiGOd+UipwM4H8GFXdlsttfmv9qRQrXtt
         6pzA==
X-Gm-Message-State: ACrzQf0EaTUBUR66UUFR5LgNryZMuPZJtAbiul3u/Wa+x61R9JweAGT0
        Qls4gWim0UrvZrBKOfMOzv22YZIxqrynOJaW3x3zBGaQjjw=
X-Google-Smtp-Source: AMsMyM5QgiEdaJNG37KGmh1CNsd/1WwDUQFzP+l7GQUc9TIHKquqzdDyOKDjSjSXgGgrs41SRx9yiR9cvAsSkR5N7jg=
X-Received: by 2002:ac8:7c43:0:b0:35c:cd8f:3da5 with SMTP id
 o3-20020ac87c43000000b0035ccd8f3da5mr3412621qtv.61.1665132841032; Fri, 07 Oct
 2022 01:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220917081339.3354075-1-jjhiblot@traphandler.com>
 <20220917081339.3354075-5-jjhiblot@traphandler.com> <CAHp75VeAnJQt7kS8UE+OKcqnScYnmHnVvL+QNW6jR=yF0=oMAA@mail.gmail.com>
 <6d3d2dfd-4d44-c91a-2145-bae624926259@traphandler.com>
In-Reply-To: <6d3d2dfd-4d44-c91a-2145-bae624926259@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Oct 2022 11:53:24 +0300
Message-ID: <CAHp75VePiAs_qz2fxAheoGbq4wk39x5uoVUKZdbN254RDevgsQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 4/4] leds: Add a multicolor LED driver to group
 monochromatic LEDs
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sha@pengutronix.de
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

On Fri, Oct 7, 2022 at 9:34 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> On 17/09/2022 10:37, Andy Shevchenko wrote:
> > On Sat, Sep 17, 2022 at 11:14 AM Jean-Jacques Hiblot
> > <jjhiblot@traphandler.com> wrote:

...

> >> +               led_cdev = devm_of_led_get(dev, count);
> > Why _of_ variant? Please, make this OF independent since it's
> > pretending to cover not only OF-based systems.
>
> This is not OF independent. It could be, but that will wait until
> someone needs it. I don't know much about ACPI and have no hardware to
> test it on.
>
> I'll add the missing  dependency on OF in the Kconfig.

No, please consider getting rid of OF-centric API usage.

...

I'm not sure why you left a lot of context in the reply without
commenting or replying to it.

-- 
With Best Regards,
Andy Shevchenko
