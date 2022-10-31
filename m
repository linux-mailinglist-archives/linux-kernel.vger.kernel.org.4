Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69404613D94
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJaSnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJaSnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:43:43 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F813D4A;
        Mon, 31 Oct 2022 11:43:42 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so14448695fac.1;
        Mon, 31 Oct 2022 11:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riEhJI8G7uoCQmZTrlcGBLPUnlTnsywRFiMnVaXjKWk=;
        b=Zg9lbJbaeyYhlzA72h1kRnamVLULBes2RZJ8tbrQi3b5VgNSb8HDPEYqOarBWdb51k
         J4Hza3lcnmWx+mKSmpHVZ2GPZvBvuzXX/Vp38AE7247Ym3dLZjBAWGRD0lm3FzgzNtTb
         9cWpl1S377rxyE43eKPR2O9zG5z2ffq+LtCrYFTd877RizS3V5/lDn5+co1WfQy84Yf8
         G9qAXu7qY7dW2T+6SRDDeZlobJ7/lM4MzlghE5yIIz8RKBmjYDDDvnPlPtFT435qCGmF
         7z+WaBa8T/j3v4ELiTcmkowzVeg+HD6dQyQA+J41Yh0aXLL13xHqyAGuek3PaH56+51Q
         jYAA==
X-Gm-Message-State: ACrzQf09EfDGnfGuAl/6WSZq93c6D5CVkVbBFmaLt80yCxD+uxahm13d
        IZ6YatZrvdpRY+NKQjOTew==
X-Google-Smtp-Source: AMsMyM7NZtP3wDok5vjddQFKN4tnOsm2GF6RDetCJiSa5VMKaFm3TvtUFz0VGHdGPXkd/ZambwEHQw==
X-Received: by 2002:a05:6870:428a:b0:13c:4dd3:9890 with SMTP id y10-20020a056870428a00b0013c4dd39890mr14304964oah.295.1667241822059;
        Mon, 31 Oct 2022 11:43:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t3-20020a056870f20300b0012752d3212fsm3379647oao.53.2022.10.31.11.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:43:41 -0700 (PDT)
Received: (nullmailer pid 3240044 invoked by uid 1000);
        Mon, 31 Oct 2022 18:43:43 -0000
Date:   Mon, 31 Oct 2022 13:43:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        angelogioacchino.delregno@collabora.corp-partner.google.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: Document dmic_sel-gpios
 optional prop for two DMICs case
Message-ID: <20221031184343.GA3235956-robh@kernel.org>
References: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
 <20221028102450.1161382-2-ajye_huang@compal.corp-partner.google.com>
 <Y1vDYNOwZNOco1hq@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vDYNOwZNOco1hq@sirena.org.uk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 12:56:16PM +0100, Mark Brown wrote:
> On Fri, Oct 28, 2022 at 06:24:49PM +0800, Ajye Huang wrote:
> > Document dmic_sel-gpios optional prop for switching between two DMICs.
> > Ex, the GPIO can control a MUX to select Front or Rear dmic.
> 
> > +  dmic_sel-gpios:

s/_/-/

> > +    maxItems: 1
> > +    description: GPIO for switching between DMICs, ex Front/Rear dmic
> > +
> 
> If we're going to do this we should also allow the bindings to label the
> mics appropriately so that the control presented can reflect the actual
> hardware.  It does feel like it might fit better to do this separately
> to the DMIC driver as a mux between the DMIC and the DAI it's connected
> to but equally with the way things are at the minute that feels like
> it's probably disproportionate effort.

Are there other needs for DAI muxes? We already have a mux binding, so 
defining a DAI mux would work for any type of muxing control, not just 
GPIO.

Rob
