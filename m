Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9F656D88
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiL0Rm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiL0RmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:42:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BBAA47F;
        Tue, 27 Dec 2022 09:42:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3F45B80E98;
        Tue, 27 Dec 2022 17:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4CEC433D2;
        Tue, 27 Dec 2022 17:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672162939;
        bh=bsxu3cQIxJCAmoMyRaPk0vJ+C2smV1odvrSTgHAcz18=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cAWM3Cortrfl5c7Yq3Gh+WS44R1WC9K637uwBNrztE2LtKnBQaSYc8jFn8eNB5pu4
         ah3y7NOVFKDuahx31Z6JRe6Jtczoax6lbrcqPWThxYtemaYPifU0SJ+/TWfFDS/dYH
         Lc4PjLh9q6OVhgs5nc+Z6qVsXkVbhmiGy4GYxZhKMZifqUnM7TFWYz2h4ljZ3tr8js
         /NWqzeqeQAhVl+FK+7sUsF545P7baIVV3modJPQ1bBAI58Jay6xgxDPqy4A6zj7fAT
         6Nctty1QLBW3oorDXrQBWqEco9uNzs4enX9aa3MXMEJiSD+pKnyGCA1IuIxqjG5k1u
         iOiDrkVUB6Ltg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom,glink-edge: add GPR node
Date:   Tue, 27 Dec 2022 11:42:15 -0600
Message-Id: <167216232799.738877.18279130764991980992.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221223132213.81273-1-krzysztof.kozlowski@linaro.org>
References: <20221223132213.81273-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 23 Dec 2022 14:22:13 +0100, Krzysztof Kozlowski wrote:
> The existing SM8450 DTS (and newer platforms) come with a "gpr" child node,
> not "apr":
> 
>   sm8450-sony-xperia-nagara-pdx224.dtb: remoteproc@30000000: glink-edge: Unevaluated properties are not allowed ('gpr' was unexpected)
>     From schema: Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: remoteproc: qcom,glink-edge: add GPR node
      commit: 1135e93682db5f66909f4785b1bfbd798955b2b1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
