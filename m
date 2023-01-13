Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC60966A14F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjAMR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjAMR6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:58:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449B77A908;
        Fri, 13 Jan 2023 09:51:25 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v23so23124629pju.3;
        Fri, 13 Jan 2023 09:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=du5CbuzD5atms0biyIBc9VheGNqSzzV0KdMTQ42JShU=;
        b=cAcBE7E+Vkqn393UgBfPDsUTqKnVkitg6csPzX3Jal8hLe41CV6LeUEBL8keS27tdJ
         ycoUvMqbGHSbdzLiRSajaYL2CySlPO8fSpKXcqtSG8iGNyH0j96A2ETKjMuhHs85FHpg
         8Wyi6b73mJXgiNsdOEbicsITj7KjS++vUvQo2nM9p84r4GW/gpUksl6g0vyyUdmQqWym
         oM9WzUoLVj/5yaOB3J5q/O1jlrggIx6kNGjojknneX0GUWpP9dQM7wVIQ7FhAeGdJRZM
         DEGGRq8eCQ1D50/TPjNEtBi8QWNAitdbEoHgdnjSekV1ncKtO7+ouI8jZzWsrGRZnJfQ
         udpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=du5CbuzD5atms0biyIBc9VheGNqSzzV0KdMTQ42JShU=;
        b=F/XY3ypQMyAhrqqnfU3oT0b9NUEg1mOpBz9GWOIQ/4Xd+bZS5vNxb2Xm4QgS0IVvKo
         twCay0VUqtr9B8i2ZbZi4m7D3Rma2QqREmUxkptmdZR160nIGbtmX8b4riz5FHhxPpAA
         sHaw1lg5DhNbmGoB7OWwaaMibU7ghi1X34G+X79h4geywSn/KV9mHEEATzVYyjKOJo1D
         qijnxnK4VnqBHFB0AbK0x95niZz27PFiX+0x+AWxSyX1wWXA2O6zOmQZmWGpZoJ2vXS5
         S4EgAGtU3/TNbnwK5yMwRWOzT/T0yqR3HjJeWtzwRIQrvtYgb+C80Wz1ZaU6jBzWik6t
         bcAQ==
X-Gm-Message-State: AFqh2koBIdJ2AUlhmW/KQjKR4+1BakUBOzohO3YvP0u9vQxdySmIikrY
        Wy6pI0U8jhBeKblYfZv8NOPS54Nhf78=
X-Google-Smtp-Source: AMrXdXvRZCoIh+K3Cdn5EMXgHn43VDic0a4r16FTk8O2JUbrj2VvDpG7YzPmz0u7JL5/OVJCGapFbg==
X-Received: by 2002:a17:903:d1:b0:192:7f35:90ed with SMTP id x17-20020a17090300d100b001927f3590edmr10346053plc.11.1673632284578;
        Fri, 13 Jan 2023 09:51:24 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b00189c9f7fac1sm14482455plg.62.2023.01.13.09.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:51:23 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 Jan 2023 07:51:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Fold rebind_worker() within rebind_workers()
Message-ID: <Y8GaGovaq5TkiGSj@slm.duckdns.org>
References: <20230113174040.1344293-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113174040.1344293-1-vschneid@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 05:40:40PM +0000, Valentin Schneider wrote:
> !CONFIG_SMP builds complain about rebind_worker() being unused. Its only
> user, rebind_workers() is indeed only defined for CONFIG_SMP, so just fold
> the two lines back up there.
> 
> Link: http://lore.kernel.org/r/20230113143102.2e94d74f@canb.auug.org.au
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Applied to wq/for-6.3.

Thanks.

-- 
tejun
