Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F3E6DF7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjDLNsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjDLNsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:48:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A6A10CA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:48:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso11287154wmr.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681307319; x=1683899319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb6P2byqyLNvxYx5mpnu/HADSn0CeAL5J6+dhakFGrg=;
        b=X5GLXeJDIHOwYV33b0gurB0ztbWSgIyEeiSSG0/C6Vpi4vK1fhMxGZNWKHD8UQZzjk
         RuUJfvCOgJehPIKFMlGxnNZAvJI9GIH8z0noUWQLiVAewf3Ov7fFOfl/1Ho2YD7CuH1v
         Mm0T1u3w2UKESMcBO8HOKdgRlp73K2s5Zp4rc3jAxXmWyikjLX9YlrbmWLIfo2SaHcy0
         uSFCHjhPiRlfecUqaDRr/qTj86ljC3cS5s8uM7A+xA/Kda0UKaKzVyd95X5aCn4lmbSq
         7H3VZFmtr/dj0eo6tq9m9Gn+I5n2PI7CSAnwklU5ceCFwMDUpTortZkODsAaWO8gUi/E
         eEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307319; x=1683899319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb6P2byqyLNvxYx5mpnu/HADSn0CeAL5J6+dhakFGrg=;
        b=O8HIwS7MtUXixW1imXODwr3ZPsUM95vpeJOLFqNEC4rpdAjHWwoRmncB77+pyaIkgO
         2LDk6twJ8vXfZIS0i5fmmnsBrbUSNAE6UmavOEwW+iI86PbSpwAWpSrrXNJpT+ToNv0N
         yjyPYFYhVWUqdmNdAfP3BuBBLJ/bqukn4jzgbU0jfegMO+VRKfCAUscpyyGZb1uJiTpC
         Vt0amrMEUatDgVca2pNwigWn8CS0U52zrpla2tIxicwos2P5gQPGxYOd9cvPxx4O5jsI
         gi81l/TFMNU3X3CbNhNnqlIYrcJOrL8wvDRJ8fM2hRwXiQCAxIbQMCy1l962Anug/AZt
         lK3w==
X-Gm-Message-State: AAQBX9fAXIfRns2MSM7AIp+igzFjuk4fh6NVESOwceXjT4KswaIvf13A
        pqwYktXjHarxTGhB4QyHZN3UCw==
X-Google-Smtp-Source: AKy350Z/ROia9nB7VNPQp9VQ8QMdkRRPlJGnrcpi8r3HW5TGeAv0xb6C9Cd+EosDMxX9OgVXXjaA1w==
X-Received: by 2002:a05:600c:230c:b0:3ea:f73e:9d8a with SMTP id 12-20020a05600c230c00b003eaf73e9d8amr12320568wmo.30.1681307318747;
        Wed, 12 Apr 2023 06:48:38 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c4f9400b003ed51cdb94csm2535939wmq.26.2023.04.12.06.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 06:48:38 -0700 (PDT)
Message-ID: <3dab974e-4244-feda-4b85-d48a18013219@baylibre.com>
Date:   Wed, 12 Apr 2023 15:48:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next 1/3] drm/mediatek: Use
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, airlied@gmail.com
Cc:     daniel@ffwll.ch, matthias.bgg@gmail.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230412064635.41315-1-yang.lee@linux.alibaba.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230412064635.41315-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 08:46, Yang Li wrote:
> Remove variable 'res' and convert platform_get_resource(),
> devm_ioremap_resource() to a single call to
> devm_platform_ioremap_resource(), as this is exactly what this function
> does.
> 
> Signed-off-by: Yang Li<yang.lee@linux.alibaba.com>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

