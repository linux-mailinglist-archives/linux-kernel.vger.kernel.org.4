Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB37D73FD8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjF0OOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjF0OOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:14:45 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA43DD;
        Tue, 27 Jun 2023 07:14:44 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-345b347196cso6009775ab.3;
        Tue, 27 Jun 2023 07:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875283; x=1690467283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtpjMQbRGvdxDL2EiL2bPErftGmwHaii42RsuEkFumw=;
        b=bLlOOcaDK61XDR5J2fbGs0xnbr/IlVy3qW0+4x55ti2KWJr6JBWzw2YC7zfl75HJBc
         nVmJeJoJxbKuQ+yv9xVyu8G/twxSULJ/ERkwtVUwdrKwbSyoeDhwpTl8l97WHAJQvGdn
         zo8tAu2txUNO5k1OyB3XuRO1aMN+vU8Q0RQyejcZHW12Bu1/NOV+tY2VjxBcyF9jcgSX
         +c+Vv9gRbGzeiXxM6BdsEIcoHEFpPWXv+FEc6Xrrl7qsov/3q3YEW/nIxVxnbbQX6k39
         i+dlYMQCIaIRpuM0fdh3vIDK0PYo+NmMJ6V9EGmJavelO3eBAozeo2jEe5P7SN8epRPc
         jfwA==
X-Gm-Message-State: AC+VfDzRlx7c5QJB7jrEgpJKC+NK17BGuJ/WxIpvyb4qf+Kh/85MYL+f
        37f9YyjwfmCG7QK2nN/JmA==
X-Google-Smtp-Source: ACHHUZ7NAxk5LAin+xCrhfjlJOkHv5JLXmJQWTUTwr/xexg6usRWq7g4Gs4ln+qATm3UxdCFT/LtuQ==
X-Received: by 2002:a92:c08b:0:b0:342:3796:afd9 with SMTP id h11-20020a92c08b000000b003423796afd9mr28601216ile.31.1687875283442;
        Tue, 27 Jun 2023 07:14:43 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g7-20020a0566380c4700b0040fad79ac08sm2562055jal.89.2023.06.27.07.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:14:42 -0700 (PDT)
Received: (nullmailer pid 1847867 invoked by uid 1000);
        Tue, 27 Jun 2023 14:14:40 -0000
Date:   Tue, 27 Jun 2023 08:14:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>, conor+dt@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, tglx@linutronix.de,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v3] dt-bindings: interrupt-controller: add Ralink SoCs
 interrupt controller
Message-ID: <168787527937.1847641.4581724588120092902.robh@kernel.org>
References: <20230623035901.1514341-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623035901.1514341-1-sergio.paracuellos@gmail.com>
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


On Fri, 23 Jun 2023 05:59:01 +0200, Sergio Paracuellos wrote:
> Add YAML doc for the interrupt controller which is present on Ralink SoCs.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> Changes in v3:
>  - Drop '|' from description.
>  - s/unevaluatedProperties/additionalProperties
>  - Add Conor's Reviewed-by tag.
> 
> Changes in v2:
>  - Drop label from the example.
> 
>  .../ralink,rt2880-intc.yaml                   | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml
> 

Applied, thanks!

