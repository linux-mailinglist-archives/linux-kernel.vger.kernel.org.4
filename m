Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD66DE2AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDKRf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDKRf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:35:56 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D844C1D;
        Tue, 11 Apr 2023 10:35:54 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1842e278605so10666540fac.6;
        Tue, 11 Apr 2023 10:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681234554; x=1683826554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxRBAACOQmsDZVgDcPTJclqhGazIBd8TxXM9U+CJTBI=;
        b=idMEK7tZ09SPnGFugX7F8nrxWzDaIGCsFSEqFTxpZGyD9vkvfwbFjE3JHsOjc9M5wr
         ayRH7J5VMz9b9s91bbsh3ypE9oUpMtF2F8BrA2CJ60DCIQsrBs7lJpWLX3NGFZFjz0Nt
         2ttVlUw4qrKLloBa80jI/8VYzSHDoG9Um8WXiq7xCt3HSUoNG9utY6g9ddIWMZeB6lcr
         9FTl2bS0Uc+OJEAsGapnzK3yxnTsUZmC7kQTpokDaUGvHmhLP8k3saV8v47qGXji2uRO
         MXfsfYTvWP49r+si1xHSAKmf3StXSTjZuWJkO9v3Y4So9ZkoH//stdu9w7MBE+Xs/T8X
         yUSA==
X-Gm-Message-State: AAQBX9f65OdIYWT+mT+9U3+9LSiHzaXCzXSFAsLLnYHLeDhHyFDSMVV1
        sfLCafge2046A8STdidoiA==
X-Google-Smtp-Source: AKy350aev31o0vgGv6uWzPdOHgbdJoRi/zmhZhoVmHDysdeBlPq+SlCNvhSStCjGd9NLZUXNevO6rw==
X-Received: by 2002:a05:6870:8912:b0:179:95f2:56e8 with SMTP id i18-20020a056870891200b0017995f256e8mr9160035oao.3.1681234552427;
        Tue, 11 Apr 2023 10:35:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t21-20020a9d5915000000b006a13dd5c8a2sm5582333oth.5.2023.04.11.10.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:35:52 -0700 (PDT)
Received: (nullmailer pid 3418439 invoked by uid 1000);
        Tue, 11 Apr 2023 17:35:50 -0000
Date:   Tue, 11 Apr 2023 12:35:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/40] dt-bindings: pinctrl: qcom,ipq5332-tlmm: simplify
 with unevaluatedProperties
Message-ID: <20230411173550.GA3408186-robh@kernel.org>
References: <20230407184546.161168-1-krzysztof.kozlowski@linaro.org>
 <574d3aa5-21f4-014a-8cc7-7549df59ff3c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574d3aa5-21f4-014a-8cc7-7549df59ff3c@linaro.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 08:54:43PM +0200, Krzysztof Kozlowski wrote:
> On 07/04/2023 20:45, Krzysztof Kozlowski wrote:
> > All Qualcomm SoC Top Level Mode Multiplexer pin controllers have similar
> > capabilities regarding pin properties, thus we can just accept entire
> > set provided by qcom,tlmm-common.yaml schema.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> 
> Linus,
> 
> If you prefer I can send all these to you in a pull after getting some acks.
> 
> 
> Rob,
> 
> Feel free to ack once for all of them.

There's no cover letter to ack them all (and b4 to pick up), but I guess 
that's your own problem in this case. For the series:

Acked-by: Rob Herring <robh@kernel.org>

IMO, this should just be 1 patch. It's 1 change for 1 platform family 
for 1 subsystem. There's just no point when it's all the same people 
that will review it and apply it.

Rob
