Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23BD5FBDD6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJKWVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJKWUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:20:49 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEFFA6C14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:20:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fw14so13682847pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CsnM9u/lLdimA3vKzzsOcLQ3M1ATdHwDz5zxOEZu19M=;
        b=irqSnR0KdOr2iWj0vUE5Q3Ie15C8FSp/JUvWisbhs4kSXQycixw5Nwl+HJvfxByVb/
         2D10Zg3J3+LtszagLUjYrp+RLp9/+yeJwwZfTofqtIh/AiQL4Sm3W6n+BdIeF0qA+t3t
         GNyaWS/ejl/Q7QnhltsT5zt5m9gtCYqFm6NYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsnM9u/lLdimA3vKzzsOcLQ3M1ATdHwDz5zxOEZu19M=;
        b=G01oYh0aEYEFKWxhKu4yYgOIDaVFwCjJ7CadeKhaa60k0+2yXkAkmMIWrtVUtXgPCh
         xFi8BP5m7z02jKBR1y2u6hDDcHTQkUhmDXxmY/uaJIJeVMdTbhecH9b3RhuYOwhc5EeH
         vZ7A0pXxucAWhLNQQTrunW/GhusMKeQaUA4PAusvCzaAA7xi6dw5iVox5f0e6cyxW8Jm
         j3Fj9tq9GeKgHdGBidiQXcsgt3Qp+F6IUuN6euSBfB8sbD2WnHx5jarMBgq7bl1nZEbQ
         x8XWQ4vQtbktT2z+ETXHlUkXHvbJuQXAPZ/vCnBReIO11/o14DBpwBz4P/5i/u8OL0Rq
         LZrQ==
X-Gm-Message-State: ACrzQf0VNdEiVDi1NSquUBt2CE2HCYqiUIMZBsQ53FiQ2kpO+BuUzOsl
        2ggKdWmJNQ7JG2sOT3PQiSpO9w==
X-Google-Smtp-Source: AMsMyM6n8SCa79y1BKbuXkDGf8q1rDmrilNuIkKNflNqhcb0sni0xsx2n0F9KzWeVDQMHfSgaI4n3w==
X-Received: by 2002:a17:903:284:b0:178:2a94:9b6a with SMTP id j4-20020a170903028400b001782a949b6amr27023176plr.135.1665526813206;
        Tue, 11 Oct 2022 15:20:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b0017f7c4e260fsm9134108plk.150.2022.10.11.15.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:20:12 -0700 (PDT)
Date:   Tue, 11 Oct 2022 15:20:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-hardening@vger.kernel.org,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] MAINTAINERS: Update pstore maintainers
Message-ID: <202210111518.A626065@keescook>
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-6-keescook@chromium.org>
 <b06cdd10-3372-0613-6719-21c2fc664d05@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06cdd10-3372-0613-6719-21c2fc664d05@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 05:35:48PM -0300, Guilherme G. Piccoli wrote:
> On 11/10/2022 17:01, Kees Cook wrote:
> > +L:	linux-hardening@vger.kernel.org
> 
> Just curious, why linux-hardening was the picked list?

It's where the bulk of other things I work on end up living, and there's
an active patchwork instance, so it'll do patch lifetime tracking for
us:
https://patchwork.kernel.org/project/linux-hardening/list/

-- 
Kees Cook
