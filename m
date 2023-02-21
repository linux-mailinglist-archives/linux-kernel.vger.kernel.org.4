Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF5969D831
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 02:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjBUBw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 20:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjBUBw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:52:26 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2048C23331;
        Mon, 20 Feb 2023 17:52:23 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id t7-20020a9d5907000000b00690ecb95d46so700318oth.2;
        Mon, 20 Feb 2023 17:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi1IHeazYYEWx6mNRMLdVVgjAAhBuj7GZD4rymghCng=;
        b=qVws9iOjZmIh6BQeFeflBguc/z0co8wwUa1Y+lyKrLwDsrzMC2w1rQeaX4fMPFG6Rb
         fjtOWRcsFizgS2OvWoWFjFsViZOQsUBHZJ+h9gNotoaTi1ul51sg6/sWFEI5f0qvtMFh
         j/F5fxgehYY2aY0V+lE4FZhWhyJlJR86T4OYVU7vNh8g5o1tIyEKzZscM6FFBE43AZM+
         hq69M4oeBkXOp/Qffluj/F6+/83rQJe+9A8HvyXDEI+gymH8u1IPBbD4f7IXV7P6xgty
         KuNoIO+jIg3Xn8SetfrxVvZu3IzMm3LGIHPwCxW4j7JY793tC6OT3Pvq3aX0pORaY9zE
         YrOg==
X-Gm-Message-State: AO0yUKWYrdUGMwf/hbVx0DBcksusJuIlPjB7TIEuKiPZJEvAqlC5xJvi
        2iXlBAHRRSaF6rJDNeWd1w==
X-Google-Smtp-Source: AK7set+qwMWOprLi/02IwOHP2ZsyMiK2RmjnRFXtdIi9B9/7B4Yyv4jJhDa4+McVoDdW0GmPs/I4gQ==
X-Received: by 2002:a9d:1d0:0:b0:68b:cc5c:184b with SMTP id e74-20020a9d01d0000000b0068bcc5c184bmr6548517ote.20.1676944342349;
        Mon, 20 Feb 2023 17:52:22 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j2-20020a9d7d82000000b0068bc48c61a5sm5510368otn.19.2023.02.20.17.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 17:52:22 -0800 (PST)
Received: (nullmailer pid 795753 invoked by uid 1000);
        Tue, 21 Feb 2023 01:52:21 -0000
Date:   Mon, 20 Feb 2023 19:52:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        marijn.suijten@somainline.org, Luca Weiss <luca@z3ntu.xyz>,
        andersson@kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add Cortex-A715 and X3
Message-ID: <167694429319.794567.8538815545985460688.robh@kernel.org>
References: <20230216110803.3945747-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216110803.3945747-1-konrad.dybcio@linaro.org>
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


On Thu, 16 Feb 2023 12:08:02 +0100, Konrad Dybcio wrote:
> Add compatibles for the Cortex-A715 and X3 cores found in some
> recent flagship designs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

I took this for v6.3. No need for it to wait.

Rob
