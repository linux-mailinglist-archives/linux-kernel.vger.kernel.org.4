Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BD76EC8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjDXJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjDXJUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:20:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291ED2134;
        Mon, 24 Apr 2023 02:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87F946114F;
        Mon, 24 Apr 2023 09:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D3CC433D2;
        Mon, 24 Apr 2023 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682328030;
        bh=ipoHWLvKnKa/PRu7q7E6gwY/sRRafxPn6Q37QaSx5Do=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PXdDG73J9k03t/2BfbDLDHkMbLGFuBC3SOzdzHMQyu4t27FD3J1+e1+RJoB6Usyne
         IvCGnYWsrxmdNe6ubHLHionRfn51NZTHYHk3z0VajsKKQK7tLcSXzrel/P47k3CceN
         beHJCumnXkGo6OxBGBwezrkGuUjhz62oH5Aew4xSMUZY/869u8TYIz2/1gV9myXNQh
         4O1+sP0sC4BIJ8shhqWI1Iujr6asLgZgmE2yZlfyoxPKuoXJvjq42Gd9yYsXnoyzAP
         541XPjB1mn6BqkPt0m0MbFugdhm122jQFJm/rSLftqnbcVBh/U4EeqkhtbpzneYd2g
         oZM2wzFhhgYTg==
Message-ID: <384be1d5-c506-ac40-4302-1d029f1020cb@kernel.org>
Date:   Mon, 24 Apr 2023 11:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH][next] rv: remove redundant assignment to variable retval
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20230418150018.3123753-1-colin.i.king@gmail.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230418150018.3123753-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 17:00, Colin Ian King wrote:
> Variable retval is being assigned a value that is never read, it is
> being re-assigned a new value in both paths of a following if statement.
> Remove the assignment.
> 
> Cleans up clang-scan warning:
> kernel/trace/rv/rv.c:293:2: warning: Value stored to 'retval' is never read [deadcode.DeadStores]
>         retval = count;
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
