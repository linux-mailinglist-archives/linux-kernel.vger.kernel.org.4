Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80C95BFE30
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIUMrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIUMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:47:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB698A1FD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD51E62625
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB59C433D6;
        Wed, 21 Sep 2022 12:47:05 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2] arm64: Enable docker support in defconfig
Date:   Wed, 21 Sep 2022 13:47:03 +0100
Message-Id: <166376440307.3544597.3478680468016452961.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220907110235.14708-1-vincenzo.frascino@arm.com>
References: <20220907110235.14708-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2022 12:02:35 +0100, Vincenzo Frascino wrote:
> The arm64 defconfig does not support the docker usecase.
> 
> Enable the missing configuration options.
> 
> The resulting .config was validated with [1].
> 
> ...
> 
> [...]

Applied to arm64 (for-next/defconfig), thanks!

[1/1] arm64: Enable docker support in defconfig
      https://git.kernel.org/arm64/c/e2c12540420d

-- 
Catalin

