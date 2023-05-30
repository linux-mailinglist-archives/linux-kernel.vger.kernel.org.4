Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D7E715426
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 05:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjE3DJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 23:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjE3DJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 23:09:40 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732C5E0;
        Mon, 29 May 2023 20:09:35 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53f9a376f3eso947648a12.0;
        Mon, 29 May 2023 20:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685416174; x=1688008174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHha7skYKya3YZ9Yq4CvIc6dsTZef5S5YbQ/NaBv3TA=;
        b=nqNy+aH6lnZgEWufNk5dgaIMiij6+g5EOXT8T7A+Lt99aQ9mRjK5bLpKqBYYc0yzdH
         0+d4uvwP6kyZRim96acurrJstqriWKplKYPIayRNwbYPFEZROEj7tl3lJIE/JUfesd5+
         UHfgjDrNLY9kEAWatkc2hDztMoRi4qolizUwSjXzOHj6sSQD44Jn5YkVv9UslS/9FcUa
         fudS6BGNkCa/PndUmGasdObstYrgFzDWj0Wsn1NbDL51vo0QYemI5b/7w2b40H8Z/aL6
         y7vrIXLKy3Urk25tqrFGU9aKfVN6x8tkKWkd09wENjtDzNrTsn1c3XsEZhKcMpmVKdyn
         ob4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685416174; x=1688008174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHha7skYKya3YZ9Yq4CvIc6dsTZef5S5YbQ/NaBv3TA=;
        b=QbBLxW6uAgtkPWZ3fui8v9OfgqG5M4jzXDMDG1andzI7+PbLXZe6FFJ+ye8d8lHAJz
         DN4niTu/a4pIuFbK1xItG2a5xWO274Smz9qJQ9yKeSc6uePwjg2Oe35K5aNq/8aYC9/6
         MKg+ZSx5L7uiYoZLNioozi4pEwUd7m+3vf9AHaCOkUBEMLR5dYr5ecNS/yJDtYKi5S4v
         4r/UJTS1KfStTEMwEaCHKjRLsNRHkJLQqxfujiLm13olGHXMur66FgViXgcPh1dqptbz
         FWc1EVmaqvXHc+3Wnx48e7tzVAGjmC0+06RA1Wmh593OiCriGF1tF3iUcti/AmAqGB5r
         0nFg==
X-Gm-Message-State: AC+VfDzggNTJo6RptsqgeKZ+N3lLrJrMVueZpRO46k8FJxR+2/D0bSot
        39ElaqzJl/aeDT95NnTyZx0=
X-Google-Smtp-Source: ACHHUZ5pMXMQ/CqUWNS0MCIllEY4M9NsQixB8jkD8YOEy/fqDSIycPN4xCg0g4GnwTDQnZmG5hg9Wg==
X-Received: by 2002:a17:903:278c:b0:1ac:b449:352d with SMTP id jw12-20020a170903278c00b001acb449352dmr805807plb.61.1685416174083;
        Mon, 29 May 2023 20:09:34 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-15.three.co.id. [180.214.232.15])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b001a95c7742bbsm8972584plf.9.2023.05.29.20.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 20:09:33 -0700 (PDT)
Message-ID: <2b8dbe95-c7e9-5158-93f6-865306a661b0@gmail.com>
Date:   Tue, 30 May 2023 10:09:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [net-next PATCH v3 03/13] Documentation: leds: leds-class:
 Document new Hardware driven LEDs APIs
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-leds@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20230527112854.2366-1-ansuelsmth@gmail.com>
 <20230527112854.2366-4-ansuelsmth@gmail.com> <ZHRd5wDnMrWZlwrd@debian.me>
 <871qiz5iqt.fsf@meer.lwn.net> <6474b526.050a0220.baa3e.31c1@mx.google.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <6474b526.050a0220.baa3e.31c1@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 21:09, Christian Marangi wrote:
> Just to clarify, a device name can't be returned. Not every device have
> a name and such name can be changed. An example is network device where
> you can change the name of the interface.
> 
> Using the device prevents all of this problem. 
> 

Oh, I guess it was /dev/something.

-- 
An old man doll... just what I always wanted! - Clara

