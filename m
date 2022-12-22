Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343876545D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLVSJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLVSJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:09:47 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0258E15804;
        Thu, 22 Dec 2022 10:09:47 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id r205so2573841oib.9;
        Thu, 22 Dec 2022 10:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f80xyDOk9KHf4uJK6arjWJwVRc80XWsAqw622e+2d9I=;
        b=WjjX6ssCoVnP0c+K+hxsLtrqtF/y05DUpLRooP+0T86UHmIZ/uZuXMbNz7T54ZXWZ9
         fegWZqKuZFoJNkn8MqAVAriaw0XWGM6YQiaMgk+BKAiXXN71TEthY7e8rMO1lrnwJeuQ
         BzRNw6Fxnr01r298QCnLF6OcVIDJ6FUyl3+ULWN1xl3t2WTB8okzaV4hzHFgnEzvubRc
         oETUpu0awoE3eaN8NPaka/+ci/nnguob+Sjcdc8haRJ4IlaCOeLUpzUnlpEDozRZq0hc
         F2akBF/ES0P8d+yiU4VSxuI5oWU9oUHVrChhoz/c1W+yQqJHfhTbdQguGxY9nvJdEXP8
         oQTQ==
X-Gm-Message-State: AFqh2kq5bJyIeIBQ5hHu2I/aestXd5wRXvXSBKZuKDPYgYlqcAAPalw1
        rLToN9k9hbjn2Yw9ut8MBQ==
X-Google-Smtp-Source: AMrXdXsf5t0zjQgu0bp4rIu0RQlpGNwMex6n3Tknbcjzee6r9WtvrQsaOzukDzzJMGUlkmjLBBgQfQ==
X-Received: by 2002:a05:6808:13c1:b0:35e:66a4:1b19 with SMTP id d1-20020a05680813c100b0035e66a41b19mr4305245oiw.8.1671732586235;
        Thu, 22 Dec 2022 10:09:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r70-20020acaa849000000b00354932bae03sm598371oie.10.2022.12.22.10.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 10:09:45 -0800 (PST)
Received: (nullmailer pid 1836501 invoked by uid 1000);
        Thu, 22 Dec 2022 18:09:45 -0000
Date:   Thu, 22 Dec 2022 12:09:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Biju Das <biju.das@bp.renesas.com>, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: Add RZ/V2M PWC
Message-ID: <167173258412.1836090.16333363777384274301.robh@kernel.org>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
 <20221221210917.458537-2-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221210917.458537-2-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Dec 2022 21:09:14 +0000, Fabrizio Castro wrote:
> The Renesas RZ/V2M External Power Sequence Controller (PWC)
> IP is a multi-function device, and it's capable of:
> * external power supply on/off sequence generation
> * on/off signal generation for the LPDDR4 core power supply (LPVDD)
> * key input signals processing
> * general-purpose output pins
> 
> Add the corresponding dt-bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> 
> v1->v2: I have dropped syscon, simple-mfd, regmap, offset, and the child nodes.
> 
>  .../bindings/mfd/renesas,rzv2m-pwc.yaml       | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
