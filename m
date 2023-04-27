Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6296F0A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbjD0Q6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbjD0Q6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:58:22 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629D81710;
        Thu, 27 Apr 2023 09:58:21 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6a438f0d9c9so6585417a34.1;
        Thu, 27 Apr 2023 09:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682614700; x=1685206700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVDMZO8bxEJIxS9PI5722WZbwU4DYkxh8/qW+7ek2mk=;
        b=QySpC+/udUi6+yjKuJILI+rLEIebe4rvoC8F9jgOOOdT5KtGYkhUSqVqvKX275FyEw
         qQelxIsZPAZTsGMCj9OOpmCgyz5h2Q6pxqL2zOL2kGRJs6Pl6HXQK/KJqCXxqTuEVL9e
         qTjf8/wfo412R50xuohBUVd4Bn+JASYsEOne8WWmQOwVzD14/mFMe2PJeAvDsap8YM4a
         IbKfswNvu4Uv2CxmB1thvAkRy3Ti6bCj8ZmIoxHiEAPTes8tchvsZ0jdYHHm+0+TmdgB
         gkFvQ23Zp/IHFkBHZKgqd6oMnYF/FttDcuaNaJEyQupiTBNIzlw+WCis30ZEEId116lt
         tfkA==
X-Gm-Message-State: AC+VfDzfGGsUH2mKBrO034RiHcuWpijYe6hf53EcRc0ieQhxHyw8DUIm
        vHLuGTXAQKkdykgTLOGU5uqPWeLD9A==
X-Google-Smtp-Source: ACHHUZ4dMvCSafI1uquiq+8NtLkmw2HRk59JIlme3n1Bkh+j7qljFBrKofUa9TZHcolg2VjH/2/vOw==
X-Received: by 2002:a9d:7687:0:b0:6a8:b659:d46c with SMTP id j7-20020a9d7687000000b006a8b659d46cmr973283otl.11.1682614700664;
        Thu, 27 Apr 2023 09:58:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c10-20020a9d67ca000000b0069f153bb37asm8158604otn.62.2023.04.27.09.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:58:20 -0700 (PDT)
Received: (nullmailer pid 3163297 invoked by uid 1000);
        Thu, 27 Apr 2023 16:58:19 -0000
Date:   Thu, 27 Apr 2023 11:58:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH] dt-bindings: timer: brcm,kona-timer: convert to YAML
Message-ID: <168261469911.3163242.999660035852888472.robh@kernel.org>
References: <20230426182854.GA9571@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426182854.GA9571@standask-GA-A55M-S2HP>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Apr 2023 20:28:54 +0200, Stanislav Jakubek wrote:
> Convert Broadcom Kona family timer bindings to DT schema.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../bindings/timer/brcm,kona-timer.txt        | 25 ---------
>  .../bindings/timer/brcm,kona-timer.yaml       | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

