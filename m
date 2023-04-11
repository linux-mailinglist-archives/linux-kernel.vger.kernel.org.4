Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760166DD542
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDKIYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDKIXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:23:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C540DD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:22:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v29so6655037wra.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681201357; x=1683793357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XpPfEvaJafdQk9OGNwAPeE8oZldMuXTJ1wSplmPTMQ=;
        b=BrlQU45vdQ3zKlNTUPYRt0jjCvKE/qhZBFgXrxg8IvaeN1IXatGdK+c1mjQXum2rtI
         HuWYIEXVTX5PJjX8yZoclDEuajHgGEwbr19Cvfo/0YxNhOD1p77G3a1b6v5NA5YT+ZhG
         Byh9NIRe2/IL3okyYeSEWCm4YxNaaLlsfKSRPHF1GPwLchU+OyDX029JVSiuhK7a/mDZ
         aAOR5nubPGLzdcmiOnfFxaaOK6p/eTLeqQIqenAY8u3vzVWzDYTolO0wtEufUaW9X9KM
         Ir6+APjkrp49qkyuqGNYwhQbQOoJDjMAx5DJwAWctncatfEptMK5dZmcno0szxOseV+i
         py3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681201357; x=1683793357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XpPfEvaJafdQk9OGNwAPeE8oZldMuXTJ1wSplmPTMQ=;
        b=hcn6m82QbOWff7LrKvQVcKuJqf97A6u0U7ba+oOWolukeOQbxtguhjoVS/TOAtmExk
         l9bcyjtfk3e40bdUd5JuX/DGEGvgSzXqaKuSuDmu6DC42xc7cWuMM7xDNDQZRIWTOsLB
         d6Q3KsvRGgeU1nXuBlb6gX0UKnaqJMpYt+SbupVYlyyTXR+GmTFP2zB1e+dNLV+B/Igz
         0m4J9NMQt7Rb7iGPbcQO4/CYfqISVlTU8x8+mTUZJW+iuo0eoISlJaQAJH1jbiqU6gJI
         sZdtCX+3TMf7d0/Qe4Mi2lqc0Sp53MX1mlNgQTagRVd0oqVzJPq1S6xf1D+FF077Autk
         wUdw==
X-Gm-Message-State: AAQBX9fTLXz+Ix6AIckbYYMp0U3Mt5AkhGq6QvyaDfmbvBq8a2fWgiyX
        VYfW016I4+Blgs/R0y4GDvhzfA==
X-Google-Smtp-Source: AKy350ZHBb4mMpY/hce0OQzOyb9NHoj+BNj6MWzRcVd9xPaMjVO3DvSEhPf+ox4y2xEJFETu1ti/iQ==
X-Received: by 2002:a5d:6050:0:b0:2ce:9f35:59b9 with SMTP id j16-20020a5d6050000000b002ce9f3559b9mr8166431wrt.17.1681201357286;
        Tue, 11 Apr 2023 01:22:37 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id a16-20020adffad0000000b002efb2d861dasm10588664wrs.77.2023.04.11.01.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 01:22:36 -0700 (PDT)
Message-ID: <9f341ab0-19ec-166f-86da-3bc7711645de@baylibre.com>
Date:   Tue, 11 Apr 2023 10:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2, 1/2] media: mediatek: vcodec: make sure array index is
 in valid range
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, maoguang.meng@mediatek.com,
        Yunfei Dong <yunfei.dong@mediatek.com>
References: <20230411055413.539-1-irui.wang@mediatek.com>
 <20230411055413.539-2-irui.wang@mediatek.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230411055413.539-2-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 07:54, Irui Wang wrote:
> CERT-C Characters and Strings:
> dev->reg_base[dev->venc_pdata->core_id] evaluates to an address
> that could be at negative offset of an array, check core id is
> in valid range.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
