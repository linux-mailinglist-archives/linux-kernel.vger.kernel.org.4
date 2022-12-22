Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E015654241
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiLVOBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiLVOA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:00:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F978643E;
        Thu, 22 Dec 2022 06:00:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C12F9B81D61;
        Thu, 22 Dec 2022 14:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2805CC433EF;
        Thu, 22 Dec 2022 14:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671717654;
        bh=mMJUumurLoq9HMhtBSrfesshi3z9lboXd0zA00aEbJo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=H9iO/VvWX3/N2WbTe1LCDvEzmt74OnGoRy50zSDRYaJpFyqpM/OAI4tkTN65bcFXk
         yFA1F+wEtKHMZUOOmn1asFEf9pnfjsBM+vXgH9DYPQ+iTbOiluGYo06xNFxjxh73Py
         szLLA92w6W22PedGGV6+x+TJDN9VOEFpWk1Rm7GWxJfPMDvR9rd1gvCOtYQnY3RKBu
         rVz53/OqyyfXcSnvtM70b4sxyurUM0rpNbNEDqg3aZcY/66Re7JByeqwvbwZbeaJWO
         gvEgNJdV4768rgbI6w+ZQSx2Zl4XmEqcnKfXniW9447/5hQkdRYN7vdL1TD68ctXyI
         wkiKPUD4m0Bpw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>
Subject: Re: [PATCH 0/2] Update the channel list if the change in channel flags
References: <20221222124221.30894-1-quic_youghand@quicinc.com>
Date:   Thu, 22 Dec 2022 16:00:50 +0200
In-Reply-To: <20221222124221.30894-1-quic_youghand@quicinc.com> (Youghandhar
        Chintala's message of "Thu, 22 Dec 2022 18:12:19 +0530")
Message-ID: <87fsd7zgfh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Youghandhar Chintala <quic_youghand@quicinc.com> writes:

> There are connection failures in hidden SSID case when the device is with
> default reg domain WW.
> For WW reg domain most of the 5 GHz channels are passive. When device
> listens to the beacon on that channel, the driver is updating its channel
> flag but firmware is not aware of it and firmware is not sending probes
> on that channels.
> Due to this, we are seeing connection failures when the device is tries to
> connect with hidden SSID AP.
> Whenever the driver detects a channel flag change, send the updated channel
> list command to the firmware.
>
> Youghandhae Chintala (2):
>   wifi: cfg80211: Add beacon hint notifier support
>   wifi: ath10k: update the channel list if change in channel flags.

If you submit patches again, please _always_ increase the version number
(ie. this one should be v2). Now there are two v1 patchsets and
difficult for maintainers to pick which one to take.

But don't resend the patchset just because of this. Hopefully this mail
makes it clear that this is v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
