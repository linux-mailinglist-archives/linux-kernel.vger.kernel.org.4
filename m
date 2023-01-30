Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A3E681E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjA3Wvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjA3Wva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:51:30 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB32725E24;
        Mon, 30 Jan 2023 14:51:29 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1631b928691so17138773fac.11;
        Mon, 30 Jan 2023 14:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HCHA9qe6DAIVNH0ERIjRJyJaTxLrcEySDYqQJSUgcI=;
        b=bzOfBVwtgsK4tUdjvAAJWN9Sqa045jIf12RtURlXuiqdoBVqAdjyOr4laxY/wB91E5
         2xMMEc1XmRyspM9MvM9icJw8WoRUZIiMSyX3oFxULOu3xWCEcBjpuFHhveh0iJeBOlM1
         xjvmqbLh1uNdiOdsM2wKKHE6ZUpGnuKkVa2dZI3+F59I4u2AjrkzBoGKu/89RYCPZXA0
         xYzypXMEcPtFDBpDmMlyQY19G3H1LrF/9dVveHyUcZUsgV13rxiHHFLFFMp6wMJKCp7E
         KQPbyYmr/xoZkIKFDHG0/BA6YOpN8osr1jjpcw21c5o8Qusdz5+JsDD8xOWLDyPTFyle
         W8yA==
X-Gm-Message-State: AO0yUKWvRoCizBEbozuAsySoJ9C9WTTVbjTO59xd68x+5I0zPGCIiKmE
        7rJbTOg8Er7qMFyg2e1gb7oabzE/iQ==
X-Google-Smtp-Source: AK7set8bEuRWecXac1zUHFjkMVxeNgQB/z8mM3Qhn9NRoUbFWevftGbavBFAsSK1GXafYn5g2qgC2A==
X-Received: by 2002:a05:6870:392b:b0:163:36d5:35bd with SMTP id b43-20020a056870392b00b0016336d535bdmr11831704oap.18.1675119089175;
        Mon, 30 Jan 2023 14:51:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id kz12-20020a056871408c00b0013b911d5960sm5769899oab.49.2023.01.30.14.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:51:28 -0800 (PST)
Received: (nullmailer pid 3671600 invoked by uid 1000);
        Mon, 30 Jan 2023 22:51:28 -0000
Date:   Mon, 30 Jan 2023 16:51:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        andersson@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org,
        marijn.suijten@somainline.org
Subject: Re: [PATCH] dt-bindings: usb: fsa4480: Use generic node name
Message-ID: <167511908747.3671540.7351021628735761280.robh@kernel.org>
References: <20230130113151.2130063-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130113151.2130063-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2023 12:31:50 +0100, Konrad Dybcio wrote:
> Node names should be generic. Change fsa4480@ to typec-mux@.
> 
> Fixes: 01afa882f12d ("dt-bindings: usb: Add binding for fcs,fsa4480")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
