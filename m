Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2AD66E713
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjAQTfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbjAQT3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:29:11 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B453E4D;
        Tue, 17 Jan 2023 10:34:52 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id p133so11361273oig.8;
        Tue, 17 Jan 2023 10:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lX+6Z0OlQ07+t9nQjvkv2dDMkjX1pwcJNWhvE932sdU=;
        b=RfHsCTn4rKj2P2vLdHyaPs80SczzrlCbI3K9QoBw8luK+p2sLYh5iwyrWLLllP7U8Z
         TheeCvL9Osz4jpveC2EN06ewySrEb5P6HVU6vCRKzcNh+cxTucSKbe7i6G6GCpLzZWZI
         yYk/CudZR3mDMlR9RtCP6Hl6oP0tsNRSiFkC2OJvFxWi9faEv01odvxfKBXGBYwReUYX
         Q80ncAT0edNun7smdMAbsv2N77EP0da4YF3ghr6iuCHrW3jJZZLBAk0R0dU6jAGA5+C8
         JFfjZNmF6ifDjVSYl6HmJybBVPLCH12E3JDaP9OlMlk33LiM5RiGSZWO7Y538NqMkFfJ
         TjxA==
X-Gm-Message-State: AFqh2kpe0/GhQvG4Dp9x4oR9lbY6bSUQ+p78qL2PgRKbpnqnfCeLQi51
        ACoMiCrq+jCcq7KS4cYGZA==
X-Google-Smtp-Source: AMrXdXvilM2PLUJPhr+TCdUeK5S5Diqs5zjhMdzfpDEA02/efrzjJvygZgdZLG92tuDhm11fpfNFPQ==
X-Received: by 2002:a54:489a:0:b0:35c:687:2ff8 with SMTP id r26-20020a54489a000000b0035c06872ff8mr1833297oic.21.1673980491272;
        Tue, 17 Jan 2023 10:34:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s40-20020a05683043a800b00684bc23f2cfsm9609899otv.32.2023.01.17.10.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 10:34:50 -0800 (PST)
Received: (nullmailer pid 3426273 invoked by uid 1000);
        Tue, 17 Jan 2023 18:34:50 -0000
Date:   Tue, 17 Jan 2023 12:34:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: qcom,a53pll: drop operating-points-v2
Message-ID: <167398048822.3426199.2848666545032964620.robh@kernel.org>
References: <20230113145859.82868-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113145859.82868-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2023 15:58:59 +0100, Krzysztof Kozlowski wrote:
> The CPU PLL clock node does not use OPP tables (neither driver).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,a53pll.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
