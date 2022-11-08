Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53B2620835
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiKHEVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiKHEVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:21:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9858518B34
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 20:21:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l6so12687826pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 20:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SfqLAbIddyq76wOhovHVJdZznkWEzSpDefKEM7fw48=;
        b=JIPRYFMoxy3GfAJ8By4TEu05YaVP1ntog5Y9wfjBHbFI1pS5m1s0/JiB9eBWyuxgRs
         0d4P4UZ4vPDsNtFUnv4GxztfLBlFtpjOiBeHFieTSpPDV2eF6EeOrHaJX6plPhQ34F3w
         NDtQwNc7pWMxanGPjLm8ziu+H56nHbzmXNyTJm/MiMdm4aGS/2EnyHjpHA41vfCOcdkk
         PZYkoCZKIO9P2X7ul2+Brtdrn31FQo4Aagnu5OsEx780t6woauhvhYEAvhfUjk8RRfFn
         Y1i98rgs9vswK1e9wRByWf0TlSpa1oD0/+RnVPkKSHpOqiPHpkhoezw0CyhuWqJvao1G
         dkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SfqLAbIddyq76wOhovHVJdZznkWEzSpDefKEM7fw48=;
        b=lnuIvVprmJfU+LabKJxjfROkWOMXBJ8j56uhgkQsbCPmZKQ99PpOyDPqBMhmYpFWAz
         nQzGSbrYgjWP7srzj+TD9I7G9TQuzuTs7mr63tE++gET1CQXAHRbMnGyRan9H2NDRkfQ
         /RLBXt9K3id+zh514OQDYmvAU2PzTku+dvqyD77LAZBWMDaNzbiDnC1lGNwd3/M9wmZk
         w0bwqc7FyWKfqLdu2l3z/EM0JTnpSvcGWNVe4QKZM5qV9RXKplwChXxKshK++XsDPlul
         1IZacBAZi7++gBwX9XK4R0Eu790xzjK1JDFKcowgZUVs8fOjDVj/E93E52qg4OZ7L88s
         dLFQ==
X-Gm-Message-State: ACrzQf189eKMA+DhSkh1ce6c6VmL6xWRhFti8SGRLDXq9w3UiyfTRspg
        XM661hkLiqWdE9Ja0j/QrTOatg==
X-Google-Smtp-Source: AMsMyM6rouWEqC5wyKoVUJdp0gW7NIB8ViQoUIR9P8lG8d913aUjGMtR7fXDusx8RWaiFC72isNXQA==
X-Received: by 2002:a17:90b:33d0:b0:213:137b:1343 with SMTP id lk16-20020a17090b33d000b00213137b1343mr55451053pjb.128.1667881263179;
        Mon, 07 Nov 2022 20:21:03 -0800 (PST)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a39c400b00211d5f93029sm6873798pjf.24.2022.11.07.20.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:21:02 -0800 (PST)
Date:   Tue, 8 Nov 2022 09:50:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: opp-v2: Fix clock-latency-ns prop in example
Message-ID: <20221108042058.o7xuzkuokykv5xcs@vireshk-i7>
References: <20221107204355.31971-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107204355.31971-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-11-22, 23:43, Serge Semin wrote:
> Accidentally discovered a hidden typo in the DT-nodes defined in the
> opp-v2 bindings example. Instead of specifying the "clock-latency-ns"
> property the DT-node has been created with the "lock-latency-ns" property
> in it, which doesn't exist neither in opp-v2 nor in the base schemas.
> Let's fix the name to having the "clock-" prefix as it was originally
> implied and as the rest of the similar nodes has.
> 
> Fixes: 94274f20f6bf ("dt-bindings: opp: Convert to DT schema")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Applied. Thanks.

-- 
viresh
