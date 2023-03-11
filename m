Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7406B583B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 05:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCKEmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 23:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCKEmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 23:42:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7528123CC8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 20:42:07 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p26so4658948wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 20:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678509726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4YQ71uLbPQ+0NSiHPqb24cst2BHjUEN6kSJWZmwaWJo=;
        b=Bq8b7mTIFzwHOwPOde1GyJishXztXmfsitoRQ3lhua+7pQ9xoFSHPP85xUHQs4cx7A
         hiOt3Z2HxMZEwFUne6RQi8y6F70kb69ZDmsH+EonYYVcKKvsczTPmM1aXa7PMLqj2SMo
         U6tBXi3xwJ69RyWDcNSYUy310EOc/cp8RdBc44Mjkg5O7pbgmFkw5KX/SpocBQwwYNcc
         wU5oKYU6OWseS5GFapKxK6HBd8jI0xkk1iZeJwE7EXDJC17s2sn0AIPJtMfEbnR0qwA2
         ugZDXT/7Tk7irL1CEAyT+uHIzDiWNp77x3nrcoq6N3oaAJxoiMYfuw4WXzt+Njre0+/l
         o+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678509726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YQ71uLbPQ+0NSiHPqb24cst2BHjUEN6kSJWZmwaWJo=;
        b=NG2k3sVzpZpdC6GhePSguz78vz1AhrqpA/O9A4EPhuC56iVH2uFO2alZHbcznSjpLC
         Y27HEj1AzLXIaRxCI6JFv2kbjCgA76iJ9lNkf1XRkXyPOIqc+asHKPYS+mUD7C5ngfCz
         WzrEDk9xFvyQ8+0/b278dV522rpjoQEQ3WcENosyS6O6oJPNvP0XFOuuIrNhVK15/sy+
         UGZUp8L8PGRzzREK5nyu/JtkZ+SEwAcamNyM9WgFilhznnVGz9eR6tRsVPCXaPwN76zY
         02++5zihTh8cqyAxqmmWYOZcTFgsIu4fXo1hgbrZXIbHeYgoVTEFZgNotwY/rp0IQ2Fx
         VBIw==
X-Gm-Message-State: AO0yUKXJlJ012ZN3Y6WB5ryhzBx1590IyBbMFl+RXCK8HXlRHn89q41M
        8Unrs78X7I/86UIFDSurWvY=
X-Google-Smtp-Source: AK7set+8ZlNuTVV28ZK4blflxk3xqYb8clby4Wi5OWnXuV1LVCofgaa6vYSpcPg0wHG8AFB5IfmBhA==
X-Received: by 2002:a05:600c:3585:b0:3eb:2b88:5af1 with SMTP id p5-20020a05600c358500b003eb2b885af1mr4727616wmq.18.1678509726074;
        Fri, 10 Mar 2023 20:42:06 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k26-20020a05600c1c9a00b003dfe549da4fsm1798671wms.18.2023.03.10.20.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 20:42:05 -0800 (PST)
Date:   Sat, 11 Mar 2023 07:42:01 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Kloudifold <cloudifold.3125@gmail.com>
Cc:     teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750: Rename camel case functions
Message-ID: <ba534c24-83ed-460d-984d-e915e090aff6@kili.mountain>
References: <ZAvk8SGjwdYlHEU6@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAvk8SGjwdYlHEU6@CloudiRingWorld>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 10:18:25AM +0800, Kloudifold wrote:
> This patch fixes the "CHECK: Avoid CamelCase" reported by
> checkpatch.pl by renaming camel case functions in
> sm750_cursor.c and sm750_cursor.h.
> Modified calls to functions declared in sm750_cursor.h in sm750.c.
> 
> Fixed issue in [PATCH] staging: sm750: Rename camel case functions in sm750_cursor.*
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
> 
> Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
> ---

No, you're going to need to resend a v2 patch.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Please slow down.  It's explained in my blog, but you should not send
any more patches until tomorrow.  It gives people more time to respond
to the original patch.  Also if you wait until tomorrow everyone will
assume you are testing everything overnight.

regards,
dan carpenter

