Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7725F7DF0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJGTZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJGTYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:24:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECE912627;
        Fri,  7 Oct 2022 12:23:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D5F6D1F7AB;
        Fri,  7 Oct 2022 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665170581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5C9GlnWH2PQfTnwA7VvBSXTuKeGaXDov8qfQoZWnQ2Q=;
        b=NSxASkEeqmb+U2+NeQXIWzIbCesMTV+RHAhMCKOr0H3s97maz0aOjrmgkX8uo1VTkNH9LI
        Ga79KR7ZlBXfXZ7zjgDths0DLdumDHIrsU+QhB1//pQqC7Jz11kovTMzLiW95IPnQtAJjl
        OVXDonP3zma3FKPsZDNTWzsWb+6C54I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665170581;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5C9GlnWH2PQfTnwA7VvBSXTuKeGaXDov8qfQoZWnQ2Q=;
        b=iT/9+zw18bGxYwbsCqYfuJcGbFRaQ+xerYjzTkrnm+/GdF2xl1NzAlIvIativFbYg7ft0K
        yaotfZq2yfGM/GBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5999113A3D;
        Fri,  7 Oct 2022 19:23:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HZUFCpV8QGPCfQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Fri, 07 Oct 2022 19:23:01 +0000
Date:   Fri, 7 Oct 2022 16:22:59 -0300
From:   'Enzo Matsumiya' <ematsumiya@suse.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cifs: remove initialization value
Message-ID: <20221007192259.lte3xpsjneg352um@suse.de>
References: <20221004062333.416225-1-usama.anjum@collabora.com>
 <20221004142306.ysgh45nhgdo4z3ok@suse.de>
 <fbb39e4354434cb99b6f6731cab2e0c9@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fbb39e4354434cb99b6f6731cab2e0c9@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05, David Laight wrote:
>From: Enzo Matsumiya
>> Sent: 04 October 2022 15:23
>>
>> Hi Usama,
>>
>> On 10/04, Muhammad Usama Anjum wrote:
>> >Don't initialize the rc as its value is being overwritten before its
>> >use.
>>
>> Being bitten by an unitialized variable bug as recent as 2 days ago, I'd
>> say this is a step backwards from the "best practices" POV.
>
>Depends on your POV.

My POV was, considering "unitialized variables" is a _whole_ class of
security bugs, a patch to specifically deinitialize a variable is pretty
much like saying "let's leave this to chance".

https://cwe.mitre.org/data/definitions/457.html

>If you don't initialise locals there is a fair chance that the
>compiler will detect buggy code.
>
>If you initialise them you get well defined behaviour - but
>the compiler won't find bugs for you.
>
>Mostly the kernel is in the first camp.

My money is on the smaller unfair chances that the compiler cannot catch
even the smallest bit of complexity of uninitialized use.

Also, initializing something to 0/NULL will, most of the time, if at all,
be "just" a bug, whereas an uninitialized variable bug might turn into a
security bug and even go unnoticed for years.

Anyway, this patch got merged and I seem to be alone with this
concern...


>	David

Cheers,

Enzo
