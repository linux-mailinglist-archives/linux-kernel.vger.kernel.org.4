Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8656C4E32
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjCVOnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjCVOnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4C16512C;
        Wed, 22 Mar 2023 07:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C36B62128;
        Wed, 22 Mar 2023 14:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AC3C433AA;
        Wed, 22 Mar 2023 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496137;
        bh=L/4jbOCsiAXmR9pJuwqtguB38HvoLhQ1Uo+07ejSBCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJjiRAfWtAQTyxZtRLUKLUf3wKAjxwnCqq7ga7AQfpnJH1uJPWOgwvGdk/sm8GDay
         2L9rPkQ0ueM5d/vN28Slx7BT+2Sl+SZDeqDvWTnFf/ed+28j8QFAb3MmHCEGK4o1YF
         FIlmbjGn3LPPsJ5qzkkDCKZc3Hub1fSSXl3R5sKmd8pZG0Yc2+sWXuoaodoc+JRULD
         /QBHN0kr4N41ilAf5jBDBRhwrNxvI3+hGsV460vYZGuLsBYbQKV4Mdc0Asj9ICNtpU
         laTNitHGYCtdbMuWsRLkZ+XNqqPZrEKUsitIkO/B9ltuw1LiWRIix9xpC2a6YNv1e+
         nH4J9x8rxtHmQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix external display power domain
Date:   Wed, 22 Mar 2023 07:45:08 -0700
Message-Id: <167949631654.1081726.16063174854126507628.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316141252.2436-1-johan+linaro@kernel.org>
References: <20230316141252.2436-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 15:12:52 +0100, Johan Hovold wrote:
> Fix the external display controller nodes which erroneously described
> the controllers as belonging to CX rather than MMCX.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: fix external display power domain
      commit: cf386126aef92256245adc8be686f2df4b837013

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
