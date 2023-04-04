Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B66D654B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjDDO1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbjDDO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:27:09 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C094EC3;
        Tue,  4 Apr 2023 07:26:59 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id q27so23588375oiw.0;
        Tue, 04 Apr 2023 07:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GepwDY8pY6IPiy+4YgNweyquxm2+4jucNmXEMIhff7Y=;
        b=VA/88h+v/8d/gaGuV7/QIohNmhOJY4hPD9XyAaHt0M2o+PD1D2yaiW6y1gUjvPCLMH
         W3Frux1j2HdpknSJsh8V8lNVG8cqDnfHCnhCDZvezElp/TZtZ5L9KeFg45jkEVfOI1gK
         sSreWhYJ+VuGI272Nr8kjUDsYKRY9Cx3Auj7aDL45DjPoJMzBGiFD2D+3IT356wbXe5V
         kMcyqCaq/Jd8OHBXnCzZj03PBPwRf2dI348+JyqATbnNv9A00dDWSeR2PtzvtfybJHFc
         9cZUaJoNjZINhOk5LgyemO6fJMwiCcVvn8WxfMTfqny2iDH9fZxqLEIY3tJ7fORAqCdd
         6lsA==
X-Gm-Message-State: AAQBX9cVtvDnhba0qPlB+qmeGyiSMcKCNTQmosbJie7WQaAkEbpOAuGu
        TMIIlHittOGIiwahV2EdOw==
X-Google-Smtp-Source: AKy350ZFLMdWujtv62S9b2atoWj5/+Ipi68c5D8aVR0u5Kg9UKFRTqw5ZWlxRl3ioOihcP+8ZlLrbg==
X-Received: by 2002:aca:1702:0:b0:387:cfb5:98f1 with SMTP id j2-20020aca1702000000b00387cfb598f1mr1230525oii.27.1680618418614;
        Tue, 04 Apr 2023 07:26:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a4-20020a4aae44000000b00524faf3d2d7sm5392916oon.41.2023.04.04.07.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:26:58 -0700 (PDT)
Received: (nullmailer pid 3835522 invoked by uid 1000);
        Tue, 04 Apr 2023 14:26:57 -0000
Date:   Tue, 4 Apr 2023 09:26:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com, Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCHv2 1/7] dt-bindings: soc: rockchip: add rk3588 usb2phy
 syscon
Message-ID: <168061841610.3835454.11500113945951398690.robh@kernel.org>
References: <20230403202307.120562-1-sebastian.reichel@collabora.com>
 <20230403202307.120562-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403202307.120562-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 22:23:01 +0200, Sebastian Reichel wrote:
> The usb2phy is accessible via a syscon registers on RK3588, similar
> to rk3399.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

