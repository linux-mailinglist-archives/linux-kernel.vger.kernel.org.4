Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7076EB152
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjDUSBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjDUSBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:01:33 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7597D172C;
        Fri, 21 Apr 2023 11:01:32 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-18665c1776dso1760581fac.2;
        Fri, 21 Apr 2023 11:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682100092; x=1684692092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnmTMZtvA/f6TPhezgaB/eM/0Kt2Nz3CF0RXPywChaE=;
        b=Vghxhr6U7Cb/tTXVnZLqZWNTURAJoIClkTSV/9F25DsHwk3vjI2BHC8dkhekZ9u3bo
         6YOCkFoSUOEfsYm2UKq2F83MxvR7FhNTSJRw1saHHO/EMGtoBNLwST1AIeAe1Xj+M3tb
         ziu+WDnbiIy4VcqZEoEKMAAT/CfkGYgujs1a68TOZWnVm/Eo4xfs8mEcFoq5Sqlcq2C3
         cIPLJB1AT+61IT7nZJHLLmRnH86JNG7kt2Niaj2O6iTHBUnjEdly255+3AOmcyYAW3vp
         Xbt1p4y69HNGz+TuNap/TNgbDrh/WweeKAdgelceIGLmebZM6qD7Mi48yW024Xquig5e
         r19g==
X-Gm-Message-State: AAQBX9flw9JUKbI7tVnz8JmEcn21RTj9d0bLMwbMp1GsdytdMyjywH9q
        5r09ppfnggMB6grnbp7Qkg==
X-Google-Smtp-Source: AKy350bS6Yt9+puose4G3XnzK+iG2RBGcT82lno6wn46NVV3zf3nyr8BIptdf9X2gnZJqGbUtRaqFw==
X-Received: by 2002:a05:6871:84:b0:17f:e13:9c96 with SMTP id u4-20020a056871008400b0017f0e139c96mr4884396oaa.51.1682100091343;
        Fri, 21 Apr 2023 11:01:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c3-20020a056870b28300b0018b22156e84sm1790729oao.38.2023.04.21.11.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 11:01:30 -0700 (PDT)
Received: (nullmailer pid 1552920 invoked by uid 1000);
        Fri, 21 Apr 2023 18:01:29 -0000
Date:   Fri, 21 Apr 2023 13:01:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     linux-usb@vger.kernel.org, hanjie.lin@amlogic.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        yue.wang@amlogic.com, rockosov@gmail.com, robh+dt@kernel.org,
        hminas@synopsys.com, martin.blumenstingl@googlemail.com,
        mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org,
        jbrunet@baylibre.com, neil.armstrong@linaro.org,
        linux-phy@lists.infradead.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        kishon@kernel.org, Thinh.Nguyen@synopsys.com,
        kernel@sberdevices.ru, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: usb: dwc2: add support for Amlogic
 A1 SoC USB peripheral
Message-ID: <168210008936.1552867.8929832255980698687.robh@kernel.org>
References: <20230418111612.19479-1-ddrokosov@sberdevices.ru>
 <20230418111612.19479-4-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418111612.19479-4-ddrokosov@sberdevices.ru>
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


On Tue, 18 Apr 2023 14:16:10 +0300, Dmitry Rokosov wrote:
> Provide the appropriate compatible string for the DWC2 IP that is found
> inside the Amlogic A1 SoC and used in peripheral mode.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

