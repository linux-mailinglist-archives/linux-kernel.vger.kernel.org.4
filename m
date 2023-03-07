Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125D6AD617
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjCGERV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCGERJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:17:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967EF5328A;
        Mon,  6 Mar 2023 20:17:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4678B81613;
        Tue,  7 Mar 2023 04:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE29EC433EF;
        Tue,  7 Mar 2023 04:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678162625;
        bh=X2mu4QLPFyIf9GnMC2MlfaO80bGeCQmDWyEqMjyg8OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZJ5j3TsxkQoA1KAK6+3RwE9YQ34VrsREShGYB2WXSNNWDK87KTu/4hQIjcgI89kO
         tbPF6NnFM9jxhgl18UD47eYdzPw69jJsfcLNwiauFr147UXbiHFNdYguMQ/hnZE3mW
         8buH3bkAeJM/zjWwct/5PXwD84Wk+DejhETYupl05XNAdiYpbaBhSCn6LaCMLKIrwV
         AgxCcprGoeqMsswOfvRW6F55G3ClGsUMjjBlK9CArZqOMvvTxnX7+0FqKkDDY4qKCH
         YeRQDDx3npkARaPZuUj6CckjR7ZAX7q2tvdk4iFQtKKJU0lLXS2dDf9DPNJtksjQQ6
         NuEs62OFyleAQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     marijn.suijten@somainline.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: arm: Add Cortex-A715 and X3
Date:   Mon,  6 Mar 2023 20:20:28 -0800
Message-Id: <167816282864.1458033.9946003182900300090.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230216110803.3945747-1-konrad.dybcio@linaro.org>
References: <20230216110803.3945747-1-konrad.dybcio@linaro.org>
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

On Thu, 16 Feb 2023 12:08:02 +0100, Konrad Dybcio wrote:
> Add compatibles for the Cortex-A715 and X3 cores found in some
> recent flagship designs.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sm8550: Use correct CPU compatibles
      commit: 27072f2ffb29283b9a44d878204c86c08d86b37f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
