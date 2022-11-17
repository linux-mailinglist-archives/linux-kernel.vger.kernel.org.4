Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F1662E7B7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbiKQWGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241207AbiKQWF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:05:56 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028471C40B;
        Thu, 17 Nov 2022 14:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8ZhcWlDmltUwtE56L7IJOVNcjiS8H2R20Q2ecjdjAR4=; b=iy70dn2qtlIcrwfa2yL8sKHJoK
        avVbMWlJvogZM3a2lmxrr0rSUDpzfMlJYX3kjp5yioqskPaB//cSq+Voo0srqXiCJ5EbWHVF5HZvm
        uvaCPKssSVVV771NggIS4QTfPfWkaI271Z5S1MR5YlqB2VOsno6Qc7Z6mXAxEcdpWVLwUu0Zu2czT
        CekscdOn0gAZTvCaPEoQxmWZV/VtEHh84D0uuacFlUEmCG8SWFt0qN34k2khGxHc7Ev2OiWaKW4bX
        +9/e/ZG1aCvF7Gs3mIt8/5wCDLbjkoXN0uDukLLszrfn/10zy1RiP99+bL55pDeATzVdI03UYIZG5
        heLlAMDw==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ovn0S-002sqU-AP; Thu, 17 Nov 2022 23:05:12 +0100
Message-ID: <34c3a141-ca0a-d4db-15de-399f4948518d@igalia.com>
Date:   Thu, 17 Nov 2022 19:05:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 5/5] MAINTAINERS: Update pstore maintainers
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-6-keescook@chromium.org>
 <542aa83d-6227-ea7d-2150-a74293cbf59a@igalia.com>
 <202211171359.232C769E3A@keescook>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202211171359.232C769E3A@keescook>
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

On 17/11/2022 19:01, Kees Cook wrote:
> [...]
>> PSTORE FILESYSTEM
>> M:      Kees Cook <keescook@chromium.org>
>> [...]
>> F:      include/linux/pstore*
>> K:      \b(pstore|ramoops) <------
>>
>> Should this be kept? Maybe only the ramoops entry could be removed?
> 
> I would like to keep it -- if something mentions pstore and ramoops, I'd
> like to see it. I can't review all of it, but I'd like it to at least
> show up in my inbox. :)
> 

Totally fine by me, was curious and now I understand this is not legacy,
but something of your interest indeed.
Thanks for the prompt response!

Cheers,


Guilherme
