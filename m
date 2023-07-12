Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E796750937
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjGLNHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjGLNHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:07:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E7F12F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:07:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3142a9ffa89so7806090f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689167268; x=1691759268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lk0KxbPL7g9PHdbTrRV8GwvZTLdNn5RyLE237XDBwng=;
        b=Pl3dPP9WaagaZa5NZVF07AyuGVkuebSNjvMI/IJzHvl1F1sPHVcp/7u/J80rHfduqf
         UO5wNcVh1Wz2IdYKjZS/uJQwfzdzb97YnykXQEWEEGrVDdK67csEpl9l2inwECsJ1Q8m
         VJqq6NDxmvU5r2ivTTuMRKX6IzfYXVtB/UOLxTM9G4kiuOZg1DZbwSIcc8wGe2yvxi9C
         OtVeqs38kzjyf5rKg1E8KSwGCODuLs7PZLBFui7IOAk8mcdKvqdKw4fRGRE43L6L3sQw
         Wrl7k9WvADMh6sVGcJYBwDD9V8+0nERpFVyG45qBAIIPlXOuG468dazCuwDDEDKlMVrM
         gr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689167268; x=1691759268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lk0KxbPL7g9PHdbTrRV8GwvZTLdNn5RyLE237XDBwng=;
        b=ElGAI3r33fxd1la4v1CEYJgrn/Y9IVyH0w91xgB0s+Ncq+I7bxI0YAkVxxaoYyu14q
         bbimsosP4PlTVMAD295yr0bnMwV8JLx8kRwyKB7KAh+12Uf378OPkchOgnnhDFx2pdip
         mv8GMdOZs1E8Hh48SOBMORrey8b3ixDywVrbtBnEXwQtccUecrUyF8hc+MZkxKis8s2m
         nCr63oO2kyA4D5y6OyqAJ2yIttl+mHrnyE77XSRYFw5tHSCF5P659qAsVozMFYgqKsB7
         pDZ71yFItSh6qfEUDXkKwG3/gEVCA1rNI7epsRaHWtVxnbzHwzMW/g1WDGvjruU/j5RF
         fKPQ==
X-Gm-Message-State: ABy/qLZ+KXYoslZ4jVCvADzcxQ/SvMj7Cf4Q1bGBY3zKNAwZyRnRpq4y
        sdJF/rGQGRdHGfsMZpBwHvXgpA==
X-Google-Smtp-Source: APBJJlHfRnv7y9rZI3NMWpRgDW07OG6yBWWWNoyjxIJUDcLnaIvBEGr8R4hrrI4kOutThs0bqhTanA==
X-Received: by 2002:a5d:45cc:0:b0:314:3358:d57f with SMTP id b12-20020a5d45cc000000b003143358d57fmr18305861wrs.56.1689167267884;
        Wed, 12 Jul 2023 06:07:47 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id x6-20020a5d6506000000b003143b14848dsm5050267wru.102.2023.07.12.06.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 06:07:47 -0700 (PDT)
Message-ID: <aa92a6da-b406-59c3-8d2e-084bee6ba778@baylibre.com>
Date:   Wed, 12 Jul 2023 15:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/4] drm/mediatek: Add casting before assign
Content-Language: en-US
To:     =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?UTF-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?UTF-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20230621102247.10116-1-jason-jh.lin@mediatek.com>
 <20230621102247.10116-4-jason-jh.lin@mediatek.com>
 <797c0144-4072-8728-304e-e64213185687@baylibre.com>
 <4d7f86a662429256e5a0a5a52b9e8c375b22c382.camel@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <4d7f86a662429256e5a0a5a52b9e8c375b22c382.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/06/2023 10:02, Jason-JH Lin (林睿祥) wrote:
>> drm_plane_state *new_state,
>> >   dma_addr_t addr;
>> >   dma_addr_t hdr_addr = 0;
>> >   unsigned int hdr_pitch = 0;
>> > +int offset;
>> 
>> I agree with Angelo, please set offset as unsigned.
>> 
> I think offset should be unsigned, but since src.x1 and src.y1 are
> 'int'. That means 'unsigned int' offset will be very big when src.x1 or
> src.y1 is negative.
> So I just use 'int' for offset here.

Ok

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
