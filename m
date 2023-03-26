Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994D36C9704
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjCZQ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCZQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:59:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6AA55B5;
        Sun, 26 Mar 2023 09:59:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l27so6329838wrb.2;
        Sun, 26 Mar 2023 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679849976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4onfKPR5OV3H8ezXvNnqQtHHZOpBtrzFFIqmv0blz20=;
        b=F6M99Gu/29cxqx2Ny1B34fJ6KzEVNqQUdeB6+w5fcVYc0G5Mnyebxly18qN5QkEJ7W
         W1Tye1OHF4qPYf9f9FnR/uIw/eWztZjw1nAyhLq6F3a9aMUi1zrSlBGbHkN3hc2SGF3s
         A6dciSwZbxpNodkOORZC8UsKRiWw0N2fC6Uh2NfetPQi5WkjJzonMSdO/ENp38KrnBu9
         H0r9WKPZHiYdwNDMjodf1f7ogn23kfq8EHQQ7u79EY+Ncn26AFr419javWSP6zepK3FR
         1xjpU3GSabT9vpPSK9r7uEYE86R5aRzOWa8Qt4vNjzWEPiD65Qk7VYU6gSja7A3Q6Vr5
         tcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679849976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4onfKPR5OV3H8ezXvNnqQtHHZOpBtrzFFIqmv0blz20=;
        b=Jz6EblTryChG1tKO7NxQwT3WN6ZAt4FSjnj8fTeyRyKBwv9rJybR80s1N6f7rhqYVK
         +X/nwKWaABsMaCdgIf2quaVRWAarhjwSV/b2qlORR1Gu+B3kAarkM2+C5DWpIm6SyYRU
         BNavmdZ23KYfazhV8udjtKZ1VWVwsjHstDPxCEzuedImMLvEdQT5ioOQJgxmXhawePcz
         o3OksBtC5omMMpeSLAsEaNQcKCyFC4Y4K+WDTffSfBI1iTMjnbI5IUzSgjkpfheIKIe/
         PGiIGTOJbnMqf5tu03IFGFi2jjTGgZOnGujUUUkNFyR8RrKTTQIla56pP1RXCq3twwYe
         Zpmg==
X-Gm-Message-State: AAQBX9e0XJ5lvjOm7hqzjcaZzkPJhMkVlC539bXKZoJa/3n3LMPxVF+i
        He9Ri3VtzoyRCrb6PnCbGDxHnoAOkb97d9ZLVHE=
X-Google-Smtp-Source: AKy350auyOW51dcsEwSuS3Tg3x334Pt9EVII6MmtPIIGeMOP0puGxpIVEQCLy7aqA7YGXMxkjfHF7nEUR6fKBM9dO5Q=
X-Received: by 2002:adf:ec82:0:b0:2c7:156c:ae8d with SMTP id
 z2-20020adfec82000000b002c7156cae8dmr1819274wrn.2.1679849976117; Sun, 26 Mar
 2023 09:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <20230326001535.149539-2-bigbeeshane@gmail.com> <10930783-e1dd-5e75-a2cc-a09af862d949@linaro.org>
 <CABnpCuCzdbWTTp1Gc6wWPsB80J5GYw1QzKtZzzyEYU456E=1JA@mail.gmail.com> <1b9c8e19-10f2-824d-9b50-51e7a9287bb1@linaro.org>
In-Reply-To: <1b9c8e19-10f2-824d-9b50-51e7a9287bb1@linaro.org>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Sun, 26 Mar 2023 17:59:25 +0100
Message-ID: <CABnpCuAWm7jh19JKukOquPnZCwHoJispgDPGJzjYy6T_BZSnbg@mail.gmail.com>
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

Hi Krzysztof


> So mention this in the commit msg.

> Then commit msg should also mention it.

Sorry for not expanding on this more in the initial commit message, I will
expand on this in the next patch set.

However I think in general for most modern platforms it can be assumed
that replacing the bootloader is not always something that is achievable
for one reason or another


Thanks In Advance

On Sun, Mar 26, 2023 at 3:51=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/03/2023 14:02, Shane Francis wrote:
> >> Please wrap commit message according to > > Linux coding style /
> > submission
> >
> > Will do, I haven't submitted patches for a while totally forgot the
> > wrapping guidelines
> >
> >> Unfortunately the reason is not good enough > for ABI break. Replace
> >> vendor boot uboots with open-source one or > just correct them (it's s=
till
> >> U-Boot so even for vendor one you have the source).
> >
> > Replacing uboot is fine for this case, however I can foresee that can c=
ause
> > issues further down the line.
> >
> >
> > 1. No uboot source from the vendor, we all know no everyone respects co=
de
> > licencing
> >
> > 2. Secure environments (like android tables), this chipset will likely =
end
> > up in android tablets that have the secure boot chain enable. These wil=
l be
> > unable to replace uboot even if source is available.
>
> So mention this in the commit msg.
>
> >
> > As this SoC is new to the Linux kernel (not even useable for much it's
> > current state) would it not be better to aling on this so vendor and
> > mainline DTS "agree" now rather than possibly have to address is in the
> > future ?
>
> Then commit msg should also mention it.
>
>
>
> Best regards,
> Krzysztof
>
