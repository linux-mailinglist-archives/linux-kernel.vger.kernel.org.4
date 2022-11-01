Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4586142A3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiKABHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKABHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:07:39 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529721658A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:07:38 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e62so28589ybh.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XmMaXP90CaIMiPtYW47n6m2G5ZMtSO1W1wgU+NyJUlI=;
        b=KV7kD2/vrb7m62VzqzYzSnWH+Ru13le5MwXLe2PxHkpYIB7UYu262mGqcarWS6abdD
         0dn/55y/MOGSm2sQV75SA1wSv0YWmvzxR9tHvFNO0eYd/p+XMjfj9QQLaHTV+LDuwnBa
         BPYazU9flaQYyJM5cVJFmzqaMfMTDnKJRRKLPjdfFZvWpny7+W8rXzheWnWWNUTD9bOK
         TSxsmi1kbswby1PBNFOEN080yKyITA6s4Pfiss8/g/nvbAUkmgenBIo/2AcTEEsTwfKc
         1i/wVL7p7lpD6Z99zf+2MtG/NrYASJpB8AdHCoT/HeVY3lxITW0aXRkgbCax4e7Pmvw6
         CjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmMaXP90CaIMiPtYW47n6m2G5ZMtSO1W1wgU+NyJUlI=;
        b=BDb/Y4nx9ycrQTpYSUCHuP8pF7D5oKruVsk5LG7JdxywCXogZ5gbr/BHY1h2dH92Kb
         eXAAOvh6abiaIDMBfoUgktB7ha5BU4sgbqZbH0V6tDawil/I8VEVF2WGXY6roRcdlme1
         JobH4eX7FT0bSzicSoyGHiM+gsN6WPvJNhem+Iyx1/uL/sI8VigmjBCA5QfiFaoHbvpG
         3uUAuD4fT0rniYDgr8YDtmIYwGzRs3a5DgKrot69UBXKP5Gj8vhkTZ4t+i6Zps1cBcD9
         GCPWEwdKoTGL7niUKmehYY8YfazppaIcD7A3rUn+IHK5FEAkHoyVC//ce1e5ngTgTlIn
         2ybw==
X-Gm-Message-State: ACrzQf0JGPslLs4p6RYDaEW8bDmKo2r6tH/DCS7aVRT+xIm5IPi23cDy
        +7FC1swXTqMORdiMA4bNpM6h5tae5xdw5v+HIv2ZCg==
X-Google-Smtp-Source: AMsMyM6rZlIQZ1PYaWj2k4quC4D/+5G6Kbx8Z29PHK8evYzmyRI+sEH2P3krYmjXNk4yI5MLVy44GaA90GQxOjbPmBU=
X-Received: by 2002:a25:7055:0:b0:6cb:7973:a3a2 with SMTP id
 l82-20020a257055000000b006cb7973a3a2mr15384128ybc.595.1667264857444; Mon, 31
 Oct 2022 18:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
 <20221028102450.1161382-2-ajye_huang@compal.corp-partner.google.com>
 <Y1vDYNOwZNOco1hq@sirena.org.uk> <20221031184343.GA3235956-robh@kernel.org>
 <Y2A0fdwnHTqw/NDw@sirena.org.uk> <CALprXBYEsB5z-iioBeyeBAwPFkOnkQn8CBbj9Di9CpdqvFFnOg@mail.gmail.com>
In-Reply-To: <CALprXBYEsB5z-iioBeyeBAwPFkOnkQn8CBbj9Di9CpdqvFFnOg@mail.gmail.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Tue, 1 Nov 2022 09:07:27 +0800
Message-ID: <CALprXBYrKMSx=JRft7eB+YGQc2eDY6VXSrNfuoB3aH8DApi=NQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: Document dmic_sel-gpios
 optional prop for two DMICs case
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Rob

I submitted another one to process the kcontrol in the audio machine
driver instead,  sorry about that previous non-completed mail.
 https://patchwork.kernel.org/project/alsa-devel/patch/20221031122224.1846221-2-ajye_huang@compal.corp-partner.google.com/
thanks

On Tue, Nov 1, 2022 at 9:04 AM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:
>
> Hi Mark, Rob
>
> To avoid confusion, I had submitted another one for process
