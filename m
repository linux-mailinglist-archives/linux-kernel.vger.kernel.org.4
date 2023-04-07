Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85066DB3A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjDGSwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjDGSvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:51:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C386FF04;
        Fri,  7 Apr 2023 11:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C8D46129D;
        Fri,  7 Apr 2023 18:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6465C433D2;
        Fri,  7 Apr 2023 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680893346;
        bh=IOQYXzc1Q0IZQ0HMwVrbGboM3njryjbjWR2+LHfLNis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VO5kLW3mLApfkExtOa1Z69NFmfuUsUkQ79RrAmAPfDLw3dJCg8TMOu2YDQLD26HGc
         KTpT7cXNxdFxuf4D7UF9BU2oId21azj/SVVvfaVTf9kE+09h2vmEj/qucHJyl3Ckqy
         wpjQBjrg344l1MBMzJJE2664Z8ETI3LxIuT+02T2t4O1nKaTD0beUE75MtN3+6fO91
         b5bF7/ALtAh+G7ZZJ+B2gDZq/VUqHHWp3V+Wehe9ByDitbJJt5oDI8CkerE8cdJdpM
         OL/1/GIqg8S+X9u3DARWanax/rAwQc3TNI4zxAbRx5VCVgCCjwXbw2Ttx7UZRZPzRc
         2LxX8WPRq2STA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/3] arm64: dts: qcom: Split elish dts into common dtsi and elish-boe dts
Date:   Fri,  7 Apr 2023 11:51:54 -0700
Message-Id: <168089350725.2675207.9177780643341397781.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323005925.23179-1-lujianhua000@gmail.com>
References: <20230323005925.23179-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 08:59:23 +0800, Jianhua Lu wrote:
> There are two panel variants of xiaomi-elish, BOE and CSOT panels.
> In order to support both panels, so split elish dts into common dtsi
> and elish-boe dts.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: Split elish dts into common dtsi and elish-boe dts
      commit: 68434024dae509455bdd2a9e321a2cf58a6d0a75
[2/3] arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel
      commit: 51c4c2bd6f314de8b1bb7b5c949d2432be19d419
[3/3] arm64: dts: qcom: sm8250-xiaomi-elish-csot: Add Xiaomi Mi Pad 5 Pro CSOT variant
      commit: 8a786036c7b682c4d77abf7f396b87bc7eec98f9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
