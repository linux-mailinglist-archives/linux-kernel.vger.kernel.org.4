Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7342B713252
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjE0D5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjE0D45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70216134;
        Fri, 26 May 2023 20:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DB4364D1E;
        Sat, 27 May 2023 03:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3EBC433EF;
        Sat, 27 May 2023 03:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685159812;
        bh=ulpBEbFWXS5MRLjQwXCE94VGL9oNIIxXW9RYDB3Clnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nO65IjCYmGbQ9i3xqd3P7j9EbsQbWJADutzfs/tiLNm3RXPSBP8x6zg+iw++7IMCc
         uuTMXYVGbFBaqt4jCzWE0j8QGhi1/ND5Lqok+KK39Srxg0G6B30E+/c/+131aoJ6PN
         SZX3EFeIQxImOAdjRN/puViuKPdT4lMFothLZs49A23otY9q6hd2APRP45CAq9p+Fy
         T3N9IwiIOjH6aaAt6gNiOMTPSTWWDNzAmXTp/+EIh+dR+uOxIoUeHz89FIXiRRawZB
         JDxQSfbjtJP74tvdRo/VDcP9iyVpAr7PmCdrg+qd/bT4aYDs6FOFQx7xWy2VBAZZF5
         EVNU4ovau+hcw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: mdt_loader: Fix unconditional call to scm_pas_mem_setup
Date:   Fri, 26 May 2023 21:00:34 -0700
Message-Id: <168516003597.405989.12052922115553427270.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526115511.3328-1-ansuelsmth@gmail.com>
References: <20230526115511.3328-1-ansuelsmth@gmail.com>
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

On Fri, 26 May 2023 13:55:11 +0200, Christian Marangi wrote:
> Commit ebeb20a9cd3f ("soc: qcom: mdt_loader: Always invoke PAS
> mem_setup") dropped the relocate check and made pas_mem_setup run
> unconditionally. The code was later moved with commit f4e526ff7e38
> ("soc: qcom: mdt_loader: Extract PAS operations") to
> qcom_mdt_pas_init() effectively losing track of what was actually
> done.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: mdt_loader: Fix unconditional call to scm_pas_mem_setup
      commit: bcb889891371c3cf767f2b9e8768cfe2fdd3810f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
