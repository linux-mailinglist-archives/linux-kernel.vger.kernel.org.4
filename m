Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A1474A8A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGGBtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjGGBtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:49:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE251FC9;
        Thu,  6 Jul 2023 18:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=pEVMLSMYDQxRiJYG+rwHNMSmMLxLLc++koHVoQM60Xs=; b=FRPacSz5lBXg+xPeRhTVEM+ODm
        v1M2gKfoCg2XqXYWAKEW/qkg2X4r4FH+LulacIpki/1NJroJfDDn0LNMuNl04m6egzJ13U1zcaTnX
        JfYCwgq30s9DzrD2by8r3zVDgjEBMpcEktn6dXBNQcRw8nNJ1eRwTEv/eT8I08/5QkQSnZyoTWRhG
        0jFN3bOQ5qRhAjuzcNbXGboVT148n5wEUcT6bmVysRdGMPB2UT2rXRs78U5iJ/JG9fciYVKvkummm
        8RTOov6fmwpqINKNbV2zC3pQ1nZRtq0tw3f0ycnyesQWuLEsnpHHaDskdBk//ngLeguRvln2WkcoT
        aMpanIMg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHaaX-003BLn-2T;
        Fri, 07 Jul 2023 01:48:49 +0000
Message-ID: <9e770151-698c-0efe-8ea2-495f1ae54931@infradead.org>
Date:   Thu, 6 Jul 2023 18:48:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: unable to boot when monitor is attached
Content-Language: en-US
To:     "Dr. David Alan Gilbert" <linux@treblig.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        primalmotion <primalmotion@pm.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>
References: <5eb57bfe-94a4-136b-497e-deeb31846db1@gmail.com>
 <ZKdgMs2ChLnJ3U8n@gallifrey>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZKdgMs2ChLnJ3U8n@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/23 17:45, Dr. David Alan Gilbert wrote:
> * Bagas Sanjaya (bagasdotme@gmail.com) wrote:
>> Hi,
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>>
>>> In the latest 6.3 and 6.4, it is impossible for me to boot my laptop if my DELL U2720Q monitor is plugged in (USB-C). I have to unplug it, then boot. As soon as the first second of boot went through, I can plug in my monitor and there is no issue afterward. There is no issue waking up after suspend. Only when it boots.
>>>
>>> See the attached pictures of the trace. The trace itself seems random (at least to me :)). I tried several things, like removing any attached USB devices from the monitor built-in USB-hub, but that does not change anything. (there is a keyboard and trackpad attached).
>>
>> See Bugzilla for the full thread.
>>
>> Unfortunately, the reporter can only provide photos of kernel trace
>> (as he doesn't have any other means to extract kernel logs, maybe
>> connecting over serial helps; see Bugzilla for these attachments).
> 
> I note the photos have 'crud' at the bottom; as if something interesting
> is in the video ram; perhaps something is freaked out by this nice 4k
> monitor and some useful data structures are ending up in video ram.
> 
> (Also note it's a librem with pureboot)
> 
> Dave
> 
>>
>> Anyway, I'm adding it to regzbot so that it doesn't fall through
>> cracks unnoticed:
>>
>> #regzbot introduced: v6.1..v6.3 https://bugzilla.kernel.org/show_bug.cgi?id=217637
>> #regzbot title: unable to boot with Dell U2720Q monitor attached
>>
>> Thanks.
>>
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217637

So what are __pfx_worker_thread and __pfx_kthread?
Where are they from?

-- 
~Randy
