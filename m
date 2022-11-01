Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38E9615615
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKAX0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKAX0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:26:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5D17E11
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 16:26:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t25so41038476ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 16:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjaxTnD+RIihVp0m1FGP/cxt8pNup1dJPxpfJslNDq0=;
        b=l905ClINmGBf1QRIARIGmkV+n9JhSylgXMU1TcpUnMgXVDuPCiyL8k1qc/rQ6iXo9U
         weF7KiBTqP7NLIhVUvMKTichGHCAnRyEaXP9tOD5gvcyqE6qVs1Rs3FbJoXb0B8fJEsO
         eV8giN2nVTaP8VgW8kNXGB3h3rs8QlTjcl9dzq1MeuBxIM1HlI9+RK0JZiJUjjadjwuy
         8wHKDcfDgC4tZp/aT0yUoGqkMMdyM1Adid6vWG/Lqa6TV5wUZr2n6Bxid8V5DZYRN4qD
         wL31Mq913v2mKdqqhzJ3cf9+JjUx3mRbdN9+7gesd9goH2gBfH6N2xQZ7Q+53KIgyxi+
         pueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjaxTnD+RIihVp0m1FGP/cxt8pNup1dJPxpfJslNDq0=;
        b=DDx2htyIJkao6qYwXh07FuS6bsjNjAs/YT3I1HBiOsxiEQhjsTLw8OT6a0W2qgwnJf
         AAFjsvuikINV0B72znCcsd6q7xKObOi93/39HCuIBreNO+rS49UODfRqx8zJzXqXtje9
         ZajACLxUvMgIwaBhgFn7JUhpUgJM4e92B3l4YELaZo6PFuoYG56rJmYeU/nZKjsAUZ3W
         yBKepLj9TXbhePJamTmMQIrmrvh33uTzGH+mRDrX1UL+8GJuNVavfCbuntzno5YqGOnl
         qV502gC1HgeiZPF5svdvKZEDqpG6dU0Orblnb4JWgSO6O0LDAi9ZkuOoiNtHD5TagtKS
         SnSg==
X-Gm-Message-State: ACrzQf1olLM04EB5LLdX4G7Hw3RmGXK0H+YQno7UdVLmQy2z3C5qW/dU
        M9vrG0svAxHhxLdPHT6vSxo=
X-Google-Smtp-Source: AMsMyM51/dwqW/J04wkNqDaDuY77JtN/Er/BG5P4RbcUcTNG9pWX27ABWK4tfQCvB7j4nrPML4r+bQ==
X-Received: by 2002:a17:906:6a17:b0:794:f0e8:1918 with SMTP id qw23-20020a1709066a1700b00794f0e81918mr20990385ejc.474.1667345199742;
        Tue, 01 Nov 2022 16:26:39 -0700 (PDT)
Received: from [192.168.1.102] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id mj21-20020a170906af9500b00773f3ccd989sm4717136ejb.68.2022.11.01.16.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 16:26:39 -0700 (PDT)
Message-ID: <32a31a3d-99df-c402-9889-51ca4f8c041a@gmail.com>
Date:   Wed, 2 Nov 2022 00:26:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] staging: r8188eu: two simple cleanups
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221101191458.8619-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221101191458.8619-1-straube.linux@gmail.com>
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

On 11/1/22 20:14, Michael Straube wrote:
> This series contains two simple cleanup patches.
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (2):
>    staging: r8188eu: remove extern from function prototypes
>    staging: r8188eu: convert rtw_free_stainfo() to void
> 
>   drivers/staging/r8188eu/core/rtw_sta_mgt.c     |  8 ++------
>   .../staging/r8188eu/include/osdep_service.h    |  2 +-
>   drivers/staging/r8188eu/include/rtw_mlme_ext.h |  4 ++--
>   drivers/staging/r8188eu/include/sta_info.h     | 18 +++++++++---------
>   4 files changed, 14 insertions(+), 18 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
