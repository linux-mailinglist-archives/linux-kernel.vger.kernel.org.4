Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BA469756B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjBOE2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjBOE2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:28:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9474CFF13;
        Tue, 14 Feb 2023 20:28:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CF13B81FE1;
        Wed, 15 Feb 2023 04:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52351C4339B;
        Wed, 15 Feb 2023 04:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676435288;
        bh=LaHxlO/Lqk94HLe8G6u25TN7SKABfg5M/QlVM+MCs3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gi04b6ewaKyQP0hp+a24h4MXZmEzyTJDGfWVMB2Mw9J0SxwsliGXxKCXqmCK1e5le
         W7dAAnoYPS5NdaKqEY/rdR+AxZlQ3aHFIwS2TCiTbsvnz4fu5fx+QHyiwsKsbn6Lmi
         XU+r+eafj4/7Xv9Hzs7s3rCOiR4Mtm4/+/pmg6mSXkmReJnl58nPzZB1G3Gem+sSyU
         eO6zgVkbuVYwryRA/1jgShobyuOmfPDu3rrXgz8pNs6tycC/AxbOsWJP4bgyzfU8tF
         BQJz/K2PLJp4HIDayrKF/BE8tcvdvYhl17kSl+AuoJrR5ZboohSSm80EGW/wvPaHbX
         QaMd0Q75Yk0Fg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: glink: Fix spelling of peek
Date:   Tue, 14 Feb 2023 20:30:10 -0800
Message-Id: <167643540672.1154547.18139879334619462422.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214224746.1996130-1-quic_bjorande@quicinc.com>
References: <20230214224746.1996130-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 14:47:46 -0800, Bjorn Andersson wrote:
> The code is peeking into the buffers, not peaking. Fix this throughout
> the glink drivers.
> 
> 

Applied, thanks!

[1/1] rpmsg: glink: Fix spelling of peek
      commit: a8f500c68673d385b437da678aaf9ebba0ab9db0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
