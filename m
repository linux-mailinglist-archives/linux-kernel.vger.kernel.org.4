Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0085B7EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiINCWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiINCWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:22:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D2C5D12E;
        Tue, 13 Sep 2022 19:22:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b75so8248783pfb.7;
        Tue, 13 Sep 2022 19:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Xh2tj/Sm3azGG4pEFrcs+/3d9DJUuBiaLdi0ugkWFc8=;
        b=njZ5LCTmBxMANq0KZsKakLpizFlmK0o4Zn/gnfYybetBfymjccZSv76p2IJPMZO2E+
         RHod7ouozCHayUw1eBsNxICKRlTMDdzINTFLIlznOnkfe3AWKIX+R4CFc//5YLnCPJHm
         Q8gVdL5gEhpavGoZGyDCC/k6pkJDJXS4qk8E2qSZqZ6m3Qj2eo40VjN2WnYt/gU2+L88
         T5FzoOVPXk5jHeQCqRp8l/cB4no00J7uLc4eLXbwUBw6H93jQBa6MhsMU5nNdbGHsa7K
         v0d/qfVmkeWEbbQgcUr/fJpwtRFC8WqprmxtrVl+6IGvKHE9dRSANqNMSLBo4foqPdsX
         zTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Xh2tj/Sm3azGG4pEFrcs+/3d9DJUuBiaLdi0ugkWFc8=;
        b=ts4f1ez9SEWdiZtAvuI63dwl1VyboNnKnTqHOBHrygm4BYKMqUMMtEAJ1RenmFvU1J
         l2yFCZZGMHPnaiv4+WthSL1REjxZNzfEVWDe/x73y7M0BQ7HSbKI4yZvgXgENfPsZ4Fg
         Jz2tRw6bBDYsVwelo8qMLgrQCFPXz0mrXuWYhW/JdhA7Mgl2eQ8ImbGNFxqGdFa8gg8N
         Kd6S3uHRDCK6hjPTAkFF9MplnvW1hLanTijJIQvh2eEOAS2jrvuV5Hy/Q1HFz0RNj53G
         0X7gTORcBI2S2PmahhBS2y9E2KXP0qW4qVi1Vkhy70mBRC1Z8zU0iUURzIBAEh2W5tYE
         vZ/w==
X-Gm-Message-State: ACgBeo0g2ZwpNs7Ka0jYURLznKhRB0PZKAmUpKMcWQBrbTXoTxgaR270
        R0bTinqPEchaxF3yKXIlGp4=
X-Google-Smtp-Source: AA6agR5g5r/B36KAruxppH2g9pWT+VmkBduzxZV0nu3PAL/AvO6oKnBb48Sqq7EqDTRqBd1fNuffnQ==
X-Received: by 2002:a05:6a00:88a:b0:53a:b7a0:ea3a with SMTP id q10-20020a056a00088a00b0053ab7a0ea3amr34561001pfj.21.1663122153986;
        Tue, 13 Sep 2022 19:22:33 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id a184-20020a621ac1000000b00543780ba513sm5846083pfa.218.2022.09.13.19.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 19:22:33 -0700 (PDT)
Message-ID: <731a3b01-1ade-6003-eb21-6b0a2c919750@gmail.com>
Date:   Wed, 14 Sep 2022 09:22:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] Documentation: remove magic number doc
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
References: <ae1e3abd-cafb-7059-b8ae-5bcb13d53b40@gmail.com>
 <20220907231109.htnfxzmr6wkuhn2v@tarta.nabijaczleweli.xyz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220907231109.htnfxzmr6wkuhn2v@tarta.nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 06:11, наб wrote:
> The entire file blames back to the start of git
> (minus whitespace from the RST translation and a typo fix):
>   * there are changelog comments for March 1994 through to Linux 2.5.74
>   * struct tty_ldisc is two pointers nowadays, so naturally no magic
>   * GDA_MAGIC is defined but unused, and it's been this way
>     since start-of-git
>   * M3_CARD_MAGIC isn't defined, because
>     commit d56b9b9c464a10ab1ee51a4c6190a2b57b8ef7a6 ("[PATCH] The
>     scheduled removal of some OSS drivers")
>     removed the entire driver in 2006
>   * CS_CARD_MAGIC likewise since
>     commit b5d425c97f7d4e92151167b01ca038e7853c6b37 ("more scheduled OSS
>     driver removal") in 2007
>   * KMALLOC_MAGIC and VMALLOC_MAGIC were removed in
>     commit e38e0cfa48ac38f4fe24453d2523852467c95b21 ("[ALSA] Remove
>     kmalloc wrappers"), six months after start of git
>   * SLAB_C_MAGIC has never even appeared in git
>     (removed in in 2.4.0-test3pre6)
>

Hi,

The patch description can be improved, see below.

Nit: Use abbreviated hash when referring to commits (`git show -s
--pretty=format:"%h (\"%s\")`). You may need to set `core.abbrev=12`
in your `~/.gitconfig`.

> At a glance, the only ones still in use are in code mostly untouched
> since git (TTY, SLIP, SCSI (drivers/scsi/{arm/queue.c,ncr53c8xx.c}),
> &c., but not PPP or PTY (neither exist now)).
>

 
"... are in drivers which are mostly untouched..."

Also, really PPP and PTY have been burninated? Since what commit?

> A rough estimate of magic numbers in the kernel may be obtained via
>   # git grep define | grep '_MAGIC\b' |
>     grep -ve IOC  -e ^tools/ -e '_IO[(WR]' -e _SUPER | wc -l
>   780
> there is, of course, a few other meanings of magic here,
> but a random sampling of SR_EEPROM_MAGIC, L2TP_TUNNEL_MAGIC,
> and MD_SB_MAGIC showed they are all used like magic-number.rst describes
> and are not in it
> 

"A rough estimate ... is obtained by:"

"Note that the word 'magic' may have different meaning from magic
number context.
There are also magic numbers which aren't listed here, like ..."

> By all accounts, it seems magic-number.rst is a low-value historical
> relic at best and misleading cruft at worst
> 

"Therefore, magic-number.rst is a low-value historial relic at best and
misleading cruft at worst, so remove the documentation."

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
