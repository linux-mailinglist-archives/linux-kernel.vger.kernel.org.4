Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A349644BAB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLFSXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiLFSWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:22:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F371D0DE;
        Tue,  6 Dec 2022 10:21:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF42CB81B2B;
        Tue,  6 Dec 2022 18:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAC4C4347C;
        Tue,  6 Dec 2022 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350825;
        bh=xiyzD5CIr9ef97Noc6GYm1Dx3uDPCVdlKHHDwT4uhC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=juhmWXzelATD2k3R+xqgnz910RVirQoDVJGoDilY5ys+BNiMIbaBs8QVBiyqujp+3
         lHsVXqUmQQTEtu/NT9Iel5WCZwNCPHL1+QbKc+C2B8wGGDxFaXBwGOfKa1BiunMyCu
         9g1naAeTX+PU4Co6KkGrIyYsUd2KElIDMHXamyb6iEu0IuUe6lOu7bcj6AbUEEEVQX
         DOpifjQ73/QUzFeL9W3gPENiwbQkPFITCdgCwxhlwAhTt5vsgu2R9s5Xi/UIgAALQn
         bOJWxocVy5G30dbMl75wIjfgU/mhaQ4XTLiupQ43HRr6vAKJfjKbI7YqpUEwNP8JpD
         vUqiWHAKdxVqQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, quic_ppareek@quicinc.com,
        Andy Gross <agross@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, quic_shazhuss@quicinc.com,
        bmasney@redhat.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ahalaney@redhat.com
Subject: Re: (subset) [PATCH v10 0/2] arm64: dts: qcom: add dts for sa8540p-ride board
Date:   Tue,  6 Dec 2022 12:19:30 -0600
Message-Id: <167035076343.3155086.14685315873698668804.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221118025158.16902-1-quic_ppareek@quicinc.com>
References: <20221118025158.16902-1-quic_ppareek@quicinc.com>
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

On Fri, 18 Nov 2022 08:21:56 +0530, Parikshit Pareek wrote:
> Changes in v10:
>  - Removed micro-amp properties from ufs_mem_hc node(Konrad)
> 
> Changes in v9:
>  - Enabled ufs_mem_hc/ufs_mem_phy nodes(Johan)
>  - Corrected the indentation of 'regulator-allowed-modes' properties.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: add SA8540P ride(Qdrive-3)
      commit: 6be310347c9ca850b6fcc3f0e6a9fa1bd49c7327

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
