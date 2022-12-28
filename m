Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40CA657297
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiL1EhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiL1EhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4B2D2D2;
        Tue, 27 Dec 2022 20:37:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AAE561236;
        Wed, 28 Dec 2022 04:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B924C43392;
        Wed, 28 Dec 2022 04:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202219;
        bh=lZLSCCCJMNcQo8O0RU24sjGYh8FnhtI6CLWwO6/DqkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TB2X4xwqA/fpNDW5snNyGxfdIQk59vcjjHV926qZtCMY1HpP+tP97Fm9KPjeAo/mT
         cDTHplT2NBIP/mY2bararEUoto+ge9xk7J/V4PO2XFZpDYOnj/Y65D5zC1kSHPzVJ0
         C6aAT9MbZXUJqmmrs8jvuxg5yUGfJZpknzYTOMSczecHCK3l7TuVf4OwCy2NcpvLzP
         lISfe8aNnTk88FLhoUG91awxX2VzxRZIMA9PTLcosN6//dyD97YxCwk4m5sfwpDq42
         v8QKqXrPxCf5mk0VBW4bFB7jaDAbVjOwA2Ipl2v/CWu+MNZMMqtUNyE7eFV9akNsmJ
         /LFN0szEPIx9A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: move 'thermal-zones' node
Date:   Tue, 27 Dec 2022 22:36:33 -0600
Message-Id: <167220221239.833009.15082877460224492874.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221227170202.21618-1-johan+linaro@kernel.org>
References: <20221227170202.21618-1-johan+linaro@kernel.org>
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

On Tue, 27 Dec 2022 18:02:02 +0100, Johan Hovold wrote:
> Move the 'thermal-zones' node after the regulator nodes to restore the
> root-node sort order (alphabetically by node name).
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-x13s: move 'thermal-zones' node
      commit: 5e4cab734c26ec46fd847bedd31a0df83d853b04

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
