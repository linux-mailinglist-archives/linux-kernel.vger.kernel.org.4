Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B226022B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiJRDgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiJRDfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:35:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390F8A2A98;
        Mon, 17 Oct 2022 20:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61EAD61350;
        Tue, 18 Oct 2022 03:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E12C433D7;
        Tue, 18 Oct 2022 03:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062804;
        bh=1U+wxIcjtKmdUFTPt3VJpuMT4JvOkaudAevESL6iZNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghklexBes2WO4mgt2PmexKi/63fYRWfUBAX9duXmirdrfNHXcZM5Zc/LMwft1Q7ry
         fjQessYvhPiUkL6oEdkTIDeyWc6YMKWbKfD6Eh9DzJ1LRFWB0aMjuJuVVznYs7hvAB
         1r6mliZBm3hq4xt1sszlgZ0Le2E6jIMhokSpEiGvVtV7HtIsZlF6GiZzekPijBkU7Y
         mrXER5ORBAtJhoxI+FGiPWb0trv+Ibs0jspxKfIv0L4CyREVYkhUfnPOaBqGqpE5yM
         YkJBjqCghjtsVKKKrJGZZR/aCNPavOmkWmjOKqRhB+YfR9A1Nwig3MAImSowUCeYrO
         ipKoWJ+ruct5w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_bjorande@quicinc.com, agross@kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: rpmhpd: Use highest corner until sync_state
Date:   Mon, 17 Oct 2022 22:13:16 -0500
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
