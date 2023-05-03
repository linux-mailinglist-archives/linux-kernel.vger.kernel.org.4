Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26046F4F7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 06:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjECEkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 00:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECEkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:40:08 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502982D4C
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 21:40:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24781e23c27so4631592a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 21:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683088807; x=1685680807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=77tiXpQ2HjbyMiGi98E0ovy9Ioj8cftg4GmqV7//X1I=;
        b=AP6cSbQMwHS6YgLcCIuhbKJsz4vaRSY9hCqhPFEtm1HvvnSf0N2gxnGfZTtZNeb3fM
         TZoK8iW8O8MRog34ymtley4D9V4uy5F6QwMBxbNoC6MOWj60ENUdFc9y3b2u/j6Y1tJz
         hkHjUFD9D/tzIc6oyyld8M2eNwZryMU6ID3HCJ0OIFfHV+sxQAlh5dWP9F6FXA8pt9hW
         qUU8Q1dvEAbAMjCbH6dYmU3dC00Dha/cZMaGdMtWi9pq7ekseqAWr/oQr/shKek35CZ2
         OSNWdXu8oT2IHmDEP+wDrzo+sdwPvFSNLWzCvIF9/pr5vb/SXBHtJnwQNQuLNTNxfiFO
         g40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683088807; x=1685680807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77tiXpQ2HjbyMiGi98E0ovy9Ioj8cftg4GmqV7//X1I=;
        b=M9jEpUISbKVGm1rkjadE0yg6kFbockt9ANAMuGmepad8PNvKGsF/P2ff7S6sY4UpMw
         WBuLv51jU2URqCTpxSnKD7dKsnvdmS+Ce9ylJ8WHWPc7xwcFFEOxAFQmEGgFPycycjhb
         echEH1ekT045k/ohJm4sP2lreydl9ekTf9r/jYt5cGyA5hTAtErWJ9HiW/wlHiC68tH3
         f+iyhkjg4KPjGtiVvnJefx6+pWgT29/SuY3OkE5a3cxegaq4zdOGRR+zsRUiL0Zo+7zJ
         qSA/pnAcgzpa2hLM4xxOHR/CUjYU2banUu6bGM5vSOM3asfMYV9TaBgDP0KTNOa1MveS
         9oCg==
X-Gm-Message-State: AC+VfDz/DPdYB9gw4pY90dtIyRnEbN6L3O1FU57dKh0XVOGtW8g8Hbo6
        kAng+Df8+cVTECockWgwRvE=
X-Google-Smtp-Source: ACHHUZ6FVFqaBqyy90CyPDYOpLziIFIxoEYbT12+sSR0gn8lbdxTMRS5XqCfds/MEuQG/S5rDPBXNw==
X-Received: by 2002:a17:90b:4c46:b0:24d:ed1e:c2db with SMTP id np6-20020a17090b4c4600b0024ded1ec2dbmr11210942pjb.31.1683088806739;
        Tue, 02 May 2023 21:40:06 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090a9c1800b00247735d1463sm2276107pjp.39.2023.05.02.21.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 21:40:06 -0700 (PDT)
Message-ID: <b449cbf6-8286-e22d-ca87-b1bc3dce29d7@gmail.com>
Date:   Wed, 3 May 2023 11:40:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-6.4 alsa sound broken
Content-Language: en-US
To:     Jeff Chua <jeff.chua.linux@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Linux ALSA Subsystem Development 
        <alsa-devel@alsa-project.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
 <ZE9B4avbDtIXOu4O@debian.me> <87r0s0pnim.wl-tiwai@suse.de>
 <CAAJw_ZsDdiB=b2PZydQWF2fjSULit3NWE-Bf1icBEryN-GuqUw@mail.gmail.com>
 <87fs8gp0i7.wl-tiwai@suse.de>
 <CAAJw_ZveoPfnBsSkHZqmLiVWATcOosR--6Ds4cdekdi=t1yV7A@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAAJw_ZveoPfnBsSkHZqmLiVWATcOosR--6Ds4cdekdi=t1yV7A@mail.gmail.com>
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

On 5/1/23 22:03, Jeff Chua wrote:
>> There was no description about which sound backend is used.  Is it
>> PulseAudio, pipewire or dmix/dsnoop?
> 
> Just pure alsautils.
> 
> arecord -D hw:1,0,0 -f S16_LE -r 48000 recorded.wav
> aplay -D hw:1,1,0 /local/share/sounds/alsa/Side_Right.wav
> 
> [recorded.wav] attached.
> [Side_Right.wav] attached.
> aplay: version 1.2.8 by Jaroslav Kysela <perex@perex.cz>
> arecord: version 1.2.8 by Jaroslav Kysela <perex@perex.cz>
> 
> alsautils, alsaplugins alsalibs all using latest git pull.

Are you sure you build alsa tools straight from the git repo?
Can you also reproduce with latest stable version of these?
Otherwise it's anyone's guess due to moving parts...

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

