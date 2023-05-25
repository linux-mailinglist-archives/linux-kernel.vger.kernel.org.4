Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA3471044E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbjEYEvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbjEYEvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729F3183;
        Wed, 24 May 2023 21:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B89A60E95;
        Thu, 25 May 2023 04:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90753C433A7;
        Thu, 25 May 2023 04:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990265;
        bh=uAo09zFgr0x/zTpqTK6MALKgebP9S1ckJK58Mg+Welg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7jEZ1hg5KP/vC0+uIBsb9u4lNSwrUBm9XdXiMJR/2+I4ENfP+WM9baOGcg8r+avY
         zoShbPYIlMe1SvE66H8N4PKoyGPHlQ539Ho66st8OXUsN3Z2MWtwLPi6TVRCYObO6e
         BL6K1ZBRZhQ8Qv8Lrwdr/4s/vPR4G6i+DrOn7sX7S0XJxy+0FOFw1ruTbsmXEfC37Z
         IR8EmTlqo3Cil9T5MLB8mear61SiiqHsL4WMj8SX2An2kAv4pTIkKxMXgK8lhT/ihg
         K06OJezKJ0uGOyKf8gcqwIduQuWZJSKiurbQGVHF6Fv4jewMw5i17ekqTwQhGWNnRp
         FPzghR2B86viQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        cros-qcom-dts-watchers@chromium.org,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-lite: Fix SDRAM freq for misidentified sc7180-lite boards
Date:   Wed, 24 May 2023 21:53:45 -0700
Message-Id: <168499048185.3998961.4415989565045380045.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515171929.1.Ic8dee2cb79ce39ffc04eab2a344dde47b2f9459f@changeid>
References: <20230515171929.1.Ic8dee2cb79ce39ffc04eab2a344dde47b2f9459f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 17:19:29 -0700, Douglas Anderson wrote:
> In general, the three SKUs of sc7180 (lite, normal, and pro) are
> handled dynamically.
> 
> The cpufreq table in sc7180.dtsi includes the superset of all CPU
> frequencies. The "qcom-cpufreq-hw" driver in Linux shows that we can
> dynamically detect which frequencies are actually available on the
> currently running CPU and then we can just enable those ones.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180-lite: Fix SDRAM freq for misidentified sc7180-lite boards
      commit: 3a735530c159b75e1402c08abe1ba4eb99a1f7a3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
