Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EF9633A93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiKVKvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiKVKvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:51:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F381E55B4;
        Tue, 22 Nov 2022 02:51:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B2D61644;
        Tue, 22 Nov 2022 10:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F9AC433C1;
        Tue, 22 Nov 2022 10:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669114286;
        bh=j8EkKONtu9VI51KdfaplORHs+ovLzoYv/jfWrltuok8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CjSs68FHPfvg9L1U5vgdwvlOfMJzvs8f3NyzCFsltW6huRNqDZOZ5E9LgI/WgUWYp
         khSy27N8gFJmlelW3FvhQmQ1sdvYoTCPrQEMwx96NhzxIfFihuZW/IgkbNGIiAzm8K
         g4MArKY08gBM4VMETb9KlX+ydv4NJwL0Ncy4W79XwaGuCQTLqIClTgq8fbcCT1j5iY
         FRjnQSL6kYpkZVFunhVmrzUAWloxnNZFg5TCPLi8OfolnXksNumOehnO5ehhXCsle2
         BPJcq5ShsBE6wBcoSWpkYPKvLPYSPV2BsgVLA7Frxboqikm3hkfNxq/S2fyw4lfXM4
         DG0LPWQ5NHuAQ==
Message-ID: <6dbcd2a8-f6b7-8bb4-661d-ff878ffac172@kernel.org>
Date:   Tue, 22 Nov 2022 11:51:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] tracing/osnoise: Fix duration type
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1668692096.git.bristot@kernel.org>
 <a93d8a8378c7973e9c609de05826533c9e977939.1668692096.git.bristot@kernel.org>
 <20221122071805.49e316a39fb86859b5a3156d@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20221122071805.49e316a39fb86859b5a3156d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 23:18, Masami Hiramatsu (Google) wrote:
> On Thu, 17 Nov 2022 14:46:17 +0100
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> The duration type is a 64 long value, not an int. This was
>> causing some long noise to report wrong values.
>>
>> Change the duration to a 64 bits value.
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks, Masami!

Btw, this patch can be applied independently of the other as a fix. It
is only here because I noticed the problem while adding the features in
the next patches.

-- Daniel
