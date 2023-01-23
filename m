Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C866467897F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjAWVYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjAWVYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:24:45 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CB32CC46;
        Mon, 23 Jan 2023 13:24:45 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id u13-20020a4aa34d000000b004f5219f9424so2340542ool.5;
        Mon, 23 Jan 2023 13:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTo2Civtr2QVO0QmMkiTtI8Hm6awAgGtXfiZQj9J25s=;
        b=CtvCWlyfJtWoUpczPL4xb8fs4/huzn4sBt7BjneQNOMEtxFYHaGtWs+J5kMGnVzq6m
         NuDPGxXk6BGtv7JBNFBBOsFdr8+ZiEZKrxPq7bLyqZQLJVP4qKHyjGjZiXeAP+ucT2Qj
         nWK9PuLHfC1tnSBM84Xubw/v9Iu4Dw064n8nyPj/GjPGMqiqCBQNIhw09hcwTm3JsAp1
         qMQPNAOzh5ydXMCLMp20qtowkXVzMWd6AqSeRhx2U/5S88TiZlcs5clgWMjtqkpU0zL4
         WRmv8bAQUsvEaUak/2AOPPaOVy1YUVuKzBSwUMnkowO8SAamVUgTYxqG/j0eZGocUlKg
         i11A==
X-Gm-Message-State: AFqh2krxxDU4xtHVTnyxUqCw3TyuHYloyyNyduszK/6R+fAigvO6Ds4F
        EbPUpGGStZbAY5VHGRa2GF2+Vx/eVg==
X-Google-Smtp-Source: AMrXdXuHRIk0mMrTrsgiK6iNy2iVP9v18/ze4mZc7AKHf+DC7Y4n3bKqAp8xpCojK85E/IrNOrm2Gg==
X-Received: by 2002:a4a:8c6e:0:b0:4fa:325e:ebb0 with SMTP id v43-20020a4a8c6e000000b004fa325eebb0mr10844594ooj.5.1674509084541;
        Mon, 23 Jan 2023 13:24:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x1-20020a4aaa01000000b00499527def25sm38231oom.47.2023.01.23.13.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:24:44 -0800 (PST)
Received: (nullmailer pid 2666082 invoked by uid 1000);
        Mon, 23 Jan 2023 21:24:43 -0000
Date:   Mon, 23 Jan 2023 15:24:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: soc: socionext,uniphier-soc-glue: Make
 child node names fixed names
Message-ID: <167450908027.2665958.2479758029072350668.robh@kernel.org>
References: <20230120020339.3223112-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120020339.3223112-1-robh@kernel.org>
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


On Thu, 19 Jan 2023 20:03:39 -0600, Rob Herring wrote:
> The child nodes 'pinctrl', 'usb-hub', and 'clock-controller' in the
> socionext,uniphier-soc-glue binding are not patterns, but the full node
> name, so move them to 'properties'. As patterns, they were missing start
> and end anchors so any prefix or suffix was allowed.
> 
> Fixes: 0611adff8b3a ("dt-bindings: soc: socionext: Add UniPhier SoC-glue logic")
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/soc/socionext/socionext,uniphier-soc-glue.yaml      | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!
