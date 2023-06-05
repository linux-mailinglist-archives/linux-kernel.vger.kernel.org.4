Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881F37223EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjFEKzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjFEKyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:54:54 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15766F1;
        Mon,  5 Jun 2023 03:54:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-650352b89f6so2210071b3a.0;
        Mon, 05 Jun 2023 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685962490; x=1688554490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgcgjvcFqJ16hUvgLs2bTi5nsSAAxgHJ3nGSH16Iezs=;
        b=qNy9NVkLEUujmwerpRY8KnA7c5hcI5UYt8nLGJEfR0SKXjyZ92BNz8rhuIF0qxl7aX
         PWW8H3wvdXqu1C/AaEpV7PJsO1VQPrvZ9r66bEjv3KSblQ5e8CuoyEIqEpBFzqyn+fSD
         ejxSQmbNX01rbFWuoL2xp2Ul9EcdCM82OxPbYf9Q4j02lMYW7Qeh0I081jWb/kPtQB1y
         K36/UBfNBBMIRuul5cX6oO68vnyeTYYHztTCZPVc2DZRmG9j4BPXIAQzo/t5A1GFTWeO
         LqCEyCTnuH4706o/krmUW9FO7/tTZF9rvloqGTKuDeYo55v2h02dZ5dqdxkvbEKuGUUa
         FIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962490; x=1688554490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgcgjvcFqJ16hUvgLs2bTi5nsSAAxgHJ3nGSH16Iezs=;
        b=WNAQtNHH15B9GJQld6lD98LJ4wyVcDZUevsb1kM98oygD5qqzkt4xcKPz3rdR00sXY
         sFbfNw+1WHbRIeB2t7PUkuBBvY58FUCuXhKhJm6vo5MroW/i+DHCbL1Gkm4zdvvYEEaA
         mTB/gESYrHf6aKtv/rLc1ZKXmexmGyukS+69qYBPW7AuXmY3lSHVaFt4eUOmNBSQB69Z
         /F70O+SRpkqX6UrMQeVOzzZp3o/ID3Ijcnj05XCsCs/SHilzFqBrUmHJlFjYGTfJoTB0
         Y80xxbKIjNLTylvHYPcTDRG1N95u4IsPhSLu37oraJTOZ6ZOHUTMgBNipnfix+Pimp0t
         /S7w==
X-Gm-Message-State: AC+VfDzf6gTayg4HL9QwFazwNMvHT82Hh5YmHKI/XdFpGQkEhuZOY6WE
        O5tO2QXUVVIiRo23cpihh94=
X-Google-Smtp-Source: ACHHUZ7bI67fM9JC8fBlc4gJJbjHk34ajtFWisoCdHmD6arrU7/k9D1h4qusPKrbNSe+CBmqSlJmdA==
X-Received: by 2002:a05:6a20:1451:b0:101:282c:2b with SMTP id a17-20020a056a20145100b00101282c002bmr1857364pzi.32.1685962490313;
        Mon, 05 Jun 2023 03:54:50 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-71.three.co.id. [180.214.233.71])
        by smtp.gmail.com with ESMTPSA id jf12-20020a170903268c00b001b176d96da0sm6345746plb.78.2023.06.05.03.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 03:54:49 -0700 (PDT)
Message-ID: <91fc8d61-1a34-bc37-41c1-1528ff93c654@gmail.com>
Date:   Mon, 5 Jun 2023 17:54:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 01/12] Documentation/x86: Document Key Locker
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, elliott@hpe.com, gmazyland@gmail.com,
        luto@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20230603152227.12335-2-chang.seok.bae@intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230603152227.12335-2-chang.seok.bae@intel.com>
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

On 6/3/23 22:22, Chang S. Bae wrote:
> +==============
> +x86 Key Locker
> +==============
> +
> +Introduction
> +============
> +
> +Key Locker is a CPU feature to reduce key exfiltration opportunities
> +while maintaining a programming interface similar to AES-NI. It
> +converts the AES key into an encoded form, called the 'key handle'.
> +The key handle is a wrapped version of the clear-text key where the
> +wrapping key has limited exposure. Once converted, all subsequent data
> +encryption using new AES instructions (AES-KL) uses this key handle,
> +reducing the exposure of private key material in memory.
> +
> +CPU-internal Wrapping Key
> +=========================
> +
> +The CPU-internal wrapping key is an entity in a software-invisible CPU
> +state. On every system boot, a new key is loaded. So the key handle that
> +was encoded by the old wrapping key is no longer usable on system shutdown
> +or reboot.
> +
> +And the key may be lost on the following exceptional situation upon wakeup:
> +
> +Wrapping Key Restore Failure
> +----------------------------
> +
> +The CPU state is volatile with the ACPI S3/4 sleep states. When the system
> +supports those states, the key has to be backed up so that it is restored
> +on wake up. The kernel saves the key in non-volatile media.
> +
> +The event of a wrapping key restore failure upon resume from suspend, all
> +established key handles become invalid. In flight dm-crypt operations
> +receive error results from pending operations. In the likely scenario that
> +dm-crypt is hosting the root filesystem the recovery is identical to if a
> +storage controller failed to resume from suspend, reboot. If the volume
"... resume from suspend or reboot."
> +impacted by a wrapping key restore failure is a data-volume then it is
> +possible that I/O errors on that volume do not bring down the rest of the
> +system. However, a reboot is still required because the kernel will have
> +soft-disabled Key Locker. Upon the failure, the crypto library code will
> +return -ENODEV on every AES-KL function call. The Key Locker implementation
> +only loads a new wrapping key at initial boot, not any time after like
> +resume from suspend.
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
> +expectation is that a guest VM wants private wrapping key state, but the
> +architecture does not provide that. An emulation of that capability, by
> +caching per-VM wrapping keys in memory, defeats the purpose of Key Locker.
> +The backup / restore facility is also not performant enough to be suitable
> +for guest VM context switches.
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
> +  crypto library implementation includes the flag check to return -EINVAL.
> +  Note that this flag is also set if the wrapping key is changed, e.g.,
> +  because of the backup error.
> +
> +* AES-KL implements support for 128-bit and 256-bit keys, but there is no
> +  AES-KL instruction to process an 192-bit key. The AES-KL cipher
> +  implementation logs a warning message with a 192-bit key and then falls
> +  back to AES-NI. So, this 192-bit key-size limitation is only documented,
> +  not enforced. It means the key will remain in clear-text in memory. This
> +  is to meet Linux crypto-cipher expectation that each implementation must
> +  support all the AES-compliant key sizes.
> +
> +* Some AES-KL hardware implementation may have noticeable performance
> +  overhead when compared with AES-NI instructions.
> +

The rest is LGTM, thanks!

Anyway,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

