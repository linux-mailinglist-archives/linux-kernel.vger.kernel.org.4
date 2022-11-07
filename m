Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CDF61FFD6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiKGUvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiKGUvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:51:05 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862A229CB9;
        Mon,  7 Nov 2022 12:50:59 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id n83so13475658oif.11;
        Mon, 07 Nov 2022 12:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMIfFh0jFk/uWC/uMd3cS1sbab5CiZecRWEgl6xf4h4=;
        b=SR4yTPwkLY6MER4d4cbQw5tf6ivKIyIu+cXmOt6Jjn9zVbeg5zIMJRaF7D3qOr8q80
         Y3tDkY40Ztix7zdI0tD7rDouy30rcu76lijLq3K9p7WTTzFfrMDO0p3ylc996jja+uNa
         ykOgvXr+nh9qFnV6j8LQwbIG6Zs26woCQE2w6EB7vR37k8YShIcKlP+eojhNgFZnu8j5
         dAODHP9KMXnRFsI1h1gPxBbCmRLz/Xj+7FAKRIsRnfL4e0S659Qb36/ugMgIndrPEOQQ
         y5qLLuq2RZX8CjTBCiyQVIeOCJkxhOnkSh9C5AudR090eWM9ltgEEfx9SBQxbjGjaqG8
         08NQ==
X-Gm-Message-State: ACrzQf1TYXGUAAMWQTW5lDnklKb+qbNL1urQ0ZTfhtRAGPcAMnM1rmxF
        cD0th4tuS1Xp7KGZjz6Rng==
X-Google-Smtp-Source: AMsMyM41YcU8dki2sEq2So/D+/0EszJm73r0qBdIP7orU+mr6c8WbQJzk+wRIqeViK6ZzLMRGsqoag==
X-Received: by 2002:a05:6808:8e2:b0:35a:2f3e:4210 with SMTP id d2-20020a05680808e200b0035a2f3e4210mr19223245oic.7.1667854258798;
        Mon, 07 Nov 2022 12:50:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x12-20020a05683000cc00b0065c2c46077dsm3324264oto.67.2022.11.07.12.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 12:50:58 -0800 (PST)
Received: (nullmailer pid 1610687 invoked by uid 1000);
        Mon, 07 Nov 2022 20:51:00 -0000
Date:   Mon, 7 Nov 2022 14:51:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-renesas-soc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: timer: renesas,cmt: Add r8a779g0 CMT support
Message-ID: <166785425794.1610599.8755518204982690405.robh@kernel.org>
References: <20221104150642.4587-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104150642.4587-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 04 Nov 2022 16:06:42 +0100, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
