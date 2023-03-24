Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FC6C8516
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjCXSbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjCXSbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:31:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3CA20A11;
        Fri, 24 Mar 2023 11:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8D49B825E5;
        Fri, 24 Mar 2023 18:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE5EC4339E;
        Fri, 24 Mar 2023 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679682690;
        bh=krgFEq7Aa0aTJiYzMIeWj55qSAKzA1UPItgJl/FTz1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cKCMJi0jXsoLtx0mTwbcrK2znZDOSm6FsbYHRyBLoFDCYFaSlt2nXSHo75COJPFyQ
         gXkLVN+2p5itmnauDgtaUCAFGDbm5v+UBPAoGYwM3yE8IhExxS/Ei5SO6/ILOrdyeS
         HcJ57Do6QmJoWhNNULlONdtiOtC9KTuXWYjmDDn8lEWsLEU90Q/gZxvZ0hWg5ycPJW
         dhM+E0trtcWeFlC3nzXfh1CSZ3dqWleIewZTNRzHCNgjDIspUFcG/Y2x/kKHKxeON1
         zBj564FqBMM33nHaUQlrBhvdCdZiPlV6qna7XgYlvWRoD/IiUlmPmWQMcEl2njFAbu
         qlENVgTFYmv7g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v3 1/2] dt-bindings: mailbox: qcom,apcs-kpss-global: correct SDX55 clocks
Date:   Fri, 24 Mar 2023 11:34:30 -0700
Message-Id: <167968287203.2233401.14930759110888883685.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322173559.809805-1-krzysztof.kozlowski@linaro.org>
References: <20230322173559.809805-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 22 Mar 2023 18:35:58 +0100, Krzysztof Kozlowski wrote:
> SDX55 and SDX65 DTS takes clocks in a bit different order.  Adjust
> bindings to the DTS.
> 
> 

Applied, thanks!

[1/2] dt-bindings: mailbox: qcom,apcs-kpss-global: correct SDX55 clocks
      commit: 8504fa9baf8bdc5f333f24077b54df1d16173d99
[2/2] dt-bindings: mailbox: qcom,apcs-kpss-global: fix SDX55 'if' match
      commit: 22ead09ba40745e50970565af1996c2c1cc4e909

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
