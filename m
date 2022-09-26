Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2599E5EB55D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIZXRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIZXRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:17:51 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EB920BD3;
        Mon, 26 Sep 2022 16:17:51 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id z18-20020a9d65d2000000b0065c3705f7beso1197926oth.9;
        Mon, 26 Sep 2022 16:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pUDlAiYbWhBILgcfHOGN1vnbsJE8NU2E56Bj22cEp2w=;
        b=X4RS9eIcP0cI8mNbQNdX7N1Q+7yyCSsOWF0yQ/Ra58B/hrcRnHo2GEbtoDB3s3bSSU
         YKTgaqWIWtfxODGbyZFtudrsD1O9MBalgGdpsxFZn4F7Zhj2RhgnnqOq1zFkJoAZtytA
         Ol5jahkUw8TBdnmOa0qi5QxeHsuY7jqx7knudlalzG8m0oz/WegERORotreh/CsJLcqc
         8LLvfT2DBqk2wD8gUf2oAkJg/B7rp06HrMFQQjrR7l/th5nCZDssTVjxyHaPjNuZx6vG
         dre7OGSm6Dso1PMd8aj+XlzpXcGgJN6Ji6FU1ww6Dg3Ehlz3lmixGWIotDM4p4l4V70q
         sFbA==
X-Gm-Message-State: ACrzQf2IZYvkVko057W6rGIVMk7kLHwghGTI3UzKOw0hFbm999j40EdM
        xNX6Eadumq6jc4uPLnCriw==
X-Google-Smtp-Source: AMsMyM4TI174Y1YBND+dh3btcgJpiUv8C3jD84mPo0OBvxz/w9zvW0Y1WKaN68s3Qp7my05HBeB7kw==
X-Received: by 2002:a9d:6957:0:b0:655:f174:9fc3 with SMTP id p23-20020a9d6957000000b00655f1749fc3mr11023825oto.282.1664234270557;
        Mon, 26 Sep 2022 16:17:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w25-20020a9d77d9000000b00656039161b1sm8587568otl.40.2022.09.26.16.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:17:50 -0700 (PDT)
Received: (nullmailer pid 3155607 invoked by uid 1000);
        Mon, 26 Sep 2022 23:17:49 -0000
Date:   Mon, 26 Sep 2022 18:17:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: qcom,a53pll: replace maintainer
Message-ID: <20220926231749.GA3155562-robh@kernel.org>
References: <20220924081329.15141-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924081329.15141-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 24 Sep 2022 10:13:29 +0200, Krzysztof Kozlowski wrote:
> Emails to codeaurora.org bounce ("Recipient address rejected:
> undeliverable address: No such user here.").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,a53pll.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
