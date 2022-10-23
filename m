Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA466093B0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiJWNgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJWNgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:36:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251B767470;
        Sun, 23 Oct 2022 06:36:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l14so4729935wrw.2;
        Sun, 23 Oct 2022 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:references:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoVvCB1hQ8h8zDnqjfbOWIK1oHoE24MiFfun5t1upMI=;
        b=NEg55mCBKWVDjo1kRCfYA7EY4H2EQEKh4Gl4eI1jB7DDDdO7CXlXwFZUyrFc9kU9hj
         A8vziP1KkGF1mzhP/xlCKLHMuXX49jwpb6tftQqHjZPyIR4qOB/ng/5D/KXe5GbAeKvv
         OL5sYbR8wrUB0oKBeWCrnKhffMc8bdpIBsJXdROnNLU+7idU/jhWuPV3R7kzRRtvx4G1
         38qw2uWSn94M7qCT90MCAYEHjhpr9zdfWhU2D5KbyVRQBbmu4AW2XfvbaKvuYWdxq4Gh
         GCURUtzHBBi8IFjVrF0cTlJTvCSSx2UFqthe8+fSjRIizIhCNol4pN4RQc/FrP9uLoHw
         UfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:references:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MoVvCB1hQ8h8zDnqjfbOWIK1oHoE24MiFfun5t1upMI=;
        b=2ztBJWDRF0DSNP0pOuz6dbmPZ2ZCWBvFpR1hBncdOmGU55qD91KqXW35T7u9U2BOsE
         elGjjSdrN58+RCz6VPPtdz0f5SSL0NFdI6r1jRzxov5S+ILmlt4W4+lOSclWaXXnlXiD
         bLM/BwBUWjDl308I6eYsFerrhlxDG3OyiCiI/ntbpJHyrsrd6ejX8l7GIqW5v/ILAeOK
         mOLERypsfrJq3t7MyS2i8h7QXqSAuZ7vNWulGm/u106raRN2mMTAPPOFMPozwt95zOKR
         qgcCGrcz249Mjw4NKR6/NprjvYddyBiCJyxAaDLZuOupgc/nBVeNQjXMPyk/us9bGn9h
         H8kg==
X-Gm-Message-State: ACrzQf1hhN0ilFKIrXDSUCMd7TiyRQzhvE1CzkZ8KnY7dCx0IuHXvolZ
        Ry/KHPBeIpTMIdJqHjHPyy9RQ1j0zu7sFQ==
X-Google-Smtp-Source: AMsMyM4mIr8LjXfQVnRa7MLd87e5HsCXWHz50muclsSe9aXcKOfO16SurXYwJroewlShnZ3tBmFUWA==
X-Received: by 2002:a5d:47c2:0:b0:22e:4911:6925 with SMTP id o2-20020a5d47c2000000b0022e49116925mr18217396wrc.403.1666532163122;
        Sun, 23 Oct 2022 06:36:03 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id j18-20020adff012000000b00228fa832b7asm23675246wro.52.2022.10.23.06.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:36:02 -0700 (PDT)
References: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
 <GU66KR.0W1UC5ES8HSL1@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] ASoC: cleanups and improvements for jz4740-i2s
Date:   Sun, 23 Oct 2022 14:29:34 +0100
In-reply-to: <GU66KR.0W1UC5ES8HSL1@crapouillou.net>
Message-ID: <Nzxf3qjE8JgcBzxULU2xE5br4OnbgBVC@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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


Paul Cercueil <paul@crapouillou.net> writes:

> Hi Aidan,
>
> Le sam. 22 oct. 2022 =C3=A0 20:12:59 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> This series is a preparatory cleanup of the jz4740-i2s driver before
>> adding support for a new SoC. The two improvements are lifting
>> unnecessary restrictions on sample rates and formats -- the existing
>> ones appear to be derived from the limitations of the JZ4740's internal
>> codec and don't reflect the actual capabilities of the I2S controller.
>> I'm unable to test the series on any JZ47xx SoCs, but I have tested
>> on an X1000 (which is the SoC I'll be adding in a followup series).
>> Changes in v5:
>> * Drop 'mem' resource removal patch already upstream.
>> * Update FIFO flush bits fix to address Paul's review comments.
>> * Drop PLL clock name patch, that needs a different approach.
>> Link for v4: URLHERE
>
> Forgot something? ;)
>
> -Paul
>

Ah, sorry, that's why you shouldn't eat dinner between format-patch
and send-patch... :)

Link to v4: https://lore.kernel.org/alsa-devel/20220708160244.21933-1-aidan=
macdonald.0x0@gmail.com/

>> Aidan MacDonald (9):
>>   ASoC: jz4740-i2s: Handle independent FIFO flush bits
>>   ASoC: jz4740-i2s: Convert to regmap API
>>   ASoC: jz4740-i2s: Simplify using regmap fields
>>   ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
>>   ASoC: jz4740-i2s: Align macro values and sort includes
>>   ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
>>   ASoC: jz4740-i2s: Support continuous sample rate
>>   ASoC: jz4740-i2s: Move component functions near the component driver
>>   ASoC: jz4740-i2s: Refactor DAI probe/remove ops as component ops
>>  sound/soc/jz4740/Kconfig      |   1 +
>>  sound/soc/jz4740/jz4740-i2s.c | 455 ++++++++++++++++++----------------
>>  2 files changed, 243 insertions(+), 213 deletions(-)
>> --
>> 2.38.1
>>
