Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC2E5FA89E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJJXWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJJXWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:22:36 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DFB7CB65;
        Mon, 10 Oct 2022 16:22:35 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id u10so6366770ilm.5;
        Mon, 10 Oct 2022 16:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXda3aTJALziQd8LZ4HyvmpbEN2s8N724Nf4X7JuxXw=;
        b=DiCdkPM3ayZgQGw1oFuPR+4CcnJaM+6jx805hFxp2dG/evzVYwc9uJGBEMQw9hKuPq
         jET16b5fYgzd8HR197N65zcF5rT20s0WAAbGdvymCm35MsSdRnafDNob5dvU0FVwWfHn
         y3A1GONfWWf7HIdBBekyJWNoM0cRyhzdEuypCmSW5jo6HJMnPXSGokfRN8GZp0BH24i3
         y8srnBDgwJlaQeZJEp3tPcWel4/OA0W4WuCntjouXcTKhx96LxBAV1F/VkzR1aBib6Hb
         jgqiJ+S2efWODcW/SpUbbfURA15rqAPmIMwQ1MCDbJqmc69kewk86UNQznnW3KQGKoS9
         NgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXda3aTJALziQd8LZ4HyvmpbEN2s8N724Nf4X7JuxXw=;
        b=Rjl28wIrIeXNNCc6rHFkShSwgqW9UkcsTZ1Q8JVxPlHUmv+nQIQXB4F9zmebrdWTk0
         cxil0yh4qaBcOEc/e1f5pxVauiDkYwAg+O3D6J3vmePuMiVQfV+lsHgpm7NvS1pg+qag
         afB9z9Sd2Nyj1tCLZG/sdvWPSygp31AIgWQwY22gWJn7RPi1HHf9cFHM+HaOCm9HzuCF
         MxSkjem9ESVt7S+SSNDEJZrCjsCsRJ8RQFDqBIzHVNqtglXKB3CpDSgps4WOD/JMrq/x
         lUVK7LaYod0+T8DTgg2z54kq/rcy/BkJrTPF+VWVVyHhvmkr9W9VCxjcE+C9XtXl6hav
         4z1w==
X-Gm-Message-State: ACrzQf0AJlTWD9zfrZGQMTmAmDXOMfor/+8XL+So4DXO7eYgMYe0jhB2
        JmoKRhQ5YUd9pW05lbYrq7ggCqVgTw2yKA==
X-Google-Smtp-Source: AMsMyM6czbGTLFOK8h5xrObQR2p50k9F6EeWMjxD0SKBxhkM17PfkoMsy3Ks6dj7cIpjBmV3+OJFGg==
X-Received: by 2002:a92:ca4d:0:b0:2f9:3e9e:e566 with SMTP id q13-20020a92ca4d000000b002f93e9ee566mr10533363ilo.165.1665444154326;
        Mon, 10 Oct 2022 16:22:34 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::deb2])
        by smtp.gmail.com with UTF8SMTPSA id d3-20020a056e020be300b002f584a19a79sm4207450ilu.34.2022.10.10.16.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 16:22:33 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v9 0/3] SDM670 Pin Control Driver
Date:   Mon, 10 Oct 2022 19:22:25 -0400
Message-Id: <20221010232225.209700-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <Y0POmQ+xrQ/HT7RF@google.com>
References: <20221007213241.84962-1-mailingradian@gmail.com> <Y0POmQ+xrQ/HT7RF@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 07 Oct 2022, Richard Acayan wrote:
> > Richard Acayan (3):
> >   dt-bindings: pinctrl: qcom: add sdm670 pinctrl
> >   pinctrl: qcom: do not reinitialize gpio valid mask
> >   pinctrl: qcom: add sdm670 pinctrl
> > 
> >  .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    |  127 ++
> >  drivers/pinctrl/qcom/Kconfig                  |    9 +
> >  drivers/pinctrl/qcom/Makefile                 |    1 +
> >  drivers/pinctrl/qcom/pinctrl-msm.c            |    3 +-
> >  drivers/pinctrl/qcom/pinctrl-sdm670.c         | 1345 +++++++++++++++++
> 
> And I'm receiving this because ... ?

You wrote a patch a few years ago, then supposedly changed your email, and I
wanted to know if there's anything we should consider before removing some of
the code you wrote for it (in patch 2). After I added you as a recipient, it got
a review tag, so I don't know what input you can give now (unless it's
important). My bad for not removing you yet.

Link: https://lore.kernel.org/all/20190610084213.1052-3-lee.jones@linaro.org/

> 
> >  5 files changed, 1483 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> >  create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c
> > 
