Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B066A5127
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjB1CYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB1CYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:24:21 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4AF77C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:24:20 -0800 (PST)
Date:   Tue, 28 Feb 2023 02:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677551057;
        bh=7Qg+xKXJ1+25GUEC62BFoxzEycsCpM75zBRzi6+52RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=thqJyk1AOWmi9xcMyshzejT1V7M9gPqyNhiA513ttAVNNdepa2xk1npjqqNt1Y211
         s3MNbyqg4xyfi62CIIFQrOIQ6eReT6iTHH2bsiGWaDeW3I/obfGxJ4+yAk+3uxOISD
         k4DtOtIQ0m0qKLGa+MRHMqgBSBX2s5RiS8uhFtNY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v7 1/4] tools/nolibc: add stdint.h
Message-ID: <85e5fe90-4ff9-45f5-99d4-08ee737dfb51@t-8ch.de>
References: <20230228021136.13472-1-v@vda.io>
 <20230228021136.13472-2-v@vda.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230228021136.13472-2-v@vda.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 09:11:33PM -0500, Vincent Dagonneau wrote:
> Nolibc works fine for small and limited program however most program
> expect integer types to be defined in stdint.h rather than std.h.
> 
> This is a quick fix that moves the existing integer definitions in std.h
> to stdint.h.
> 
> Signed-off-by: Vincent Dagonneau <v@vda.io>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

One more nitpick (applies to all patches):

The correct order of trailers would be:

Signed-off-by: Willy Tarreau <w@1wt.eu>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Vincent Dagonneau <v@vda.io>

In chronological order.

First Willy submitted something, then I reviewed it and then you
submitted it.
Your previous submissions/Signed-off-by are superseeded by the last one.

See Documentation/process/submitting-patches.rst.
(Especially search for "chronological")

Willy can probably fix this up when applying the series, so a new
revision may not be necessary.

> ---
>  tools/include/nolibc/Makefile |  4 ++--
>  tools/include/nolibc/std.h    | 15 +--------------
>  tools/include/nolibc/stdint.h | 24 ++++++++++++++++++++++++
>  3 files changed, 27 insertions(+), 16 deletions(-)
>  create mode 100644 tools/include/nolibc/stdint.h
