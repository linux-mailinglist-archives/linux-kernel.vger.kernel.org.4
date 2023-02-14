Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6B6696B73
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjBNR2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBNR2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:28:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1B9524B;
        Tue, 14 Feb 2023 09:28:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 395C2617C8;
        Tue, 14 Feb 2023 17:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5D3C433A1;
        Tue, 14 Feb 2023 17:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676395695;
        bh=By2YoftB1VENHi1k10kHOrHOooi4UaKqxSqwDanAXt0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h4L99RPzOjliln8FGZdZGqUV6v9TMiyT6pJvD9/Wy7B0ZKQkFfDw4E2LET3fMjHEV
         cIF0EcIxI7PxSocL/IDwEd+IAZsU83PVwen7KV9GRS0ll+EV2Bm7nXfGc9SpJ8j1Yz
         LE/JCQFtEzfODhD1mfGVl35UBM1wX/MrUOyWI/2yE5eqDQ/fk9lObPSE/8R6nYX9YA
         rlbN1PuYChN1J1fu/pKHtqwf94MJbITMkZp0Ewl3/JjyL9xUl5StQ0/4kboggYVYxS
         G5xL8D9W/pyL6FnqdNqvnZTnn/yYdRVg0ISGWsJGtHW5i7fDc9RNemwV2t/VZZP2sI
         NWZnebNodT73g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom,sm8550-pas: correct power domains
Date:   Tue, 14 Feb 2023 09:30:14 -0800
Message-Id: <167639581474.996065.11129738192205911246.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206193313.30667-1-krzysztof.kozlowski@linaro.org>
References: <20230206193313.30667-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 6 Feb 2023 20:33:13 +0100, Krzysztof Kozlowski wrote:
> Correct CDSP and MPSS power domains to match what is used in DTS and the
> Linux driver:
> 
>   sm8550-mtp.dtb: remoteproc@32300000: power-domain-names: ['cx', 'mxc', 'nsp'] is too long
> 
> 

Applied, thanks!

[1/1] dt-bindings: remoteproc: qcom,sm8550-pas: correct power domains
      commit: 6f998eb2fd02a7a7a529abb4c7d8bbf44fc3ff13

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
