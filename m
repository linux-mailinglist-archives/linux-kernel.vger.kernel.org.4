Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD6867B2F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjAYNGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjAYNGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:06:09 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8859B42DD1;
        Wed, 25 Jan 2023 05:06:05 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y19so21716097edc.2;
        Wed, 25 Jan 2023 05:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3TRaMLCElj28RgHhwbA7Ir1AYkB/9P+D5pixtveZOk=;
        b=gU/PHo3MaV1FFz7RDJ9GB9ENGSgU04XrJxY54UbvRRroEsP3CKJ395BG15dYDZxAeG
         c2mjPoOyOBLvI9ce0xMtgnJz0o/Pl6oytoT0mz0i6DfY3NPlAVMrb8xV5x8EjPny37HQ
         0N0T69W2cb9SQZoqpmkTUeBKG+0RX6Wmj2FLrqc4dObWkwaLBMi6RQGY/BpEMzD7gQxT
         emEtuIRXTvYidsnF+ZGCHo/gKkNM5sHW8/8qbF8s7kLaG0MkcVeOpR4d1QyThzFxgDbK
         Sye0ZTMRJf/3fR0hWnNo48O7S7Ed6K4eQAv3wm2DRfZDzTZh3nxetNodaeZoX9refs80
         I06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3TRaMLCElj28RgHhwbA7Ir1AYkB/9P+D5pixtveZOk=;
        b=Uo7Q75NJzzTrZA/kLbdI4qQqNmyBiOxolCFKyBWwbo0IH/tb+a2FjXqM7Swxi5vh0U
         lX0fatbHUyj9G/TQH6qJYdE90ycH/zGE4zCFI7RTpj15KBBdavCd3OXmTn7ozUk57s1N
         Fo5VBnhCcNbapsODngv14RmW8IdWx50u9IG3Q3UilCpxtrYn7AedR9hw5mikOpT8A4xk
         JH67WkWL1fthHOdXtc0p8uY7BlhKBzU5pCtOnDkrRIgydKN/o6c1toclVTq0ochIiKLR
         1JOf4vOGZ8Snd87JlkbwSufWLA7w8s3o+HUcFKISbEHG98rX8XdZ7JEN/8hRZz2qkKP9
         Amcw==
X-Gm-Message-State: AFqh2kqeaGJIqQQhwt0e5CDV3RQxGn2deE3hDCvBy6cZWu4fY/dApFqL
        qhPs5kMR/xwV+X5v+2YVV1E=
X-Google-Smtp-Source: AMrXdXsEYYBWCTr9uq6jIS+j9EUt8rXf9FBBVvduYXy7+KVbVQ8ZN3mqJ52n0uMLKbFpYDoavbCpqw==
X-Received: by 2002:aa7:c994:0:b0:499:bf81:be6 with SMTP id c20-20020aa7c994000000b00499bf810be6mr36035323edt.37.1674651963963;
        Wed, 25 Jan 2023 05:06:03 -0800 (PST)
Received: from fedora (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id f20-20020a056402005400b0049e1f167956sm2353139edu.9.2023.01.25.05.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 05:06:03 -0800 (PST)
Date:   Wed, 25 Jan 2023 14:05:57 +0100
From:   Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/3] bus: add Wiegand bus driver
Message-ID: <Y9EpNfZJ5irXZqvR@fedora>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-3-m.zatovic1@gmail.com>
 <Y7WHjD4psjgAAyPd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7WHjD4psjgAAyPd@kroah.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

thank you for your insights! The static lists are needed
for matching wiegand_board_info structures to
wiegand_controller structures for drivers of devices that
do not use devicetree. I have seen this approach in the
SPI bus driver, so I assumed it was okay. If there is
a better way, please let me know.

With regards,
Martin
