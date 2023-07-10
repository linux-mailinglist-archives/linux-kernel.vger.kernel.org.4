Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8519B74CC00
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjGJFIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjGJFG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE8318D;
        Sun,  9 Jul 2023 22:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB5460DEB;
        Mon, 10 Jul 2023 05:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288FFC433C8;
        Mon, 10 Jul 2023 05:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965499;
        bh=tYuyJ+DT7hUW+l/0UGxl4gydj7pIK3oXhAVyhKbcXFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mte/bL7WReF/+OLnhxfubH9RNiKBcO37xcuWr3OHDkuxnBdffzB1Dpj1g2EOxNuUh
         WAdqHD2/gfhsp9CoBIKoeuZdOQjlTOi6Jr0zq2gc8+IMpZEq7StlFoRvM0GyfIq6ly
         pzSliJCSYPwezffMeD6Y5NWJBWMsyiHodaFsVSb2nOWnNIUyMVWxpmuSXxvHQdAgMV
         ilP312FA1VSq2EpEEarQ1TRuChyhminWxWfS87VDwLese0kMtrjM3rAe3sXv6l/dFi
         q0xMu7wf2hibsJi4j2e0Bf2SzFQMBoaW8/nClQocUfCJ6leAvwRa/XhKpznJxz1d9Y
         UoC8Dc/jZB3yw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: (subset) [PATCH v3 0/6] Add MSM8226 OCMEM support plus some extra OCMEM driver fixes
Date:   Sun,  9 Jul 2023 22:07:37 -0700
Message-ID: <168896565952.1376307.10535078828402994333.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Jun 2023 18:35:46 +0200, Luca Weiss wrote:
> Like MSM8974 the MSM8226 SoC also contains some OCMEM but it has just
> one region for graphics compared to 8974.
> 
> While adding support I found a bug in the existing driver that is being
> fixed in this series also and the rest of the matches are mostly
> preparations for MSM8226 support.
> 
> [...]

Applied, thanks!

[6/6] ARM: dts: qcom: msm8226: Add ocmem
      commit: 4bad24d73abcc6adf70bc4c894c29cb1d0acda05

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
