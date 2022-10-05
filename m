Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EDA5F5507
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJENI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJENIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:08:25 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49F26A489;
        Wed,  5 Oct 2022 06:08:17 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id m11-20020a4aab8b000000b00476743c0743so10757651oon.10;
        Wed, 05 Oct 2022 06:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3t+GscuuDlNI3lPYH9+53v6c5AMIA5UB0rxRf4WczLI=;
        b=SY5q+BDBc6L9LOzM4DSEx9sBeBtTlz2GPks4lCRKIHQ4VEmr4BLa47mcdjPnEeZO4d
         A8i+8K2yzSrmR4PYqgVhiWNx0iSxte7GVtmpgIHookSlyji9F76wOoEIiTectqa0YIEu
         ftcJDXYM3KTLzgm8Aw2wv6ul4+rNZEIu0lTXY/pXaVb0Orhpoq0rRsEtkHA8QfW2KSF4
         NRxqeDh7EiZmRBPiR6OD+9S5RzjXY4EvJmcp7bHImyIOyarH6R0It+EhZyrGyFdBsg2E
         B9ituPQ8d82KJ3mmp3QnaWPGfbKwHqpBTuCMOlJvhTmfKhhzyqh5Qmeb0bEGmPcJfmnR
         EU+w==
X-Gm-Message-State: ACrzQf2cILv8WKB2AI/UM8wgJjDoo0OpBpvmTDSOMlrVsT4hvjR6DSsw
        oAohJqMY5qQOwU7Q66+gOgiDvUI4Hg==
X-Google-Smtp-Source: AMsMyM4q/HGTToLRqz7AqWvI/17SkBm4JEFT4t2hNCcS793qd+QzBZ07JBmeBJ3urLCd+Z60PXBUYA==
X-Received: by 2002:a9d:4a1:0:b0:65c:4497:6cd9 with SMTP id 30-20020a9d04a1000000b0065c44976cd9mr11633009otm.188.1664975296268;
        Wed, 05 Oct 2022 06:08:16 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id 188-20020aca06c5000000b0034d14c6ce3dsm4275306oig.16.2022.10.05.06.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:08:15 -0700 (PDT)
Received: (nullmailer pid 3248915 invoked by uid 1000);
        Wed, 05 Oct 2022 13:08:13 -0000
Date:   Wed, 5 Oct 2022 08:08:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     pavel@ucw.cz, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andriy.shevchenko@linux.intel.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v13 1/5] dt-bindings: leds: mt6370: Add MediaTek MT6370
 current sink type LED indicator
Message-ID: <20221005130813.GA3246955-robh@kernel.org>
References: <cover.1664991040.git.chiaen_wu@richtek.com>
 <d59807369c2ad245245514c49d9f91d47c8a5851.1664991040.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d59807369c2ad245245514c49d9f91d47c8a5851.1664991040.git.chiaen_wu@richtek.com>
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

On Wed, Oct 05, 2022 at 07:43:54PM +0800, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add MediaTek MT6370 current sink type LED indicator binding documentation.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
> 
> v13
> - Remove 'allOf' property
> - Add '$ref' and 'unevaluatedProperties: false' in 'multi-led'

I already applied the binding patches from v12. Send incremental fixes.

Rob
