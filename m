Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434406D691E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjDDQny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjDDQnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:43:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D6210CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:43:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h11so36151335lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680626630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPKKymJTY9rvqEJxInmNmGTLfT+vj13vegpiWHqz2Lk=;
        b=Fl2yvGh72hVdEcOX7jQcowtNEYPHtPab2XbKQUKk0701TIlqHYZWnWLu1RfRcYUg3/
         GF2WJSOK2M9z/q/ovXGjyCztG7ewMjOnxUwGWtr7JTsyparGjUhIFi+k1XobxRSYrUcW
         /DvvZmy5rYuccEyXmhfxEYRpOEnO3StHDIGPlpWNH94/4Eqb0F76opJCVY4eRzl4oC3R
         ZOdGJxW/bDpFD4vhL/0Pze3EP08aaT2g6NsTK0o70fxc9w3sstAUcpLjVt+zwVLlyMND
         J64RwYQsYREjX16f515SDkkuK6GuYHsJXxVCGp5S/9xcLcw2Ka4hIiFtpIF+oul9jq2x
         lBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPKKymJTY9rvqEJxInmNmGTLfT+vj13vegpiWHqz2Lk=;
        b=2yciMyS3Q2jJYiAgrkgtdHFXQGuN7YqI2ODP51WDqxBsUTfpTQk+JHlAThYzAk7GWE
         m/my4Z53DJEjhUyaj7vRerqVxpb+mWueKfXVgvucj2qiw5lVxYLnJLVkyKqsPqIasShR
         VBbkNy5ND1Z9+JIgvL2LgffYuVMcwcHMsJOm3iFCDiugsqIHMC0pBHHm+WSJjZRAF15J
         q0seBwoe7G/+4lC9Si7454S0kiDAMaDtKz3t7JQV9JqncDCU+U8iQ4fO71riKNrsbDPy
         yXWugKqzMBd35beX3cuCh82iTlWEV6HP8QxJSEQLiw+SqbfOQ4tuFHl7+IbEL4CkJIzw
         MaSw==
X-Gm-Message-State: AAQBX9dGsqNSMZlnqBQbzfHUTupiEHdcnSR1FjtvZSZ7bFkeAMax6yZl
        pnmnbMjCQ2EGMAvo98ltbf4=
X-Google-Smtp-Source: AKy350aSGJWJEFeInrhaES2alrYzxIz3SSdNIbK8J/1Od1RpmykzLr4rzGwKnEEfoFceyXNB/3au4g==
X-Received: by 2002:a05:6512:76:b0:4eb:c30:2782 with SMTP id i22-20020a056512007600b004eb0c302782mr866849lfo.55.1680626629858;
        Tue, 04 Apr 2023 09:43:49 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id j29-20020ac2551d000000b004eaf6d7228bsm2387139lfk.110.2023.04.04.09.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 09:43:49 -0700 (PDT)
Message-ID: <87594ad8-ae4a-c17a-5614-3b504612e738@gmail.com>
Date:   Tue, 4 Apr 2023 19:43:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND PATCH v2 1/3] iio: Add some kerneldoc for channel types
Content-Language: en-US, en-GB
To:     Randy Dunlap <rdunlap@infradead.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cover.1680610554.git.mazziesaccount@gmail.com>
 <6cbe49605986fe1b82e4f3d67344e549846c5f6c.1680610554.git.mazziesaccount@gmail.com>
 <02d3149a-27a1-ac94-45d7-9e8ca67bc73a@infradead.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <02d3149a-27a1-ac94-45d7-9e8ca67bc73a@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 19:33, Randy Dunlap wrote:
> Hi Matti,
> 
> On 4/4/23 05:24, Matti Vaittinen wrote:

>> +/**
>> + * iio_chan_type - Type of data transferred via IIO channel.
> 
>      * enum iio_chan_type - ...
> 
> as you did in patch 2/3.
> 

>> +/**
>> + * iio_modifier - accurate class for channel data
> 
> Ditto here.

Well spotted. Thanks Randy. I'll wait for a lil while if there'll be 
some more comments - but I'll fix this in v3.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

