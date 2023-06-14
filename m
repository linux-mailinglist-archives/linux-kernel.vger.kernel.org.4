Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE673046A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245143AbjFNQAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245125AbjFNQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517DD2116;
        Wed, 14 Jun 2023 09:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF0A364420;
        Wed, 14 Jun 2023 16:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7068EC433CA;
        Wed, 14 Jun 2023 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686758420;
        bh=PaasvYHVBtNDQXi/Vm5Io2200abDXXvpk3T7lM0fGMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRSvyvL/Qta3abTszP7pREX7W8gkyDIPD1HwIEkwQjysNT+yCP4upPICaVNaG0eM9
         Ncm/wlAn2iBjyO9ATz3/5uyFAxVN/UW73drVJt8zfr1F/gzvowllrqs6puQR7jmttG
         ufGs+rDRo4gtp+pqu/WHMp6QK58g98nmiOLelDTR4IwsKaculwMCeieI84a9/C+Zcd
         q+K73bcR6Iw1xTh7+UJ9mHi4PsDmNqyIn9iSv3MT9XLepkf7GqgJYg/fAzSCbz4kko
         +nViSjqJvHg9NqXc6bYS8CVuFSQ0kUgJbbgfdkCTUm4TXFcxt53Ba1yJgN40XbAnAA
         umLVVD9HcxJRw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_vtanuku@quicinc.com, swboyd@chromium.org,
        dianders@chromium.org, quic_msavaliy@quicinc.com, mka@chromium.org
Subject: Re: [PATCH v2] soc: qcom: geni-se: Do not bother about enable/disable of interrupts in secondary sequencer
Date:   Wed, 14 Jun 2023 09:03:37 -0700
Message-Id: <168675861182.1453524.1002425552835112936.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1686742087-30731-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1686742087-30731-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 16:58:07 +0530, Vijaya Krishna Nivarthi wrote:
> The select_fifo/dma_mode() functions in geni driver enable/disable
> interrupts (secondary included) conditionally for non-uart modes, while
> uart is supposed to manage this internally.
> However, only uart uses secondary IRQs while spi, i2c do not care about
> these at all making their enablement (or disablement) totally unnecessary
> for these protos.
> Similarly, select_gpi_mode() also does disable s_irq and its useless again.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: geni-se: Do not bother about enable/disable of interrupts in secondary sequencer
      commit: 5d85ea2c879781d296bd770f562d33a58161d2b1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
