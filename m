Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EB2613B65
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiJaQdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiJaQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:33:47 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADAAC5E;
        Mon, 31 Oct 2022 09:33:46 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id r83so13320940oih.2;
        Mon, 31 Oct 2022 09:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUuSSinBxYk25yBlqlund1H+FK4Fb3hJf7Ya5iqDDMc=;
        b=kA6keeWjdFMQWxZ9qZxP3AZEQHZqxRbrK7GEcAoFgNY/3j+futig6yidCcnqyGfuPH
         AyNe4YuiNNc/jqye8euUHYs2P4ezx0+TU14x2DB00ytaK0wfU7Gm5f8GN6OF2ZVE7kQY
         GN5I58cwhoE3UWOjdxMkiBWCxFn6S4X+eZA4Jg9lyhQhzuI8JnZpcOu6U5SuEyX+/Otf
         DX0jmqo+tPqY6hW+DgEhu//khaP65ZBscTl9nLzz1qlg4SLougIx/4O4kmSmOiZfJzrn
         b7ZcHgjfar+eaf9FbbpJo6gtMEiz+9fZYaV9i9Slbr/S+KS4NC9gJWBKBNm624VF3SCp
         TW1g==
X-Gm-Message-State: ACrzQf1pWSyPSJG8550IP6lgbVrm6Iww9WSleXIHvbBA3F4xMoBIfKi7
        QmS80VmbDnGJosa4OFV98cuYGT7qMQ==
X-Google-Smtp-Source: AMsMyM5/8K+GN/fs1Kccvk/6zgPyR4yCxqVWCn5+UdWeXXWSq/so8rA7OTOvQv9KNZYuB3XjHxhhdg==
X-Received: by 2002:a05:6808:1591:b0:359:e9f6:e349 with SMTP id t17-20020a056808159100b00359e9f6e349mr6078120oiw.267.1667234025737;
        Mon, 31 Oct 2022 09:33:45 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v21-20020a05683018d500b0066c55b99d14sm1065089ote.54.2022.10.31.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:33:45 -0700 (PDT)
Received: (nullmailer pid 2979076 invoked by uid 1000);
        Mon, 31 Oct 2022 16:33:47 -0000
Date:   Mon, 31 Oct 2022 11:33:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: qcom,spmi-vadc: simplify
 compatible enum
Message-ID: <166723402653.2979037.13977255259751466976.robh@kernel.org>
References: <20221027143411.277980-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027143411.277980-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Oct 2022 10:34:10 -0400, Krzysztof Kozlowski wrote:
> The second compatible item in oneOf is just an enum, not a list.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml  | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
