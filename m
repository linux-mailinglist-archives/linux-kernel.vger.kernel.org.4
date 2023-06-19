Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231D5734DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFSIcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjFSIcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:32:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F5ABC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:32:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f8d258f203so23639565e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687163525; x=1689755525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKgLxFNe6Vqer27h+wDKJ38s4aUcdV6KAPk/ux2OGzM=;
        b=isa+VCyPRBW3qNrZPJExkSh+lO23Q8qPTzQ5U8b6qLj0CqlJi+dNX7oXhQHcTgN7+0
         0WKkQUalhafgEitjWIhmDhWX2KG8SXN4S1bXpXytq9ibpi94NP5k3Cvrw79HRRnbzInJ
         t4k1u+sEfFCPdRFmH0JZ6N4bWl19s3SOT/g5GVDa5t/eDDWDlV7oQfxfdnIEdgtkKaks
         zSJvhsxgNDsRmo+fPXIQuFr6VqBE6pokBVHZr086RXQQA5P88+OBqRFJiPaHvYRvyXrY
         KHjeLvlMdjmi2jeqbxL1aQf2VukxyV+IeBxCCnUYeZTJCK9b48Qf9zpF0l9JgYj2sPI2
         Er/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687163525; x=1689755525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKgLxFNe6Vqer27h+wDKJ38s4aUcdV6KAPk/ux2OGzM=;
        b=VK/zJlgDBd0AHOA09/ZqjWrpl7ofN7sABxx2GbsZaM6FQWFyOqaw7/uHCMMFHEldho
         Dfkwm7ok7kWLXOpSoz1BgasfdZGI0C6290TtE4aVHBhQvk6aA9KI61RaiJmep0yelf3j
         B7DFFc9w2hprO4OGs5SyuerYbeVVYEmh7jEgg4HARpZD+SsrRyh1pMzEoLqhjxCJVKC2
         irbV7D3nF0QrNLTFpuWg2G8JT2hyS6LjZptDwHrhK0LgUn/WihbYFRbX/eKsT7/HqvKa
         Udi+Y4XVA+w06Z51KRdtzJ1VoPsKBlPC63UQHh7b1v+fKKmGasmZ4FNA23gJFnSirgfe
         ZkwQ==
X-Gm-Message-State: AC+VfDyhDCD5qj3lh09SYKg6geZSvRD9O5sgP9wKEb3NcdHrGqEaFTuC
        sYvsmCEE9QyvqblDt8P0ldsKOA==
X-Google-Smtp-Source: ACHHUZ5dfrlTzQZaKtkSsJqn5n2OOWZI5AIm3s7kGaM1LXA0sGsO4oPrV7FqHvnbGydobk6ik4WaBA==
X-Received: by 2002:a1c:e914:0:b0:3f8:facf:7626 with SMTP id q20-20020a1ce914000000b003f8facf7626mr5530793wmc.20.1687163525549;
        Mon, 19 Jun 2023 01:32:05 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z25-20020a7bc7d9000000b003f8fac0ad4bsm8634301wmk.17.2023.06.19.01.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:32:04 -0700 (PDT)
Date:   Mon, 19 Jun 2023 11:32:01 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Fei Shao <fshao@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: clk: Fix memory leak in devm_clk_notifier_register()
Message-ID: <56998d04-7f09-4982-b0f1-20ef917aa524@kadam.mountain>
References: <20230617160901.1.I2b151cdf7a72d9e3ecc7ab2ff38409ebe6d65d6b@changeid>
 <71168ceb-8273-4067-d0e0-c6c219d4618e@web.de>
 <CAC=S1ngN=TFQa0Y4FoSCOTUs8HRi4NEP1OwY8WccUEUMG_UDeQ@mail.gmail.com>
 <8366a35f-bc2c-4aee-b2bb-5fc9b2a7072b@kadam.mountain>
 <ea5c0b0b-7aa5-d4eb-def9-fa279d69cd44@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea5c0b0b-7aa5-d4eb-def9-fa279d69cd44@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 09:42:37AM +0200, Markus Elfring wrote:
> > He doesn't have a very accurate perspective
> > of what is important and what is not important.
> 
> I offered various hints for desirable change possibilities.
> The change acceptance might evolve in more constructive ways, doesn't it?

No, I'm sorry, it's not constructive at all.  You're just creating noise
when we should be looking at if the patch is correct and how we can
improve our QC infrastructure to prevent bugs like this in the future.

regards,
dan carpenter
