Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF0172C7FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbjFLORj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbjFLORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:17:18 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057C33589;
        Mon, 12 Jun 2023 07:15:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-38c35975545so2627015b6e.1;
        Mon, 12 Jun 2023 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579298; x=1689171298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOx6mer2Y0xFwAlHeK7VBbHx/09765NLkewrCj3zx+Y=;
        b=Xm4+EAzsXGukgRlA9uQ7SswMSO6ou4ZbhpL0ZIA/gSytMrnxLjaA+b+tOB21QRGS0Q
         0onrjdR/+2Ce5Q7cwkUDbwf/nnkzIZeuJuY5kF+a0vcFRw3xp4PPbo3ao0SrL53rfJOp
         avC0oy/PoRms5aLTAiolXBPBlPLqfgt3gdlMDf4WERKme13KnaraXObCgqyAFYOJvsgw
         MsSWJc4G0ZlNFr1PF0pHuLplPiesuyoLh9bYkY7u7HFYKUVafmgT4XQseqHNkzYIKf0O
         3uHnrglgzdUQeKq6qFdTo7fRN6zE7kSdPRClbfZi7gJuLb8iEhkZaZ09P2LYBBLjZd8N
         S9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579298; x=1689171298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOx6mer2Y0xFwAlHeK7VBbHx/09765NLkewrCj3zx+Y=;
        b=WA2cKTl3ufP2+Su0xN6tD/iDKMpuIfyUATGi2WqvREKN8GNLWART379wtT/iLMY+bk
         90AE0yNXIKx+cccmfn5g4ohJkowpgCg5QSi2J5K/FGkWJ/mv1663BgwDulxk0CtMbUxJ
         IptTQP9uaG9jikwj43GQvLFgnGaUUsYiDcye3wEq65o2xnSzlEolw9Ach18rfVCkyQ88
         LahEygiDQ332LE+FL0y/DsK3nVoFVoZ2UGIoa94BpWORjKK8Eih+Vjq2yTSbpst/rnhY
         CRYj1j+pbs14OjWVVcAU93UNISKqRCgYBHuVJb8FH1S+znjHTT0Ayiac4yLV1L2YIdpq
         IIqg==
X-Gm-Message-State: AC+VfDzNf6G/RxzY1uBDOI8vrclaxZoP6m9RSoWanBBAOU3qCrgKkGg9
        V2r/vLBwiZkrf00291DM19GV0nxhQS9ZdaLYAog=
X-Google-Smtp-Source: ACHHUZ6Oh7TNKalmakidfKCbkahmgvWW5tzHcVOkdNDnRMGrUcsnGhx4I0KYX7WHaFzH9cmlzGiLEvmvQfcHdSyQeQw=
X-Received: by 2002:a05:6808:1506:b0:39a:acfe:4659 with SMTP id
 u6-20020a056808150600b0039aacfe4659mr5139127oiw.17.1686579297921; Mon, 12 Jun
 2023 07:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230612122926.107333-1-herve.codina@bootlin.com> <20230612122926.107333-9-herve.codina@bootlin.com>
In-Reply-To: <20230612122926.107333-9-herve.codina@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jun 2023 17:14:22 +0300
Message-ID: <CAHp75VcQzo2mUmqbBtZzCX3EarSHYx6ZfPm6BR_n7Uv_tGBK1A@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] iio: inkern: Replace a FIXME comment by a TODO one
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 3:30=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> This FIXME comment is more a TODO one.
> It is a note when someone will need for this currently unsupported case.

> Change from FIXME to TODO.

Suggested-by: Jonathan ... ?

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
