Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75526E68F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjDRQGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDRQGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA63B762;
        Tue, 18 Apr 2023 09:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F037063642;
        Tue, 18 Apr 2023 16:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0693C433EF;
        Tue, 18 Apr 2023 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681833976;
        bh=t22GjGkZwDeAKMFoBEgsyk9Z0FcAW9MXYWyHPW5hHPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPlzolzOori3SNOi4w94HukBt49miBVHP82jKfXL9wMQiiWe2D5HeJvf7plZiLQTQ
         anMgcYP1aazTOw3uuGfzxzen2Oe0UjfQAhIZYo420bHPUjRebeGprC25MLhdEFXZI9
         slDSYGYoshvN4+zwqi6xeO1G8sEwSutkNfac7yPa7fTrg5qxlSRnJEqTIzt5Dlzz2d
         D790fUkNrvLylzbqiSWESp7XUgUO1rdDYivBNJjyiy77nP0QPjMrB81SVExgTeZFyi
         XKwJcfzBwtwDuwMIKoGQSrw+FeXEIVYx1UOeWdEHo++yY5HLjy7aocuaNDaGuf8Uow
         3iIU9JcKcT30g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     swboyd@chromium.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com, quic_bjorande@quicinc.com,
        quic_clew@quicinc.com, Sarannya S <quic_sarannya@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 0/3] rpmsg signaling/flowcontrol patches
Date:   Tue, 18 Apr 2023 09:09:47 -0700
Message-Id: <168183418159.1484313.2492339947490878263.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1681807721-32343-1-git-send-email-quic_sarannya@quicinc.com>
References: <1681807721-32343-1-git-send-email-quic_sarannya@quicinc.com>
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

On Tue, 18 Apr 2023 14:18:38 +0530, Sarannya S wrote:
> Added new IOCTLS- RPMSG_GET_SIGNAL_IOCTL and RPMSG_SET_SIGNAL_IOCTL
> to get/set the rpmsg char device's flow control signal.
> Update the cmd name 'RPM_CMD_SIGNALS' to 'GLINK_CMD_SIGNALS'.
> Addressed review comments to change variable names/descriptions.
> 
> Chris Lew (2):
>   rpmsg: glink: Add support to handle signals command
>   rpmsg: char: Add RPMSG GET/SET SIGNAL IOCTL support
> 
> [...]

Applied, thanks!

[1/3] rpmsg: core: Add signal API support
      commit: cc7c3bc62c6c74c217ea73e30a135fd2c3affb34
[2/3] rpmsg: glink: Add support to handle signals command
      commit: 96a7a78517751f01c2a3aeef46768159aca370fd
[3/3] rpmsg: char: Add RPMSG GET/SET SIGNAL IOCTL support
      commit: bdae2e497fd6cb1de0f142f3c64d89a38e3576e3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
