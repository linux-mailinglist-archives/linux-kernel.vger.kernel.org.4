Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739917104C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbjEYEz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbjEYEyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:54:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAAF1733;
        Wed, 24 May 2023 21:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3ED264207;
        Thu, 25 May 2023 04:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581A9C433A7;
        Thu, 25 May 2023 04:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990308;
        bh=HyHw0UpNevbdtUGutX+HpxfziuOeqXUOwlyvSUOaI2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBWlrVHNBgswCnSqwsUYXWUmC4dQmcQ4PEH3WsQ6Ul/vavpv0T103Xn6Tv+ktedrX
         icUoV5ktYM3vIpMmcpfvh/S5arC5UAgDgKRqCT8VuPZuCX9Jw827g6AkOawsbx85xB
         XqaqN3n7AD8EDmPG2SeUZjpGj75QAxAj56GV7gLEKPRoYQ6XHt/ilHMZ+baHqsudVX
         UsSiZ03m4vu3B692v+RA4+i3cBDOR+YA1emr9tTa80Z6vZ/ngrCXfEXIuTo3Yof6X+
         szFopOcpOfieX5zLLwuoi/IUpEIWSXbAwuztE9TQOaqHTUSNcJx68YPU+6R1TnKmH7
         b/xuK2Vt8eWig==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8250-xiaomi-elish: remove redundant empty line
Date:   Wed, 24 May 2023 21:54:26 -0700
Message-Id: <168499048186.3998961.1405428189083098126.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517133340.21111-1-lujianhua000@gmail.com>
References: <20230517133340.21111-1-lujianhua000@gmail.com>
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

On Wed, 17 May 2023 21:33:40 +0800, Jianhua Lu wrote:
> Remove a redundant empty line introduced by
>   commit 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250-xiaomi-elish: remove redundant empty line
      commit: 05860f678c686afebc781c1fe8233bf997f2435b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
