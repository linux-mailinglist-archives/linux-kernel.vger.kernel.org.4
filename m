Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8376F6205D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiKHB2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiKHB1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:27:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894CC28733;
        Mon,  7 Nov 2022 17:27:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34116B81716;
        Tue,  8 Nov 2022 01:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC3BC433D7;
        Tue,  8 Nov 2022 01:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870867;
        bh=0TXBwQrSlPJZArSBgz+4MwrNnxL7OCGqH6k4Ht3vkjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7Rbr9XQ4X/9+qkumFZpMhuT11KyNHQ+kThx6Vtf2Hjvi16NfuoqdIPpXMyoMh9mC
         gXbIrCRgsz5ldhfUORE80/54jTOtUDgzDYdFfEnSA6EhJr4+oy1fp6tsU+emf/GZmN
         P1J0HyVcyxYBJTF6QbP1GG0s92PjleSOy67b/OUVbB/3GrD49+7UMqdVWTwBv/nXrd
         bJyN/1WntlDok1DdYlP05m1F0n7ID7z/ijVwQ3fd7KapOA3qyruVxamJa3gNnFUZxz
         Ughdqvti9DHgngKGujBmHeKRiusYzIR6e5Qfz/BfgRqW5V8h9NC4yCiwtalC9uuRJ2
         Kw4nRQTef6qcg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     jiasheng@iscas.ac.cn
Cc:     quic_jjohnson@quicinc.com, konrad.dybcio@somainline.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6] soc: qcom: apr: Add check for idr_alloc and of_property_read_string_index
Date:   Mon,  7 Nov 2022 19:27:20 -0600
Message-Id: <166787084685.599230.7554750931145257916.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221107014403.3606-1-jiasheng@iscas.ac.cn>
References: <20221107014403.3606-1-jiasheng@iscas.ac.cn>
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

On Mon, 7 Nov 2022 09:44:03 +0800, Jiasheng Jiang wrote:
> As idr_alloc() and of_property_read_string_index() can return negative
> numbers, it should be better to check the return value and deal with
> the exception.
> Therefore, it should be better to use goto statement to stop and return
> error.
> 
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: apr: Add check for idr_alloc and of_property_read_string_index
      commit: 6d7860f5750d73da2fa1a1f6c9405058a593fa32

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
