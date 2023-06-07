Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C05726C81
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjFGUdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjFGUdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:33:51 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34239211B;
        Wed,  7 Jun 2023 13:33:46 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-33c37f62e24so7586695ab.3;
        Wed, 07 Jun 2023 13:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686170025; x=1688762025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iVva9TijxeCG+oO2fuJtRH4NJqlWxMczFOc2yePB7g=;
        b=XsWtRmlUOGtnyr2RQNWcqHipVIsPvzOht0mtn2yaEk01jxgIb5FofVtWWfh6V6NOU9
         hyFHUHdoYD/NPTj3TY/x5xAexHX/6MEaVL9MGrK2xZfKWoZ5n5RHd/hfWN8qhaHkdLFt
         VOfF+X60fDor3rsekeGCXMPygQ2p2yaTlLJbSsimEpe0KuwnvVgSD1+UrmCntO6ag7z+
         dkEZxNRd9NeC4rngdPYTHeXtjcFqUBj+GyapLE26+p/AY61fK/jr3biZynYFi4JiHdtB
         3DYUVj/GykjUIZ++KgmFzcsDSpcDimm+7nLq7R1bKJNKfTsUhOGwzt0RNF5Rz4pe3qgM
         Qb5A==
X-Gm-Message-State: AC+VfDznPBUTv7vD4m06FyWMXd9QnwV0w1wiBA/SFlJqGn6Hi1lEgZ14
        LKlJeNzf6TtvaPAQpTxCpg==
X-Google-Smtp-Source: ACHHUZ4VBsK/pRdxbIVwIR7PM8P6q0QhZxOoxBwVSOfqQqZV3ZYtLKMGskrPaGb6pYE7Badlv2n2ag==
X-Received: by 2002:a92:c00f:0:b0:33b:ca8:fdaa with SMTP id q15-20020a92c00f000000b0033b0ca8fdaamr6422297ild.6.1686170025373;
        Wed, 07 Jun 2023 13:33:45 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t2-20020a05663801e200b00418af04e405sm3586065jaq.116.2023.06.07.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:33:44 -0700 (PDT)
Received: (nullmailer pid 3973482 invoked by uid 1000);
        Wed, 07 Jun 2023 20:33:42 -0000
Date:   Wed, 7 Jun 2023 14:33:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, maz@kernel.org,
        tglx@linutronix.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller:
 microchip,sama7g5-eic: use proper naming syntax
Message-ID: <168617000060.3972795.10055026929860783252.robh@kernel.org>
References: <20230523070637.224476-1-claudiu.beznea@microchip.com>
 <20230523070637.224476-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523070637.224476-2-claudiu.beznea@microchip.com>
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


On Tue, 23 May 2023 10:06:36 +0300, Claudiu Beznea wrote:
> Use the following syntax for Microchip EIC YAML file: vendor,device.yaml.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../{microchip,eic.yaml => microchip,sama7g5-eic.yaml}          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/interrupt-controller/{microchip,eic.yaml => microchip,sama7g5-eic.yaml} (98%)
> 

Applied both, thanks!

