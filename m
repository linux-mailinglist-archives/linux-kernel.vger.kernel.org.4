Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A4668C964
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjBFW2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBFW2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:28:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF59D50F;
        Mon,  6 Feb 2023 14:28:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD2F4B8164E;
        Mon,  6 Feb 2023 22:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F6DC433EF;
        Mon,  6 Feb 2023 22:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722506;
        bh=1RGIFSB7Oa1xqYA/+oBBQhdSdDH0R9pf5Ae/ehEJvqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=graPBw6sZ13Ol3XjiE27BKBrIsV3fz0ivBtk+UEpDUAg74q+tmLhAi3clH4HvYmuZ
         uq6o2yERDt7c+H3cLWtZ7GQSH87mZgBTg3sI+dXwSGyjvZkfQHW6ZkTeADvpdzfySo
         resQrdBJGPAKBZuIKJaD74fHKEjzlwF7PDzVX5HB1zBkNzUiebbelhKVmE/+A/9Ead
         051fKrVqGXNdqST+bU3UR9/K1xTgWVzU5Igb9hoafJ4MMlia4/XFtx1bheZ3pPMByT
         KmWBCYsJJMANKZFDeHkLpvjRSRYNfzFl29R/pm0rGxtPnpi1rYs4DNGnVjxtJai9N6
         w/90n0/ReuhBA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: add GPR and LPASS pin controller
Date:   Mon,  6 Feb 2023 14:30:33 -0800
Message-Id: <167572263442.3569822.17666402173008722433.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206150744.513967-1-krzysztof.kozlowski@linaro.org>
References: <20230206150744.513967-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 6 Feb 2023 16:07:44 +0100, Krzysztof Kozlowski wrote:
> Add the ADSP GPR (Generic Packet Router) and LPASS LPI (Low Power Audio
> SubSystem Low Power Island) pin controller nodes used as part of audio
> subsystem on SM8550.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: add GPR and LPASS pin controller
      commit: 6de7f9c34358ce54819b9d3fd5e2da492c219d8a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
