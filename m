Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE65659686
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiL3JGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3JGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:06:18 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5927D28D;
        Fri, 30 Dec 2022 01:06:17 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id k19so6418333pfg.11;
        Fri, 30 Dec 2022 01:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bP+IUq0326ZlmpZ81mrcAidOpaHmKMzVCI4CLiGRKhQ=;
        b=oiHDncSnmHC8UvxbCTR7OiQZIy38GxkCdI4YTsizlLlgro4VM6eLUdipCJzD7uxI1f
         p9yER92AZ4L60T7KvnybTK7U61fBd+K/YF4pknZjZ5KSz0/uXIQ2D3ZN0YhQPTChF/vr
         1poYE5QK27yDdWmkxUzOGSHkIjcPv6PExtC/Pg4sqQGfStGQs42hkgzm9jA4hxqPkm6n
         B1qZe0qwUEcViTTFqOt5VzgURggQNhMYnKLqebsMmX3jnKTVDlCHGBEARQ6lZz/uDzcQ
         KUmmWkyfVKoSRIxHleBwpSG9JmX7Yhjyr7l/0sCEsMAEnL7X80CE5oe+Ysa4IwawPapJ
         M7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bP+IUq0326ZlmpZ81mrcAidOpaHmKMzVCI4CLiGRKhQ=;
        b=TDwmLTWZEZSvyUz2En7OJ0R8rksHTL0CfI0Kf7ASeYJBdet/nLXL1BBqYzroFI6zTh
         T1yzbEj+qtsftWsJY6UHQmeZ03xJj8Qv5n4tiqZBtxr6n2NIcZe8Y0bM6km4WMGnb3mz
         VIqMhyXyPtygfFHFJBRF3PjA62HPvGyJftXJUka6cdBm4jmhbQA+lek/4WCFp3S/excu
         abmyKsZA0pQ7Dr6wsJHInotSKy/vS/XKQLq2uP2nWzZYOa8Z4cR9Forrgh2YesLQVVln
         gEG5Zk9TRVWPa4rTZy5Tn0KAMdjra6hR1wcsN/809CS3q3SRwC8yIFRSPzag36Skuz0p
         3NjA==
X-Gm-Message-State: AFqh2kqyUCi3uKoxZgLp3YOsY8R9DQDhoD7ZRw/5tkqvj4rSmKp0OHL+
        Owc7ZZbEkey4xJgZiTE+l9U=
X-Google-Smtp-Source: AMrXdXspCnTe70fh8Lq/lLsOywuqsOA9QI5jVwM/C/3SpZJRFb3L6/s1+BY0PFBtBKT92J3E0URH8w==
X-Received: by 2002:a05:6a00:1f0d:b0:56c:3696:ad68 with SMTP id be13-20020a056a001f0d00b0056c3696ad68mr31487128pfb.8.1672391176849;
        Fri, 30 Dec 2022 01:06:16 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-69.three.co.id. [180.214.232.69])
        by smtp.gmail.com with ESMTPSA id n7-20020a622707000000b00580c0219f16sm8616883pfn.169.2022.12.30.01.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 01:06:16 -0800 (PST)
Message-ID: <69095f6d-2f1d-07ab-26ac-5f35ea80a58a@gmail.com>
Date:   Fri, 30 Dec 2022 16:06:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [V2] media: jpeg: Fix multi-hw judgement
To:     =?UTF-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?UTF-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        =?UTF-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?WGlhIEppYW5nICjmsZ/pnJ4p?= <Xia.Jiang@mediatek.com>
References: <20221216035247.18816-1-irui.wang@mediatek.com>
 <Y6w2wG2MlIiHlkr/@debian.me>
 <0846a7d726135d28f1da2a94eaa4c978754f9d2f.camel@mediatek.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <0846a7d726135d28f1da2a94eaa4c978754f9d2f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/22 15:19, Kyrie Wu (吴晗) wrote:
> On Wed, 2022-12-28 at 19:29 +0700, Bagas Sanjaya wrote:
>> On Fri, Dec 16, 2022 at 11:52:47AM +0800, Irui Wang wrote:
>> > From: kyrie wu <kyrie.wu@mediatek.com>
>> > 
>> > some chips have multi-hw, but others have only one,
>> > modify the condition of multi-hw judgement
>> 
>> nit: s/judgement/conditional block/ ...
>> 
>> > -if (list_empty(&pdev->dev.devres_head)) {
>> > +if (!jpeg->variant->hw_arch) {
>> 
>> ... like here (if block).
>> 
>> Thanks.
> 
> Hi Bagas,
> 
> I can't get your suggestion exactly.
> Do you mean to change if (...) as follows:
> if (jpeg->variant->hw_arch)

No, not what I mean. I pointed you at the correct terminology
with your code as example.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

