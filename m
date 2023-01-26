Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD63567D4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjAZSt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjAZStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:49:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A72125A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:49:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79BB3B81ED4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765CDC433EF;
        Thu, 26 Jan 2023 18:49:19 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prathu Baronia <prathubaronia2011@gmail.com>
Subject: Re: [PATCH] arm64: el2_setup.h: fix spelling typo in comments
Date:   Thu, 26 Jan 2023 18:49:17 +0000
Message-Id: <167475894593.1012628.8131945200635769548.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123110639.10473-1-prathubaronia2011@gmail.com>
References: <20230123110639.10473-1-prathubaronia2011@gmail.com>
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

On Mon, 23 Jan 2023 16:36:38 +0530, Prathu Baronia wrote:
> - "evailable" -> "available"
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: el2_setup.h: fix spelling typo in comments
      https://git.kernel.org/arm64/c/bb457bddee41

-- 
Catalin

