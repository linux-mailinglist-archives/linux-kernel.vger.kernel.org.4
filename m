Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900EC68E2A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBGVGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBGVGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:06:03 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B70D4;
        Tue,  7 Feb 2023 13:06:02 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id g21-20020a9d6495000000b0068bb336141dso4630527otl.11;
        Tue, 07 Feb 2023 13:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPyVZIpN0FwAdN9R9CTFnTvuWd1/gJoACGAtnhIy+Qk=;
        b=x0l43pvuNjO5acWRpR7v7fSVjMm6BHZHNZC6E5WzqDSvOtQtq/dEkMXtx91WfcuaDi
         1A70xMar4DDiIgBRbAms2U/qwijhPP6MCS/kOj3M8hEtpeEyPkLlqqmRwlUZlNIYjFO2
         45qTAtfMled0mRuMzQ6AKuCVNhJElpX5xZhVX/O9LtbE8VkH5luGTyiZHVxF5aTaWo6H
         x3ejquTlPWoQ7BftCtl88sO9g5yHGLiLH/zXrSWJOuXAUP8L9EMcSwQbVCOB9EbwaWSB
         yl4yNHpvz97AM8ZSaPxfeYTjW0IboIgFsgpLMtUkpuZ/luMTR2nuzl8qFYkrU5G65E5S
         pXWg==
X-Gm-Message-State: AO0yUKUchq8NL4tZt0FpMBnL++zJcEU/VQLedByjMfyODbPkChZW9VsP
        5nZwMfPPWzZXWWRfQVMokA==
X-Google-Smtp-Source: AK7set+hznFQEHzf2Hr9+9cQLKct1X7nEWhvUZ2fL6DzpfEcUHkveKOh0p3fOokjzyTqibWnuajNVA==
X-Received: by 2002:a9d:7dce:0:b0:670:8cc8:3a00 with SMTP id k14-20020a9d7dce000000b006708cc83a00mr2796731otn.19.1675803961677;
        Tue, 07 Feb 2023 13:06:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bh15-20020a056830380f00b006864816ecd9sm7039529otb.59.2023.02.07.13.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:06:01 -0800 (PST)
Received: (nullmailer pid 4153448 invoked by uid 1000);
        Tue, 07 Feb 2023 21:06:00 -0000
Date:   Tue, 7 Feb 2023 15:06:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: sound: Add the Infineon PEB2466 codec
Message-ID: <167580395997.4153388.12039194229273966008.robh@kernel.org>
References: <20230206144904.91078-1-herve.codina@bootlin.com>
 <20230206144904.91078-2-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206144904.91078-2-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Feb 2023 15:49:02 +0100, Herve Codina wrote:
> The Infineon PEB2466 codec is a programmable DSP-based four channels
> codec with filters capabilities.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/sound/infineon,peb2466.yaml      | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

