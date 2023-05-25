Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E6A7104F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbjEYE5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbjEYEz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D2419B1;
        Wed, 24 May 2023 21:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 170C9642B9;
        Thu, 25 May 2023 04:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD36C4339B;
        Thu, 25 May 2023 04:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990319;
        bh=j3WXOQtumtPyRDE7jtnWd8SFc/lKPPY+Rb067nhvURo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kA7avkadcUItK/o1X48A0VK2yI0n8JPQf2S2VYFVJOqgNT1TlVix7AqZLG6Rs1SMO
         m/leaUJ1H6BuF9ItO+QZ5wFkUwF1i0Va9o4Q7vbIoNwIIZx3FZNGSQC5VmflZcsny3
         8NlOaLfHd2YKVs69ebui16jYjEH1tQiGZzEACG5J7z1fd0Bd4eRHehyvGg8Aa0kOmP
         ETy8x/1WKDw3vIe+devJUc23P6eUeeAT57t2hHrZopIIY1NSD9qYEsIyHoC7Tf+daQ
         u8f9XQFHH1RdnoI/N8HlaCR/kLu4/ciDTuX8whw0sM62Um8xldgNTM0XpVeOluGn6l
         rpVoyQdIpGOfg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: Re: [PATCH V3] arm64: dts: qcom: ipq9574: add few device nodes
Date:   Wed, 24 May 2023 21:54:37 -0700
Message-Id: <168499048186.3998961.10536295689489328026.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517072806.13170-1-quic_kathirav@quicinc.com>
References: <20230517072806.13170-1-quic_kathirav@quicinc.com>
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

On Wed, 17 May 2023 12:58:06 +0530, Kathiravan T wrote:
> Add QUP(SPI / I2C) peripheral, PRNG, WDOG and the remaining UART nodes.
> While at it, enable the SPI NOR in RDP433 board.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq9574: add few device nodes
      commit: 9ef42640504e09ecc79530b6e532ebf48305516b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
