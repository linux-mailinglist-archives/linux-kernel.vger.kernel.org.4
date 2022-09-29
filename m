Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2190A5EFC6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiI2RzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiI2RzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:55:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA334E851
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:55:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 57418CE2338
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1B5C43470;
        Thu, 29 Sep 2022 17:55:05 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, ard.biesheuvel@linaro.org,
        will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: reloc_test: add __init/__exit annotations to module init/exit funcs
Date:   Thu, 29 Sep 2022 18:55:03 +0100
Message-Id: <166447408706.3004635.17987165163593299274.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220911034747.132098-1-xiujianfeng@huawei.com>
References: <20220911034747.132098-1-xiujianfeng@huawei.com>
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

On Sun, 11 Sep 2022 11:47:47 +0800, Xiu Jianfeng wrote:
> Add missing __init/__exit annotations to module init/exit funcs.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] ARM64: reloc_test: add __init/__exit annotations to module init/exit funcs
      https://git.kernel.org/arm64/c/8c6e3657be6b

-- 
Catalin

