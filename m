Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A7F6C1AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCTQNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCTQNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:13:13 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AACD5591;
        Mon, 20 Mar 2023 09:03:28 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id t10-20020a9d774a000000b00698d7d8d512so6979323otl.10;
        Mon, 20 Mar 2023 09:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ONYF9Dhx9WuItYv8TAksl5NcQGpYz4D/9DErzT0sW8=;
        b=ihrPqVWnEUQ2inX7U53n0cWk8weK9GBHltk4f8vOAPqMhJjTS75ZdxI7jScUjFAWt/
         pQRH+jv2dT3iAsVVxlLhi6t4DA+QLGojChn5tc7H5w9H81vzxzUXIqNCkyiUxRFprxot
         ta/6hwrsKAZTO+p6waCTpmRC6Akvn9GfwPVNajJ8p6F+vVJJQqym/Jz4Mij80GobuxJ2
         NzFO0ytBva1lryyEkQZuJY8+H5dW+D+E51lvLLh1hHpQIk1js9JNijpQgBGR2oSYP+hq
         c9g9VyBWIGk9OUjTU+muxP0NEiR8cpqpb8RwmzS6f2dMxdDA5wfvPdh1lcMzRdXyNeIM
         9TKQ==
X-Gm-Message-State: AO0yUKU9A/z8uB93sfSEATdDk7rn6rnGj01je/N1J4dY5ou3ICFtS5qM
        tVVTluVmc39Ykeqp7jprJw==
X-Google-Smtp-Source: AK7set8NH1bWAW41KIn+lr6vHiP/x1CpF/1YMJ08oLnvsEuB8hZrMa5U2xgwSIKI0WC3TSJ4A51DjA==
X-Received: by 2002:a9d:7595:0:b0:69e:80e7:905f with SMTP id s21-20020a9d7595000000b0069e80e7905fmr243497otk.13.1679328152031;
        Mon, 20 Mar 2023 09:02:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c7-20020a9d6847000000b0069f71b0d060sm117205oto.36.2023.03.20.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:02:31 -0700 (PDT)
Received: (nullmailer pid 1767227 invoked by uid 1000);
        Mon, 20 Mar 2023 16:02:30 -0000
Date:   Mon, 20 Mar 2023 11:02:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH 03/11] ASoC: dt-bindings: everest,es8316: Document audio
 graph port
Message-ID: <167932814988.1767188.7685028838394723224.robh@kernel.org>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-4-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315114806.3819515-4-cristian.ciocaltea@collabora.com>
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


On Wed, 15 Mar 2023 13:47:58 +0200, Cristian Ciocaltea wrote:
> The ES8316 codec is currently used in conjunction with audio-graph-card
> to provide an endpoint for binding with the other side of the audio
> link.
> 
> This is achieved via the 'port' property, which is not allowed:
> 
>   rk3399-rockpro64.dtb: codec@11: Unevaluated properties are not allowed ('port' was unexpected)
> 
> Fix the issue by documenting the missing property.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  Documentation/devicetree/bindings/sound/everest,es8316.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

