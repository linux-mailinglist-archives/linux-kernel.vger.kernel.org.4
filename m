Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2786F48A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjEBQvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjEBQu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:50:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B11BF6;
        Tue,  2 May 2023 09:50:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 23E7544A;
        Tue,  2 May 2023 16:50:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 23E7544A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1683046256; bh=tCSPNCpvcve/k22DjTIu5RayNrviaTp6n/wonrqJyFE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KFC7nX7EUzpQhIRdzVOT4yaswRMhBNZeg+5E5j2cTeFanFqNpSUN1RXa67M6eVdeF
         W3DZ5+53H5a/s8DERYYwemZT+C0sN9C7YrzxVlBLiASDHh5dXBrzKWUi10NpmhuI6E
         y8oU7sPjMHmm20WTIcX1axVqlpbK/4NVuTJgstcEJl6Skik0LGyHR83hmUBdanjrSo
         o5bAGgtzzU7cgd4hVWKz8vowAFRC173aMcHmZHFVY8uR858ojIds6NKtc36TqefISw
         dmL3Rw2us9Al/Vj+Dp8G2N9nApE8GLtvddEIqFZZlCpMTnWN0NW1UVoGt726/G8hS6
         xs/yaYFMQuwOQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Stultz <jstultz@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] Documentation: timers: hrtimers: Make hybrid union
 historical
In-Reply-To: <87v8ha4tvh.ffs@tglx>
References: <59250a3d1c2c827b5c1833169a6e652ca6a784e6.1683021785.git.geert+renesas@glider.be>
 <87v8ha4tvh.ffs@tglx>
Date:   Tue, 02 May 2023 10:50:55 -0600
Message-ID: <874jou8yog.fsf@meer.lwn.net>
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

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, May 02 2023 at 12:05, Geert Uytterhoeven wrote:
>
>> Non-scalar time was removed from the ktime hybrid union in v3.17, and
>> the union itself followed suit in v4.10.
>>
>> Make it clear that ktime_t is always a 64bit scalar type, to avoid
>> confusing the casual reader.
>>
>> While at it, fix a spelling mistake.
>>
>> Fixes: 24e4a8c3e8868874 ("ktime: Kill non-scalar ktime_t implementation for 2038")
>> Fixes: 2456e855354415bf ("ktime: Get rid of the union")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Applied, thanks.

jon
