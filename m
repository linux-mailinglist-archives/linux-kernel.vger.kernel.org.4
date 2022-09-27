Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A85EC216
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiI0MI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiI0MIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:08:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B342AA2AA8;
        Tue, 27 Sep 2022 05:08:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a80so9497742pfa.4;
        Tue, 27 Sep 2022 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kWbWkuKWvVGaeeFfHEB2UkzJbLFThe5KkEvYUbeof1g=;
        b=QiIlkU5VJGjW3xNo8lW81gmbbWTpoogY3aFw8UUx+R5v2LKlhX7yLyJzzFRAekwLNV
         3D1AW1IIizT6obpp/GJ17O1DqEXNlPk4tYPgNhWg/u20V4ggTBPlKHAs6X/TNWa95yK1
         lz4+n/IAFQJyzEKvmhY2iWbg1Inf1SzZvSnhyICO8FMPaDz5Xbs0e5n2tzBzZyeEAMUk
         NiLqa8BlbkYbzxhAggp13rU4RhMSvrRvyPmhM286vmE4If5grOX1kJ0TewpeE0KZIJ9n
         fzNGju1tnQmaLi64p75mUJ1mUlt22CVLJb7HOVe8F0qwtDRtwSGpLOtqrnK17stsdVqZ
         V89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kWbWkuKWvVGaeeFfHEB2UkzJbLFThe5KkEvYUbeof1g=;
        b=nc1t2NrjEPxhxOdKh+HYQnUublEHTvmRpHSMON+bg/jiSAx3I7pt5uvJXpEExJy7ZP
         eNL1MBAG6xKXoVvLyZNQzQKvvyX5+Je5EueEDeBjCLwfwiNt/ghDsl42RbyoxjRq0JEA
         mcmN5i6/4Ug8MXgR19rr0yPzGClg7Lwa6U3zXNBW7VoOf7N2GFdyPEtK2aA6olby+SwZ
         gL1GwnoAUNa6v3xsVOLYrTXovxiV1DgZeR+EzGYz0vCohlJzRW6fDbRHJkQ59ZbkQEK7
         A/witkWwB4PdanUsALMEKaf9tRF+whHpFlwKmthma9/hvY4XRChUeDpf79imAPcbFvhm
         Lscg==
X-Gm-Message-State: ACrzQf095PMEqM+1inBNMVND1fQy/Kmn4NRV5K2vIQwVyrTrP5F+dB5s
        uThAU/bayXCafDU0Go4zfkIGPND+nr8=
X-Google-Smtp-Source: AMsMyM41ioVUEdSMLDienYDhZ9Bh/Sytq2y6mQVYRhL7zxWz7UrXW8/vgwG+Y0kmXuEW0ngKos8A3Q==
X-Received: by 2002:a63:a18:0:b0:43b:e1c8:fdae with SMTP id 24-20020a630a18000000b0043be1c8fdaemr23826019pgk.163.1664280498131;
        Tue, 27 Sep 2022 05:08:18 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id j13-20020a170903024d00b0017541ecdcfesm1354079plh.229.2022.09.27.05.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 05:08:17 -0700 (PDT)
Message-ID: <c5099b4d-eb37-a210-b852-51e02c185a87@gmail.com>
Date:   Tue, 27 Sep 2022 19:08:11 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] Documentation/CoC: Reflect current CoC interpretation and
 practices
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20220926211149.2278214-1-kristen@linux.intel.com>
 <dd89a30e-5403-8844-036c-9c9107cac888@gmail.com> <YzKyqNJk72TY//42@kroah.com>
 <f0c27a5b-fee2-eb64-6855-639e7ea65d37@gmail.com> <YzK3sSrHSckm7T3b@kroah.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YzK3sSrHSckm7T3b@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 15:43, Greg Kroah-Hartman wrote:
>> Hi Greg,
>>
>> In the patch, the mention to bootstrap period of CoC committee is
>> replaced with note about dynamic nature of CoC interpretation. I asked
>> when the duration of bootstrap period was before we got into status quo.
> 
> It was a while ago, a few years perhaps?  We had forgotten to update the
> document since then, sorry.
> 
> greg k-h

Thanks Greg for the info!

-- 
An old man doll... just what I always wanted! - Clara
