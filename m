Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F71698F62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjBPJKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBPJKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:10:37 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A921A490
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:10:36 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id v17so1943712lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itpmqCRSbaIVC7wZtfr9HbCli3IWfUbTikhRIPulXqo=;
        b=ehpbVRDY3uFTXff1WZrb6WzdSKIUhNZKsSYQj+UUJ9tM4zj5sKYMMEnr2n0/mMzn/o
         IecrjHyF7rqlAAAr0WXGO/Ou4CQWwvq4ZdaGLW6n9piiT0pmaBCHTJARw3TxpUoZfwim
         ASsW9LVa9EB64amERKkSIZrA4RkOAajtj/XTJlY+n2AOWieHVDCD5B5Ret+Gxsg7mFVV
         Vry1hqxCXl1i4WP+jUXmGt3XZLHNge0QPVZG+WCZjm2ONoixoQpWa21B9LY92Lu2UvJU
         0OT1aL4himfNuIXrdFYrwOeOtzCie75xXunGHoVbinRum48bgpgsmeWgYM9ONIqtcZqJ
         Fyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itpmqCRSbaIVC7wZtfr9HbCli3IWfUbTikhRIPulXqo=;
        b=OVIgKsUjt5iFf462zGLonbzP7qxnKbqgy7/Ow55hToFMgtbonDO322wvzEOx4/6BAM
         bvo4HZ1K4r/tkhKlWIA6V6WKYmBGsTnh9rWn2aXbTVFEBP1p2Yz0/S3nj7MLwSCr2EAX
         HNd7AYprVTWHerQJRSS4r6dp/Rol6WLd8GhV1ETTQOSxW+yIaGcPOSv/G5AKgboOaO1Z
         A5um2eV/emdUzUtr5KzeydDvryGmBmIvw9J/cpnn92D32J5sRwvcZaNH/kkwxNUknkEO
         AzQbok7U6lsEra+L8jzip49Syr8OkS2ZZoFS6Fs6esTnC8ChAqTupQWEg7e8Q8SZS9cE
         tpPQ==
X-Gm-Message-State: AO0yUKWUatrSOYc19sHv4FBUs8vD5NbMruzmuzA2pmFh85k4HwpEga9n
        rL0S2qmj4Tb1Ycbi5XawTL0+Vw==
X-Google-Smtp-Source: AK7set8ACLYGt8o/dN9L05F77GXMyAo0T/IhKox4F0xKScHW5FBT6vZ462WamvK/b6Hz9W8WtuuerQ==
X-Received: by 2002:ac2:5ec8:0:b0:4cc:7ff3:ab4d with SMTP id d8-20020ac25ec8000000b004cc7ff3ab4dmr1530785lfq.20.1676538634978;
        Thu, 16 Feb 2023 01:10:34 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id q14-20020ac246ee000000b004d6ebbad989sm220855lfo.1.2023.02.16.01.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:10:34 -0800 (PST)
Message-ID: <71078188-1443-d84e-658c-967991f3b590@linaro.org>
Date:   Thu, 16 Feb 2023 10:10:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/2] Revert "splice: Do splice read from a buffered file
 without using ITER_PIPE"
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mm@kvack.org
References: <20230215-topic-next-20230214-revert-v1-2-c58cd87b9086@linaro.org>
 <20230215-topic-next-20230214-revert-v1-0-c58cd87b9086@linaro.org>
 <3055589.1676466118@warthog.procyon.org.uk>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <3055589.1676466118@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.02.2023 14:01, David Howells wrote:
> Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> 
>> next-20230213 introduced commit d9722a475711 ("splice: Do splice read from
>> a buffered file without using ITER_PIPE") which broke booting on any
>> Qualcomm ARM64 device I grabbed, dereferencing a null pointer in
>> generic_filesplice_read+0xf8/x598. Revert it to make the devices
>> bootable again.
>>
>> This reverts commit d9722a47571104f7fa1eeb5ec59044d3607c6070.
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Commit d9722a47571104f7fa1eeb5ec59044d3607c6070 was part of v13 of my
> patches.  This got replaced yesterday by a newer version which may or may not
> have made it into linux-next.
> 
> This is probably a known bug fixed in the v14 by making shmem have its own
> splice-read function.
> 
> Can you try this?
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract
next-20230216 boots fine again, thanks!

> 
> (Also, can you include me in the cc list as I'm the author of the patch you
> reverted?)
Ugh.. I thought b4 would have done that for me.. weird..

Konrad
> 
> Thanks,
> David
> 
