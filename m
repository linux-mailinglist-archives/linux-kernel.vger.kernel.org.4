Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6EA619A5D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiKDOmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiKDOme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:42:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B1C10D;
        Fri,  4 Nov 2022 07:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5310EB82E10;
        Fri,  4 Nov 2022 14:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C825C433D7;
        Fri,  4 Nov 2022 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667572919;
        bh=nJm6GH0U61TT4nh8e052yvYCa0it0Fu7rmkzBsd5NkA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rjrYbGQvTJxw5YO6LUhTJ/nUgJ1M7T74oJkOiP9s4XMd0iMcYY+qBTl6aFZhYyefz
         4v4c7Suzash5l22hL8Gj98HwqN8uK1uNufRG3GraJHZFqCCoKMKvlCUa+YvZJOVb2V
         UzQNcNvLtWBO7feNtZDGT2g7yHt7lrf6+S9ONVNLoqbgY2KoUa4/BEz9Cm3HSZYJXV
         ZorrMVMs3gH1AusOdqNR5QR5AKa5TTSs67drBs3gVErPd/QYSLv32PTc+sBWmDX0LF
         ymL5CAkVzpd/YFd0vxzooGHIIPNjBdCg/3NcX3ti4NbHLMSh6TSAq1NyaNO37Qj8Vv
         4LtsjodS+HNbA==
Message-ID: <b4639b19-94e3-2128-643e-6a3a44a1d944@kernel.org>
Date:   Fri, 4 Nov 2022 15:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] rtla: Fix exit status when returning from calls to
 usage()
To:     John Kacur <jkacur@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Chang Yin <cyin@redhat.com>
References: <20221103135742.9523-1-jkacur@redhat.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20221103135742.9523-1-jkacur@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 14:57, John Kacur wrote:
> rtla_usage(), osnoise_usage() and timerlat_usage() all exit with an
> error status

missing .

> However when these are called from help, they should exit with a
> non-error status.
> 
> Fix this by passing the exit status to the functions

missing .

> Note, although we remove the subsequent call to exit after calling
> usage, we leave it in at the end of a function to supress the compiler

suppress?

> warning "control reaches end of a non-void function"

missing .

Yep, that is a problem, and agree with the solution (I am already doing it
in the rv cmd line).

-- Daniel
