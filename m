Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1BE5F352F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJCSCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJCSCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:02:04 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13BD3687A;
        Mon,  3 Oct 2022 11:02:00 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so7244667oom.1;
        Mon, 03 Oct 2022 11:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=IWs7Hry/AxIB02qMH6dCMBOwHjYkvCUVeeJUO6Fpnho=;
        b=UJVJAP7G0VJpjGjZAPFvE86cHMP8TXJJvXu7bEU6LDqc3j0nldo+enzf2BpYFNyc7Q
         K52sLPTxug0LDsFqwVRkceU5qm8itmbsb1210jurmnGmyJ/9JYtXgAnV0+5cjm5dPjDD
         ZJsuJbDxrl4yRwvGzsKCo5pp/oqCYVCl6v76fDHMvJEYA3o8E402f43bNi4q6rpmpU/g
         n0qnpWSuT4BNp+WBQJjkIIMbMdYOxJFM/JSXuEMVfDxvEDetbUQB4wA9MSEoj3du8Z08
         OtzzUrmqtMMtMzEu9or2rsdEG8FuiYWzKFDqyu06YOxFBtK+EPCHPRa1DujWb1niWevQ
         XaGw==
X-Gm-Message-State: ACrzQf3UkOkhVhOIhqHtakYHQR9qERMgcOQGLsZr/8+edIGw0VjVTHa+
        i1e5YbEHnEiP7XzLKTIFIA==
X-Google-Smtp-Source: AMsMyM7oNKwlv1vNO9RTSTxR+Spnt+NymWqlxMPqPXsLqLcH88c7l0F1FkSaj/FixBlXs53+oCVpUw==
X-Received: by 2002:a05:6830:120c:b0:659:bcc3:d9aa with SMTP id r12-20020a056830120c00b00659bcc3d9aamr8253289otp.100.1664820118983;
        Mon, 03 Oct 2022 11:01:58 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z187-20020aca33c4000000b00342d207e68bsm2576280oiz.37.2022.10.03.11.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:01:58 -0700 (PDT)
Received: (nullmailer pid 2515871 invoked by uid 1000);
        Mon, 03 Oct 2022 18:01:57 -0000
Date:   Mon, 3 Oct 2022 13:01:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     allen_chiang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sre@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, cy_huang@richtek.com
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: Add Richtek RT9759 smart
 cap divider charger
Message-ID: <166482011693.2515822.16928918344784317898.robh@kernel.org>
References: <1664790493-16386-1-git-send-email-u0084500@gmail.com>
 <1664790493-16386-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1664790493-16386-2-git-send-email-u0084500@gmail.com>
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

On Mon, 03 Oct 2022 17:48:11 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add bindings for the Richtek RT9759 smart cap divider charger.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/power/supply/richtek,rt9759.yaml      | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
