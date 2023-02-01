Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F672685CC5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjBABor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjBABoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:44:44 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3A45264;
        Tue, 31 Jan 2023 17:44:43 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id s17so3589682ois.10;
        Tue, 31 Jan 2023 17:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXwTZgiPmgELyuj9MUwWX8YzaCtDhA3ytFvllU7DMXs=;
        b=lGmJuSdYkOm75qM1KJlOYW+O8AAvbyLqRtFxM5vYqreg9ksW+JibVXk8QrzkYWfWhV
         eLwIumzc4lOEMQTvBhWa+mNCp+DaW02dHl0Yd2vNpgmw7tZiQOVqFMxlDzYdupxMancB
         oHc7TCujr261IPi3xHGpoQpfPCnKpVLgVLnjVvwTvEXdmEYe3PCfnEZMTC9DK/Hs0Ttt
         85YMxiv/VO+xQYhCCD0/jEBkL97xe3fWEC0/XDUSDM7xZ+F6TNgCAixp39rwLwjaFfb2
         l3i2duR0tauGLZEOkCmNk0zjd5l7NKnyMUIJRxKD72yFj9+O7SSV5lBFZiJgE76OWSdp
         arAw==
X-Gm-Message-State: AO0yUKVt/So7whsT17VL6O3H/ghu1JuLxQXC80DJszV7nUKE3ohMNGwS
        /XohyJWJLhffCMT3SxR+8Q==
X-Google-Smtp-Source: AK7set+FZoHi7elOF65zpP8ZutGk1Jngax+dH8ZskVeZ8YY0Mo5VpXGo0yGCn4+eTAs/apLAEMHCQg==
X-Received: by 2002:aca:110f:0:b0:378:477c:3e0e with SMTP id 15-20020aca110f000000b00378477c3e0emr302653oir.45.1675215883089;
        Tue, 31 Jan 2023 17:44:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s33-20020a0568302aa100b0068bd3001922sm3076967otu.45.2023.01.31.17.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 17:44:42 -0800 (PST)
Received: (nullmailer pid 2297811 invoked by uid 1000);
        Wed, 01 Feb 2023 01:44:41 -0000
Date:   Tue, 31 Jan 2023 19:44:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: crypto: Add StarFive crypto module
Message-ID: <167521588146.2297772.10966946099496116680.robh@kernel.org>
References: <20230130154242.112613-1-jiajie.ho@starfivetech.com>
 <20230130154242.112613-2-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130154242.112613-2-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2023 23:42:39 +0800, Jia Jie Ho wrote:
> Add documentation to describe StarFive cryptographic engine.
> 
> Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  .../crypto/starfive,jh7110-crypto.yaml        | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

