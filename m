Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC97612C5C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJ3S4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJ3S4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:56:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B138BB49A;
        Sun, 30 Oct 2022 11:56:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p16so482514wmc.3;
        Sun, 30 Oct 2022 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sRlmF28UGiI8Vzg4eKX2nV3QMVLZdp3/jEuCPwwG//I=;
        b=hfQYbmL/1J1/3WlQjBKvxIbtKkOxi4IwOypHtL1LVwRedQgc1g1HMXMWFD6ymW6Y73
         gbbh/OsDvKq4Tvok4gcwfIeLaSsaeHPxB+6sCqCYhFAo2H3fANP4rBzkLgAAE4qm7g65
         82O4IrY+hCpfXkD7jA0CqlOkW+Nq4WTdE3QpFwookArFOgc1sSFC7eKK45ppcVSyeha6
         2OXTzz0DaIbKaFxm3XE1L2NzRqdURaBeOAXjLMOxjghW4qwJcZMVw8lF3RSotc0MQBpg
         bmGmX3i7sn3/jq9+S4Q0ahSmLUGXqwuTaCyGPSgrVimmaKcSr0JGooUycOxQAca8AiNg
         vw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRlmF28UGiI8Vzg4eKX2nV3QMVLZdp3/jEuCPwwG//I=;
        b=iN+X3g+7B1Jc1DsjKQ8f2Gh5VTKPUrTcBYssRcWALJtj+LYN197yaAxyRPp5zzbuyo
         L3n8KWeMWkmzDZsMEjbGl9aM2TyRjFHi4/85M7XDCecWpM+117MK0R8AVPcWn/xfjUzg
         C6FGPQjgg4eJ3UQy+d5Rv+N6FQ7/1Mzq+7bmlATPHvm8hu0phhBh+IeEBI1rXyyqiom5
         YuJcKWWS/7PpwE2AyEEUFiBZDRSM09Vp4Idp3qSzBnQcfSRhietKbdM5Yhse4+2YM6LQ
         /pjm/NZaJjtJWWU8+I/Y0vjQkYJlsj8eRygcelhdVyIkSiz0vAaoQwwSa5euCiPFN3fB
         9OGA==
X-Gm-Message-State: ACrzQf2D7WH6yT7tfm4Ng6EtHYUGTTeAb2EhMx5nUhzsc/DYs8zbanY9
        aA+FG1hN0F3QYQZrXvnJiEQ=
X-Google-Smtp-Source: AMsMyM5TupdZxZQUyg5jxGqOkZ1HikEgb3sgMchC2YJC40hWyOXSRV82cFTpUlJq9ZOPi4VPiWPb3Q==
X-Received: by 2002:a05:600c:3849:b0:3cf:4d99:fd1f with SMTP id s9-20020a05600c384900b003cf4d99fd1fmr14847358wmr.128.1667156193119;
        Sun, 30 Oct 2022 11:56:33 -0700 (PDT)
Received: from [109.186.183.118] (109-186-183-118.bb.netvision.net.il. [109.186.183.118])
        by smtp.gmail.com with ESMTPSA id bx7-20020a5d5b07000000b00228cbac7a25sm4896685wrb.64.2022.10.30.11.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 11:56:32 -0700 (PDT)
Message-ID: <fc22e139-4eb1-45e0-5314-38f74ce4a643@gmail.com>
Date:   Sun, 30 Oct 2022 20:55:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH v2] char: xillybus: Prevent use-after-free due to race
 condition
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        imv4bel@gmail.com
References: <20221030094209.65916-1-eli.billauer@gmail.com>
 <Y16k90Lk2fehKqRC@rowland.harvard.edu>
Content-Language: en-US
In-Reply-To: <Y16k90Lk2fehKqRC@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2022 18:23, Alan Stern wrote:
> It looks like the xillybus driver already has a private mutex that would
> have been very well suited for this task: unit_mutex defined in
> xillybus_class.c.

Indeed so. The problem is that unit_mutex is global to xillybus_class.c, 
and I need the mutex to be released in xillyusb.c: The kref counter, 
which needs to be incremented with a mutex held, is inside a structure 
that only the XillyUSB driver knows about, so xillybus_class can't do 
that. Which is why xillybus_find_inode() passed a pointer to unit_mutex 
  to its caller in the v1 version of this patch. But that turned out to 
be too odd.

> Of course, there's nothing wrong with using a new
> mutex instead -- just make sure there aren't any ABBA locking order
> problems.

The kref_mutex is always taken with no other (Xillybus-related) mutex 
taken. So the locking order is assured.

But thanks for the reminder. Never hurts checking again.

Regards,
    Eli
