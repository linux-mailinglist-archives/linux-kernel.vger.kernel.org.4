Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ABC681F55
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjA3XFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjA3XEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:04:39 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669D3305C5;
        Mon, 30 Jan 2023 15:03:49 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-15ff0a1f735so17207712fac.5;
        Mon, 30 Jan 2023 15:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5awBKQMRNIFlgOmsN558nb1g7BhxxR7/Ebn83/FlLOc=;
        b=XvdCIKlMvQd1b1QkIDS/FpHqlGvy5TkDwaReUh+vvU6b7LPJFk6jvVzIHSHXsL2SDi
         psDQX2hKgyrgCajaZM+uap+vnd779FQfFFs7oOeLaztlGfdbtCsSMaJFPpAFnTCCA9iq
         ik8z+/AEbr70Wko7MnPoe2lfkHyrHF6CCiXByaFDIfBrcDw9/72thlsc3l9TJE+SJsKa
         WJJMDBlFPNPhkvAwAt0+zWjS6kAvSFMPH/F59TRchzEPLiXjkZI0fZl2aqnE4X8XQyd9
         tTMnMqL3xywIPHJsVwycqEg5nQDqgIwYZ/+r5iMadnGKQv+FKEv9OShCi0axp3NQGagb
         xmfQ==
X-Gm-Message-State: AO0yUKVF4ejLX7IEAlBriUbVBlHCQmsmVNAyucPXsfjhgeOAj3tkVrRG
        sKAVzuMtTnwzyKR0DzTpfOtXCT9gkQ==
X-Google-Smtp-Source: AK7set9rnMG/hp07uhPP7aEpFqQ+zZ5ZYq9icSenZMrkxRhfolUcWQhGaYJtc/Mr/EoBxwu+TbEPVw==
X-Received: by 2002:a05:6870:5b95:b0:15f:2c6a:1ef9 with SMTP id em21-20020a0568705b9500b0015f2c6a1ef9mr5391163oab.53.1675119746804;
        Mon, 30 Jan 2023 15:02:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bd2-20020a056870d78200b001639b1f2f96sm2877847oab.50.2023.01.30.15.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:02:26 -0800 (PST)
Received: (nullmailer pid 3687161 invoked by uid 1000);
        Mon, 30 Jan 2023 23:02:25 -0000
Date:   Mon, 30 Jan 2023 17:02:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH -next] dt-bindings: clock: qcom,sa8775p-gcc: add the
 power-domains property
Message-ID: <167511974526.3687122.8740972401480652619.robh@kernel.org>
References: <20230130145154.195562-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130145154.195562-1-brgl@bgdev.pl>
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


On Mon, 30 Jan 2023 15:51:54 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The binding document is missing the power-domains property. Add it and
> update the example.
> 
> Fixes: 0fff9fa043f9 ("dt-bindings: clock: Add Qualcomm SA8775P GCC")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../devicetree/bindings/clock/qcom,sa8775p-gcc.yaml          | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
