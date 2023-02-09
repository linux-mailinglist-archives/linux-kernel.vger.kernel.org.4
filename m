Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D068FF1E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBIEc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjBIEcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:32:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3133F2B4;
        Wed,  8 Feb 2023 20:31:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11D8FB82019;
        Thu,  9 Feb 2023 04:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD3EC433A8;
        Thu,  9 Feb 2023 04:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916527;
        bh=Dk9LU3lz3zg8TjdOVz99Ga2XcB9YAnHzJWtYVcJbL1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8vHB5JYQcnWnaF+LEK2o2LQx+kvGnra8bIL6v5VVf80bhjs2mO28zKdPskC3HnZX
         gdOusUnyh9myeFVtuh0feIycbxN3p0O4A1TESTvH36qgBcMl1sCLOj95T2YS2phEo6
         moeLQfbqhMfQl0eVNy5e/lETBiR/y2gFjrVxowKgasKAfAyU5L/bwIWJeEmS77BhrT
         Jt+NRbxsz82TxD7p1073ZuLliwHELGVgqcurUN8/1Z/CHZSmqKozl7IDlZdFpaz1lZ
         3mD1MA1N42KKAqYAy+yFLh4f82sX9qCK1UIJWbjeF6NCnguY/JZHxlcSb+0R4jhUbE
         m3LnG7aTOAcsw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Niklas Cassel <niklas.cassel@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Niklas Cassel <nks@flawful.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update qcom CPR maintainer entry
Date:   Wed,  8 Feb 2023 20:23:24 -0800
Message-Id: <167591660369.1230100.8849740773917373264.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123104305.44641-1-niklas.cassel@wdc.com>
References: <20230123104305.44641-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 11:43:05 +0100, Niklas Cassel wrote:
> From: Niklas Cassel <nks@flawful.org>
> 
> I do no longer have access to qcom CPR hardware, nor the documentation for
> said hardware.
> 
> Based on past and recent activity, I propose Bjorn and Konrad as the new
> qcom CPR maintainers.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: Update qcom CPR maintainer entry
      commit: eade820f7970c18af68591939038b4c3eb111205

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
