Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9686572CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiL1EjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiL1Eh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107EE0B0;
        Tue, 27 Dec 2022 20:37:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 124DC61303;
        Wed, 28 Dec 2022 04:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4707C433F2;
        Wed, 28 Dec 2022 04:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202235;
        bh=WGBdAv/FRNReJ3jkgStLxZF1PkLdvHu9kYknAsOc9IA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lejBDr83fJY2jV1FeifxOHLNNALFp3cVZC3kK0+3nFJ54UQ2Y6HjqS/xtvm9ih/Et
         54szhZ1KzziJOulQ3Sc6jQJ6+N/zEBr3F0Wwk9hBtuwWoJf2/CxcKhVlW4u5CDWRPC
         7xAkoA1c7gcrgwMFOUZ2WVKeoNNpmCUxkNnbFeiz9Fyh+3DNiSXO1UwEScb38+SWLF
         /V1THvDFcKG1OsyvfgQUBlFrhMcL8zpD5AofzAq/IMicw32eULhVjm/DgajwmQrK1+
         Z3teFxLbuC8DyUXIorpV05rmU/VwP2EbfBjwbrvH+m7opKWI279oh6yyD5HRN7IouT
         j2AalB62g4xQg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/2] ARM: dts: msm8974: castor: Define pm8841 regulators
Date:   Tue, 27 Dec 2022 22:36:50 -0600
Message-Id: <167220221213.833009.17726643815381947935.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221121212226.321514-1-luca@z3ntu.xyz>
References: <20221121212226.321514-1-luca@z3ntu.xyz>
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

On Mon, 21 Nov 2022 22:22:25 +0100, Luca Weiss wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Define the pm8841 regulators under SMD/RPM, to allow the modem
> remoteproc to set the voltage during boot of the remote processor.
> 
> Entries are just copied from the Honami dts.
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: msm8974: castor: Define pm8841 regulators
      commit: a0145c557d94b3bac7c5a4545f90cfe940a226cd
[2/2] ARM: dts: qcom: msm8974-*: re-add remoteproc supplies
      commit: 6d933c0ec1718a08b44689da0f79ac1d905db7dd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
