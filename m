Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2426D26D9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjCaRlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCaRlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:41:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0234526A1;
        Fri, 31 Mar 2023 10:41:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so14356279wms.2;
        Fri, 31 Mar 2023 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680284507; x=1682876507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TUFI6ZoGE4D187Ap/hu2CM+/bIVRPAdjBlB5u8XKpoU=;
        b=Nc4w6ho1+jaEzklG+v1DR+ZtPdgQ+sspeGCsWYeGHYu7FatKyYBE3y4Eag0671yAUJ
         68C/StEWqmyLZ61YT+WMq+POMv8sF7Wk8mahES/8Y/Ki3DhiAmBYS1zP5EEHbogQzEae
         ESGil93FPnAJekgtdjynHHotqzC5ifPZeh0RKTEgB5R2h03OsghkBoDFVbBHC1XkXakc
         r74zLbMERsbGAZ/cYegyilL9k9SEQYZqLmJm8Gj2xuhc9A7a+o0a7wonIIL+fapnDS5h
         9Tw8+u92AZUGywV02QRVvqsKUstuALWCrd76J+BJrgyhyWbR7x3jRgrq6qAWY2zYAcom
         xvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680284507; x=1682876507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUFI6ZoGE4D187Ap/hu2CM+/bIVRPAdjBlB5u8XKpoU=;
        b=hUUfF0/oMZPmHs+5fMt73dEmnh6VmwPWF2OFpiBKhxD5+UawISs3gl3JuEdkHWBixD
         ui7QTwQq3XEHe7aWSYKS5X+Qetw1nntA/J/7WW3iEUGGYnz0sVLBEv9y3DY3s3oeCtUx
         DgHkGIxh4y52OFuqzE+FB8vFnHs0s4JjZkC88UMjudrpAKud6d7attU9fQwNbSzsi1qw
         KOSriH7JKzGXFT4VS5yQF43Fo8fube1WauuIP7FBwssVyCoqSGtxVsWYE8JSUgp0wuCQ
         EiGjvUGQQUJ4MdM/7oCv9QE/hXY0y+0m0ehjOLqF0w5JEc0O2csoQm6d5QR3t5vN23oI
         70FA==
X-Gm-Message-State: AO0yUKWcZVKuqVmSZuGlcF6DKK339yHBeYgQoDPcFGBiflgj1r8CTXLB
        7wXQZF0ZD8fSRt+DQOYHI8U=
X-Google-Smtp-Source: AK7set92qv+teOITBOEx9uF6SszoxcM+lcGrEtC0OEqi7nrHYiddCx4h0uS27vnXLQ4FkFd7JEu0pQ==
X-Received: by 2002:a7b:cd87:0:b0:3ee:4bd1:39ca with SMTP id y7-20020a7bcd87000000b003ee4bd139camr21021728wmj.13.1680284507379;
        Fri, 31 Mar 2023 10:41:47 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id u15-20020adfed4f000000b002cea299a575sm2689663wro.101.2023.03.31.10.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:41:46 -0700 (PDT)
Date:   Fri, 31 Mar 2023 18:41:46 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: Use common of_get_cpu_node() instead of
 open-coding
Message-ID: <ZCcbWnwQVHRFyBwD@antec>
References: <20230327182816.233818-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327182816.233818-1-robh@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:28:16PM -0500, Rob Herring wrote:
> The common of_get_cpu_node() is equivalent to setup_find_cpu_node(), so
> use it instead.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks,

I will queue this.

-Stafford
