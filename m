Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18927661A23
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjAHVoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjAHVoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:44:06 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48418654F;
        Sun,  8 Jan 2023 13:44:06 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id q10so4982446qvt.10;
        Sun, 08 Jan 2023 13:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6T43D0FupTceOalhCbxQCz5TRvmC2lIXz6LXAPPXOo=;
        b=OnUlqoRrqRwZB/vgIZFbQh1qnk6+8vALZiKA5sQ6+2axoEt4pNzfTZx6lFYug9Fm3w
         8kJduUifQNaYm9FaTcVsIH7kYBk2yAwK1PjFi6gwwIaLVaD2g5ef9+R2rnN30zXwHlf5
         oZS7SLDnO9SvvrH47p6vkLosUQ+x3lnkMovtPhmCKNHExIHHMv6y9snzofocTnVZQBT3
         Ql86V38EF+cq05WDadcRJCxzPyw4L6t9N8cwXFPJiJL1j2mdaS6pu6OZKIO7RghDDxeE
         qRX3IKAelTgEJqNgp82Smz+qkgfxCcA+bFLUzq8Oi5bxviaHy5E8NVvwTjHi+TUbrZmg
         QyJw==
X-Gm-Message-State: AFqh2kpz0TTSt/8fZBvT6jx+mvrcHeMAnce0GFdB3iFWYSkwOmT1nrQS
        sY7mjSbull4oogKJjGf6oQ==
X-Google-Smtp-Source: AMrXdXuU6fv5RU/0vsc0XkLOlOxceJbfILEYGJ/eGd9SquRgy6qEKKGgFaPLC1tNzfV6JiA6aCIa8w==
X-Received: by 2002:a05:6214:5bc2:b0:4c7:62eb:145d with SMTP id lr2-20020a0562145bc200b004c762eb145dmr103551507qvb.25.1673214245388;
        Sun, 08 Jan 2023 13:44:05 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80a5:9b51:39ae:24d1:33f3:811e])
        by smtp.gmail.com with ESMTPSA id bk25-20020a05620a1a1900b006ff8ac9acfdsm4316145qkb.49.2023.01.08.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:44:05 -0800 (PST)
Received: (nullmailer pid 320040 invoked by uid 1000);
        Sun, 08 Jan 2023 21:43:57 -0000
Date:   Sun, 8 Jan 2023 15:43:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiri Valek - 2N <jiriv@axis.com>
Cc:     devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v2 1/2] dt-bindings: input: microchip,cap11xx: add
 cap1203, cap1293 and cap1298
Message-ID: <20230108214357.GA318729-robh@kernel.org>
References: <20230103134105.736346-3-jiriv@axis.com>
 <20230104135951.930783-1-jiriv@axis.com>
 <20230104135951.930783-2-jiriv@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104135951.930783-2-jiriv@axis.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 02:59:50PM +0100, Jiri Valek - 2N wrote:
> Add support for cap1203, cap1293 and cap1298.
> 
> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
> ---
>  Documentation/devicetree/bindings/input/microchip,cap11xx.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> index 67d4d8f86a2d..08ca993b94c4 100644
> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> @@ -20,6 +20,9 @@ properties:
>        - microchip,cap1126
>        - microchip,cap1188
>        - microchip,cap1206
> +      - microchip,cap1203
> +      - microchip,cap1293
> +      - microchip,cap1298

Maintain alphabetical order please.

>  
>    reg:
>      maxItems: 1
> -- 
> 2.25.1
> 
> 
