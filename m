Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C614768133B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbjA3O32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbjA3O3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:29:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34549113F7;
        Mon, 30 Jan 2023 06:28:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD83661163;
        Mon, 30 Jan 2023 14:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2CAC433D2;
        Mon, 30 Jan 2023 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675088882;
        bh=zDEpKXiQZZeQ0gghTvngUyxYlTUM0N1+OMsn3yXX99Q=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=I1AH8Y32a4ZMkfId4seR29Oldpt+AL6LyyaUriZeeNN+qk8gifGT77tCEpg2doJ8/
         XKe2AyQTrCwaGeu7ssBWMuwD0kAiFg3os6g1iO+PlNu2jPcvnzavJv18zlyeUwssLZ
         YxIFBDgMZcnZFl72V+J0a/exBmpE6s3KoUdr9nC4aq6zYjxPQSnVrF8q3h/ar7nrbS
         2JjVYpED6ERVGVEg9Ty9uDwziOZDujhSyVY1a/2rh4+io0xViAI4nOXyX8CQwyp+AX
         IoOWM4LQ83dz3lGW5c4FzHNCt0cffe6s1xFILXdGWBlTKwOlwM0kwA6IKBpmZlh4s2
         YLL9IjzQSfnJw==
Date:   Mon, 30 Jan 2023 15:28:03 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     qi feng <fengqi706@gmail.com>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: add KEY_CAMERA_FOCUS event in HID
In-Reply-To: <CACOZ=ZWB3grJKn7wAZEZ0BDyN7KJF4VWUTNs-mPxeoW_oiR7=g@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2301301527100.1734@cbobk.fhfr.pm>
References: <20230109123216.4974-1-fengqi706@gmail.com> <nycvar.YFH.7.76.2301201849090.1734@cbobk.fhfr.pm> <CACOZ=ZWB3grJKn7wAZEZ0BDyN7KJF4VWUTNs-mPxeoW_oiR7=g@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023, qi feng wrote:

> Hi,
> Our Bluetooth Handle needs the focus function, which is missing in the
> current map
> If our setting is unreasonable, do you have other suggested values

If the device is under your control, wouldn't it be better to let it 
produce something more defined by HID standard? (see e.g. 0x90 -- Camera 
Control Page).

Thanks,

-- 
Jiri Kosina
SUSE Labs

