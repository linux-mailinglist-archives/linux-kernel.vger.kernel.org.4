Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92AA602237
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiJRDL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiJRDJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D819AFAB;
        Mon, 17 Oct 2022 20:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40D83B81BDF;
        Tue, 18 Oct 2022 03:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FD8C433C1;
        Tue, 18 Oct 2022 03:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062438;
        bh=7EmnwgrulKXfc85L28oNtTlw3vj3nugBsWrOkSIwf/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cx4eUYmoFHbVyRBVzOkRb+h1DjZGmIqldPtWkIueuL9qZAlDUDBfeK9q9DnJHnl2f
         crbGBx7PKMcTjgKhCFLn/ZIW+9mLAB1nFc4IuF9urEgu8rFjDB8C838qSEhiZElkgl
         UC35CW1dwKeP8ZXHPw34yv4124NoEVY+8mgDGwo4jasYfItmVpOCmCpWNv2ah5S+pi
         ZJF0k6ZKP1TxzN8mlsd1jm30T/K/kFJtPAuq0oqgSmr6prb8i7m0YrKGJHsbeCENqo
         8INF2KQYWIwQB1t/1Zz8YooE5p+sj+qEaSzXlBDJ3HpP6OWWD+vc7rmX9FotQf73sO
         K0uJnHAunav0Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, robh+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH 1/5] dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing compatibles
Date:   Mon, 17 Oct 2022 22:05:50 -0500
Message-Id: <166606235862.3553294.12849281897845693153.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221016090035.565350-1-luca@z3ntu.xyz>
References: <20221016090035.565350-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2022 11:00:30 +0200, Luca Weiss wrote:
> Document the cpufreq-epss compatibles currently used in the tree, plus
> the sc7280 which will be added in a separate commit.
> 
> 

Applied, thanks!

[2/5] arm64: dts: qcom: sc7280: Fix cpufreq-epss compatible
      commit: 0cde1210f7b9f6f17f3af450bde598c0ad9d54cc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
