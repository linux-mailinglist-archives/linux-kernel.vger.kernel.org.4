Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7562FE1B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbiKRTlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241676AbiKRTlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:41:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CA486A52;
        Fri, 18 Nov 2022 11:41:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFA2B62714;
        Fri, 18 Nov 2022 19:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC758C433D6;
        Fri, 18 Nov 2022 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668800465;
        bh=ZxBjBfDNN39LcAdfeJMuyPeXKjlCO7wv0AfCNAfuHfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7X7SrKH9uswDp7VJopT1zVp1xB1OqnMQYPT91URObWVrU+EktI+OPX9d/fpSBS80
         qcjw3eFEfNbmE4wUaxepWAN6ietCpr6+pswX0ujhAtSK0mH200U7yXv6GGTjHyZQqj
         zBfxHPboyQ8NhqttmGRy1SlsbgiKPEK40XgnmYmiI6086TeXD/CLzGrJOjphqVIXer
         Fy4Im27UGa+0kHcajVAr6yhYzRARF7ZfeCraVYpHR+O5wTmblUNlp7H0rV49gNzxzu
         xtXwZAGdZwUxkFzHlipKi0eXJaX4WmF0IllfSJYn7IkUHLX2u3iNbkmPTgMiQsa/cf
         7OZGE+TrQ1ppQ==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vsethi@nvidia.com, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, treding@nvidia.com, jonathanh@nvidia.com,
        ywan@nvidia.com
Subject: Re: [PATCH] perf: arm_cspmu: Fix build failure on x86_64
Date:   Fri, 18 Nov 2022 19:40:42 +0000
Message-Id: <166877831470.3584603.8252400743799504223.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116190455.55651-1-bwicaksono@nvidia.com>
References: <20221116190455.55651-1-bwicaksono@nvidia.com>
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

On Wed, 16 Nov 2022 13:04:55 -0600, Besar Wicaksono wrote:
> Building on x86_64 allmodconfig failed:
>   | drivers/perf/arm_cspmu/arm_cspmu.c:1114:29: error: implicit
>   |    declaration of function 'get_acpi_id_for_cpu'
> 
> get_acpi_id_for_cpu is a helper function from ARM64.
> Fix by adding ARM64 dependency.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_cspmu: Fix build failure on x86_64
      https://git.kernel.org/will/c/e72dbf9085b5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
