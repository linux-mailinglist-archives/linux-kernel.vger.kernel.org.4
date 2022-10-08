Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677265F84CC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 12:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJHKid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 06:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJHKi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 06:38:29 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70422237FF;
        Sat,  8 Oct 2022 03:38:27 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w2so7000757pfb.0;
        Sat, 08 Oct 2022 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4I7VQ2qzFTnaQe2ImZXDnGAkGARSRETXPdcvTfuia8=;
        b=M+KUsnbZfJKABTg1mXfD+fm5DPieUOtpokG/3KvxijKkDHZKpkP6uJPpoQwlOGWBPb
         75nKimDRonlvfKgVfap8TsoG7FMeAPPD/Z6d98cUKDgRIFSW9f6JlzKB+9juyHCGjGm+
         KJFAHE43CMzlsyjj3CkbhHK0azWL0afAax68Li4/w6N7jPoBSNC+seiMF8fNM7LWHIlW
         E3Pb1n8mvCH54wBoSccKwDmQ0DADRtMOnqgsBdZ2ExEqthh16QQ/y2NL0Jrpl4ksyjod
         r6UmmOpUFjYDLcsb0WrHTWzCR49iYuvA2byK+jxJwvYfpiAu5TBIpq5RS/tCIY0+0uvX
         p30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4I7VQ2qzFTnaQe2ImZXDnGAkGARSRETXPdcvTfuia8=;
        b=syM7TJJGZASpe4euEwnyjMQF2myYDdsZOREzcQQQ3QEjApIgSZLNTb2YxZ5G/NewqR
         8O+Oun08dzJJYPXsvjYYiTZazeKGGiQwVXfbxlpRQdj14fsVqdmBBYL3KOjvapQgznbS
         Tx/znBz1RaXBIqOBfogKscCtg14fPRh3sQ0NL8PmUU1Un0Y8ulV1IykDhCdAIED3aR+S
         g3vyt7ndIsE28wjerzHyIqmyzwsmC0FHyzbX85U18WflyZJVugkoKve0z0O/sGVfR4HP
         9IC572LybKMSpIs4aH9HvCvjca6DKffpnZ6xZ53oFb8Xzf+R2XcRX/M+zxEW0HmabjvQ
         nMZg==
X-Gm-Message-State: ACrzQf2W69u78pO+TSy53OhJgRRhOw06QJUPGJ51p8qXnhisxttSK7Ut
        OLNnuqz6fD1uYrkMpWMDVl8=
X-Google-Smtp-Source: AMsMyM60egt59KBnICKg3vHD9t3DBOeWSqDpsmU7bwk1uZGPTodGV5Q0GF1FHtw4tRrOfloKXjvkIw==
X-Received: by 2002:a62:b501:0:b0:557:d887:20ee with SMTP id y1-20020a62b501000000b00557d88720eemr9502990pfe.8.1665225506899;
        Sat, 08 Oct 2022 03:38:26 -0700 (PDT)
Received: from [192.168.0.141] (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79842000000b00561ac9b1376sm3135315pfq.133.2022.10.08.03.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 03:38:26 -0700 (PDT)
Message-ID: <e4438675-d7f6-02f1-79c0-aa9917db8997@gmail.com>
Date:   Sat, 8 Oct 2022 03:38:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/3] Input: Fix incorrectly halved touchpad range on ELAN
 v3 touchpads
Content-Language: en-US
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220929082119.22112-1-nyanpasu256@gmail.com>
 <20220929082119.22112-4-nyanpasu256@gmail.com>
 <87czb37mpb.fsf@mkorpershoek-xps-13-9370.home>
From:   Eirin Nya <nyanpasu256@gmail.com>
In-Reply-To: <87czb37mpb.fsf@mkorpershoek-xps-13-9370.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/22 6:35 AM, Mattijs Korpershoek wrote:
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> ps: please consider using the proper subject line for input subsystem if
> you need to send again.
> 
> It should be "Input: elantech - Remove redundant field elantech_data::width
On 10/7/22 7:06 AM, Mattijs Korpershoek wrote:
> This seems like a candidate patch for stable kernels as well.
> 
> Maybe consider adding the following in the commit message footer:
> Fixes: 28f49616113f ("Input: elantech - add v3 hardware support")
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Should I submit a v2 where I change the subject line for all commits
and add a Fixes: tag to patch 3/3 (or 0/3, not sure), but not change
the code? Sorry, I'm new to kernel development.
