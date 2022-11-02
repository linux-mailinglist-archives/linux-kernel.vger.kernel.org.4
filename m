Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9816B616938
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiKBQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKBQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:36:07 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874202F3BE;
        Wed,  2 Nov 2022 09:31:36 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so2550765oop.3;
        Wed, 02 Nov 2022 09:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faR5Ztwq3XFpKQyisNeFrXxkqxow/m4BgrGmpTl9rjQ=;
        b=CRhdsTJiTO11MHM0KbR39bzyth9qLRf35cUYfrl4NmqK52grxm5MZe7TrjlYSbD43b
         M988dK/KiQ1VgDx3jokH137jgVKAkAoqcgP0iv64XCRvBs1GYG+1LvR7spsJG83vNxQZ
         zBqUveUuvny+vnjuDsJ0dmP7UW4VRdb3R33fm0SLFlAeRRaDagBFqbV8HNp78rD+ADDj
         WOG5RfJI6rqTVcVx2UgicLAs1rjI7gLFDInj7zWLRls6wEAxKhZ22WNumdMm9BPqBDFs
         MNpZeJJbojhvJQOC+joRWdnSqVuajgbR0SpL15iKc6BeOfPWVZC0Myjrmhci/KcIBFxF
         +Pnw==
X-Gm-Message-State: ACrzQf0Qj6noYHKwAAiDcCoHpbw1JyczcyXwHyDmGYiYYStkMKdoM30f
        fUsdT0bFPG10YYx7x0Bh4OjFI2ftDw==
X-Google-Smtp-Source: AMsMyM6sU6vRmjlJy7p77oVUMKlljg5rXCkPBPOhutAikk5bqOtDyzcej7jdS7MAf/BVtcFIhPwVfw==
X-Received: by 2002:a05:6820:54c:b0:49b:5e1e:5226 with SMTP id n12-20020a056820054c00b0049b5e1e5226mr7710669ooj.17.1667406695563;
        Wed, 02 Nov 2022 09:31:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e21-20020a4ad255000000b0049ded99501bsm123104oos.40.2022.11.02.09.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:31:35 -0700 (PDT)
Received: (nullmailer pid 4006134 invoked by uid 1000);
        Wed, 02 Nov 2022 16:31:36 -0000
Date:   Wed, 2 Nov 2022 11:31:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio/adc: qcom,spmi-iadc: use double
 compatibles
Message-ID: <20221102163136.GA4004075-robh@kernel.org>
References: <20221031182456.952648-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031182456.952648-1-luca@z3ntu.xyz>
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

On Mon, Oct 31, 2022 at 07:24:54PM +0100, Luca Weiss wrote:
> As in other bindings, let's use specific compatibles together with the
> fallback compatible. Adjust the bindings for it.

You should state users are already doing this.

> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v2:
> * New patch
> 
>  .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml        | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
