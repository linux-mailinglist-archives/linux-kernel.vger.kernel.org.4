Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0586021BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiJRDHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJRDGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A7172FE0;
        Mon, 17 Oct 2022 20:06:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 626006136D;
        Tue, 18 Oct 2022 03:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B243C433D7;
        Tue, 18 Oct 2022 03:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062394;
        bh=iOv43FCPYN/nrr5Dp3iuqBcLumV/8nzh1nlks4pmEIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PV1HrCQwNjVEMn4CWAF2CLqvy8JtP/ALZcltY2IMEi4v8jR4+cBmnoYV7oHBppVmh
         tFfuocAo+eVxqknZ4NbuLwmR0TxEzMeCVV251mHU1NEjsagAoUGLa0dlT2NG2inxGA
         Lj4plowvBXbyaGKn2k7dSUFvOIjH19i86+MIkuCp/L/8cdtcCJZhEUP3QeRn1PVSLK
         SMr6bXg+iERNiueeQkHT0oV2RDDY4cDUuzABAaOgyE+0AvRsQktG5eLMpO/q2+97iu
         MPBlEszqwsbNTBNzM0HB6wBHYnnRpimZE59pLNtHorVyKnufdWJV1Vp09DQBu50rQT
         Bqj/Xc1XutEcQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, gustavoars@kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] soc: qcom: smd-rpm: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
Date:   Mon, 17 Oct 2022 22:05:16 -0500
Message-Id: <166606235837.3553294.13172997146200535471.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <YzIvNIyPhWaG2DTr@work>
References: <YzIvNIyPhWaG2DTr@work>
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

On Mon, 26 Sep 2022 18:01:08 -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: smd-rpm: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
      commit: 1e9dd807c609d1598fa56a1d65074a6eeb89f705

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
