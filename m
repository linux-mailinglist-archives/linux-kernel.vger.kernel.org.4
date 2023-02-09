Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4168FF05
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjBIEcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjBIEbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09993BDB2;
        Wed,  8 Feb 2023 20:31:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0484B82010;
        Thu,  9 Feb 2023 04:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88446C4339B;
        Thu,  9 Feb 2023 04:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916522;
        bh=p5VVj10S5orhNpUZIUZG0+Gb/fuq/M0x8vaoEkwoOT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnZxjr8jRJJn2tO7y2d2HfSi2SuLIO5DCyIiQeaWSRoIXvClXgvIZGIeO0YEVyauJ
         VBzF2yepyOn7AXEI0ghrV0hVnjtsw1U6Lzhd/6yUH+AbNl1F0ubcOqHS0bWHVry/bS
         rCMczBX7lq02x1vui0xtWaMcktBVltAeFUdAMESAjG9S1pEWmL6d8LzgWOk+PVx2lw
         D8kvkACOj+VWuchbEbS0z8f8sNS3HpVwI+lCz5R2sXEJKf2ZOVNKYMTVTxaBgdCe8F
         wG5oFl2057Epz0MzJEXpJhcgSblitkUaxhcb7hLVcSSaDzb3c62ED2M8kDrAOYH9yp
         mRtU0PA4aIfog==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v4 1/2] dt-bindings: arm: qcom: Add Xiaomi Mi Pad 5 Pro (xiaomi-elish)
Date:   Wed,  8 Feb 2023 20:23:18 -0800
Message-Id: <167591660369.1230100.756923498094436262.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230131123515.833-1-lujianhua000@gmail.com>
References: <20230131123515.833-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 20:35:14 +0800, Jianhua Lu wrote:
> Add a compatible for Xiaomi Mi Pad 5 Pro.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sm8250: Add device tree for Xiaomi Mi Pad 5 Pro
      commit: a41b617530bf07e584b18b4ec390d0e39d95c796

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
