Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CFC6CA409
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjC0MZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjC0MZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:25:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD353ABA;
        Mon, 27 Mar 2023 05:25:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id q7-20020a05600c46c700b003ef6e809574so1874448wmo.4;
        Mon, 27 Mar 2023 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679919949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uslYjtv4m4AksflLGnoX5lwwTxOvcq4QRw5RlSVhmQw=;
        b=PolfwCa4IcIK/n1Oye+8d0lgDu5S86ppO9k9VnMxzkxR4mlDsXWKRuEN8Wwa9GHlLi
         TRRK46gDB7oUpZyQDk98GV+bj/f1JD3ILY4I/x2RqkTgtJToR/klNkZmZk+D0fy5S7Ov
         7oaUO59O34ggm9cYdnewFt66WppKiqlW3zkEF+7+aURbQpDjOWGDNM8W/w0K94l4x2W7
         CTizHGz0IVtz4H7qjCkZpXAzY7tEzvA5QIPJSwICyJGGtRAnZeagBGYVnhENx4VlXkLz
         UrEqPXgcP3LfY13X9A68zKtG5KMdfZYaBhp9rAIARwmentau8XmHIlBAJsytXYlhafBF
         6CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679919949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uslYjtv4m4AksflLGnoX5lwwTxOvcq4QRw5RlSVhmQw=;
        b=qMdSWY4ptLBds11vurm5YlOoeX4+z0/JBsW5dvGexzaymwArL21tdwQur6LErC9RYN
         +yTD78XgCU4on/5IixvopRUnHwDIX3+tLylPkvQSH0CfrCKXrry9USz4bpVno5hCA6BN
         MKM9Zq4rbhTUQdghCtmK+pBJQimbrksPmf0sz6PgEgUmv77gS/+GmqscwUIxR7QHj+CD
         vfh6roI2Qd3LBGGN7DHguxT6oo1WxavhIcISNuS3LdXDqpvd4iRqvj2dZkzwxhM2hAZi
         0jOHEaiRH50BtLVVZLpIH9/05Oi6sQjuzbveHUPy6RyAzd4qQusHDqZrKuC0DgbMG+ZD
         CKug==
X-Gm-Message-State: AO0yUKUSMlCE9E0x7sv7ihpsjNqL0w/F0H6L4jJzSwEtVnB0vjxwY5Tu
        eUjU4Ex1D9wUfx3cdYvxzmm1EaNEqdM=
X-Google-Smtp-Source: AK7set/0A4okK2dgo4fW1zVAEQe9LUB6jX7YJlVK/yTZPM2X1C4gkyjrVKH+mEqxf1SGXfO7XIX7Zg==
X-Received: by 2002:a05:600c:d2:b0:3ee:9909:acc8 with SMTP id u18-20020a05600c00d200b003ee9909acc8mr9576073wmm.32.1679919949093;
        Mon, 27 Mar 2023 05:25:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b003ede6540190sm8895718wmq.0.2023.03.27.05.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:25:48 -0700 (PDT)
Date:   Mon, 27 Mar 2023 15:25:43 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: nvec: replace udelay() with usleep_range()
Message-ID: <453453f4-1496-4735-8fab-efb7e4240e05@kili.mountain>
References: <ZCGK4+zUDT1lLz6s@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCGK4+zUDT1lLz6s@khadija-virtual-machine>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 05:24:03PM +0500, Khadija Kamran wrote:
> Replace 'udelay()' with 'usleep_range()' with 1000us as upper limit.
> This issue is reported by checkpatch.pl script.
> 
> CHECK: usleep_range is preferred over udelay; see
> Documentation/timers/timers-howto.rst
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---

This kind of change requires you to test on the hardware and have
slightly in depth knowledge of the spec.

regards,
dan carpenter

