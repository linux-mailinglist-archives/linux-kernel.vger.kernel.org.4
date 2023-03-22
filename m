Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F7A6C4E38
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCVOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjCVOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8727067710;
        Wed, 22 Mar 2023 07:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D4678CE1DD2;
        Wed, 22 Mar 2023 14:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F061BC4339B;
        Wed, 22 Mar 2023 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496139;
        bh=YF/j7IwVdKdC9HkKg3n8Fx/F+jk79cGadPGPjgRcSSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXy3GxCoJA9s2IWcSpyvr+oWqEhvwittAqHJFAi2QJyg7aaM9SCf1Ys6y94OPkBCm
         ZZjr1JJCH/69XpfL0YjQkOhSCZPZKUEnE+cvmoTxq+CzDD/PzymRo6FH1E0OWUN0hN
         h8Wz33L0rytfFNafJHG//4U091Dz3HWL9M9V/yFBLkHlsacRFizG44Wm0EMHHZ6DGs
         TN13vl19VBDX48Y/kbQ5m9T5AZjOdemYxTj5gB3i+pXAFKnoM8c59ymoEJHz/IHqVV
         scaqZ7BfurrN0C6FiZvMuly/0s8JiQtmAUgr0+c0eewSeK2Cs1UAJxfCnf1AKeGggS
         YTpBvBDQ/r/1Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     marijn.suijten@somainline.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom_scm: Add SM6375 compatible
Date:   Wed, 22 Mar 2023 07:45:10 -0700
Message-Id: <167949631653.1081726.2312754965106074231.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307012247.3655547-1-konrad.dybcio@linaro.org>
References: <20230307012247.3655547-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 02:22:47 +0100, Konrad Dybcio wrote:
> While it was introduced in bindings, requiring a core clock, and added
> into the DT, this compatible was apparently forgotten about on the driver
> side of things. Fix it.
> 
> 

Applied, thanks!

[1/1] firmware: qcom_scm: Add SM6375 compatible
      commit: fb1eb0b5dcf6f214479e853ee466958190785ab4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
