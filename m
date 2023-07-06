Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B42274A45A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjGFTW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGFTW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:22:26 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4861BD3;
        Thu,  6 Jul 2023 12:22:26 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3457157a164so3948525ab.1;
        Thu, 06 Jul 2023 12:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688671345; x=1691263345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1vhHxHDYnQQYlAo2yiSpaZvyCaq/6aSS1boX6Qwnys=;
        b=Q6/bSlyzmfAhRvaTafeHRhNs0B5FqmqUzAKPwCA135TLSems2u3Zjq9JOGXPpn+6Bq
         sqiXcXldDiGtlawrZ+LPJlBfXmS8sfbL0CgMvNWTFLY3/FDTKeDuRY4jtkLw+Q9lAVEB
         hBx4z49iEGywkcYnQch1D4wVxn8uoCBmYnmMQYpSQum82DKs2EGQzVzFGIR6drUTUUHU
         +IkmgrP+Qnd73vv5mHmQE6VIqX+cBNYlZNfX2/y+GHrArWRLXvRfzI9pAAvTrvzBZ4ml
         Qgha3/ifpTpsgBH+ecTKQd6nEygdCILfTepJXWpCAW/4hpVDktvN0/+RoXAHSilIfovc
         gDcA==
X-Gm-Message-State: ABy/qLZaiVsms9Gk3vgzGqW/WDEYayAH7ja6tdepl+V+XhTrHC9f7sYZ
        2qkMZSCXydHvMP4jm00rnA==
X-Google-Smtp-Source: APBJJlFWoym+oBQ2Q3VJdb2mYORaZVCrsen7ZoIQ1ReqH1GTrhFEq86fUM15IHFSUMYuwKf5lH1o8w==
X-Received: by 2002:a05:6602:274e:b0:783:58a3:ce2a with SMTP id b14-20020a056602274e00b0078358a3ce2amr3175614ioe.12.1688671345303;
        Thu, 06 Jul 2023 12:22:25 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f12-20020a056638118c00b0041f4ce6e9cdsm714157jas.65.2023.07.06.12.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:22:24 -0700 (PDT)
Received: (nullmailer pid 182715 invoked by uid 1000);
        Thu, 06 Jul 2023 19:22:23 -0000
Date:   Thu, 6 Jul 2023 13:22:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3 2/3] dt-bindings: clock: amlogic: convert
 amlogic,gxbb-aoclkc.txt to dt-schema
Message-ID: <168867134189.182630.15973523447108474911.robh@kernel.org>
References: <20230706-b4-amlogic-bindings-convert-take2-v3-0-f63de6f12dcc@linaro.org>
 <20230706-b4-amlogic-bindings-convert-take2-v3-2-f63de6f12dcc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706-b4-amlogic-bindings-convert-take2-v3-2-f63de6f12dcc@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 06 Jul 2023 16:52:33 +0200, Neil Armstrong wrote:
> Convert the Amlogic Always-On Clock Controller bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/clock/amlogic,gxbb-aoclkc.txt         | 64 ----------------
>  .../bindings/clock/amlogic,gxbb-aoclkc.yaml        | 85 ++++++++++++++++++++++
>  2 files changed, 85 insertions(+), 64 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

