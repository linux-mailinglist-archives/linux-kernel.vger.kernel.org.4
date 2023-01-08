Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12286617D0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbjAHSJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbjAHSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:08:45 -0500
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E620657F;
        Sun,  8 Jan 2023 10:08:44 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id o8so3843331ilo.1;
        Sun, 08 Jan 2023 10:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G2aF2Rlg2azVZf2JFJeNKVoMm1OVbhxv0Ci3azN7wE=;
        b=dpy1TFbdVVJvROIkfWTyE8wiPwbunr+w8+rURH6AyzaCePob0QDwyZHCNKjCkZPC/n
         eDa95/NOTX4H0qYtq6YUfZ+uZJY1tWjd7KnEfEJX9LyQNiddgr4P1gRUkITOPgVZxbNi
         qGTvhlo0srIIfgy/qLXD327i+ZmgyyNhC5Ru1iYAxiNei4E9h76RP8wVJ+s3uzhxjFiP
         f7dJHcKClqWkzTuE1jLzzVfPgn2ng8ARYHUb3rQJzYj+xDF2zLDnEkwh74metDR61ULw
         T2fsdedpT9uvXTtVoGp3TJ2DReoz75A/twpu0UhjuPeNuEMdy0MHhwyPXZksBY1mnVb5
         8aBg==
X-Gm-Message-State: AFqh2kq5wpC72s0pZCU+UYgSSiJthu1f5wTh777fowql5XaUmK2HW62S
        IfL+kj2zj6Uy1AWBiQAN99EAZNHleA==
X-Google-Smtp-Source: AMrXdXtwGhnMqe9C2G+mYOvJ/eN9hOjcLZPmAVnaDhw1Q+GPzNfHud/mEjKEJ6nfHLiRx0oZyQ2jJw==
X-Received: by 2002:a92:d20f:0:b0:303:27a3:8666 with SMTP id y15-20020a92d20f000000b0030327a38666mr42281126ily.28.1673201323881;
        Sun, 08 Jan 2023 10:08:43 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id e30-20020a02211e000000b00370decbbff3sm2079795jaa.148.2023.01.08.10.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:08:43 -0800 (PST)
Received: (nullmailer pid 151858 invoked by uid 1000);
        Sun, 08 Jan 2023 18:08:40 -0000
Date:   Sun, 8 Jan 2023 12:08:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: qcom,camcc-sm8250: extend clocks and
 power domains
Message-ID: <167320131871.151783.4587146709277238289.robh@kernel.org>
References: <20221224214404.18280-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221224214404.18280-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 24 Dec 2022 22:44:04 +0100, Krzysztof Kozlowski wrote:
> Add clocks and properties (power-domains, required-opps) already used in
> SM8250 DTS:
> 
>   sm8250-hdk.dtb: clock-controller@ad00000: clocks: [[46, 10], [44, 0], [44, 1], [45]] is too long
>   sm8250-hdk.dtb: clock-controller@ad00000: clock-names:0: 'bi_tcxo' was expected
>   sm8250-hdk.dtb: clock-controller@ad00000: 'power-domains', 'required-opps' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/clock/qcom,camcc-sm8250.yaml     | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
