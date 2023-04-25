Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04D46EE7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjDYSzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbjDYSzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:55:19 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6A016F33;
        Tue, 25 Apr 2023 11:55:02 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-546615d6f47so3886312eaf.0;
        Tue, 25 Apr 2023 11:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448865; x=1685040865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6y7CuaWGG4f2cR6D1dHG8n9H6ZV3XhXaEAnqjecAYoY=;
        b=VabjucDEMNi32e/OQTZrI+Z2ewa7s630759yis6U5PlwJJJZ/t3ouPIJnBsdkzQh07
         uhKLGkMuLP5i40dhMwc8Dk6KyYzHv/YcFNrxI1TrwwxGZR92sx4t3Hg2OJVgHpskMceq
         9dF3Ii7oMwY/xLQed5Op+JUUkXH3BgkKePFgIlm1iQIoGqXJ1Sh6KIIyONYICnCFWrIe
         SC0q+JJjEQ21sL4XM64V+f6XWWE8LjBaXl0pErDtYb7XMA4RfBuy1AoP9mTtakoBSCpp
         IQeRu/f6RG2s1llHDePfrJbEo4pIhVmr5Bzeib2ty9C5opZYkH5hQOVezFD5LHGjvGHc
         Z+yA==
X-Gm-Message-State: AAQBX9cBdyUiAXSoiqHtgnoZF7p79iA5RU3GDXTsa+HE/YIxeUIZFVM7
        jlYd+xR4GAfIiSeYuXqReQ==
X-Google-Smtp-Source: AKy350ZgWB2rPL7vzrqJCgeshN8YMDvzpzXhtbPchKiP/hbFnojfOGoW8uB4QIS0QWg5LDfTnrxnmg==
X-Received: by 2002:aca:2315:0:b0:38c:11b3:a397 with SMTP id e21-20020aca2315000000b0038c11b3a397mr9259981oie.14.1682448865005;
        Tue, 25 Apr 2023 11:54:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y10-20020a544d8a000000b0037b6f5d6309sm3774393oix.2.2023.04.25.11.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:54:24 -0700 (PDT)
Received: (nullmailer pid 2079162 invoked by uid 1000);
        Tue, 25 Apr 2023 18:54:22 -0000
Date:   Tue, 25 Apr 2023 13:54:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mantas Pucka <mantas@8devices.com>
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Anusha Canchi Ramachandra Rao <anusharao@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: mmc: sdhci-msm: add IPQ6018 compatible
Message-ID: <168244885070.2078831.17064973248574990697.robh@kernel.org>
References: <1682338412-15420-1-git-send-email-mantas@8devices.com>
 <1682338412-15420-2-git-send-email-mantas@8devices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682338412-15420-2-git-send-email-mantas@8devices.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2023 15:13:31 +0300, Mantas Pucka wrote:
> IPQ6018 has a sdhci-msm compatible MMC controller. Add the appropriate
> compatible to the documentation.
> 
> Signed-off-by: Mantas Pucka <mantas@8devices.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

