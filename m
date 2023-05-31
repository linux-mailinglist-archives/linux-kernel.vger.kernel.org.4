Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B67717B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjEaJS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEaJSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:18:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2627EA0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:18:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30af86a966eso1230045f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685524732; x=1688116732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrJA1wmEzlkWZ69WKrs6mIsPDzL8DfCHLcTOjGfg6I4=;
        b=bd9uC8GB+3PDY+D4IIrbCZqNEUVwTIUTV3DdWmWHgvO+aVjzWp3wDu/vlefKMZI+t3
         o/y9+1sHoqFCkMsh452VKfK/k+EW3T6D9CtczGNhEYjwGXww4OaKqrpXFStM6O9S2huv
         RUK2/e8QIoGSJhSTpIZOKiGnVU2sVimTfWbtpUDjYn7dkuixFoJ/liRbsUYi3oVS7rHP
         bQrU4bL/fSWNyeX2qZlkGl9YfrS5qGlGKBB5hxOojwV6/vYJ72op3fDlX0rfG6M74In/
         ti5u40JdMnOlKTqSnjL+6yPL1KRBuAqETCWlVM74blLv/RqTRVeZMF97dIGg8Sp4C6S1
         h84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685524732; x=1688116732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrJA1wmEzlkWZ69WKrs6mIsPDzL8DfCHLcTOjGfg6I4=;
        b=ilThmbmu+BfoTCFjnTx4BjyGAaJGDocgVTaMV55Ze/9t/sVQPCh3L0Lpuf2ZLoaukD
         kKlrAkmI2lVWuBI8CPsKeG5fKTbwklUgEmriwBkvy5SX9aEPQjGPfUE7MpGnWv4pBM/4
         iO1TmA75uH+0S7UVcQBhFYQ38mvNpLW3p20APqwBi2Bg2ll9H3yyC73LEjximm6MkMgn
         ghWc9WW4wsrO4FVntPemwz3Jfp1ZeDX4x+V16onGpGgo7iI10t9G0pkCgBGqMJdbXJVO
         9gOlTGgtada4xApeilxCVLrwcDxPO2vjcNW969RQHRgYRjGGE3AeB7FlseitcyONTN5U
         UyQA==
X-Gm-Message-State: AC+VfDzILbRpEoo7/lJZH+lC4uBRhUjIXUEIanBuLYlwEGrdzeCqE4fL
        iUaVlyZgUapjjXVSIjU95Q1gOMrKei4JabtSo/o=
X-Google-Smtp-Source: ACHHUZ7lAAwrKpK9TRhDn+eecpnGOlf2Rzd8NfNRAS064a3cbEl3TUU1UqGLbZuvQvX9QWl2mu2DTA==
X-Received: by 2002:adf:f088:0:b0:307:a77c:c170 with SMTP id n8-20020adff088000000b00307a77cc170mr3426526wro.2.1685524732559;
        Wed, 31 May 2023 02:18:52 -0700 (PDT)
Received: from [10.1.3.59] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d13-20020a5d4f8d000000b0030ae69920c9sm6063518wru.53.2023.05.31.02.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 02:18:52 -0700 (PDT)
Message-ID: <ebeb1d26-f42f-a57a-f6fb-ae764649f3c2@baylibre.com>
Date:   Wed, 31 May 2023 11:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] soc: mediatek: SVS: Fix MT8192 GPU node name
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230531063532.2240038-1-wenst@chromium.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230531063532.2240038-1-wenst@chromium.org>
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

On 31/05/2023 08:35, Chen-Yu Tsai wrote:
> Device tree node names should be generic. The planned device node name
> for the GPU, according to the bindings and posted DT changes, is "gpu",
> not "mali".
> 
> Fix the GPU node name in the SVS driver to follow.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

