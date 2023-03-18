Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D256BF889
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 08:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCRHvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 03:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRHvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 03:51:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3976D5BDAA
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 00:51:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j2so6202240wrh.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 00:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679125863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+As7vie8N8s59ETHaGf9UJ+zSFOwNWpAniW6fJEOFE=;
        b=W78NR3YbYmaVDR/ba9WPGziRu7ooqerV6RjKmGLHgeMb7mUf7Q3fckA7ys9v6OKgVu
         AANJ5Jdyt8DvgRiYuCqPq41xIDdSh0eMU07fWZJikyjZ4SVOTMm0ZPXDjkFteb49/cU/
         /v1IoV0JINwwuUQs6UVOdXcBOxm19a0Bb99IpXkyMzUK6pr6zH6MRoBpPy0x1Uy/NYvM
         qvPEb0g6AaYkdiuaXA6Fpg8oSbD71+UftIl3fsIW/qPFYBORJz80tsgUfg5uug+R8VLo
         tBH9g5CqS0PZzTECFNo0JNh6Y8bX+ozztNkVwFHivkO5osVug+gMMjy9iZwEZV+JbosA
         dizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679125863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+As7vie8N8s59ETHaGf9UJ+zSFOwNWpAniW6fJEOFE=;
        b=TUOUMU1I5ufYd4/tuZlvTgCtCZWOfQkHfbKmSJlOCZrn3nNy6vF4xtil38/oyMIFdk
         ulZkph06ZY+liiCi13J+msNAdbpJhYm08DxlkJIovsTwIrrcLDyKPZgZ+S0R4HDsS7uR
         Bg3axIgHQBM9CK3A3uP/XhRo3vhEFKXEq74MbVZDxCCOBnq3LetlKQngrUJkeN+eYKq2
         CUY/E7vpa6CmO2XEO2ys9fVya56UvoUQGJ/0oPna67runjbEnKq2U/i3dNgGViIRMzCa
         K1EPTRZ8Wft73Kznq3wreA3H8cFqyFgPhkDtOPFfC0CWeq5U3RzYJ+cuZX+gljtwB85X
         cgZg==
X-Gm-Message-State: AO0yUKVCMxLOYCHDNBOOrzEG6HThtjZpJagIZGxf9+/fLqqKqPTUEqd5
        FkKyLnRQ2rpkyNMt3nCUrRS/UQlla44=
X-Google-Smtp-Source: AK7set/GZHlIs69TB9+8FNiWVqS072+J2sCpOhA8cihjCLaQn1bDvVyXDkg+0xWE2MShH6HP6+gmyQ==
X-Received: by 2002:adf:f60f:0:b0:2cf:f061:4913 with SMTP id t15-20020adff60f000000b002cff0614913mr8730812wrp.49.1679125863626;
        Sat, 18 Mar 2023 00:51:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d4a08000000b002c3f03d8851sm3699880wrq.16.2023.03.18.00.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 00:51:03 -0700 (PDT)
Date:   Sat, 18 Mar 2023 10:51:00 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Replace "<<" with BIT macro
Message-ID: <6d78fc9c-59e2-4748-b6a8-65c937b111a2@kili.mountain>
References: <ZBVhmU+5dVoExIH9@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBVhmU+5dVoExIH9@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 12:30:41PM +0530, Abhirup Deb wrote:
> -#define TSI148_PCFS_STAT_SELTIM        (3<<9)	/* DELSEL Timing */
> +#define TSI148_PCFS_STAT_SELTIM        BIT(9)	/* DELSEL Timing */

This patch is buggy.

regards,
dan carpenter
