Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C76C68FF08
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBIEcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBIEbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DF3F2B1;
        Wed,  8 Feb 2023 20:31:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0E52B8200E;
        Thu,  9 Feb 2023 04:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497D8C433D2;
        Thu,  9 Feb 2023 04:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916520;
        bh=yxNnMNwO/bUWsvA6c9eHATZsKZptWxbUJkDnkmisqTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CgEyBUNU3OqUDrBSgYhru7oKhJwbl0QfdKuyJ/wfTEQXV0gRiS2Jt8adF4hXAEw3g
         940SbcPt4mmPU48WckB2T/n+F0/KfJRFRaw6ZaGYNU9Lx8XIMSYAzWo+yjTt2KhDgo
         LV4ZP0S1ngwfQ0Kdxn31H85q289qkR1SV+30MtRqOmJTibF/ArImM6Jl0pCug72gD3
         C/VM4Gn5OqWOhVZeLiQg5KLsBUYOaPj8I/IRXB+5FSPTPmbV6/Q4pm10AkOvHiO41k
         1almP0uAYzIItRAe9AibZodsvH2USjdFD06Fgv/Q08vIjFDBBUFu1hWZkyKfFtdzH0
         n245E/hhcMjKg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/3] Add USB/DP combo PHY config for SM6350
Date:   Wed,  8 Feb 2023 20:23:16 -0800
Message-Id: <167591660369.1230100.11949215646296439039.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120-sm6350-usbphy-v4-0-4d700a90ba16@fairphone.com>
References: <20230120-sm6350-usbphy-v4-0-4d700a90ba16@fairphone.com>
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

On Mon, 23 Jan 2023 14:29:48 +0100, Luca Weiss wrote:
> While this patchset started out as just adding a dedicated init sequence
> for SM6350 since USB PHY init didn't work in some cases, now it's also
> migrating the phy config and dts over to a new format.
> 
> Also note, that the DP portions are pratically untested since TCPM
> (type-C port manager) and possibly other components aren't brought up
> yet.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sm6350: Use specific qmpphy compatible
      commit: 5ed2b6388b310521fdaa81cf5e075c20e9d0006c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
