Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA96611377
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiJ1Nqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiJ1Nq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:46:26 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCD01BC161;
        Fri, 28 Oct 2022 06:45:30 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f193so4916844pgc.0;
        Fri, 28 Oct 2022 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nCBeqNhxGHNAOTB5X4QzGaGY7ElJNzraVUZzOfIwnw=;
        b=OWFjRJDjG0hZfvLzLrLn6gcWEpwMr7W8FRJQuFzilZqybD6zTxuQ/dOTSuDSp74DlW
         XbJ7LBJWephs36XZZIKfDOet/m5Xh8ebOdZvkxuoJ5GiGe1g0usITsw8q9GVwTu57SEs
         xqzMYMz3g82LTZ8drLAVoV4XqyhL9SXvPKBaFUj+NpToaHGMpuZRRLoHo0woJYcIqBX0
         WREf3kQyaEaJB5K0pxMr+tAxLDnb2hVAPw5tMOXBhD9i+kpdnIar2Dja2db2ZWtodHIV
         jGuhf8s2RsswctZd4SUzWuJfOlRn2CIO1e4dNazBUFQWuy5ORoNrONvxaWsPvZJ35A2m
         a41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nCBeqNhxGHNAOTB5X4QzGaGY7ElJNzraVUZzOfIwnw=;
        b=FlCOj8oIo1zHhM0w/ggctkQPCp5OJdCBVocCxgIUGUNmd54jeXcznBDqXprsuvv3bm
         +6H7kztQnWmGMF0O2P6b1UqdHyjDrGmtftdjPh04xqmWfsSf0zEsLFKI+mR0QOQrpp0p
         C6vRTE2R8xUlxFCQpcj+bRd7Xyw4RH7pP7OlqQ9l2wF2QLQICpuyfy8w9+bMN5TXp1+Q
         56Cgf1gSg+1f/zHw3kasNixU5qaZR35nV0mQpZ9DCXlWrhoapYn4oom1oE9fQSPrgCML
         DJvz1o807etUe+hy9ssyR8nOEEC+ATHLQhFWvuKhmaLpFz68mEhcAq6MKbbxwY836WVa
         ou0w==
X-Gm-Message-State: ACrzQf2wr9QN0dZa99w9aDmKqlKpTk17ra6BdncC4nLhOfVHtL5GR4nw
        74JocMPbhz204WPZSF3mlt0=
X-Google-Smtp-Source: AMsMyM6AEhB7L7ZMphKIJJWq0vrsiEJSZ+mJNPPyytr0Dzis4Hli3RA9hImOcXsh8f2jyj9NRE4S5A==
X-Received: by 2002:aa7:9e1c:0:b0:56c:78fa:2a2 with SMTP id y28-20020aa79e1c000000b0056c78fa02a2mr12079092pfq.65.1666964729960;
        Fri, 28 Oct 2022 06:45:29 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709027e0e00b00187022627d7sm319743plm.36.2022.10.28.06.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:45:29 -0700 (PDT)
Message-ID: <80c998ec-435f-158c-9b45-4e6844f7861b@gmail.com>
Date:   Fri, 28 Oct 2022 20:45:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 09/15] x86/APM: remove APM_BIOS_MAGIC
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <ff5e936ea657d9197a9c13404b9fd880dffc9fbb.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ff5e936ea657d9197a9c13404b9fd880dffc9fbb.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 05:43, наб wrote:
> We have largely moved away from this approach,
> and we have better debugging instrumentation nowadays: kill it
> 

Again, see [1] and [2].

Also, please write the patch description in imperative mood, not
descriptive not even in first-person POV.

[1]: https://lore.kernel.org/linux-doc/47c2bffb-6bfe-7f5d-0d2d-3cbb99d31019@gmail.com/
[2]: https://lore.kernel.org/linux-doc/9d96c96d-dfc7-7749-07d4-2601c00661c2@gmail.com/

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

