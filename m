Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EAE6BC11F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjCOXc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjCOXca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C34265120;
        Wed, 15 Mar 2023 16:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7113261EAD;
        Wed, 15 Mar 2023 23:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E43C433A1;
        Wed, 15 Mar 2023 23:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923141;
        bh=i0UilE12A9MFVC7jZjPk0heaEPqfcpzRLVhYdxCRTXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWWtRiqD1cI0ZfbylVCTK+XwC5zF+9sXwsuQD/hAvQLtAJVrCq2mwAWeW10uSZ8+U
         9OLWrcF3OIWDWQR0yl0L3z806wU4LoC5+IvRdzp16ViMgSZenzttxqUO1aereoxOyp
         NdD8NP6Gp9WOAWwNapJ9SWKzj4j3puYxaRzMR7NVuRLI5W7oa0m25seslA2TgHAYfX
         Gg8kkOVYo/dB2tOtv8Bh5YCx0ag4FX23QXnNh/Qg6sbJUfkdqqRzQPfOzga/U5VbJm
         JAlg6XXBVL/BCMDv4lPJ8SSaCgBHqkKu6X8QLLVCSx/4LAGe9rVPLWMou8Y2h6UExz
         O8/0PcZ99HNvA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] firmware: qcom: scm: fix bogus irq error at probe
Date:   Wed, 15 Mar 2023 16:34:51 -0700
Message-Id: <167892332562.4030021.518248630017093396.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309111209.31606-1-johan+linaro@kernel.org>
References: <20230309111209.31606-1-johan+linaro@kernel.org>
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

On Thu, 9 Mar 2023 12:12:09 +0100, Johan Hovold wrote:
> A recent commit added support for an optional interrupt which is only
> available on some platforms.
> 
> Stop spamming the logs with bogus error messages on platforms that do
> not use this new optional resource:
> 
> 	qcom_scm firmware:scm: error -ENXIO: IRQ index 0 not found
> 
> [...]

Applied, thanks!

[1/1] firmware: qcom: scm: fix bogus irq error at probe
      commit: f3d0fbad6765da25de7ecf6481af9b6ddb0b3793

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
