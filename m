Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CA86F0B12
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbjD0Rkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244089AbjD0Rke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:40:34 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56744423C;
        Thu, 27 Apr 2023 10:40:08 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-546ee6030e5so4633488eaf.3;
        Thu, 27 Apr 2023 10:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682617161; x=1685209161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AD3fQdKaQFdku2aIFjpNovuQ9wn6Q2sNynbCaMLgODE=;
        b=f1cKqGk4LMsllSHXvlXBbDerx2hThF5rV+jYj+N31H6fqYutdXmtnX0HivXfF6e5cw
         pBmzHese6F+BIz9jmqrXbEo5qkwnX/cfzKGfLM9g36dqPCpfsIJN3WBM484xvAqa64qt
         tyy0PbmvMNEZa2I/eRLWJImcCUEmiXkfcNAOy8QYIvwhddAUlThlAWJUxE04X05SpGqe
         D4Zpys6735QhM336BUlZfZnAsBUks5M+tIImUsY3w53jrokPe//GpodSAs6Q69B1dHti
         /8tcKkz/5i4vG2UHOJStF9ghTD4vGoufg0nGbuiAGexlZcGY8XDa7gVjUXwB/oOVWnCB
         NXyg==
X-Gm-Message-State: AC+VfDxeKWwO2tCP7A+7UARmiTe5D9FF8g4xPs1i7waRzFGpzo/WKRNP
        iysJtO6J5koqH7BxTongC6v19dk35g==
X-Google-Smtp-Source: ACHHUZ4503HyHI7UJ3zKQxVNIZ7VAtQFhpl7W6Stdj0s/zR4e0u8lGqIZxNeWBv5Zi0MxXJgKlORiQ==
X-Received: by 2002:a4a:d896:0:b0:547:5725:7711 with SMTP id b22-20020a4ad896000000b0054757257711mr1407382oov.6.1682617161624;
        Thu, 27 Apr 2023 10:39:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 27-20020a4ae1bb000000b00541fbbbcd31sm6196058ooy.5.2023.04.27.10.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:39:21 -0700 (PDT)
Received: (nullmailer pid 3209698 invoked by uid 1000);
        Thu, 27 Apr 2023 17:39:20 -0000
Date:   Thu, 27 Apr 2023 12:39:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     conor@kernel.org, devicetree@vger.kernel.org, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1] dt-bindings: riscv: explicitly mention assumption of
 Zicsr & Zifencei support
Message-ID: <168261716012.3209643.3723944369525088026.robh@kernel.org>
References: <20230427-fence-blurred-c92fb69d4137@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427-fence-blurred-c92fb69d4137@wendy>
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


On Thu, 27 Apr 2023 11:43:42 +0100, Conor Dooley wrote:
> The dt-binding was defined before the extraction of csr access and
> fence.i into their own extensions, and thus the presence of the I
> base extension implies Zicsr and Zifencei.
> There's no harm in adding them obviously, but for backwards
> compatibility with DTs that existed prior to that extraction, software
> is unable to differentiate between "i" and "i_zicsr_zifencei" without
> any further information.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Conor Dooley <conor@kernel.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: linux-riscv@lists.infradead.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

