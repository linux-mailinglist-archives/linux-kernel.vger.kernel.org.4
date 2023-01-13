Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F3066A1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbjAMSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjAMSX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:23:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA29B8D5FE;
        Fri, 13 Jan 2023 10:17:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85919B821AA;
        Fri, 13 Jan 2023 18:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31446C43392;
        Fri, 13 Jan 2023 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673633851;
        bh=MC3Wb0A+JrFPrTulLTxnk1+4ay4eXZrhHeOdStTKrfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ts/O8pF741PO1l3JN4gkhTIapMPZ3pImdar2X6efG6/+c+a+PCVOyFot/na2cwwMo
         Ck1qMstsND4k83I09UbbacKvr+0lkeb2f1shWydjbNpdfKYyoStX0BLOA2ip/kpagI
         dagDI0TxUTmmUgIu8LZ5WJ+h/yE8azCttZ2A3hDpgqEqQ/RxlGymhbhOlc2Wa3I+lc
         FLib8YA9o2gc6ZUpU2eojnFimtZ8i4u5QwFsbXivg56EcIqqwpQONFfS5mKISPaUQw
         yjQ6k/Gf+ewI5LJN5cpHX2Ie0xBS4VY5h0gh4ijLmnx1JQJ0bpMzzJzzODAYUW54XI
         20Px3YBhDdCCw==
Date:   Fri, 13 Jan 2023 23:47:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: qcom,qusb2: do not define properties
 in "if" block
Message-ID: <Y8GgNidy+Hhnnikp@matsya>
References: <20221224154226.43417-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221224154226.43417-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-12-22, 16:42, Krzysztof Kozlowski wrote:
> It is more readable to define properties in top-level "properties:" and
> restrict them (if needed) per compatible in the "if" block.  Defining
> properties in "if" block  does not work correctly with
> additionalProperties:false:

Applied, thanks

-- 
~Vinod
