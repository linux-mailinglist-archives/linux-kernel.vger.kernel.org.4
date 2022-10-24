Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD260B41C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiJXR3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiJXR21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:28:27 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3A51CD687
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:04:03 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so10304215wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shkzBSRYb8eEdOLP3UTTdRh/01nxv5ZqRjAmdh5koP4=;
        b=fIrCzFGVNBamfhyfghjHLSPnjaYaAXiXB3FlPHyl8D0PCF3CQgHU+oYWhqDxdlqqOM
         /K/u1URMEwIxnFZQBK3npbbRoT3rIW8FIaDieyu18BGC5ztrwbNUsG8mLXyXtQ0G0V7V
         /LnixtZEuqTTdnAu+u+h9K4fFQB2jhJ6cr1yMYjwiArR/8MBqHT10CmWz8PvArlWgZld
         w0vUl6AoiDRmzg6B/Ylqlovbd4uBAG2RSjO4V+5aN35aC1m4Ed8Hb/yZGnpou1jvJaLs
         Cd0UbHhlgJ4B2m9qIdFqYNuj9+vMAHSPOzH8yqT82DlkERQYyHVYcSkvevSpbJdc7Yvc
         JDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shkzBSRYb8eEdOLP3UTTdRh/01nxv5ZqRjAmdh5koP4=;
        b=X1Hm122WeLg36LPLZoRIqqMtBqC/0svaU/48+Fjo7WP0sx7m3S8sL/LglZSu+vy+19
         pShotk1pDnB4/gr034w5yBMfs1iLeaeXpCDEbvUBio6Yf8o68bco3gJGNceBhrXpZ4xb
         EHRmIkF3Lj9wrf4AkT14Df4UDYr2qUbq4l0G+/VtiQ5P6JSrY8M3ldkNbA6eozeliW92
         vE1/kmCrlau/H4F2EFAvIocOPVICcho8/V2wJqAk/EOtnAtk+6UYpql0Vs5H8i18J14u
         FV5YktajQGVX7E/novnZg486B/cl6ihwp6Fj6KKRL4krWsgT4j4n4wnsiLCFMMQ2tFv4
         JNDA==
X-Gm-Message-State: ACrzQf1K+6rYZ5U/R77U8owVPSORV5xd5BWKnxbsy9yuCdyk7t3Dhpqy
        Hl1SF8jpbOfnWLqmnDV4KfKwOFsAOA==
X-Google-Smtp-Source: AMsMyM4ID7U+5xsG2SxyVRB5HsOJSb0xMmMuphBm9NuevCGEECcRTYYkSr2vYCt8Vj6iT00/s0AZ+g==
X-Received: by 2002:a05:600c:1c88:b0:3c6:d9a5:a083 with SMTP id k8-20020a05600c1c8800b003c6d9a5a083mr41082045wms.54.1666626292895;
        Mon, 24 Oct 2022 08:44:52 -0700 (PDT)
Received: from x99 ([46.53.254.150])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b003c6d21a19a0sm235454wmh.29.2022.10.24.08.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 08:44:52 -0700 (PDT)
Date:   Mon, 24 Oct 2022 18:44:50 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rft, PATCH v1 4/4] kernel.h: Split out ARRAY_SZIE()
Message-ID: <Y1ay8k75fegxTcuG@x99>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> include/linux/array_size.h | 13 +++++++++++++

All of this is pessimisation unless you're removing

	+#include <linux/array_size.h>

from kernel.h which you aren't doing.

container_of.h is just as silly.

kernel.h might need _some_ cleanup (like panic and tainted stuff) which
is rarely used but ARRAY_SIZE()?
