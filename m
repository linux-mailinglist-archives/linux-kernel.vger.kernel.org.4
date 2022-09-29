Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E274D5EFC5F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiI2RyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiI2RyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:54:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A973915310C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:54:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B60D3B82620
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA7CC433C1;
        Thu, 29 Sep 2022 17:53:55 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, suzuki.poulose@arm.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        leo.yan@linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
Subject: Re: [PATCH v2 0/1] arm64: defconfig: Add Coresight as module
Date:   Thu, 29 Sep 2022 18:53:52 +0100
Message-Id: <166447402870.3004033.10480653257215180133.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220922142400.478815-1-james.clark@arm.com>
References: <20220922142400.478815-1-james.clark@arm.com>
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

On Thu, 22 Sep 2022 15:23:59 +0100, James Clark wrote:
> I'm still leaving out CONFIG_CORESIGHT_SOURCE_ETM4X because it depends
> on the outcome of the investigation into CONFIG_PID_IN_CONTEXTIDR, but
> I think we should enable these ones for now and start getting some of
> the benefits sooner.
> 
> Changes since v1:
> 
> [...]

Applied to arm64 (for-next/defconfig), thanks!

[1/1] arm64: defconfig: Add Coresight as module
      https://git.kernel.org/arm64/c/d56f66d2bd4a

-- 
Catalin

