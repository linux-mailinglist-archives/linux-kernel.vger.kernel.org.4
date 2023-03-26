Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A366C974C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 19:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjCZRwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 13:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjCZRvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 13:51:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729AA5B88;
        Sun, 26 Mar 2023 10:51:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q19so3324283wrc.5;
        Sun, 26 Mar 2023 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679853101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQtHwxLiaWLJIGykUiHYl89Ngg0txqbdaptvAgwczSA=;
        b=HXRiXeGKYFyN1HdxGyEvmo3qTxzeR0tZQcIjFMCsO11EiMdZiOyyx/7sM4Jqkwyfmi
         BaZnw3Sc1LnonaCyGsfkKUfw0Tg3CL+Sce7ORpAGOuxj8/Es3j7RuPZulMuOMaNZLWwB
         ZFP8sbKwfJ6KX4UavGrcQcWfCJlDoHBm1jCeP/w56ebqBJjIGysPoJNsc1kGo7BcWfJG
         0JKylT+TRSMTCr/8Le7S2wwcxnOOPZbEC2i04Q04NoJjZ0YE/3NiItMvY2oeABpyjOKq
         lx+HNM7Zz2jpF4XdfFJx9S0wxS11Fs1Rv7zVKbp5x39yH6BPAzgpard02kkI8pC9MJs5
         464A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679853101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQtHwxLiaWLJIGykUiHYl89Ngg0txqbdaptvAgwczSA=;
        b=NWtgfCZ+pa+QkCMpjqEbEk/wfBYv4aTTNSuvRRiZSiMSwmV01qmoW8eFim+5VOjU0W
         wpKdn034ovCks/NrXn2msqEjT0Wry9wY51zDrOiGBc7haaXS64OMhgaBlN2Yvl4GfDoZ
         OO8UOL+6F+5ePZaDf8Gvp6jRZxLpNmxyJH0rX8f8L0PMfUTBLfT7HlAn/GKPv9H7k2WS
         mUNqsFX95Z8gO0ysflAF8XH9Dq6HD3cioe8rTHSBXm9IY5jPI8UGw3HInA1sncptXfQQ
         fqzK+HcdvBgNQl3gXWdhI7HkJPh2C76KMRyvLg1OMGPLmTbsXjw4aQ0NIZRpANdHB7HT
         M0pQ==
X-Gm-Message-State: AAQBX9fizjvl2uF/21Gm+xWsPcuLlPqCFuKTnw0eFDFR7vzsZ9KK3WYt
        BiXogOu3tl+J4eJs/NIhZNzVkIdv2srsmIbXG8c=
X-Google-Smtp-Source: AKy350YEtmZvkRKbrZP0JupwIckeH8jk6XHajX9oLrJNa6AiLb+Tt3Djt4A71mPRRZcRxRb6OCxsuHXjxN4KaG5dqv4=
X-Received: by 2002:adf:ec82:0:b0:2ce:56eb:5892 with SMTP id
 z2-20020adfec82000000b002ce56eb5892mr1486107wrn.2.1679853100837; Sun, 26 Mar
 2023 10:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <20230326001535.149539-2-bigbeeshane@gmail.com> <10930783-e1dd-5e75-a2cc-a09af862d949@linaro.org>
 <CABnpCuCzdbWTTp1Gc6wWPsB80J5GYw1QzKtZzzyEYU456E=1JA@mail.gmail.com>
 <1b9c8e19-10f2-824d-9b50-51e7a9287bb1@linaro.org> <CABnpCuAWm7jh19JKukOquPnZCwHoJispgDPGJzjYy6T_BZSnbg@mail.gmail.com>
 <717bfba9-1d70-ef09-9193-853a57117926@linaro.org>
In-Reply-To: <717bfba9-1d70-ef09-9193-853a57117926@linaro.org>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Sun, 26 Mar 2023 18:51:29 +0100
Message-ID: <CABnpCuA7V9ti6BOoz+3Mq-f=PwgxL2K7rOhjo6tJ4QquSZbaSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: update rk3588 clock definitions
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

> Bootloader also does not use mainline DTS, so where is exactly the proble=
m?

In this case uboot does load the target DTB, and it seems a common
function in rockchips
downstream boot process, see :

https://github.com/rockchip-linux/u-boot/blob/ef1dd650042f61915c4859ecc9462=
3a09a3529fa/arch/arm/mach-rockchip/kernel_dtb.c#L70

It's a pretty nasty process, but unfortunately some devices will be
stuck with it I guess, and in
those cases they will have issues booting a mainline kernel.


Regards


On Sun, Mar 26, 2023 at 6:23=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/03/2023 18:59, Shane Francis wrote:
> > Hi Krzysztof
> >
> >
> >> So mention this in the commit msg.
> >
> >> Then commit msg should also mention it.
> >
> > Sorry for not expanding on this more in the initial commit message, I w=
ill
> > expand on this in the next patch set.
> >
> > However I think in general for most modern platforms it can be assumed
> > that replacing the bootloader is not always something that is achievabl=
e
> > for one reason or another
>
> Bootloader also does not use mainline DTS, so where is exactly the proble=
m?
>
> Best regards,
> Krzysztof
>
