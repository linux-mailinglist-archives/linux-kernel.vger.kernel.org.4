Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5733E672B11
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjARWGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjARWGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:06:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B56646A9;
        Wed, 18 Jan 2023 14:06:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18E20B81E14;
        Wed, 18 Jan 2023 22:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C06C433D2;
        Wed, 18 Jan 2023 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674079563;
        bh=9q9c+MLmT8C3c4Q61ySLMlKiuX8AJ96fxzZFSsyCCsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EELzYxIlT41pYBWdRIGNma/THT05zPvpuBfSOT32sDuUwcw0EvFwOtckR3HYxZzSi
         BqOvLxQp0VlnvmJhBWyD4bzJCjDMEDFWnXqaOFQn0YzMgpMzTSKBuJmpOubU873I7p
         LqWMGcUDDlCmEKyqKZZbxCKqCoWLPGQ8WN8VySN/by+EkORgmUSE7IaoDa61qkjnGW
         Cxp3eEumlQVLlNADOqZrQGwOL3oO65gkxt0UERrR2bJTs9cwTPlMDSjr3/psFw1xJn
         1CYiZO69mQc9d+oGVfvcfWVKtz71pwMiGtNcnZYxbw/KLw+Xw21sogePuVV2aUmOxy
         9tLqgG66VOdQw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_bjorande@quicinc.com, mathieu.poirier@linaro.org
Cc:     quic_clew@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] rpmsg: glink: Include types in qcom_glink_native.h
Date:   Wed, 18 Jan 2023 16:06:02 -0600
Message-Id: <167407955794.2940632.3174898857042107561.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109223745.1706152-1-quic_bjorande@quicinc.com>
References: <20230109223745.1706152-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 14:37:45 -0800, Bjorn Andersson wrote:
> Ensure that the used data types are available in qcom_glink_native.h, to
> silence LSP warnings.
> 
> 

Applied, thanks!

[1/1] rpmsg: glink: Include types in qcom_glink_native.h
      commit: f014eda5d5923a1d85f29dc7467cd90e9775cbfd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
