Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5415D6B1657
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCHXOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCHXOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:14:34 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0566486F;
        Wed,  8 Mar 2023 15:14:29 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id g73-20020a9d12cf000000b006943a7df072so96290otg.11;
        Wed, 08 Mar 2023 15:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678317269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHu/oGGSXQlPy/uql3D2VDJcT0bQkL/85Y5X0Ql3e9A=;
        b=Msss3uZ3NJslCQ19C7r/KAN4gQyr/MSClkcU8RADuZ9ZsLMZ4o+nrqjN1flQv9UsOM
         OQhOzsLcaGkBjkR7M5D1MkX/7qUftG+MhkQignlvSkPo7n96jVLLqkoEsCHmSsNYcwp3
         5yHU/oNeiJmaj5EH2NjD/h4kxS49DwBoDxn8CvZvt1dzULPgWXyAGUQeRlkCpSBRKaFt
         eK71MS2Yx5bGunpSJ9TABWUaCiE/bzq80aTazeQKdmdaw1nHAqKkIVy+Ss9YQA0bprOp
         ADEuYSx4VtDxaka1ilgvHtvphLdWh0bZ6q0lFZfDHAfObrgRHdKNa0iNNPmy8ScL+pEY
         oaPg==
X-Gm-Message-State: AO0yUKWMPtYLFkeKb88YZoDUC8QhZM4JjgxFsL3ckqqfg78c+ty8pMDG
        ZdOI6+ZHVOofSBcCWWCuROJ+AlG60w==
X-Google-Smtp-Source: AK7set/tyoSQViAmxTaUHy/Tj2H+uzwC8gFhM1OGhh8Tsia2+9aUxqpaCMsm85alcWBG/GLP99nbvw==
X-Received: by 2002:a9d:6d16:0:b0:68b:dd2c:77cf with SMTP id o22-20020a9d6d16000000b0068bdd2c77cfmr1772195otp.32.1678317268758;
        Wed, 08 Mar 2023 15:14:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y12-20020a9d714c000000b006864b5f4650sm7140599otj.46.2023.03.08.15.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:14:28 -0800 (PST)
Received: (nullmailer pid 4053194 invoked by uid 1000);
        Wed, 08 Mar 2023 23:14:27 -0000
Date:   Wed, 8 Mar 2023 17:14:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 3/5] dt-bindings: soc: renesas: remove R-Car H3 ES1.*
Message-ID: <167831726687.4053115.9108602835932174936.robh@kernel.org>
References: <20230307105645.5285-1-wsa+renesas@sang-engineering.com>
 <20230307105645.5285-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307105645.5285-4-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Mar 2023 11:56:39 +0100, Wolfram Sang wrote:
> R-Car H3 ES1.* was only available to an internal development group and
> needed a lot of quirks and workarounds. These become a maintenance
> burden now, so our development group decided to remove upstream support
> and disable booting for this SoC. Public users only have ES2 onwards.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../devicetree/bindings/soc/renesas/renesas.yaml          | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

