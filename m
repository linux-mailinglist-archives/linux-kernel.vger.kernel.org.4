Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E07F6BDCA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCPXDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPXDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:03:45 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CE2BD4E2;
        Thu, 16 Mar 2023 16:03:44 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id i19so1859322ila.10;
        Thu, 16 Mar 2023 16:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3vqXXLwqv2XRky9iyecIB+2xC8KFM8iq/pRksSGaDY=;
        b=Rc68iAREGBNfwPETlbzxqRdLhJ0tVux0lNq79AdmnAYMx5Gw7GPuB6dtIuuYwQcwds
         mL8nHZDVsc/hN1F42MHz0DX+jz+trRU4EMDB5Xn6kPiCo2X5reUkqO4XsyBklAz4HBmO
         hqPJyx1SbL/61nkQa7QugOcexpB9jJjKSUs31Pu26oYFd75o0lniyTUv/t+nrbge/toZ
         /2JEa1G6KheJYdUVdD6j+P9bU/8yWq16+pji6c3Q4Ri6zjF7JxM0DrJk7fRj/834GFC/
         mtFtRXthflp0JtH0iDYBE9lr4ZS0luaK31ORwjaE34AcQ9XYuyK1gvLTcSx3cPE4KKoq
         m89Q==
X-Gm-Message-State: AO0yUKUoYGdsJBqRpsrKj4jIA8/Gkc6c7nhs/BgH0WjcM0mP1aazKj3V
        O0RrpyDIth3YuHUASNC2xw==
X-Google-Smtp-Source: AK7set+KtYnW8zMo/o5tGP6SAbrOZZwVFCpK7S1AMRI04tsXzGoeXfTQvecCDoQGfCwFP5RJ9D+uBw==
X-Received: by 2002:a92:6a0c:0:b0:317:9c8b:c0a7 with SMTP id f12-20020a926a0c000000b003179c8bc0a7mr7745417ilc.11.1679007823331;
        Thu, 16 Mar 2023 16:03:43 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id c5-20020a056e020bc500b0031112bb19e9sm158706ilu.54.2023.03.16.16.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:03:42 -0700 (PDT)
Received: (nullmailer pid 4050407 invoked by uid 1000);
        Thu, 16 Mar 2023 23:03:40 -0000
Date:   Thu, 16 Mar 2023 18:03:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 05/12] dt-bindings: usb: snps,dwc3: document HS & SS
 OF graph ports
Message-ID: <167900782010.4050347.7367290857102133764.robh@kernel.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v3-5-4c860d265d28@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v3-5-4c860d265d28@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Mar 2023 14:27:56 +0100, Neil Armstrong wrote:
> Document the optional ports subnode to describe the High-Speed
> and Super-Speed connections as separate OF graph links.
> 
> The ports property is an alternative to the already documented
> single port subnode property.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

