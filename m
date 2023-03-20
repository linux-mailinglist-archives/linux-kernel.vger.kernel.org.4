Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8776C1B25
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjCTQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjCTQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:18:00 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5347819F1E;
        Mon, 20 Mar 2023 09:07:55 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso13442197fac.12;
        Mon, 20 Mar 2023 09:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXPLPHoO6OcEzh0FRvvTkMYHJJivlJafTToDO4kOl40=;
        b=jyUQ+8KxMKko/mmIJD5/4QNYqSPU+mTXZsocZv7KMZ9UHjNhDDAXTqsV6We5qw67m/
         rEJBL0uh5z6/6N4DOvA3Q7JVyBwfTFtGXPOWmZ9XLcQmNXBBYzfeAan4MyyaGhpGD24Z
         ayS/QPxkP07QCNTgGQH9faG6V72U7qbqba2pMAkBinfx9rqSA5y5yk1iGPbgT39ToQlh
         EK6YGLtBpCF7J/jwH4OYxIF5HqSiZO0N9KNzClzb0qLBk4Nuye+fxCr9PMOTw7t5sTU9
         w/TozNMFHSf+ZZxZoBwVbzOW4XHgNTeXdB9OWWCdjL0doKiKg2dWb/TjwVoQ298xzeW0
         1vsw==
X-Gm-Message-State: AO0yUKWO9k2s0XYIeuYw9DB+ZwOvIbo5HkKiZf7dGh2+zEhn1TZxAzUW
        CIjQIHaZeeQpuI7A9l9fTw==
X-Google-Smtp-Source: AK7set8XvRgwjmJDOYipg3BA4ranqSKnJyKo74CpeOtIhfaO2wH4agFUVkOR5yGuCLkfnjT0NXGXHA==
X-Received: by 2002:a05:6870:a549:b0:17a:b214:f004 with SMTP id p9-20020a056870a54900b0017ab214f004mr5277277oal.6.1679328167586;
        Mon, 20 Mar 2023 09:02:47 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id tk6-20020a05687189c600b0017703cd8ff6sm3389673oab.7.2023.03.20.09.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:02:47 -0700 (PDT)
Received: (nullmailer pid 1768734 invoked by uid 1000);
        Mon, 20 Mar 2023 16:02:45 -0000
Date:   Mon, 20 Mar 2023 11:02:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Daniel Drake <drake@endlessm.com>,
        linux-arm-kernel@lists.infradead.org,
        Takashi Iwai <tiwai@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>, kernel@collabora.com,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 04/11] ASoC: dt-bindings: rockchip: Document audio graph
 port
Message-ID: <167932816525.1768684.13404674229392132860.robh@kernel.org>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-5-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315114806.3819515-5-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Mar 2023 13:47:59 +0200, Cristian Ciocaltea wrote:
> The Rockchip I2S controller is currently used in conjunction with
> audio-graph-card to provide an endpoint for binding with the other side
> of the audio link.
> 
> This is achieved via the 'port' property, which is not allowed:
> 
>   rk3399-rockpro64.dtb: i2s@ff890000: Unevaluated properties are not allowed ('port' was unexpected)
> 
> Fix the issue by documenting the missing property.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

