Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F92683A82
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjAaXcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjAaXb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:31:59 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A4E4A1EE;
        Tue, 31 Jan 2023 15:31:57 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id p185so14298044oif.2;
        Tue, 31 Jan 2023 15:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpSebhuIxCshTfXuKAIuXq/TVfcGBSIS0YyGdJo/w/Q=;
        b=h8TBToPSti6HPfNA4A6Uy3MfIeQuHYqi1vuHU5wYvysScWH/934nM+DrrGC+zSN54L
         jO5g37yow7McGBqPsqWNDp4wfKVtptbk5hZG7NApUnGbatyRJyY5qS4JW7XvFGGOXMih
         RR/K5voO+8UVbo/Kd9+EIKfC1CfJUrRn0U4hJWzJhGjvfZUfCbYsh9qTaLr8DZ7cAUYS
         0jznxQXSrTGuuSm+6pYscZwvMLoWAlxSIeQacqRc7PmZrhg7KlfClg6fRfrmC6XFsnlp
         4MvY3nO9vaVTF+3omuUQGddf2QVcNSr3cuuWA5JXZnopxg97hYX/7ZQwKa9e6kemcDBb
         VekQ==
X-Gm-Message-State: AO0yUKUOJ7666ucZVaasV3F57Yb8DvFTDxxzQ8HMfw25bDGD4IRq+FEx
        TwaySI8tNnvcQA7kmCVbblY0u0iIxw==
X-Google-Smtp-Source: AK7set9lmdDVw4LeekokVVMhIToeNu34QFb80YRmvs42Ki5UN2cREP2nzMovK0Jk/VAyPIUVpc11tA==
X-Received: by 2002:a05:6808:30a4:b0:35b:e207:e50 with SMTP id bl36-20020a05680830a400b0035be2070e50mr273196oib.43.1675207916689;
        Tue, 31 Jan 2023 15:31:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i186-20020aca3bc3000000b0035b4b6d1bbfsm6307547oia.28.2023.01.31.15.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:31:56 -0800 (PST)
Received: (nullmailer pid 2151038 invoked by uid 1000);
        Tue, 31 Jan 2023 23:31:55 -0000
Date:   Tue, 31 Jan 2023 17:31:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: brcm,bcm7120-l2-intc:
 Fix 'brcm,int-fwd-mask' differing type
Message-ID: <167520791475.2150985.16489951770202083455.robh@kernel.org>
References: <20230125221423.3058221-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125221423.3058221-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Jan 2023 16:14:23 -0600, Rob Herring wrote:
> 'brcm,int-fwd-mask' is also defined in brcm,bcm7038-l1-intc.yaml as a
> 'uint32-array', so unify the type definition.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml    | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!

