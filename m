Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB3D6DE74B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDKWaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKWaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:30:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315074C1B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:30:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6323870b5d4so578547b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1681252208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKBhoDP+sP3T2nnParrcD9Nl7mDJF/BQppydlUzHoVg=;
        b=ppIQMuKaJsl4nmCDvoLnNaGHRTl3fy8ZJnTim7m+CAoZlk2cI19ue6Qwr3wF4CULRa
         8R1XCkP9nl1T7OaGT73D2jf2HxGCCFhHBendL/+3jCpxjPEDfuV0MwZC1vG6ObvPtSDd
         nAUCkFZd3W90mTsW4m3L8gVdEUch5goD10VFVu/plYWDCktHJsiySH3McdLGq79+QJ0+
         FWarpfnrJOGdxHTKt0Q70vi4fjHugObGLHZla5j0boc7GRuT4X5YEg4HkOnCQ1lBwhYj
         iubNvBlqj6xGVqMvvm3VGeGd5eSZkvfWgh0+zYvyXTD7vq5mhSm6eFQXBORkHhhV0hya
         DGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681252208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKBhoDP+sP3T2nnParrcD9Nl7mDJF/BQppydlUzHoVg=;
        b=UYUEkKerfbOzIiYSTdugqtXbmHX9uzu7ARjnKjKqLVhRn0CmIHRFm79fVFdre7y5MI
         VgwreiWb7sJDluilpAqpFUVOyEF+o75UsIqIpRdc+MqVdPn58BnRF+OaXEgb+MVTegM7
         ZKCQS1fxmGaq35HXTcuM+vua6Po3dsNoqS6bfcaw0WmBA0GUDJxukpwspO22dKQehL9t
         BE2qfpLoy08QiM+ehGLM2cuYFfFNmHicVDwrQmM6R+4vRyILRYwby2Q+QH2H5g6LE7Um
         OuPGvsnxEWi4h0oHLSYRrmsOs1xAo3nbU14tUf1v/JZ8fN7AGfC8MdrQr6+MSh8hf+S/
         cfbg==
X-Gm-Message-State: AAQBX9dgtOwZw5HmJcvoDE3mrvW5WtgbeEzy8JydME4F7uw31wCPEk0Y
        XBReIHN3CP7IYaIHKRXc2UjwpbvriaxHfzkhePw=
X-Google-Smtp-Source: AKy350bgytSfQoCBdzIljJdVL7dc7jpGWxSHkSREDMiKD/9cP3MFpAhTJYWkhDo6j9aQ7/1eCry7Qw==
X-Received: by 2002:a05:6a00:190f:b0:638:abf4:d49c with SMTP id y15-20020a056a00190f00b00638abf4d49cmr511087pfi.3.1681252208638;
        Tue, 11 Apr 2023 15:30:08 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v5-20020a62a505000000b00625e14d3a15sm10215338pfm.166.2023.04.11.15.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 15:30:08 -0700 (PDT)
Message-ID: <4d015798-84d8-ed15-393b-105f9f315e25@kernel.dk>
Date:   Tue, 11 Apr 2023 16:30:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: linux-next: build warnings after merge of the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230327120017.6bb826d7@canb.auug.org.au>
 <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230412073416.73a8ea1a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 3:34?PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 28 Mar 2023 10:47:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> On Mon, 27 Mar 2023 09:26:30 -0700 Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>>
>>> On Mon, Mar 27, 2023 at 12:00:17PM +1100, Stephen Rothwell wrote:  
>>>>
>>>> After merging the block tree, today's linux-next build (x86_64
>>>> allnoconfig) produced these warnings:
>>>>
>>>> lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x0: redundant UACCESS d
>>>> isable
>>>> lib/iov_iter.o: warning: objtool: iovec_from_user.part.0+0xc7: call to copy_comp
>>>> at_iovec_from_user.part.0() with UACCESS enabled
>>>> lib/iov_iter.o: warning: objtool: __import_iovec+0x21d: call to copy_compat_iovec_from_user.part.0() with UACCESS enabled
>>>>
>>>> Presumably introduced by commit
>>>>
>>>>   6376ce56feb6 ("iov_iter: import single vector iovecs as ITER_UBUF")    
>>>
>>> I'm not able to recreate.  What's your compiler version?  
>>
>> $ x86_64-linux-gnu-gcc --version
>> x86_64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0
> 
> Any progress?

Honestly I have no idea what it's complaining about. It's obviously the
compat copy, but everything seems fine to me?

-- 
Jens Axboe

