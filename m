Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60D1613E39
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJaT1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJaT1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:27:01 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5161612A91;
        Mon, 31 Oct 2022 12:26:58 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id c129so1989110oia.0;
        Mon, 31 Oct 2022 12:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4di/lLF30NiNOY2y58ftDsroYebuwIwGfqf6Xiyt+E0=;
        b=vSgbdPStC+zI8LpYqld5JPUeQ1qTyAMKgZOgd+3GLdD7XOKy5bQbNLPWh38J0h0yzt
         7xIe1JdPoceGDIQqI6EgNNaRuegFzxw7kNBGpfhqrQsTXUOaahIAOtQTOUzP9pVCCkKe
         442qoDSoSh4Cvq6axMEOiMAvlpOR89Hao3bWRSYCRfxnar4iqVJYHnM6lxUKXg7rG18I
         DPyWSB204G2hPue0nIOqmHwnHyzlcn9/Xz4Z8rsiqTYTzP7SxajRxcMM5NxagFucUSDl
         dQBDe39LlF8ufpFdwYvqeyp32gTu2TfPI2is/Hlz065WFs8HhRQjL59pWcZJ379oiETM
         Q6NQ==
X-Gm-Message-State: ACrzQf15RYGCpix4bvmp2GLDhaQx0z8k69WeYxMLpB+3wZHkBcWG7jnY
        I5CpjIrY+tw5SuBtaQj8aA==
X-Google-Smtp-Source: AMsMyM5fyIkq8Zl+7LyVSIvYffzfskCjDo4gOFtL9h+x5N0+BM8JPLZ1lf8gdt4Kt6YyWLzTPUNmCg==
X-Received: by 2002:a05:6808:1248:b0:354:2c04:c35b with SMTP id o8-20020a056808124800b003542c04c35bmr15190572oiv.143.1667244417543;
        Mon, 31 Oct 2022 12:26:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g10-20020a4a250a000000b00480fd5b0d6bsm436989ooa.22.2022.10.31.12.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 12:26:57 -0700 (PDT)
Received: (nullmailer pid 3287247 invoked by uid 1000);
        Mon, 31 Oct 2022 19:26:58 -0000
Date:   Mon, 31 Oct 2022 14:26:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mfd: Expect specific type for
 monitored-battery
Message-ID: <20221031192658.GA3286587-robh@kernel.org>
References: <20221028231309.565451-1-krzysztof.kozlowski@linaro.org>
 <Y1+MNL+fCfreAqMh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1+MNL+fCfreAqMh@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 08:49:56AM +0000, Lee Jones wrote:
> On Fri, 28 Oct 2022, Krzysztof Kozlowski wrote:
> 
> > Core schema does not define type of monitored-battery, so the schemas
> > are expected to reference proper type.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/ene-kb930.yaml      | 4 +++-
> >  Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 1 +
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> Applied, thanks.

NAK. Please drop or revert.

Rob
