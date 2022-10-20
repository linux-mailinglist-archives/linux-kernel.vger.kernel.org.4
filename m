Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E437E605F89
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJTL7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiJTL7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:59:20 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371A513C1C7;
        Thu, 20 Oct 2022 04:59:15 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o22so12569429qkl.8;
        Thu, 20 Oct 2022 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyMFpOElofDJZNk00pkycBZ1li0ZG0mlfPkJtReDgXg=;
        b=M70nAw73IR0CoIQ1ALAjyz+N3PNZkFAK4loZ76XpYp1+Dt/qsWYX4pYeErmz8EBQjU
         Gj+p/bw1TxgnwU3/VlMs6R54YCeWqYdSAw283lANOTVZZLL7gifAPfELCnmDOhzH0/gQ
         omMd4iVLWmilF+W8Z8pN7HT0uYg/WzMGqoB+v1vQdLS6VIVcJGN9JrmKYwBdeXYi1V2T
         OdGTAxprj9dSnJ0pjXuM8Y7Ow84kWwuQ8BBzxMFnS9izGqJtfJ2JVACpMep9KowEY52R
         F06h9LTKVseezN6xk215VHTpfkQQJBdWUmxV7gz+Ng2naph1TMNQjwYO6OkRVATnl9kN
         yzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyMFpOElofDJZNk00pkycBZ1li0ZG0mlfPkJtReDgXg=;
        b=f04/OcnkvhxkeNXc2lWsgru0NzvKsLMz4yNY+xRHklqcIbn7oLnf3+fYnUkcCk3u9G
         1Sbejt8VEnEAqdXQuRSfSD9os96Ed83q4V/qdvqE8qRF+kqQiN5X2OiJYQ+Wd9r1OfJH
         zdoskzD70BaVEJWWuzr6j8Wy1Lj0hwRGlnE+/kjxCg1Lq8e9SikM+wPyROWZkwY84mj/
         ptY29RXekUnsg0MT/Zm88n25WlDa1Yi5B+fUJIh775rvKES5YUvleUo511JWLc8n70Oj
         3gz0wzaGzVygfTZ5MCHJruKpSDxArF1FTfiqxPaSGar2CF8xKy1HjniItXubX5LMKdmT
         soyA==
X-Gm-Message-State: ACrzQf0hTII/uQvuEFQxM0Y8nBFYpqUVjpoigCAtsfr+KNhleTOvphlA
        MuTBIZOedwqeSzHmf+jX7QUa/qGFJGCpvTM7TYG20TOJiw+ZzUWZ
X-Google-Smtp-Source: AMsMyM48UrLUGogQxyXHnQZ/YxaD4IPpxciQFU4nObHIDhoME9mQfyCSu++KX6/H9lb/F3oLZXexRKCOapJJelT0MN8=
X-Received: by 2002:a05:6638:3c45:b0:363:afb2:3269 with SMTP id
 bg5-20020a0566383c4500b00363afb23269mr9854117jab.215.1666267143179; Thu, 20
 Oct 2022 04:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221016132648.3011729-1-lis8215@gmail.com> <166609251307.155136.11548088283059583394.b4-ty@kernel.org>
In-Reply-To: <166609251307.155136.11548088283059583394.b4-ty@kernel.org>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Thu, 20 Oct 2022 14:58:51 +0300
Message-ID: <CAKNVLfbfRRE3O2uFH6MQxoa_cdqTUcvpGzmcxFm3oCLKFfHv6w@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] ASoC: codecs: jz4725b: Various improvements and fixes
To:     Mark Brown <broonie@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-mips@vger.kernel.org, alsa-devel@alsa-project.org
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

=D0=B2=D1=82, 18 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 14:28, Mark Brown =
<broonie@kernel.org>:
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-=
next
>
> Thanks!

Great! Thank you!

Unfortunately I found a critical bug in my patchset, yet easy to fix.
So I need some help to make and send the fix.

> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.

What are mailing lists it needs to be sent to?
Any additional tags needed? I know about Fixes tag.
Do I need to keep a link on this patchset somehow?
Do I need to mail a patch with the fix to this thread or
create a new one?

PS: the patch will look like:
 - {"ADC Sourc Capture Routee", "Line In", "Line In"},
 + {"ADC Source Capture Route", "Line In", "Line In"},

Thanks in advance,
Siarhei
