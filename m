Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A336B14C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCHWIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCHWIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:08:20 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0222539CFC;
        Wed,  8 Mar 2023 14:08:19 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-176eae36feaso318935fac.6;
        Wed, 08 Mar 2023 14:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEry6ytAZhl0tOKdRhcBysU8A9zZyr8Ag2HKP0YMd7o=;
        b=2nxYD4q6npZ+1rb0lpc78cSVcnC47RYjd7ybB87ExYyaEEMink+qeIitdDe9hW6jOi
         cZprQs2CvtMZJvkGllHcz5mk4V05ZC2CzlTtDO2xt4hWo8oEQcHJ5K26gPsrSaz1sC3l
         gV099JgU9pi/SJPJspOHDRlpzBwK2Pf5ZqEL8QQQplGSoOnlE3CcdBkgglFmLn0bexF8
         lTNJlG6A2vWrHaD99v/moQeyFf1ro9QynhzZu3d1Q0c5Dayxw42W+dPvt6S87qXEQep3
         bKbIpSxYq5ldAYRZud+RQH+9deIA4/jbp/Re+Jh7vVfAgsO87NgrmtwfOuovPcpwak6E
         ReHQ==
X-Gm-Message-State: AO0yUKU4siISzpHgHF1OWRp6diVXLbF5ZTYtf6AriKY76MOTLrg6UeaO
        z/W4BVe9E6mgjbTAjBF8wA==
X-Google-Smtp-Source: AK7set8epuP2RlANSYFbZz59gbdFJrBwJ+lSGxVM6dmJyDaV13kdgQHHvC3FeH0GJMc6g5YhQqS5UA==
X-Received: by 2002:a05:6870:593:b0:172:5de5:785 with SMTP id m19-20020a056870059300b001725de50785mr11533655oap.6.1678313298271;
        Wed, 08 Mar 2023 14:08:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zj40-20020a0568716ca800b001723a2e84b6sm4572405oab.6.2023.03.08.14.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:08:17 -0800 (PST)
Received: (nullmailer pid 3932824 invoked by uid 1000);
        Wed, 08 Mar 2023 22:08:17 -0000
Date:   Wed, 8 Mar 2023 16:08:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: snps,dwc3: document extcon property
Message-ID: <167831329670.3932766.1517794698913796551.robh@kernel.org>
References: <20230304130302.51497-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304130302.51497-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 04 Mar 2023 14:03:02 +0100, Krzysztof Kozlowski wrote:
> The DWC3 USB Linux driver and several DTS use extcon property, so
> document it, even though it is deprecated, to fix warnings like:
> 
>   sm6125-sony-xperia-seine-pdx201.dtb: usb@4ef8800: usb@4e00000: Unevaluated properties are not allowed ('extcon' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

