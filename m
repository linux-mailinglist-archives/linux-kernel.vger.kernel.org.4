Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D0174CBF7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjGJFHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjGJFGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632FE1AB;
        Sun,  9 Jul 2023 22:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E9FE60E00;
        Mon, 10 Jul 2023 05:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21053C433C8;
        Mon, 10 Jul 2023 05:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965511;
        bh=wasgO7PCCj2MCdHP6K/ZsSnJ2fzkWv0/BORaRdwY8cA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=utj8WCcXt8QX+MMt8XOj7vRksJEqFAGhyLlZszn/nyNIZAxI8awSXv1PlbbK8dVHJ
         dx+oIxbPJ7/1wUTbZnfDdzdTGuJ54JO0D5Buded+LCcIu1tznatkvzSR4/lvQygaLB
         0zr2qj6nTn86f/y3q7TpQK6u0XTfQ2csffdG+ZArCaw1Ix7C5LE2uA73Jk6ZtO0AYv
         TOYDtMpTrl3LHniqBOq92IbFw8cIhACOKbF7O3a/KGAt8UBk0oKno+TxREDiY5FNpx
         Umomj+/rK30qjFk2COXtyHkbhZ9FNEhRqb5GHbe87DiZvlY3tsnQj+GsyPtoYKxlhg
         WEhJHj4bUa84w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8939-sony-xperia-kanuti-tulip: Add missing 'chassis-type'
Date:   Sun,  9 Jul 2023 22:07:49 -0700
Message-ID: <168896565966.1376307.4269800889772328546.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622021105.66015-1-raymondhackley@protonmail.com>
References: <20230622021105.66015-1-raymondhackley@protonmail.com>
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


On Thu, 22 Jun 2023 02:11:14 +0000, Raymond Hackley wrote:
> Sony Xperia M4 Aqua is a handset. Add the chassis-type = "handset"; to it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8939-sony-xperia-kanuti-tulip: Add missing 'chassis-type'
      commit: 38c6fe604bc21530b3df16c79a7a96bdc42a0e93

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
