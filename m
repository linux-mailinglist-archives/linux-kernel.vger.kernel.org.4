Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02156717D4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjARJeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjARJYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:24:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE28798CF;
        Wed, 18 Jan 2023 00:49:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74D12B81BB6;
        Wed, 18 Jan 2023 08:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649A9C433EF;
        Wed, 18 Jan 2023 08:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674031741;
        bh=YvCaTb+WM1z/jkE0eRVvRdXaotfkYrFvJyzz047AbI8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=RYVadmqaFiwuo8ltlbKzzttPYuuJ91PPCxm4CiOpnbV9GVB8VcvJnVVvn39UOfj5G
         GpDwsAmFLTjh9eYy5yd9eFtS0gP9CpPgKFnbTvOBYt6NVPJ5OFekCtX3QQyNP0/odn
         IouAiYWr9v8qtvEVQ8IEP/noMEvinEL8nCWLTVvnOV5YM+pnu884Me56BseX3IARhB
         1XhP/NYf1NJbPkA6KEICHzO0ntfUxcN9qZfItotT97dQNHWkHa801JKKmfvJonPG60
         ESH0ritSJcKb5CTFxmeo6qLOigJCwzsWUFA9eYs+iV9na4IOSezVrQYm7SOloqF5h7
         QdWDaPtC71Zrg==
Date:   Wed, 18 Jan 2023 09:49:01 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Adrian Freund <adrian@freund.io>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Luke D. Jones" <luke@ljones.dev>, Ivan Dovgal <iv.dovg@gmail.com>
Subject: Re: [PATCH v2] HID: amd_sfh: Add support for tablet-mode-switch
 sensor
In-Reply-To: <20221218214723.14735-1-adrian@freund.io>
Message-ID: <nycvar.YFH.7.76.2301180948450.1734@cbobk.fhfr.pm>
References: <20221218214723.14735-1-adrian@freund.io>
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

On Sun, 18 Dec 2022, Adrian Freund wrote:

> This patch adds support for the tablet mode switch sensors on
> convertible devices where that sensor is managed by AMD SFH, like the
> Asus Flow X13 and the Lenovo ThinkPad L13 Yoga Gen2 (AMD).
> 
> Co-developed-by: Ivan Dovgal <iv.dovg@gmail.com>
> Signed-off-by: Ivan Dovgal <iv.dovg@gmail.com>
> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Adrian Freund <adrian@freund.io>

Basavaraj, could you please review this? Thanks,

-- 
Jiri Kosina
SUSE Labs

