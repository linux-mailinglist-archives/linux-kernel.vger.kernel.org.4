Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B70E6DF7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjDLNtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjDLNtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:49:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A95A4696
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:49:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so4289311wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681307382; x=1683899382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb6P2byqyLNvxYx5mpnu/HADSn0CeAL5J6+dhakFGrg=;
        b=B9v3Cr72e/au74c7iF4mlnBofvVBf0by7QnZev1/Fg+aA5h0JtHabAGNwWsTm1dhJb
         QaHZJk3eU9ZK5/S+ufoY0/U9W83wj8VLxD2sX4rqNIlHS7bbp9sDlk6iqXgC1mTacuk4
         +RI4jowaObwXoqScKuNcmsqBGuxn86bKGkm97Dv1CgBDCmVWFt+tnlRyfPEBC9BpQZS2
         YDSEKlsByawXVG/u3DR52AD1jUzzVoJbsyNWCCHPx07GuxHSi/fktwXGh2oun3AqtCE6
         dJNXUJvNoW6UQrP40bI4//QvWskJftzd1z+RQhoRADiCG8FBuJYsaSPonV/kamY1STsa
         0GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307382; x=1683899382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb6P2byqyLNvxYx5mpnu/HADSn0CeAL5J6+dhakFGrg=;
        b=BBby6h/tmk1MG8h8gXSQ1tbGnOHcB57SJQjUZsQyGeDDT/eV+UPHTmkLtNovvsBcFk
         hgIU4n9XJruO0ufPMC8yXVudEMZY9HMsUfEaxVaG0c8ruiKIuBXj7Ze75h3ZAu7qBcQC
         NRewBPzAxTTFd3DoF9qGjH5xr5HCyktuvWUGY4o8oZRvlEQmUgx175MXPsDtmF8ph26z
         r5LQ5emI56y0G1beODefB1I+X/58uH4JZs0mXu2U9vd2F3iuNlLPf/nCqonQEEMEOhr9
         jWQ0Ol0AE/s7lx8LytNrCrGHeIh9i2sUrsMrRoJnBDtER+RgWWNxNMxjfCCmO+orDsrY
         ANKw==
X-Gm-Message-State: AAQBX9frT/Da7usZCC6/s7Tvh3NrqvhM5UKTZ34bqtl7LNQC9Ta8NK9S
        YavFUvSMmzkp+YcUCYIcOSi1vA==
X-Google-Smtp-Source: AKy350ZXbR07ORT2zgwh1nwhJhmgY6mdrSYJvMKUTwK7WgHD/vtESiSZPZKxhQzGEBaaP+LS9j+LgQ==
X-Received: by 2002:a05:600c:ad2:b0:3ed:9ed7:d676 with SMTP id c18-20020a05600c0ad200b003ed9ed7d676mr5037319wmr.13.1681307382012;
        Wed, 12 Apr 2023 06:49:42 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id i19-20020a1c5413000000b003edf2ae2432sm2466316wmb.7.2023.04.12.06.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 06:49:41 -0700 (PDT)
Message-ID: <de13cb5f-abf2-86b3-d2e0-2b1131cd8dfa@baylibre.com>
Date:   Wed, 12 Apr 2023 15:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next 3/3] drm/mediatek: Use
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, airlied@gmail.com
Cc:     daniel@ffwll.ch, matthias.bgg@gmail.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230412064635.41315-1-yang.lee@linux.alibaba.com>
 <20230412064635.41315-3-yang.lee@linux.alibaba.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230412064635.41315-3-yang.lee@linux.alibaba.com>
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

