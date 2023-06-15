Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA12E731EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbjFOR12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239185AbjFOR1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:27:13 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE232976;
        Thu, 15 Jun 2023 10:27:05 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-77aec4dcd9bso355469239f.2;
        Thu, 15 Jun 2023 10:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850025; x=1689442025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNCDqrABJF3M8/lnxfzZZp21Ai/zRv5Taug3qoEtoTY=;
        b=U8O8+2zerXQbADh2/HEwM4CTLYIYh5WxWvm7A0qgbqJovDsJLeWZs8Kxqd0YKUs81z
         zrEYaYQoa4lSI6MvEJD69fV20ijjNTiA1UQFBU5xAdwaMBdr+qz4qGYkgZqVC2rjTvMu
         VojAOmb3hrmx03dZ9+705yRdmYdEq+sjTtQD+HraZlDQ6pQKIDMIcNrZ0M9D/oHM8R1R
         txcSNoVEE7Igtu47PFeJXQcFSsrv1DK2iF0oFsd3fO0Bh2Av09Qex07bejtHN6B3pBH9
         +CUkqe0x9MjkhbeqisfxraJfRlZUBxfJzw8ATx2WNrOUVgqNrz6Gl/8DMqfvTcIXrQO4
         awQg==
X-Gm-Message-State: AC+VfDwTA+N+J4VPg/XvlTXzRYvVgN+SHC+qSbuVxX7VZldYAzkpTEIz
        TVKC6sMud9dEwKAfhK1Y/ptCoqjSEA==
X-Google-Smtp-Source: ACHHUZ5ZBlTykTw03OYSJ1c/iVqnzi62NArMJdfe7f3A+YpFQnjWjIEEbBDu+oiv9aaVdz/5vxJtCg==
X-Received: by 2002:a05:6602:420b:b0:760:ec52:254d with SMTP id cb11-20020a056602420b00b00760ec52254dmr156243iob.2.1686850024987;
        Thu, 15 Jun 2023 10:27:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o8-20020a02cc28000000b004186bea7f51sm5723990jap.54.2023.06.15.10.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:27:04 -0700 (PDT)
Received: (nullmailer pid 1230692 invoked by uid 1000);
        Thu, 15 Jun 2023 17:27:02 -0000
Date:   Thu, 15 Jun 2023 11:27:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Conor Dooley <conor+dt@kernel.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gaurav Jain <gaurav.jain@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: crypto: fsl,sec-v4.0-mon: Add missing
 type for "linux,keycode"
Message-ID: <168685002168.1230636.5672610340417656950.robh@kernel.org>
References: <20230613201231.2826352-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613201231.2826352-1-robh@kernel.org>
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


On Tue, 13 Jun 2023 14:12:29 -0600, Rob Herring wrote:
> The "linux,keycode" property is missing a type probably because it was
> confused with the common property "linux,keycodes".
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

