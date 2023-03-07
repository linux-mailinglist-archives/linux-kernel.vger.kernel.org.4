Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BB66ADDDC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjCGLpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjCGLpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:45:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DC8193CD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:42:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2776A1FE1A;
        Tue,  7 Mar 2023 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678189324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfCj1neJmCfrUUT47ZTKFAGgBx7IRsC7B39zh/pZjJY=;
        b=jxnOzSkkr5lkAr9qQ5rP6QSJxhoITzp3JhsC5Ul3YRJoDOKIG7W3hfXM1dA/htQNqqp5vp
        3KyKQcUtPkSTmnSMdfG4eikDYQT9Dp2wY0VNy9qVGykhugTBuczRxARXzDFgF8/FMYRHWA
        MsZ7rcFab88U9sENderRWcdjhWY/SRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678189324;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfCj1neJmCfrUUT47ZTKFAGgBx7IRsC7B39zh/pZjJY=;
        b=ZsSdeVP/rqguQhmuE0vDQX9SWmwCIFY4m6IHGs0t9wlZvK/HXfMOvkmNFXe8CcrZmXhte0
        sHbpXFiLf1M/5/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0513D13440;
        Tue,  7 Mar 2023 11:42:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iMo+OwsjB2TqEgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 07 Mar 2023 11:42:03 +0000
Message-ID: <b27c7950-873a-f0e9-d7b4-322bb941a11f@suse.cz>
Date:   Tue, 7 Mar 2023 12:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Who is looking at CVEs to prevent them?
To:     Hillf Danton <hdanton@sina.com>, Dan Carpenter <error27@gmail.com>
Cc:     Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
        cip-dev <cip-dev@lists.cip-project.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lwn@lwn.net, smatch@ver.kernel.org
References: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
 <20230307110029.1947-1-hdanton@sina.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230307110029.1947-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 12:00, Hillf Danton wrote:
> On 7 Mar 2023 12:51:14 +0300 Dan Carpenter <error27@gmail.com>
>> On Thu, Jan 19, 2023 at 09:14:53AM +0900, Masami Ichikawa wrote:
>> > CVE-2023-0210: ksmbd: check nt_len to be at least CIFS_ENCPWD_SIZE in
>> > ksmbd_decode_ntlmssp_auth_blob
>> > 
>> > 5.15, 6.0, and 6.1 were fixed.
>> > 
>> > Fixed status
>> > mainline: [797805d81baa814f76cf7bdab35f86408a79d707]
>> > stable/5.15: [e32f867b37da7902685c9a106bef819506aa1a92]
>> > stable/6.0: [1e7ed525c60d8d51daf2700777071cd0dfb6f807]
>> > stable/6.1: [5e7d97dbae25ab4cb0ac1b1b98aebc4915689a86]
>> 
>> Sorry, I have kind of hijacked the cip-dev email list...  I use these
>> lists to figure out where we are failing.
>> 
>> I created a static checker warning for this bug.  I also wrote a blog
>> stepping through the process:
>> https://staticthinking.wordpress.com/2023/03/07/triaging-security-bugs/
>> 
>> If anyone wants to review the warnings, just email me and I can send
>> them to you.  I Cc'd LWN because I was going to post the warnings but I
>> chickened out because that didn't feel like responsible disclosure. The
> 
> Given the syzbot reports only in the past three years for instance, the
> chickenout sounds a bit over reaction.
> 
>> instructions for how to find these yourself are kind of right there in
>> the blog so it's not too hard to generate these results yourself...  I
>> don't really have enough time to review static checker warnings anymore
>> but I don't know who wants to do that job now.
> 
> If no more than three warnings you will post a week after filtering, feel
> free to add me to your Cc list, better with the leading [triage smatch
> warning] on the subject line the same way as the syzbot report.
> 
> Thanks
> Hillf

Why do you keep adding linux-mm to the Cc list of random threads that are
not about MM?

