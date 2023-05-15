Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DC1702252
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjEODbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjEODai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D2B3582;
        Sun, 14 May 2023 20:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C91D061767;
        Mon, 15 May 2023 03:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90139C433D2;
        Mon, 15 May 2023 03:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121357;
        bh=mFyHyYBGiXN1K9UO9Pw2FXSpQ31xV2ioqkh4L9zAoCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OctG4n3vOZ/qdMJYg+AxNaxA/Lf29+v5mU1v009UDwsdLgU9IbEYzN68/RWHSmqgB
         7deGRycR3ohMupjvzjQGrAW8qVJQfyNXe8lKnVZteSQCoe6FjIOHFdcWR6k3VhdKXx
         dZUzbhgQapLrfPS3gsL6yO9h/EKEwSbxcw33GPdPj9x6wlql6Yl+FloxuOC30EeM4B
         PHn5TbFQdPp9mfan05ncS4oEVdHL+BIBJxVm3XrMhe6PkBACrMLb45oxM64I6hgV4K
         dpu7+Hac/bRf/MKieXDG7juFZf+5ozYiIJeMolpCgJKttApLRP0TsLyohDy/JCnmpK
         uuXwPkVQPIL0g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
Subject: Re: [PATCH v6 0/2] Add EMAC3 support for sa8540p-ride (devicetree bits)
Date:   Sun, 14 May 2023 20:32:56 -0700
Message-Id: <168412158454.1260758.12334402333318173153.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501205105.2518373-1-ahalaney@redhat.com>
References: <20230501205105.2518373-1-ahalaney@redhat.com>
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

On Mon, 1 May 2023 15:51:03 -0500, Andrew Halaney wrote:
> This is a forward port / upstream refactor of code delivered
> downstream by Qualcomm over at [0] to enable the DWMAC5 based
> implementation called EMAC3 on the sa8540p-ride dev board.
> 
> From what I can tell with the board schematic in hand,
> as well as the code delivered, the main changes needed are:
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sc8280xp: Add ethernet nodes
      commit: b405d8d500e59e1edc51d934a766ea6127e1e69d
[2/2] arm64: dts: qcom: sa8540p-ride: Add ethernet nodes
      commit: 57827e87be5447559cc3495567349ff002a6b33a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
