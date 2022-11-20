Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0286314A4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 15:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKTORa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 09:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiKTOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 09:17:28 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9145B17;
        Sun, 20 Nov 2022 06:17:26 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id e15so6509252qvo.4;
        Sun, 20 Nov 2022 06:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFBd2tgFU0YTAhl1+JwJGS4pxfP6J1RbVkOT1+nxdRI=;
        b=XaMQB5OZDP+OnIAjhbIlu5OmHpuRScoEeB3IuTNBBVL3bKJhmKN0Jio8qCOS7kAPhZ
         WaZEnYpIbe92ieEapPFrlqX01sqv+PcHOXEPjPPgzZP9Y8ea0POc2jxF+h9MUxh73eR0
         UGfJa1q8BFcaVhLjfewjGVjb5vhZPw/5faG3+EBO3P+oWBzLu19mImTnSKkx+q5xx+uS
         Ue16aiJ1hkmVVo3r9BESZoXc5vfwTAp+FqP4OnFr6nj/3do0K39UtMEtE/LygcdkSMf5
         UghmcIxkiHRiClf9IOBpc4e/htCi4U6fV7DUKyMbdjZSNu7Sx7MAkMN6dwaIST9QUSRh
         UazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFBd2tgFU0YTAhl1+JwJGS4pxfP6J1RbVkOT1+nxdRI=;
        b=bHO9Zd8Yhlu+g6A86tmXGmAUFvgsqOb6CtZzN9mMxl3308oy/fJAUVLLPBA9DL2LUg
         7QltKTxG2ROSyHviZoFvutdQ6stqLy/qi6KzCBXbWzEhQ+l8KTqnnh1kMD45/Bh/FbkW
         bIeMbTv3JNew4FMTiJN+kVl9Aezhz7nNTOI7hq7Vb0B94ZXP1o95riiVzcvdZ2F6XpV+
         xjwHx9nuGtbq9uaHW+TC//V4Bqrk01eyo6jt1VSKy3OewWJ5HjU3HZKYd5dDpM5M5PmP
         18Y77WBxrw3PXnwDnl9eVLio4/GEup9/pybCVLeAYNKJW2Xh4lmmI05+8fSPCHKowJKe
         +IFA==
X-Gm-Message-State: ANoB5pntyZ8qMZU1Me9go+OGs981+YrabNlXeB5QOtp/faCRDDlcUzUm
        tgWnlzM0Zp803pcOm1U863NvHl0JuP0=
X-Google-Smtp-Source: AA0mqf438Ax0Gx3eJ8Yc02Ql8cQm7Nwmpy2l44nn3bmazHOxlbAkhmko7Dci6TxbvvkFZFZ9+ziUiQ==
X-Received: by 2002:a05:6214:3504:b0:4c6:2732:d4f7 with SMTP id nk4-20020a056214350400b004c62732d4f7mr14239475qvb.83.1668953845956;
        Sun, 20 Nov 2022 06:17:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s68-20020ae9de47000000b006eed47a1a1esm6246821qkf.134.2022.11.20.06.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 06:17:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 20 Nov 2022 06:17:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (gsc-hwmon) Switch to flexible array to simplify
 code
Message-ID: <20221120141724.GA1790491@roeck-us.net>
References: <61a23e1d642397cfcecc4ac3bb0ab485d257987d.1668936855.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61a23e1d642397cfcecc4ac3bb0ab485d257987d.1668936855.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 10:34:41AM +0100, Christophe JAILLET wrote:
> Using flexible array is more straight forward. It
>   - saves 1 pointer in the 'gsc_hwmon_platform_data' structure
>   - saves an indirection when using this array
>   - saves some LoC and avoids some always spurious pointer arithmetic
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to hwmon-next.

Thanks,
Guenter
