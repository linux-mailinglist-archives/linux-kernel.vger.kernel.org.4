Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BEE7371E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjFTQiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFTQiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:38:10 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204D1988;
        Tue, 20 Jun 2023 09:37:54 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3422d37d316so13553895ab.3;
        Tue, 20 Jun 2023 09:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687279074; x=1689871074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzHhBcGehlWwZFYVf8Mcmgg1mKcLxdLW5Zggyy+CCXM=;
        b=ODGNDLhtIbPyhP04QC6TtKSlOk07ThJV19EBv+7/X9uWcufbAJTqUo28rreIIXFjVQ
         0SoQfZoQ3N1iDeKBsE5atI2vWkHq/iNIDIArXGRqiGsjEGhXKb7TVB9hS6ZER331XFUc
         FlpLN0Itrh6gw1SaQGJ7AymTIt2VI6iKOrzk3K9iOnALGQXfV4AvTeZoAjBrK9q8ko8e
         4NsAoxkKrRUIEJRQu5aJscGQfe19CG/jJ4njdDsPC0Kumh8ioW2XARr2iJ4VtXS55MoY
         ZBfQJEvoG+6jevxsIoAK/aymtZs8myolVVntTDJ6W5Zqef+b2uVR2ueNOQDkLsk0eiwG
         F2Jw==
X-Gm-Message-State: AC+VfDxptBaPzMhXbu68RzrwcEeguSHYDPJnEl/xMbFu7HPx4RqXF4SS
        rE0dQvFIHVmTaPBKgofw7g==
X-Google-Smtp-Source: ACHHUZ4zJSh5ti9pvnIfdniu0E1NqvpspqRuuhbVpluLjMmbPmBKj+IVLp/KcN4Qlye8SWQ/35QrFw==
X-Received: by 2002:a92:c80a:0:b0:341:c806:a8cd with SMTP id v10-20020a92c80a000000b00341c806a8cdmr8907661iln.6.1687279073923;
        Tue, 20 Jun 2023 09:37:53 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a12-20020a056638018c00b0041f4bd6f285sm741308jaq.37.2023.06.20.09.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:37:53 -0700 (PDT)
Received: (nullmailer pid 3789063 invoked by uid 1000);
        Tue, 20 Jun 2023 16:37:51 -0000
Date:   Tue, 20 Jun 2023 10:37:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v5 01/13] ASoC: dt-bindings: Add audio-iio-aux
Message-ID: <168727907001.3788984.8001897155371948964.robh@kernel.org>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
 <20230615152631.224529-2-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615152631.224529-2-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Jun 2023 17:26:19 +0200, Herve Codina wrote:
> Industrial I/O devices can be present in the audio path.
> These devices needs to be viewed as audio components in order to be
> fully integrated in the audio path.
> 
> audio-iio-aux allows to consider these Industrial I/O devices as
> auxliary audio devices.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/sound/audio-iio-aux.yaml         | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/audio-iio-aux.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

