Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A655F709E94
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjESRxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjESRxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:53:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD143107
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:53:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f6a9131fdso134827366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20221208.gappssmtp.com; s=20221208; t=1684518789; x=1687110789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPki2kVedYBkUAnsyHX8bgELTNrSWdqM1kLCtkWIKP4=;
        b=CqOEJ9y6sewFdUXSDUTsiMr6es2vloNq2KnGrw6fH2Hl8YD9G+jpliaygnZaF7C6H5
         N/cMNs2gvDLYn6Ge3XqOMnPAJCUyNt47I/Gkni3hJ8opanrP5RHlACjZ/xpWwFbZy7/S
         3Fj5yFs99VlQpLV15lhIKPzRpQtt0hFWgzJT94iNCoqbkyFzsFXQ4Tu/kMni+/CXbAh7
         uwHRpTU2vgB0soE2lH/34HxrZd5Mi71hGQ8KVCbExle5IDbjiYK8B4DBR44l88z7wGjR
         +WxedqqcYw7sy/EX5pbo9JspxsXwXsoQbshasnvipYrtvGtonW8D0Pxc1M+4X+o3Mnky
         NU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518789; x=1687110789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPki2kVedYBkUAnsyHX8bgELTNrSWdqM1kLCtkWIKP4=;
        b=XtrGYrHiF5+Rb6aGOGUFwjd4nhiV27WMW3odRL+p+a1dMaS09jXt07ADAZhTxmmgxl
         +f2sp4FeHKqQOaSzqPqOPhSlfNwE65a1JLuSKL37bTIPryz3/w0y1lh7DkpF/Bjv79v1
         ahR7MxCl/OBGR6p8hhJuRMKuwBK1DdcPmJO3icaTDAOkvWPAbfVP+pS5tG8LEKxzCM0H
         k/G7PdVnZrIMyZiJkqTWT2uh613eBy6AzwbeRIxDEYXLGTJP0fihcN7YcdhceUTa7Zhg
         GC1K3sZXkDb9CMZOlKcpQRAjrYKRSEN0X6e6yXwjRuHKghvCk4qlNLzSnr5JuGbMxZHa
         CsIA==
X-Gm-Message-State: AC+VfDz9cwrFPb4gI1qoP40FAeKrvZWn8KPtMSf0i6Qt/cdB4k55Qmzy
        nblDFSZ0+liUDlZ1ws6CmegGgg==
X-Google-Smtp-Source: ACHHUZ5RgJD6BJtA+67fYSx0macSbw7DTob9kArFehfqSHZvkwsdWEGvFJhnhcbWc65vG4XLFH+1rQ==
X-Received: by 2002:a17:906:9b86:b0:94e:54ec:1a10 with SMTP id dd6-20020a1709069b8600b0094e54ec1a10mr3052962ejc.29.1684518789159;
        Fri, 19 May 2023 10:53:09 -0700 (PDT)
Received: from ?IPV6:2003:d9:9741:2000:44f:a939:9f33:a662? (p200300d997412000044fa9399f33a662.dip0.t-ipconnect.de. [2003:d9:9741:2000:44f:a939:9f33:a662])
        by smtp.googlemail.com with ESMTPSA id e16-20020a170906649000b0096f6647b5e8sm1091443ejm.64.2023.05.19.10.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:53:08 -0700 (PDT)
Message-ID: <b3b0d222-b745-07bc-8dcd-38f762343c84@colorfullife.com>
Date:   Fri, 19 May 2023 19:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: LTP: shmget02 fails on compat mode - 64-bit kernel and 32-bit
 userspace
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, lkft-triage@lists.linaro.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        Martin Doucha <mdoucha@suse.cz>
References: <CA+G9fYuKehraq_kcHdVgqWnwQWHN2QiE7ze53mXJvtL0DLc0uQ@mail.gmail.com>
 <9677ced3-8386-47f0-a2d6-de27ec84207e@app.fastmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <9677ced3-8386-47f0-a2d6-de27ec84207e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 5/19/23 12:57, Arnd Bergmann wrote:
> On Fri, May 19, 2023, at 11:17, Naresh Kamboju wrote:
>> LTP running on compat mode where the tests run on
>> 64-bit kernel and 32-bit userspace are noticed on a list of failures.
>>
>> What would be the best way to handle this rare combination of failures ?
>>
>> * arm64: juno-r2-compat, qemu_arm64-compat and qemu_x86_64-compat
>>      - shmget02
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> tst_hugepage.c:83: TINFO: 0 hugepage(s) reserved
>> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
>> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
>> shmget02.c:95: TPASS: shmget(1644199826, 2048, 1024) : ENOENT (2)
>> shmget02.c:95: TPASS: shmget(1627422610, 2048, 1536) : EEXIST (17)
>> <4>[   84.678150] __vm_enough_memory: pid: 513, comm: shmget02, not
>> enough memory for the allocation
>> shmget02.c:95: TPASS: shmget(1644199826, 0, 1536) : EINVAL (22)
>> shmget02.c:95: TFAIL: shmget(1644199826, 4278190080, 1536) expected
>> EINVAL: ENOMEM (12)
> Adding Liam Howlett, Davidlohr Bueso and Manfred Spraul to Cc, they
> have worked on the shm code in the past few years.
>
> This is the line
>
> 	{&shmkey1, SHMMAX + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
>
> from
>
> https://github.com/linux-test-project/ltp/blob/04e8f2f4fd949/testcases/kernel/syscalls/ipc/shmget/shmget02.c#LL59C1-L59C61
>
> right?
>
> I think this is a result of SHMMAX being defined as
> #define SHMMAX (ULONG_MAX - (1UL << 24)), so the kernel would
> likely use a large 64-bit value here, while the 32-bit user
> space uses a much smaller limit.
>
> The expected return code likely comes from
>
> static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
> {
> ...
>          if (size < SHMMIN || size > ns->shm_ctlmax)
>                  return -EINVAL;
>          
> but if ns->shm_ctlmax is probably set to the 64-bit value here.
> It would then trigger the accounting limit in __shmem_file_setup():
>
>          if (shmem_acct_size(flags, size))
>                  return ERR_PTR(-ENOMEM);
>
> My feeling is that the kernel in this case works as expected,
> and I wouldn't see this as a bug. On the other hand, this
> can probably be addressed in the kernel by adding a check for
> compat tasks like
>
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -714,7 +714,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>          char name[13];
>          vm_flags_t acctflag = 0;
>   
> -       if (size < SHMMIN || size > ns->shm_ctlmax)
> +       if (size < SHMMIN || size > ns->shm_ctlmax ||
> +          in_compat_syscall() && size > COMPAT_SHMMAX))
>                  return -EINVAL;
>   
>          if (numpages << PAGE_SHIFT < size)
>
I would consider this as ugly: ns->shm_ctlmax can be configured by 
writing to /proc/sys/kernel/shmmax.

You can break the test case on 64-bit as well, just by writing SHMMAX+1 
to /proc/sys/kernel/shmmax

Thus I think the test case is flawed:

It is testing the overflow behavior for a configurable value by testing 
with default+1. But sometimes the actual value is not the default.

Are the tests running as root?

What about intentionally setting the value to something useful?

tmp=$(cat /proc/sys/kernel/shmmax)

echo "1234" > /proc/sys/kernel/shmmax

semget() based on {&shmkey1, 1234 + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
echo $tmp >/proc/sys/kernel/shmmax

Or, alternatively: read /proc/sys/kernel/shmmax, and skip the test if 
the value is larger than ULONG_MAX-1.

--
	Manfred


