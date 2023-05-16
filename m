Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E627055AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjEPSJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjEPSJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:09:35 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF9518C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:09:33 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-55a20a56a01so249010657b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684260572; x=1686852572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOOCBtnPBFwUcTzbyrJ0D+u8r9EEiyuqpPeng26UuJw=;
        b=qmxo71Iu51dxFxvJUFwzFuvE5d4/yYabhhGeWleeEm4S88WH1eWl0ErD0jyC4E4Yw4
         kTAlQonYg0MmNr6Lvn8vC+nHf2rA+KvFG+LWsMiS0LBHhEFghvMt8DKhK8ViUaFADlfy
         LgUNrPAHtqz0J/rOZuJLs6YHWWXNsyH5TMAwK2hQG+K+7JuqIl6X4+iOmZri0mYKJrkS
         vQfel+hfcdz3pLMvRD+0xBDdGTGaN9gCNPp4eRf3Yiy7WW9bTH+Nxd6snpjBwcr6/LXB
         F2T46T91x4YRYJakVsZrBKMVK9YMbm7l+sLh1ogMnYSjVAI8XOFtNd3Ghx0Ot/yr84ca
         nAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684260572; x=1686852572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOOCBtnPBFwUcTzbyrJ0D+u8r9EEiyuqpPeng26UuJw=;
        b=h/qBafDNhpMlbtEr9D3DhCnLOPC/sxp12vBh1G3U/T7pKD9Hn+l+oIXMtiFmKQBeve
         3i2VgB1OFbB8Q7oXmlCbv/t3DaI3tnKCE/CWqB9XBGTZ9eHpsystLV8oKvLtAq2Lj0fq
         ZWtWQr0ARWt2WqGHUPebX6zFp8LhTBtZoiP0t6AiSL2gLYhGw1JDWhIYGGc5PPf2Xzd5
         kN+ehGux1cRVu1ODIjGfHvyAkuogCLxP5oevMbe41Lf8A4MGDWcsmdSli9DerOnhN4Di
         zkvgYmAOsvNiswvea7MPAI3LM2t44z2MP9y6rsIIfQOFqF8A5gDuLEuD5jw9LYO7L6n8
         STmw==
X-Gm-Message-State: AC+VfDw9xiJFJkZHKgqGt2qql6LvXtgxIrxoXi96gmBISLqRNOWyuRPQ
        5CYofIS/a+tm9gbvgumxEi4oEGSD58HEB886Cha/tQ==
X-Google-Smtp-Source: ACHHUZ7XF6q2Bm1/49+wSfDCry1UkLwKzxIvfA8o0ztp9zAXasmfZmqYoLT5ce/cEdz0K4L4NDqNhKlG99yf44fNy44=
X-Received: by 2002:a81:6c45:0:b0:561:bae4:c377 with SMTP id
 h66-20020a816c45000000b00561bae4c377mr255712ywc.14.1684260572560; Tue, 16 May
 2023 11:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230426-stmpe-dt-bindings-v4-0-36fdd53d9919@linaro.org>
 <20230426-stmpe-dt-bindings-v4-1-36fdd53d9919@linaro.org> <CAMRc=MdsBiV3AvzSPtCuR58w0N9z7o+hUrBDtXUC4a++pECb8w@mail.gmail.com>
 <CACRpkdaJrB1f13LB4aHSWys63448a4NQZORgwdk8z=C8qe-BDA@mail.gmail.com> <CAMRc=Mf+RsU6PT7fwm=r9OLbmxNjiv9Ru8HEfpMEAqDN5-0Qig@mail.gmail.com>
In-Reply-To: <CAMRc=Mf+RsU6PT7fwm=r9OLbmxNjiv9Ru8HEfpMEAqDN5-0Qig@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 20:09:21 +0200
Message-ID: <CACRpkdbCiEtiXkhaoUMCqeqcOaTYu0hSp0cDTy8NzzwitfQL+g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: gpio: Convert STMPE GPIO to YAML schema
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:34=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Thu, May 11, 2023 at 10:39=E2=80=AFPM Linus Walleij <linus.walleij@lin=
aro.org> wrote:
> >
> > On Thu, May 11, 2023 at 4:58=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> >
> > > Applied, thanks!
> >
> > That works ... but patch 2/2 depends on this one. (uses $ref).
> > You'd have to give Lee an immutable branch that he can pull
> > before applying patch 2/2 so he has the dependency, or let him
> > apply both.
> >
> > Yours,
> > Linus Walleij
>
> Sure:
>
> The following changes since commit ac9a78681b921877518763ba0e89202254349d=
1b:
>
>   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
> tags/v6.4-stmpe-gpio
>
> for you to fetch changes up to 6c19974d1e83fba2cca1cbea2fbf250f093eb5ed:
>
>   dt-bindings: gpio: Convert STMPE GPIO to YAML schema (2023-05-11
> 16:58:04 +0200)

Hey cool :D

Lee if you pull this in you can apply 2/2 on top if it checks out.

Yours,
Linus Walleij
