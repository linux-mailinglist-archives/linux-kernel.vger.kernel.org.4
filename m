Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA1616ABE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiKBR3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiKBR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:29:29 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6955FD5;
        Wed,  2 Nov 2022 10:29:22 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 16-20020a9d0490000000b0066938311495so10654217otm.4;
        Wed, 02 Nov 2022 10:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEpRB2dhc51/gCDHhrS4K+eUaEu05u03r4bcPUfjBNY=;
        b=bwIekMpFoAYtBrfBQ5QNSBKvxaFcBeRucYijLCjwArwAHEXj2Tlo8ODcxHKkm9VCKw
         aIldED8yyBmcKtJ5z7oCTMJ5yoTB46aF4SwB36csYABd5efz4k6THqomvxaDalLmsN9i
         8HNSJxM2sQDDU5FTtkIciXtG8e9LrPX241lAGnJpCDGP0goFdQsjQ1BLoB0NFzk/R0Pz
         r3IDDL3In8W28icedCzXCQi4FH5+pIVYP8SnSrtIIUg/0OUxk4cIEdsdSBvs6ywhXk0n
         iQYjg0tAkY+RLXI7bTzXK7zSPNATU3udmDwlCOpPmNx2ASVr0x3KVhXluGi7wP3ZbTrr
         U9Uw==
X-Gm-Message-State: ACrzQf2ZsFxfNytskQ6ixsvABtJ6HZIc8R9v2dS3y6eo3WMSVIWUno51
        TO9mjQ2P06EubBycnH0gaw==
X-Google-Smtp-Source: AMsMyM70U1ELYK0+O7pqLeORhCvc6X7y6ep05YXLtd19VAaeHVJOLJpBotoWzAb5C71Jea3ggzrG6Q==
X-Received: by 2002:a05:6830:6203:b0:65c:39a9:4007 with SMTP id cd3-20020a056830620300b0065c39a94007mr12686538otb.92.1667410161329;
        Wed, 02 Nov 2022 10:29:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bl8-20020a056808308800b0035028730c90sm4724159oib.1.2022.11.02.10.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:29:20 -0700 (PDT)
Received: (nullmailer pid 4192956 invoked by uid 1000);
        Wed, 02 Nov 2022 17:29:22 -0000
Date:   Wed, 2 Nov 2022 12:29:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <andersson@kernel.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: qcom-wled: Add PMI8950
 compatible
Message-ID: <166741016166.4192902.16881683175503637947.robh@kernel.org>
References: <20221101161801.1058969-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101161801.1058969-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Nov 2022 17:17:59 +0100, Luca Weiss wrote:
> Document the compatible for the wled block found in PMI8950.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes since v2:
> * New patch
> 
>  Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
