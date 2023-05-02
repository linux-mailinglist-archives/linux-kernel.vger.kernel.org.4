Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E16A6F48C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjEBRBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjEBRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:00:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198702D6D;
        Tue,  2 May 2023 10:00:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B5BEC44A;
        Tue,  2 May 2023 17:00:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B5BEC44A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1683046856; bh=H6+Fc2M0+KSsE5dhxLBiphFubGSgN5wwk4SXjyToF9g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=i0tL1/PawO8IO/CFYX1tAcsvIdkc7HDNyqN1bYwH/A7AlujZ+8Z31dd/fWcQX+H//
         4GQv2ISdsGutJEdoF1ThX1f+Gjoz8B21brWBaL+DDoUkySb72pnuVdmjmlhHmrWA+A
         oAunACSPH3HJIeAXL8Wu3XzISjMyWtojXSG2oUM9CsXpH6gTX6wKtc0z/cemle2yB+
         4hB/3BXafBt5vRGvHkD2IgejZcjCSz8we96D8BetlUa9D0TWG8XBX/cvHntMtXOD1/
         V/U/si3nfS+jKTIOxtGU8+pHoI0BpOvOsBhAm9qzwNGWuSCdiQn10GhgbA2FNaH4c6
         WXz5qDIN0DXDg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mat Martineau <martineau@kernel.org>, linux-doc@vger.kernel.org
Cc:     Mat Martineau <martineau@kernel.org>, mat@martineau.name,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CREDITS: Update email address for Mat Martineau
In-Reply-To: <20230502000545.2899055-1-martineau@kernel.org>
References: <20230502000545.2899055-1-martineau@kernel.org>
Date:   Tue, 02 May 2023 11:00:55 -0600
Message-ID: <87mt2m7jnc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mat Martineau <martineau@kernel.org> writes:

> Changing my email address in CREDITS to be consistent with what's in use
> in MAINTAINERS and mailmap. Also removed extra date information from the
> CREDITS entry since I'm a maintainer for MPTCP again.
>
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> ---
>  CREDITS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon
