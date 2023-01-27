Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3367F1EE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjA0XCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjA0XCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:02:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9FF8B070
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:02:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso9295262pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PnZ4M8G6osMqcq0cay4H65EdY9MFfyodwQo99UDcY5Q=;
        b=ms8VfDaCX6wdA6Z3meYfF762Bsh7OEsFfB3OKHnFicBX6YwKvvWtHSormw3sFbYq5j
         4mAqkFQdKjNVfRrA2WMysoHJfUskEejTGKh50E9SxBAnG5VU/10aKWZ0bnR1THtPnSUF
         125JsixoYCtZ1UT66RCvxOw9QkmrgSOs33Qjsz+WqDyraJrFHNFnmDnoFsTcsuKV4yz/
         szBXCuMXw+lR/e4ekqRm4hyo6TMR3O6KxExFUjodQE5Q6XWLrSC8aDPrlfNbgnFS8weX
         DctG36yxggdBwW4ThHhoRUkO+7bSBQpvfeFtfCLYJL5c1S5kBn9yljrS0n07uskq7XG0
         VU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PnZ4M8G6osMqcq0cay4H65EdY9MFfyodwQo99UDcY5Q=;
        b=Wfvc6AXEoPy2r/6DgAVB1aacNlMlNjbCXKaTqtTqVDuzlPcHFe2xBllIBSL8HZ6z0E
         n+pAk9Bq9k8Gk7nhS/wPw8Rleac/ipF8ffThMOCd/pXqGPlNPd74i3+AwiwXNmg5zftn
         0OcO3NfXzEIxlhFt9Pf0o4MOsyThWr2vU6bDZAKgKw49WiLk4w1qqPmilR65q9iyd85Z
         8WCYhWOqqaiewwdhj50KwkRg5IYw33ndlISs5dFwkLhZAWgal1xt2p+W3l46j9Hcube+
         bQeBgUghxlL8+Wl3rEgA0g00sp/U5rtk1LDxJLD+vU61V17h7kAUMeLqXJUgT9I4/1nl
         2NYg==
X-Gm-Message-State: AFqh2krUJMtkzFJCJ7HuHJLlqs9htpB76rGP410o0SH7WKmMDiadR0wn
        cqAzyrj2EqmEOtEXrd3zfuCGQA==
X-Google-Smtp-Source: AMrXdXt8a5YQA7h7/dDv6oqEhYSkfw+aGca5wCXf3mUxmcixKWjND2mhoCZqx6+wNxe4j6Run/cFXw==
X-Received: by 2002:a05:6a20:158e:b0:b6:5687:17b1 with SMTP id h14-20020a056a20158e00b000b6568717b1mr12564706pzj.4.1674860562142;
        Fri, 27 Jan 2023 15:02:42 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f190-20020a636ac7000000b004a737a6e62fsm2748893pgc.14.2023.01.27.15.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 15:02:41 -0800 (PST)
Message-ID: <7904e869-f885-e406-9fe6-495a6e9790e4@kernel.dk>
Date:   Fri, 27 Jan 2023 16:02:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 0/2] two suggested iouring op audit updates
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Stefan Roesch <shr@fb.com>,
        Christian Brauner <brauner@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <cover.1674682056.git.rgb@redhat.com>
 <da695bf4-bd9b-a03d-3fbc-686724a7b602@kernel.dk>
 <CAHC9VhSRbay5bEUMJngpj+6Ss=WLeRoyJaNNMip+TyTkTJ6=Lg@mail.gmail.com>
 <24fbe6cb-ee80-f726-b260-09f394ead764@kernel.dk>
 <CAHC9VhRuvV9vjhmTM4eGJkWmpZmSkgVaoQ=L6g3cahej-F52tQ@mail.gmail.com>
 <d9da8035-ed81-fb28-bf3a-f98c8a1e044a@kernel.dk>
 <CAHC9VhRpu7WZDqWKcLDj18A0Z5FJdUU=eUL3wbJH1CnEBWB4GA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHC9VhRpu7WZDqWKcLDj18A0Z5FJdUU=eUL3wbJH1CnEBWB4GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 3:53 PM, Paul Moore wrote:
> On Fri, Jan 27, 2023 at 5:46 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/27/23 3:38 PM, Paul Moore wrote:
>>> On Fri, Jan 27, 2023 at 2:43 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> On 1/27/23 12:42 PM, Paul Moore wrote:
>>>>> On Fri, Jan 27, 2023 at 12:40 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>> On 1/27/23 10:23 AM, Richard Guy Briggs wrote:
>>>>>>> A couple of updates to the iouring ops audit bypass selections suggested in
>>>>>>> consultation with Steve Grubb.
>>>>>>>
>>>>>>> Richard Guy Briggs (2):
>>>>>>>   io_uring,audit: audit IORING_OP_FADVISE but not IORING_OP_MADVISE
>>>>>>>   io_uring,audit: do not log IORING_OP_*GETXATTR
>>>>>>>
>>>>>>>  io_uring/opdef.c | 4 +++-
>>>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> Look fine to me - we should probably add stable to both of them, just
>>>>>> to keep things consistent across releases. I can queue them up for 6.3.
>>>>>
>>>>> Please hold off until I've had a chance to look them over ...
>>>>
>>>> I haven't taken anything yet, for things like this I always let it
>>>> simmer until people have had a chance to do so.
>>>
>>> Thanks.  FWIW, that sounds very reasonable to me, but I've seen lots
>>> of different behaviors across subsystems and wanted to make sure we
>>> were on the same page.
>>
>> Sounds fair. BTW, can we stop CC'ing closed lists on patch
>> submissions? Getting these:
>>
>> Your message to Linux-audit awaits moderator approval
>>
>> on every reply is really annoying.
> 
> We kinda need audit related stuff on the linux-audit list, that's our
> mailing list for audit stuff.

Sure, but then it should be open. Or do separate postings or something.
CC'ing a closed list with open lists and sending email to people that
are not on that closed list is bad form.

-- 
Jens Axboe


