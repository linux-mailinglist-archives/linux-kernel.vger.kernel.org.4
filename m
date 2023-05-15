Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365A3702276
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbjEODda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbjEODcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6DA2708;
        Sun, 14 May 2023 20:30:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0EF361E30;
        Mon, 15 May 2023 03:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F4CC433D2;
        Mon, 15 May 2023 03:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121369;
        bh=PJns+FdyfLEF4/WJUPn7vHvOh9pfr2DmL5H+kgBB3C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Db6r9VpU0/iaYBGrk6GkZx0WZvskdGZJIFaLuPq3z7m4MrMdyY6jGsEHTWtRzRz5n
         /RFCDDW5I4P1EOUw2aAW4SDnqB70NUNKSf4aQAjPjrM/JTHf1tZMO56DBwd2jBpJJM
         1yY8nQHcumK+/6CkhumBmMldupQ5o6HS4X0Pg/kN7hPT87cmgByYMO1IvOlQdwNkxV
         C1mGJIygoxdVezlshBE2MU6LT0lmCFn9Msfm1V/r6gGChww+oZWDWO56oWXyQcxjvc
         YX/qAhz6NN0EgTJtHrUioF0FotKDaFB53Ud5luOf1+d08DX36UUhznQCJu0scD9bzX
         ZTgDmrkwZ7ggQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes
Date:   Sun, 14 May 2023 20:33:08 -0700
Message-Id: <168412158457.1260758.12092492977187646460.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512150425.3171122-1-quic_bjorande@quicinc.com>
References: <20230512150425.3171122-1-quic_bjorande@quicinc.com>
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

On Fri, 12 May 2023 08:04:25 -0700, Bjorn Andersson wrote:
> The rpmh driver will cache sleep and wake votes until the cluster
> power-domain is about to enter idle, to avoid unnecessary writes. So
> associate the apps_rsc with the cluster pd, so that it can be notified
> about this event.
> 
> Without this, only AMC votes are being commited.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes
      commit: ce7c014937c442be677963848c7db62eccd94eac

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
