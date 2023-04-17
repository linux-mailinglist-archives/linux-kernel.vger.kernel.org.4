Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45F86E439F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDQJZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjDQJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:25:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3231FE5;
        Mon, 17 Apr 2023 02:25:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-2f7db354092so826979f8f.2;
        Mon, 17 Apr 2023 02:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681723525; x=1684315525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ni1mp87nimYzLK0CBqJWgwY5rbZXm5kOnIvLQwtSwI=;
        b=H3fXzv0KaQshT8TnpTyZtf8FLbH/jT+lzC7we60I/atLATOc4t2d9dNZzVQ0vqsQHC
         owug5T9+JsEhklVUcRhDgPkY0135ATRBdybj7XzDjlTj7el+hffwI8/HK7S23T9+kLdn
         coDADO84uSTlzIwBtVsXuv4F42/wkYQSCos2HQ+uELYPvKjU787oGsn5JcT17/S9c4zn
         6g/U5aRyMKEzUHd62ZAznW7r4y4Xk4mwu+7aaoxrDw5UQFHBDoUFBoMQOF/f5BJ5L3/n
         P42Hne/7UgmxdoxlD9kq3R+hQ+sgsijVzH8Qe4kc5ookjLP3C+OR4exLF5ZFfX/yKlES
         MDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681723525; x=1684315525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ni1mp87nimYzLK0CBqJWgwY5rbZXm5kOnIvLQwtSwI=;
        b=PwQdCegMfkmMFzhmxrEh92auynUgd2SmkoNPCUce9xryy6Xd/fB8VDYYL7zp3turN1
         ZkYhEUg5UyslFD3EKgxzJskqvcfklICZAc+WjStvtaT5Ia99fvUEl8TUmGIz9Jt4Qzi6
         PtIqZmMY9pyrm4y0zsCxPu0fefVy3plxY5pqICfRWjbyK626rrRl7/rYavi8vJuTOmkR
         8Sj01sOU9v6YLpokLiBOqo6Poe/iSPDIszpYKlnfVTRI8c6SCRxGG998gJcegE/BBvVf
         WmYBz/QWXJiv0HIkIZXKxx2MPRXw6F2X3F0gw6ArDD0AaSnj5nTcvZiWYRq6tjcy/q/i
         TVTA==
X-Gm-Message-State: AAQBX9fZFT9WuuPXdULJxGMe8XARqIL3pbygF5IFn0w1q0AhdjK0o3RD
        SF5rLgrnooN88+XwZKds7U4=
X-Google-Smtp-Source: AKy350aztd/txuxoD9co8jX4C9jttt92j871FRkhuKE7yFSjcOhyVaf52A6bg/FfSUWsKdNPcM3xCg==
X-Received: by 2002:adf:e3d0:0:b0:2f7:825c:9db6 with SMTP id k16-20020adfe3d0000000b002f7825c9db6mr4580455wrm.45.1681723524883;
        Mon, 17 Apr 2023 02:25:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d4fcc000000b002f22c44e974sm10015438wrw.102.2023.04.17.02.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:25:24 -0700 (PDT)
Date:   Mon, 17 Apr 2023 12:25:21 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>, Vicki Pfau <vi@endrift.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Nate Yocom <nate@yocom.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        John Butler <radon86dev@gmail.com>,
        Matthias Benkmann <matthias.benkmann@gmail.com>,
        Christopher Crockett <chaorace@gmail.com>,
        Santosh De Massari <s.demassari@gmail.com>,
        hust-os-kernel-patches@googlegroups.com,
        syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - fix GPF in xpad_probe
Message-ID: <c3e0823b-2b03-4dab-b7cb-a8bc5151f0b1@kili.mountain>
References: <20230414125603.686123-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414125603.686123-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 08:55:47PM +0800, Dongliang Mu wrote:
> In xpad_probe(), it does not allocate xpad->dev with input_dev type.
> Then, when it invokes dev_warn with 1st argument - &xpad->dev->dev, it
> would trigger GPF.

What is a call tree for this?  Actually I found it from the bug report.
drivers/input/joystick/xpad.c
  2034                  if (error)
  2035                          dev_warn(&xpad->dev->dev,
  2036                                   "unable to receive magic message: %d\n",
  2037                                   error);
  2038          }

> 
> Fix this by allocating xpad->dev, its error handling and cleanup
> operations in the remove function.
> 
> Note that this crash does not have any reproducer, so the patch
> only passes compilation testing.

The xpad->dev = input_dev; already happens in xpad_init_input().  We
shouldn't allocate it twice.  I think the fix is to just use a different
device pointer for the dev_warn().  Why not use &xpad->intf->dev?

> 
> Reported-by: syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com

Could you use a Link tag to link to the bug report?
Link: https://groups.google.com/g/syzkaller-bugs/c/iMhTgpGuIbM

This needs a Fixes tag.

Fixes: db7220c48d8d ("Input: xpad - fix support for some third-party controllers")

regards,
dan carpenter

