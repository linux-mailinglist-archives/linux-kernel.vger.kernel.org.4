Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0895B698D55
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBPGpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPGpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:45:41 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5131AB;
        Wed, 15 Feb 2023 22:45:40 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id g6-20020a05600c310600b003e1f6dff952so3389009wmo.1;
        Wed, 15 Feb 2023 22:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1erk48KVVeI/+eFAGnZc8sEEqbTN/WLvkPC+ieubqRc=;
        b=7hE83IkNSTZKyYebGMZ5YO2tZXg6mecJuQqieUWlIP+eJR5fv4AMLdlcZJ8/SFUurn
         a8BqqRn+WJwI9jGgP0iGLv90QRn+tGrjDp05BKNqfPJDJUAawWFIE/d98+RrA9+Ixc0u
         FjbmSCI6nOPENXHxTFJRSQMy7nxSNxb7DFg43hg5hrbmVqAn1nyBfPhplTggYRF7teeK
         LrclCfWOvETIMSYJ5lpZW7cM0ZsnovtFivOWfcsZktqfSIxRk+gjJGSH/cw7fjS1dT6i
         kPm6psZ5Mc7WeWQuhQ5ij9+0NXK1NPXlDUQJeEEF1kCjUIbg9fAZUxQ/QQNElZ10MIKZ
         Bx8Q==
X-Gm-Message-State: AO0yUKWe+Msl+Fhc+5iq8XtwhBf64ykSP4ycq2uQNuKAvo/40VjsgC0h
        n6s3aHJZusiixQfuzVQQFzo=
X-Google-Smtp-Source: AK7set+N4NsjMOEpcpJ23+61k/88zxYcHZXcULDwl4iDfQBjhHjL6CXkfGP67EpOPs7GO81bqSx+4w==
X-Received: by 2002:a05:600c:708:b0:3dc:1687:9ba2 with SMTP id i8-20020a05600c070800b003dc16879ba2mr4042689wmn.35.1676529938838;
        Wed, 15 Feb 2023 22:45:38 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id hn30-20020a05600ca39e00b003db03725e86sm685919wmb.8.2023.02.15.22.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 22:45:37 -0800 (PST)
Message-ID: <5ece1fc9-f2e7-3567-9a16-3f950ee65709@kernel.org>
Date:   Thu, 16 Feb 2023 07:45:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] leds: trigger: ledtrig-tty: add additional modes
Content-Language: en-US
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
References: <20230213140638.620206-1-fe@dev.tdt.de>
 <20230213140638.620206-3-fe@dev.tdt.de>
 <b5dd2505-b087-b521-739b-ad4e97f3cbc5@kernel.org>
 <f4f9b09939819709822cea2b328422b8@dev.tdt.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <f4f9b09939819709822cea2b328422b8@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14. 02. 23, 12:13, Florian Eckert wrote:
>>> +static const char * const mode[] = {
>>
> 
>> This is not a wise name.
> 
> What do you suggest? For me, the 'mode' here was the most accurate.
> It describes how the trigger should behave.

mode is fine but with a context. Like tty_led_mode.

thanks,
-- 
js

