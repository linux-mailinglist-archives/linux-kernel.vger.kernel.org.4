Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E787F70523F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjEPPeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjEPPed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:34:33 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE567EF0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:34:31 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-77d456fa0dbso4735138241.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684251270; x=1686843270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvdEFRzutnbNOOurn60T1w5qVmFLZEprgNl0tF1OCLU=;
        b=tZVNSEGczk6kIRbArRY4cT/mlLGwGfeFEZC4vS6WmlRMOls5d8PmqRrLKMEDSZ7GMO
         eJfDXy/lUNmgKxKOYPOirx0QdqTi2brRnvQas/Q5iwI1OY8cu634PHz2WZkYLlRJ5DM3
         wpOjIXL0HnUomCYNJemdDzBpvfWBBuIytX4NppipIL0y0B/tY0P3UZeGK341HTCTLTRT
         A7zGY3V4+y+0ors7BTT9n3iEnkvkbkSUZvXKu7foGVRPGUjZ8YSkUHn5tyfMzgz0D4oR
         xxIJxVa8F9xH0YeMWc1g+w2j3KWD5t6Ud8hg85Tgt5vTk3utd/0jzDJl93mHAhoZJdgl
         4Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684251270; x=1686843270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvdEFRzutnbNOOurn60T1w5qVmFLZEprgNl0tF1OCLU=;
        b=SckAL9ylyg8Nuxu971FmLgPqxMGZuMHPFMvOEzbt7uanuROzEO3PS81py2+uoJJ4X+
         oThQxfUHALe6rJ+sIpcIbEQXqsQUXCUSotLDYvuS7N6xURw/AFD+z2aYAIYuXloLCWNP
         c9zXiL3D4zbjCfMOo7KR6y5lUTlm3I6TYZSb15Z/dRUBIAa1mkDr1hUiLVxyUh4m3uag
         mKSlvEeaNo4ik64yrYpxOSivVWS19m8drcEev8AXBnL9hwizhQtHwpfnsaoBm7R5uuRR
         7kHMYbJ8e6XJP1ZtC6ycjVN7JZfzEm9OvqxRP6eGbdGGumvEW2vvFwJ9W1/dE2YMdEyL
         izoQ==
X-Gm-Message-State: AC+VfDynGgq92/KWUoNQ9VC05o+TJdLcjavc3UA6JADvMsIXru/RdnPA
        GaYsbiypSN6deCz9jDLQBMGPMIkELWZFUVL5g3lE0w==
X-Google-Smtp-Source: ACHHUZ5sCb0e2/K3Uf+Pa17albTb/UYZ+MkMOgqzIyHbPaxLBkNnJDii6OJqSgfWeqRTkGUNL2gYv09etbeSxK8EXMo=
X-Received: by 2002:a67:ee55:0:b0:434:711e:e2c4 with SMTP id
 g21-20020a67ee55000000b00434711ee2c4mr15531301vsp.14.1684251270212; Tue, 16
 May 2023 08:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230426-stmpe-dt-bindings-v4-0-36fdd53d9919@linaro.org>
 <20230426-stmpe-dt-bindings-v4-1-36fdd53d9919@linaro.org> <CAMRc=MdsBiV3AvzSPtCuR58w0N9z7o+hUrBDtXUC4a++pECb8w@mail.gmail.com>
 <CACRpkdaJrB1f13LB4aHSWys63448a4NQZORgwdk8z=C8qe-BDA@mail.gmail.com>
In-Reply-To: <CACRpkdaJrB1f13LB4aHSWys63448a4NQZORgwdk8z=C8qe-BDA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 16 May 2023 17:34:19 +0200
Message-ID: <CAMRc=Mf+RsU6PT7fwm=r9OLbmxNjiv9Ru8HEfpMEAqDN5-0Qig@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: gpio: Convert STMPE GPIO to YAML schema
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee@kernel.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:39=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Thu, May 11, 2023 at 4:58=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > Applied, thanks!
>
> That works ... but patch 2/2 depends on this one. (uses $ref).
> You'd have to give Lee an immutable branch that he can pull
> before applying patch 2/2 so he has the dependency, or let him
> apply both.
>
> Yours,
> Linus Walleij

Sure:

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b=
:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
tags/v6.4-stmpe-gpio

for you to fetch changes up to 6c19974d1e83fba2cca1cbea2fbf250f093eb5ed:

  dt-bindings: gpio: Convert STMPE GPIO to YAML schema (2023-05-11
16:58:04 +0200)

Bart
