Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E26022B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJRDfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiJRDeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:34:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFBB2F39D;
        Mon, 17 Oct 2022 20:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5BDAB81C5C;
        Tue, 18 Oct 2022 03:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E5BC433D6;
        Tue, 18 Oct 2022 03:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062674;
        bh=1U+wxIcjtKmdUFTPt3VJpuMT4JvOkaudAevESL6iZNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hp0hXS7IzYhXIEUvpy1T0eGXw135NwfvykzGifUMrADbBLIa50RwvF3Vi5ZSzynp0
         f91kdCmext38b4WTynFo4Sy5fX9VwBAnbhnbPiVbXFloPfP3Nec17dNdoA2AT73TcE
         T3P2yimhlNooVNXBV2YJtYDz603gWDDrsmm6NjE+h1kD4+JFsxwwupn4jond3zaDjv
         gfLt4YoDQ9maSfgH1e0QxEQLmIEJWbG2dIQM2bHJFU6xZY/9durXYN1d4fq6wk7197
         qZrppOKu882envp3lN6SUiSzYDPmYSL15/wNaE2nQlG6PzecKSwmo812Utnl+8YeID
         RMT2AqiA7uACg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_bjorande@quicinc.com, agross@kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: rpmhpd: Use highest corner until sync_state
Date:   Mon, 17 Oct 2022 22:11:06 -0500
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
