Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B197270DC0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjEWMKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjEWMKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:10:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95F211F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:10:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-309382efe13so4591460f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684843846; x=1687435846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGk02VW36o8oi9xKpds5rY0RuBS6XODiauPH5sa2EDk=;
        b=1+hx8JRMv8bN6bR9C5NNLW6j3oMCk8dl5nP2zPiCTdzFTyYS6CMOWzYCAiyr2LbJKq
         stWoCqsYd1ZFVflnqCQlsMXyKLScSJgyNJfWrF8oy3pkxaPTIpyLGGrB5Pble1GU5YbF
         2eS4IGtUlX3yflBdysz+r7R63PGwkXLgQ84zSRvb07Kh8UBAqV4thC5UN2FaoD9Vu6M9
         FszYXip6ViB509VU11lVE1QKqOfqcMft+qzm4ZM6dAhDfnZK8vfdlk8PGmKDSJC58IG6
         w30vkFHRYKAmLbtlms+ciDK/pCVgcWb9Vd0i0bB+IqDOLVFdnLSjFVYeWXQE6wWQyzOW
         a1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684843846; x=1687435846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGk02VW36o8oi9xKpds5rY0RuBS6XODiauPH5sa2EDk=;
        b=DA9W4OJKK/Nv66t0WRaevTy5JYcngI+mCSlkh3w1RdQ2GTvOqXhTVGby4Qgn8rqBMs
         eiV9F2i1M1xWwzBiqpS1xdao4JlhIsA/vIxS5Yp+M5JPclaomUAaLxuiuVNWp7tx+/lB
         hli5f1wfu5HdJetkjy/bwuadfwGp6N9mBudK22wfoCAoWWqy6rgmqmi2JAA4zeQa6/7l
         AhzpmAqq8WxsHCqnhgbGR54ZxOGJtbr2c/ypPVCCoWMDbSnTph3n6AZDq7+IOr1o2s3F
         hIwygxFgt5jQovA7PJaBB8O6RB6LchnYDUgmV3kCn9bStvO5khiIYbUgm/hoL844wx6e
         30Sw==
X-Gm-Message-State: AC+VfDyTCsHNrpxQtUCrOoBUFSOUz9WMwbaFJzt1LJtuALsUBrxXdEmh
        QV4GVnfnM38/tw4aPowP8IDcsg==
X-Google-Smtp-Source: ACHHUZ42YAfaQnb/Yc6os9IZAlXJp0vBw8ve0qBJR7shOA52HC7aoC6d1NzgFID1WFdnGb+5LV4Qkw==
X-Received: by 2002:a5d:6b4c:0:b0:2f5:83a8:a9a9 with SMTP id x12-20020a5d6b4c000000b002f583a8a9a9mr10876277wrw.16.1684843846192;
        Tue, 23 May 2023 05:10:46 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe8c6000000b003095a329e90sm10788563wrn.97.2023.05.23.05.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 05:10:45 -0700 (PDT)
Message-ID: <2a22b9e1-a828-8a88-e125-f8e603bf1796@baylibre.com>
Date:   Tue, 23 May 2023 14:10:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] media: mediatek: vcodec: mtk_vcodec_dec_hw: Use
 devm_pm_runtime_enable()
Content-Language: en-US
To:     Fei Shao <fshao@chromium.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-media@vger.kernel.org,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20230515141610.v2.1.I0d1657be3fea5870f797e975a7aa490291e17993@changeid>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230515141610.v2.1.I0d1657be3fea5870f797e975a7aa490291e17993@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 08:16, Fei Shao wrote:
> Convert pm_runtime_enable() to the managed version, and clean up error
> handling and unnecessary .remove() callback accordingly.
> 
> Signed-off-by: Fei Shao<fshao@chromium.org>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

