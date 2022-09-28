Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9975ED1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiI1AVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiI1AVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:21:16 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B01FFA44;
        Tue, 27 Sep 2022 17:21:15 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id j188so13769093oih.0;
        Tue, 27 Sep 2022 17:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LSsI1UmaEiwpWOuPRPNW0BPxQ9ZAZbmqM52Owl/qreY=;
        b=hjchGnVAb9jEaVlWS4ic0wh+emsQM9bCtnEKO5j8itqSv5NoOE3p2FE+48RVeiLiiF
         MLloQgg4QluSAVjlgOLw33+JwJuEBq0osXZ4wKbkZAPCsHDKzZbKrF1pzwDyxmhTH15l
         1+1kZUWQlxX8gd7JyT4yduSqFnKockhtNa3ojTYPW8q5Ppdhp7eWT3p+AL801c3Mxul/
         KaG0686CMT5gDy5rDUiB37+iglMzi0vvA7hEN+M0ejFWKw3TPlEDYJqNgsbV/9zZIb1I
         f42rDTCxe5DEhZqKfsw/mtt1RtkVuMUd6GoJUqN9WZFAgpPpKoYoPeiTi+V24KmyWldm
         CVrA==
X-Gm-Message-State: ACrzQf3EDYczVxkx9fHYCJvAfAep9F6QchDS4oyfaV0DxEgDNndgvnYK
        8FiFAJ5nn2hI+YyQ/kolNA==
X-Google-Smtp-Source: AMsMyM5bsN/ft2HMu0c/dZL8o+CkzJS402pP0nPHvR88Qx+bmsvkGqWSoFiNsFMFLZhvYKhdeS4D6Q==
X-Received: by 2002:aca:370b:0:b0:350:805e:9741 with SMTP id e11-20020aca370b000000b00350805e9741mr3105419oia.115.1664324474613;
        Tue, 27 Sep 2022 17:21:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i19-20020a4adf13000000b004767df8f231sm1196760oou.39.2022.09.27.17.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:21:14 -0700 (PDT)
Received: (nullmailer pid 2687991 invoked by uid 1000);
        Wed, 28 Sep 2022 00:21:13 -0000
Date:   Tue, 27 Sep 2022 19:21:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>, linux-gpio@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 24/34] dt-bindings: pinctrl: qcom,mdm9607: do not
 require function on non-GPIOs
Message-ID: <20220928002113.GA2687862-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-25-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-25-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:52 +0200, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> ---
> 
> v1 was reviewed by Rob, but patch was changed since that time, so not
> adding Rob's tag.
> ---
>  .../devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml        | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
