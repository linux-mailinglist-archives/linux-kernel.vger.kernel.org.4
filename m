Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029B96FFDA6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbjELAHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjELAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:07:06 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80401FEB;
        Thu, 11 May 2023 17:07:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso4922445b3a.1;
        Thu, 11 May 2023 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683850025; x=1686442025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PG0+Bzo22Jh4OYNF4Qr9XFzl3Ib185ws1dA1AyL1Uu4=;
        b=FJwY5DxV06rZ0pSUm5egBIYlJp9DAgl5dbwhn4T3x85LW+e3JtlkOGYTPLKl2CI4IX
         iXPuLWOZpObrTGJJTOiNlfvjewn61AQJxXxyiI1OBj9PE1PZQhAEssLkF4ayO3d0g1M3
         Z3d4C9x9nok6lH/kj+2eD26xc5whfmpnI8jHETsj967VQvrD4FVfdZYXlyGF3X9/aiiH
         lZk0oUe/Kc9bPV/3veBYsFcwTzfogC7n0B+Ovci2l5kohGSPT+gFUmTYL1Bh+RrXxcxY
         FFCxyFP3gFAgc8ZA/9LUi68RfDHlyyE5C1QrehAA7WkmvF7ZDX5YeEV6V/nYM4bEPUPR
         wHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683850025; x=1686442025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG0+Bzo22Jh4OYNF4Qr9XFzl3Ib185ws1dA1AyL1Uu4=;
        b=IBl3CSGYTmLwEwWoDQ657BVUjSmVNfs/LOP/hVixjVGJOl/HYmgC3e6GDvq1w81pQ6
         eHrSf2P3A45xYdnHHb5otd4djfFJOq6KiqhZO2xq5MKbG5yqNbze0joaz9LXtIQ4CbU6
         1qyMjjFxRJ4YkRYBsV0wVEC7h3qgMBCU8oWVaMiXgJiVRv24y1hqmAglddmeSlp20WVl
         LDuziF4d7+gvksnA0tqcJab3Jnwgow+8lV0J2CSsaBLHz6PQ2qqBC14zzSSfCbgypije
         rGZlWHFvI0ntzNrzW1/dZHuG8ULlm38WCPB+EcMGx9BWanDieGfUlYP2kE6jQnqVLLgg
         S7gA==
X-Gm-Message-State: AC+VfDyzrxcqXcGi3JlkorLaQTX5WXJQ7FuUZhsbb+ofsoWhg+X5YxaI
        3UpFQP+Gq/tYN5q5cem5dCFvtXdZbhg=
X-Google-Smtp-Source: ACHHUZ6OQfxUL2zoRQq1f7F62pIg97SbQ2BezVCfIKv6f3G4GMQ82CqTxgpYl+RPWboL4mQXiykyTQ==
X-Received: by 2002:a05:6a00:14d0:b0:63d:2f13:1f3 with SMTP id w16-20020a056a0014d000b0063d2f1301f3mr31387078pfu.33.1683850025053;
        Thu, 11 May 2023 17:07:05 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:53f7:c9da:338e:6206])
        by smtp.gmail.com with ESMTPSA id d9-20020aa78149000000b0063b6451cd01sm5869138pfn.121.2023.05.11.17.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:07:04 -0700 (PDT)
Date:   Thu, 11 May 2023 17:07:01 -0700
From:   'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
To:     "Jingle.Wu" <jingle.wu@emc.com.tw>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        phoenix@emc.com.tw, josh.chen@emc.com.tw, dave.wang@emc.com.tw
Subject: Re: [PATCH] Input: elan_i2c - Implement inhibit/uninhibit functions.
Message-ID: <ZF2DJVZ0KgXmhoZi@google.com>
References: <20230320011456.986321-1-jingle.wu@emc.com.tw>
 <ZDBKwo4UMUm+TSnj@penguin>
 <000001d96b4b$6b30cda0$419268e0$@emc.com.tw>
 <ZEmsc0HyZuXlJARq@google.com>
 <000b01d97978$32775ca0$976615e0$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01d97978$32775ca0$976615e0$@emc.com.tw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingle,

On Fri, Apr 28, 2023 at 10:21:53AM +0800, Jingle.Wu wrote:
> Hi Dmitry:
> 	During the initial process and when the users open/close device,
> having the elan uninhibit/inhibit commands (low power mode) was not what
> Elan expects to happen. Due to that touchpad would do the calibration in
> uninhibit moment , we don't want the calibration to be affected by fingers
> on the touchpad.
> 	However, the LID inhibit/uninhibit functions in the Linux kernel
> driver calls open/close(), so we need to separate the inhibit/uninhibit
> behavior from open/close() function
> 	
> https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1783
> 	
> https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1813

You quite intentionally can not separate inhibit/uninhibit from open and
close. As with open/close nothing stops inhibit/uninhibit to be called
rapidly multiple times in a row. You probably rely on particular
operation of ChromeOS devices during normal user interaction.

As far as I remember, you need to perform recalibration on certain
devices when LID gets open. I recommend you implement something similar
to https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3578852
where we monitor LID events and recalibrate when needed, instead of
trying to make assumptions on when inhibit and uninhibit functions are
called.

Thanks.

-- 
Dmitry
