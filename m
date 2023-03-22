Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D852B6C4E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjCVOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjCVOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B465C7A;
        Wed, 22 Mar 2023 07:42:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94BC3B81D1D;
        Wed, 22 Mar 2023 14:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE318C4339C;
        Wed, 22 Mar 2023 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496144;
        bh=mBK8wNWGKce9mK40qvn/97+waN6jhT3Mg7iueJUX3t4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vLjC3SPaHERNh7Z+7kgN2jqxCYlpR/OzizMJUEKmQm7eyUOIB/4cbi73RdSscVR+N
         H3dSCleqyN2PdYdI7CbSr3DLWFHciXhlfjgNAIwheYbhwtBm5D1XrPrn0kKGeEQlxp
         P/5O5rQ1T7XUL3Gc6Y/Ot+f/4ZeE3EHvLj8TmRtvb0Yos+Ww/xR0qUCRJciTbquehL
         xUWX/Y4mjm34gYUAHlKDZfsBEbKP0MEy9tX9zrfI8Bbj6SEDNWahqw7kLw4HYqPfoW
         ml1r5kpFK2KropqIiaf4AbS6a3J36AEKQpvQb6M3GIkCjNZi3H4D6f5uiI3pK4IWub
         LHFfd0NjrqhhQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] arm64: defconfig: enable Qualcomm pin controller drivers
Date:   Wed, 22 Mar 2023 07:45:16 -0700
Message-Id: <167949631651.1081726.15570181868744368727.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309155733.662043-1-krzysztof.kozlowski@linaro.org>
References: <20230309155733.662043-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 9 Mar 2023 16:57:33 +0100, Krzysztof Kozlowski wrote:
> Enable pin controller drivers for several Qualcomm SoCs, as they are
> necessary for basic system functionality:
>  - main Top Level Mode Multiplexer as built-in for QDU1000, SDM660,
>    SDM670, SM6125, SM6350 and SM6375.
>  - Low Power Audio (LPASS) TLMM as module for SC7280, SC8280XP, SM8450
>    and SM8550.
> 
> [...]

Applied, thanks!

[1/1] arm64: defconfig: enable Qualcomm pin controller drivers
      commit: c9ab590f54c75c6c6b6016bdfe9ffb3ac40a7ad2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
