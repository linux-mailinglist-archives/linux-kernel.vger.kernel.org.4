Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6172B5E4ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiIUSYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIUSX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:23:59 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3B3A0241;
        Wed, 21 Sep 2022 11:23:57 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id g85so3644381vkf.10;
        Wed, 21 Sep 2022 11:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=+eAo7BDyj6rqLjBqJp5X0j6DhBCMrJif3f40JY/Uy7s=;
        b=kutqZRMFdJuMiHLv0dWs/IkHYRC+xE8RV150VKytMpk2z5ZDFUBkG6X+qCNdzVF4rj
         dXi5H4Zi0xugPLM5IurwU/I9Oon2Za6GpLWEMBOqcsCgY/02jDWQxqeTHKIo9Cqb0QhL
         1PBX6J7sW9ywaSergyJEe9TtpFa9dU6UUnQA09zOyaZKgf+P+8tnXfIkHkWXOmObodmO
         87kQtBCxHqmObTl8fxT8TBRSAvF/KdygwNlMQ8OHqFUOnjqrJHjBRPGCoeQjiN1+sZEH
         k7nhvii49/ZcGvLnr0Sa9c88A06miVuu+b00e+CnulJah2CtoENIce8j2gf1uF5qYssU
         1jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=+eAo7BDyj6rqLjBqJp5X0j6DhBCMrJif3f40JY/Uy7s=;
        b=CmnVB3Thw/B0I7nY43K+hhclT9ty1oSBLXxZFUmg2l4cj4k+31wxxHvoM7lIYN2Bfp
         fXkDYEzRftzEKSPK0i6IgT2uFsRhpWiEcyGPhnd0Yh48LsAbiHl1MS4w0PDqb6g9nY6s
         qei6JRkYVCHhuQKfi0/gURqlxWldfCvOuv3LNSDT00pHUnXRDBofEH7sicfwnZyhZU/v
         HnkRNIv4kWcPzVWLSiHJxRjkhGmC2jXpV2CF9uU48cdbBq8GsmCQOjXDa4v7VpwFXtTH
         GI1QEPW8Gy5u5VyI05oXNq77SKAynjBSpp8/5sRec0OpmycyapNnAzfHpbFkbN+EdmPV
         p8Uw==
X-Gm-Message-State: ACrzQf2Tu0oQn+5MomtRDP3/uH+H0YzXBN9MaEMp9zYzxED6qgBiaFJl
        Or6bKPOYiTbToBlWI53Ibgu1fIh1gzqmlfGH3PU=
X-Google-Smtp-Source: AMsMyM46IWYtfcmTEWdwAgUz+nhVqCEhKTsB1hlNV9/ILqNsWTEcrcBWt6flzOj8YeLVklpUukBY2WxB7A0pWflitzM=
X-Received: by 2002:a1f:b60b:0:b0:39e:d666:d9de with SMTP id
 g11-20020a1fb60b000000b0039ed666d9demr11068795vkf.8.1663784636888; Wed, 21
 Sep 2022 11:23:56 -0700 (PDT)
MIME-Version: 1.0
From:   Marko <marko.cekrlic.26@gmail.com>
Date:   Wed, 21 Sep 2022 20:23:46 +0200
Message-ID: <CAF9VpL4ZavjF9pwbRC_mj7+YAajgCJXTBdnnwNK3gHSS2VUxYw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] acpi/x86: s2idle: Add a quirk for ASUS ROG
 Zephyrus G14
To:     mario.limonciello@amd.com
Cc:     Shyam-sundar.S-k@amd.com, catalin@antebit.com, hdegoede@redhat.com,
        iam@decentr.al, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, philipp.zabel@gmail.com,
        rafael@kernel.org, ruinairas1992@gmail.com, travisghansen@yahoo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixed fans and speakers on top of my ASUS Zephyrus
G14 GA402RJ laptop not working after resuming from suspend.

Tested-by: Marko Cekrlic <marko.cekrlic.26@gmail.com>
