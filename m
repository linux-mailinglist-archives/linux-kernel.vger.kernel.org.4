Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9D86C4E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjCVOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjCVOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8326544C;
        Wed, 22 Mar 2023 07:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E434B81D1C;
        Wed, 22 Mar 2023 14:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64105C433EF;
        Wed, 22 Mar 2023 14:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496141;
        bh=ZcC6DXyHmOiusRVaUJxCIxY87h35l1f0imd2AA4omSY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uRB7G93x3qAMkm2Xn/oa9G4n8bJSqCSCsWLKYryFpWGIsJthng80UliliGHvIHDZW
         ZNjL6XS5XL0KXMBkhMBub9nxzFr9ruwlmUXsr4lVfkBF/IJje1UPs3G916zZkJvl9u
         c3h3u9AfB6r6aFYC9Pn5W6VT8J1I+44iXyBDN1vgymHJm0UXBOkHACfUhKp46GZQao
         1jhddGkwckVt1PrKkPT+nuJ5TsZ9ptueYNQ0Ql+bNJ33S3AwVE4+TfuZ/g0u3AKpmW
         gXWcbnyWYnstiHT+HKgVeBgB+sidV1uE0HO4btUsd9cQO98CGNCXIJ5oR8RaAiMuLh
         6/0+3H1Yd4Scg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sdm845-db845c: drop empty node override
Date:   Wed, 22 Mar 2023 07:45:12 -0700
Message-Id: <167949631653.1081726.12804733771037765657.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306081430.28491-1-krzysztof.kozlowski@linaro.org>
References: <20230306081430.28491-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 6 Mar 2023 09:14:29 +0100, Krzysztof Kozlowski wrote:
> Drop empty override of pm8998_gpios.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sdm845-db845c: drop empty node override
      commit: e225d56042e3a02aa3ee60c96da687ac3c690a37
[2/2] arm64: dts: qcom: drop redundant line breaks
      commit: e18b829549793f706c6c8a39f24ba93b3213fb33

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
