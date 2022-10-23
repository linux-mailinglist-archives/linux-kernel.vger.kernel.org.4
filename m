Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA004609383
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJWNQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJWNQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:16:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EBE4C61B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 06:15:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEC47B80D1A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E66C433C1;
        Sun, 23 Oct 2022 13:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666530923;
        bh=24jfiU/yrrKjZ3YEUChr/C7eW5BzB6SFfAFU8gr4+V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StrrYEG1k5RFh45/mjCDs+EfkMouzIaegoZeaFd8xKPuaa6PjuGEHd6v+uNnSO+4/
         1LxbxuROZtcOI4JME5sGalp5o/WH6/cveFl+zRzMsoucg1DsQJQwKbs8xqTQ3eDv7D
         DGP/fOdR9S6PBU8VF3jK9pT4RjF5JcjxhPoTd+5EdsHm6eHYGm7OLqZzDm03kSs9/S
         X4lTCmB2CpzqeoUySbup2pxkfanzRWhalrK14VoIq2rt87roi+9UpSqoq9v34MXW1i
         29UZ9dntrMQqpNTpS/U9o1tmuxmIAGCJKRrVgraWMs4zxTOPjc6SeQJEjFM1+lekmU
         llU4I9SFSjrqg==
Date:   Sun, 23 Oct 2022 21:15:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/8] arm64: defconfig: enable snvs lpgpr support
Message-ID: <20221023131515.GO125525@dragon>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
 <20220922162925.2368577-8-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922162925.2368577-8-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:29:24PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Enable SNVS LPGPR support. This may e.g. be used on the i.MX 8M Mini and
> Plus to store a form of boot counter.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks!
