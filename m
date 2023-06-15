Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB58731EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbjFOR1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239284AbjFOR1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:27:17 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CAB2944;
        Thu, 15 Jun 2023 10:27:12 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-777b1b5ff50so358246139f.3;
        Thu, 15 Jun 2023 10:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850031; x=1689442031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKk+TgAjylPN5EUy5QdAn2mAooqy0Uaxj8L8e+7bg3c=;
        b=gEDeazn+RujxgGhGlT0FLfTX2u8vAd9/62Jhs8aJWKVdXeNa3thZA88YF08L000NSb
         EXcngv6c6L43eLQWBNrAfNjl+6eDUakveoZqAZa8lP/rIynrzO8GTx1XZiwmPAdVfdSh
         u0egpycjgppsk5FPz8SXh3qPo/TcRFg7CZkCc9kDACBqE70Ad0UGtKsxaQOmxA8vFPxx
         WGPNacYau8IRGixRan+pm7nos14rllRTaQkP755mAUoptp7of66aqHAM2javqBNmjL6A
         HIgbnmsoJTdQstMutJvg1hjFsRG5hZRCtDUA2S3dt0blEz6/67CHidOfdO9LCddgLNze
         /JIQ==
X-Gm-Message-State: AC+VfDx0M8AkOXSvD6PcZZ0aoMogWPgyX9Tn3h47wk5tChGo8ng3E3/f
        3+8SV2dwxm2hDEFn3TKDog==
X-Google-Smtp-Source: ACHHUZ687Kt6K8e3YCR3HIVzkrF4r312BQJ99CW0umX1310Gm/rdPancA3e4T+8F8FLon1Scz73T4w==
X-Received: by 2002:a6b:dc14:0:b0:76f:f54d:36ff with SMTP id s20-20020a6bdc14000000b0076ff54d36ffmr96005ioc.11.1686850031691;
        Thu, 15 Jun 2023 10:27:11 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a22-20020a5d89d6000000b007747a6d875csm6163436iot.9.2023.06.15.10.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:27:10 -0700 (PDT)
Received: (nullmailer pid 1230967 invoked by uid 1000);
        Thu, 15 Jun 2023 17:27:09 -0000
Date:   Thu, 15 Jun 2023 11:27:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Gaurav Jain <gaurav.jain@nxp.com>, devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: crypto: fsl,sec-v4.0-mon: Add
 "linux,keycodes" and deprecate "linux,keycode"
Message-ID: <168685002907.1230919.13694167518227679407.robh@kernel.org>
References: <20230613201231.2826352-1-robh@kernel.org>
 <20230613201231.2826352-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613201231.2826352-2-robh@kernel.org>
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


On Tue, 13 Jun 2023 14:12:30 -0600, Rob Herring wrote:
> The "linux,keycode" property is non-standard. Add the common property
> "linux,keycodes" and mark "linux,keycode" deprecated so that the mistake
> is not propagated.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml         | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Applied, thanks!

