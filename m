Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED773A2A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjFVOJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjFVOJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:09:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46604E2;
        Thu, 22 Jun 2023 07:09:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-988b204ce5fso584519466b.3;
        Thu, 22 Jun 2023 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687442957; x=1690034957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAtPTyoV3UhGL+5nkAK0G/poQIs7q3wI78CdBfj2Pgc=;
        b=JTLG41Ac/dzcege4isOrjYrzeaRKZUIGevjdcyPM/ypROXoxCNvPhxgyEmmpxKWQh6
         v1Kz4TMyJgI9ERmsXewOUzibglaWyWCx8MMGh1krnU+I9Z8B1VmxUzDU7cNcY3//fH79
         kakxVxAIak+hA9+UPnQQythBaEhUB0MJ0w65mZQiRcLl8OMryN4vyjzh9WnhQVWplKsT
         DzjUvka8R/33H12jho5SqV17Fzqxvd/A8nf76Z3PFk5T68ByhT8G2tm60JHY0UQnbCg/
         +zbJpX/947puBDenS2opHNCnjtWdrVWjjvUHm3AH9Km0f14sLVSGBXcPU3EpCcI3BRSj
         7CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687442957; x=1690034957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAtPTyoV3UhGL+5nkAK0G/poQIs7q3wI78CdBfj2Pgc=;
        b=bg5R8TGYfa0OIDEiqaMs5EaIl2s8/UkV3wffLsn3sQVIt8y9vSTZEwtcgD5aPAcZD1
         acPssN6FiG1X3tKshRLZLAq4LzpRA4hJNBffvqyr9FvzOi7gGzfp+ePZFYCDMPQFoExF
         u3NppGjjdUl7/9RrYt+TsQFT52RxKjD32JmZTtHq+XRyRLNElwsdMkKyKK+w10kQYC19
         8gPJqRWZEUV6QlbNUkryBK0Isvxi8PUYnOfVHdhJIrc1AkkuK6ui0+/3R5HJ0oSOcxgm
         JTGmCqziRTXZv7BXYOWyMSvT46mYj4m4Xmt/BVAVzgSpB+gR9LNrACzGXtPyDymhhzn6
         ZQ7g==
X-Gm-Message-State: AC+VfDzfGZVQtL8y/xVbA9xu/zenC2HcQ2pkhxpz2x1a00iIzJkkJBVh
        fg+hJ2Uc5ewn9FywHHJMoVUOztUmj+CtKWL7zII=
X-Google-Smtp-Source: ACHHUZ5pzjeQRJqs/lr8FYXwqoFgoRFaBJky8QvaNPcbryNKOQtG5+vu148+3/ZqjIPWF2Qvr6fC4rt3h7fCW6Ov3t0=
X-Received: by 2002:a17:907:2d88:b0:988:56d1:10ca with SMTP id
 gt8-20020a1709072d8800b0098856d110camr13336128ejc.66.1687442956463; Thu, 22
 Jun 2023 07:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230615152631.224529-1-herve.codina@bootlin.com>
 <20230615152631.224529-8-herve.codina@bootlin.com> <70697b976107473b8779eea7d6c8a189@AcuMS.aculab.com>
 <20230622143233.7300a813@bootlin.com>
In-Reply-To: <20230622143233.7300a813@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Jun 2023 17:08:40 +0300
Message-ID: <CAHp75VfNdTwQ3Y5Q=uUaaJuFAm4iqj6cQZ-axOfLkfv9NoAqHw@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] minmax: Introduce {min,max}_array()
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
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

On Thu, Jun 22, 2023 at 3:32=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
> On Tue, 20 Jun 2023 11:45:01 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> > From: Herve Codina
> > > Sent: 15 June 2023 16:26

> I didn't plan to change the {min,max}_array() macros in this series as yo=
u
> suggest.
>
> Maybe min()/max() is too strict but it's a way to be sure about the type
> used. Also the current version doesn't need any extra cast to get rid of
> the integer promotion as the integer promotion doesn't occur.
>
> Is it ok for you if we keep as it ?

I think the current verison is good enough, and as Mark said we may
update incrementally if ever needed.

--=20
With Best Regards,
Andy Shevchenko
