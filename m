Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B2B71325C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjE0D5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjE0D5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABD213D;
        Fri, 26 May 2023 20:56:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58D0164FFE;
        Sat, 27 May 2023 03:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3C4C433EF;
        Sat, 27 May 2023 03:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685159817;
        bh=qpUua0Bd5xS9Q8kDtCFNb/s9VPf78P6z9fVHg1By/mE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fZ/sJr1rfveHISCohZRyoZLWBWIkBd7wNzJfBhHIsbDiXemnAsBDqaD9akX7rEQfi
         +Ao9ZQcr8P5bpGRTUU1TsrDhhjSLzM1tnk5cTIJx12hK5tVd5Jfv769erQ1wIBpNGm
         8YlmbtsWQrdOLiDMUEB8v+y/b4Ww4/BlzQovQqI2dNpJCOqBkaLcOTtOg+nR5DTE4Y
         iZAoipPxAkndOVN9ApEzLiH0frAxgnBOLPlQlRrlcBF5eoXtRQsNNY9c9EMDi2IQ5S
         cSinTSoS8v875vPkMrVpvHbfZSdMpYnuBBJBV5qn0Kiu7PAseKoqhoUVI4ZurCLcoV
         0eSSuC6T8zDTg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-pm@vger.kernel.org, konrad.dybcio@linaro.org,
        viresh.kumar@linaro.org, ilia.lin@kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>, agross@kernel.org
Subject: Re: (subset) [PATCH 1/4] soc: qcom: socinfo: move SMEM item struct and defines to a header
Date:   Fri, 26 May 2023 21:00:39 -0700
Message-Id: <168516003597.405989.10506857474161773619.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230121112947.53433-1-robimarko@gmail.com>
References: <20230121112947.53433-1-robimarko@gmail.com>
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

On Sat, 21 Jan 2023 12:29:44 +0100, Robert Marko wrote:
> Move SMEM item struct and related defines to a header in order to be able
> to reuse them in the Qualcomm NVMEM CPUFreq driver instead of duplicating
> them.
> 
> 

Applied, thanks!

[1/4] soc: qcom: socinfo: move SMEM item struct and defines to a header
      commit: ec001bb71e4476f7f5be9db693d5f43e65b9d8cb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
