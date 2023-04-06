Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E18D6D8DA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjDFCty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjDFCtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:49:36 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D751AD39
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 19:46:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id F22DF604EF;
        Thu,  6 Apr 2023 04:46:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680749200; bh=My+Xx8qnBNE+sWvp8e43sgjINqFil3fDL+5IiLrFkjo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=g0hBUS/jlVtWeXGqbOagmK6mwl/40AXeRAUll74sk0IiPd7zyu/fAL9qlUrPQqk9u
         up+OVXYrBfWuFZAWPWeqNdGghsrH/cKr0MZWcJt3TDWml/iOvX19JqUyVhF7EteyCk
         nrZOAA73f17JZYOA8zOIg3IK5tsHjUQVfz0MINI+rbIlVoi/72SEa/w7Mjq8hi0LBt
         j//kEp22VMzJJolfBU/Ino9SNhNQBQY3EHnjbzQtVKBN6HxJFZ7QzOpGD77ChUCnJE
         Arar+Z/qwFYyzUL/asyCE/GXPrNEsL3rANtntYrLllAW4tsOvqHj1X2E8dcsiiCCf7
         EbOuIGPcsY90g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id liSTa8_JLyKo; Thu,  6 Apr 2023 04:46:38 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.188.177])
        by domac.alu.hr (Postfix) with ESMTPSA id 240C0604ED;
        Thu,  6 Apr 2023 04:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680749198; bh=My+Xx8qnBNE+sWvp8e43sgjINqFil3fDL+5IiLrFkjo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=byLqwb0MFMv/ibkHpPiYLHWpGeA2w+dSu+7vMMosi/azzjLEqli6ZylFXdJ/F6vem
         Y4S4c0zGBtpnUdEZWhJ9Rq/fgiSiImYW1TShKfRVPrqeFaCPTv1utjPrag3vpnBzX+
         +VR0oelcsj6p2zLJ4dj4kn31dJRrFp42Qe11+Bl9w8hLt3RkU9zDFZmobdEegmw91C
         hRYuehFkF19LA+IjCLG6FDD0tvNqk12VOQAe+aNbaF5huBiOop6BaRmsk0GnFEzPYK
         QP5g1BLTrt8MXSdUDwV4pdBaNN+2e0iygsvu8WvoZpXDqN7N+Y3t1tKvdJowEtrnh/
         RUerkibqKKNDw==
Message-ID: <fbbdc526-308b-32e6-75dd-05543e0a2129@alu.unizg.hr>
Date:   Thu, 6 Apr 2023 04:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/2] Revert "lib/firmware: fix a memory leak with
 multiple calls of trigger_batched_requests_store()"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
References: <20230406014324.31171-2-mirsad.todorovac@alu.unizg.hr>
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230406014324.31171-2-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 04. 2023. 03:43, Mirsad Goran Todorovac wrote:
> This reverts commit d59ff9027c628f0e9be344b28f3576566a274f2f.
> ---
>  lib/test_firmware.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 51377b9ab6e3..454992bfdb2a 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -1036,11 +1036,6 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
>  
>  	mutex_lock(&test_fw_mutex);
>  
> -	if (test_fw_config->reqs) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
> -
>  	test_fw_config->reqs =
>  		vzalloc(array3_size(sizeof(struct test_batched_req),
>  				    test_fw_config->num_requests, 2));

NOTE: This was sent by an accident with the patch sending script.
Please ignore this erroneous patch.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

