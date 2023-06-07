Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588AB7268F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjFGSg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjFGSgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:36:15 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2222703
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:35:49 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-62613b2c8b7so78640686d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686162944; x=1688754944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8MO8idHjGgHobSj2+y8L7jZ0lTI1b+AM3qlVbDTHoEw=;
        b=l7PIGNLaNe8gpnf/YZ7Edx9UYXtsV67dV0Ugo24UM3bkzQMN51zevh7wJiYj40l/hh
         Qbp+Px0kgc7GFHPNdUmCapVc6RnCcU8GlWkqXG5uoiKshUBxFx2kW2lCwfdssl1RcPYJ
         nnPxslFYNkw4GLKZgbTEMeWEpL0A6LKNFauv9H3+suGpcnJSHTkSf2hYA7NaXPpoz47b
         a0YSGU/YlzKd/i9HnIf8Sqa+Ik/eVw1XFPkuqZpVR57kC06fojqpupEJbhhUMoIxF53Z
         +aY0wm/NG38QeRKTFAeLXoGlNMt0EJwO3YRvlQ0LpfqaWCksoBliyI1V3BruCbn2B32b
         CO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686162944; x=1688754944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MO8idHjGgHobSj2+y8L7jZ0lTI1b+AM3qlVbDTHoEw=;
        b=anEarm4BEqAqysWh44HJyynixOdkMhhosUiNJWgV95SpqqUFpojIsy6S6bVlBL5S19
         +G/CI5CTLakIrah7vRVwYFu+evZEAVkK8xvHfouJLT4q4jr0doICUuxpNxBrVN5Vb34Z
         TZhij2od9sTKA9wi+jMugQWpR1TdNypuHOWXeZFHi8SYwQjXMqUku7menKaXymUSrVNp
         C1el3jlPAaFgdIBmnDF/wQD9J9FDDnOFtcGN0CYP6zFUdsDB7GklYDDYKOCuzj7eHL91
         Ln0bSA3jZVoquhXRMSkOl/Q+NQTyz4N8prQwrdQnCpXBkmWNOxJQjwv9FQ08jkbVFv8p
         a6kg==
X-Gm-Message-State: AC+VfDzc66i6NDQRpiBJStoretJO9S9mD0zBvgzmTx2WWyGEVtM2nVm4
        6HMSrPnAufo2uzt2Eyn3PHgB52NQ6YZoKwQeI+Glrw==
X-Google-Smtp-Source: ACHHUZ41vtT1v+9WUFo1/H9LU26cF4vuWNbFOrs9wq3Nb/pAS0xEnhKvoMQ9CfUjYQ4/e7vAMEpMlRchjM9aqQT0ZEY=
X-Received: by 2002:a05:6214:260c:b0:623:8214:14c8 with SMTP id
 gu12-20020a056214260c00b00623821414c8mr4287841qvb.51.1686162944601; Wed, 07
 Jun 2023 11:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYs4JsmNxX4+W=wijfSPdDsOy=SWLBSitZper5ncPpdxqA@mail.gmail.com>
 <CAMRc=MdRev1NBz9ga0jcDKD0oZy_W-7caq9R0tQkUG86rBQ=3Q@mail.gmail.com>
In-Reply-To: <CAMRc=MdRev1NBz9ga0jcDKD0oZy_W-7caq9R0tQkUG86rBQ=3Q@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 7 Jun 2023 20:35:34 +0200
Message-ID: <CADYN=9Kj9A6utjkPMuAQ4=ytvBiL50GnTzttauRWLQZOn5rzeQ@mail.gmail.com>
Subject: Re: arm64: libgpiod: refcount_t: underflow; use-after-free.
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ferry Toth <fntoth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, warthog618@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 at 13:36, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Feb 20, 2023 at 3:59 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > Following kernel warning notices on qemu-arm64, qemu-arm and also on devices
> > running Linux version v6.2.0 while running libgpiod tests.
> >
>
> I don't see it on v6.2 with libgpiod v1.6.4. Seeing the output of the
> test script, it seems you're using an old version - what is it?

Yes, I did run libgpiod v1.6.4 by mistake on todays next-20230607 tag.
Not sure if I should or should not get the use-after-free warning by
running the "wrong version"
of a test suite or?

>
> > + ./gpiod.sh /opt/libgpiod/bin/
>
> What's in gpiod.sh?

its a wrapper script around gpiod-test [1] to parse the output to be
understood by our test framework

Cheers,
Anders
[1] https://github.com/Linaro/test-definitions/blob/master/automated/linux/gpiod/gpiod.sh

>
> Bart
>
> >   [INFO]    libgpiod test suite
> >   [INFO]    117 tests registered
> >   [INFO]    checking the linux kernel version
> >   [INFO]    kernel release is v6.2.0 - ok to run tests
> >   [INFO]    using gpio-tools from '/usr/bin'
> > [   10.499036] ------------[ cut here ]------------
> > [   10.499656] refcount_t: underflow; use-after-free.
> > [   10.500264] WARNING: CPU: 2 PID: 291 at lib/refcount.c:28
> > refcount_warn_saturate+0xf4/0x144
> > [   10.501306] Modules linked in: gpio_mockup(-) cfg80211 bluetooth
> > rfkill crct10dif_ce fuse drm
> > [   10.502364] CPU: 2 PID: 291 Comm: gpiod-test Not tainted 6.2.0 #1
> > [   10.503229] Hardware name: linux,dummy-virt (DT)
> > [   10.503883] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   10.505331] pc : refcount_warn_saturate+0xf4/0x144
> > [   10.505723] lr : refcount_warn_saturate+0xf4/0x144
> > [   10.506115] sp : ffff800008983cd0
> > [   10.506391] x29: ffff800008983cd0 x28: ffff0000c4c4c100 x27: 0000000000000000
> > [   10.506961] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> > [   10.507533] x23: 0000000000000200 x22: ffff0000c4e66800 x21: ffff0000c7734640
> > [   10.508104] x20: 0000000000000001 x19: ffff0000c7734600 x18: ffffffffffffffff
> > [   10.508677] x17: 3d4d455453595342 x16: ffffcf0234432020 x15: ffff800088983957
> > [   10.509424] x14: 0000000000000000 x13: 2e656572662d7265 x12: 7466612d65737520
> > [   10.510003] x11: 3b776f6c66726564 x10: ffffcf02365db580 x9 : ffffcf0233b20138
> > [   10.510575] x8 : 00000000ffffefff x7 : ffffcf02365db580 x6 : 0000000000000001
> > [   10.511145] x5 : ffffcf023655f000 x4 : ffffcf023655f2e8 x3 : 0000000000000000
> > [   10.511721] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c4c4c100
> > [   10.512294] Call trace:
> > [   10.512494]  refcount_warn_saturate+0xf4/0x144
> > [   10.512971]  kobject_put+0x164/0x220
> > [   10.513224]  fwnode_remove_software_node+0x44/0x60
> > [   10.513554]  gpio_mockup_unregister_pdevs+0x54/0x70 [gpio_mockup]
> > [   10.513970]  gpio_mockup_exit+0x10/0x328 [gpio_mockup]
> > [   10.514322]  __arm64_sys_delete_module+0x190/0x2a0
> > [   10.514653]  invoke_syscall+0x50/0x120
> > [   10.514915]  el0_svc_common.constprop.0+0x104/0x124
> > [   10.515277]  do_el0_svc+0x44/0xcc
> > [   10.515541]  el0_svc+0x30/0x94
> > [   10.515788]  el0t_64_sync_handler+0xbc/0x13c
> > [   10.516126]  el0t_64_sync+0x190/0x194
> > [   10.516419] ---[ end trace 0000000000000000 ]---
> >
> >
> > Build and test logs,
> > https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.2/testrun/14856342/suite/libgpiod/test/ctxless-get-value-single-line/log
> > https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.2/testrun/14856342/suite/libgpiod/tests/
> >
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
