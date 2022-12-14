Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E44364C184
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbiLNAxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiLNAxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:53:01 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE0510FE3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zy3O73fmfvkrnYLmlTlp/aoV2gFGdC6nGas691zCLP8=; b=fmjsM/EHeugv7EwGMVJgsXUfds
        2WKC38xXRxFME3vrfBE5Lbp5x5fpiUfSp80hybiDOSDEa0AAtp7oqeXtyemj/YeTQX64hwwXxGFcm
        YbanrvYNrH2QdbBRPfZIjLH5LKVScJVuvhWwIvKQr2rCkU9ptKGB8oNMCr4WC17iQtdxv06cAZv5T
        jx8hOviVnM0Q3cisjPR64jNSldYgG/wsf8Bnwd3zW7CcalMIkQl4d5ig4sI4c0N40qnTWC9dUPS3T
        NcVu4sPOCQjCC9NrTFWSE+Ph9mnNl/rDXo7UJ9aG8glQuyTMU2oAJikPK1YAllTLzQAs8TbpzTF46
        OFQnLSAw==;
Received: from 200-158-226-94.dsl.telesp.net.br ([200.158.226.94] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1p5G0x-002tOW-O7; Wed, 14 Dec 2022 01:52:52 +0100
Message-ID: <ab0da0ed-044f-9347-a309-5c5ccf402437@igalia.com>
Date:   Tue, 13 Dec 2022 21:52:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V3 06/11] tracing: Improve panic/die notifiers
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-7-gpiccoli@igalia.com>
 <20221020172908.25c6e3a5@gandalf.local.home>
 <f29935e3-e3b6-2d4e-7fc1-267e1ef0925b@igalia.com>
 <20221213190656.3c229b73@gandalf.local.home>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221213190656.3c229b73@gandalf.local.home>
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

On 13/12/2022 21:06, Steven Rostedt wrote:
> [...]
> Heh, yeah, I forgot about this one too.
> 
>>
>> So, do you think it's possible to pick it for 6.2? No dependency here,
>> it's a standalone patch.
> 
> I can pull it in.

Awesome, thanks a bunch!


> 
>>
>> Thanks again and sorry for the annoyance!
> 
> No, sorry for missing these.
> 
> -- Steve

No biggies =))
