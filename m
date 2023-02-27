Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75046A3D59
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjB0Ig1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjB0Ifj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:35:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F2D2115;
        Mon, 27 Feb 2023 00:31:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id eg37so22186229edb.12;
        Mon, 27 Feb 2023 00:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=07+qdTDQ6UBJE1ppAUMQ9P0jdgbB7pl5uWXEfVl4Vtk=;
        b=PdYt7oEElXres1wTHUrJs0HhWeO98wzJ9CWly9kW6imArKG1ucr7eFri/kFG0u4D9o
         IOEmZAILEx7y5UXi+4dV9d36NyK0hmfAtH5LZhWJEnUJPrbgA5BPF1GAQ9i8iFF/1GFo
         TA/NMigaHCDOW8vMg0LR7S83IMB/n/doN0RAUObgRDzfnhylR4g/qegxJssiugwDSYds
         wYGZtNX/EP4Iy9khTpNJ/A4P4HhpP+Ux+tGRZ9uZ9r7lVkyVk1duONUvdVxS3wzduJT0
         nXlgAujayHG4snkp58oz7nYqWav/KaVM7JHVi9L0v1eACwLXy1IUP/NGz8SVllyN5J4G
         5pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07+qdTDQ6UBJE1ppAUMQ9P0jdgbB7pl5uWXEfVl4Vtk=;
        b=A+jYxD9i0FY/jnLolUUmiSSjnjtqYFhHKjYkX2Yy+1HuXjJ7gy1GDZj2hTm4UOM2gI
         WobPPQ4eiTdXodGH8TvHBX+i0DclNb1oGtEhR4EasO8YseQ0EighGCuxGD/6VeJ39SZR
         kpu925FCtGTvtI/RdlBqGUnxeIxj7ivg9zKwJDsqcMana+HHnGR+7keHNDt94PUo7dCB
         873uADwNG735GIfp7rifS6jMTmczvTW+gF1XPJNsXGRxKQwlsTs8lFf8p8jmtK2f4sZ6
         EC52U5y4QYaH3gD4jg9eFmZD69qKiAuubkNLA/6hAfc4oNZ5ERbmR8jL2G2IG+CVEJCo
         uvfQ==
X-Gm-Message-State: AO0yUKXgZVWGTDnM8AssOobH4f6eH6pgp4iQi9j66L2c7JZNSDohd0we
        IYTZ3tsQIK87IuD0pNr94G12Pyi2pXU=
X-Google-Smtp-Source: AK7set9HQ4ELfhFlAbdj5+Og+m9HexOksW8t+xT3bndkDTCmcqH05zqH4lnjwZoNhTBpFC3gadonOg==
X-Received: by 2002:a17:907:94c5:b0:8f7:68ca:c004 with SMTP id dn5-20020a17090794c500b008f768cac004mr12022799ejc.64.1677486589371;
        Mon, 27 Feb 2023 00:29:49 -0800 (PST)
Received: from [10.33.2.246] ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id p25-20020a170906141900b008b30e2a450csm2971396ejc.144.2023.02.27.00.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 00:29:49 -0800 (PST)
Date:   Mon, 27 Feb 2023 11:29:26 +0300
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: Add MediaTek MT6735 clock
 bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Message-Id: <2XCQQR.YSBPBN01H6D31@gmail.com>
In-Reply-To: <52d479ff-14c6-b65d-952b-e7753fee2dea@linaro.org>
References: <20230225094246.261697-1-y.oudjana@protonmail.com>
        <20230225094246.261697-2-y.oudjana@protonmail.com>
        <52d479ff-14c6-b65d-952b-e7753fee2dea@linaro.org>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Feb 27 2023 at 09:18:45 AM +01:00:00, Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:
> On 25/02/2023 10:42, Yassine Oudjana wrote:
>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>>  Add clock definitions for the main clock controllers of MT6735 
>> (apmixedsys,
>>  topckgen, infracfg and pericfg).
>> 
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  Acked-by: Rob Herring <robh@kernel.org>
>>  ---
>>   MAINTAINERS                                   | 10 +++
>>   .../clock/mediatek,mt6735-apmixedsys.h        | 16 ++++
>>   .../clock/mediatek,mt6735-infracfg.h          | 25 ++++++
>>   .../clock/mediatek,mt6735-pericfg.h           | 37 +++++++++
>>   .../clock/mediatek,mt6735-topckgen.h          | 79 
>> +++++++++++++++++++
>>   5 files changed, 167 insertions(+)
> 
> You should squash it with other part of binding. What is the reason
> behind splitting one binding into three patches?

It seemed logical to me that each of clock and reset bindings as well 
as documentation would be separate parts especially since they go in 
different paths, but if combining them is how it's done then sure, I'll 
squash them and resend.



