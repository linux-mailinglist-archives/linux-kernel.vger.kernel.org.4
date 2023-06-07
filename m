Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFB8726FA0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjFGVAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbjFGVAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:00:38 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1339EFC;
        Wed,  7 Jun 2023 14:00:19 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-777a6ebb542so179248339f.0;
        Wed, 07 Jun 2023 14:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686171578; x=1688763578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bReB+G99C/TitPAfGna3q3OEgVBDkQB9BG1TaTm9cig=;
        b=QC5BXdUWeTr+Fs2otTY4ua7LcNbJD+1GpNC13VKGrYyPJ4y2QtoKQnjWl94j0bwIIb
         k1fa+uz6la9l6lx9EsOtVbGHELXC3WGasfj5rgXo4hT+KtcaM/MCR2sj+Swk1NBxGwhE
         kkYI4DaEKBJcXIw+tiTmj1QtQaBUXmcBTpfCg69QSAD+rmMBhE1Ag1Lzd903Wxk0ol94
         sgHA7i6E49TkQwhzS1we7LXRf5I6cCL+/zdAeoi8Qk9xljeM1my2HR3GFBlT7PZcWoz0
         vB80W6vq4H4/1W60gBBZ+877Pg7lST1MkBjnnCHl6ev3bik7WEIvDDuRn6hszEASve+m
         2Vyw==
X-Gm-Message-State: AC+VfDw4hK9uir7RPlcdIZdoy9V2Ip/1YDLimrtHoRnGVYqcjmFUfPX0
        +Kl/OE+/efNbGhQrqomKyA==
X-Google-Smtp-Source: ACHHUZ7tr2rY4wJwOgLmdXMjkDXUq68gIy7/NbTCkGDzXAqIzWGLJONAaOq/QVcAsm5gbrpJmn+Vvw==
X-Received: by 2002:a6b:7614:0:b0:779:c221:eb6c with SMTP id g20-20020a6b7614000000b00779c221eb6cmr4666621iom.19.1686171578643;
        Wed, 07 Jun 2023 13:59:38 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f19-20020a056638119300b0040fad79ac08sm3697065jas.89.2023.06.07.13.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:59:37 -0700 (PDT)
Received: (nullmailer pid 4012378 invoked by uid 1000);
        Wed, 07 Jun 2023 20:59:36 -0000
Date:   Wed, 7 Jun 2023 14:59:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-crypto@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH V4 2/2] dt-bindings: imxgpt: add imx6ul compatible
Message-ID: <168617157566.4012324.4683965294535906539.robh@kernel.org>
References: <20230530100843.15072-1-stefan.wahren@i2se.com>
 <20230530100843.15072-3-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530100843.15072-3-stefan.wahren@i2se.com>
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


On Tue, 30 May 2023 12:08:43 +0200, Stefan Wahren wrote:
> Currently the dtbs_check for imx6ul generates warnings like this:
> 
> ['fsl,imx6ul-gpt', 'fsl,imx6sx-gpt'] is too long
> 
> According to the timer-imx-gpt driver all imx6 use the same imx6dl data,
> but according to the existing DTS files the imx6ul GPT IP is derived from
> imx6sx. So better follow the DTS files here and make the imx6ul GPT
> compatible to the imx6sl one to fix the warning.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!

