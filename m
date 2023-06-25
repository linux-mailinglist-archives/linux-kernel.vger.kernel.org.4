Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A9E73CE71
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 06:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFYElT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 00:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFYElQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 00:41:16 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8539137;
        Sat, 24 Jun 2023 21:41:14 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b0138963ffso1016672fac.0;
        Sat, 24 Jun 2023 21:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687668074; x=1690260074;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1B4lH9WeYTv33HNkRVZObp7asR+HnhMg6dQl8HhZ2qY=;
        b=MMnqhoSXSLWLJfn5GfJIKP92DaK/FakNRAVS4oHMhcdVp319bbfgC72mCQ56ugPmpT
         DS4FqwEX03Db/bCNvyQ0fswZ3OKXXUvET442ZZ5Hk+boT61bVEVxXdSMtpA0/wKcMnL+
         oN/FeLQsYqWWnIP4I+YhZ1VghbAPnGirJMdONVrr/Gyi9ErJEAaej1iYCvnXQ6hiToR4
         RBeIvnD0q0eaJYcaBxqn6GVPnFmzh9Y4w1T5pl5a1YLmkbV5D8ldUTQGVhNAnhbjKBav
         YhWthSSeqS0nevcQTPhp77J2Ltsn/ZXuBi7S+ItSMQf3W4nTdcqJh94kexOZtAQmqIA6
         I0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687668074; x=1690260074;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1B4lH9WeYTv33HNkRVZObp7asR+HnhMg6dQl8HhZ2qY=;
        b=Pc/sHJ3oZy+J5TsS9JBotrkT7tN7grU7VwuDrmXnYrEGpmlkgFte9ZSjLpqas0vxC9
         WnwaviX6ZFTs7iV4gavZfC+j50/tYhQ2ySg3ZDnqrCr3jYmUB74ofU0dXToBNNeJ0iLQ
         9d/OhLR2Ntz5X9iGotH4+YGQWuUaVnhxQPWpaQBPdSk610pEgjtPoOv346EMgzKNSPLV
         rixG8rcPAYGrc+9xdfs9xCH3WtSTHaZCtJ5WeTzut4i2c6QhudEzo5udF5ro8mlHimwC
         iqyZ74FyrWjcBqFqnWsqa0PQXH9yrrAtBRNhsSySWRmg9aGb1QvPB954VFe5EMu9egHM
         JvTg==
X-Gm-Message-State: AC+VfDz7DEnr8RfmOij2+idMhBQT8qVhj0YMfapzzX093xDb49kNKzLu
        ElAMkRpaLSC8F7C+1zdFOSYWkSatqx7wtg==
X-Google-Smtp-Source: ACHHUZ72rJJVSWVBVO8GaJv7atxqNw1z/wt95NIVyxtaWXaXjGuxoQ1OGxMVqFnFFBqjXnHbioxRhA==
X-Received: by 2002:a05:6870:6295:b0:18e:2b7e:a846 with SMTP id s21-20020a056870629500b0018e2b7ea846mr16655070oan.50.1687668074012;
        Sat, 24 Jun 2023 21:41:14 -0700 (PDT)
Received: from [192.168.1.128] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id bd6-20020a056870d78600b001ad21a705a8sm1925228oab.49.2023.06.24.21.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 21:41:13 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <69b98eb4-2c4e-fe75-90b4-4b08505a595a@lwfinger.net>
Date:   Sat, 24 Jun 2023 23:41:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "Sardonimous ." <sardonimous@hotmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Cc:     =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
 <b9428e48-f0f9-46f6-892c-4c8834c930c4@app.fastmail.com>
 <RO2P215MB193850DDADD38492BEC8CC2FA720A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <a3bc5eb5-9639-8016-36ab-105abc8c0ca3@gmail.com>
Content-Language: en-US
In-Reply-To: <a3bc5eb5-9639-8016-36ab-105abc8c0ca3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 19:50, Bagas Sanjaya wrote:
> On 6/25/23 04:47, Sardonimous . wrote:
>> A newer report with the missing top lines:
>>
> 
> tl;dr:
> 
>> A: http://en.wikipedia.org/wiki/Top_post
>> Q: Were do I find info about this thing called top-posting?
>> A: Because it messes up the order in which people normally read text.
>> Q: Why is top-posting such a bad thing?
>> A: Top-posting.
>> Q: What is the most annoying thing in e-mail?
>>
>> A: No.
>> Q: Should I include quotations after my reply?
>>
>> http://daringfireball.net/2007/07/on_top
> 
> Also, please send plain-text email: I don't see your dmesg on
> lore.kernel.org archive because you send HTML email instead.
> 
> But anyway, I'm pasting yours from Bugzilla thread instead
> (as Arnd requested):
> 
> ```
> Jun 20 18:20:11 askasleikir kernel: ------------[ cut here ]------------
> Jun 20 18:20:11 askasleikir kernel: WARNING: CPU: 1 PID: 33 at net/mac80211/util.c:514 __ieee80211_stop_queue+0xcc/0xe0 [mac80211]
> Jun 20 18:20:11 askasleikir kernel: Modules linked in: ccm tun qrtr rpcrdma rdma_cm iw_cm ib_cm ib_core nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver fscache net>
> Jun 20 18:20:11 askasleikir kernel:  lockd grace crypto_user sunrpc fuse dm_mod loop bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 sr_mod>
> Jun 20 18:20:11 askasleikir kernel: CPU: 1 PID: 33 Comm: kworker/u4:2 Tainted: G        W          6.3.6-arch1-1 #1 a07497485287c74e7a472f42ded4b2ddcf7a6fd7
> Jun 20 18:20:11 askasleikir kernel: Hardware name: Apple Inc. MacBookPro7,1/Mac-F222BEC8, BIOS    MBP71.88Z.0039.B15.1702241313 02/24/17
> Jun 20 18:20:11 askasleikir kernel: Workqueue: phy0 b43_tx_work [b43]
> Jun 20 18:20:11 askasleikir kernel: RIP: 0010:__ieee80211_stop_queue+0xcc/0xe0 [mac80211]
> Jun 20 18:20:11 askasleikir kernel: Code: 74 11 48 8b 78 08 0f b7 d6 89 e9 4c 89 e6 e8 fb ea 00 00 65 ff 0d 2c 2d ac 3e 0f 85 55 ff ff ff e8 d9 44 69 c3 e9 4b ff>
> Jun 20 18:20:11 askasleikir kernel: RSP: 0018:ffffb3538013bdb8 EFLAGS: 00010097
> Jun 20 18:20:11 askasleikir kernel: RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000000
> Jun 20 18:20:11 askasleikir kernel: RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff9e55cfa248e0
> Jun 20 18:20:11 askasleikir kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 000000008010000f
> Jun 20 18:20:11 askasleikir kernel: R10: 0000000000000005 R11: 0000000000000181 R12: ffff9e55cfa248e0
> Jun 20 18:20:11 askasleikir kernel: R13: 0000000000000000 R14: ffff9e55cfa26238 R15: ffff9e55cfa26090
> Jun 20 18:20:11 askasleikir kernel: FS:  0000000000000000(0000) GS:ffff9e55fbf00000(0000) knlGS:0000000000000000
> Jun 20 18:20:11 askasleikir kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 20 18:20:11 askasleikir kernel: CR2: 00007f37cce5d180 CR3: 0000000057620000 CR4: 00000000000406e0
> Jun 20 18:20:11 askasleikir kernel: Call Trace:
> Jun 20 18:20:11 askasleikir kernel:  <TASK>
> Jun 20 18:20:11 askasleikir kernel:  ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211 01be121fb223b347160617528f5dda900e828bc2]
> Jun 20 18:20:11 askasleikir kernel:  ? __warn+0x81/0x130
> Jun 20 18:20:11 askasleikir kernel:  ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211 01be121fb223b347160617528f5dda900e828bc2]
> Jun 20 18:20:11 askasleikir kernel:  ? report_bug+0x171/0x1a0
> Jun 20 18:20:11 askasleikir kernel:  ? handle_bug+0x3c/0x80
> Jun 20 18:20:11 askasleikir kernel:  ? exc_invalid_op+0x17/0x70
> Jun 20 18:20:11 askasleikir kernel:  ? asm_exc_invalid_op+0x1a/0x20
> Jun 20 18:20:11 askasleikir kernel:  ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211 01be121fb223b347160617528f5dda900e828bc2]
> Jun 20 18:20:11 askasleikir kernel:  ? __slab_free+0xe0/0x310
> Jun 20 18:20:11 askasleikir kernel:  ieee80211_stop_queue+0x36/0x50 [mac80211 01be121fb223b347160617528f5dda900e828bc2]
> Jun 20 18:20:11 askasleikir kernel:  b43_pio_tx+0x373/0x390 [b43 3dc9b3f0fd98e2a659c64e057bd3b22d977e5228]
> Jun 20 18:20:11 askasleikir kernel:  b43_tx_work+0x57/0x130 [b43 3dc9b3f0fd98e2a659c64e057bd3b22d977e5228]
> Jun 20 18:20:11 askasleikir kernel:  process_one_work+0x1c7/0x3d0
> Jun 20 18:20:11 askasleikir kernel:  worker_thread+0x51/0x390
> Jun 20 18:20:11 askasleikir kernel:  ? __pfx_worker_thread+0x10/0x10
> Jun 20 18:20:11 askasleikir kernel:  kthread+0xde/0x110
> Jun 20 18:20:11 askasleikir kernel:  ? __pfx_kthread+0x10/0x10
> Jun 20 18:20:11 askasleikir kernel:  ret_from_fork+0x2c/0x50
> Jun 20 18:20:11 askasleikir kernel:  </TASK>
> Jun 20 18:20:11 askasleikir kernel: ---[ end trace 0000000000000000 ]---
> Jun 20 18:20:11 askasleikir kernel: ------------[ cut here ]------------

Sardonimous,

The critical line is:
> Jun 20 18:20:11 askasleikir kernel:  b43_pio_tx+0x373/0x390

I certainly have not used PIO for a long time. I expect that your MacBook Pro 
should do DMA on the b43. Apple makes wierd hardware, but not likely that wierd.

Does dmesg offer any clues as to what is happening?

If there is nothing shown in the log, you definitely need to do a proper 
bisection from the mainline git tree to isolate the change that led to this failure.



ADDED WITH EDIT: I looked at the code and b43 will not be built for any hardware 
without DMA, thus it appears that adding "b43.pio=1" is the only way to get PIO 
mode. Please check the output of dmesg for PIO messages.

Larry
