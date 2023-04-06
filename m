Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928D96D9CB8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbjDFPwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238983AbjDFPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D2293F4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15E5F62C83
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32519C433D2;
        Thu,  6 Apr 2023 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680796317;
        bh=VuFsn13TpSEkmuU0IEVPttGivSLCIMKCcDkIVckJMcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mY4r0DjM1Xbrf07EbmuCXDo5pzLXubFVY/z3w+arDRMYwcl9jrMmCG7qjPWOlS0/u
         OB9yHfeKIzv0sTlxomhLE1RHqlYQKgSqS4nqeopG50a3AGw1m1Ex376ZYtUsFRdaZ3
         6P3KwKiaEsE4zF5RR21P8s2iTISvIHRpDHFudWKrFhOWBL6acA4Dp5OE2hCdLyQBxz
         FkmjeiV20Sr/U6kvGmPOzscJ+05p1Se26Iro6k6Kaq9NLxi8YSFhCZBgQGyN9CJ295
         waK8WPIcabhlbuJUgKCADcJ14jI1sjYoA6jbPEd2SvLgvvTUZ97GOBJqdfut96cO6Z
         6w69ESeEjaaXA==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Update ID_AA64PFR1_EL1 for DDI0601 2022-12
Date:   Thu,  6 Apr 2023 16:51:47 +0100
Message-Id: <168079274923.333708.3020938769780768778.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230308-arm64-aa64pfr1-2022-12-v1-1-f03c1ea39611@kernel.org>
References: <20230308-arm64-aa64pfr1-2022-12-v1-1-f03c1ea39611@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2023 15:20:42 +0000, Mark Brown wrote:
> Version 2022-12 of DDI0601 has defined a number of new fields in
> previously RES0 space in ID_AA64PFR1_EL1, update our definition to
> include them.
> 
> No functional changes.
> 
> 
> [...]

Applied to arm64 (for-next/sysreg), thanks!

[1/1] arm64/sysreg: Update ID_AA64PFR1_EL1 for DDI0601 2022-12
      https://git.kernel.org/arm64/c/79260355593f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
