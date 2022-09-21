Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49BD5C01F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiIUPpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiIUPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:45:30 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CF961130;
        Wed, 21 Sep 2022 08:45:29 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id k9so3408186vke.4;
        Wed, 21 Sep 2022 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=BGlo6ay9T/5m0qNzyNn7Ta7yrBuOkYbaACoZggjAvrE=;
        b=AQCgqIT5AXYbiCLzzlr4Y0jdkYglbGAALygN9T6mwxUzAXf5fKKvf95SQhvmr4MSF1
         A7w2YIP3kgqvVpnHFY0KWYNKo/CekJvRx3dYgOjE9rMpvsAk6l/qbHW6Fe2ORSUA4Icl
         8yF4gPIuvtFXPiYCLWGk5PDj9AY6SFSBEXvYk6mCQvCBVZRzf87/TGTDrm2o5vrW7j+1
         vbk8KXXntpi/SeMVCg9IpzL3NoUgwyVIlfgWh9WrSDjblY/fJEcvMNP0+gL4jwpH81Dt
         5MlR32tdTcI956Nw2P3hXrL+lSEeULE6MZLPgGeQWqVi6AgJZb+txR1oIaEcK/rNWDds
         HcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BGlo6ay9T/5m0qNzyNn7Ta7yrBuOkYbaACoZggjAvrE=;
        b=GszgaZlDLvbFxX/Okm+gdtLW//C86grQ4V3pzg1waBiukYhg/fHW9Cha3ztbMVLH1O
         AKtA4lFlNSCO6q7H7nzR58nSTChLahDm56FZrJrrkYdq2O9Wu0817vW+WGskxHXBK5Tp
         1ZrsllFOSVnnrT3VKn3DaWKRqnbDLQBRMmcUiIeGnPX0+EUJBlvt74qNLWcyI+SKSLcK
         nwcGeEW6AI39bbu+8J3yKRCdnkdpvu7nAzSvLISd9sNUzMPQPyxXGhLWwq5qtv3POalG
         nzfGKbak4xkxwfzyTjAeAk/KLkR4CeP163pGGtKILycgmyKXFC8wuXAjC1EYgoFk/9TO
         wn0A==
X-Gm-Message-State: ACrzQf1vvIDfX3Gm2j+4g5KEfg0lyH5kM4YA11yIlH61cc+aWubLvxFg
        8cvIuRoNqumZm0TBVC2SswZxTeJlV0iNRJj09DvA1zfcYT+TvmIDRjk=
X-Google-Smtp-Source: AMsMyM7J2G57PxjKJzMKxGHuLzogv8GwiLBgt6a04q5nbjsnhy67K9WyLz/uO7VMKg4BDIcz5rzUWgQWWYAJX03haVU=
X-Received: by 2002:a1f:249:0:b0:3a1:e0fb:5402 with SMTP id
 70-20020a1f0249000000b003a1e0fb5402mr10605185vkc.24.1663775128439; Wed, 21
 Sep 2022 08:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAB7eexKhQeqgpMaZoT=JD2EMwn=qTw4sWzF7hdU9XDFVsz3ooA@mail.gmail.com>
 <YynnT7/mnzJVn7iz@kroah.com>
In-Reply-To: <YynnT7/mnzJVn7iz@kroah.com>
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Wed, 21 Sep 2022 23:45:17 +0800
Message-ID: <CAB7eexKKeOxgZ6uh7WXJcui71_uOMeYr8+=Hfb0-Gi4h8JMmEw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in keyspan_close
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        johan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply!

This is a =E2=80=9Cfake=E2=80=9D device. We emulated some functions with th=
e built-in
gadget module as a virtual device side for fuzzing. It can pass through
the matching phase and, to some extent the probing phase.
As you said, the configuration options are correct.

After a successful attachment, we extracted the file_operations
of the device files on both sides to find the corresponding system calls.
Later, by fuzzing the dual-sided device with system calls, it is
equivalent to considering data threats from both peripheral and user space.

We are open to any suggestions and hope to submit a patch capable
of fixing this bug in the near future.

Best Regards,
Rondreis
