Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CABA60CCD6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJYNBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiJYNAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:00:50 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288A1192A6;
        Tue, 25 Oct 2022 05:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4upcEUNCFEu3hk4JtYzdLpibVWwDGGjBVwHjdTMXMTk=; b=ZOZzbBhTSmMZDGiPnG6DUV06bL
        l5GBrzGw8a9xBkvd5Vox2vP8B9UYG+YNE1oYr5Rpey2BmS9rPnr1rNPScQIwd5g/8wPo6JvY+5c/B
        hIZwB0og4hI1qUvg/uKsK7DGbJ4Ya4ayRuCgKzs4Ho2BMZPQZMIDv3J/ZNr10M3wkpGXUlQAdmAIE
        uKAs+9pKGwzAH22oDcBxzRoFPwOXem7D6I3WMo2Wk/DtMRwFDEqSL+W5gapk4wWhID92qFB+bjKen
        JprE/SjPB30EjBM6fFXDg8OeUGxlpp/+EL/Bn4mcnYK5YBVPwLqJmy/4ewMierOfdPfEMgjkydMbZ
        FeVsohEw==;
Received: from [177.95.16.195] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1onJVB-005DXf-RJ; Tue, 25 Oct 2022 14:57:54 +0200
Message-ID: <db3183ee-df61-a9fd-abdf-92df6d578ec6@igalia.com>
Date:   Tue, 25 Oct 2022 09:57:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3] x86/split_lock: Add sysctl to control the misery mode
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>,
        Andre Almeida <andrealmeid@igalia.com>
References: <20221024200254.635256-1-gpiccoli@igalia.com>
 <Y1dcDmmIu8gSX4Rb@debian.me> <7db9c3a5-2120-5ede-eb4e-077e3ed6c1f7@intel.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <7db9c3a5-2120-5ede-eb4e-077e3ed6c1f7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other than that, is this version good enough in your opinion Dave?

Personally I think Bagas could submit a patch later and propose the
changes to the docs as well.

Cheers,


Guilherme
