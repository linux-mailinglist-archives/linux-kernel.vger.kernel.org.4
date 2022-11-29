Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C937A63C97A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbiK2UlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbiK2UlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:41:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F0969ABF;
        Tue, 29 Nov 2022 12:41:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7671B818F6;
        Tue, 29 Nov 2022 20:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8D4C433D6;
        Tue, 29 Nov 2022 20:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669754477;
        bh=K/qBsbp0/BjS2c7vO/taj/9RoO4bN4ZoqYNajRSMNss=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pY3GfC9OgDOUrpwx/P2V2w0/9CDRCGgHSitWarZX6qh0zzknj63KnV29nWRflCz8M
         pApCgE+CfMz7fM4vZ0f4HhsZ9hbigeVPMf/zO7UGE1VOclrGXA+IO6c+FrEFyncDL7
         qN1uivxPnUuHlHqvoQ3cWMDnj5d1zZTntRLKiDn2o5uY6bjNzqVHVIrpIhf69u0M4c
         Z0AGmeZZOxIzKW1jULs3sitUvpC9Mfb5qIAS/ylHojRnEAQ427XqM9hZZ6dAX9KPuR
         bW0mVQ8TH9lAyQ6bQL08LkL0Xb5rLjnI55zt1UVoegMLE0iz5shdK5eY6rlQDGuGkH
         GjZEoRtpneKVA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221128122820.798610-4-abel.vesa@linaro.org>
References: <20221128122820.798610-1-abel.vesa@linaro.org> <20221128122820.798610-4-abel.vesa@linaro.org>
Subject: Re: [PATCH v3 3/9] clk: qcom: gdsc: Add configurable poll timeout
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 29 Nov 2022 12:41:13 -0800
User-Agent: alot/0.10
Message-Id: <20221129204117.4C8D4C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2022-11-28 04:28:14)
> Depending on the platform, the poll timeout delay might be different,
> so allow the platform specific drivers to specify their own values.

It's a timeout, why not just increase the timeout define? I don't think
we really care that some platforms have slower GDSCs, eventually they'll
toggle status.
