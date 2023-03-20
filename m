Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4493F6C1B05
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjCTQOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCTQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:14:05 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31454360AD;
        Mon, 20 Mar 2023 09:04:05 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso13523451fac.4;
        Mon, 20 Mar 2023 09:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk4bf5o+T0icO2it+WiVyLr9KB3ljMdbR5QHyH11JsI=;
        b=Dot9Qok4zqhVzPcW1uuriQ5/HVbDt8bg+Fmg5pcKOpYwIsKki/nPPGVn3qweSGSQAI
         NpB+wTasQ5xTVHd//IvwrUZbjSdf8X8BKY37mCxe0JXPElPFAluQ2q3u1Vd443WkoFWM
         PkugYpTnNGx2Ye0TG+UVcRgjfF3VXPRavGhEtu0HngVJhYEQd/oCPtdreRUlXUU519cN
         jJ/sjh+Yg/+sH+varqzpLo77lm44HEDk5P/pwyu/xB37zsWInCENeLgX3Yd46kQsyvro
         sQvmyYJvrGy3/OaFki5G/lNO1MFplrgJXmM3nIGuDO0VEpb9XoWoeEIBnZIxE8SRjN9g
         Mw0Q==
X-Gm-Message-State: AO0yUKWnkEs1zoswLmU9f8/jFJonYEuJ5v7ggmW38uRlDyQ6bE2dLEhU
        9xJEmh/+jYQgqPIhB5qBGQ==
X-Google-Smtp-Source: AK7set+K3nWOBlUoUowZ7HA8nsud+xt7EyVHYJaSSzw2tyQ5SdbaGQ0LXy0ftmchOcmPlwGf6U+e7g==
X-Received: by 2002:a05:6870:4789:b0:177:baf4:5b10 with SMTP id c9-20020a056870478900b00177baf45b10mr5713445oaq.31.1679328196643;
        Mon, 20 Mar 2023 09:03:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zd47-20020a05687127af00b0016dbf59175bsm3363841oab.47.2023.03.20.09.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:03:16 -0700 (PDT)
Received: (nullmailer pid 1771200 invoked by uid 1000);
        Mon, 20 Mar 2023 16:03:15 -0000
Date:   Mon, 20 Mar 2023 11:03:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     kernel@collabora.com, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Daniel Drake <drake@endlessm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 06/11] ASoC: dt-bindings: rockchip: i2s-tdm: Document
 power-domains
Message-ID: <167932819469.1771105.12720875880996381388.robh@kernel.org>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-7-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315114806.3819515-7-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Mar 2023 13:48:01 +0200, Cristian Ciocaltea wrote:
> The binding document is missing the power-domains property. Add it.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

