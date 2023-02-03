Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F43688B40
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjBCAAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjBCAAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:00:40 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E24D84196;
        Thu,  2 Feb 2023 16:00:36 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id n25-20020a9d7119000000b0068bd8c1e836so938561otj.3;
        Thu, 02 Feb 2023 16:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCzaKa5wkmjbvUEOBMnFEymMS89zsiOi/X15uYFryEI=;
        b=yM4EikrZrixpWCBAM8VuwpG2GRapZuCEnIliM8nUP74abPCdFWrBo3yGs4VKfn2nyp
         AvjG7qM8lD1MhVvvKpJYt3gwRlVhCaxFE2NPyGcV33A2UsnHVLIfQ9CtKknuRmN9MMP/
         FL5xaOBHfjY9z96DOuAibzP5oVdGANwnwVmBqApOuQ3LAzOUDgDnIYFVlkAhU/czf25l
         y3jmm2TVy9KkpEWgUmBF3hIgBYI1+7sJUXM1MFE0gHGhyiXfBgK4rcN4Pej3qJg0XNlw
         aoFVxGxmYrmpmiXlrZpSqwHv/XA86BKZJO6LD71FktvKgEveVCxm9YHBKmp5IW0WHv5D
         dulg==
X-Gm-Message-State: AO0yUKVbtPgfNrNxJ6iyZGtHEBwBj0jx58WCEkbcloAkNaJ3v7E61BG0
        thPF9Et1L7yJMlhGLu0ZWQ==
X-Google-Smtp-Source: AK7set+ExJfRFgsfqruk4gT1abA+BYAJ5I/vJg18pYkyZR0kFWh6DGOtIJc7j+wk81UnZ1J+Q+Xc1A==
X-Received: by 2002:a05:6830:6184:b0:68b:d1c7:4eb4 with SMTP id cb4-20020a056830618400b0068bd1c74eb4mr5646404otb.16.1675382435582;
        Thu, 02 Feb 2023 16:00:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a05683010c300b0068d542f630fsm410456oto.76.2023.02.02.16.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:00:35 -0800 (PST)
Received: (nullmailer pid 2934210 invoked by uid 1000);
        Fri, 03 Feb 2023 00:00:34 -0000
Date:   Thu, 2 Feb 2023 18:00:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vladimir Lypak <vladimir.lypak@gmail.com>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Iskren Chernev <me@iskren.info>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dt-bindings: pinctrl: qcom,msm8226: correct
 GPIO name pattern
Message-ID: <167538243377.2934157.17799698260403483858.robh@kernel.org>
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
 <20230202104452.299048-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202104452.299048-2-krzysztof.kozlowski@linaro.org>
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


On Thu, 02 Feb 2023 11:44:43 +0100, Krzysztof Kozlowski wrote:
> The MSM8226 TLMM pin controller has GPIOs 0-116, so correct the pattern
> to bring back missing 107-109.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

