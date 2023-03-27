Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8242D6CA52C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjC0NGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjC0NGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:06:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC75A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:06:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so35917131edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679922388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBRzSjF1ItIhFkB/xfzfFNBgliDQkj3K2tL0x/5xLLA=;
        b=JwHQ5CYDRZgnqIABG/vIRSL/jAk6QRm9Ebi1hd8dh6gsxeEtqS4/fNF3/nuK7dv2N2
         C++uIegHeA6s3eTPmJ8a8MzVHXjS7rfZeROG9dxb5N8U3M+dqTP+gQKVbqEIYn4wAI5y
         uIHv78JsTM90s+XP8FAz7yyYcmJjIBps8CdNdpfWzBY4VUFnuc8vGX6F8OlG0gMaCSAK
         mAeBcIRaXARtMzmwonZhHcGSqauZhRaBZdDFuzsUV8cIBrgqzNToy8KhOz54/YZtyKev
         FXlT3YWbKnVP34us4nth/s6kuNa762qNOJv2WXyoOqLsTL8PdTecUgCqJxlUs+pC6wek
         MzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBRzSjF1ItIhFkB/xfzfFNBgliDQkj3K2tL0x/5xLLA=;
        b=SdVXxVcHJBd+kCfA+dUKf5vB6aYhxy6OPNZ5FZCucINVSHwgsMQEl5jpSfiHXlTfPV
         KA98sCL9O+lmZlofZuGlcOKcTMtZIPD+cnQo68P3Lt2oc1X8yymjTNEwdeFZBW56If+b
         nnmcRAITo9lCKeDv5UjpWMRcCBWeewmiK4aRcW7+OXgvnnuG0iLdu6ujOFeSYXXmnMHo
         f1tvmnGsx+USUO4bjCe/Dajhmq3wyGHVWC42t41tyRNyvL80PHWkp242n0sLH76Wgoqj
         hV4gouSUeh1CUvyXorBD2dF166vGf0p1oklzW3LIrYHGx03D8m7YCcLWApsf00i5VMzf
         4BWg==
X-Gm-Message-State: AAQBX9fLRyn/tgNBGvGEvs+f0CvV4xrwqs+9RH4Z9GAIVnuI1/yp6g/4
        /Cw/MxAX3sXTNYaX+o1GeHb6Ew==
X-Google-Smtp-Source: AKy350aubl4IeRos5yxV+0Tm1DFsUgWeynjATke5ZllIc+r07irJ1p6DoXT2tO0X3ANifJBSe5VRxA==
X-Received: by 2002:a17:907:9626:b0:8a9:e031:c4ae with SMTP id gb38-20020a170907962600b008a9e031c4aemr14908672ejc.2.1679922387777;
        Mon, 27 Mar 2023 06:06:27 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906454900b008f89953b761sm14066107ejq.3.2023.03.27.06.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 06:06:27 -0700 (PDT)
Message-ID: <bf7546ab-6c76-05b0-4539-f4aa854ffae9@tessares.net>
Date:   Mon, 27 Mar 2023 15:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] checkpatch: allow Closes tags with links
Content-Language: en-GB
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v2-0-f4a417861f6d@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
 <2f96048b-c580-625f-6fc7-06237292efe3@leemhuis.info>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2f96048b-c580-625f-6fc7-06237292efe3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On 25/03/2023 07:25, Thorsten Leemhuis wrote:
> On 24.03.23 19:52, Matthieu Baerts wrote:
>> As a follow-up of the previous patch modifying the documentation to
>> allow using the "Closes:" tag, checkpatch.pl is updated accordingly.
>>
>> checkpatch.pl now mentions the "Closes:" tag between brackets to express
>> the fact it should be used only if it makes sense.
>>
>> While at it, checkpatch.pl will not complain if the "Closes" tag is used
>> with a "long" line, similar to what is done with the "Link" tag.
>>
>> [...]
>>  
>> -# check if Reported-by: is followed by a Link:
>> +# check if Reported-by: is followed by a Link: (or Closes:) tag
> 
> Small detail: why the parenthesis here? Why no simply "check if
> Reported-by: is followed by a either Link: or Closes: tag". Same below...
> 
>>  			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
>>  				if (!defined $lines[$linenr]) {
>>  					WARN("BAD_REPORTED_BY_LINK",
>> -					     "Reported-by: should be immediately followed by Link: to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
>> -				} elsif ($rawlines[$linenr] !~ m{^link:\s*https?://}i) {
>> +					     "Reported-by: should be immediately followed by Link: (or Closes:) to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
> 
> ...here, where users actually get to see this and might wonder why it's
> written like that, without getting any answer.

I tried to explain that in the cover-letter but maybe I should add an
additional comment in the code: checkpatch.pl now mentions the "Closes:"
tag between parenthesis to express the fact it should be used only if it
makes sense. I didn't find any other short ways to express that but I'm
open to suggestions.

Now as discussed on patch 1/2, if the "Closes:" tag can be used with any
public link, we should definitively remove the parenthesis here and
probably below (see "Check for odd tags before a URI/URL") as well.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
