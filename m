Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E906DB1E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjDGRjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjDGRjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:39:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D85C15E;
        Fri,  7 Apr 2023 10:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5464165332;
        Fri,  7 Apr 2023 17:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AADC43327;
        Fri,  7 Apr 2023 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889121;
        bh=bFFPH1Ienkhp59MfIC09xWJaXKkkxnsYDHZaBe7OHZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6wu+oeR2suL5F0BghTxW8iFqLL2IufUkNVr7QSPcEZHdLtJLFPAJOZjyJdIfE2OT
         rPSiPx8KsYfZ0dmy30uSSwXpyuoqbpfLJFs7FpjBmwCDHe3EjDTqH7+cJSVQkhfHyL
         Ckgu9z5oa9fHxhm5ySz/TK3xpz7Vnmlp1xC2IO7HWJaRnn1OM1hkdLVRBlTD1nkyMy
         +YZ/mcDIXEvmLmwa3bD6iYLmOo2yXz+uf43kVjDE+Q1NZf2tFZM8tG0AyLuZTh9z5A
         xwFOy5KeENs4oLieYCRYq7CCBbu0TsltwEoyhs3K3QMpo37UsNwZd/LvJK2f+wyyfr
         lcqtD7VLUm8ag==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, Tushar Nimkar <quic_tnimkar@quicinc.com>
Cc:     quic_mkshah@quicinc.com, abel.vesa@linaro.org,
        quic_lsrao@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Support RSC v3 minor versions
Date:   Fri,  7 Apr 2023 10:41:18 -0700
Message-Id: <168088927578.2561591.6035959847493913436.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406115732.9293-1-quic_tnimkar@quicinc.com>
References: <20230406115732.9293-1-quic_tnimkar@quicinc.com>
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

On Thu, 6 Apr 2023 17:27:32 +0530, Tushar Nimkar wrote:
> RSC v3 register offsets are same for all minor versions of v3. Fix a
> minor version check to pick correct offsets for all v3 minor versions.
> 
> 

Applied, thanks!

[1/1] soc: qcom: rpmh-rsc: Support RSC v3 minor versions
      commit: 88704a0cd71909c3107561261412a5d5beb23358

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
