Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4128E61E94D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiKGDOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiKGDNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:13:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0051511C1D;
        Sun,  6 Nov 2022 19:13:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F566B80D8E;
        Mon,  7 Nov 2022 03:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BF0C433C1;
        Mon,  7 Nov 2022 03:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790785;
        bh=3mEwzCwgosBBIlSpvycu5fwB0sXss+tK+aeYmxTn28s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R6CQQwZhydI8LC5dso0QvhwyH55XUPUBinhh8FZ0ASAMG09n1qxFYGHghRgH5zEQu
         TVXHRidGp7y0Fiafj9PQfbO7pFPIKOY5b06xLt8SMVXYctMFLCNNoNuPW4YJY8vfx1
         ikT3YdYnZc+lNrM/qmjUNtU9rD9LJrttlCp/e7nOrNXYZRBMuYB91cCfftnloS+v8y
         WIWLn/mMh0MJPofO4YcILW0geBBhkmlny2e5zbcrdRPQ+wNtle0/7o+nrzEglEZ/V3
         inwluB+kH8//SdVLYfXhJUkTHVAG9JZNGZVKIOjPc36rcLht/czC+KrP3jQKoPROCI
         JlH8R8XTAciZg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, luca.weiss@fairphone.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht, evgreen@chromium.org,
        konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
        vnkgutta@codeaurora.org, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] soc: qcom: llcc: make irq truly optional
Date:   Sun,  6 Nov 2022 21:12:23 -0600
Message-Id: <166779074269.500303.16334557002713010360.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221104153041.412020-1-luca.weiss@fairphone.com>
References: <20221104153041.412020-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 16:30:41 +0100, Luca Weiss wrote:
> The function platform_get_irq prints an error message into the kernel
> log when the irq isn't found.
> 
> Since the interrupt is actually optional and not provided by some SoCs,
> use platform_get_irq_optional which does not print an error message.
> 
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: llcc: make irq truly optional
      commit: c882c899ead3545102a4d71b5fbe73b9e4bc2657

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
