Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD9E60109F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiJQN6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJQN5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:57:42 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D3642D1;
        Mon, 17 Oct 2022 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6QZ3gapeMS/aSRKE6Bc1zdlguo4AQT7A2NhJ50U8mgk=; b=sWH+XupFFO60xes+EwZS6aJ6/o
        qjRpjYWRAlGfyttkjnohOP054j5rWeCHxcsnCop9rmvN1ugvH9q1xXi1MfPlzX1fZOrBFhPPOUKAQ
        CZvyO8HhNVrD/2ymBDo9dMjeRmUKw2or9NVYMG05TtMv/Ze7HFXPP3aG7uC57iBXlEDY/z7USmgHX
        oxAmDtgqXjmm7/yIBNubAd0/lMa4JKD1jHuCbUNAKrARVHsgeiqqs6VpxZVXS1ot3mQeeodY710Pz
        26jiD2tsm7SY7aUgc1cB3tFotq4fHciB7EBepLQD0FRttCjQGJjiKyzaDbhjkw6lRwk8WQ9mh/zrS
        9jkh49AQ==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1okQcM-000Nos-4q; Mon, 17 Oct 2022 15:57:22 +0200
Message-ID: <0d9d589e-4f6c-02a4-fb00-b4467e75b47f@igalia.com>
Date:   Mon, 17 Oct 2022 10:57:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Andre Almeida <andrealmeid@igalia.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>
References: <20221014180506.211592-1-gpiccoli@igalia.com>
 <Y0tz1/pR/s7+j6s+@debian.me>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Y0tz1/pR/s7+j6s+@debian.me>
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

Thank you Bagas! I see you fixed the documentation in more than one
place, appreciate that.

What's the next step then, re-submit with your fixes, or wait more
feedback perhaps?

If a maintainer plans to pick this one, maybe they can just apply your
fix-up on top of it.
Cheers,


Guilherme
