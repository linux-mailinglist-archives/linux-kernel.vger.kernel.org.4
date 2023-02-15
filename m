Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3912F697567
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjBOE2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBOE2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:28:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F3BCA12;
        Tue, 14 Feb 2023 20:28:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B731A619E6;
        Wed, 15 Feb 2023 04:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB7CC433D2;
        Wed, 15 Feb 2023 04:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676435287;
        bh=/L1o81djQfCsbCx2J3wixdS6atWd0MZPMT5Ksh+sWmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ctdDwUO4SUF/OIAte3b38LNHJoVHgk6RT9lsBnZ1vusp+l3fUIPm/FJmOWgYXaSNs
         okUUV4rmcwiSHFX03TTxZZhAvhPjdfjmL8iFKBbnm5aAkuZaRYEfD+AYSIf0ADHEmT
         mLYSkdbnlgfGDJLQYBWhcyPSjNgcy2UWrdxAJ78wjzeIZdr7v4uT5on209Y/UigqSl
         AdxNSB+F5UG8R2lYKGqOlpvz9PS4Kky1p2vWrpl+7uMGg0F3LhLcbDILqx2HhWR3Q0
         0yd360V927u7EYw7kEmjf2MRDdDKxcqYcB0hTtF63xlwsrOnOMnNjbguNum3bSCICi
         0c0S4NhTYQjzA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: glink: Fix GLINK command prefix
Date:   Tue, 14 Feb 2023 20:30:09 -0800
Message-Id: <167643540672.1154547.8151253623301887579.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214225933.2025595-1-quic_bjorande@quicinc.com>
References: <20230214225933.2025595-1-quic_bjorande@quicinc.com>
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

On Tue, 14 Feb 2023 14:59:33 -0800, Bjorn Andersson wrote:
> The upstream GLINK driver was first introduced to communicate with the
> RPM on MSM8996, presumably as an artifact from that era the command
> defines was prefixed RPM_CMD, while they actually are GLINK_CMDs.
> 
> Let's rename these, to keep things tidy. No functional change.
> 
> 
> [...]

Applied, thanks!

[1/1] rpmsg: glink: Fix GLINK command prefix
      commit: 4e816d0318fdfe8932da80dbf04ba318b13e4b3a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
