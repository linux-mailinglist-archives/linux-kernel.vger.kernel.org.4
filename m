Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF16BE75D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjCQK5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCQK5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:57:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D60E7EDD;
        Fri, 17 Mar 2023 03:57:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h31so2626152pgl.6;
        Fri, 17 Mar 2023 03:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679050649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYzgFOhNj+V5+Y4ZxXOfb+9wTN5oY+/0C9ikK6FfNVo=;
        b=l6CNQAI+Q6uVrXVRcshFtcZ/clOKohTbU4dL8err0xmUiQQUT+Fe6rWqJZRU0gkeMb
         RUKrtNmRjms9wf8rsEXBLgcKvv/RfS2aYNLfvot/f4HdtOgICy3S6cGfvoqzE/cRFbO6
         +WULldNGM1gl5iegG+LUYpg7cIBylTzOZzqPc7NBy55Ld9ZS+cDrFOpHB6QDhJtBoXr+
         u9ewf86gAcJ8GcVuB1O3nT6HJ36qLNq3vNXxLscQx17Ypuj/AIJe7zD/R2Ykr7F2vZ3/
         4OiGsb1Ybu5+GlS4P2Vd/Pl22yrPIzhQbs1+A7cAUmnvUNk5H1nvvH6M5zasV0NN2Jho
         YWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679050649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYzgFOhNj+V5+Y4ZxXOfb+9wTN5oY+/0C9ikK6FfNVo=;
        b=MPXPCrZj5xpHiCLtJHfE903vfkdHwduPOL7t747r6QtON7KDLSFYBseLCSgvyqPD1F
         FkDlPM24G8CIVf23RonnRIVZTyOLcQsrEpPUMV7oSFmqb/jcDqOd4zUiwa/Gb1MEstrh
         SAw1TjruwiG+LbTNqBBDsOS8PkGa4fLakLOYuyK1/8DtU5Hf93kMUp2x+II1vCpHv91s
         Izwi2EdN4RI+cRfymfCqNg3vRUIM7DUF8596Hceid1R9o3sD68owHEfoqyWT2Ojpz7Gs
         sF7QMXfazlqNBaC8JgAop/RXhic3CneuPBz/2oLas4FMDEyGPSNRt3WL68i1f/sdaPPY
         wVuw==
X-Gm-Message-State: AO0yUKVIVQN+Prmz6rf3XLUy/WN9l4J29prcr75vZfRK1TLyxJVc2xM1
        PMuoRcoIG4iQ6T48SaLBKnsgYYxnCwFyUQ==
X-Google-Smtp-Source: AK7set80YyuatQ0/fvp4+mQZPlSXfrwZ/W+mQ93Nh9A2V1z/XQcbJZYfnJR0hoYuia5bp79ss/5uEA==
X-Received: by 2002:aa7:99cb:0:b0:5a8:a420:72f7 with SMTP id v11-20020aa799cb000000b005a8a42072f7mr6046315pfi.7.1679050649166;
        Fri, 17 Mar 2023 03:57:29 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d084:8252:e846:af61])
        by smtp.gmail.com with ESMTPSA id x13-20020a62fb0d000000b0061a6f4c1b2bsm1324406pfm.171.2023.03.17.03.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 03:57:28 -0700 (PDT)
Date:   Fri, 17 Mar 2023 03:57:25 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] Input: hideep: clean up some inconsistent indenting
Message-ID: <ZBRHlb6aQpnTa+TL@google.com>
References: <20220429070103.4747-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429070103.4747-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 03:01:03PM +0800, Yang Li wrote:
> Turn the space into a tab to Eliminate the follow smatch warning:
> drivers/input/touchscreen/hideep.c:470 hideep_program_nvm() warn:
> inconsistent indenting
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied, thank you.

-- 
Dmitry
