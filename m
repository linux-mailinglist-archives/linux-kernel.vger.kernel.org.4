Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3411736F22
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjFTOvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjFTOuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:50:55 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826291710;
        Tue, 20 Jun 2023 07:50:51 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-77b00bb3fd6so162548539f.1;
        Tue, 20 Jun 2023 07:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687272650; x=1689864650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiKQ5hP9aMypDr6PQyGYdVmLylbM5CtCzwxbvKKKfHo=;
        b=B0mNsXaHn0Sb0ycwN/o7E9qL/OI0Qqy94sn0OvrinjhQyXhAFXKm8+7Z3oQ/+7vHhW
         VVgg13quv6g/y81LdHCZE/mX2oVd2O5DwOPxXd2yfv4one+Vp16ejSt1W4ya6IdcS+hF
         /zYUOy2jX09wcanlfp1tjMKd3U917JszhWFxKGb+Xe0C4roXmrjGPTRvuYAGpYCeT7iu
         pEXKFSKlAkePoVlC5nU9ydHablN8GBmJYChXtXm7AakiWqbLgluia58LowDY2/1xGSD7
         frPef0OYFvUdMgg/RKaaZvsfH/lnZ+dSxwocIoCS5lZERUu/M2APIrDdIwtZpSeUiHSw
         qSSw==
X-Gm-Message-State: AC+VfDwPCW87/o7mIMlOhmU0V5qC0P07WRuLpvjERAX/Bx6lKqnghZ6L
        cUGaqkYsMXRBs7PXRP2XSA==
X-Google-Smtp-Source: ACHHUZ6uninFwYNKrueL8yvsBNxjR3NlRFWjJ2Rdy0mjyWvhSYXjfk3TA0XV6NCs5SHens653N3PoQ==
X-Received: by 2002:a05:6e02:1111:b0:342:3c46:2d3b with SMTP id u17-20020a056e02111100b003423c462d3bmr5536098ilk.12.1687272650730;
        Tue, 20 Jun 2023 07:50:50 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id em26-20020a0566384dba00b004267abdb240sm687320jab.38.2023.06.20.07.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:50:50 -0700 (PDT)
Received: (nullmailer pid 3576737 invoked by uid 1000);
        Tue, 20 Jun 2023 14:50:48 -0000
Date:   Tue, 20 Jun 2023 08:50:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: drop unneeded quotes
 and use absolute /schemas path
Message-ID: <168727264646.3576635.1973418219483672102.robh@kernel.org>
References: <20230609140749.65102-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609140749.65102-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Jun 2023 16:07:49 +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.  Also absolute path
> starting with /schemas is preferred.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

