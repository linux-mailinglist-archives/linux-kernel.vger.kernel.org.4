Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF6463CED0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiK3FpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiK3FpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:45:04 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189ED1EADC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:45:04 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so905665pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kcop1gzwvrOWuYGccdr47O8voZqAmlt2zg16X+P522E=;
        b=z41iTzbj/qN/MPAQ5F4zvwaDd9PpZTxY22drhP/5eyYFzjHcPHa79pM+kqyhKsCQ7/
         v/hzsc62C1o0gTwrYjuGzFFxvVZxZg6pdRaB8aIRUYdgpEVWvRCy5U7qxNWMKGky7KKN
         5NlS+CwQUx1VHmkZpABluXtWaRf+PsWkMm4SD8Xj/M37dYlRrxzIy8C+Qt7VG4fQgNGW
         3I19hb8bCxftYcoL2+HUB2/RLSZ1tCQo675W9ca5de9rA5XMdHEZ/uGM9rEbND/OiKYN
         j3XVw1yo4Mg6tUMt7VWoWZsDZ+vowH8/kIutoKY2Z2BSvUJNBLHgG4Q2z5S/rC85vbDv
         xeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kcop1gzwvrOWuYGccdr47O8voZqAmlt2zg16X+P522E=;
        b=Tnducnw9U/jkMjSP/JMf3yjYf2jTL98uFP8avq4h+5SEBuKyERJlrqdvS684GMElEN
         +ji04s0Cj7/OmzW0BwTrZIAwxw6ZCTb6hxGO3uSpVH+ZgFW6iJXKnKKPwNi7ugmD4pQz
         D6hfiuhp/ir2BRnbBm5KAADDxNy3IcNO0lAIJ6MeT2wfyOBIELL/G7StdKDgT95KFlXU
         M6OR2DL27Aei6MhTEYxXyBa0045t4kbgdg+K06LIuveyEL9jUi1ARw7sz0NnC1KybO7m
         0X9j0A1zpgaOGCGMxqkOOVAwRUAjJUlBKgdASrMCRaemmlqaMmEu1eEq+juWL10ziitD
         D4CA==
X-Gm-Message-State: ANoB5pkZ0AZve/YMYaFDFT7OVia6ixinIG7faf7hUS3u4A02bk1G98MF
        13eZ8d2VsDKTq2nlFr6gaRtWNg==
X-Google-Smtp-Source: AA0mqf6fvEC7PPByArPqHez7CyXgUfArEJ4SMUtjONXdpBqqiVfIleMT5tI/sdO5xAWpKyEdccQ3Rg==
X-Received: by 2002:a17:903:44b:b0:189:9749:d3fe with SMTP id iw11-20020a170903044b00b001899749d3femr8917136plb.70.1669787103612;
        Tue, 29 Nov 2022 21:45:03 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id u8-20020a170903124800b00189a50d2a38sm362710plh.38.2022.11.29.21.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 21:45:03 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:15:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Apple SoC cpufreq driver
Message-ID: <20221130054501.d65ajqzctsoyqemz@vireshk-i7>
References: <20221128142912.16022-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128142912.16022-1-marcan@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-11-22, 23:29, Hector Martin wrote:
> Hi folks,
> 
> Here's v5 of the cpufreq driver for Apple SoCs. v5 just incorporates
> minor review feedback changes from v3, and no functional changes. v4
> had a DT schema SNAFU; this supersedes it.
> 
> Once reviewed, please merge #3 via the cpufreq tree, and we'll take
> care of #1,#2,#4 via the asahi-soc tree. This lets us merge the DT
> changes in the same cycle without blocking on the binding coming in
> via the cpufreq tree first.

For patches 1/2/4:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
