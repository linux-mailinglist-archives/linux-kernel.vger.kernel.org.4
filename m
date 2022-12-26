Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128CB656248
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 12:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiLZLut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 06:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiLZLuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 06:50:23 -0500
Received: from serv15.avernis.de (serv15.avernis.de [IPv6:2a01:4f8:151:30a2::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBD0E61;
        Mon, 26 Dec 2022 03:50:18 -0800 (PST)
Received: from webmail.serv15.avernis.de (ip6-localhost [IPv6:::1])
        by serv15.avernis.de (Postfix) with ESMTPSA id A8407BDE8929;
        Mon, 26 Dec 2022 12:50:15 +0100 (CET)
MIME-Version: 1.0
Date:   Mon, 26 Dec 2022 11:50:15 +0000
From:   Andreas Ziegler <br015@umbiko.net>
To:     Slade Watkins <srw@sladewatkins.net>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: rtla osnoise hist: average duration is always zero
In-Reply-To: <CA+pv=HO1mvnN5XZHkWDjWr=NJHJZxjcstiY4qtJGJ6mfsqPfQw@mail.gmail.com>
References: <d7bb31547e9bbf6684801a7bbd857810@umbiko.net>
 <CA+pv=HO1mvnN5XZHkWDjWr=NJHJZxjcstiY4qtJGJ6mfsqPfQw@mail.gmail.com>
Message-ID: <a900f403176c0e806051efc0f34f2912@umbiko.net>
X-Sender: br015@umbiko.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.7 at serv15.avernis.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-24 21:17, Slade Watkins wrote:
> On Sat, Dec 24, 2022 at 7:48 AM Andreas Ziegler <br015@umbiko.net> 
> wrote:
>> 
>> -- Observed in, but not limited to, Linux 6.1.1
> 
> Wait, "but not limited to"? What does that mean? Are there more
> versions affected?

This was meant to indicate that the bug is not a regression; it can be 
found in every release since introduction in 5.17. Currently affected 
are 6.1.y and 6.0.y kernel trees.

Regards,
Andreas

> -- Slade
