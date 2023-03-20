Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92676C0E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCTKKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCTKKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:10:37 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3227AB1;
        Mon, 20 Mar 2023 03:10:33 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id t14so11473543ljd.5;
        Mon, 20 Mar 2023 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679307032;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ROGny04CILeyCPZ4vkWe21NJxi6A4EiVeLCtFyNlFs=;
        b=ZR/0YZ46z2R1px//N0p0Im+diR1oI2cClyXVOcochUiM28WB8AS+2KbuoIuF+y2w2S
         SGp3e4N/2V/31/W1P50/3k0BC39KHANQCUpz1USm3bFshWR5pXt9NXXO3Yp5W8IHH0no
         4SDSiTdBo6lgcBUM1Jpm7j8p/hvMt24KAADG17vwxvPiIBIOC0Ukw3/BKWPOVI/jqX8S
         xFijGUWy1xQu0pdt+ZJT1f3OVeUXoM4YcfmUXqDKY6Rwp5XMngmCmuPb9KEQaEvDwGtR
         Y77LAdLVSwhv1LD+KnIzGE1VqKuErkQyRl5PMAJd9E92k+90oeHinlMJHlZD6qOcoIMk
         IPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679307032;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ROGny04CILeyCPZ4vkWe21NJxi6A4EiVeLCtFyNlFs=;
        b=OJD18c8tZNTa22v3vdyA7PAL+ucyYYroOOQ0utneNe+XSH50vIbjMG42D4r8j5+6wf
         hH57gahcHvJMxyfsc8h7tmr2X5JJ7/rUIE2Ofqf0/9aCpR1+ZLh45iq7QRe5ig9G1QiI
         6AR1GqdfymIfBUeQxbid/BmdEUNp+085vU4W4N4+R9wSuegRewH+wo15rP4wMiRaOOcD
         o77gCD62p6f4QqJQc9VvPsxjxiS2DG1+0G+PXm5T03/fUbvD99r5YOy1GiaojFZbWbou
         FEcNEQ7vEYWY3fIJSHvhpB83NmtiKIiCHje+kbtCutvI6ptX2zfUYmGGP9CtsTKDe5VH
         F4KQ==
X-Gm-Message-State: AO0yUKUKElTbZhwMOC/z/h+RwvhYdKeR59YVxOoBW6rxEusuU6Zb/8DZ
        51EVzLhK+ShOIO9bZkogdKA=
X-Google-Smtp-Source: AK7set8BlupRJrQbxc3VqBd1QIZwBQ2zzvWSnLrmb+RqyM2N/9W7Y/lQ3XFjGIiv9rqyjE24i67KWA==
X-Received: by 2002:a2e:9990:0:b0:29b:6521:887f with SMTP id w16-20020a2e9990000000b0029b6521887fmr2287242lji.51.1679307031576;
        Mon, 20 Mar 2023 03:10:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id h23-20020a2e3a17000000b00295a9be8764sm1673368lja.117.2023.03.20.03.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:10:31 -0700 (PDT)
Message-ID: <98ff1aa3-2c7f-0503-4e72-32a711638153@gmail.com>
Date:   Mon, 20 Mar 2023 12:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Zhigang Shi <Zhigang.Shi@liteon.com>,
        Maxime Ripard <mripard@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Emma Anholt <emma@anholt.net>,
        Liam Beguin <liambeguin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <cover.1679062529.git.mazziesaccount@gmail.com>
 <20230319165744.10e49cc0@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 0/8] Support ROHM BU27034 ALS sensor
In-Reply-To: <20230319165744.10e49cc0@jic23-huawei>
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

On 3/19/23 18:57, Jonathan Cameron wrote:
> On Fri, 17 Mar 2023 16:40:16 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Support ROHM BU27034 ALS sensor
> 
> Hi Matti,
> 
> For ease of when this is ready to apply, better to just keep
> key mailing lists and individuals cc'd on all patches.

Right. Sorry about this. I kind of rushed the sending at last friday - 
which resulted bunch of errors in the process. I forgot to do the 
spell-check, missed a header and messed the recipients... I should 
really learn to not try meeting artificial deadlines like friday EOB. 
There is Saturday and Sunday - and even if I spent weekend off the 
computer there will likely be the next Monday. (and if there is not, 
then I should probably not care about sending the patches).

> Mind you cc list is random enough I'm guessing it wasn't
> deliberate (like the maintainers patch 8 only went to lkml
> where no one will notice it)

I am using a script which generates the recipients "per patch" using the 
get_maintaner.pl underneath because in many cases certain people are 
only interested in seeing a subset of a series. This avoids polluting 
inboxes when sending large series. For v2 and v3 I did manually add the 
relevant lists / recipients to MAINTAINERS patches which only pick-up 
the LKML list.

> I can scrape these all of lore, but it's a step that not
> all reviewers are going to bother with.

I appreciate the extra mile you're ready to go here as well :) However, 
you should not need to do that. This whole series should've been CC'd to 
you and the iio-list. Sorry again.


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

