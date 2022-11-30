Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F5163CC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiK3AIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiK3AI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:08:29 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E22C1B9C5;
        Tue, 29 Nov 2022 16:08:28 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-12c8312131fso19167121fac.4;
        Tue, 29 Nov 2022 16:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGfJ7Toh6jQkrsNnaaKUduCGwv/HpQ7JNgqq7fZFKTE=;
        b=YbjToL2KmnH68b2JvM6oRuj7bCOxhuY9/znTcJN1Bf9pncdQbg9RAVTrGOYd41LMl2
         c+NcYXvjZktEf2behxuBX3j4K4DHXcZm1CuVu4xN93iB2xpDed5JsPBne86rw+rXQ+T9
         wo/64dsNJDLqbbidlbHqtdWhQ682KV5XkCiM/zSfY9u5mQ5pJRoQ7nOW6ffGPGD7Ntm3
         iKkyxYeFc0WzL8+yObM7WbwnN/WFZbb75PwqU/y1uFI7qM8RLO490vvgMdXdUye0YS+C
         BBcylfXcDvLESN/vAmBxCjgNrh8uBwiAFPSVQtjaAtHyJrvjb5Ec0zuyL1rmOCRnYLZJ
         LT9A==
X-Gm-Message-State: ANoB5pnUI9hZU7lRdH0anaSf9jGy8RSovLJbdCSVMRBPSJz2TFo0kJ9X
        hLleTDck0JWmGbqe04WjWP4d7NFQVA==
X-Google-Smtp-Source: AA0mqf6hfM+mKoQSH1zv0mFlC74mN+8YTtsD67PrauceBqul3vBBjEef7hQGLnE0QehHtlJTIRA0Tw==
X-Received: by 2002:a05:6870:d90c:b0:13b:c4f5:6900 with SMTP id gq12-20020a056870d90c00b0013bc4f56900mr23363081oab.93.1669766907656;
        Tue, 29 Nov 2022 16:08:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k2-20020a056870148200b00132741e966asm73146oab.51.2022.11.29.16.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 16:08:27 -0800 (PST)
Received: (nullmailer pid 554386 invoked by uid 1000);
        Wed, 30 Nov 2022 00:08:26 -0000
Date:   Tue, 29 Nov 2022 18:08:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v11 1/2] dt-bindings: mfd: Add MAX5970 and MAX5978
Message-ID: <166976687726.552364.17379342841980861555.robh@kernel.org>
References: <20221124110210.3905092-1-Naresh.Solanki@9elements.com>
 <20221124110210.3905092-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124110210.3905092-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 12:02:08 +0100, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Co-developed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../bindings/mfd/maxim,max5970.yaml           | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


