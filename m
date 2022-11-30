Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441FE63CDA3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiK3DAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiK3DAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:00:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9A6E571;
        Tue, 29 Nov 2022 19:00:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28D8CB819FA;
        Wed, 30 Nov 2022 03:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37295C433C1;
        Wed, 30 Nov 2022 03:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669777246;
        bh=IWQo4SSdovd7II4a3BN6Ku/F6HwhfznsqvyOPegEjQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSXLjOXClSrRHvhJSt+ogmAoeLAldynncH1XLRJ+ffjNT8UxKTDkEZ1oYPQpsZd9Q
         zr8jdwc42kmeFLnO2L/Ibj1J/S86zMjbP1BQNh6leYHwm5HKHFWsk7xrVpDd/iAisO
         m4puiGZCQs0k4eU0WmEu0BcBSFxb+dB3pAtqD8WiFz1Bqj19SslIgv6WhQCN4bggT4
         g7V7d4ZPGokkbMUIDBf3Zo4i8ggmwLKCHs9Scdqb/TZ6YnUCX6VzO9HN0wQDHPDcdz
         1nexwS2WGelmKLj+Cmh2pgutaoBM5Jsglopv2chsz03+Tr0ZAihvVge9Z6v02rXx2Q
         u773h4L2eUN+Q==
Date:   Tue, 29 Nov 2022 21:00:44 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sarannya S <quic_sarannya@quicinc.com>
Cc:     quic_bjorande@quicinc.com, arnaud.pouliquen@foss.st.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH V4 0/3] rpmsg signaling/flowcontrol patches
Message-ID: <20221130030044.hqp6vwovhgl37or5@builder.lan>
References: <1669658575-21993-1-git-send-email-quic_sarannya@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669658575-21993-1-git-send-email-quic_sarannya@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:32:52PM +0530, Sarannya S wrote:
> [Change from V3]:
> Fixed review comments in previous set.
> 

Please do list the actual changes that you did. This ensures that new
people can focus on the new areas, if preferred, and that returning
reviewers get confirmation that their feedback was addressed.

Thanks,
Bjorn

> Sarannya S (3):
>   rpmsg: core: Add signal API support
>   rpmsg: glink: Add support to handle signals command
>   rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
> 
>  drivers/rpmsg/qcom_glink_native.c | 63 +++++++++++++++++++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_char.c        | 60 ++++++++++++++++++++++++++++++++-----
>  drivers/rpmsg/rpmsg_core.c        | 20 +++++++++++++
>  drivers/rpmsg/rpmsg_internal.h    |  2 ++
>  include/linux/rpmsg.h             | 15 ++++++++++
>  5 files changed, 152 insertions(+), 8 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
