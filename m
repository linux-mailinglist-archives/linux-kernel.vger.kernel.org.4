Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187AB696B83
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjBNR2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjBNR2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:28:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C51B9;
        Tue, 14 Feb 2023 09:28:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EDDFB81E52;
        Tue, 14 Feb 2023 17:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65457C433D2;
        Tue, 14 Feb 2023 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676395699;
        bh=WsygXz6hKASDW3Ap1NIU8e4tgT2emY5wCqe3iy7hUsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYn6KlmaqNTFsnLmqBfbjk6SnOVp549jQskpDnVfTqkExTZG/rFFIiVyc3kmPY7iU
         nm1ADmEbsZWG73dki3u4oGvK8nip/1RHE+uQWNfebEXvbfe7U96smY1gJlfq9yKFFU
         C0PpBJ2wLF2DPtvtzKKTevSt1VZQjH8xqui3Kn2gPJT4uwVr9tPqEHnTisvxO7x+ul
         Os8/+wM+nyQmSjfYB1UjBmdlDs3tbBFxsuJxtydFhEhqfRbQ66j76kRhCGpQ5oHKXS
         ffe86ZDuFceQDYrwevao5050e/3yHaFQ0RQPvc6TeFJikEPs7MVmcsnH7PBy/ebufy
         PxprJYh2NXeCQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     bjorn.andersson@linaro.org, quic_sibis@quicinc.com,
        Yogesh Lal <quic_ylal@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH V3] remoteproc: qcom: pas: Adjust the phys addr wrt the mem region
Date:   Tue, 14 Feb 2023 09:30:19 -0800
Message-Id: <167639581473.996065.8150646315410727656.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <1667409129-6254-1-git-send-email-quic_ylal@quicinc.com>
References: <1667409129-6254-1-git-send-email-quic_ylal@quicinc.com>
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

On Wed, 2 Nov 2022 22:42:09 +0530, Yogesh Lal wrote:
> The minidump table in the toc contains physical addresses that may lie
> before the physical address of the first elf segment in relocatable
> images. This change adds a custom dump function for minidumps which
> calculates the offset into the carveout region using the start of
> the physical address instead of the start of the first elf segment.
> 
> 
> [...]

Applied, thanks!

[1/1] remoteproc: qcom: pas: Adjust the phys addr wrt the mem region
      commit: a376c10d45a8e6ee5ea55791193f90625b35e156

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
