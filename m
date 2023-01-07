Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1804660A93
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbjAGAI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbjAGAIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:08:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777243DBF8;
        Fri,  6 Jan 2023 16:08:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CFFBCCE1EBE;
        Sat,  7 Jan 2023 00:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B4FC433EF;
        Sat,  7 Jan 2023 00:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673050100;
        bh=8u3Qc0RIaieWL44MYlHmNd9QLF5reVDmKXzh37Fj2lA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfix8YVR0kz4M/xfyWPZ0tinN9THWryewjoNtPtR4541XmbwbHGdctPOsJySb61v0
         RXA/9R/G+Pw5R+G0d6o23UAl2H5n7yny64omZv2evtP+wTwfX1CHdxEyjx9hFQc3uP
         YE6kdCWDsVPCIsPNTRXlBFgV6GGikvgMC3k9jY39/op/5h54kym3v/h1QHEIl1b/X+
         mZY4nZWHUwiLw3qm2nClCpLBB8PusprQ4GfRtCAHzar0gnwjYIkRcTSRjBHGibkAta
         eJEJjRFyYLPYtN+emoj0jOV0P14wuzBidAPpEYWJVKheDoPj59gqqUUt7lbQvm1m3h
         9NL7068Z8gK/g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com
Cc:     robh+dt@kernel.org, quic_rjendra@quicinc.com,
        quic_sibis@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        elder@linaro.org, quic_saipraka@quicinc.com, agross@kernel.org,
        konrad.dybcio@somainline.org, quic_schowdhu@quicinc.com,
        vkoul@kernel.org
Subject: Re: [PATCH 0/2] soc: qcom: dcc: Documentation improv
Date:   Fri,  6 Jan 2023 18:08:17 -0600
Message-Id: <167305009215.1816299.16435625611756424987.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221230135030.17002-1-bagasdotme@gmail.com>
References: <20221230135030.17002-1-bagasdotme@gmail.com>
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

On Fri, 30 Dec 2022 20:50:29 +0700, Bagas Sanjaya wrote:
> The DCC (Data Capture and Compare) patchset was sent and partially
> merged [1] without Cc'ing linux-doc list for documentation review.
> kernel test robot [2] noted htmldocs warnings as a result, which is fixed
> in [1/2]. Later, when inspecting the sysfs description, the wording
> could have been improved ([2/2]). So here is the improv series.
> 
> [1]: https://lore.kernel.org/lkml/cover.1672148732.git.quic_schowdhu@quicinc.com/
> [2]: https://lore.kernel.org/linux-doc/202212300426.eMLsZsvA-lkp@intel.com/
> 
> [...]

Applied, thanks!

[1/2] soc: qcom: dcc: Fix examples list on /sys/kernel/debug/dcc/.../[list-number]/config documentation
      commit: dc2f5a499de420001813562ddbc9d51ece295978
[2/2] soc: qcom: dcc: rewrite description of dcc sysfs files
      commit: 13763fb955a0043bd9b6fb1e237f4fd8fe8b3c75

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
