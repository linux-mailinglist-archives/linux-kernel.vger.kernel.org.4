Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2B702258
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbjEODbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbjEODam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A482D76;
        Sun, 14 May 2023 20:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC78261E2B;
        Mon, 15 May 2023 03:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73819C4339E;
        Mon, 15 May 2023 03:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121358;
        bh=3U7Yu4lWHuHPvXJ3zXDd0svY1gpGXjwrJN0tg5aitHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQy8957c7TB7aIE5PMfS0VmwMhu9JxTxnG/Kfe09H4GD59ZyLfnYxkMY3pP8tnhpv
         xNiaaUAtI5eskEpFPpuRZhgCjJTqNuQnRacLxyw0Q/ddHidsyAV1NaQzcMBba7RQbT
         6TQH0Zzy174hHgpHtsRJwhyeY9Uw0Md75O7pX4Twl65A/CSzr/BE1qIljs0v0JnG5z
         kumjEsm+0S6OT/hTq2qZeflzgCre5yoqn80tay7WmHb6w/sdrKoxck4KcyfmN/py0Q
         OUiZ9GmeWeVR4LEACmXX8V3gd+HliWLnXIikHjXBJwvh0uH5SLg88iU9EBRjs82su7
         ufRBKuHdM/QLA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: soc: qcom: aoss-qmp: add compatible for sa8775p
Date:   Sun, 14 May 2023 20:32:57 -0700
Message-Id: <168412158456.1260758.12394667213859910379.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504161755.197417-1-brgl@bgdev.pl>
References: <20230504161755.197417-1-brgl@bgdev.pl>
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

On Thu, 4 May 2023 18:17:54 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Document the AOSS QMP compatible for SA8775P.
> 
> 

Applied, thanks!

[1/2] dt-bindings: soc: qcom: aoss-qmp: add compatible for sa8775p
      commit: 0dc608855195c8f79e499e2a608b26e56e259810

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
