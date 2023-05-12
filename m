Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8892700361
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbjELJHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbjELJHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:07:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B75B100DD;
        Fri, 12 May 2023 02:07:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24e2b2a27ebso9068043a91.3;
        Fri, 12 May 2023 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683882466; x=1686474466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oseHv6VTSzckslEr5MWLMD1wKR85pm76Ym5jt2vFoxI=;
        b=XjEIPEkNIvghUZ4sYuX1fCWrgg44BfoxhHVaks66vlF5xl5VUv4r3isABKr/LsYPYw
         Tly6RKPK9BcyMqYvoSOgRdb9WA1254+yurUnYVBO0DpOoyToddB4r3IDlbeJVvJS+aIS
         cIU73rW7ZyB8UfQOdcYe9RWtl8aAXPzz839ZP++4bXfB0lpVKXJehz/EqhRzVPYRv+B7
         z7mpm7xHQaI6a3VIN/7jkY+uvr6L4PuFjgQ3/VPChSlkqopIjEq5foFvjsooPNWZXn2w
         NREm8Inimbied+1qeFmwZQ/2mm1A2tVHyBhiD6Ze7c52BViC2yJfu7/XZ2TmVWhspGu9
         +Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683882466; x=1686474466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oseHv6VTSzckslEr5MWLMD1wKR85pm76Ym5jt2vFoxI=;
        b=Iv003L73fO7XWNhtFJguMYrn/IblOm2DhyhXyKzzMNE95c2B8wPX80UK5BTu0Buqbg
         9ncCpMA7G97Zly2ekYbMXeavMY2tYby5iS1pXKrd92hcZLsI772ZZE+Xcz0TGSFhTRkR
         0Q5xB+I+mVdvknj0rIBaJguvcK4lQMUtDKxIeCgg/Pr4sgLDMFrxXoMHl/MekFZHZdZU
         wKlFeeTaF7geLsX2iTTlMTprs/yDsqMAYRQsncT1LIH1syn1keHLxG2z1z6P7fGdzXC3
         y3FAY1A9nit3X53hQlO9Uz1f6dAJL7WuxOiKvtMZbUlY1wpm02yShuGvZG7bFpBrdgjJ
         xKow==
X-Gm-Message-State: AC+VfDz8J9n/WsdDoT7a2w0jIjYxz1vzRjc2YT7T5qNFLA3o79hmOzl1
        s/kux0CGZNx5vaFJ+9uzviA=
X-Google-Smtp-Source: ACHHUZ7+b/oOCYYoASqforqMy2MxURpPVBmI0FXSJlR2iCNI8DK+oJQKKZTGyZQoOcDqitWf1y1ZzA==
X-Received: by 2002:a17:90a:b317:b0:250:78d0:f797 with SMTP id d23-20020a17090ab31700b0025078d0f797mr18003584pjr.41.1683882466461;
        Fri, 12 May 2023 02:07:46 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-8.three.co.id. [116.206.28.8])
        by smtp.gmail.com with ESMTPSA id cq2-20020a17090af98200b002508f0ac3edsm8373161pjb.53.2023.05.12.02.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 02:07:46 -0700 (PDT)
Message-ID: <51c2577a-b9d9-4f6e-e79b-c2c324b72347@gmail.com>
Date:   Fri, 12 May 2023 16:07:33 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/10] Treewide GPL SPDX conversion (love letter to Didi)
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Watchdog Devices <linux-watchdog@vger.kernel.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        David Airlie <airlied@redhat.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Sam Creasey <sammy@sammy.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Jan Kara <jack@suse.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Pavel Machek <pavel@ucw.cz>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Deepak R Varma <drv@mailo.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Dan Carpenter <error27@gmail.com>, Archana <craechal@gmail.com>
References: <20230511133406.78155-1-bagasdotme@gmail.com>
 <20230511174105.63b7a6ae@kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230511174105.63b7a6ae@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 07:41, Jakub Kicinski wrote:
> On Thu, 11 May 2023 20:33:56 +0700 Bagas Sanjaya wrote:
>> I trigger this patch series because of Didi's GPL full name fixes
>> attempt [1], for which all of them had been NAKed. In many cases, the
>> appropriate correction is to use SPDX license identifier instead.
>>
>> Often, when replacing license notice boilerplates with their equivalent
>> SPDX identifier, the notice doesn't mention explicit GPL version. Greg
>> [2] replied this question by falling back to GPL 1.0 (more precisely
>> GPL 1.0+ in order to be compatible with GPL 2.0 used by Linux kernel),
>> although there are exceptions (mostly resolved by inferring from
>> older patches covering similar situation).
> 
> Should you be CCing linux-spdx@ on this?

Oops, I forgot to Cc that list. Will do in v2.

-- 
An old man doll... just what I always wanted! - Clara

