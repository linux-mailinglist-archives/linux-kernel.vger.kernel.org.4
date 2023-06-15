Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE67E731F18
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjFORcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjFORb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:31:56 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4A1270C;
        Thu, 15 Jun 2023 10:31:55 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-77b00bb3fd6so36457439f.1;
        Thu, 15 Jun 2023 10:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850315; x=1689442315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkhQdbzK/JQNpLtdi3xfeP99Qq8P80vebf9FHM9ma7E=;
        b=j8tKU83Ao3OoCor23uKb5zilSlFENGwxYGjdBOE2hmT4TLYAp6pr3UaXFin2knObo9
         xsa6CAgIPJ7w8ur0JgKk9buH2ztxM6ZD3kdZd3gnEW1CGKhPhcPy10h4QZo167XtNnxW
         8WsSpW3nW9HyL7AqfkwtepKOsiDGrHS5PRNSn08hH9jPBf9Au1TPXtflnl2rpn7pHiHA
         e9TKeFR0kcFEJi3G95vi5ik1RXqjJo33xajFEPTohvQI+xrNZBYKR9jM/DtBaucpBRGP
         WrIwIwijwOJ94ybdCC1o3IS0VvnGoLJG0toPlfQ/terk+N1ui+eQDMrqO/BZ2jnv8yYs
         /QDw==
X-Gm-Message-State: AC+VfDxKbz/W07gnVfEKCppLLZATBAHBJo3cdkLFpvw/QU16QX9Nv26i
        lU73GjDxL6pIC+KMGUFsgQ==
X-Google-Smtp-Source: ACHHUZ62NBa/rgMlrSg3KTLd+HFQrJ05IAz83DdDaq5ekZFLEAcGESQTtVkP8WhtD/aTcPJkA3LkHQ==
X-Received: by 2002:a05:6e02:1253:b0:33c:2a80:3721 with SMTP id j19-20020a056e02125300b0033c2a803721mr4057200ilq.4.1686850315209;
        Thu, 15 Jun 2023 10:31:55 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f12-20020a02cacc000000b0041ac54cbc60sm5751224jap.56.2023.06.15.10.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:31:54 -0700 (PDT)
Received: (nullmailer pid 1235901 invoked by uid 1000);
        Thu, 15 Jun 2023 17:31:52 -0000
Date:   Thu, 15 Jun 2023 11:31:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Marek Vasut <marex@denx.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] dt-bindings: timer: fsl,imxgpt: Add imx8mp-gpt compatible
Message-ID: <20230615173152.GA1235714-robh@kernel.org>
References: <20230614113612.365199-1-linux@rasmusvillemoes.dk>
 <8f2d0993-4b19-18f3-1261-01c7149672e2@linaro.org>
 <a65003fb-4557-a1ab-bee3-103ec5e6de6e@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65003fb-4557-a1ab-bee3-103ec5e6de6e@rasmusvillemoes.dk>
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

On Wed, Jun 14, 2023 at 09:25:11PM +0200, Rasmus Villemoes wrote:
> On 14/06/2023 19.19, Krzysztof Kozlowski wrote:
> > On 14/06/2023 13:36, Rasmus Villemoes wrote:
> >> The imx8mp has the same GPT as imx6dl. Add fsl,imx8mp-gpt to the set
> >> of values that can be used together with fsl,imx6dl-gpt.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> ---
> >> This allows what imx8mp.dtsi already does, namely
> >>
> >> 	compatible = "fsl,imx8mp-gpt", "fsl,imx6dl-gpt";
> >>
> > 
> > https://lore.kernel.org/all/20230327173526.851734-2-u.kleine-koenig@pengutronix.de/
> 
> Thanks, I looked in -next and didn't find anything, but didn't think to
> check lore.
> 
> So could somebody please pick that up? Shawn?

Done.

Rob
