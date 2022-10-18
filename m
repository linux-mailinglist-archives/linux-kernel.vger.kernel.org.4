Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C516021E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiJRDIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiJRDHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:07:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F4B9A2B0;
        Mon, 17 Oct 2022 20:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BE24B81C55;
        Tue, 18 Oct 2022 03:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABDBC43147;
        Tue, 18 Oct 2022 03:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062402;
        bh=/JFNCvf+56Gzppfvo1oD6GGpNyK42pK9fZDPHQmB/Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDWxo24062sQJbZTPBYUb4wg9KtztwIPIgEwxuE4a53W6j7AzqhwacLikQJzDuORg
         EezXLgXIWKczVJpjMsNWPqFd9nF+K+ARrv7M8uw2pxxKtPvSrEBA8T5HHy4bQuCLrB
         HDnmK0jsIbIrM23Z+GNnNUvTNzMjC12Zwh3YzGgB91pDGpIpMJLgPZKjONlEWoMROe
         ZfDNUkAlm5yLQGWabzXOQ/I4bkKuEsb8swNMOrWOYQPvSo8Aq3CiFed5actNgvwZq9
         4lmHJb2s1CZmuMgrPBnZPa6ymoCag5FYuoPVnKMxIqfohpRxu9N5OgEOWJ2XGG42dY
         imjQEajBDubQA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     kc@postmarketos.org, caleb@connolly.tech
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v2 0/3] arm64: dts: qcom: sdm845: commonize bluetooth pinconf
Date:   Mon, 17 Oct 2022 22:05:24 -0500
Message-Id: <166606235862.3553294.9272597956883515889.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221016172944.1892206-1-kc@postmarketos.org>
References: <20221016172944.1892206-1-kc@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2022 18:29:40 +0100, Caleb Connolly wrote:
> From: Caleb Connolly <caleb@connolly.tech>
> 
> This series commonises the 4-pin pinconf used by almost all devices which have have
> Bluetooth on uart6 and removes the node from individual device DTS files.
> 
> It also updates the old hsuart alias definitions to serial1. I'm happy to drop this if it
> may causes issues with userspace, but it seemed to make sense to throw in while we're at it.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sdm845: commonize bluetooth UART pinmux
      commit: 691dfbf54214c9c42444f357fc3a8103a10ad738
[2/3] arm64: dts: qcom: sdm845-shift-axolotl: fix Bluetooth
      commit: 9833e23b6905d0ab342deb16a6c2312759ab5a0d
[3/3] arm64: dts: qcom: sdm845-*: fix uart6 aliases
      commit: 4772c03002c3eb2fc6dd0f908af0d8371a622499

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
