Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7021E74CC0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjGJFI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGJFHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:07:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7918C123;
        Sun,  9 Jul 2023 22:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 791B760E84;
        Mon, 10 Jul 2023 05:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0456EC433CA;
        Mon, 10 Jul 2023 05:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965513;
        bh=H7+5Zhs8MwLQ7viSeXNye+0TWMPXDTMsQKrVvfWNxnc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=c7f2QIagIr1en0G2cIRQaIhhjNM2wQgwv3MLren9iqgk0GIHp1dDykUEfz1gzhMSx
         viHIPSmOClRd6MkS9xabtSmhGPdDlGVyIiuwl1buoUv/tvkH2CqVaR4U5nKZ7fKs0E
         bcTF+xJYuDnsGjWguUncLCXswamImgvZk4CAqAhK1SX9FmHiM/ysgt6+aBOabbH5uI
         g93v0jsNdfU+hCqFkqYTdK0QuyBYonaDLbbGfL9eMoC0A57l0hyd4CyuBgeDdkB7R5
         XFtE5uDpQUT8TNLRR/qlsyb34wsKbcwvEVP22me4HX0R7VNVCNk/cWiU9NrEc0BFSr
         7AOaFL+fxPpFg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        danny@kdrag0n.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: correct dynamic power coefficients
Date:   Sun,  9 Jul 2023 22:07:51 -0700
Message-ID: <168896565953.1376307.7784893387678780644.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230615154852.130076-1-vincent.guittot@linaro.org>
References: <20230615154852.130076-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Jun 2023 17:48:52 +0200, Vincent Guittot wrote:
> sm8250 faces the same problem with its Energy Model as sdm845. The energy
> cost of LITTLE cores is reported to be higher than medium or big cores
> 
> EM computes the energy with formula:
> 
> energy = OPP's cost / maximum cpu capacity * utilization
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250: correct dynamic power coefficients
      commit: 775a5283c25d160b2a1359018c447bc518096547

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
