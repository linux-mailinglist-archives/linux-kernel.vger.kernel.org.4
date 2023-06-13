Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C88172EF60
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbjFMW2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbjFMW1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7D21BFD;
        Tue, 13 Jun 2023 15:27:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F29061625;
        Tue, 13 Jun 2023 22:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DBEC433C8;
        Tue, 13 Jun 2023 22:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695244;
        bh=y9fKrFHaMRhep0/VFWaHJUxHH5jsTj0Etm8hQeq/a+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ghagcwh2EhNqyVqS0dGDU61XJkaH+Xh+xSrn6E/pM7HmWXtMs1wGl+nWZZyjrx/L5
         /V6t6xic26C6Zi2Q+3TeKUgvjzIzGKm+O6gw6ZHdnscHQ3uLE221fhVbxha/uhiRE0
         6pfXozpKCo8lPMiSYqQ1VxEOLsBZJDZaZCDrxBkYcpIM8m9fiQ+qfwo/flUUw7NF54
         RZVZ/v7CL74DQk/OFDu3LlPcOWp3gbS8AaO4UhNAt5hQS8YoeglT6ejs+molyzrALI
         MagTdY2NaUreOAiUCkfNifz58bfOgvZkmdruIvHAUiZsrlGLK7a08O1Z+NNqMA7+56
         bdWIQ2eWpLCSw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Anusha Rao <quic_anusha@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_poovendh@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: ipq9574: add few more reserved memory region
Date:   Tue, 13 Jun 2023 15:30:21 -0700
Message-Id: <168669542895.1315701.7702140907456519614.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230602084431.19134-1-quic_anusha@quicinc.com>
References: <20230602084431.19134-1-quic_anusha@quicinc.com>
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

On Fri, 2 Jun 2023 14:14:31 +0530, Anusha Rao wrote:
> In IPQ SoCs, bootloader will collect the system RAM contents upon crash
> for post-morterm analysis. If we don't reserve the memory region used
> by bootloader, obviously linux will consume it and upon next boot on
> crash, bootloader will be loaded in the same region, which will lead to
> loss of some data, sometimes we may miss out critical information.
> So lets reserve the region used by the bootloader.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: ipq9574: add few more reserved memory region
      commit: f684391e3d323bbdc832569dc685d1289c58d081

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
