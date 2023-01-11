Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3594266533B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjAKFTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAKFRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:17:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353D6E0DE;
        Tue, 10 Jan 2023 21:09:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFB9B61A36;
        Wed, 11 Jan 2023 05:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F389C433EF;
        Wed, 11 Jan 2023 05:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413783;
        bh=xcLFlHA7vQfa2Rvgo59cpOcPrumkxSTluJwR/rY7nQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MAjJOT53qPcNXVF92+Q4vzURYfFOX3lnCqjiOsTZSFIMrptsp9x1inP8UNrBuoczK
         y4aY4hg2xTYEZ802XkCG+NFGdliXbf4bj+raJMVtcdHej3RfKXg9liBlgtHb3jpfpH
         IFI5xolbNBF82SlTbzYZGwmmRI7MPpf85vjsaCkm6xZQPDfkKjkOzn9c9C8l7HEssM
         JKLzh/WoQhNXi0Os+fV6dyM2TcS+nXwN8qxJ68Nke56FTLqjp+L2x1BZ9RbPMkkONe
         tHVv4NtSCAYd1/dXO+me5s6SAtgZG5nGXfanRiWED4nzQkQwbZbNPEeYM6dH1qj2V0
         i9jA7iqcOSEMQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Brian Masney <bmasney@redhat.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: defconfig: enable crypto userspace API
Date:   Tue, 10 Jan 2023 23:09:06 -0600
Message-Id: <167341377729.2246479.7785660372337180630.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221214174607.2948497-1-bmasney@redhat.com>
References: <20221214174607.2948497-1-bmasney@redhat.com>
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

On Wed, 14 Dec 2022 12:46:07 -0500, Brian Masney wrote:
> Enable CONFIG_CRYPTO_USER so that libkcapi can be used. This was tested
> using kcapi-rng on a Qualcomm SA8540p automotive development board.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: enable crypto userspace API
      commit: a251655f1b6a88551f134daea4cdefbd35e225c3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
