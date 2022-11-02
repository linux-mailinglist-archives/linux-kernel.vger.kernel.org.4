Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D56168EA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKBQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiKBQaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:13 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117A6286CB;
        Wed,  2 Nov 2022 09:26:33 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id s206so19743128oie.3;
        Wed, 02 Nov 2022 09:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIR+AoKte/Rbp/gRokLAMVnpl7+lVKm8vL229c31Jzg=;
        b=xZ7k+xc+ADIdzgDmKYgWuoJNnHopuH3b7SZfHdflcMjcw76SrRwWwNUWRxePgpOV1j
         KNv4ehEoUAYEXhbdlx4xak/CxXlhhzhQW7WPUz1SLO+ooDXu2/ufrvtcxQPMqjaOVtdz
         PER5EjPDpDkUawiP6HwnowVvvPojRzQXjDitojvRQ2gbDDXzIwXUCfPMqLpInWBB6j1Z
         HCVyTHXK2ulmq5VUFB3jyf3zR2duyN+uGux/fKbLevxd/hB2lJ7KuxR64BOzIArpuHZY
         6CyjYnqmq7d7aHzFhwebWu6uhOCazXTP9LZC3Plh943ek5nGe2TG8cI64P63FtLRGiHE
         Bp0Q==
X-Gm-Message-State: ACrzQf0yZ0NL+4C6qehQwGRJzzcp1VdKaINMMzD+eZEduh4gPEtrYCDt
        Yu85UrGnVJIbmRaTjZx3Kg==
X-Google-Smtp-Source: AMsMyM4M2t4ITPG9ff4UEKZwkJmzFS9pjESqaNmXMoiTarkbHnxF6fwaZy6kgAncbKRzlyQ1wJjLZQ==
X-Received: by 2002:aca:1301:0:b0:35a:1a7f:f955 with SMTP id e1-20020aca1301000000b0035a1a7ff955mr7965929oii.283.1667406392326;
        Wed, 02 Nov 2022 09:26:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u8-20020a9d4d88000000b006618586b850sm5310082otk.46.2022.11.02.09.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:26:31 -0700 (PDT)
Received: (nullmailer pid 4000253 invoked by uid 1000);
        Wed, 02 Nov 2022 16:26:33 -0000
Date:   Wed, 2 Nov 2022 11:26:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     afd@ti.com, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: qcom,spmi-pmic: support more
 types
Message-ID: <166740639308.4000199.15920506245442600325.robh@kernel.org>
References: <20221031173933.936147-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031173933.936147-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Oct 2022 18:39:31 +0100, Luca Weiss wrote:
> * 'adc@' is either spmi-iadc or spmi-vadc
> * 'charger@' is either pm8941-charger or pm8941-coincell
> * 'usb-vbus-regulator@' is usb-vbus-regulator
> * 'vibrator@' is now in yaml format, so add it
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes since v1:
> * Change dcdc@ to usb-vbus-regulator@
> * Link to pm8xxx-vib.yaml
> 
>  .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml  | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
