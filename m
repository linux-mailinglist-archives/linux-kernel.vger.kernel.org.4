Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD96907E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBIL4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBILz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:55:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B15BA51;
        Thu,  9 Feb 2023 03:45:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74909619EE;
        Thu,  9 Feb 2023 11:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD9FC433EF;
        Thu,  9 Feb 2023 11:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675943133;
        bh=dH8XaQHJB4uPeHKhOyFk1VUj80gjnk+DfBL+3NPdqn8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rpw/wlYN5r8oMGPKg5J3BT1OFzjCDa10Z0gciJ5zGI+IjMLqlE3EXWLYPEy9FiQLZ
         SJsaoL6FbSIuQL88NhXYRvmyrLH/wBFooLRJEGT0TIa2/aWW868uAyBIY42/WHTnsg
         7YfqkQOZ/CgjKNPOwLK3vkcyAg+Bt9Vi+Dy2HxHs9T0mnt6OAAI/wQcihFWd6kLehO
         ccVg2qWfqPXM3RoIEAsd8EtR9yFHgzgbNnLO0kEkBFlBc3nHAlo9DmujSQSlaGgYl0
         ON/R8IscJLvsJpe7CdKsLw18xVMJKsWD3JQ3H/SdUWjpxoScGwy/tFwqrFQQIsc+3F
         96nqA+kapv93A==
Message-ID: <ac5e8ede-2a56-4a7c-b4c7-77dc6216a194@kernel.org>
Date:   Thu, 9 Feb 2023 12:45:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 20/24] Documentation: trace/rv: correct spelling
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230209071400.31476-1-rdunlap@infradead.org>
 <20230209071400.31476-21-rdunlap@infradead.org>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230209071400.31476-21-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 08:13, Randy Dunlap wrote:
> Correct spelling problems for Documentation/trace/rv/ as reported
> by codespell.

Many thanks, Randy!

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel
