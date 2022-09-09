Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C9A5B3E91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiIISIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiIISIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:08:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0FAEB2FD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:08:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 83FDECE240A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 18:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26174C433D7;
        Fri,  9 Sep 2022 18:08:03 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     james.morse@arm.com, will@kernel.org,
        Liu Song <liusong@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: spectre: increase parameters that can be used to turn off bhb mitigation individually
Date:   Fri,  9 Sep 2022 19:08:01 +0100
Message-Id: <166274687150.1011948.15499044427739964990.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1661514050-22263-1-git-send-email-liusong@linux.alibaba.com>
References: <1661514050-22263-1-git-send-email-liusong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 19:40:50 +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> In our environment, it was found that the mitigation BHB has a great
> impact on the benchmark performance. For example, in the lmbench test,
> the "process fork && exit" test performance drops by 20%.
> So it is necessary to have the ability to turn off the mitigation
> individually through cmdline, thus avoiding having to compile the
> kernel by adjusting the config.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: spectre: increase parameters that can be used to turn off bhb mitigation individually
      https://git.kernel.org/arm64/c/877ace9eab7d

-- 
Catalin

