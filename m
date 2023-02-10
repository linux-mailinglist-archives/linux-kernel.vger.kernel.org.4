Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3CD692854
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjBJUcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjBJUcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:32:08 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D053A0A2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:32:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so6632606pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNGC2gVkur39N/z2BGm7FqvHrhN7MB6Kvr8/zKYBd54=;
        b=ggqXtIq5KlvW4+bzHNM7jlAyPY0z+p8Jo7a8W5Rwk3QnaHJBZJYKrMboQklL4ZGFrv
         doeD+gsAKuhGs6CO8+lmAhnM5DM5DY8zlKWhmcpxPJ18NtE30dQFnad21m2dFAXsZCAc
         IWwmpfvczOUhuSrW5mcQ/18/WZ9Ewfltyt6cA8gE2QkAtzx5AfbrCOqS0Urw0unKmbqf
         z2UYJcIBpB1tl7pg9rgtQlmG09i0W8p/w0a+VlN2yHKqCtKNN4uKxuDsYhjky/Drgn64
         wdXVTkTZdehl/wP+SsMIOApp8GzW7OugxlIx+sFuTAFkMOuvey8XbdArw4uvJHVbYz/i
         Lcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNGC2gVkur39N/z2BGm7FqvHrhN7MB6Kvr8/zKYBd54=;
        b=0pzi544VHIK5RCMNXzoIILB1Mc+53eG6pRqLc2WQrUH82Bitx8h8RI1vd+tUXpW0Qh
         NJQNJ4ggq1DX8KTH8HHzt4V18j7MiYUpSAKtR78drDl7jN9R+vHKQC+t/GBkczK8TRMz
         zxtNgcwTs+IOrXs7UI995QTkurbVMy5z9aV3U++6h7hXMFzQidoDcv5NoJDG9kweitMx
         fkIjC5j6/Z5aqxhjKuP9kszjC4yzIUDCfd7f59nN9UpiUgIDsDMcU2XRitV9Io581G2s
         T9Xv3TvcNvOL2nKSIfbP3tdOVjNm5fd89cYTGQ/MbNtlqOss/2bAQbUGJABfCkUZlDpS
         80tg==
X-Gm-Message-State: AO0yUKXhquGyNZGrnLewh85783sgtD2YyuRw4Sovll33Nf4OBcmkRmKQ
        /BUVOeBKXn/gyDoP+CQdWQVAkQ==
X-Google-Smtp-Source: AK7set/R7DRDye2KopX4VXsYABJedGTdp+oIlslYijdw2jgktzMAsQBFaHyYZ8x0PhoUd6tBAQ0VEQ==
X-Received: by 2002:a17:902:d2c3:b0:19a:7217:32af with SMTP id n3-20020a170902d2c300b0019a721732afmr3770005plc.5.1676061124414;
        Fri, 10 Feb 2023 12:32:04 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902b71700b001933b4b1a49sm2701300pls.183.2023.02.10.12.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 12:32:03 -0800 (PST)
Message-ID: <1dd85095-c18c-ed3e-38b7-02f4d13d9bd6@kernel.dk>
Date:   Fri, 10 Feb 2023 13:32:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: copy on write for splice() from file to pipe?
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area>
 <20230210040626.GB2825702@dread.disaster.area>
 <Y+XLuYh+kC+4wTRi@casper.infradead.org>
 <20230210065747.GD2825702@dread.disaster.area>
 <CALCETrWjJisipSJA7tPu+h6B2gs3m+g0yPhZ4z+Atod+WOMkZg@mail.gmail.com>
 <CAHk-=wj66F6CdJUAAjqigXMBy7gHquFMzPNAwKCgkrb2mF6U7w@mail.gmail.com>
 <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
 <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
 <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
 <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
 <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/23 1:27 PM, Linus Torvalds wrote:
> On Fri, Feb 10, 2023 at 11:56 AM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> i think this is almost exactly what Jeremy and Stefan are asking for
>> re: notification when the system is done with a zero-copy send:
> 
> Yeah, right now it's all just "incremented page counts", I think.
> 
> Even the pipe code itself doesn't know about writes that have already
> been done, but that are pending elsewhere.
> 
> You'd have to ask the target file descriptor itself about "how much do
> you have pending" or something.

No, we very much do have that for io_uring zerocopy sends, which was in
the bit below you snipped from the reply. It'll tell you when data has
been sent out, and when the data has been acked. Or what am I missing
here? Late to this thread, and there's a ton of stuff go to through.

-- 
Jens Axboe


