Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CB164CDEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbiLNQXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbiLNQXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:23:21 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95161CE3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RceYrgwe1XOpaAJQx3X6Pp0jD9QIBn/bhfAwKUMR+DQ=; b=IXnDh/+UDcyYKX4OTuPRIpDEk9
        TlARg8z/VvBe/5V32WdcNkg/TAlDLngtwYTRlnEzMEUtr5x8g4dia4+jAHqimOexqQYjPiVCo5mFd
        1g2N6TJAUpxHHbUBz3SfD2ZLD02GXIuHo68G5ShsYqMhjPsaih9hbK6DBtgnCPlvOb22Dsm1Nbkvk
        /hxyoR9hpbdxIPtfn9XOvn6wFXVB6e96iDiHCj09nor/hvdOweUWhi6JgEPOSuugwYTq9vVW90Kku
        bv4uDnByObs8YSIHFODoTtfn3bbGGRuxWltx5F56FN62k+l6hmC7QctkAAlEQ+dAsJVH0NMiYl7/H
        U+S9WEUA==;
Received: from 200-158-226-94.dsl.telesp.net.br ([200.158.226.94] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1p5UXL-003Jo4-9o; Wed, 14 Dec 2022 17:23:15 +0100
Message-ID: <63239502-53ee-45b6-8dd6-26479b225e60@igalia.com>
Date:   Wed, 14 Dec 2022 13:23:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [for-next][PATCH 6/8] ftrace: Prevent RCU stall on
 PREEMPT_VOLUNTARY kernels
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221214140133.608431204@goodmis.org>
 <20221214140209.346584113@goodmis.org>
 <b95f7a3d-429a-3564-fc9e-fa05d1d551df@igalia.com>
 <20221214111544.01660987@gandalf.local.home>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221214111544.01660987@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2022 13:15, Steven Rostedt wrote:
> On Wed, 14 Dec 2022 12:53:04 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
>> On 14/12/2022 11:01, Steven Rostedt wrote:
>>> From: "gpiccoli@igalia.com" <gpiccoli@igalia.com>  
>>
>> Hi Steve, would be possible to use my full name here, like: Guilherme G.
>> Piccoli <gpiccoli@igalia.com> ?
> 
> Sure, I haven't pushed to the next repo yet.
> 
> I found the reason it didn't go into my patchwork, and did a resend via a
> "redirect", and that must have changed the from address :-/
> 
> -- Steve

Perfect, thanks a lot for your prompt response!!
