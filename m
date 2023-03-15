Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD06BC172
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjCOXf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjCOXeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B38A8C40;
        Wed, 15 Mar 2023 16:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 629F4B81F9A;
        Wed, 15 Mar 2023 23:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40613C433D2;
        Wed, 15 Mar 2023 23:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923176;
        bh=aoz2bnbiFrBxlSw6q0XxgH+8ryhNBVBOEYUuwtxFdQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvPpbXMkjrmQVwvQaBYqfnhvkekanx11vUo31RXxBu5OGLj6kWpapyqgnNcwrme7t
         otesIGB1z+mSBUfq76W5e30FZOMzFxS4N2nBj/a5HQDs4PIydryzbK7S8fmhMx56ks
         f/1vXeFFNp22KOMx5jHekYndfKGv/irSuB17lmQkMy/TlhTXNEJruYq2TMeN1N5lYL
         MIEXbii9n2sx/cSxMZHc4GSWY48i/C+YbeawcSnOarei9pZfZIiUYnv8eVB6G/GTh9
         uI2MKZCAfETqafs8b40dcddc2Rhvf4EErFEoQfAmpMGlCX+VqPCGwGfrSN1s4D0RAM
         k9ezEB9LcrtOw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, sboyd@kernel.org,
        konrad.dybcio@linaro.org, Robert Marko <robert.marko@sartura.hr>,
        robh+dt@kernel.org, agross@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Cc:     luka.perkov@sartura.hr
Subject: Re: (subset) [PATCH 1/7] dt-bindings: clock: split qcom,gcc-ipq4019 to separate file
Date:   Wed, 15 Mar 2023 16:35:26 -0700
Message-Id: <167892332566.4030021.2066671633508562447.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230214162325.312057-1-robert.marko@sartura.hr>
References: <20230214162325.312057-1-robert.marko@sartura.hr>
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

On Tue, 14 Feb 2023 17:23:19 +0100, Robert Marko wrote:
> Move schema for the GCC on IPQ4019 platform to a separate file to be able
> to allow passing XO and sleep clks directly to GCC.
> 
> 

Applied, thanks!

[3/7] ARM: dts: qcom: ipq4019: pass XO and sleep clocks to GCC
      commit: 66e4811ab3967332c52a72f04d615f0faabb145e
[4/7] ARM: dts: qcom: ipq4019: remove clk-output-names for sleep clock
      commit: 2a41c611f21751150cf4c0132a02828700e58e2d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
