Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B76022AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiJRDbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJRDak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4863A598F;
        Mon, 17 Oct 2022 20:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B53C6140D;
        Tue, 18 Oct 2022 03:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1F6C433B5;
        Tue, 18 Oct 2022 03:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062730;
        bh=1U+wxIcjtKmdUFTPt3VJpuMT4JvOkaudAevESL6iZNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K944jnB/2BqO3GKQuFNYKwOx7wxMl/LmKZoXtZxx7GvyHiOEMhmyFTSRE/eG1kAAE
         c5hI9gVNOG9owaEXlfEBGmlT5Z0IPP9UKeRD6aSTmg9wtWZzjuVqEDTSuUT/SPtge2
         Y5pulYja+MMXqIpZ0izu8vNNnasIxpNytB9EX+idvsmpndspPrWDkdlyRMh8cEaDpB
         W9NSF0UfRSfjj9ythL1OCBI2F4FtDqtWMLV+AfhXvAR17kaHMKFakc+WLsyxmA9NMS
         2rqFdF+TuMxvb4Lg95lDmUVtVC1uZiR9ctTuhTrr+NUucqE76s/cJiogvLMyscoqEX
         G9+mat5ga4AuA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_bjorande@quicinc.com, agross@kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: rpmhpd: Use highest corner until sync_state
Date:   Mon, 17 Oct 2022 22:12:02 -0500
Message-Id: <166606235838.3553294.5635322330677546287.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220915205559.14574-1-quic_bjorande@quicinc.com>
References: <20220915205559.14574-1-quic_bjorande@quicinc.com>
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

On Thu, 15 Sep 2022 13:55:59 -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> In some cases the hardware that the bootloader has left configured
> depends on RPMH power domains for their operation up until the point
> where the related Linux device driver probes and can inherit that
> configuration, or power down the hardware gracefully.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: rpmhpd: Use highest corner until sync_state
      commit: 3a39049f88e4e92823bcc43fa8f148cf7dfdda67

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
