Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0201602251
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiJRDMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiJRDKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:10:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD579B84D;
        Mon, 17 Oct 2022 20:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDF0C6120C;
        Tue, 18 Oct 2022 03:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83D7C43141;
        Tue, 18 Oct 2022 03:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062449;
        bh=1U+wxIcjtKmdUFTPt3VJpuMT4JvOkaudAevESL6iZNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+2LkNun7XLdqHcY+98encUZhGoXNYRxYMUT4VekGEgqV+K+1L10A1Qyvd8WqXOLN
         9hbA4y/j/hdlAZ2hX26CI9X38TF5swykurdqJbSZJ32tXxLKI1ni79uGVvQgZKwXt2
         LkGB3jAbW7n8B4lngYBTskX3XMi0Qu84VwHgO/kZOE6FkM7ljNR4va+7XHg5B7BXL7
         S6XUHc2s5Msvj7g/4qjDFGOnyGTOpkqLXqqZJTqY9IzlJKc2zje7WV3Vi0yVjxv8Bk
         z422ZyC7cdTIoA4svuWcyk2Oa4BmLfSTlcF3FFqZ+dmF8ayY4tbZf3kxWAts4xcWVW
         OJxJb/5CsrLqA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_bjorande@quicinc.com, agross@kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: rpmhpd: Use highest corner until sync_state
Date:   Mon, 17 Oct 2022 22:06:02 -0500
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
