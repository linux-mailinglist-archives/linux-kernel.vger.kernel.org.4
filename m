Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2406BC11E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjCOXcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjCOXc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4641F2ED6F;
        Wed, 15 Mar 2023 16:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9958761EAE;
        Wed, 15 Mar 2023 23:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350BCC4339C;
        Wed, 15 Mar 2023 23:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923141;
        bh=95QohC5HZZa7/gRCWlqQ5Hmlrk86RQ41dEtKTxfBfx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tjgcDP7TIlONIBpX9a9yauWm/l6DvxIUqKBnoO1mxt1oMB3lf1xm4J+2W9BRo+L3t
         OTsqYQQ9K8jDY+xodlZ982wvuzRum+Vly0RlkPhdhatst9JweEp8IHf20QhmY3ngq3
         orEswS67Qb2NnLuETSQJWl8qobpCyoz2eimTGwwFkHiLCp/VjoiERZ1bZJqIVF1FPI
         n69m7j4SYn6RneQCpUfJnZ8SpEvsJbbZKGm2yZKzkLJCMNT9LUtsQvRtgRKKcnMFW9
         awcauU6DRInqfSxbmLYXfdYvDzUxc5MPKY1P0bHnRlsXxo1ybfVTS8f+EkYtgmUUaq
         MLv1P5ZTl6Y8A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     sboyd@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Danila Tikhonov <danila@jiaxyga.com>, mturquette@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/2] clk: qcom: Add GCC support for SM7150
Date:   Wed, 15 Mar 2023 16:34:50 -0700
Message-Id: <167892332565.4030021.4505402734060998642.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230213165318.127160-1-danila@jiaxyga.com>
References: <20230213165318.127160-1-danila@jiaxyga.com>
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

On Mon, 13 Feb 2023 19:53:16 +0300, Danila Tikhonov wrote:
> Add the Global Clock Controller for SM7150.
> 
> Changes in v4:
> - Keep the critical clocks always-ON
> - Added Krzysztof Reviewed-by on patch 1
> 
> Changes in v3:
> - Dropped entire property, it's coming from gcc.yaml
> - Included original work copyrights
> - Link to v2: https://lore.kernel.org/linux-clk/20230122192924.119636-1-danila@jiaxyga.com/
> 
> [...]

Applied, thanks!

[2/2] clk: qcom: Add Global Clock Controller (GCC) driver for SM7150
      commit: a808d58ddf29c5d593da497053bcb2af1696031b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
