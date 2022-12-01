Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C6963F538
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiLAQZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiLAQZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:25:44 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24142A47ED
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:25:43 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so2575000pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bNjt9tPvWgAx7JuBIs6WMfVNC7BuK2Z8wYiC6YvDlc=;
        b=VXztHXDrR+xZo4L8X3MpJ1iSe68L5W8VPgrlv2eWUV7G/C3sQ+034nFFbvokv8oUTf
         mYtIJ3uQxzekOo6H7n4IyoC7CxHBC7O2zJ8CN56LBRR/Ra4ssbY/PUuUVYVaiu0jaa8F
         csCQ4uiFCpLWd4uWutUPT00ApYrbSt/L1qZW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bNjt9tPvWgAx7JuBIs6WMfVNC7BuK2Z8wYiC6YvDlc=;
        b=nPgNjZvFB9bReL6mwEwPd/h1+7wsGzaBpnLV8O3v0NtMqChYojo+dt9cl/5+40WzDT
         SKjnKnV5bvyOni8yFxdxpTQBczi3NxHLR7zBR1bkwnVQvJoE/4PWqGXq7aJoWG2Uwg2U
         TI4S0oESZffgfSzDuP3+oKD0kHXbkqeihWHcIt04vNUa32nWUw1sxLeLoNjs/OM6Th0c
         KbH+zwryv1pADGTu53Smtpx6azyA1qLSxFSBxfupKRFtn7s+c2ZmzBSIdSqbGUAQT1ue
         17TRX9J0kRQcgThIowHH47ywaB8eOGXmL2pRHAmuNuTAtzMwW3KHJhziuaO7zCWwKqwI
         Nv4w==
X-Gm-Message-State: ANoB5plo5kOTkTloSAd3xP3t9tAMAEx+4tKxWvZTN/2X9T7/G8JPNa+T
        fqGOT5bQ7fmO/FJj1q8n7WH6jg==
X-Google-Smtp-Source: AA0mqf5C6RNO0WsrG4XPNg8bQW/k9uJfNgPAyasXDOvMC133sOy/dVw7FuF1O3OtMxSGM8kjnWR3fA==
X-Received: by 2002:a17:902:74c3:b0:189:71ff:cfb5 with SMTP id f3-20020a17090274c300b0018971ffcfb5mr28712391plt.7.1669911942606;
        Thu, 01 Dec 2022 08:25:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t3-20020a1709027fc300b00187022627d8sm3831161plb.62.2022.12.01.08.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:25:42 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 1 Dec 2022 08:25:41 -0800
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: kvm_hv_flush_tlb(): Uninitialized variables
Message-ID: <202212010825.9FB75F1F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221201 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Fri Nov 18 12:59:05 2022 -0500
    260970862c88 ("KVM: x86: hyper-v: Handle HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently")

Coverity reported the following:

*** CID 1527764:  Uninitialized variables  (UNINIT)
arch/x86/kvm/hyperv.c:2024 in kvm_hv_flush_tlb()
2018     		 * Hyper-V TLFS doesn't explicitly forbid non-empty sparse vCPU
2019     		 * banks (and, thus, non-zero 'var_cnt') for the 'all vCPUs'
2020     		 * case (HV_GENERIC_SET_ALL).  Always adjust data_offset and
2021     		 * consumed_xmm_halves to make sure TLB flush entries are read
2022     		 * from the correct offset.
2023     		 */
vvv     CID 1527764:  Uninitialized variables  (UNINIT)
vvv     Using uninitialized value "data_offset".
2024     		data_offset += hc->var_cnt * sizeof(sparse_banks[0]);
2025     		consumed_xmm_halves += hc->var_cnt;
2026     	}
2027
2028     	if (hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE ||
2029     	    hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX ||

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527764 ("Uninitialized variables")
Fixes: 260970862c88 ("KVM: x86: hyper-v: Handle HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently")

Thanks for your attention!

-- 
Coverity-bot
