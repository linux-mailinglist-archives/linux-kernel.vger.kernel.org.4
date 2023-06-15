Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5FC731E15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbjFOQos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbjFOQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:44:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E11A2D4E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f8cc04c278so20458325e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1686847459; x=1689439459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTvO1ofEFZkX2L+3srAV8TMv0rP6MBqsvVOXrpHnSKY=;
        b=NACQDV93NhQZI5WKTGNSxOdFtrlCCWlIOCTxU1CFVRJl98IMrtHfF/NFdhZtslzLJ3
         OglZlAffARJZfpgrQlb9HSE4iwaEsmUMIMLCw9D87J8NCGvpQdGmMhENRAHlAUAsXCUG
         MiUijnnExwpzcncaKzP2N9FCnFL4t+76ofaOCa58JbIxHDgyHcpHkXoYgaxYxTnQPBxX
         ihC/sAqBA5H0pFb07NJ0emx9UFoKKkUJWDN8x+ZL8iTJxZ7GdZ2EKjB9JrlmslWcA9Nv
         PxeKeAyaZkD7tU9Bo4bHMOuMA+ysgdXO/WBIp3rt+yGengcQIVnOa6rBrQJ4vjWMCoj5
         zNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847459; x=1689439459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTvO1ofEFZkX2L+3srAV8TMv0rP6MBqsvVOXrpHnSKY=;
        b=Bk5nmzLrLjFXteYiaHJaWyAA+X5RgL/T2aQbWMm3Cs7KVkq17UeAY1R7nwlH55ftZS
         o7I0Ov5271OInaeHrumTAxxe6KUgmv02vg/k+QgrPbw/LkI3uwSZI2fM6aNXCtCSGsLD
         73aI478Sw0zFuSsaI2JUg1HPIRn9HKZVI2qJJyVvqt3j3dlFRYD9Nm4awRcn4m3fH18/
         faREvgwqxgH3LRtfeoigG3AoJ50OWp/TwyYyvWVnKoJfCszyYsXO9CsgyFqEuGULqEpV
         DwBVTdycfBpia3JbBmWCO6hVhoEVcnp6BxYLddRddP4e9Ab3UC3zbaXbqMspapyotpcK
         LhZg==
X-Gm-Message-State: AC+VfDwuXFMEx1USkwpAyogAHSrwV/7WDj5VRlMsFiIXGh8V3BkkjWcp
        4JHxCJplSoqUgGJFj79LpShZBA==
X-Google-Smtp-Source: ACHHUZ7QMm+aLr1Tu/oeq1u2EFkDxx5DyPS9TS7lcx8zc3pb6NWiLVw+vXm/m+r9DTKwdS1hnHNG9g==
X-Received: by 2002:a05:600c:24c:b0:3f8:c8d1:b6de with SMTP id 12-20020a05600c024c00b003f8c8d1b6demr6520693wmj.15.1686847459649;
        Thu, 15 Jun 2023 09:44:19 -0700 (PDT)
Received: from [10.83.37.24] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z8-20020a05600c220800b003f8db429095sm4739944wml.28.2023.06.15.09.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 09:44:18 -0700 (PDT)
Message-ID: <21845b01-a915-d80a-8b87-85c6987c7691@arista.com>
Date:   Thu, 15 Jun 2023 17:44:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 01/22] net/tcp: Prepare tcp_md5sig_pool for TCP-AO
Content-Language: en-US
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
References: <20230614230947.3954084-1-dima@arista.com>
 <20230614230947.3954084-2-dima@arista.com>
 <255b4de132365501c6e1e97246c30d9729860546.camel@microchip.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <255b4de132365501c6e1e97246c30d9729860546.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steen,

On 6/15/23 11:45, Steen Hegelund wrote:
> Hi Dmitry,
> 
> On Thu, 2023-06-15 at 00:09 +0100, Dmitry Safonov wrote:
[..]
>> +/**
>> + * tcp_sigpool_alloc_ahash - allocates pool for ahash requests
>> + * @alg: name of async hash algorithm
>> + * @scratch_size: reserve a tcp_sigpool::scratch buffer of this size
>> + */
>> +int tcp_sigpool_alloc_ahash(const char *alg, size_t scratch_size)
>> +{
>> +       int i, ret;
>> +
>> +       /* slow-path */
>> +       mutex_lock(&cpool_mutex);
>> +       ret = sigpool_reserve_scratch(scratch_size);
>> +       if (ret)
>> +               goto out;
>> +       for (i = 0; i < cpool_populated; i++) {
>> +               if (!cpool[i].alg)
>> +                       continue;
>> +               if (strcmp(cpool[i].alg, alg))
>> +                       continue;
>> +
>> +               if (kref_read(&cpool[i].kref) > 0)
>> +                       kref_get(&cpool[i].kref);
>> +               else
>> +                       kref_init(&cpool[i].kref);
>> +               ret = i;
>> +               goto out;
>> +       }
> 
> Here it looks to me like you will never get to this part of the code since you
> always end up going to the out label in the previous loop.

Well, not exactly: this part is looking if the crypto algorithm is
already in this pool, so that it can increment refcounter rather than
initialize a new tfm. In case strcmp(cpool[i].alg, alg) fails, this loop
will never goto out.

I.e., you issued previously setsockopt()s for TCP-MD5 and TCP-AO with
HMAC-SHA1, so in this pool there'll be two algorithms: "md5" and
"hmac(sha1)". Now if you want to use TCP-AO with "cmac(aes128)" or
"hmac(sha256)", you won't find them in the pool yet.

> 
>> +
>> +       for (i = 0; i < cpool_populated; i++) {
>> +               if (!cpool[i].alg)
>> +                       break;
>> +       }
>> +       if (i >= CPOOL_SIZE) {
>> +               ret = -ENOSPC;
>> +               goto out;
>> +       }
>> +
>> +       ret = __cpool_alloc_ahash(&cpool[i], alg);
>> +       if (!ret) {
>> +               ret = i;
>> +               if (i == cpool_populated)
>> +                       cpool_populated++;
>> +       }
>> +out:
>> +       mutex_unlock(&cpool_mutex);
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(tcp_sigpool_alloc_ahash);
>> +
> 
> ... snip ...
> 
> 
>>  clear_hash:
>> -       tcp_put_md5sig_pool();
>> -clear_hash_noput:
>> +       tcp_sigpool_end(&hp);
>> +clear_hash_nostart:
>>         memset(md5_hash, 0, 16);
>>         return 1;
>>  }
Thanks,
            Dmitry

