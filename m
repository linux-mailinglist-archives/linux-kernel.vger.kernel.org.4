Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40A9697210
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBNXs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjBNXsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:48:06 -0500
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8EB303F7;
        Tue, 14 Feb 2023 15:47:40 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id u8so6933935ilq.13;
        Tue, 14 Feb 2023 15:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpPZszrCAS+I7Dsv6vN6PL8MO3yZHHAYUe2N+KaH1dA=;
        b=kX+MykXd38F34UKqHUnptRhi5AvOG9nM3731hF2Bqfos2cMvvIymSRFfPN5uNj1xQP
         V4KLotmRyThiw7uopa/+6qxGFURTkedJz28dhNFLZCKxFPTHWjzk1kqeZE6r4fLph1O6
         wv4TTEGE2Ltrnu8cOXMToz6uRf1PQYH+i4ATjypHltGSma/Nyx7D5uF5DDbux+7Sw/bw
         uMwiyey0HGeF8qWwglkQoEayIYDEhqq2yRjC3n/wpP4YBFZ8q8PmnM7v7z35eFoKzjEL
         IKY7uaQA4RRLu5WtMO3Vh7hY3Io5ioXsgSeZvxWWtRLFrq7GLPWbAR4rjw42CxIgrlNt
         v4ig==
X-Gm-Message-State: AO0yUKWyGvWOX1I8g1mFlU9vXHIBNn8vtTBdY435A9wIWeVl7nUUCiIH
        cHm4GapI2sXbL6LGm3dJzg==
X-Google-Smtp-Source: AK7set9gngvgX1v9SjvKei6xXJ7wLaQx5dvigMVGlW8OG7IGyqQEP8OzuFk6CUd6HxYoWN/3kSsTMQ==
X-Received: by 2002:a05:6e02:20c5:b0:315:4f67:7054 with SMTP id 5-20020a056e0220c500b003154f677054mr460708ilq.19.1676418456717;
        Tue, 14 Feb 2023 15:47:36 -0800 (PST)
Received: from robh_at_kernel.org ([65.158.198.5])
        by smtp.gmail.com with ESMTPSA id y20-20020a02c014000000b003a4419ba0c2sm5084450jai.139.2023.02.14.15.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:47:35 -0800 (PST)
Received: (nullmailer pid 42204 invoked by uid 1000);
        Tue, 14 Feb 2023 23:47:34 -0000
Date:   Tue, 14 Feb 2023 17:47:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: qcom,rpmh: Correct PM8550 family
 supplies
Message-ID: <167641845356.42141.15153738219686589662.robh@kernel.org>
References: <20230210155930.549082-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210155930.549082-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Feb 2023 16:59:30 +0100, Krzysztof Kozlowski wrote:
> PM8550 is different than PM8550VE/VS, because the latter has much
> smaller amount of supplies (l1-3 and s1-6) and regulators.  The PM8550
> has on theh other hand one pin for vdd-l1-l4-l10 supplies.  Correct the
> if:then: clause with their supplies.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/regulator/qcom,rpmh-regulator.yaml  | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

