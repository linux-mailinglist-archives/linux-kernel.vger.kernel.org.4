Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067AD6819D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbjA3TEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3TEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:04:23 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF333865D;
        Mon, 30 Jan 2023 11:04:20 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-142b72a728fso16328719fac.9;
        Mon, 30 Jan 2023 11:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KJ9Rz1Ynh3fjcAdkx5iP/6JNhfuUpXfGWr8jMXGpK8=;
        b=DfFQEal8N3PGF1mRijjLtabH4AolzTqXVelRSeOgDbNMIOjj37h+wjT30VnvGhRfoV
         i+rHqIk7GuBOQQdM4146l7COV0WOys+Vih20hhJ/a/TM0ZNd7SmzGMNZXgN9attYPVqv
         rl5YiR27TQkP1H5K4MxXg/CT6tWB6ZAVO34NH/QT/945umkahsy/XFuLi1YlPhl10ndu
         cOrDWbirqh5jKoANg8uWEH75FlyxfRcBoojmcf3brcfRXGalBURg3V2zrEllQcug78YJ
         96pDfPWvihmD3J6LFD4inkx4X1LpwiaycNKLZ2GJwIEaFN9NVLerS3e48CktvKQWA0cQ
         R/jw==
X-Gm-Message-State: AFqh2krQNxmFOa4zoUXnrxBqiK7R566DHmpDAu3EwBcmAckvly6741VT
        ZEjp/+k/+eTZFZv7KdnQkA==
X-Google-Smtp-Source: AMrXdXtjE2UK5IbXgI+0HH5dQJ2HxAVZhp2l7U70Q5qV6hgbDhg9WyJ89Jl7Cr6tB34YfAkN15nwIw==
X-Received: by 2002:a05:6870:828a:b0:15f:dac1:7e7d with SMTP id q10-20020a056870828a00b0015fdac17e7dmr19809449oae.25.1675105459938;
        Mon, 30 Jan 2023 11:04:19 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id mv7-20020a0568706a8700b0015f4d1b195bsm5567310oab.36.2023.01.30.11.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:04:19 -0800 (PST)
Received: (nullmailer pid 3125626 invoked by uid 1000);
        Mon, 30 Jan 2023 19:04:18 -0000
Date:   Mon, 30 Jan 2023 13:04:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Eric Chanudet <echanude@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,sa8775p-rpmh: fix a typo
Message-ID: <167510545823.3125572.248582702391244849.robh@kernel.org>
References: <20230127092615.39690-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127092615.39690-1-brgl@bgdev.pl>
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


On Fri, 27 Jan 2023 10:26:15 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The name of the chip is sa8775p, not sa8875p.
> 
> Reported-by: Eric Chanudet <echanude@redhat.com>
> Link: https://lore.kernel.org/lkml/20230126203618.nbqwppaddncq7on7@echanude/
> Fixes: 2579af94c813 ("dt-bindings: interconnect: qcom: document the interconnects for sa8775p")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
