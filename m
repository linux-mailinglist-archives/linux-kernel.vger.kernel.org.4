Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61DC644B6B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiLFSVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiLFSUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D476F286C9;
        Tue,  6 Dec 2022 10:20:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86DF9B81B1F;
        Tue,  6 Dec 2022 18:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C300C4314B;
        Tue,  6 Dec 2022 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350799;
        bh=UntVAScl8MifuVWxdfcurrQW/vnt4pAAlqgEzwG2kwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDyj8EejjrD/Nh5NlFP4exsfkj+jxRU3Vgx6WNN/fBoEtPB5qDnakUVqUwaNB1qTU
         cOjK+Wq788SCv17lmzfANFqTeNNUQo9Ul2Ni4xquzXFBhfISeYs0L02hMB6LkKAP6m
         P0XK/ZHqhunLoFDo4MV6VkBNsRseUJtQi1P3ahO5tveSVi1/LDiZ9JCPtGcwIptiml
         MJ6ip9jTADUmDSFsyrApM75cLUoLHMBda0WTXr3h2k/vKNXKq7/pC29QIYTt8hjUMV
         KQIF4lONdK3m4ZEihkPEDTYgNKkMF5IKGmrNpjwr0arYLFvldbQlLUqvgxNcfJ0U0F
         wiML8Q2Qego/Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski@linaro.org
Cc:     robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, patches@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: pmk8350: Specify PBS register for PON
Date:   Tue,  6 Dec 2022 12:19:03 -0600
Message-Id: <167035076334.3155086.9014812561234261436.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115132626.7465-1-konrad.dybcio@linaro.org>
References: <20221115132626.7465-1-konrad.dybcio@linaro.org>
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

On Tue, 15 Nov 2022 14:26:26 +0100, Konrad Dybcio wrote:
> PMK8350 is the first PMIC to require both HLOS and PBS registers for
> PON to function properly (at least in theory, sm8350 sees no change).
> The support for it on the driver side has been added long ago,
> but it has never been wired up. Do so.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: pmk8350: Specify PBS register for PON
      commit: f46ef374e0dcb8fd2f272a376cf0dcdab7e52fc2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
