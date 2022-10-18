Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53364602217
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiJRDKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiJRDIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:08:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BBF9AFA1;
        Mon, 17 Oct 2022 20:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06DEA61373;
        Tue, 18 Oct 2022 03:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3097C43146;
        Tue, 18 Oct 2022 03:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062423;
        bh=7mW64TaDE9nC2ztLTDtdEtKrec3eYyQNSLXJqDd1HR0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CZR31TxsTJad2nzGCCXVIuP5Mt1Q7EcWgI1R920F1IPJBvFDkuxTctZ1PhfrQOUFN
         C9/gI/b39m7u3TH7PBT5IWBz7c85IwR6gje1S263zbsfPBgyHzZnfUMBgozj7nJBhv
         fINl3DwEhU8rJmG/OzdX8NdGqEb/EY6Jw+vcda3NVqLc2SCWm/Y7ZjiYkdyn0wsH18
         +UobMbpvsFf0YQvaf+vOXyj20ag78PWWAorxj0hmR5DadxPAYgwmg9KBLonw7tWtlY
         hNIbt9DWMcZCdMAWMDnU2JSZZ2TBGg6V8xRAZMcuuyBOYBTexpkNeEE0VTg0Vw9zQb
         vIvn0pME02ALg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, linux@armlinux.org.uk,
        linux-arm-msm@vger.kernel.org, catalin.marinas@arm.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v2 1/2] ARM: qcom_defconfig: enable rest of ARMv7 SoCs pinctrl drivers
Date:   Mon, 17 Oct 2022 22:05:37 -0500
Message-Id: <166606235858.3553294.1160358701501210726.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220925112123.148897-1-krzysztof.kozlowski@linaro.org>
References: <20220925112123.148897-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 25 Sep 2022 13:21:22 +0200, Krzysztof Kozlowski wrote:
> Enable rest of ARMv7 SoCs pin controller drivers.
> 
> 

Applied, thanks!

[2/2] arm64: defconfig: enable rest of Qualcomm ARMv8 SoCs pinctrl drivers
      commit: d780386cd44a2f44c90abdb41487f4cdb8be7213

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
