Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983D36BC151
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjCOXeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjCOXdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:33:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0CBA648A;
        Wed, 15 Mar 2023 16:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 923E0B81E8F;
        Wed, 15 Mar 2023 23:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE296C433A0;
        Wed, 15 Mar 2023 23:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923157;
        bh=dw1wSeVnThxCMyMXNr3qZpGWjJ0MmN16axRGaGa8oi8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HuWjewKt8UY5kxpfbKMy+AEeje5s+Q4r5F9pY4a4GQ2jGNoXKjaWJy1Hg2wuTCFdQ
         tVv/h2MvyIoJD9zxH9hfVHSQcW2lI3gtNiDhBv/pUkVjB1GIZNtJ0Ujmfs4YQ1T1jY
         n5vkD/RYo02dU+Bbn5uFuYnH9hxR64E816sOOI1QAfuKKzTZxEQWREwa47t/nHW0y0
         kwLPohGt8Pi6ZAB6BB2C6OFp3RGBqHe1JT/FNgCI2kTrRnIwGNmaCk8RON9igqKgzI
         R1q9V/0v3stMDfWJ2BSp71Hup5bMCwMbtS4fFx5dDbvmUDRs8IGKiqsD9HxGTVDjSC
         QGRqvyosvIRbA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] soc: qcom: restrict L2 accessors to ARM64 build tests
Date:   Wed, 15 Mar 2023 16:35:09 -0700
Message-Id: <167892332563.4030021.9883617927678726811.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230123202601.1296983-1-krzysztof.kozlowski@linaro.org>
References: <20230123202601.1296983-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 23 Jan 2023 21:26:01 +0100, Krzysztof Kozlowski wrote:
> The QCOM_KRYO_L2_ACCESSORS can be compile tested only on ARM64 because
> it references asm/sysreg.h present only on ARM64.  Mark the dependency
> correct, even though as a non-selectable option it does not have real
> effect.
> 
> 

Applied, thanks!

[1/1] soc: qcom: restrict L2 accessors to ARM64 build tests
      commit: 34bb2c1c1bb5d36487c1e7ff00dbf49bb91056e2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
