Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BAB748E84
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjGET6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjGET6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:58:21 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D8A9;
        Wed,  5 Jul 2023 12:58:20 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7835ae70e46so270722839f.3;
        Wed, 05 Jul 2023 12:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688587100; x=1691179100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWR4rzgRzJqw8ZsrwBvfIC+5CsnJGVSJ/W7SY72QRJs=;
        b=hKxVGnUs5H7+PpYhId1qJotfxQmjlc2HJ+pPzcXW7mh9mkUzGyRmH0bRAocCDuntdv
         53CFYdBJhFe0SiS83rheYX2oeW48GFa+T1CIk435ox/zyKs1k9I/1A6fKza4bsRAa/I5
         1UBHD8WeuAhrXippI+31xZaUbm6wNPyIzF0oeOO5QZK55qNT8sqo7UNJfaGrQiaKdin9
         T55q7GyLKKpHznVB2EI3C7Cw/nAM+c5kq17txN7Oawo4pqs8rEJXZbxEOt3Fkeh4pUkN
         cCjVxXndqZ5mKLNP4lqthH4yOlk94MQAHQ2efydwt/7krpsTjYwA4cMf2wof97voN05L
         +9Sg==
X-Gm-Message-State: ABy/qLZ56KbQPA2PZQ+HuK0s+SCK5a2Yv50L8uX4qDyG48MZi2y8GKDs
        N9v5pwie4Z53iXQETLS/Iw==
X-Google-Smtp-Source: APBJJlH+GhulCs77gC1uUiQFuq4jo9mjgirVmZ0inqvPVdAxFQcR+RjE/nzGuZy9qJVIo8aNC6PGXg==
X-Received: by 2002:a92:4a0f:0:b0:345:6ce1:d24e with SMTP id m15-20020a924a0f000000b003456ce1d24emr124971ilf.22.1688587100082;
        Wed, 05 Jul 2023 12:58:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k16-20020a02c650000000b0042b3bb542aesm2613192jan.168.2023.07.05.12.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:58:19 -0700 (PDT)
Received: (nullmailer pid 1739539 invoked by uid 1000);
        Wed, 05 Jul 2023 19:58:16 -0000
Date:   Wed, 5 Jul 2023 13:58:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 3/3] dt-bindings: soc: amlogic: document System
 Control registers
Message-ID: <168858709644.1739479.11332380287477883638.robh@kernel.org>
References: <20230705-b4-amlogic-bindings-convert-take2-v2-0-22be915ddc3b@linaro.org>
 <20230705-b4-amlogic-bindings-convert-take2-v2-3-22be915ddc3b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705-b4-amlogic-bindings-convert-take2-v2-3-22be915ddc3b@linaro.org>
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


On Wed, 05 Jul 2023 13:41:53 +0200, Neil Armstrong wrote:
> Document the System Control registers regions found on all Amlogic
> SoC families and it's clock, power, pinctrl and phy subnodes.
> 
> The regions has various independent registers tied to other
> hardware devices, thus the syscon compatible.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 160 +++++++++++++++++++++
>  1 file changed, 160 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

