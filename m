Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8E6B8D72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCNIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCNIgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:36:16 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F4092BE7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:36:05 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-53916ab0c6bso290151247b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678782965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lB6BaE9PQJlFgjFssuLDs/1pNB2B4wE60UwmllOQKpo=;
        b=VtcOJxgORj62aKYqzvzFIs9Br4dJKBMCAEWt93DXbXwwsXDVO7+MGIv3c7MbPZbr10
         vyRB8SldCFFr3jeV7LmFMZ/MTcigZTzh3EQcEPJhoQVdlh9tihXccGEABIbfK0oK3kCX
         4sDZPavb02Ylwi8kGp7f81navOLC7IDuU+tM4BiRrr4P+EU12hOH/VNN0AgDnMofxmrD
         GqVSTa5k4zWmfAYdvlERb7DRuYbLpKA4R3aaV8npy6kBTzG9jKu4jJpbQxBec3GM90PI
         DNMWtpnjk+uv58HdlQW+WQ6+Ap0qLb4JuFBcgZkbE1FVPAapHcJvWVtCrlySFUpMsr9d
         9Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678782965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lB6BaE9PQJlFgjFssuLDs/1pNB2B4wE60UwmllOQKpo=;
        b=2GpFkkEyjc0bTtDkta6LuE2Wym4FYEYyMgsLSoAvFj3+BwPKOJ2nw6VreC1qzZ3SLP
         /CP7bUdjsaZgs2hV/UPTfAiEORqApEfFy5+Tu1GjwcFb4syHILlepcnjgczVF5gaNcnY
         aPx3yfSTEZogC0ULq7fjr+D3rYffziGYlr54WYf5srNhfQIvin/gdMRyb8Z7cqHq8k9D
         341KvMdVW8LUNcwytc8utKOWBEENylm+E3VRsvK9PDIcN/tx98Fm1ePb2jS7s4RBvxKH
         O8WsqXir7qCWoaGO3MG6RNnudtNt+avZr9AryQw+NY2nSJe/kJg9Obk8dbxNaxzx7Vg2
         BeQg==
X-Gm-Message-State: AO0yUKWAcaKkEKMpFlnQpDnUTU4WEXeTVAgr+cNrNrat49C/J4azRm8f
        ewNRCYo73EmnEs50yVfc/Cu3mkPomSkLKUOtsySXPQ==
X-Google-Smtp-Source: AK7set9zsq4G3HjB2UmY3GdM4HjLIJpqrBod3QW00SMBURajfHD1KhUPcUBu7rZpTvJJrigEfTbcfa9NLeKNv+p89is=
X-Received: by 2002:a81:b10a:0:b0:53d:2772:65d with SMTP id
 p10-20020a81b10a000000b0053d2772065dmr18614375ywh.9.1678782964942; Tue, 14
 Mar 2023 01:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230310190634.5053-1-dipenp@nvidia.com> <20230310190634.5053-3-dipenp@nvidia.com>
 <CACRpkdYmC=eLiWPPPRG7DYBmQfPNCN4pcDhzTCO=hkQDx2HoGw@mail.gmail.com>
 <798dd219-f4aa-39b3-2368-7a6d072b6de2@nvidia.com> <bceedc91-cccd-258a-1cab-57a79f5a294d@nvidia.com>
In-Reply-To: <bceedc91-cccd-258a-1cab-57a79f5a294d@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Mar 2023 09:35:53 +0100
Message-ID: <CACRpkdYkYBimR_9-hDRk7Gsi+qq78_WYvD8PMAJwtE_n2zVs1w@mail.gmail.com>
Subject: Re: [PATCH V3 2/6] dt-bindings: timestamp: Add Tegra234 support
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 1:02 AM Dipen Patel <dipenp@nvidia.com> wrote:

> However, as I understood, current point of contention/discussion is addition of the
> nvidia,gpio-controller property.

No I think you are talking past each other. Krzysztof talks about
a "removed property":

> Unfortunately, I don't understand this statement. The
> nvidia,tegra194-gte-aon with removed property is in a released kernel
> v6.2. What does it mean "technically"? It's a released kernel thus it is
> a released ABI.

The only property you remove is nvidia,slices, so deprecate it instead,
problem solved.

I don't think the added phandle is a problem, it can't cause backward
compatibility issues since it is new.

Yours,
Linus Walleij
