Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFD661920
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjAHULz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjAHULj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:11:39 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CE62F1;
        Sun,  8 Jan 2023 12:11:38 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id c20so3937604ilj.10;
        Sun, 08 Jan 2023 12:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYqV2nU6Tw+z/B9Vx5GFoYY8jor9qYP+w2UEpApgQ08=;
        b=DMWTOyzZb0+B8WmUPM/lk1SuNYikJRr8fz7WgoBtIi6A1lqun2xI43Zg2JGmmMaY40
         99TUtIDa1ct1373pfJmlp/GAveVo+1oB3lj8jrX4J1zd1GECCZJkP9Hnk8B28zN37X9a
         n1Ei8SgMqB6i+NouKqD1eYmERzbDBf5N6WcI9v3GXImjLAfEJtWUNmtapfoXsa1nnttM
         MAlkMFAIkovlY3PUPf5X4gb8PWEOfsbVY2vc8L1p1y0VATdrdU93uE4qnOm6wkl0lwqE
         FRuKqsl1RAKRBD9Rk/TGDo/MZKU6XHzAr/MAYBGuXniChBcWiPV92vCGanHftVQ0lKvH
         SSCQ==
X-Gm-Message-State: AFqh2kr7jRvf8GguzmdcPb7cu+eUm4/Ypp8Jb9T2RsqXNS8FJzyLCwB3
        WmKZprdF3Q/Lq+REWV6hyQ==
X-Google-Smtp-Source: AMrXdXsHfgs1cHUnKltEtLa0KqWSXV3E9bCzQ4zGJ19lAcT2OO1H8eMT3x0WTdWIsAN8ZpunqaLz5g==
X-Received: by 2002:a92:d684:0:b0:30b:e8a6:2772 with SMTP id p4-20020a92d684000000b0030be8a62772mr49305095iln.24.1673208697428;
        Sun, 08 Jan 2023 12:11:37 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id r7-20020a92c5a7000000b0030d7eb788e6sm2199238ilt.31.2023.01.08.12.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:11:37 -0800 (PST)
Received: (nullmailer pid 216447 invoked by uid 1000);
        Sun, 08 Jan 2023 20:11:27 -0000
Date:   Sun, 8 Jan 2023 14:11:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-gpio@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/9] dt-bindings: pinctrl: qcom,sm8350-tlmm: correct pins
 pattern
Message-ID: <167320868698.216111.10132559326075486139.robh@kernel.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
 <20221230135645.56401-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230135645.56401-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Dec 2022 14:56:42 +0100, Krzysztof Kozlowski wrote:
> SM8350 TLMM pin controller has GPIOs 0-202.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
