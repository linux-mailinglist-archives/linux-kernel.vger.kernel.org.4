Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608A56E6DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjDRUyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDRUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:53:58 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51A01700;
        Tue, 18 Apr 2023 13:53:23 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-38bcc5914ecso464174b6e.0;
        Tue, 18 Apr 2023 13:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681851178; x=1684443178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TrYUm+T8Wd2bLJ7okaAZD89A3g+NG0oDzgzaijoDZk=;
        b=fkVi29t7sDMP0ZJuJ/P7V8ymR8bWXdQtSxCDDT0+y0SZCdRW0TQlD5R9dJKPrdLYlu
         dAwP7EMSNcg8yZR0P6YfhiRNQcsS56E7rKct2T2pcchux5xTsPZytdFNZyM8zVcbbA1i
         bsKyd1QRjNJXWkLbj8epOaYvAJFNvaXTXYqLd25vh681+UrmgK9ARl+Ltk46qAmo6Sk0
         HtltEviAi90Jfs8x2e3EO2vBm59bQmwODV56MLH2U/rfUVEEsD+7dsQmjxOIn9WqIr4p
         c0HvSOkfehSM7EuawJi5r2bhCmykcqJaRo0rparG3bLOv460j64VdiYNxq1DeML3QTor
         SFoQ==
X-Gm-Message-State: AAQBX9ee7wysi4ew2WMjywSHZhz2pEw50uZYjJHJIXOKhtBPi8v3vxpQ
        vyH4Gzsf9+WhJoYN1L5zJ2/lsKaTDQ==
X-Google-Smtp-Source: AKy350axRRgJ8DEbrFcZH3TtLMDOicgHXPxT8oAB2FLTh2FyyZOAa3fvynTBvFVAFF4UVv5lKxmoKA==
X-Received: by 2002:aca:211a:0:b0:38c:319b:57fc with SMTP id 26-20020aca211a000000b0038c319b57fcmr1544404oiz.18.1681851177854;
        Tue, 18 Apr 2023 13:52:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s2-20020a05687087c200b001802d3e181fsm6056418oam.14.2023.04.18.13.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:52:57 -0700 (PDT)
Received: (nullmailer pid 2321269 invoked by uid 1000);
        Tue, 18 Apr 2023 20:52:56 -0000
Date:   Tue, 18 Apr 2023 15:52:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,parkmode-disable-hs-quirk' quirk
Message-ID: <168185117592.2321215.4923836603705304820.robh@kernel.org>
References: <20230413100914.7890-1-stanley_chang@realtek.com>
 <20230413100914.7890-2-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413100914.7890-2-stanley_chang@realtek.com>
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


On Thu, 13 Apr 2023 18:09:14 +0800, Stanley Chang wrote:
> Add a new 'snps,parkmode-disable-hs-quirk' DT quirk to dwc3 core for
> disable the high-speed parkmode.
> 
> For some USB wifi devices, if enable this feature it will reduce the
> performance. Therefore, add an option for disabling HS park mode by
> device-tree.
> 
> In Synopsys's dwc3 data book:
> In a few high speed devices when an IN request is sent within 900ns of the
> ACK of the previous packet, these devices send a NAK. When connected to
> these devices, if required, the software can disable the park mode if you
> see performance drop in your system. When park mode is disabled,
> pipelining of multiple packet is disabled and instead one packet at a time
> is requested by the scheduler. This allows up to 12 NAKs in a micro-frame
> and improves performance of these slow devices.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v2 to v3 change:
> 1. Add the comment message.
> 2. cc the right maintainers.
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

