Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B068EED0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjBHMWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBHMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:22:10 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003F96196
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:22:08 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so26851549lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 04:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fp0NKuoTqeKieMuPExLXzrxdvpIWXw/nMcx/ZYXWt9c=;
        b=Dir2pRfjcShrZh0W+NFMPpG+77UihZ4gmj7YSB8S0eMT2YliBO0yeAiTvIfaCkiLS4
         9LZMddi19LMAxD9w4YMulQLzmOxPLKX6GjPLGRk94IxnBxqzZ2C9g0cIFcrCiG/LC8KI
         sX7NaYI1JVOjgsIdSR3JYE7dm1exKBOOCdunpceqRt/KNZfXIoYup8zWiIzWRPh6VOK4
         jyzOlT8e75n+go7rgVysoxICpu9ALko3pkLKF4d7IVwwZDNWmR0vl1s+UaaOzoGYT3cF
         mkTuqUBKZsVM++9+5Y5FIJATWJqbs2arhjocDwOtOV5HLkTbAp3jgP+Wo/9LAwnHGtEu
         KAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp0NKuoTqeKieMuPExLXzrxdvpIWXw/nMcx/ZYXWt9c=;
        b=Ex+mnFfM9UFAwk8G6Slw2LH2OZK3xDRA1TMm6nci180wN+Al4X1yEaAPiraUc430Vx
         w9jVYxJ3tA2GY4pjCdNk8D7YQkLE8VwLNPGXszXz4mojTXNluoTW8FKRq3sk7vpouClN
         wPjw7zEoeEjekWZ3n0YUF6FHzM/CNpbREkDaou5lRH8aXHZIEf4RFhyUfL3zAL3bLMIV
         /SOS0mYABWzfnMNNv7v//pg605Z5WI6SD2IR5WII/xC2hNtztlyCh24xxd4v0gyG4e6v
         NjYgBbcuffo5s9vuhtpfz8UFIVizROoKRIuiAxSUIuDy/NQ1yyjWBI7kSgwZxzIKu9HO
         Q2vA==
X-Gm-Message-State: AO0yUKWvxIjeknjFll35jw0zNVNIjvd/Lp3j4r96hQK7h9/RwQznWu6u
        KG/3RwRJeu/Va+hYPZxztEk12q9ojrkbcQVSZS8=
X-Google-Smtp-Source: AK7set8NRlF5tZeSRZJzglJ0LkS8wAP4fh0O1B6YuHSYNcx+WXLgLPBBMFOB+416bHk7fBTjTIqWkU5xRsgrJ5gh/0k=
X-Received: by 2002:ac2:41cb:0:b0:4d3:d4e4:9b85 with SMTP id
 d11-20020ac241cb000000b004d3d4e49b85mr1250037lfi.46.1675858927239; Wed, 08
 Feb 2023 04:22:07 -0800 (PST)
MIME-Version: 1.0
Sender: leighannhester285@gmail.com
Received: by 2002:a05:6022:730b:b0:37:1684:426d with HTTP; Wed, 8 Feb 2023
 04:22:06 -0800 (PST)
From:   Fiona Hill <fionahill.usa@gmail.com>
Date:   Wed, 8 Feb 2023 12:22:06 +0000
X-Google-Sender-Auth: iTzs8NB-qEYYfJM0Vw7ePNXUdpc
Message-ID: <CAD3H0r-yqbVm_wVxuLN6VHmb1nsBMmj0o8g7CSXw28_Ni+zLaw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
HI, did you get my two previous emails? please check and reply back to me
