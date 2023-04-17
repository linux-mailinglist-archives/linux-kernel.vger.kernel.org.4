Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524406E4C50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjDQPDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjDQPDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:03:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087BF86B8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8152862523
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63776C433D2;
        Mon, 17 Apr 2023 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681743790;
        bh=SPowuaH4kDg56XhhrdUJCm9J7cpCLWj1gVcG5OvC6VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=akwHn71tvkQTubB94jj3Aoio+N9pIMuCBYiPk5CCZ0K2hfGlSVElhxSzhOx+3R+Py
         UKP5qIAUqd9VsfxvfeRgoZfQmdakL1H6vGQWAkZ1mH9DaY8PfJ6f15SQu1OBTzEWbE
         7tUDUVttmWnM9OWmlNi6xFpBiXXw3ezvJnFJEFbCixmV4mO7vBcD3HMQF4Lo98bCdU
         LXbZxOeQQIydlrf9c3NBzbrAu7PS3B6+omMgGkRBG4Q7vnBsOz2wGzeeY/x8vx37aj
         g8BuoUD+yK+0s2F52i04Mp8r8NDa0Da9dP6XaArP8+6VuqcRvOwRuxVoPwdJM895af
         IWm5C+uaw9Dfg==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH v5] arm64/sysreg: Convert HFGITR_EL2 to automatic generation
Date:   Mon, 17 Apr 2023 16:03:02 +0100
Message-Id: <168173287047.3661649.9384527225958097521.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230306-arm64-fgt-reg-gen-v5-1-516a89cb50f6@kernel.org>
References: <20230306-arm64-fgt-reg-gen-v5-1-516a89cb50f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 17:26:43 +0100, Mark Brown wrote:
> Automatically generate the Hypervisor Fine-Grained Instruction Trap
> Register as per DDI0601 2023-03, currently we only have a definition for
> the register name not any of the contents.  No functional change.
> 
> 

Applied to arm64 (for-next/sysreg), thanks!

[1/1] arm64/sysreg: Convert HFGITR_EL2 to automatic generation
      https://git.kernel.org/arm64/c/bbd329fe723d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
