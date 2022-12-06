Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD827644B3B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiLFSUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLFSTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D269BB4B3;
        Tue,  6 Dec 2022 10:19:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8892BB81B1F;
        Tue,  6 Dec 2022 18:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7CFC4347C;
        Tue,  6 Dec 2022 18:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350790;
        bh=mCVbbzQMKd8wwgl5es1PASYdCo9ZtjtYGz4AiK0At70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSeLjUOkcdVhl2+IEq0VS8Zs5v2dGgYueNuuD74GLVreJ8XPMw8NwwcqV8DpRX05g
         jaNWEVU+C2RrjuQY3jx29ZRDmowFEieYfmNOOe4u1vzIFJg54vyY/e3HnqcJO3sY1b
         gDjF9Te7OxmcOHNseEbsW9Utw5lSt1TxjffVFQDXuUzKiwNlfxGDldg+dmhhk52qB8
         cS6DYoXSgxs5STYbtt7DEuu/M+vLvZQixuIPnxC0j2RQofApokTFs7BlSOdj28/Pw3
         jlkvJ8Z86cozOPxj87Qj0lF8wmvcVrofZzXeBqaha4SxcqIEAJ5JQqCNOCSGcVqeVO
         pMO/XsPCyijTw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ecs.taipeikernel@gmail.com, LKML <linux-kernel@vger.kernel.org>
Cc:     robh+dt@kernel.org, Doug Anderson <dianders@chromium.org>,
        moragues@google.com, krzysztof.kozlowski+dt@linaro.org,
        hunge@google.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, abner.yen@ecs.com.tw,
        Andy Gross <agross@kernel.org>, gavin.lee@ecs.com.tw,
        konrad.dybcio@linaro.org, mka@google.com,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: (subset) [PATCH v15 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Tue,  6 Dec 2022 12:18:54 -0600
Message-Id: <167035076356.3155086.5676138491367395561.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221205133603.v15.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
References: <20221205133603.v15.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 13:36:14 +0800, Owen Yang wrote:
> Add entries in the device tree binding for sc7280-zombie.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sc7280: Add DT for sc7280-herobrine-zombie
      commit: 300848e05da03aa6c0ee2c353bba4b8623991cce

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
