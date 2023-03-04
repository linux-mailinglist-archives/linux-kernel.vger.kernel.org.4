Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FF86AAC26
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCDTm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCDTm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:42:26 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269CB126D8;
        Sat,  4 Mar 2023 11:42:25 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id by8so5710758ljb.7;
        Sat, 04 Mar 2023 11:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677958943;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1wFoY31xVN2Uq17yukxHtrVCwH9+JzibemythRvN60=;
        b=iTcYeWFsGYPh4z+bSwm44whM/Jd25gxYZrksk7LtJHnI6MAGX6A5Xi2QQCE4WOPcWu
         qFmK3jKuMVe/eNdhfx5c97ccYDI7/OSRTb5xnmKS4zQplfQrCn64fds+S1NR3817ihCE
         gXhSgUzF8Q8RqD09ddquPkObcDVAP4A7vde9XxLAkb8gUWG2oXjG7nDe8kgVMVuYVUTd
         doGIAciX9EwEzsqG3RWukTOsmEq6AFGKMlaEOpfR8Qhen6nnHh0XpRlpTApAXovNgC3k
         GBogqgWTue/5FB86hi5agxMf8hwn4uLkmw11R3BXrpctHfSb0PRsEWvU6a2g8+XtjDEG
         OXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677958943;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1wFoY31xVN2Uq17yukxHtrVCwH9+JzibemythRvN60=;
        b=649+9ybItGYhJGIpRm7XcOVibLUznuq5bhvRutwNJw8Wk8BRoioGcR4TH0OzxxeCCi
         v84xBqsHN/hWTJUd00UTV911tTXk/p7NXWFY9hY3/oN0uJE44czySvHOHDjRaqSy580Y
         94Vn9udhRTMZLakUPCJidv2xW70TrDtkERebfQ8SadaIyjzh8JbPqlErWMlfB+WPUCmt
         XLJ4gvJ3xTZOIqxYf+08PSVgK1wodcT+RukgKXfe51dO5ViRGi7ox5eziOvdTFExi0nb
         tu1TJLGfAlrHsHyzd9otoGDZeRrnXA5Qss77hrqgRP5AY020Fkg1zCkcxK2ykFIXceY1
         Bdgg==
X-Gm-Message-State: AO0yUKUyX2gGMhiQe2/8PNk7mX5x3AEPkfaqsXdxSs3czzcYRjcwYpl6
        PtpHcDqEBRbqhEgqZtExcAO1ma7jbSg=
X-Google-Smtp-Source: AK7set9fyhDnXPWBq5nkc+C72btrQWeP4L1de1iDbs65WUzGF5IQ3BajO67sH8sxxZlUmcrxVlrtNA==
X-Received: by 2002:a2e:83d6:0:b0:293:2ca4:bbcb with SMTP id s22-20020a2e83d6000000b002932ca4bbcbmr1645618ljh.50.1677958943170;
        Sat, 04 Mar 2023 11:42:23 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e910c000000b0029474e94ac6sm907481ljg.12.2023.03.04.11.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 11:42:22 -0800 (PST)
Message-ID: <081bc734-bfac-1eed-cc2a-c85cd2eac13e@gmail.com>
Date:   Sat, 4 Mar 2023 21:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <9895826669118a1aa1db3f85c2610fa759426c33.1677750859.git.mazziesaccount@gmail.com>
 <20230304183557.2ea54737@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/6] iio: light: Add gain-time-scale helpers
In-Reply-To: <20230304183557.2ea54737@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan, all

On 3/4/23 20:35, Jonathan Cameron wrote:
> On Thu, 2 Mar 2023 12:57:54 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Some light sensors can adjust both the HW-gain and integration time.
>> There are cases where adjusting the integration time has similar impact
>> to the scale of the reported values as gain setting has.
>>
>> IIO users do typically expect to handle scale by a single writable 'scale'
>> entry. Driver should then adjust the gain/time accordingly.
>>
>> It however is difficult for a driver to know whether it should change
>> gain or integration time to meet the requested scale. Usually it is
>> preferred to have longer integration time which usually improves
>> accuracy, but there may be use-cases where long measurement times can be
>> an issue. Thus it can be preferable to allow also changing the
>> integration time - but mitigate the scale impact by also changing the gain
>> underneath. Eg, if integration time change doubles the measured values,
>> the driver can reduce the HW-gain to half.
>>
>> The theory of the computations of gain-time-scale is simple. However,
>> some people (undersigned) got that implemented wrong for more than once.
>>
>> Add some gain-time-scale helpers in order to not dublicate errors in all
>> drivers needing these computations.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Probably makes sense to put the exports in their own namespace.

Andy asked for that as well. And, while I do not really see the 
usefulness of the namespaces when all symbols are properly prefixed (I 
only see added complexity there) - I agreed to use one.

> 
> I've been meaning to finish namespacing the rest of IIO but not
> gotten around to it yet.
> As this is a separate library probably makes sense to have a unique
> namespace for it that the users opt in on.
> Perhaps IIO_GTS makes sense?

Thanks. I think I'll use that. Although, as all of the symbols are 
prefixed with iio_gts - if I really saw a risk of symbol clash it would 
probably make more sense to use just about anything else ;) This because 
if someone else were prefixing symbols with iio_gts - he would likely be 
using the exactly same namespace.

> Otherwise, as Andy's done a detailed review of this version I'll let
> you update it for those comments and take another look at v3.

This suits me fine. I have v3 almost prepared - but I'll be very much 
away from the computer next week so it may be the v3 will not be out 
until later. It may be I won't continue work with this until about after 
a week.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

