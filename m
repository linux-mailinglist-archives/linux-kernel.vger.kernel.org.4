Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1281749A3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjGFLIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjGFLIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:08:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D24DC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:08:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5344d45bfb0so24506a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688641691; x=1691233691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G84Dw5Ig2Kfn04ePqxCMIByfKhRpoEBfGjJKCC/CPmY=;
        b=lpWMMMk4+M0UTvc4sZgFla6gp1hZlkV4OKhMXVYtfsGRR5RgjYLg8+nN57lnngqdDr
         roBBzjzs1kupP1nDWffXYGrAJSCQTf0NzR+moyuBLb05NGn+eACyWiSj7VHaR+70lUUj
         FBp+UVssD1OqIRFeOoQEnEaJaYnSqWz+ABco3/EWzVtaZtkc9Y3TuoHzObw1MtKte6qw
         LPt0Pd0oMmqXx8yXG0tsAUaYYL5E1WMWnf4grrV7EshAJjOb3mjlcau7K9mR1lGGB/Oy
         ISDa/m3wtaENvJrpUL6WXLSPEDRhI51vdn050i5eU/m6Xz0p88291mqwWp3J1DuV0SJe
         rh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688641691; x=1691233691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G84Dw5Ig2Kfn04ePqxCMIByfKhRpoEBfGjJKCC/CPmY=;
        b=DTvjWnIFM+51vPnnKQDQ5iFDL1So2sC+QzipPRDyfv6ON5Jpkbehb/kXe+gCYOS95q
         S8mljatr1Ns0vTW71z/K04GgAxC3zNfD43d99hyc7nBSHcNJxasAt0DLo6xcsCh+VjYj
         bOdbMyilTP6kizGdLpcgcst6QE2YrL9Behcu3Qlx5Chcrw/8AJaBZMd5NqPrhxVbQc30
         LYHUC8TMeChjrAbC+bXDLomdNuRhsSHoLK1ZfIPTd4YeWUba22amLgj525InNCMhkSfh
         8bOwofqdfSvC8EckN3404aQtnd772SjLAscXbSW14piIBsazB2AQqplzItJhBFGSLb2L
         PRZw==
X-Gm-Message-State: ABy/qLbqFjF0Vkpfb4CseJJJDOKuaoANV5CAz8o+ZpYwrNRO/YUfPpDf
        wUbSs+x39jfMuDJF2LYawGA8za1ghloEaGtt5Yw=
X-Google-Smtp-Source: APBJJlEfvnVo+6BfRY2TBz2YQulzAtcJkrBgmENQyf9COZhtw1dVjiGfHsnITjVVTZiHpd0YcG9M9aXITp/zezUvGpQ=
X-Received: by 2002:a05:6a00:2d06:b0:66d:d03e:3493 with SMTP id
 fa6-20020a056a002d0600b0066dd03e3493mr1751099pfb.2.1688641691084; Thu, 06 Jul
 2023 04:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <1652963808-14515-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5DtpoH0dLDX3=Sv4UUpX_=66VEZPsJUWQNnYviApfMLKQ@mail.gmail.com> <20230706084706.bzwsbi3zisx5m5rl@fatal.se>
In-Reply-To: <20230706084706.bzwsbi3zisx5m5rl@fatal.se>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Jul 2023 08:08:00 -0300
Message-ID: <CAOMZO5CCdaodWQrHUQgMizoES=jfEtw-sNJZG-DJMpRD8tZW9g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode
To:     Andreas Henriksson <andreas@fatal.se>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
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

Hi Andreas,

On Thu, Jul 6, 2023 at 5:47=E2=80=AFAM Andreas Henriksson <andreas@fatal.se=
> wrote:

> We've been working on an i.MX8MP where MCLK needs to be input and found
> that this enables the MCLK as output despite not having set the
> `fsl,sai-mclk-direction-output;` devicetree property in our DT.
> Reverting the patch fixes the issues for us.
>
> I have to say that the code comment made me a bit confused, but once
> I found the commit message I understood why this code existed.
> If this is really i.MX8MM specific maybe mention that in the code
> comment and please make the code actually only trigger on i.MX8MM.
> It seems to me like these all fulfill the current criteria:
> imx7ulp, imx8mq, imx8mm, imx8mp, imx8ulp, imx93
>
> Should I report this in bugzilla.kernel.org ?

Should we do a fix like this?

--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1453,7 +1453,7 @@ static int fsl_sai_probe(struct platform_device *pdev=
)

        /* Select MCLK direction */
        if (sai->mclk_direction_output &&
-           sai->soc_data->max_register >=3D FSL_SAI_MCTL) {
+           sai->soc_data->max_register >=3D FSL_SAI_MCTL &&
sai->mclk_direction_output) {
                regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
                                   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_=
EN);
        }
