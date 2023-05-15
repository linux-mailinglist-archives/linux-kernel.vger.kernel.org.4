Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED9670227B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbjEODdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238190AbjEODdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:33:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BF92684;
        Sun, 14 May 2023 20:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71A1A61E4B;
        Mon, 15 May 2023 03:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C35DC433A0;
        Mon, 15 May 2023 03:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121370;
        bh=XMRnj8mbLoMF224gPhdKVw9PE5wQ32Z8oIToWRiYvvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTCL3vnMzGGLbOZeDUkfJkLfuEHdbGEFvrYlb1fUSD/5gOdwJ95UxrEsbcYpRzg7w
         QiItYXhVl6dQfx4lxI727ZVQ0BiFE5dcCLT+sLvj+DB1h6RAZA/U0zQg9VFM+l2ULz
         /pkbBPVUhKwjOztR3NepXEaWKRe0R6j0Y6jJ/a0dF9Gs5iWR2IW6dGkTQsi+CUkToz
         Vpf7tu9SvxcUNu9yZKq2Jzsm7qGCHAYVrc3k1MpUMErQoab5xztuNFWUJu5YeOOvOk
         h6JipEoKjAedhJFJvuAjIh+8DlaUK7soLDENc0FgP9YESdhgnmPgo+uqPqYZ7bocr1
         ++mCfcOiiBkhw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     lee@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        conor+dt@kernel.org,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
Cc:     uic_gokulsri@quicinc.com, quic_srichara@quicinc.com,
        quic_devipriy@quicinc.com, quic_sjaganat@quicinc.com,
        quic_arajkuma@quicinc.com, quic_kathirav@quicinc.com,
        quic_anusha@quicinc.com
Subject: Re: [PATCH V7 0/2] Enable crashdump collection support for IPQ9574
Date:   Sun, 14 May 2023 20:33:09 -0700
Message-Id: <168412158453.1260758.6784235069429539037.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511075814.2370-1-quic_poovendh@quicinc.com>
References: <20230511075814.2370-1-quic_poovendh@quicinc.com>
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

On Thu, 11 May 2023 13:28:12 +0530, Poovendhan Selvaraj wrote:
> Crashdump collection is enabled based on the DLOAD bit in the TCSR register.
> This bit is set during bootup and clearing during shutdown. During crash,
> dload bit is not cleared, due to which uboot starts crashdump collection.
> 
> Enable the support for download mode to collect the crashdumps if
> system crashes, to debug crashes extensively.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: ipq9574: Enable the download mode support
      commit: 590db411752dd8ef6504113643fc6c4f68660ffd
[2/2] arm64: dts: qcom: ipq9574: Add SMEM support
      commit: 46384ac7a61885ee29cf918777d5f81a6446e9e6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
