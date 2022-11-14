Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5572D628C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbiKNWs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKNWsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:48:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A38FD135;
        Mon, 14 Nov 2022 14:48:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FCF0B815AA;
        Mon, 14 Nov 2022 22:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD37DC433C1;
        Mon, 14 Nov 2022 22:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668466131;
        bh=rZiO8iZy4/uE+ODGO5RTZb2K1BOcOBg2m0IscJfaxoE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=snWI9rHZRyYZI1J7KBFb6/Z9WPiFEGK+jbv9yTpx4ZghkUOzx0v+PVuBjD7oruqXy
         fuswg2ExAj1altPtwmbKNB5+TUD3Uy2Gu8l69YRh0mb66DwHUVnLtAxR8AyFJ8nfCJ
         3/RvoKzuTNvnPtXWmbWRFJUp1XemZkeK3PPYDDnY1zZpH1IO+eId5yNlnNrPepk8W7
         CwzLDxrXK1EwNixUxhT4wVy3SiaLp+KTZEG6d5epaezZS3CxST/UgjrBuz6spTMT98
         MUhrVWOPv0p1bDEQPyTfciDc1/AhT2J0xv1vbBLhd1HMFsgMhshtP5m4s9g8/8ce7j
         WhFMcUbqPG4gQ==
Date:   Mon, 14 Nov 2022 23:48:49 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Aditya Garg <gargaditya08@live.com>
cc:     "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: apple: Swap Control and Command keys on Apple
 keyboards
In-Reply-To: <7AC64680-44F7-4605-95E9-B5FF97A78D2A@live.com>
Message-ID: <nycvar.YFH.7.76.2211142347000.6045@cbobk.fhfr.pm>
References: <7AC64680-44F7-4605-95E9-B5FF97A78D2A@live.com>
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

On Fri, 4 Nov 2022, Aditya Garg wrote:

> From: Aditya Garg <gargaditya08@live.com>
> 
> This patch allows users to swap the control and command keys. This can be
> useful for the Mac users who are used to using Command instead of Control
> in macOS for various commonly used shortcuts.
> 
> Signed-off-by: Aditya Garg <gargaditya08@live.com>

Applied, thanks.

The number of module parameters the apple driver has been acquiring over 
years is becoming a little bit worrisome ... I am not sure that the actual 
users are keeping track. Is there any userspace utlizing it in a friendly 
manner?

-- 
Jiri Kosina
SUSE Labs

