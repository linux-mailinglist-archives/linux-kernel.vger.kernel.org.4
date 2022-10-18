Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1E602289
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiJRDWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiJRDVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1DD3E742;
        Mon, 17 Oct 2022 20:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 407D261416;
        Tue, 18 Oct 2022 03:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4DAC433D7;
        Tue, 18 Oct 2022 03:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062898;
        bh=h4yVnHGfFznB7ov7bGRb8zYb45nKKtf92Ilt+P8sRZk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CaL9UTU/+feDHzpl4zXk7tp5jXdDZ/hD/fT/w6GyevwpF5qoRUCYp3QUDLQTYFE78
         ERJubuH+gZkxdyX0teHQiTcrnGQn77B5Z9gjENmfDtjlFryEHFFw3fMjy7ORGXO5VI
         bHQrqIkdLV/GXi6QrhtyguaqPxJxULkhg1IT3we9CAEALJFOVHFhgyAxJXaQyXTRJ+
         lBp6aB49Mmmu0PCfmV5dPvqTZF+zoUxNh9IDb7+RZIsSHiPlD9lMY5VDnI76ueWelL
         UbZs0EsltGM+2/FdCuCF5L2DbdRsp9wR0Qe/WQtImPZJc12FFmbZLWRFEXi/+BVepl
         ElVDirNFlWHWg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@somainline.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, robimarko@gmail.com
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: cp01-c1: remove bootargs-append
Date:   Mon, 17 Oct 2022 22:14:52 -0500
Message-Id: <166606235859.3553294.16396316544090941981.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220927201415.1265191-1-robimarko@gmail.com>
References: <20220927201415.1265191-1-robimarko@gmail.com>
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

On Tue, 27 Sep 2022 22:14:14 +0200, Robert Marko wrote:
> bootargs-append is a leftover from the vendor SDK, and does not exist
> in the mainline kernel at all, so remove it.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: cp01-c1: remove bootargs-append
      commit: f493bf2e70c6540f79fda3b28d636f1dd486d17a
[2/2] arm64: dts: qcom: cp01-c1: use "okay" instead of "ok"
      commit: 4d29e016eb72d14fa4fb4e5c90c880d260b8b281

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
