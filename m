Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1B0726F9B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbjFGVAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbjFGVAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:00:37 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68DA1FEB;
        Wed,  7 Jun 2023 14:00:16 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-33e53672aa6so7306895ab.1;
        Wed, 07 Jun 2023 14:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686171572; x=1688763572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axXVP1FSeT8lMoMtxFYk2sNnZwnKT/moxNbe0e0mxa4=;
        b=lQ9LH88JvuI30SR0tJxmPUtarJCE1q+Pg4/OTOG9RM4Zb4lJwRoxK4LudbRNkg73Sc
         7GMLZvFWZS10qIzcXlgCEiS+VOciSC2wa+qx4T9oueRHl8eOslb7AS73mbIcfuEi8Vyi
         WKRQgullameS97MOooQ/BVZ5+oDNtWocpl8aDT76qOcdClsdoqBosK69YtYDq3rfcdh7
         TyDfVDesgYYHxdjI1qBrSoO94ckZucSl3atSvh9I3V7DRLQW90GpHROSlpZPSRc3cBvF
         BO8DPAVW+vdfnU62W/9gpEvQ9HdsgzyliSpDAk03xSql+hQk5a+1lU4COdkNYr4gsdu8
         +hTQ==
X-Gm-Message-State: AC+VfDwjDDRjyH7aGbgiVJmNMjME0fb3+hAShGcd7DfLs65mYJLvQwyY
        8B/Dbru8//3T2HCUd6vjXg==
X-Google-Smtp-Source: ACHHUZ6Wj/Yz722n4BTii4IYWHsMX9owkLfvImZFc5WG8aPD5Yuwi2Y2oJGfNsDHhsPofoob1v3Q0A==
X-Received: by 2002:a92:d24b:0:b0:33b:c0d8:26af with SMTP id v11-20020a92d24b000000b0033bc0d826afmr9303310ilg.7.1686171572475;
        Wed, 07 Jun 2023 13:59:32 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u15-20020a92d1cf000000b0033a6e7ee4e3sm3939749ilg.1.2023.06.07.13.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:59:31 -0700 (PDT)
Received: (nullmailer pid 4012050 invoked by uid 1000);
        Wed, 07 Jun 2023 20:59:29 -0000
Date:   Wed, 7 Jun 2023 14:59:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-crypto@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH V4 1/2] dt-bindings: crypto: fsl-dcp: add imx6sl and
 imx6ull compatible
Message-ID: <168617156788.4011973.6516502300479379769.robh@kernel.org>
References: <20230530100843.15072-1-stefan.wahren@i2se.com>
 <20230530100843.15072-2-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530100843.15072-2-stefan.wahren@i2se.com>
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


On Tue, 30 May 2023 12:08:42 +0200, Stefan Wahren wrote:
> Currently the dtbs_check for imx6 generates warnings like this:
> 
> 'fsl,imx6sl-dcp' is not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
> ['fsl,imx6sl-dcp', 'fsl,imx28-dcp'] is too long
> 
> or
> 
> 'fsl,imx6ull-dcp' is not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
> ['fsl,imx6ull-dcp', 'fsl,imx28-dcp'] is too long
> 
> So add them to the devicetree binding.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/crypto/fsl-dcp.yaml          | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Applied, thanks!

