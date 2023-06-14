Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB85730460
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245067AbjFNQAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbjFNQAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833B11FC8;
        Wed, 14 Jun 2023 09:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD00C63FB4;
        Wed, 14 Jun 2023 16:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0954C433C9;
        Wed, 14 Jun 2023 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686758415;
        bh=d2ZKiMNfxVleUTrZsfi2NstNs14jaMzV1BVxwQu2lls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcJRued0xFQ23sb9smUesPf18PNs8zkg+fQkue8GUc1Gje3HxUmjHQc9yj/KaXrO7
         jfSL7RE/jCnG/hvwRfNHmI6njQlNS9ju8+/tRy6BvGSzKjZ4vDAjzYgTu+tCCesiHl
         03D0zX8BOjCW3PcBfu7eEwkAiaWkzYaUszGWaWE4Rq+CxuVTD6SFdJLRNeBVgkN/Uw
         IocxE+DhLTVuNlSgw3hzMOBhr/ff79gyyEiAOEl8fUdrhUpVbWi6FdOwHHqiFNyfRP
         CzJyTYYe/pdmneTUv+sJg5Zf8bawDAPkrQc0IAmathVgRhNTtbVUxJdEudofP/u1/c
         QlnM+iupLkeeQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH] arm64: dts: qcom: qrb4210-rb2: Enable on-board buttons
Date:   Wed, 14 Jun 2023 09:03:32 -0700
Message-Id: <168675861182.1453524.9338443444158479247.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230613-topic-rb2_-v1-1-696cd7dbda28@linaro.org>
References: <20230613-topic-rb2_-v1-1-696cd7dbda28@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 20:09:00 +0200, Konrad Dybcio wrote:
> Enable the PMIC GPIO- and RESIN-connected buttons on the board.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qrb4210-rb2: Enable on-board buttons
      commit: d34654f54ebad11263cf7c411d8c60cd8941e2d4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
