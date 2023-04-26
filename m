Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB596EF53A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbjDZNMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbjDZNMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:12:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7F626AC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:12:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5055141a8fdso10344538a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682514763; x=1685106763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFf6ynUEdWvZg24idlsMEJNdaFi8wG+njYK3TUT9Ygg=;
        b=FX50yMpsaLk6q0JYobPAobLrNR4o0lBTG6lJGhtMqRJhPOZxaXmXZunFaLlYE58+Kx
         faiIrdAhs7xoUmtAUmuw+Tr/fH3hIZzvrfFLdslClXVmpXjO/ZW5CWI/aQp9dXbh7S/H
         6nQw6k1a71VnpkiIEqfkVMw/UNRG0D6egzwTCXPY7x2XqkFN1junFG16jR+qSjQrtUfy
         RKWibIHIUdkVJcYfrqOeCZnuGZk5QsJ1kkzLV71lAnHiXCg0wuoH883K9+Ezc9qWLz77
         /42LfzmDU5Geh3rcWjm3ssl91Lj8uITM9fyOFypAvE0PrR9OOVWLO1efyUbEquhJc/kc
         nlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682514763; x=1685106763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFf6ynUEdWvZg24idlsMEJNdaFi8wG+njYK3TUT9Ygg=;
        b=Umr94wI4q8yhvYLpHR/hYwn2lJKCjSH7kcYOyypQ3wuArtupFnYoBEo8USSCrApLEG
         28tE5+zsRcMMcz2ZhtikGTORt+qKirsS5uHn5AFf4JHvY1p5SQKsufxBE3dRKLGG+YR7
         kj0cpLLBiwbrECsRlKo6AEq5wP7zPfBHtHl1XN4Bupa1bImn/e/cxmKvoLgDu6zUFZXS
         3Mhl7KWZfhYqIo+TRvMwZa1DpHSJDOIS8eannmlV0Vx9nZAkOAuBOJkv9JYZ+cGoLTH3
         B4x5uOKRw6smnVpXhIcotiR97S822A6N07roR4RvRaDJCvkTQbKUFFpGoqKZah9EWRkM
         M9Jg==
X-Gm-Message-State: AAQBX9dNLX4wZxzLM0qQJYfLaJaenQ/N4z1uZ60m1Ro5P54eFT+BMnj6
        D+2EG+xeDAYxdXYFLxi6KU5K0A==
X-Google-Smtp-Source: AKy350bo0t5Ha0uwpw3G4VATjMGhJ2s4SHwb5d83OKKUWvs5hv9CaUzprnuqhPXJ3Orqf9zYo9UwZA==
X-Received: by 2002:a05:6402:349:b0:504:784e:47d9 with SMTP id r9-20020a056402034900b00504784e47d9mr18236567edw.6.1682514763152;
        Wed, 26 Apr 2023 06:12:43 -0700 (PDT)
Received: from [172.23.2.142] ([31.221.30.162])
        by smtp.gmail.com with ESMTPSA id u10-20020a056402064a00b00506addaaab0sm6783210edx.32.2023.04.26.06.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 06:12:42 -0700 (PDT)
Message-ID: <1b67d480-d6f1-965f-ccfa-0874eb9a3b6b@linaro.org>
Date:   Wed, 26 Apr 2023 15:12:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Syzkaller & bisect] There is WARNING in tpm_chip_unregister in
 upstream patch "tpm: st33zp24: Mark ACPI and OF related data as maybe unused"
To:     Pengfei Xu <pengfei.xu@intel.com>, jarkko@kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@ziepe.ca, heng.su@intel.com,
        peterhuewe@gmx.de, dhowells@redhat.com, lkp@intel.com
References: <ZEjqhwHWBnxcaRV5@xpf.sh.intel.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZEjqhwHWBnxcaRV5@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 11:10, Pengfei Xu wrote:
> Hi Jarkko and Krzysztof Kozlowski,
> 
> Greeting!
> 
> Platform: x86 platforms
> 
> There is WARNING in tpm_chip_unregister in upstream patch "tpm: st33zp24: Mark
> ACPI and OF related data as maybe unused":
> https://lore.kernel.org/lkml/20230424144130.1084795-1-jarkko@kernel.org/
> -> https://lore.kernel.org/lkml/20230319141354.22907-1-krzysztof.kozlowski@linaro.org/
> 
> We tested Intel internal kernel and found that, the above patch caused below
> WARNING and then kernel BUG dmesg info. After reverted above commit on top
> of Intel internal kernel, this issue was gone.
> I checked that internal commit:"c3985d8b9c22 tpm: st33zp24: Mark ACPI and OF
> related data as maybe unused" was same as above link patch.
> This issue could be reproduced in 155s in VM.
> 
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230426_132902_tpm_chip_unregister_warning
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/repro.c
> Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/repro.prog
> Syzkaller analysis report: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/repro.report
> Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/bisect_info.log
> 
> "
> [   24.638052] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=329 'systemd'
> [   28.731375] cgroup: Unknown subsys name 'net'
> [   28.741433] cgroup: Unknown subsys name 'rlimit'
> [   35.900833] tpm tpm0: Operation Canceled
> [   35.901377] ------------[ cut here ]------------
> [   35.901648] refcount_t: addition on 0; use-after-free.
> [   35.901986] WARNING: CPU: 0 PID: 4095 at lib/refcount.c:25 refcount_warn_saturate+0xe6/0x1c0

Thanks for the report. I am quite surprised that this commit was pointed
as possible cause. The patch does not touch anything related to reported
issue... At least I do not see it. Could be some tooling problem in your
reproduction steps?


Best regards,
Krzysztof

