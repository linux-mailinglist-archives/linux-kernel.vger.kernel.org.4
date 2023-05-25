Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A44971045A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbjEYEwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbjEYEv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A49E47;
        Wed, 24 May 2023 21:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40DD664280;
        Thu, 25 May 2023 04:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58B3C433EF;
        Thu, 25 May 2023 04:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990270;
        bh=LdTpSiapswxf7sYU8ih/QGcMfmaVAAytcGZDnIjG+2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+rOkwqmhDHx0NiitB1dLwIa97LC8j3qYMMNzcsa7pD5GB3XWf8FB1GWUsOxEVM8i
         GzNMtuXTY+j21jIDCrrmAb4F9fZCGiLFBY1GqvZ20x54ftpcWCtThiBVWar9xHUs3z
         YyXmMda4QDjSBR4vzVfULWk64V99gOT9USZ/gbkMT+oFWmhkwd7MZBe8Nf0VcbC9qk
         1GGapvp7LdHFpi1dHDT2XkHs3m/gvm7Oeq6L8dxvzjDpu1lknMZ1ovSWHokPRliB32
         BqQCxho7e1rS6PINmQDiR0ry37bRWXkhfvO01c3JtChyQ0/7DFibIrN7co3/C0X+l9
         Ie4b2vrV9iEXg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rudraksha Gupta <guptarud@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     david@ixit.cz, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: Add missing msm8960 for list of strings
Date:   Wed, 24 May 2023 21:53:50 -0700
Message-Id: <168499048187.3998961.9308237097375591180.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524230338.120619-1-guptarud@gmail.com>
References: <20230524230338.120619-1-guptarud@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 19:03:37 -0400, Rudraksha Gupta wrote:
> The list of supported 'SoC's didn't include msm8960 even though
> qcom,msm8960-cdp exists.
> 
> 

Applied, thanks!

[1/1] ARM: Add missing msm8960 for list of strings
      commit: aaa3fc4ce98b7b37531c330f975270d27b1179ea

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
