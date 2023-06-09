Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEE9729FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbjFIQMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFIQMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:12:18 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383661BD3;
        Fri,  9 Jun 2023 09:12:18 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33b1e83e204so8220175ab.1;
        Fri, 09 Jun 2023 09:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327137; x=1688919137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa4vB2U1flKhhbprb1amfEpwTs4HseZtMrwx/2SL6kQ=;
        b=gc5aBtNPlB/rV5SsvMpQDQU6OwD+q7NtHkRTWsmia/a1+oH3gG5by5p3O88/gPBrd9
         Y7VvD8W6YsCEFyO/uZ8rnsBkY4ZOxNnnFrp4qEJlQ014zwW3mGFyoHDOfxLFUYw7obBK
         phhWCTPof6zsUqGl4VJWRLv2eFtKkSwAdh9+E6hUh+AyQ8nbQO71cXBg82pWffFIugfU
         nFeY+BTy2m5fmi29rItxq6cul5dcBTWUI3cZE+cnvFkQ0StSxcqWUbuaJ9N0HWKT45Wo
         zoPJKOk1KM49U7NdY3oFvOjLSjU8D+4BpOcp6x5/sgV3KM5IZDPymnux6eJQoBQmWdYg
         owWA==
X-Gm-Message-State: AC+VfDxVmfZsgKRNj8gUss+yaNVgDG0dnKerV1cBbM66ahRILktkmnOq
        Cf83nYtD/6pUXDwBrz9iRg==
X-Google-Smtp-Source: ACHHUZ6Lmwer/Pv2HgUYkSqmxwSS2AKnK0XIdjSFYROINnw9bMDw1r1RDEgF6FOMzh/q+aKy9o6xHA==
X-Received: by 2002:a05:6e02:6cd:b0:33e:8195:5a4 with SMTP id p13-20020a056e0206cd00b0033e819505a4mr2008663ils.20.1686327137433;
        Fri, 09 Jun 2023 09:12:17 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t17-20020a92cc51000000b00325e4c39de8sm1137304ilq.66.2023.06.09.09.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:12:16 -0700 (PDT)
Received: (nullmailer pid 1185251 invoked by uid 1000);
        Fri, 09 Jun 2023 16:12:14 -0000
Date:   Fri, 9 Jun 2023 10:12:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     monstr@monstr.eu, Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        git@xilinx.com, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Mark Brown <broonie@kernel.org>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        devicetree@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH] dt-bindings: trivial-devices: Add infineon,irps5401
Message-ID: <168632713297.1184845.3122767939046227328.robh@kernel.org>
References: <9673fc919c6785879975fb1830d5026d3cfa658a.1686233049.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9673fc919c6785879975fb1830d5026d3cfa658a.1686233049.git.michal.simek@amd.com>
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


On Thu, 08 Jun 2023 16:04:12 +0200, Michal Simek wrote:
> Add Infineon IRPS5401 power supply to trivial devices. Driver has been
> added long time ago by commit 9158411b96b1 ("hwmon: (pmbus) Add Infineon
> IRPS5401 driver").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!

