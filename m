Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F0C6D28A6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjCaT1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaT1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:27:08 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C552031B;
        Fri, 31 Mar 2023 12:27:07 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-17997ccf711so24304727fac.0;
        Fri, 31 Mar 2023 12:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680290827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buu8WqVMzAcMHXXEn9C7CMlfiJnivaRXjI1lCWs4gWU=;
        b=CH/O3fn0J431BMMx+pjQUp+kbjyn3EcGbc/Lz5kky1nCX1W2LlF2iblOzva/FeqTBR
         zG9GhE6f+TnQQKe1+soqqmQfETGvZGjcD3Vf8DvNCMHFXI77ineqnMU5pdUzL+DmUJTQ
         EBcMWi335gHqbv+S/Bfbdec7T5kBN/opfr7omco8ijl5LNcjgNfFBGIBYc4C/GpgG/ty
         e115HTCEVzonoCmLG6j6duXGpXkWImX0GHpAyaJ1yFjC4E4Ch3VWINCRNsqac6iqIezn
         eHGWI/Phg1JA5dObse4NVhAhnmWCv5RAs2rXoCqjEFuzf0r0zYM165bkOBbi5WiYrCiI
         wXtQ==
X-Gm-Message-State: AAQBX9ch8UoO2o+W6F294KyfkjqSrU80UP00LiYdVJ5TN4V2+8A6j4iC
        GNbKMTPYUR6r8QwD2ahXOr9Lat/HJw==
X-Google-Smtp-Source: AKy350aaVHPapcCWgvkHXPT8cKxlw9Sl3X/+842+zkcyrUdJIsrfD1NB+jBgRlMHjhuketVAO601aA==
X-Received: by 2002:a05:6870:b48f:b0:177:c0e4:1bd2 with SMTP id y15-20020a056870b48f00b00177c0e41bd2mr17442367oap.52.1680290827144;
        Fri, 31 Mar 2023 12:27:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id xf19-20020a056870cf1300b001724742cfcesm1230021oab.38.2023.03.31.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:27:06 -0700 (PDT)
Received: (nullmailer pid 2086972 invoked by uid 1000);
        Fri, 31 Mar 2023 19:27:05 -0000
Date:   Fri, 31 Mar 2023 14:27:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Airlie <airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: sitronix,st7789v: document dc-gpios
Message-ID: <168029082400.2086887.14988355567564977926.robh@kernel.org>
References: <20230326164700.104570-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326164700.104570-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 26 Mar 2023 18:47:00 +0200, Krzysztof Kozlowski wrote:
> The device comes with DCX pin which is already used in
> canaan/sipeed_maixduino.dts (although not in Linux driver).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/panel/sitronix,st7789v.yaml   | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks!

