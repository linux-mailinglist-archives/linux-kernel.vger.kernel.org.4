Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2275E8BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiIXLBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiIXLBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:01:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF6D923D0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:01:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l65so2358777pfl.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JK3ww3GzL9eXDZpo76I+2PZVtTjJduXh3wpZm8Je374=;
        b=g7oP4a6EV9WCpuO2ZFAWTrmUEORgS8kFRMsNLcMRQctE3pIo/Bs2nx4BTfaWleQteV
         CCGOEAQSjbeIGLv1bkXrJ288dhNbJpUXx+CtLBYsKlQkhwD/THTGMs7NJZ6GGLSTHrPQ
         oVl7062wepBLgzNYtwfpY1whHWHbFMEvab/BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JK3ww3GzL9eXDZpo76I+2PZVtTjJduXh3wpZm8Je374=;
        b=6ICAVWwSRxbUG4kXmEmN1eg7sXwb1Cebrsa1Em/thIZm4vGxybtlt+7hvWO6qL1+xH
         qnm0XXNN8foN+d4gCGs+J8uyQYkzvS5KfZbkT4eMMtIfZ4hWs+GdK5IAAoArP5PCXywD
         8pdkcfg0lyieHVxxFXaR9I4qizAhtO7hrYhoMk23rKk/qGrdA8HUJG3teupZl9XOZLLx
         IjwtjyWXkZW31rcS0Xc9RMBxt70cKeddkf+XFy0bXZ9cmWOSPmFeNriElwcO+xxHfmpM
         /viaFcBCYLt8G3nJjlqOgvBBSWLJ1Ps2pfM81nfMxoGTENiIvYwQbb/zUurmYkyCtgrL
         hhUA==
X-Gm-Message-State: ACrzQf2AUBWd3eMUiMZKmi7FXvwVA4zyK8GkQy54OPjl4zjojpVyfMaa
        WwM0qHpjtdWsNOQ0EbVclfY58Q==
X-Google-Smtp-Source: AMsMyM6QC2yyWwgagrJIYjOw5h2bpzQmgqRwCl0886M3ZuSb9eOOdlyR6drPCuU6jiBb3hELo1Xu4A==
X-Received: by 2002:a05:6a00:a05:b0:534:b1ad:cfac with SMTP id p5-20020a056a000a0500b00534b1adcfacmr13438549pfh.35.1664017265421;
        Sat, 24 Sep 2022 04:01:05 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f4de:2419:efa3:8fed])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902e5cc00b00176cdd80148sm7593802plf.305.2022.09.24.04.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 04:01:04 -0700 (PDT)
Date:   Sat, 24 Sep 2022 20:01:00 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 13/18] printk: Move buffer size defines
Message-ID: <Yy7jbEZjbZPKCi8F@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-14-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-14-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/24 02:10), John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Move the buffer size defines to console.h in preparation of adding a buffer
> structure.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
