Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C17674CBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjGJFHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjGJFGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE21FF6;
        Sun,  9 Jul 2023 22:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 966DE60E8C;
        Mon, 10 Jul 2023 05:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E46C433CC;
        Mon, 10 Jul 2023 05:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965502;
        bh=PF+wheSWX1BGCe3BsX1xnaWBux/VJmzY6fyimdtyOa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fMqmZTKLQf3SpYIHkuvHsVZdAujMmVrErhMGlyREc4ySXZb6Mzap3qkdZuKBrmm0O
         y4WpS1Xa5m6JHw8BTfyQSXeHBvTmWUDwBEzmy7XQr0wFBoGmnFGoMYtDBYn1SHnwB+
         cd6lyNAaAHicH6ySrCH7TVg30KtTgM7Wg/hKDvSaOgQ4mZYNqyXAEyNEywpJcvipLA
         zzxKqpTSp8iGbnqssD0tHGz29ocXB0VvI/Z6+DuT6aOMKND7m0XwSygFkxE76mc8LC
         4qyNriKW+41pOPfrHWjW1ova8bLgLW44i3syfqJ43qYHk6uo7CfMd5FVRHYjtDBIHo
         Jgk1EhAv9jOvQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk: qcom: gcc-sc8280xp: Allow PCIe GDSCs to enter retention state
Date:   Sun,  9 Jul 2023 22:07:39 -0700
Message-ID: <168896565990.1376307.8509010957731691584.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707075926.11726-1-manivannan.sadhasivam@linaro.org>
References: <20230707075926.11726-1-manivannan.sadhasivam@linaro.org>
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


On Fri, 07 Jul 2023 13:29:26 +0530, Manivannan Sadhasivam wrote:
> With the minimal system suspend support in place for the PCIe driver that
> keeps the interconnect path voted, the ALWAYS_ON flag can now be dropped.
> 
> Also, the pwrsts PWRSTS_RET_ON flag should be used to allow the GDSCs to
> enter the retention state when the parent domain get's turned off during
> system suspend.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: gcc-sc8280xp: Allow PCIe GDSCs to enter retention state
      commit: db382dd55bcb8bc6319a14ad50689c19dba83b7b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
