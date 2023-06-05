Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D57223DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjFEKw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFEKwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:52:24 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4099EA;
        Mon,  5 Jun 2023 03:52:22 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso1676499a12.1;
        Mon, 05 Jun 2023 03:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685962342; x=1688554342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyziPcXjx042xRWB/UShxNbnJkgS86WOF1g0CAJiPcU=;
        b=cKiBXHg637svkO99+OtZqYw6G1Y6SnbjYFA7RhEqlGuF2v4mnpA1ZE4FdwG6KMVmh3
         6y2HJoaClaR1IkfLGn+l8A8dqc0PIYZQ9eXB6ZqyNdh7F1qDP8RQ14wSO8alGq1CbpPm
         /yZOHWbc7R/86ZKAXeB9sUJAN/K2o+JHGKIHTfN4icNLkMrHk4k20SAC+9NeHJvZvaEW
         L37TaNN7p9bzFaDKZOj5z1RjK31n9EnRpAlHskKiMRwfaGtP86SaXUmUWXuQcUf1p6Oz
         RjT1rKW0gaPvLT2XUTzDbo8HGNRHVfwWNNuIUFEe+ECisIzxqzOlgWvscD0Bx5UEpXpv
         vPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962342; x=1688554342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyziPcXjx042xRWB/UShxNbnJkgS86WOF1g0CAJiPcU=;
        b=ABi6BTfzF/I0W9knP3dLIDXriU55xw1ozeDE+A8BDuW9H1/DaDAwzxdFfMJLD2icTX
         /sTTqmYWdw5zlljiBjxaEFlatAuBMlOV7MwJVVtPZkdS4WQqMQhiJFkIkvIwE5KpxOAe
         tNMk3Q3oI0EBmlob7QqpABGYyUXDWloXqvxU5mcK/LiE/3p3Mesdx1VMnQhZyKWcJTHD
         97VLJY63R9SACkr3eLUg66eWpRPvUKSVGZo7VICaf9YF1zC9as95Cxb5ltTL5J3TSHbv
         P4PQ5qaB4dssPYiPK7dWkzdVLbahZ4vsatNuQi4pU8pzY1RYABzWXQsVcX78AvBX02Ug
         CQmQ==
X-Gm-Message-State: AC+VfDyYmuJXuZB9xhyuCF8du2B/qjnwC3Rtgf+3I0EbXII9yiLCJctZ
        Tsdq0Jel+fP9hErq0qllrGE=
X-Google-Smtp-Source: ACHHUZ4O5fsEe/UQksnA3+kVyPz7RFRKjUTKy+Vj+pQfbgdpSVTpwwXym6nU1m9pZGQVbwII+Lvrbg==
X-Received: by 2002:a05:6a20:8f0b:b0:10d:bc30:b9ea with SMTP id b11-20020a056a208f0b00b0010dbc30b9eamr3156392pzk.39.1685962342096;
        Mon, 05 Jun 2023 03:52:22 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-71.three.co.id. [180.214.233.71])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001ab061e352bsm6287237plb.195.2023.06.05.03.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 03:52:21 -0700 (PDT)
Message-ID: <15f5c6da-869c-cee4-3922-23873a077789@gmail.com>
Date:   Mon, 5 Jun 2023 17:52:13 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 01/12] Documentation/x86: Document Key Locker
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        herbert@gondor.apana.org.au, ebiggers@kernel.org, ardb@kernel.org,
        x86@kernel.org, luto@kernel.org, tglx@linutronix.de, bp@suse.de,
        dave.hansen@linux.intel.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        ravi.v.shankar@intel.com, linux-doc@vger.kernel.org
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20220112211258.21115-2-chang.seok.bae@intel.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220112211258.21115-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/22 04:12, Chang S. Bae wrote:
> +==============
> +x86 Key Locker
> +==============
> +
> +Introduction
> +============
> +
> +Key Locker is a CPU feature feature to reduce key exfiltration
> +opportunities while maintaining a programming interface similar to AES-NI.
> +It converts the AES key into an encoded form, called the 'key handle'. The
> +key handle is a wrapped version of the clear-text key where the wrapping
> +key has limited exposure. Once converted, all subsequent data encryption
> +using new AES instructions (AES-KL) uses this key handle, reducing the
> +exposure of private key material in memory.
> +
> +Internal Wrapping Key (IWKey)
> +=============================
> +
> +The CPU-internal wrapping key is an entity in a software-invisible CPU
> +state. On every system boot, a new key is loaded. So the key handle that
> +was encoded by the old wrapping key is no longer usable on system shutdown
> +or reboot.
> +
> +And the key may be lost on the following exceptional situation upon wakeup:
> +
> +IWKey Restore Failure
> +---------------------
> +
> +The CPU state is volatile with the ACPI S3/4 sleep states. When the system
> +supports those states, the key has to be backed up so that it is restored
> +on wake up. The kernel saves the key in non-volatile media.
> +
> +The event of an IWKey restore failure upon resume from suspend, all
> +established key handles become invalid. In flight dm-crypt operations
> +receive error results from pending operations. In the likely scenario that
> +dm-crypt is hosting the root filesystem the recovery is identical to if a
> +storage controller failed to resume from suspend, reboot. If the volume
                                            "suspend and reboot"?
> +impacted by an IWKey restore failure is a data-volume then it is possible
> +that I/O errors on that volume do not bring down the rest of the system.
> +However, a reboot is still required because the kernel will have
> +soft-disabled Key Locker. Upon the failure, the crypto library code will
> +return -ENODEV on every AES-KL function call. The Key Locker implementation
> +only loads a new IWKey at initial boot, not any time after like resume from
> +suspend.
> +
> +Use Case and Non-use Cases
> +==========================
> +
> +Bare metal disk encryption is the only intended use case.
> +
> +Userspace usage is not supported because there is no ABI provided to
> +communicate and coordinate wrapping-key restore failure to userspace. For
> +now, key restore failures are only coordinated with kernel users. But the
> +kernel can not prevent userspace from using the feature's AES instructions
> +('AES-KL') when the feature has been enabled. So, the lack of userspace
> +support is only documented, not actively enforced.
> +
> +Key Locker is not expected to be advertised to guest VMs and the kernel
> +implementation ignores it even if the VMM enumerates the capability. The
> +expectation is that a guest VM wants private IWKey state, but the
> +architecture does not provide that. An emulation of that capability, by
> +caching per VM IWKeys in memory, defeats the purpose of Key Locker. The
> +backup / restore facility is also not performant enough to be suitable for
> +guest VM context switches.
> +
> +AES Instruction Set
> +===================
> +
> +The feature accompanies a new AES instruction set. This instruction set is
> +analogous to AES-NI. A set of AES-NI instructions can be mapped to an
> +AES-KL instruction. For example, AESENC128KL is responsible for ten rounds
> +of transformation, which is equivalent to nine times AESENC and one
> +AESENCLAST in AES-NI.
> +
> +But they have some notable differences:
> +
> +* AES-KL provides a secure data transformation using an encrypted key.
> +
> +* If an invalid key handle is provided, e.g. a corrupted one or a handle
> +  restriction failure, the instruction fails with setting RFLAGS.ZF. The
> +  crypto library implementation includes the flag check to return an error
> +  code. Note that the flag is also set when the internal wrapping key is
> +  changed because of missing backup.
> +
> +* AES-KL implements support for 128-bit and 256-bit keys, but there is no
> +  AES-KL instruction to process an 192-bit key. But there is no AES-KL
> +  instruction to process a 192-bit key. The AES-KL cipher implementation
> +  logs a warning message with a 192-bit key and then falls back to AES-NI.
> +  So, this 192-bit key-size limitation is only documented, not enforced. It
> +  means the key will remain in clear-text in memory. This is to meet Linux
> +  crypto-cipher expectation that each implementation must support all the
> +  AES-compliant key sizes.
> +
> +* Some AES-KL hardware implementation may have noticeable performance
> +  overhead when compared with AES-NI instructions.
> +

The rest is LGTM.

-- 
An old man doll... just what I always wanted! - Clara

