Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807A5677A80
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjAWMEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjAWMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:04:47 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A623878;
        Mon, 23 Jan 2023 04:04:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d2so10557370wrp.8;
        Mon, 23 Jan 2023 04:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fISD/Oh7f7rfwyoXhffv2IBzPjVxst2oLjHNZ3zqbvY=;
        b=bsFNkkE+AmRGZwOFLU6vo4nHH5vaJSggAKfQcACTiS5z2nThSUcvIrBIT1uyFfegFC
         WPH0TXiUX8QgReBUgV9DiVo82Xz4GyOh9UxFUEIqqXOM1U+dw/yqsrLdsWUJ3D2tlT7P
         JgU5ITbcs7zgJntXJ1dXmlInsCvq7C1hOOzxmGrUspNtr5IM7enrSCIPpbALknQ9I67n
         e1IZ68nh/VCpH6N9f6CE9ZCh/VWEX/0W46FxEWy1/a3vGAFJ30sW3Um5AAHx8+FXNsGd
         03p1Yq2K9fBIJLeLPcs8Mq3Mn/SIPS14UQRQQnTJDEb4/GGEm730ShDYvHNMsEr/Kq5a
         4xIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fISD/Oh7f7rfwyoXhffv2IBzPjVxst2oLjHNZ3zqbvY=;
        b=rfo9J5mvS8vqSu/PzLm3hh9uE6vyCwtbke0aK3U0L/bgV4bqPRzf+zK4qnpk+Gru1M
         89ch/zBwjFOFe0UyzAqfwSmYlusqA7YdVfT0MoJLrzKbIkvCNgepl3tyO8DK7wtxdlYL
         xbmIDTm0+Ym49AzOZTQPfMs6WQ773RwGBWKJRuhpXe3OeNKCXH1Hex5XSgSDAiXwg1Xm
         xXj52JHe1E5SyM7Rh4BYZi3T4UsGXeD/7S7Pwyp/KvDgjraEDHzDFcAL5bHMKLsx/6h/
         QQlUuTCQTmryVbV5Zx2B86LqsEsqwpF6vsp0gCE5QVyd4pXxi3sMzWE5o+CIzKqPpHFP
         +iBg==
X-Gm-Message-State: AFqh2kpB3CIPfBNwFhWKNzJ+z/sIP4bJi3aJTdpHi1IFCrxImKlYLQnF
        eFE0A5XsU4albbmWvor2VDksVMZHdljNxw==
X-Google-Smtp-Source: AMrXdXtz9NS77O/I/Wca40ouoJ07XrkjM28zIcnW0OPop/rjoLw++G0AKR7A6dFxTiVx9ZULIg7VbQ==
X-Received: by 2002:a5d:4528:0:b0:2bd:f155:a8b0 with SMTP id j8-20020a5d4528000000b002bdf155a8b0mr22056318wra.51.1674475486618;
        Mon, 23 Jan 2023 04:04:46 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b002be505ab59asm8607749wrb.97.2023.01.23.04.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 04:04:45 -0800 (PST)
Date:   Mon, 23 Jan 2023 15:04:41 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     andy.shevchenko@gmail.com, andy@kernel.org, colin.i.king@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org,
        sakari.ailus@linux.intel.com
Subject: Re: [PATCH v3] media: atomisp: pci: sh_css: Inline single invocation
 of macro STATS_ENABLED()
Message-ID: <Y8532S313qKhIme8@kadam>
References: <Y8lZreSphK6DIkJg@kadam>
 <20230120171408.16099-1-bpappas@pappasbrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120171408.16099-1-bpappas@pappasbrent.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 12:14:08PM -0500, Brent Pappas wrote:
> Inline the single invocation of the macro STATS_ENABLED().
> The macro abstraction is not necessary because the logic behind it is only
> used once.
> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> ---
> Changelog:
> V1 -> V2: Inline macro instead of replacing it with a function.
> 
> V2 -> V3: Remove unnecessary check that stage is non-null.
> 

Thanks!

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

