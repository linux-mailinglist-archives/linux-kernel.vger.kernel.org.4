Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8B874CBF1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGJFHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGJFGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:06:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36333E67;
        Sun,  9 Jul 2023 22:05:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1752B60E99;
        Mon, 10 Jul 2023 05:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD72C433BD;
        Mon, 10 Jul 2023 05:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965509;
        bh=7Ts8Tg0DED+ANRAtnof76x+4kcM2VqLfQJU4/BpAI/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4Ia++0Kor9lA1ljXTUJVWbXCkUSpAVRLa7Zt6BlW7UvLA/V7iq0A/iu13FmU30hl
         eDlugU5TgFfWDQ0z4HTloyLvmM3II/tmeYSowAPQwT1KERs4G0KGpk2KKR2zsoAEfh
         w8E3/XNRGezFl+03jPp5pJ+FAfPFpIanUHxfzzr7neRtdaf5KlrGTiKsfmvGleY7CE
         M0GGbLEKseLGuqORC0+X9tpU7d2sOrP0cAGc6ke9wVFjGEZXm/LsyEOZF7OH+qCER9
         +QA+dUfB4d5ZjVFijAoeLr5K0IztEoIx4+JC/67qY/snyWR5kqXg/7xKYHX7kxN1mJ
         73ufiOkOakmng==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     agross@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org, sboyd@kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom: Update my email address
Date:   Sun,  9 Jul 2023 22:07:47 -0700
Message-ID: <168896565984.1376307.13025072801447705461.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627173123.9221-1-quic_tdas@quicinc.com>
References: <20230627173123.9221-1-quic_tdas@quicinc.com>
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


On Tue, 27 Jun 2023 23:01:23 +0530, Taniya Das wrote:
> Update my email address from the defunct codeaurora.org domain to the
> current quicinc.com domain.
> 
> 

Applied, thanks!

[1/1] dt-bindings: clock: qcom: Update my email address
      commit: 60838878e1fe84a056bc33ea0803c6e5470eb0c4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
