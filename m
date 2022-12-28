Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A5B6572CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiL1EjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiL1EhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E3E09C;
        Tue, 27 Dec 2022 20:37:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18ACA61306;
        Wed, 28 Dec 2022 04:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD66C433F0;
        Wed, 28 Dec 2022 04:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202234;
        bh=CCFzeeG33eVgAliB9idlkTZ7f0FHS45bRn+3My0mrJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jELf5eLDfba1SgeXJhQ9j6QFOhaEicJONjURc26mDClu21Bywj9fvHqxFxFlTkrEW
         9+CKqPeHCtF9IUHNc/BDawrM+3B2p5+cmOOAY/Xg8JdPiiN4t2MweEl/u+V96HXFHS
         RZDlUn9a47zaX2PL2p4bPVZ+5ojS7NSh3utVdhIBMcsNBhMxodjlp3UNU//7A9yK37
         oVnB0rCbYb68ScIykBsMuCzoiL093Nybh59nUrJm30yI8YbLq/uOcug/CCo+RXjDE9
         UKWRmaVFxi00hcpKS22V6L9o+6bN5X6DyS/UFoH/qX2sbYYnRk85QTed2KdRDhdGB1
         WPA0Rf/dawCgg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, agross@kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] ARM: dts: qcom: msm8974-castor: Fix touchscreen init
Date:   Tue, 27 Dec 2022 22:36:49 -0600
Message-Id: <167220221215.833009.13109652166354510953.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221121213019.324558-1-luca@z3ntu.xyz>
References: <20221121213019.324558-1-luca@z3ntu.xyz>
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

On Mon, 21 Nov 2022 22:30:19 +0100, Luca Weiss wrote:
> On some devices a higher delay is needed, otherwise touchscreen probe
> fails.
> 
> 

Applied, thanks!

[1/2] ARM: dts: qcom: msm8974-castor: Fix touchscreen init
      commit: 73bf63a6300b2fec48b54fe41d1c6d964fb2f33b
[2/2] ARM: dts: qcom: msm8974-castor: Enable charging over USB
      commit: a28146b51a299897090f071ea26071a5ab39d233

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
