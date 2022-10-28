Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E409961153E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiJ1O4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJ1O4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:56:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D64202706
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:56:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id d26so13477020eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LQqF7mgoMpdPDEfiMU46JdqFEc964tvWxw1HB/RMwiE=;
        b=arTa8Hp9eU8CHAAKuZxCuCp9TFtlwbZW3v87Df9EtS2SMm22Eduv2F12bZhmi3qg20
         8HJmCjY+CdC+8I75dYuUqmXe2VE3oJRS1Ab7QBBuK7Ac/Ucs7NcYDqHBIzhvEcOuwBJc
         ZWvP3FVXgJzFksiq7wweonN1/pPCb7+/yCC5SAHOH+OzqHpY6JAMJMI6kG/uWEGSUQvS
         C7eqz3grRob4bZfW+oH6rwPz54fq0r8j8OQoAuLFzgYj7ghCn5PKe2DQUj7NA6U5P9N3
         bur7cp6c9yjVC9Erdf8lbNNpRTVZ1+xuAt9YjDuioE9AU6LsasEf/2ttDERdZTUyoiBv
         T8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQqF7mgoMpdPDEfiMU46JdqFEc964tvWxw1HB/RMwiE=;
        b=DuxDdY9jtRtZBl0T0/4+yBc+A9xeirSRP0YY2riTTb7k7kF51HkMcKSLY6vUyVMZNY
         luCRFc2nnh5RvZI3HDs8rAzXLOU2UpTUUMdymxfZgtAusnRuYJMzV6G1kDBSr/EE3Nlw
         0QP5C0Xu4BUa8SwTcZejivTf2f43uObrvDgUkrh8XGIt24WVbazYUjP7sWfRi0n/UUre
         Gw8bzsgNgp8DhRnFXnfZorVOqsVorlwwlmrIqqlHd/mgHM8EwTE0MOotC6+MulMEGpe2
         JyTZrNckkl4+Ifn1zkc/L9kBMKwehpBcNKIL0+fMECQQT/sJ9kpA7RnRKwsyxV6z3Ub/
         TVUA==
X-Gm-Message-State: ACrzQf35KqcxJRHUctwXCJpn/NWsVP66BpGLd1DK7KsI/NuJ5bfCrBcS
        tk9Fd+ZQOjRCvhsNiyd2p1nhzFmqXjeCPQlO6K0=
X-Google-Smtp-Source: AMsMyM5YEMqyGVRZ22xaHEfcgjC/wjYt3YHikBMrSXZTvnr//2VkFszSR6BbgM3ElAHwJxzJNTa8V2q3veDVgCO00eQ=
X-Received: by 2002:a17:906:9750:b0:798:9ccc:845d with SMTP id
 o16-20020a170906975000b007989ccc845dmr38539663ejy.760.1666968993915; Fri, 28
 Oct 2022 07:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221028141129.100702-1-maarten.zanders@mind.be>
In-Reply-To: <20221028141129.100702-1-maarten.zanders@mind.be>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 28 Oct 2022 17:56:22 +0300
Message-ID: <CAEnQRZDyEdJtcMd0et5=3+Q8+oX5b8zOf6o_2yfRNVxmDuxDXg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc fsl_esai fsl_sai: allow CONFIG_PM=N
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 5:37 PM Maarten Zanders <maarten.zanders@mind.be> wrote:
>
> When CONFIG_PM=N, pm_runtime_put_sync() returns -ENOSYS
> which breaks the probe function of these drivers.
>
> Other users of pm_runtime_put_sync() typically don't check
> the return value. In order to keep the program flow as
> intended, check for -ENOSYS.
>
> This commit is similar to commit 0434d3f (omap-mailbox.c).
>
> This commit fixes:
> cab04ab (ASoC: fsl_asrc: Don't use devm_regmap_init_mmio_clk)
> 203773e (ASoC: fsl_esai: Don't use devm_regmap_init_mmio_clk)
> 2277e7e (ASoC: fsl_sai: Don't use devm_regmap_init_mmio_clk)
>
> Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
