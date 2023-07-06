Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBE6749AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjGFLdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjGFLdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:33:10 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AE81727
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:33:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-676cc97ca74so127472b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 04:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688643188; x=1691235188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBA///uk720bFWE3dLLyUaJz2IB5x6XkswygeQlz+4Q=;
        b=JxJO+d4uzSTxJ2fF2toUC9woxojvsRwpyUY80xQLq8t2WNJGj/HNq8LIlhTp9+7bX2
         BtIQlcsqjrjc8f1JkTTXTY1Gupt8OSQ2IZrxCzwQIIr1PGKbK0AqdgZUiHXq7iLP+Nss
         q4/SUhu1n1adAYLLficaE/KFjO19z1hQO0m7oCo5hoIz2/uQyxBF4MhSHtKV3kie0b5Q
         zJIG4yBT2SkdSceiEHpG7A4ZjmTIGZdPYQYYTU1/AT637rEh9dnURlnNZZgqRGlDw1mZ
         lRk/nv7Y4kjWhSGp1y7ssfGFYMmRvayjk9FhQg4TuNUIY5vv7wODHj2uadbXh26TLZok
         AQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688643188; x=1691235188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBA///uk720bFWE3dLLyUaJz2IB5x6XkswygeQlz+4Q=;
        b=YvCgaktSEmr1ec0dSC694b3fKZhmuKO6m/M4mnrCidhZBPQwSBIZZvLhwA+G08HTjq
         oce9OzESP9ulnH6ISkYozEnTBbMqUzHxg0vpYDiMI7PMJ+djwZOcDtx0VV5MTwNMuYIh
         ifQOgZ9jmXdX49lKQPUQmyqamSTXpeCexvTfuaAijb93lXh9OHIZx7laRzgFINh3PW9+
         sjcsAAsVIGJ0k8AFK6kTPLOYEhF4DDaACcBCgXC+IkoWVXoyljx63ny3pDxX0LR7PzTe
         aZcFFEXqlXTxjpdpbfZS9+vJk/4I7GuCWiI+qiwpGavVPQiqmxpaxORvl2DvlT9Ie82N
         eB4g==
X-Gm-Message-State: ABy/qLYdUfPMU5uvgR53vrSgel8bMs76VxYUwAG2hgjqDKgrTquH1iiv
        XIc7IQFCn0HJXtCCoPObJT1Rls7b8oX+CzxZ1SWCwI3VE9si0g==
X-Google-Smtp-Source: APBJJlGFh/kKWEOFbD8l2/GsLDJj5JTKw1DEIDejRqTb9QUKteSEj/kbrP0Li8/S3pvYkKSEWGyxurF18028Ok6EdhE=
X-Received: by 2002:a05:6a20:54a9:b0:12d:77e:ba3 with SMTP id
 i41-20020a056a2054a900b0012d077e0ba3mr2051265pzk.0.1688643188564; Thu, 06 Jul
 2023 04:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <1652963808-14515-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5DtpoH0dLDX3=Sv4UUpX_=66VEZPsJUWQNnYviApfMLKQ@mail.gmail.com>
 <20230706084706.bzwsbi3zisx5m5rl@fatal.se> <CAOMZO5CCdaodWQrHUQgMizoES=jfEtw-sNJZG-DJMpRD8tZW9g@mail.gmail.com>
 <CAA+D8ANAg7bs0A35c7Af3_-5sLaqvT1RoKfCbzYi=z=t_q9LUw@mail.gmail.com>
In-Reply-To: <CAA+D8ANAg7bs0A35c7Af3_-5sLaqvT1RoKfCbzYi=z=t_q9LUw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Jul 2023 08:32:57 -0300
Message-ID: <CAOMZO5BtrKwrMwrjVDbYn3ivt2uV9rzbSDxd8qfiYjOBMvKBgg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Andreas Henriksson <andreas@fatal.se>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Hans_S=C3=B6derlund?= <hans.soderlund@realbit.se>
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

On Thu, Jul 6, 2023 at 8:19=E2=80=AFAM Shengjiu Wang <shengjiu.wang@gmail.c=
om> wrote:

> No, this is the code in probe().
> The code with the issue is in fsl_sai_set_bclk().

Yes, I put it in the wrong place.

> The clean way for fixing is to remove the code in fsl_sai_set_bclk()
> and add "fsl,sai-mclk-direction-output;" property in dts for some
> node.

Yes, what about this?

--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -507,7 +507,7 @@ static int fsl_sai_set_bclk(struct snd_soc_dai
*dai, bool tx, u32 freq)
                                   savediv / 2 - 1);
        }

-       if (sai->soc_data->max_register >=3D FSL_SAI_MCTL) {
+       if (sai->soc_data->max_register >=3D FSL_SAI_MCTL  &&
sai->mclk_direction_output) {
                /* SAI is in master mode at this point, so enable MCLK */
                regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
                                   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_=
EN);
