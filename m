Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6361E924
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiKGDNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiKGDNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:13:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767DCDFE1;
        Sun,  6 Nov 2022 19:12:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E41AB80D90;
        Mon,  7 Nov 2022 03:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208D9C43470;
        Mon,  7 Nov 2022 03:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790772;
        bh=UMDPCvoqo2sWQ6McTJbSAELNREOn/h2Fg9CR2Zr7WfQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HKawyi+0hyNnRmueQZb6aX/B3GKu3mo38UtPi1vd4wqU9HFV6XnV4z7rrJFgZzLUE
         dKrtUOBGbSy/NnElUHa247h/TWYRMJwnffRORhFSk4wDOoGMp8MRVJNCJkfE4rW3BI
         AB0WpI6OU1J1q5cy6WY36WTkSuDPB/4V6F7lRI9JHSno7QkNrBWzvHAwUqzBi+7lNN
         ARWeLzxdsLCZPOf9C0j/yCtZMyXeavmYaIsJYaSKkyPmfnsUC3XHUv9v2fPM7LngK3
         V2ud1YJu1o2SqRB/NOIhEfJH8ppTvYOGiYxh9xYGSLj55WTcfKx8ayLWCIjW8qhEes
         aqxmyM6MGYOyQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: arm: qcom: document Mikrotik RB3011 board
Date:   Sun,  6 Nov 2022 21:12:10 -0600
Message-Id: <166779074258.500303.16980893196856423664.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221017014653.12970-1-krzysztof.kozlowski@linaro.org>
References: <20221017014653.12970-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 21:46:52 -0400, Krzysztof Kozlowski wrote:
> Add compatible for existing Mikrotik RB3011 board.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom: document Mikrotik RB3011 board
      commit: fb27202bc549a4469576c5b4a18ba3b6d0dd926f
[2/2] ARM: dts: qcom: ipq8064-rb3011: Add SoC compatible
      commit: 78c80faf07c06e1de7d09ded2667cae5bda9df34

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
