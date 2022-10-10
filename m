Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D52E5FA106
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJJPUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJJPUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:20:38 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6120A5EDF1;
        Mon, 10 Oct 2022 08:20:36 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 137so4445989iou.9;
        Mon, 10 Oct 2022 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcKHzg1i2Me8EqhKFtNfioe60y1iB3hPVRhH6rIJCT4=;
        b=TBb+j24Tql7lMGBRzux71qaHiImguWET6ioHZwhlZ4PdQUXhkEUgc9YOW2brTKqdnU
         8zTdhhtE7FUBVfXd1p7V5o1v4uCOYImJzPziLfaBNtDjB6Lrev5IY7SQNgg3pn5bQSMo
         wLW9nC2azr6mXZPGtkuHgN7gGw8TMPg79Qe0VkSK8fjyc7/4zb1PCeDnQBZmDTzglw8j
         /X5XK38i7eIYFwkLSxF6OUHXkgi42yJ8QQcXEtPTdKVOm+4NKMB8BmKaGRvvfzn+j3Hz
         zSDOr32ibJj4YfXyruWXwLovx8aJxum1btItTe2ySVpLb3/D8dHAF3u1P9O+GaFv+WqJ
         Feuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcKHzg1i2Me8EqhKFtNfioe60y1iB3hPVRhH6rIJCT4=;
        b=Le1Y94NW+uPgQTR+714NpkpyKOibwOKtbURteqZzZcsudGtM0V3zVweUezY+Tz+GtL
         DssTu8d+NNt7zKFVoAT4rFXfREFrh2qfi9r84bLvdALYR6A2q16IEWW0eN2JfKNvIm4M
         xgG45He4SWTGGP1TtT1P0SVz2+BP67+WoGzTzKzRBn1CMCJHyJ3vKKR45fLCxLdYRRZs
         fShxJL//pe3+CKqFHvrbhP9745FxBNjJ63CvUKhkXxuUuFlSCvHeNRW3NezB8zb/UILy
         sViRLIQvzcjlkXB1lwbs+n/QonX8RAZOFZgqzRd6TeQ2jKyZ88rKLKj6UBXPEeCynYex
         SsBg==
X-Gm-Message-State: ACrzQf2ZBU+8ETk3Pr2EzQHta+1Y9xTFngObGltU0rAVvBDktNJx7usn
        m6QCOzTBJJSbwK2tXt2ZtNYmG/Nyr5s2fXR0i8U=
X-Google-Smtp-Source: AMsMyM7BgrMi5isfnHCX6JolmakAtvlRr3ULiJstScINCNYrgAduBakCoqPks5lDMlMfN79tBnKa/M8p1ql8Zm59T9A=
X-Received: by 2002:a6b:6f02:0:b0:6bc:15d8:3446 with SMTP id
 k2-20020a6b6f02000000b006bc15d83446mr3512864ioc.108.1665415235626; Mon, 10
 Oct 2022 08:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221008181655.2747857-1-lis8215@gmail.com> <Y0P/u4pJT8rup8Za@sirena.org.uk>
In-Reply-To: <Y0P/u4pJT8rup8Za@sirena.org.uk>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Mon, 10 Oct 2022 18:20:24 +0300
Message-ID: <CAKNVLfZhH3s=jBWAoSppXSotY9giRRJbub9MqxCtjdZKh4fprg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: jz4725b: Various improvements and fixes
To:     Mark Brown <broonie@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

=D0=BF=D0=BD, 10 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 14:19, Mark Brown =
<broonie@kernel.org>:
> As covered in submitting-patches.rst this should really be split up into
> multiple patches, with one change per patch.  This is especially the
> case here since you have a mix of fixes and new features which should be
> applied differently.

Got it, will rework.

> > -     SOC_DOUBLE_R_TLV("Master Capture Volume",
> > +     SOC_DOUBLE_TLV("Master Capture Volume",
> > +                    JZ4725B_CODEC_REG_CGR10,
> > +                    REG_CGR10_GIL_OFFSET,
> > +                    REG_CGR10_GIR_OFFSET,
> > +                    0xf, 0, jz4725b_adc_tlv),
> > +     SOC_DOUBLE_R_TLV("Mixer Line In Bypass Playback Volume",
> >                        JZ4725B_CODEC_REG_CGR3,
>
> This doesn't appear to correspond to what your patch description said

I forgot to mention that in the description, thanks.

> and will presumably cause problems for any existing configurations...

I'm curious why this didn't cause problems earlier, as the wrong
control was used
for the Master Capture Volume.
