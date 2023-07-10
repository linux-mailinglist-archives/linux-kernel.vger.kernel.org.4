Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4474CBB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjGJFFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjGJFFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D9B19A;
        Sun,  9 Jul 2023 22:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B76AF60DE9;
        Mon, 10 Jul 2023 05:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B39C433CD;
        Mon, 10 Jul 2023 05:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965478;
        bh=JLzd3fpduQRSEYhXxw8VwrLHTtWf2Sek7jE7kZCaTRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDQ0Nq9YP3G9laSwFtFSzpjUjN+fURfr43pMgYQrWAEHtq9wtAbVIylX8RfzAT9uv
         JjfVoR8R2lPBBMXrcx05TKnPm7sr629HdcD7FbgbJWLjW+juu9ldtumgXddA+Fip+4
         kazCMh16GJmFJMXi4pBaXYcPxqUMqsJI3p8nNyPtF/ijEjNIGRg+XcYI2W3yPBW4i7
         fHvzMz/lZQMqCiDhmrf21T62BRH3qfbvENAuY803ZD3zNO/5btWt+tOFsrqj5Nq4W2
         bCMX3nXy7taxsG3xKpnp0XJDG2LKElrA/pVy7SrhEcVqHy/bdmul+2uf94jvyJ3g8p
         ApNwXKiYlAg1g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-tama: Set serial indices and stdout-path
Date:   Sun,  9 Jul 2023 22:07:18 -0700
Message-ID: <168896565983.1376307.11376194490443757361.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627-topic-tama_uart-v1-1-0fa790248db8@linaro.org>
References: <20230627-topic-tama_uart-v1-1-0fa790248db8@linaro.org>
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


On Tue, 27 Jun 2023 19:27:50 +0200, Konrad Dybcio wrote:
> UART6 is used for debug (routed via uSD pins) and UART9 is connected
> to the bluetooth chip.
> 
> Set indexed aliases to make the GENI UART driver happy and route serial
> traffic through the debug uart by default.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845-tama: Set serial indices and stdout-path
      commit: 9acc60c3e2d449243e4c2126e3b56f1c4f7fd3bc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
