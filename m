Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908586BC18A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjCOXgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjCOXf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:35:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A657BA8E9A;
        Wed, 15 Mar 2023 16:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51A8BB81FA5;
        Wed, 15 Mar 2023 23:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F31C433A4;
        Wed, 15 Mar 2023 23:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923174;
        bh=tGgmkyW9sOQppytiiGm2ywKzt51IycdB5ZhlIdtaeTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rjv+YCq4rsWz8IKZCpJBwNsMKHP7rvAFdYflUq306+e6QDASRtNZAHlZAU7mmXS3j
         VxG1jUcG8usAn8kvMHliv0kxQ9nUdmbcOWUBUyGsJybp1eA01E1ikoYM8zDosTzjat
         GE15HALAh2pxDJuxa1rmD1Lezg78KGXL1ceNvotm/WtkdX1QImSyM99DG6mAZ9F+se
         OCsuxVA4oVqRCgj8aGNLfx4TYm7fbIxabTP2U5lc9v+CpbikcehPbydQNPLB6rx5wO
         wcjf+p08H956IaAtndHG4RJZqBIG6XcJ6+WtiKT/PvWeGYAuJyeJ2nrtBp690ssBZG
         jwgyxGtB9Kxtg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, Visweswara Tanuku <quic_vtanuku@quicinc.com>,
        konrad.dybcio@linaro.org, gregkh@linuxfoundation.org
Cc:     quic_vnivarth@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_eberman@quicinc.com, quic_msavaliy@quicinc.com,
        linux-kernel@vger.kernel.org, quic_satyap@quicinc.com
Subject: Re: [PATCH] soc: qcom: geni-se: Update Tx and Rx fifo depth based on QUP HW version
Date:   Wed, 15 Mar 2023 16:35:24 -0700
Message-Id: <167892332566.4030021.1142374899502045448.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230215050528.9507-1-quic_vtanuku@quicinc.com>
References: <20230215050528.9507-1-quic_vtanuku@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 21:05:28 -0800, Visweswara Tanuku wrote:
> From QUP HW Version 3.10 and above the Tx and Rx
> fifo depth bits are increased to 23:16 bits from
> 21:16 bits in SE_HW_PARAM registers accomodating
> 256bytes of fifo depth.
> 
> Updated geni_se_get_tx_fifo_depth and
> geni_se_get_rx_fifo_depth to retrieve right fifo
> depth based on QUP HW version.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: geni-se: Update Tx and Rx fifo depth based on QUP HW version
      commit: fe8aa1ba078366ba23fc676efab57183b12a3a81

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
