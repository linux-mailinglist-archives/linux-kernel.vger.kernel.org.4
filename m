Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757D96489F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLIVRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLIVRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:17:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E85123E8B;
        Fri,  9 Dec 2022 13:17:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 081526226D;
        Fri,  9 Dec 2022 21:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0215BC433D2;
        Fri,  9 Dec 2022 21:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670620622;
        bh=saO7znyvoBW4vtLBcM2xx1LrnH9b1g7Bnb6NG2yxEkU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R/rQRIQ0b2HSNshynl4q1bxAS0Wd5AVXIraXKGgbKvr5cmbFU2Vo6Om8X5FK9ZFLx
         vKuqRT7SSUHliVQHK894q2RvO9PC4fbOrh1fEYwLl9b+Rjm9aLoz9OdDPO9TsqY5RB
         KG1ypJQs8G4ogEOWQSTNVFafV0aX2msH65tltDtAMvWJY8gnq/XAq09CdxtQi5GJ7E
         JLZ1IxgH0Iq3keRwWU+e1167NsTnKMW9YKOe0PwBpGTIyGIrdGb9y7rhA+c0BDfcv1
         qqPyCuqEtfhLM3XGNVMy/nc5b2JeSywEmgg3Aj8bthJHGUO9bcErRB4Z8Iymv7KLZH
         4cpeSM0b+wNJg==
Message-ID: <a91587c2-7faa-f23b-c472-f65dc5cdaae7@kernel.org>
Date:   Fri, 9 Dec 2022 22:16:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V4 2/3] tracing/osnoise: Add preempt and/or irq disabled
 options
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1669832184.git.bristot@kernel.org>
 <ded51c4490cf0cdce4e73e448c77bef9c35d257b.1669832184.git.bristot@kernel.org>
 <20221209153552.4c7099cd@gandalf.local.home>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20221209153552.4c7099cd@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 21:35, Steven Rostedt wrote:
>> +	if (preempt_disable)
>> +		preempt_disable();
>> +
> The only reason the above works is because preempt_disable() is a macro.
> If it was a function, then it would likely fail to build (as you are
> overriding the name with a bool variable).

oops.

Sending a new version changing the variable name.

-- Daniel
