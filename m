Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D2360224F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiJRDMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJRDJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6D98C92;
        Mon, 17 Oct 2022 20:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0178B81C66;
        Tue, 18 Oct 2022 03:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA227C43144;
        Tue, 18 Oct 2022 03:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062447;
        bh=nKdryelpBqqrnPX/pUyUyU2dcmUqIiQ89JllZgZMnsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sEev8H9UT42Nfkc2+whXGOtfQ6mNSue56iNW2ikkuUnQ9C44pKAZPipw+8GRebkRz
         lqgNi/pVzRWXI00D35e+x8U1QamFC3gBeuzqE3PGXHa4D3RhCpQvrrLxXc6bcNEV+k
         Dq5Mdfg7gAAUV1Yxr+0pDOaFALW6ik0iLJJ5Eb7OepB+GwcISiu8pjbeNKaMhYhcsE
         1JqEv/Yuts/11+Hoe97t62+Kx9kE0MlfaPCSUw+JaB8CSPPSqqMpG136ISVtlQZ0vL
         gvjWoYtAYi6xJsa/A29xPN90DkUgNjpxMqldo3GqehIbdeXUuWCInsTCNoVEQ2sJzX
         LhPJHHtPH535g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, matti.lehtimaki@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v6 0/3] Initial Samsung Galaxy Tab 4 10.1 (SM-T530) support
Date:   Mon, 17 Oct 2022 22:06:00 -0500
Message-Id: <166606235859.3553294.14966707893063250841.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220927214940.244480-1-matti.lehtimaki@gmail.com>
References: <20220927214940.244480-1-matti.lehtimaki@gmail.com>
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

On Wed, 28 Sep 2022 00:49:36 +0300, Matti Lehtimäki wrote:
> Add device tree node for pm8226 GPIOs and support for the Samsung Galaxy
> Tab 4 10.1 (SM-T530) tablet which is based on apq8026.
> 
> Changes in v6:
>   - Set status as last property in nodes
>   - Pad register addresses to 8 hex digits
> 
> [...]

Applied, thanks!

[2/3] dt-bindings: arm: qcom: Document samsung,matisse-wifi device
      commit: 198f7b7cbb737ba7e7ac9c2ee744746b7faf9a9c
[3/3] ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 (SM-T530)
      commit: f15623bda1dcb37007b930496e2955cca12f30d8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
