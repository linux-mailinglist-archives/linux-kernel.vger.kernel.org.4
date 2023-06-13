Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F34E72EF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbjFMW1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjFMW1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ACE10CC;
        Tue, 13 Jun 2023 15:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2A2D63BA3;
        Tue, 13 Jun 2023 22:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6604CC43391;
        Tue, 13 Jun 2023 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695238;
        bh=Bf/wEYwPBGCjx8CC16Ab8DH8+WLKbd1I9de0rrAHDxA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=H4u60iCUg3gCIzGqWt6k/Cl5Tz8dty2GIoM1RLEgkTE09enFZne2mPwTGIfF/bcpG
         /nH2DOVDoxTmXvPV7lzFA5NHG9QgxFv2wDQVSpNTGeABfXDrA3pOHVugqJ8n8I+hv2
         zxJQSivEwbtzrsxeVIoNEHXHXXNFmfAZBxVlX3lBqj6YG0DhJuCh9Bxgg+Yh8Lxktx
         Vin9P63FV3nFWLl70IzIoTqXsvvEsFCbBpXL4poOsGt/cbzLO9w5ibTasmpiMhTGJO
         nMAnuMDDZaMv7p+mubaGxCOrsOE6zjM/00I5oAz0bz0IHc3XxAl2xJbD/lMfyIasPR
         6smaqSRuX+hIg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8550-qrd: add WSA8845 speakers
Date:   Tue, 13 Jun 2023 15:30:16 -0700
Message-Id: <168669542894.1315701.12086023716607874108.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608094323.267278-1-krzysztof.kozlowski@linaro.org>
References: <20230608094323.267278-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 8 Jun 2023 11:43:22 +0200, Krzysztof Kozlowski wrote:
> Add Qualcomm WSA8845 Soundwire smart speaker amplifiers.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550-qrd: add WSA8845 speakers
      commit: a2422d51069d682a2172981fa6e7ba84b2dc93c8
[2/2] arm64: dts: qcom: sm8550-mtp: add WSA8845 speakers
      commit: edb92fae57e7b3292e92bc3fe7dfd0e21875befe

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
