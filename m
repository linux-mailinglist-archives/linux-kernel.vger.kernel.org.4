Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C278162C82C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbiKPSui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiKPSuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:50:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A418682AD;
        Wed, 16 Nov 2022 10:46:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bs21so31404585wrb.4;
        Wed, 16 Nov 2022 10:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwJWWDBntVeku1uedvJVLfXfsM4W2+ZHodqQlFwIwe4=;
        b=OibLO0sDtzDXMimFfooed4Mm/dgLbyq2mjRVnOCEfks0t5txdFiJxkccrWJg+aTekg
         cqkVzTwGUJd9LIZKW/dOjzSgdt3CBPQzoEf3ud1bClR3NCT7/Si6Xs1T6FBIY8u1z0gt
         EDh6NZvFsWXMQnNRtP13l40LtyCIpikqDBDTB2M9qboqOQnKoA5XGTizcEAPqgxwmxwy
         hNMqXThGe/Cx1I7nnW5+3bf2laRThvjIPtus3c0JOPGcrWqLBjg0rkYAZ4nSVIKkR6Wb
         32uPcg/u5KoO6pdoKmx4iyPR8Dpls+VRwd9z5a0x3oIxglYWChXDk4JghpMdCuObz/lJ
         srsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwJWWDBntVeku1uedvJVLfXfsM4W2+ZHodqQlFwIwe4=;
        b=In48yipxG1X7iOfiNXlwjl5JPrPBM6lB7m4EKmo9bjqZmpNCBzBy5iz/E8cz7ffmqz
         1oqOn19wkAfheQI93zm0XoVHq4zRy41vjFvowR4kHRDSl5eCr3t884GO0vUYnSNJblzA
         gM0gqnx0W3vW2V5IzDvBmMqlYNBqAdKgTjAZM1BmfjUmzqbTwRSsPCdCeg/y52P6E/lZ
         Dbs+8OWXeZIxt3K/QkZUa/A2hIv44t7Xiio6qsDB9lqnxahm8kEhO6nhRb3vK2AlFIDk
         7QQzicRabVafSmMVmYfpfoKx3TVIVpzWTGAf+rduZkeqH4OJY0UHV1Nc1YAZIBTjJjRf
         F7xA==
X-Gm-Message-State: ANoB5pm3i/pooeuBeBO4zwKxgpbjhtUXfdYjpXs122VfdBxybDMTr/rX
        w6ZS4MimwfisLoQmm3COouo=
X-Google-Smtp-Source: AA0mqf4JvHTxi8KK+MvHKwXoWZs8vKCo+lLf+kIDv9+vjextNU3TcfsfMIZRw+SXCq7BnCmhY9Z9SQ==
X-Received: by 2002:a5d:4589:0:b0:236:698d:9c44 with SMTP id p9-20020a5d4589000000b00236698d9c44mr14667418wrq.571.1668624380454;
        Wed, 16 Nov 2022 10:46:20 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id e21-20020a05600c4b9500b003c5571c27a1sm3165422wmp.32.2022.11.16.10.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:46:20 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Wei Li <liwei391@huawei.com>
Cc:     linux-clk@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH] clk: sunxi-ng: v3s: Correct the header guard of ccu-sun8i-v3s.h
Date:   Wed, 16 Nov 2022 19:46:19 +0100
Message-ID: <2259258.ElGaqSPkdT@kista>
In-Reply-To: <20221108094335.3597008-1-liwei391@huawei.com>
References: <20221108094335.3597008-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 08. november 2022 ob 10:43:35 CET je Wei Li napisal(a):
> Rename the header guard of ccu-sun8i-v3s.h from _CCU_SUN8I_H3_H_ to
> _CCU_SUN8I_V3S_H_ what corresponding with the file name.
> 
> Fixes: d0f11d14b0bc ("clk: sunxi-ng: add support for V3s CCU")
> Signed-off-by: Wei Li <liwei391@huawei.com>

Applied, thanks!

Best regards,
Jernej


