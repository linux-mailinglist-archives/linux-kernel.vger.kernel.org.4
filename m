Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805EA616918
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiKBQdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiKBQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:31:29 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290EB63F4;
        Wed,  2 Nov 2022 09:28:31 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13be3ef361dso20825692fac.12;
        Wed, 02 Nov 2022 09:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTe+HQSu9deCxWQ59JI/Vp6yzl4/LtPepki+Jr2M0Ps=;
        b=irSgjFDwS2muxQvTCOHkuOYimCJWOpxB2hRTgR3VGC6EpXnUXVhikO+SMKeD+Uamqk
         SZEERf7JXi6J+eekd/b9df1ooLn0ouQOtHFte61Tqy4WQJioAUzhdoImPJUsd5l07keK
         2Hzq3vYXRPobpKxoEmI7+TFH/ruiPy7FCCf6GuiQt+oRZlqbYcXuJcC7MLLCtsNdho9r
         7fy9HuIcn2E1y1lBkoIab4Wl6/T4YBt1jTOJ1aZ3edX65Rxhmf4g88eHNVOqIzNfK5gU
         zkYJIoGJz3SPa/ZIfvoLHH0ukiefbvz6xRbU5xOWHiERAHAIhdZ1HG0+Ud1B1Q1obi4c
         FC2g==
X-Gm-Message-State: ACrzQf3dZTtAJaImZnB+hWHHnsdpUbu/BfcECKjoL3FW610ozH4L7dDZ
        2YXFFRS39Rx1+pgZ2o871g==
X-Google-Smtp-Source: AMsMyM6dNpdREPCQD3KLvSS+PrujFBggZUwKZCLgUCyFiYUrExalqAUicEQkcwCKpvQKvlYi5TkaYQ==
X-Received: by 2002:a05:6870:82a8:b0:13c:673e:322a with SMTP id q40-20020a05687082a800b0013c673e322amr14742521oae.249.1667406510368;
        Wed, 02 Nov 2022 09:28:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a9-20020a056808098900b003549dde122fsm4707789oic.5.2022.11.02.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:28:29 -0700 (PDT)
Received: (nullmailer pid 4002721 invoked by uid 1000);
        Wed, 02 Nov 2022 16:28:31 -0000
Date:   Wed, 2 Nov 2022 11:28:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>, afd@ti.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH 2/3] bindings: pm8941-misc: rename misc node name
Message-ID: <166740651054.4002659.8535015951745121621.robh@kernel.org>
References: <20221031175717.942237-1-luca@z3ntu.xyz>
 <20221031175717.942237-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031175717.942237-2-luca@z3ntu.xyz>
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


On Mon, 31 Oct 2022 18:57:15 +0100, Luca Weiss wrote:
> The spmi-pmic bindings is now using usb-detect@ for this node, so adjust
> the example to match.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
