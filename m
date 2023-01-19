Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9086730E2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjASFA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjASE7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:59:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1AE7C876;
        Wed, 18 Jan 2023 20:54:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8EE461B0E;
        Thu, 19 Jan 2023 04:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88208C433EF;
        Thu, 19 Jan 2023 04:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674104044;
        bh=Yw5zUXe0t4w/X4Q3paBZ0CoPRGx7d/KESOTjQ5XqkDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDYDBXUzcDfER2Rw9EFS+zalYU9LPiIGA1t1GgtGzmD9SvxUpeS9IiarRujsHV8EW
         oJZbzPzxyKyPFG6sFpGHIn6grVmyiVW5+1WBx0kgkRRmkKAtPRjTOBiIvB8TNvDBup
         ffZriNLKW+MTgVE1qdxD9m3NLG8Jh6vMawZdP9E4H9Arp3T8eptVMb9xQ9Xdh60nOd
         DukrOirTwbMLfW9F/BdDBMUPQcrluCHPLEXzaziTpxe7WT/cWkwKFGcZFi2++Tg9xU
         gmni58XniCAXwryuCozMqfu84Fre0mrg/6It8zO1aqgk12HqeJ4644CdmlzEIRTBkF
         lpPEh0sEYukAA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_sibis@quicinc.com, srinivas.kandagatla@linaro.org
Cc:     quic_gurus@quicinc.com, robh+dt@kernel.org, robimarko@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, agross@kernel.org
Subject: Re: [PATCH V10 0/2] SCM: Add support for wait-queue aware firmware
Date:   Wed, 18 Jan 2023 22:53:59 -0600
Message-Id: <167410403677.3048186.12291874601679971916.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230113161114.22607-1-quic_sibis@quicinc.com>
References: <20230113161114.22607-1-quic_sibis@quicinc.com>
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

On Fri, 13 Jan 2023 21:41:12 +0530, Sibi Sankar wrote:
> This patch series enables the QCOM SCM driver to support firmware (FW) versions
> that expect the high-level OS (HLOS) to be tolerant of SCM call requests not
> being processed right away and, instead, being placed on a wait-queue in FW and
> processed accordingly.
> 
> The problem this feature is fixing is as follows. In a scenario where there is
> a VM in addition to HLOS (and an underlying hypervisor):
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: firmware: qcom,scm: Add optional interrupt
      commit: afb37e2577938bb854f20d428d8f29a01ea8bc93
[2/2] firmware: qcom: scm: Add wait-queue handling logic
      commit: 6bf32599223634294cdc6efb359ffaab1d68073c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
