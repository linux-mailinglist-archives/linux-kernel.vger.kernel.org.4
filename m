Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459986606A0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjAFSs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbjAFSso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:48:44 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D95D7D1F2;
        Fri,  6 Jan 2023 10:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1673030919;
        bh=3XmN6oeD1VcYxkdyM/Xe+kUR183VsWrkQGyGXz0WE7s=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=A269vLbwDzOem/okS5HwMyTOuzcZ/iVsmzcFjctQKmigXX80lCXxpNoVNUB7gLtOv
         ixbMe02FVn7Y3LpwNx8yObJ4+eR1qPqcQRp5VT/KyWbtGEiwUABnhJRxknR7XlGkfN
         WT3HofxdfCQvquSyJNA3vo9DFbu0Puf+Cq/uR41vcPmX1RzdcfU9NH0DetIgRZVi3r
         AS2G3Kd3a73olpIdvCFidHxQreT6JxKLTlYGQrtoyFezzsvgBGbg29p46o+iKbmL8X
         bVeehVFZTVlm0VU+dWHB5R7q1FQdkB/IRYwbA5jD5SWVgWYbM9x3ch/7D2QC7XmnmN
         ekvkWHNzlwFeQ==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NpXRW4V24zg2h;
        Fri,  6 Jan 2023 13:48:39 -0500 (EST)
Message-ID: <075db450-dc23-ff79-e1ce-1a8aad69f3e5@efficios.com>
Date:   Fri, 6 Jan 2023 13:49:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: rseq(2) man page
Content-Language: en-US
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, paulmck <paulmck@kernel.org>
References: <095c479b-baed-9d11-08a1-e698f59763d9@efficios.com>
 <425ddf00-24a1-bf02-29f1-937ba1545020@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <425ddf00-24a1-bf02-29f1-937ba1545020@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-06 12:22, Alejandro Colomar wrote:
> Hi Mathieu!
[...]
> 
> BTW, would you mind sending links to the previous submissions?  I 
> couldn't find them.  I know there are a few patches that we received 
> when Michael was on-and-off that I deferred for a later time, and never 
> did, and maybe this is one of those.  I tried to find such patches some 
> time ago, but with no luck.

Here is what I could find in my archives (from most recent to oldest submission):

https://lore.kernel.org/r/1094083824.1256.1591899797181.JavaMail.zimbra@efficios.com
https://lore.kernel.org/r/20181206144228.9656-1-mathieu.desnoyers@efficios.com
https://lore.kernel.org/r/20180919144028.10863-1-mathieu.desnoyers@efficios.com
https://lore.kernel.org/r/20171116151711.19001-3-mathieu.desnoyers@efficios.com
https://lore.kernel.org/r/20171115191316.828-3-mathieu.desnoyers@efficios.com

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

