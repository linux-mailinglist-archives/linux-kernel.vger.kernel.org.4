Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C22C71325B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjE0D5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjE0D5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B918D;
        Fri, 26 May 2023 20:56:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A0564D9F;
        Sat, 27 May 2023 03:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF40AC4339B;
        Sat, 27 May 2023 03:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685159818;
        bh=huApN3ti22H7EsPWxh1yzu+Sc3hqFFKv14KBzkuy1/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uVdSL89eBgJpx6aSc3Damg9MHvLgRjhTX6W5udG703mGn741bMYs3MoSj0XHvqvgq
         Rb28GZxEOKAM4b3ZFefwZ2sjcNDoynqgEGTmDkgBy9nullShp6w9j8Jpr5EwrzwHJM
         Eimry1hyL8BeUX7qPHOj/iKHhcPtGNDMk0D/qVVfo415a7L3qvf8UUpjjS5bFeFmFs
         8jNqnj+oRKkfRtqVrztRjVzxFi6vdQRFM9VKLqf6PlgSURMeMHL5HDeS3uQhcLU9o6
         iwKZjGqfgBEiJ3Qv/zJI4Dc8MLfB9IYx9kDWjXD7yo9BBFWPvx2HB7mPpW9gARkmhK
         d9FgArXJ07vJQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-pm@vger.kernel.org, konrad.dybcio@linaro.org,
        viresh.kumar@linaro.org, ilia.lin@kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>, agross@kernel.org
Cc:     ansuelsmth@gmail.com
Subject: Re: (subset) [PATCH v5 1/5] soc: qcom: socinfo: move SMEM item struct and defines to a header
Date:   Fri, 26 May 2023 21:00:40 -0700
Message-Id: <168516003598.405989.14272681988555880109.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526204802.3081168-1-robimarko@gmail.com>
References: <20230526204802.3081168-1-robimarko@gmail.com>
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

On Fri, 26 May 2023 22:47:58 +0200, Robert Marko wrote:
> Move SMEM item struct and related defines to a header in order to be able
> to reuse them in the SMEM driver instead of duplicating them.
> 
> 

Applied, thanks!

[1/5] soc: qcom: socinfo: move SMEM item struct and defines to a header
      commit: ec001bb71e4476f7f5be9db693d5f43e65b9d8cb
[2/5] soc: qcom: smem: Switch to EXPORT_SYMBOL_GPL()
      commit: 10615007483b6938da9df290fe5bf460f6a07c60
[3/5] soc: qcom: smem: introduce qcom_smem_get_soc_id()
      commit: 17051d2c3cd696439adb900e9af547ba162fb982
[4/5] cpufreq: qcom-nvmem: use SoC ID-s from bindings
      commit: 865d7e719262e9845a3c847040fbd4d84c8b5bd9
[5/5] cpufreq: qcom-nvmem: use helper to get SMEM SoC ID
      commit: 7d0f03d104e576da2a7689d0eb8560c67efc03ff

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
