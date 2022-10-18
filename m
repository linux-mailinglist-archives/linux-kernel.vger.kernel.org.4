Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AAA602222
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiJRDK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJRDIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:08:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC19A9DC;
        Mon, 17 Oct 2022 20:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0BCD61375;
        Tue, 18 Oct 2022 03:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85CEC433D7;
        Tue, 18 Oct 2022 03:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062433;
        bh=zmLhfoS15h/bgVUCXTsHRLNIQWj/4t/e7UbR3lYD7OQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9i0eVpuY7bO7gzyB3w7EEDc13CvmRm4v93ky2Oao747ruXk7Hr2Vt6KlMxSVAT00
         PB6t31AC6syKsckIGrwmHZsbdJiAq/NLyGDnu6KkRjjP7x0xJD+rA6RES3ihma5zRv
         hb9K9DhSuSxNYVDgoskcZOhA7IacOzr1HcWhj9Oapltohr68fgYBexOH6HStxWxH5m
         UOtXqCSh1kH3EwvK94aHe2UdcL7PwnWxguIyEqJBImlmQyNJ4RyDTzqWLZKSBm0xIP
         GTXiVKUHAumrq/qGTs1J0sPvYp/OwX1RE63fV31l3fO8xQXcK8qFkZbsxS8gYqsMHf
         q6K7io63oaw8A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     robh@kernel.org, robert.foss@linaro.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        elder@linaro.org, srinivas.kandagatla@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org
Subject: Re: [PATCH v6] dt-bindings: qcom: document preferred compatible naming
Date:   Mon, 17 Oct 2022 22:05:45 -0500
Message-Id: <166606235860.3553294.7875042166882265521.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928152501.490840-1-krzysztof.kozlowski@linaro.org>
References: <20220928152501.490840-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022 17:25:01 +0200, Krzysztof Kozlowski wrote:
> Compatibles can come in two formats.  Either "vendor,ip-soc" or
> "vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
> DT schema file documenting preferred policy and enforcing it for all new
> compatibles, except few existing patterns.
> 
> 

Applied, thanks!

[1/1] dt-bindings: qcom: document preferred compatible naming
      commit: 5aa332c5e7ca2469c9ff55cf294eddb33a2c8e4b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
