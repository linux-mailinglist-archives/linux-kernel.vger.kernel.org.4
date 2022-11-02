Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F028E616910
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKBQcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiKBQag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:36 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86452ED41;
        Wed,  2 Nov 2022 09:27:15 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id b124so7223170oia.4;
        Wed, 02 Nov 2022 09:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXpDP9vJLS73MUc6mzDjq8nznR0mK7nWsGmmlM0667A=;
        b=NsmeFFpNrL0q8460tfcVFiGwzdBXUbEkfpZqMYxAyNGbB+Rh0AZ8pGFtTZSRRLHk7v
         1wXgOfrtv86d1knniqnQQdxUyiJgLT+bhMpeskkjNpfmjHVDdw2LRbrVGQz9+blQMW6h
         2RMMGqlJj+RoSSqLjFWYTzpev68XkD4rHpCTC5RUVpIhI/C2sJwSjJ90k8/tB4ENL2cX
         BTEyXZoplF5UdSKqvNp4259dPIQX8F/WeG8qCHbI7XtNdt13pgttMeZ3Ahl7Yg+apkQu
         PItrFqzdgHF+KUA/zySvzjno50cjTOliPKBgsCrMN2HNHQKb2grs2bqEHQVTBylm85nA
         3aQg==
X-Gm-Message-State: ACrzQf2ZvjCLXn3OHRq3PuE5d6wWGovBTfsbLfXSZD7+Bbv177bzd3zp
        T3gZYh5kjkYBpdIlPPi3Ew==
X-Google-Smtp-Source: AMsMyM5X25puaVDWNvMGiiMDSg3X5c1iox56uXxIVuzXaWK2y77k38lP3R+EEHtmqvFUP8/nNgVi6g==
X-Received: by 2002:a05:6808:124f:b0:353:6dbc:29c7 with SMTP id o15-20020a056808124f00b003536dbc29c7mr22808542oiv.115.1667406435020;
        Wed, 02 Nov 2022 09:27:15 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d7-20020a056870960700b00130e66a7644sm6192485oaq.25.2022.11.02.09.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:27:14 -0700 (PDT)
Received: (nullmailer pid 4001146 invoked by uid 1000);
        Wed, 02 Nov 2022 16:27:16 -0000
Date:   Wed, 2 Nov 2022 11:27:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, afd@ti.com,
        ~postmarketos/upstreaming@lists.sr.ht,
        Mark Brown <broonie@kernel.org>, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [PATCH v2 2/3] regulator: dt-bindings: qcom,usb-vbus-regulator:
 change node name
Message-ID: <166740643573.4001087.10656985950751088329.robh@kernel.org>
References: <20221031173933.936147-1-luca@z3ntu.xyz>
 <20221031173933.936147-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031173933.936147-2-luca@z3ntu.xyz>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Oct 2022 18:39:32 +0100, Luca Weiss wrote:
> usb-vbus-regulator is a better generic node name than dcdc to change the
> example to match.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v2:
> * New patch
> 
>  .../devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
