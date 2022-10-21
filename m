Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B30B60807B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJUVBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJUVB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:01:29 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048122A3886;
        Fri, 21 Oct 2022 14:01:28 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id r8-20020a056830120800b00661a0a236efso2552911otp.4;
        Fri, 21 Oct 2022 14:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThaXu9P48Sql8fmtxkFGUS2TC8a/h9n1gPZWoGU9Vk4=;
        b=f9Z0k2WP5OsTrl8+VPoRrbc2VIiAvD93n6pXoigVpmei+cREhhSY5A34vkeXaLMEy1
         vYa8+P/9E0BypYPWydVh/4R1kjPCoI0WPY9GphKs8idujRNSs4STiEXcZmhROI3qVA2g
         1vu+eg49wUcXpzVAJSAL33rcH9etUxgasIBwdHC2BemX0lcYc7URZehmCOPKOyh2RK5D
         InIcD/DO4ZOhr4D4tfVAGP2nLhDZzXSnH1I0l+/KDF3GNzdfS5ION0nn9gri21fEPOG0
         yid5tkoCgjGU6uxxvOMftrjCfrqQznj6vxg6Wb5X9DrRXF4n8m3QCryZkR3c+7idEvWL
         XgXA==
X-Gm-Message-State: ACrzQf3iEc0/m7Rvk+KZlsBPD7ZiO6sOLw1KGE8vzCy7H8j6Ve7nF6ku
        j826vhUSNVdB+wRcP3XmLQ==
X-Google-Smtp-Source: AMsMyM5puNgQMe2ztfKZzxbkWEK9GvXVMrSURtKbZWZml7mWzUAxQhNgsqP6pxlCok4W5YhkXYnFqg==
X-Received: by 2002:a05:6830:2a0d:b0:656:bd3f:253f with SMTP id y13-20020a0568302a0d00b00656bd3f253fmr10826597otu.25.1666386087242;
        Fri, 21 Oct 2022 14:01:27 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b8-20020a056870d1c800b0013af0b2e917sm2538708oac.35.2022.10.21.14.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:01:26 -0700 (PDT)
Received: (nullmailer pid 316272 invoked by uid 1000);
        Fri, 21 Oct 2022 21:01:28 -0000
Date:   Fri, 21 Oct 2022 16:01:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Alexander Shiyan <shc_work@mail.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: ata: Add 'ata-generic' binding
Message-ID: <166638606840.315869.4368217201724215214.robh@kernel.org>
References: <20221011135849.2785834-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011135849.2785834-1-robh@kernel.org>
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

On Tue, 11 Oct 2022 08:58:50 -0500, Rob Herring wrote:
> The 'ata-generic' binding has been around since 2008, but never
> documented.
> 
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> AFAICT, the ata-generic,use16bit property has no effect in Linux. The
> 32-bit transfers fallback to 16-bit if ATA_PFLAG_PIO32 flag is not set
> which it doesn't appear to ever be set. Looking at the history, the
> driver always used 16-bit mode.
> 
> Linus, Okay with being maintainer here?
> 
> ---
>  .../devicetree/bindings/ata/ata-generic.yaml  | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ata-generic.yaml
> 

Applied, thanks!
