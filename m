Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205026CC097
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjC1NXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjC1NXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:23:42 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3571BC8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:23:41 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-544787916d9so228673517b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680009820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN1b6npRLarblKw5i5atBP5jClBJ0vCtjy5w1VWhxXA=;
        b=Pql8qAnzhif297YaQ4JCmJPG193WZZVk+Spat/kRLs7rSnsqPe9S28jeqcZKvgcAVc
         0ySMGzB4tcx9t4d3vdXbH523KSvfMsK2MOXLksCctKVSka31JEyhGPBY3/o9g/AdKJU1
         bafWHe/kA3hjKT6ii77W9npUJOi0WudZCa3VO/E4Azt+ftK7de7+cd8IB9+XZnTTZU+x
         u+5QqWZLqOzaEcY8S917fCQn9oltFrZt57zADXUNVfn2ET6wFGlcbUN5sCknQqGmd7QJ
         VUnudEuYvTeudlDzu/yhvvpdN+jVOAOPo2Fh4RO0nhCMS/CQZ84PvpmReq4XG/A8g0cR
         vtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN1b6npRLarblKw5i5atBP5jClBJ0vCtjy5w1VWhxXA=;
        b=a6syAjOu24mamMIzACywuTZwno1ooFxGcF335l7Pgr3f5MBAtKGHvYFKjRXNJac1Tv
         o4aqOeE2Ol4ISpTInWtHj0vEe8ZSSQFaB2ykEqsjGNupgneQpp5+425xpiMuSFo7SssV
         gO0ixc+G+wamQOnXu5872o/L8uLY9joJbIk9m1UF71T995lDYeZgpSb1hTo9a1VBNebu
         vuyPe0C4GBUfOKu14RJ1rvAnPlOIbkUGth2JQNS/AkvYoTR3otssmNMGiJUBcXH4Abpq
         4XLX7kONIgu2UaEhN6uV9fBZePz5fjCHazg8/2+utZScdH98YYZhDzo5R5NQ774ggG9R
         x5qQ==
X-Gm-Message-State: AAQBX9d4tBYhUeK+lGtGb9ZWwVzhC+qQYqFfOR+TiZdIiOwPw0hQmILW
        2kWnMe+UvoGpHJPzKyePyLOdphq1Rud2o4eN9OTN8A==
X-Google-Smtp-Source: AKy350Zx9Hs56PMUd8+ClhRLkSDffrITE9nzK+MK5EmCeupSs5mP2SRzKYpscVDyHcwUiHfgqkRYKoyq4uJZKXf0i+c=
X-Received: by 2002:a81:c84a:0:b0:541:753d:32f9 with SMTP id
 k10-20020a81c84a000000b00541753d32f9mr7120854ywl.9.1680009820193; Tue, 28 Mar
 2023 06:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230314183043.619997-1-brgl@bgdev.pl> <20230314183043.619997-13-brgl@bgdev.pl>
 <CACRpkdanAd8J2b4Ky=2jmwchVi9_yojnUQoM1OrzW79_inFV4A@mail.gmail.com> <CACMJSeuJm1qA4dc1fftq9JNe_a0dvRnAZvDeG9C5FEXQsqNABg@mail.gmail.com>
In-Reply-To: <CACMJSeuJm1qA4dc1fftq9JNe_a0dvRnAZvDeG9C5FEXQsqNABg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Mar 2023 15:23:29 +0200
Message-ID: <CACRpkdZcs3+BPMAvr215pNSCQVJ_Cpk07A0=x1=-7m2_Q-v=rA@mail.gmail.com>
Subject: Re: [PATCH 12/14] dt-bindings: pinctrl: qcom,pmic-gpio: add
 compatible for pmm8654au-gpio
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 2:30=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
> On Thu, 23 Mar 2023 at 09:23, Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> > On Tue, Mar 14, 2023 at 7:31=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Add a new compatible for the GPIO controller on the pm8654au PMIC. It
> > > has 12 pins with no holes.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> >
> > Bartosz are these two something I should apply to the pinctrl
> > tree or will you queue them?
> > Either way:
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
>
> I think it's better if Bjorn takes it through the arm-msm tree if you
> don't mind.

That's fine, I'll ACK the latest version so Bjorn can apply it.

Yours,
Linus Walleij
