Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D1C66DD39
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbjAQMKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbjAQMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:10:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6D432E6A;
        Tue, 17 Jan 2023 04:10:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E2C461306;
        Tue, 17 Jan 2023 12:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E6BC433D2;
        Tue, 17 Jan 2023 12:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673957440;
        bh=qzB6Dzj1nRN+4AUETWyKdF1OATZeQ2+Z4Nnjn1uKXj0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=U6ITn3OYIySHW5OuM8/U1SPI2zsAXYEIyshYCDpSakViZJ42NivklcUeiX+ipNfeI
         qwKDSVZV8MhrnB5NivxHwmrUgc/zoF4CHVpD2CcZmEOTaQKojoOYRq52CisZCGk/44
         p+c/OsXQ6FT/mDR+4HiNF9UV/fbONawLJKX+E+PdPrLGP4QIv9MqwkN8XkcKv/4UJq
         EwkLyWWQiKYzMh9O7Q+UfcE7AZzSDiG/RLOhK9Gm1Zj4LWfnP8ENu+9Q4IUj4t3kl7
         1xfkiSaplWXqLeOrRHODIs71u0B4OqBOnWjpyiTBySCTxXHQ8ND67b08qd8hXxUjj0
         +tAEUQVbFAT6Q==
Date:   Tue, 17 Jan 2023 13:10:40 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pietro Borrello <borrello@diag.uniroma1.it>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Kees Cook <keescook@chromium.org>, Hanno Zulla <abos@hanno.de>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Cover Letter: HID: drop assumptions on non-empty
 report lists
In-Reply-To: <20230114-hid-fix-emmpty-report-list-v1-0-e4d02fad3ba5@diag.uniroma1.it>
Message-ID: <nycvar.YFH.7.76.2301171310140.1734@cbobk.fhfr.pm>
References: <20230114-hid-fix-emmpty-report-list-v1-0-e4d02fad3ba5@diag.uniroma1.it>
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

On Mon, 16 Jan 2023, Pietro Borrello wrote:

> We found potential misuses of list_entry() on lists in hid driver
> code that are not checked.
> Issuing a list_entry() on an empty list causes a type confusion making
> the list_entry point to the list_head itself.
> The most impactful seems the missing check for an empty list in
> hid_validate_values() which is supposed to check the validity of the
> reports themselves, potentially affecting all the drivers that rely on it.

Both applied to hid.git#for-6.2/upstream-fixes. Thanks Pietro,

-- 
Jiri Kosina
SUSE Labs

