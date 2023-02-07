Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE7868E1AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjBGUEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBGUEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:04:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12AF40E6;
        Tue,  7 Feb 2023 12:04:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AA1DB81A5F;
        Tue,  7 Feb 2023 20:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2DEC433D2;
        Tue,  7 Feb 2023 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675800250;
        bh=spXGcRITlzZsmIWoKS2TkuRS9qUvnB+x6JOvZgMMNAI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dh+K6viW+dMGv7YSc1JLJQ7NGvcSdn8F83DZ65YOr4ZVMl+b2wb98yvx/apg28E/q
         Z2JMCt60I6aosfJeBbDYx92mz0MtKBYPfKUMkM+ECDihLgeWPoccwm0ictb50QEpHd
         r6rOvsusiF7D1ddX+6xUsylzBstAbU2wHyFIZu5OJ1Nf4QR0VVUWObI/qLc6d9xOCc
         Mthooe17N5LjdB6VfrO+ZsSQaAoXIWdXNLjzsX9mM+MwYr2nysOeC8Sr8+KqbDOfVq
         8wCKhE6lMjsQDTxD4N6zBd28ukeC9pOc4Xmjtm25YKH30jZu+2tXW6nnFqip1ey4qB
         7cJxvP5SJR5pA==
Message-ID: <af58737f-1d0f-06f3-be68-8b5cae284cf0@kernel.org>
Date:   Tue, 7 Feb 2023 21:04:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V2 1/6] rtla/osnoise: Add helper functions to manipulate
 osnoise/options
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1675181734.git.bristot@kernel.org>
 <930c4ef71c7bcb1158d2a8cad905f4de425b8d1e.1675181734.git.bristot@kernel.org>
 <20230201142305.4920f893@gandalf.local.home>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230201142305.4920f893@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 20:23, Steven Rostedt wrote:
> On Tue, 31 Jan 2023 17:30:02 +0100
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> Add some helper functions to read and set the on/off osnoise/options.
>> No usage in this patch.
>>
>> In preparation for hwnoise tool.
> 
> Honestly, I don't see why patches 1-5 isn't a single patch. It's not that
> big of a change, and everything in 1-5 is to do what 5 does. Breaking it up
> this fine grain isn't helpful in reviewing, as I found that I had to apply
> 1-5 and then do a diff from where I started to make sense of any of it.

Maybe what is missing is a clear:

In preparation for hwnoise tool.

IMHO, it is easier to understand by using small "logical" pieces in preparation
for the "conclusion." But I see your point, and it does not hurt :-).

I will reduce the number of patches.

-- Daniel
> 
> -- Steve
> 
> 
>>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> ---
>>

