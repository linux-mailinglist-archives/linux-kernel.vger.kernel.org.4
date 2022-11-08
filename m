Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A506205DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiKHB2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiKHB1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:27:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3702AE06;
        Mon,  7 Nov 2022 17:27:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19F16611F4;
        Tue,  8 Nov 2022 01:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D24C43470;
        Tue,  8 Nov 2022 01:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870870;
        bh=1CbCDOwx8TyiZZRRmnn6553GaQyNQZGY9rDJldRB86s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXGaqBWrDvSitb5nhDOy3GMzs+FzhMvxpcmf+NhUZjbKI9xBFh+TFDbtjIrfoIZCl
         O3NHIHG2NEvak3ztdfgjhYHIcq12KItcaNAuWkJaEJ2BRFftji7C/Xpze5rCbSw8cM
         OELy9ZvO3GChucj1lOUp+Jfdb7BX4UNE2AnRL3/SD3O27D15LiS8BMUP5lKMWQqJqv
         l6MUg7RK/++F5bdO/72bjl0L9ZwGbnISYxuYTwRrl7kUYj8DqLQX09E2vIyV/OpZL5
         tamumvGJal85RdNgxZlHFxOc2WrjtzrZoqmdCWE+cUuc93WKRgp+m8WMCoa27IMfbX
         Nb1pdUN9T147A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org
Cc:     konrad.dybcio@somainline.org, patches@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update Konrad Dybcio's email address
Date:   Mon,  7 Nov 2022 19:27:23 -0600
Message-Id: <166787084686.599230.680301375878562886.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221107092207.5832-1-konrad.dybcio@linaro.org>
References: <20221107092207.5832-1-konrad.dybcio@linaro.org>
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

On Mon, 7 Nov 2022 10:22:07 +0100, Konrad Dybcio wrote:
> Use my new Linaro address in place of my SoMainline one.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Update Konrad Dybcio's email address
      commit: d0ee86d3c0f0da1481cfab51a386fc22b00a0630

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
