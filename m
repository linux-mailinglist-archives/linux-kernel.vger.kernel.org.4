Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43956C1AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCTQOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCTQNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:13:34 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B231ACF3;
        Mon, 20 Mar 2023 09:03:52 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id be16so9099223oib.0;
        Mon, 20 Mar 2023 09:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNC+OXlKdlbVkyP5FbmhjfPQE78DDQdoT/lxRDWBrmE=;
        b=d6imcFf3NIeAfJ8GkP1GDWaxco3yU6WgEUrOEkZueaCq5isRmGtTdqLo40BbCpajhD
         fww3Rx+cLcJ/Z9n5rVBcl3v5s8wWy4P3VvGexwJ3Jko4ZgLQUC2EmFI+waakY9Nljj6V
         eXAo6cSwaxbkIIAV816l0MgDGnuiySFU8t6uv9lm8fcfB5ovYk2EDv1uuA2ICup1veCF
         Ij+DnbJGGYmUWhK0NATY3MSBxiUhvB1I+8qeerLGYOqSZylLcnf5F9iZf/JJeRo6R+t6
         R7dLck7r15diymF1/cuQIl0zW+WcZLOMMuigAwxmi0130lCLxa06Eo5nmREX/EmBTs+n
         Tc/g==
X-Gm-Message-State: AO0yUKVPGDd498S9RjlbUPF9N7GJ8/gMumuAqRzxp6A/962rSFQZMYuE
        6mBkr/AsWvPGUszcs2GImA==
X-Google-Smtp-Source: AK7set8Py2GSqg1krKh8kyywDWaz6ivjsTyoY4utp1Q09KYKg3F84NdU3xUAPh4qNBy0G//Ug9VI1w==
X-Received: by 2002:aca:f04:0:b0:387:115d:1e26 with SMTP id 4-20020aca0f04000000b00387115d1e26mr209867oip.3.1679328180069;
        Mon, 20 Mar 2023 09:03:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bk38-20020a0568081a2600b0037832f60518sm3821272oib.14.2023.03.20.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:02:59 -0700 (PDT)
Received: (nullmailer pid 1770233 invoked by uid 1000);
        Mon, 20 Mar 2023 16:02:58 -0000
Date:   Mon, 20 Mar 2023 11:02:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-rockchip@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Daniel Drake <drake@endlessm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/11] ASoC: dt-bindings: rockchip: i2s-tdm: Document
 audio graph port
Message-ID: <167932817831.1770182.9717265674737412940.robh@kernel.org>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-6-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315114806.3819515-6-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Mar 2023 13:48:00 +0200, Cristian Ciocaltea wrote:
> Document the 'port' property to allow the Rockchip I2S TDM controller to
> be used in conjunction with the audio-graph-card.
> 
> The property will be used to provide an endpoint for binding to the
> other side of the audio link.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

