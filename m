Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303446C4E48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjCVOoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjCVOnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D0565C40;
        Wed, 22 Mar 2023 07:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36566B81D1B;
        Wed, 22 Mar 2023 14:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A239C4339E;
        Wed, 22 Mar 2023 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496146;
        bh=ZVHKsJk7ORuGqB8KLWsMcPhustuB6Bf+0GSzPlAPoBM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=F2u5O2telM+gh+bqBbvOvT5E7EAgoyzXLZVUTHPNp0HVMbtfXD+MAb2JXB2dIUCLs
         m/vk0OUGf3EC/ZQ78hupnsru34tOMcuYx98FiJmF4rJ4oS6RRA/eiMuQGHJF0CCMkf
         MQ+i681cLDu6RsiABsV1Cohbtz0EDrfy7wpN0EKKr3ol5ICBEdhGyUa53+fenNTmt8
         N5RnpxrtK2SveFxiz4All594awgSHbhMeBCIFlZFfd3Awku//O3K6b6h3xxa5xt0sF
         EoH3sS++afyQLtyOYGzkQeV2a0rW5bdqjOAwYeBQz7uAr/D/41u4H8VIzKnc439MqV
         4sxQ3s+wAza8Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8450-hdk: use recommended drive strength for speaker SD_N
Date:   Wed, 22 Mar 2023 07:45:18 -0700
Message-Id: <167949631653.1081726.7744710394696808897.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308142712.277659-1-krzysztof.kozlowski@linaro.org>
References: <20230308142712.277659-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 8 Mar 2023 15:27:12 +0100, Krzysztof Kozlowski wrote:
> Downstream DTS (and sc8280xp-lenovo-thinkpad-x13s with the same
> speakers) uses 16 mA drive strength for the WSA8835 speaker SD_N
> reset/shutdown pin.  Use the same for HDK8450, as it is seem the
> recommended value.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450-hdk: use recommended drive strength for speaker SD_N
      commit: 7c2c4c9decf6f4604fe15a1db2da7c1250b3e9e5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
