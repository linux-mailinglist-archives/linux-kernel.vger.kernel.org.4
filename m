Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ECA71313C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjE0BER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbjE0BD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC781A2;
        Fri, 26 May 2023 18:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB0D2654C3;
        Sat, 27 May 2023 01:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953CCC433AF;
        Sat, 27 May 2023 01:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149434;
        bh=GHblA9PThtMpAqEBdoykOdEG+1iRZcceHoc0kkgonqc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lV6t8E4pgeO+fegj4OO9aDfelbpRIPSZGHkBvAn7hmt7UwzxmeTmKKJJSIG+dDDuB
         FFmRGvdhosc9Vv2bVHEHjM+AcY/hOlUpp5ZEKeB62SotZqDvErFdmgBS1rXOuqtL6Z
         o/mHdZnktNfiOzV4AvyrEpbOjsSQE87Wr5C4lSgBnkZSzFtYIsMDh+D/FDsVCGvSCC
         +WwcqV4NnP/iKutg5jUMJrNJ+NT+Krsaf/BiO2Reru3XAycO9/dQoNQKhr7AvuLbkL
         ih/MhzhDGYksnGZ/F/brG0+SmJKxzJriLJDsXRZjZZ8P090jF1AN13xi1LZDGLJiMx
         9CoFP3r9v4GKQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-clk@vger.kernel.org,
        Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Subject: Re: [PATCH] clk: qcom: ipq5332: fix the src parameter in ftbl_gcc_apss_axi_clk_src
Date:   Fri, 26 May 2023 18:07:29 -0700
Message-Id: <168514964950.348612.17048019037174387302.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417044342.9406-1-quic_kathirav@quicinc.com>
References: <20230417044342.9406-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 10:13:42 +0530, Kathiravan T wrote:
> 480MHz is derived from P_GPLL4_OUT_AUX not from P_GPLL4_OUT_MAIN. Update
> the freq_tbl with the correct src.
> 
> 

Applied, thanks!

[1/1] clk: qcom: ipq5332: fix the src parameter in ftbl_gcc_apss_axi_clk_src
      commit: 81c1ef89a45eccd5603f1e27e281d14fefcb81f9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
