Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4126585BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiL1STF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiL1SSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:18:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAA4175B4;
        Wed, 28 Dec 2022 10:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CB70B818BC;
        Wed, 28 Dec 2022 18:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1A6C43392;
        Wed, 28 Dec 2022 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672251519;
        bh=lrZY2fsTFYfQj4eVl3mncxZwaKUp972COk8fahv6UvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHDraBv1GIIuM9H6jtWMKo3NO/fuwbqZ1VXb4oMj18v2h1d481zgdmbLAc1k2plI/
         vBXuTnD+hxnn/MOkN+TBZO9mMT7dOdZYzqAHgjKOT+41t+AiTYbIZjuYwax/+nZM/k
         7IGWh3ThC8GGAwWm45vgqnRQRU/aPwqr2NClUcZUswLluIz8X5kPOBDHV2PwJNLwBd
         D5TIveEjdZACuZD4o/rcVCglplMmxwNVMlRqVAOfF2R+urCcedLj5jAFLXG47dOOOP
         hQOaCphqIamwEzcaQWLIDH7o5LF4XUh61TCGWzexhEzmtQ4iaA1JkPqm34Var9oq1d
         wFy+aMTMgXkAg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mathieu.poirier@linaro.org, swboyd@chromium.org,
        quic_deesin@quicinc.com, quic_clew@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>,
        arnaud.pouliquen@foss.st.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: (subset) [PATCH V4 0/2] rpmsg_char/ctrl driver fixes
Date:   Wed, 28 Dec 2022 12:18:28 -0600
Message-Id: <167225151225.950465.10463243136528744031.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1663584840-15762-1-git-send-email-quic_deesin@quicinc.com>
References: <1663584840-15762-1-git-send-email-quic_deesin@quicinc.com>
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

On Mon, 19 Sep 2022 16:23:58 +0530, Deepak Kumar Singh wrote:
> Change from v4:
> Corrcted mistaked in commit message for patch2.
> 
> Deepak Kumar Singh (2):
>   rpmsg: glink: Add lock to avoid race when rpmsg device is released
>   rpmsg: glink: Add lock to rpmsg_ctrldev_remove
> 
> [...]

Applied, thanks!

[1/2] rpmsg: char: Add lock to avoid race when rpmsg device is released
      commit: 17b88a2050e9d1f89a53562f2adb709a8959e763
[2/2] rpmsg: ctrl: Add lock to rpmsg_ctrldev_remove
      commit: c23965b7f7d99bbb2604f1f02aa26fb6d1d5864d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
