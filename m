Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3271061125F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiJ1NJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiJ1NJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:09:39 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0297101E7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:09:37 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-35befab86a4so46547837b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zNvEGzwFZiPNSYA/riEwCNGdEsEkX1GF8vTXGSAxJg4=;
        b=j/Ro6KESD6qEo8DaVVUq3iotBaCxQLlZwORfAykz4UFJz1XnfXypAIyl8qAzDxzx+K
         IAhjUghZjt+GzqNmin22zQXpTtz4SjRLO6N0nZqwdG7vrXQuX/sbvkbtiPCHtBhS0eoH
         qy2Q7VHmjJ6tdNweJK2n/smTGza7+9BVNsvN2BSMmp8JCjGUaEcSwevBbThJntv3dslG
         jUz3E70/ODotZIDMigHxJzat6yB+K6dYEWGKuKRE5TFqHCf0dvZT8vHMW0QqcLcvLyqj
         KSVSo2tG89mKnwIgB2jPhcRZHZomvC4dJiX6SSou7qhnKS+Y+827B5w2V1VZRD/eFepK
         Uspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNvEGzwFZiPNSYA/riEwCNGdEsEkX1GF8vTXGSAxJg4=;
        b=yj5MiAOUX+aaVPohW6t4T21DGeTwwL/qQ7pMqHg4N6K6X2B3KWt/7RW3T2XePBjPdb
         bB0XJbOV2J1wRsqbL+2hw6l4AMFi8pdu0/YFuDCX/ap8jwZE700ECt3EBTmcyt1DLWAq
         nN2NwqFv9ykWr/m0U5KaamhZQpuMEUDSdtMs0AJIZLi3FCdOMlpLIUPwGy7u/EIqkswX
         1KQULCiErRrRXOBfA9eQZEvkP1QJoJYflNBudtgkZoj2Tue13tmmBoZHmdLAZuKDkZct
         bZmu4IGOYdAXfFb88WVzke4St4cFAbCXJgYGNbqYN0l0xZtrOyoGpw05xhh5r278nk9A
         ViFQ==
X-Gm-Message-State: ACrzQf1qK0mD9vciYu33KgtmBPiXlR+owT81bBFS9kD+gLyOiqYbXLjC
        Q9JuhsJERGhPutM31Nm5z4BCqMsWsB5H09N9NVdtDw==
X-Google-Smtp-Source: AMsMyM4RlEu/ZOLsDrVy8uJcLRb63RMgIWBseuziSlav6DYsCFUaKtiFKKtHnLGhUZVQNf3FzpLYAMYgWfoFz/21v3Q=
X-Received: by 2002:a81:164b:0:b0:36f:ced7:985f with SMTP id
 72-20020a81164b000000b0036fced7985fmr16909310yww.360.1666962576949; Fri, 28
 Oct 2022 06:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
 <20221028102450.1161382-3-ajye_huang@compal.corp-partner.google.com>
 <Y1vDxtdNGURAT850@sirena.org.uk> <CALprXBbTkj0Q_-3AL81Q1okRD5ZyDf_c=daPrkQstkM4_CNgGQ@mail.gmail.com>
 <Y1vStD8vNYmdvPH1@sirena.org.uk>
In-Reply-To: <Y1vStD8vNYmdvPH1@sirena.org.uk>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Fri, 28 Oct 2022 21:09:30 +0800
Message-ID: <CALprXBZMvPhDo_7Hsvvgutb50ZBvmQZTAwvzUstQCEC3QN58vg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ASoC: dmic: Add optional dmic selection
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, robh@kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        angelogioacchino.delregno@collabora.corp-partner.google.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark Brown

I need to abandon this one, I will send another new patch, thank you so much.

On Fri, Oct 28, 2022 at 9:01 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 28, 2022 at 08:59:54PM +0800, Ajye Huang wrote:
>
> > Thank you for review,
> > I think it is appropriate to implement on audio machine side, like
> > this I did before,
> > commit 3cfbf07c6d27
> > ("ASoC: qcom: sc7180: Modify machine driver for 2mic")
>
> > What is your suggestion?  Thank you.
>
> Doing that seems fine.
>
> Please don't top post, reply in line with needed context.  This allows
> readers to readily follow the flow of conversation and understand what
> you are talking about and also helps ensure that everything in the
> discussion is being addressed.
