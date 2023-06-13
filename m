Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E479672EF42
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbjFMW11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjFMW1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2005D10F3;
        Tue, 13 Jun 2023 15:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8921863B9D;
        Tue, 13 Jun 2023 22:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E25C4339A;
        Tue, 13 Jun 2023 22:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695234;
        bh=QMK158R85EvKTpTuTcTE6JdEPQApDbgpQhg7LC7O+VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LBBdvMlHs7URpe86CB0808sOUzWRTmdb3zbaWk16NRXD+AvSfCxQsodDeZFBMe2XI
         S0c+1CtQaPwQVwy6IJw46SyjqvWpLXeETwBN7v0G5PaJbUvWGFKawVFe6bP/IuwtSB
         qVfahLBlUGPtnaeNE+rKI2KAe9QBdiIrBnsOuERjiTTdcw+T5K5ylFYUtG2/AGH+Om
         8THdU8HemgIFQc1XYZfyTiUcy8NaQgES3RLQY7im+NEcqznen5YEW9PN2GvdwiehmW
         t88lFpJayzI3D4GTZ4sc8ppDSXhO4LmNhw1M17e51wN5SCsy06k/4ZeJpPfrwnEWHj
         QWVFZqh2n3RWA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: Fix a IS_ERR() vs NULL bug in probe
Date:   Tue, 13 Jun 2023 15:30:12 -0700
Message-Id: <168669542894.1315701.12985204586909393008.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZH7sgpLAN23bCz9v@moroto>
References: <ZH7sgpLAN23bCz9v@moroto>
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

On Tue, 6 Jun 2023 11:21:22 +0300, Dan Carpenter wrote:
> The devm_ioremap() function returns NULL on error, it never returns
> error pointers.
> 
> 

Applied, thanks!

[1/1] soc: qcom: Fix a IS_ERR() vs NULL bug in probe
      commit: 3aed112953b1877ede66ae77afa4e5a5024be7cb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
