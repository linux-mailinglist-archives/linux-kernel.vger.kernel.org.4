Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7086F4F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 06:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjECEh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 00:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjECEhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:37:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F141FDB
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 21:37:52 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaf21bb427so23765775ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 21:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683088672; x=1685680672;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tBRpNrBSUH6LetpgU4f0Y2KfiXl/hkdBqA2mb0yht1E=;
        b=Q46J1JtdOWPafacWSg+cl2/3pw2KPyVgoSzwKoKSZFPlw9eO2rLDyCPBpM6yl3x8nc
         fdCtjZEwA6MY84cUlobNNY4nCLIwTNGdVnVfqNtEfvEClPjoMwWzXFqZfVw1fuqG3kEa
         YZAx8wMPtcxfr7O7cNTVuqVB0FiYpwOMAH1Kf/tzjGi/1xVuC0mP0zSHpuDSerBy5JW9
         W51x3CN6+hwUVQEgIAgONwSZuVpeFlyYrMaE/GhR87KPrDnJrLToxKlmjGskk6no7HaF
         yzyf5iMkTbkhRFo0KjvbS+ljgzFLv3evYmnVMOCwvVLMJfR0zBLSM+YO7B0a24POrbZn
         iLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683088672; x=1685680672;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBRpNrBSUH6LetpgU4f0Y2KfiXl/hkdBqA2mb0yht1E=;
        b=YB6HXHINBnVxrgf3TMxoQyv1fGGZ+Hb1RClC0OrpIngU7BWzdlp78l0erAMY5hGiZf
         dsWwDLr+1DInc6C0QUImrBvqR7gJACRIMdM4sfgL2gN/zqior8CwSRj640b6wL1PSEyl
         3lygY1cmYqVjOU2FlGz1el1tpDBqtTS27CFECiBoPlvaQJ/QWK5NVZo3KScGaqh0NdSW
         W15T6ZwldWl0DP1YABCZlR9/AC2JKwwJ0wzyOsPm/qBbbWWBZfx3PqYFfr4qswqekOJP
         7vFL95BRWxECCRHH7JLxaKBuO83XP8LzxUKrerfrL4momXnC/rKREIpy6aTwBchHrP9t
         Ci4A==
X-Gm-Message-State: AC+VfDzyRCuDLlU8En0FxeJ2oPEfUKof79KOvT7l+bTZXX31TJAuk/UB
        VVCAvhHAcjzZURXhp5T8Mpbvp3tsmlo=
X-Google-Smtp-Source: ACHHUZ5F2G9uszvaikvs1eFXbDQdooc27eIpRScospuCyPqfZ+tLjXP+dQZ2y3SIV3jzzNyqA1C6JQ==
X-Received: by 2002:a17:902:db03:b0:1a9:7707:80b1 with SMTP id m3-20020a170902db0300b001a9770780b1mr897127plx.67.1683088671805;
        Tue, 02 May 2023 21:37:51 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b001aae1eefc8dsm6183787plr.109.2023.05.02.21.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 21:37:51 -0700 (PDT)
Message-ID: <07f50016-5e24-56f8-0d02-df8d237059b6@gmail.com>
Date:   Wed, 3 May 2023 11:37:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-6.4 alsa sound broken
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jeff Chua <jeff.chua.linux@gmail.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
References: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
 <ZE9ngFLRqLkN6faH@ugly>
 <CAAJw_ZtKnZ3QruicqFRG_TLV0Ltbc8LSvdJSCEQRkr5GMSWvCw@mail.gmail.com>
 <63bcc1eb-b0f5-4da1-0a22-31e0c86c0851@gmail.com>
In-Reply-To: <63bcc1eb-b0f5-4da1-0a22-31e0c86c0851@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/23 11:34, Bagas Sanjaya wrote:
>> Just send .. in another email. If the atttachment got stripped off,
>> please let me know.
>>
>>
> 
> I don't see your attachment. Can you please post the link
> to your test file on file storage hosting instead?
> 

Oops, I don't see the attachment on your reply at [1]. Sorry for the
inconvenience.

[1]: https://lore.kernel.org/lkml/CAAJw_ZveoPfnBsSkHZqmLiVWATcOosR--6Ds4cdekdi=t1yV7A@mail.gmail.com/

-- 
An old man doll... just what I always wanted! - Clara

