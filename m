Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3186C1B09
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCTQPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCTQOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:14:23 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B68410AB;
        Mon, 20 Mar 2023 09:04:18 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id r27so2293177oij.9;
        Mon, 20 Mar 2023 09:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aykrVk11PH84fM2GSSqZSCXIg7R/09zXllx+hc7KgiE=;
        b=cbfyuEuEdqX6NwGJt5L1DIRIdmO9KLrtYRl8tHxWgBVgNkT3nvwGH+WnICQCbYel92
         0bjYuNZtP8vJ9GdwK5TB2QBnGklVX9KVofuUgwiB22AmjLXReWlJTTOSJfLchD+v+k6h
         SesHv7MWhz5rPAHvmkXc/vUSEtB5DG3MEyRKlyH5zW5NV+Na/WRyDWEU4lkSB9VaAP9q
         7LgAP5grcSWiGn4bYWnCCoyWZfFNiXhjybzW+awQOFqwxYWcDYax7W+2MgvDr20L2+Xt
         /JkW0QwPfEHd6FdceWp0OlEGItdQEtlQ4una1hjntMsWREPeV3cZpRdBhxpvudb0bPCW
         Ebhw==
X-Gm-Message-State: AO0yUKUG5a4sEv28ffNADiSBPV3FH765RhnXE+ObR7LrkFn+fhc2h2Cn
        8HvNGfYbl13kVdxp4iG3zw==
X-Google-Smtp-Source: AK7set9ZC/44ndn2AZ6WEHBP02JZbPv8blbEpBCxNo4pJk573f1aK48pBSdsvLxsUX2DiFnh9mSSkw==
X-Received: by 2002:a05:6808:6286:b0:386:c6ca:2b1e with SMTP id du6-20020a056808628600b00386c6ca2b1emr181632oib.7.1679328213843;
        Mon, 20 Mar 2023 09:03:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p204-20020acaf1d5000000b003845f4991c7sm3895828oih.11.2023.03.20.09.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:03:33 -0700 (PDT)
Received: (nullmailer pid 1771818 invoked by uid 1000);
        Mon, 20 Mar 2023 16:03:32 -0000
Date:   Mon, 20 Mar 2023 11:03:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Drake <drake@endlessm.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-riscv@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 07/11] ASoC: dt-bindings: rockchip: Add compatible for
 RK3588
Message-ID: <167932821168.1771757.7958131150512632634.robh@kernel.org>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-8-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315114806.3819515-8-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Mar 2023 13:48:02 +0200, Cristian Ciocaltea wrote:
> Add new compatible string for the Rockchip I2S/PCM controller found on
> RK3588 and RK3588S SoCs.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

