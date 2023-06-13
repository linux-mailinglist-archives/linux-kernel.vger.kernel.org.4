Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EB772E459
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbjFMNkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242611AbjFMNj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:39:56 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AA591;
        Tue, 13 Jun 2023 06:39:56 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso225293639f.3;
        Tue, 13 Jun 2023 06:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663595; x=1689255595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAcO8aRahkj8UvOl4ehKX1nSMyS7yJ7o7JUJATO5x/E=;
        b=KTqr7QhkmEcT0U6lspc1ABv23gB/oHJguv5GbfUZIrOdED40MPW16xmTKS3LOFs4MY
         3RxII3NnIcUTeIwG5WV77xcTqU4XPIOFPWz92+RTAsvaAVxvu53DWnsXk6bfs15VvYty
         B+tUI7vSvC/gfMxoKx8DMWPWJP8/opV0ZEIW4gH3JkE0NGCj37VhjNm4C71+lAsKaspg
         h0mFkgJvErjMPXfXcqw2aefgGAp0FUzi+JkeN5UOBKCfNvSS7Edqk61I508mpOTZ3vDR
         I5ZvXeN3bLUidlW8rAbqPcxZq5oGvm7IjxiFP1qoHQI6YZzMzxXRseIKVNani8KxlpRt
         Xgxw==
X-Gm-Message-State: AC+VfDzXl0zZ2DN7X8CGTmsX2BUYZMl+a3ImuzpzltF4G2QiUApi5MfF
        wRwelAOY2zPhnCILIdh55g==
X-Google-Smtp-Source: ACHHUZ6/qWTSG2w5eZ/Z9HURNz6vaXyzfcXSj0/JSmDpa+Dk1TjG4dV6AKWc4JbEzw+TOnb6U5vooQ==
X-Received: by 2002:a5d:9e4f:0:b0:776:f31f:aba2 with SMTP id i15-20020a5d9e4f000000b00776f31faba2mr10806622ioi.5.1686663595314;
        Tue, 13 Jun 2023 06:39:55 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n28-20020a02cc1c000000b0040bbfad3e28sm3355083jap.96.2023.06.13.06.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:39:54 -0700 (PDT)
Received: (nullmailer pid 1775418 invoked by uid 1000);
        Tue, 13 Jun 2023 13:39:53 -0000
Date:   Tue, 13 Jun 2023 07:39:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: regulator: max77857: Add ADI
 MAX77831/MAX77831 Regulator
Message-ID: <168666359292.1775358.3492312162797438910.robh@kernel.org>
References: <20230613080552.4492-1-okan.sahin@analog.com>
 <20230613080552.4492-2-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613080552.4492-2-okan.sahin@analog.com>
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


On Tue, 13 Jun 2023 11:05:49 +0300, Okan Sahin wrote:
> Add ADI MAX77857 and MAX77831 Regulator device tree document.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  .../bindings/regulator/adi,max77857.yaml      | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77857.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

