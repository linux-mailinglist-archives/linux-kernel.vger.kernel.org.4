Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F240E628C71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbiKNW6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKNW56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:57:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961FA19029;
        Mon, 14 Nov 2022 14:57:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4002CB815AE;
        Mon, 14 Nov 2022 22:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FB7C433C1;
        Mon, 14 Nov 2022 22:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668466674;
        bh=yYxb7lkhJQO3wOgQZvR1fzAfNCWNW6OMqcHmEYFa0sc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=XHgqF2WMU9e9gTvbjDNhsav42s9QwDRE+3h3EyKBVE1C3Lw2p2QyVL77BmNF597Y9
         FcCQbHnCfqbeL+RaKPbpo1D90V/Z4HLAKRzcgLyOe4FLu8kHQn3FeMCh11gGVAYnL0
         eKNga4zVtYEPLNRpMDcrUYG3DPIT0fdzWZ436E0QhWryooaZ+pfLd+er6+nGoa7EjZ
         RG7wQiJXonZgGTG/EfU4Gr9MsnfNZvjNEU5xFOVdGmT1qRnkgrMMMZIsowVeaXev4Y
         sFD6waWJQHR7b/pqWUkAdcDZlzQnB0sgsqTLDrEf3L8dcERvn43DHHAdxg+mdOKuLG
         8FA/87OAbMRhw==
Date:   Mon, 14 Nov 2022 23:57:52 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Anastasia Belova <abelova@astralinux.ru>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] HID: hid-lg4ff: Add check for empty lbuf
In-Reply-To: <20221111125511.28676-1-abelova@astralinux.ru>
Message-ID: <nycvar.YFH.7.76.2211142357170.6045@cbobk.fhfr.pm>
References: <20221111125511.28676-1-abelova@astralinux.ru>
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

On Fri, 11 Nov 2022, Anastasia Belova wrote:

> If an empty buf is received, lbuf is also empty. So lbuf is 
> accessed by index -1.

Good catch, thanks!

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: f31a2de3fe36 ("HID: hid-lg4ff: Allow switching of Logitech gaming wheels between compatibility modes")
> 
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

I've put the Fixes: line into the SOB/metadata space, and applied. Thank 
you,

-- 
Jiri Kosina
SUSE Labs

