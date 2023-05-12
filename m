Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA52700874
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbjELMvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240641AbjELMvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:51:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2463210E5E;
        Fri, 12 May 2023 05:51:02 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6436dfa15b3so6655415b3a.1;
        Fri, 12 May 2023 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683895861; x=1686487861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8hKOD9Iy0tQGy4fcQ/4Kqxu+FxDMMu7hFSgKPykyf4I=;
        b=NqfM5rnLOQVg+jb+U8/Sth8UTb3RBrch4desjGURYmphgqv6o0MyEsdMy2WvyTpZSI
         TmYbtpFkO/rnBXpBuB8dRDYBRPYLJKgvDt1n3xTpTaGb6LefNDxlB8g+uvVT6f08SOf6
         mU4j5l3vuyhxQK2KuVXbXOO3qQSO7Cm9pGG7N8aXKWc+bGCOzrBNRflYbOL/G06QDKJq
         VVa7lKkaoX1SPRH97nE58mvjS8rLo2wCmE8oe4zmNhqSFAYpKasKMHCI4e6YO3iixfjy
         IpsOTqXNjQYZyY/+KQG90AE5gJW9wgLf5NQ7NlzZiWKlDQamS52pfdMrR8p9ousiaZtF
         mAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683895861; x=1686487861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hKOD9Iy0tQGy4fcQ/4Kqxu+FxDMMu7hFSgKPykyf4I=;
        b=hOUOKvwGLomjMRHUR4y1cEC2ZUQOsD8JlX1YTnWY+24o28m9nPtsYMT2vQbg83SXwp
         oXggx14TOUxh2jolknXT8Gkve0shJxNKsXZ8/9hBitkeLZnW7jCuoa8d8Ixb4ZOXNyXD
         3T+YM3GcITa+A7NI9yCTQRyJzMWdf6H/x3k+niwvD3BzLoIda/jJNiKuaDixJxqR7Uhq
         QIFQqjDqzGA7CJj73OZ1k8w49NgDOoC9hK8K995oLPPnGTlXyIc/ec8kemEMduLMvuHZ
         nIeqhR/LN0/Vl85IlsKwSf1eGU2WhJbm4+j4+byhXynBoVQjztAl2tNjhjMUzfUa7nfm
         C9jA==
X-Gm-Message-State: AC+VfDwPosKdtkEd5OWA0MX5JYlRZNH/CJzdq3izHRWBnwcIx5MKZN0d
        Sz/60MKhk2rzzbZV1dUHXbwcpfeQQS4kdA==
X-Google-Smtp-Source: ACHHUZ4rmEAXNT8MNROvPS8CMw3+GgMmuh4hcG+aNoCCCMOyboEKaBOaBbPyFVaiIjspjomoMOheAQ==
X-Received: by 2002:a05:6a00:2daa:b0:643:b054:534e with SMTP id fb42-20020a056a002daa00b00643b054534emr29995034pfb.31.1683895860993;
        Fri, 12 May 2023 05:51:00 -0700 (PDT)
Received: from [192.168.43.80] (subs10b-223-255-225-227.three.co.id. [223.255.225.227])
        by smtp.gmail.com with ESMTPSA id x9-20020aa784c9000000b006475f831838sm5973214pfn.30.2023.05.12.05.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 05:51:00 -0700 (PDT)
Message-ID: <492cf425-0146-9608-aaba-e91c819b3eeb@gmail.com>
Date:   Fri, 12 May 2023 19:50:21 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 08/10] drivers: watchdog: Replace GPL license notice
 with SPDX identifier
To:     Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Watchdog Devices <linux-watchdog@vger.kernel.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>
Cc:     Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Airlie <airlied@redhat.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Sam Creasey <sammy@sammy.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Jan Kara <jack@suse.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ray Lehtiniemi <rayl@mail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andrey Panin <pazke@donpac.ru>, Oleg Drokin <green@crimea.edu>,
        Marc Zyngier <maz@kernel.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Sylver Bruneau <sylver.bruneau@googlemail.com>,
        Andrew Sharp <andy.sharp@lsi.com>,
        Denis Turischev <denis@compulab.co.il>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20230512100620.36807-1-bagasdotme@gmail.com>
 <20230512100620.36807-9-bagasdotme@gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230512100620.36807-9-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 17:06, Bagas Sanjaya wrote:
> diff --git a/drivers/watchdog/octeon-wdt-nmi.S b/drivers/watchdog/octeon-wdt-nmi.S
> index 97f6eb7b5a8e04..57bb0845de477d 100644
> --- a/drivers/watchdog/octeon-wdt-nmi.S
> +++ b/drivers/watchdog/octeon-wdt-nmi.S
> @@ -1,8 +1,5 @@
> +/* SPDX-License-Identifier: GPL-1.0+ */
>  /*
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - *

Oops, still incorrect tag. Will fix in v3 (should be out on next Monday).

-- 
An old man doll... just what I always wanted! - Clara

