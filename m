Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBB55BFE32
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiIUMrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIUMrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:47:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0869E8E991
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:47:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04F14B82F71
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8E1C433D6;
        Wed, 21 Sep 2022 12:47:13 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>, will@kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable memory hotplug and hotremove config
Date:   Wed, 21 Sep 2022 13:47:11 +0100
Message-Id: <166376440307.3544597.14696655839071628170.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220629093524.34801-1-wangkefeng.wang@huawei.com>
References: <20220629093524.34801-1-wangkefeng.wang@huawei.com>
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

On Wed, 29 Jun 2022 17:35:24 +0800, Kefeng Wang wrote:
> Let's enable ACPI_HMAT, ACPI_HOTPLUG_MEMORY, MEMORY_HOTPLUG
> and MEMORY_HOTREMOVE for more test coverage, also there are
> useful for heterogeneous memory scene.
> 
> 

Applied to arm64 (for-next/defconfig), thanks!

[1/1] arm64: defconfig: Enable memory hotplug and hotremove config
      https://git.kernel.org/arm64/c/31dbadcc2828

-- 
Catalin

