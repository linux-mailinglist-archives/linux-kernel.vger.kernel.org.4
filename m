Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B9E74CBD9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjGJFG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjGJFFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082A41BE8;
        Sun,  9 Jul 2023 22:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A2860DF2;
        Mon, 10 Jul 2023 05:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6022C433C9;
        Mon, 10 Jul 2023 05:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965496;
        bh=nub8H/mw+X988/i6k3Paz/dN4alhePOr2o2MoVrSaZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UX5tQu8EGfaRPbUhMXdNVLldZuWflSqWZblfQxwthG45TjzC2b7e+uM0CGBLhySnu
         zguHTczJiCsI76FHnpsAyBul6tHQqQst5C6+SUcFvnZMsem1G2PyHxodWSmqCmwYgV
         X33ATNCz7r01gn/4qrnTPTNVg0Uo74X8JrYmBYoGIyjDgSiKwT+AX+yn+4AIpKA2W5
         sCNYJFPEoGzYFaLGc876CAAfJnSEhdpjj5Fe3LD+H9nLHrXzXvQdHYCbXoR+prAqVS
         7OvugmMewYqiniOnHOT1dKSuR9NOFLq8L096Ci84cz4ucsTYHOAHFPixcY9RHiATqp
         Gc6qKjE3WVbTg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: pm8953: Add thermal zone
Date:   Sun,  9 Jul 2023 22:07:35 -0700
Message-ID: <168896565970.1376307.8219500292825816238.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230625-pm8953-thermal-v1-1-2b4247d2f769@z3ntu.xyz>
References: <20230625-pm8953-thermal-v1-1-2b4247d2f769@z3ntu.xyz>
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


On Sun, 25 Jun 2023 13:13:05 +0200, Luca Weiss wrote:
> Define the themal zones using the temperature values found in the
> downstream 4.9 sources so that the spmi-temp-alarm driver becomes
> active.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: pm8953: Add thermal zone
      commit: 519c47acac28db7cec7ab5d929055a73001ac2d9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
