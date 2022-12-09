Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A677D648A28
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiLIVkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIVkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:40:22 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7692FFA;
        Fri,  9 Dec 2022 13:40:21 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1442977d77dso1304486fac.6;
        Fri, 09 Dec 2022 13:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQNLNwb7egvKzdyQwetZ99ju3LT/N1ETMdh7cmYXrrI=;
        b=B3pYkSGPptx0Di4qdXOLzZt3nhPYQZaZffRzKnWLgT5tw8adZwW9HOjioHK5HhE4nA
         fRwrxKE+21EiWWnBsunVTMVJJ2QE22u8I0qSTYRxhuMA25M6A0QTbKRlsCjq5JmJOgr4
         rZ71weQI5iIjjNCgyUP6s2CWu4FNgUTbzjYTQTIFqcG9AFZxf6zExlc2FgNct9tWQzvI
         rd6s/vQlaQFqvei5E3azQKuzN7D56G6IbHZ0P55PwnwDcMlz62G8M18FHHKtFKtj58eI
         +CJ1jYDGkbiaauAXp3+lIW0eWaO1HePZvTV9umbEP1yNFBZqxxr3lsWJ2mmXAIm1o9h+
         ebJw==
X-Gm-Message-State: ANoB5pmvywYvDyI1x19m54K83p/AaYg+kCM+oW37aAUw49U2KCrh2Y7l
        C/QdAOzqiOpP0JAuVI0rKw==
X-Google-Smtp-Source: AA0mqf7lwDrbenyYhLWCRr+uwf9A/1TS2dZQejWfTzGivAycybUvW/jQnBmc9p97uk9mjPhgpxrqpg==
X-Received: by 2002:a05:6871:4592:b0:143:84e0:ac18 with SMTP id nl18-20020a056871459200b0014384e0ac18mr3687567oab.33.1670622021171;
        Fri, 09 Dec 2022 13:40:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u6-20020a056871058600b0013b92b3ac64sm1405499oan.3.2022.12.09.13.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:40:20 -0800 (PST)
Received: (nullmailer pid 3892918 invoked by uid 1000);
        Fri, 09 Dec 2022 21:40:20 -0000
Date:   Fri, 9 Dec 2022 15:40:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Peter Geis <pgwipeout@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: rockchip: add Radxa CM3I E25
Message-ID: <167062201942.3892855.2015967991620130082.robh@kernel.org>
References: <20221209102524.129367-1-amadeus@jmu.edu.cn>
 <20221209102524.129367-2-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209102524.129367-2-amadeus@jmu.edu.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Dec 2022 18:25:23 +0800, Chukun Pan wrote:
> Radxa CM3 Industrial (CM3I) is an System on Module made by Radxa
> based on the Rockchip RK3568 SoC. The first carrier board supported
> is the Radxa E25. Add devicetree binding documentation for it.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
