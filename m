Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF127390A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjFUURs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFUURq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:17:46 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7571994;
        Wed, 21 Jun 2023 13:17:44 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-77e35128efdso168201839f.1;
        Wed, 21 Jun 2023 13:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378664; x=1689970664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMzg88R5lwHCsteG2sdO20LoPYWmjJKCksE0YOdCh18=;
        b=hEUyt33/nCirJMa53+qLS5+yDjLQC8zPO1qLbHbHzK4ahDOx3NalcgzT/1dqzh5uUB
         lRFX8T+dkp/akfD+iH1a10qMmY4JSiCNDcwcSAOAsKeJZFQe+PJ57dqwy+LpHV9phlxk
         hkSPvoaI74uotdbpsglleG6fxfUoEUcAn0J6wv9nRQ3Va37RqlfVophHmXkVYbAcuK35
         2gjjVv3GA6OyURG7/P1bAt2L0/XP8VjCyEKKdyF9kOjlNCwVC9rYtfmWooV5YIBA6dkR
         0iz/TtSCYSihxlv+7zuZKc8Ll6jH3pbneHYnmjApNgo9a0rw5n+N+rWvnpqssiE/INJ0
         D9Pg==
X-Gm-Message-State: AC+VfDyescjL+K8C+10RYN5PvGhHm3/YZCVc0PxbwYTLP1ityogTsQvh
        o/wuJRW/1Og8NM6CtFxAig==
X-Google-Smtp-Source: ACHHUZ5Lp359DCL107oPbk6xXdTKw0Q4fj3O6nVNq/iy+s/HKrFkCKW34QOXJdLsRO/VEMQ7SADG2A==
X-Received: by 2002:a5d:8455:0:b0:780:c221:89e9 with SMTP id w21-20020a5d8455000000b00780c22189e9mr1617860ior.5.1687378663856;
        Wed, 21 Jun 2023 13:17:43 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i13-20020a02c60d000000b0042036f06b24sm1515282jan.163.2023.06.21.13.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:17:43 -0700 (PDT)
Received: (nullmailer pid 3465754 invoked by uid 1000);
        Wed, 21 Jun 2023 20:17:41 -0000
Date:   Wed, 21 Jun 2023 14:17:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dt-bindings: bus: ti-sysc: fix typo
Message-ID: <168737862857.3464913.12862621161758307926.robh@kernel.org>
References: <20230620200917.24958-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620200917.24958-1-mans@mansr.com>
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


On Tue, 20 Jun 2023 21:09:17 +0100, Mans Rullgard wrote:
> Fix typo (period vs comma) in list of valid clock names.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  Documentation/devicetree/bindings/bus/ti-sysc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

