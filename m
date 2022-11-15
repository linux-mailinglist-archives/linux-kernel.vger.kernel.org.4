Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC35629DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiKOPe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiKOPeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:34:17 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC39EE30
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sxGFQMeIhmiADf7XT/hfP3/fl66vCfyr7KNcTxTSahk=; b=pDLDle0nI2/AsXnoP2GYP+wNYJ
        wPsR0T3wtRbArJdicK/gvA7whIq13PfcZuzydEU3wP28H+SFgHhUMEP1hOLqJtU/+xQrOZavMZeir
        hOO/01Zbg4zXc0jteeBYrtOO9m5i7Q3sevGWopTXy5feDpcV3lSHylUjq7BQ2i1Rbh2j4aiCFmShz
        GKNcsq8acO6uOkmT7vdlR3KSPaG7emwcvfQ+7jFugHZ+eWAcrXf4Wx6ZZ8Qdvm/XhKVkVlLMBTyeP
        SOpMvpzT9Uj0d4Lv+HINgGWUZLCKcxOdaNyB6FJQQcMSst44AFLX6kpoN/w1sBXgmhKfszKg3Y13k
        lFxK8BDg==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ouxwX-001IcX-29; Tue, 15 Nov 2022 16:33:45 +0100
Message-ID: <abf9feef-443f-fcfa-952c-0123e61b280d@igalia.com>
Date:   Tue, 15 Nov 2022 12:33:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 0/3] x86/crash: Fix double NMI shootdown bug
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20221114233441.3895891-1-seanjc@google.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221114233441.3895891-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 20:34, Sean Christopherson wrote:
> [...]
> v3:
>   - Re-collect Guilherme's Tested-by.
>   - Tweak comment in patch 1 to reference STGI instead of CLGI.
>   - Celebrate this series' half-birthday.

Heheh

Thanks a lot for persisting with this Sean, much appreciated! I'm
surprised on how long is taking to get these _fixes_ merged in the
kernel, hence your effort is very valuable =)

Cheers,


Guilherme
