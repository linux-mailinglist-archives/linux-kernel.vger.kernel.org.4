Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A5F62CD49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiKPWBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKPWBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:01:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C023F57B56;
        Wed, 16 Nov 2022 14:01:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B293B81D80;
        Wed, 16 Nov 2022 22:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AF0C433D6;
        Wed, 16 Nov 2022 22:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668636071;
        bh=mfKrZ8tATSZA5qSJwQFPA+KqxAXPJV+e+BMQU0b5UAc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dGSj/nTGaWRVMNLMa1SEQ7Mi2BSX8giEqei4aC/myPELxg9GvjcxuECOQYooMk5zE
         99EuZeb4Qa2wnMqlP4YOOj/V1aWUKaQQkeBTGy1hta4Rlnwg+qtRbJig9Iy1fQqsev
         vMnzOaEM4Bd/rXB2iUaoFGBq6NzWnSlLh5lWp+BRved+6bVRjPsP3SNlMA9mRObPVW
         ZEXjde8GLSTc9VF5m4vbhNZiQB2nR+k9PyIiF79qRcznJq+jDDLAUCIOYUIHorBocg
         K1vZBVhgEFR0Jj4h4tRVKlxLVS6Ttkqwcq7YhHUMCWzq1tW67C5iY/hmOCWMJ1c+Ab
         DCLXAnZu3vk6Q==
Date:   Wed, 16 Nov 2022 23:01:09 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: bpf: return non NULL data pointer when CONFIG_HID_BPF
 is not set
In-Reply-To: <20221116103110.1746497-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.2211162300500.6045@cbobk.fhfr.pm>
References: <20221116103110.1746497-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022, Benjamin Tissoires wrote:

> dispatch_hid_bpf_device_event() is supposed to return either an error,
> or a valid pointer to memory containing the data.
> 
> Returning NULL simply makes a segfault when CONFIG_HID_BPF is not set
> for any processed event.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I have added

	Fixes: 658ee5a64fcfbbf ("HID: bpf: allocate data memory for device_event BPF program")

and applied on top of the HID-BPF pile. Thanks,

-- 
Jiri Kosina
SUSE Labs

