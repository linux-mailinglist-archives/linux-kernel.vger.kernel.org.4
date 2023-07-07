Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7272F74A7FD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjGGAKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGGAKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:10:20 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD8919A5;
        Thu,  6 Jul 2023 17:10:19 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b3f281c4e1so1310015fac.3;
        Thu, 06 Jul 2023 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688688618; x=1691280618;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ/b7E/Eh4nowMWl8PSAsvQtiy/LoU/GQYU3Xwct544=;
        b=JJmZToypqZzTtO/blXqEWK10w3yc7b2ehHkB2kHousQTH84aVUdfS6QaoxW0+rIlLC
         2UaulKOXvoiw2i2CHwQd6Hthsk6zNwaaqBK5UGPg8doG9IBoR40LeAxecgz/BL1cfpjh
         QAqbkDOKSv6rCbns5FfnD9+GJKLKbRwpuITNGSbo0qnGc7SFrvjboxgzmdr/PxH/01Dj
         L9e15hSNLWBq6THL0NdLub+OXldAavgXql3GJgQkBlO4vHuUV06D4duRlEJn3Ygr6RDD
         JkYwRZZHaRkTcPAqpbzXzJbOWXCxPz/AQsy2vTl9ARW8EbQDfFr0M6M7SkMs+89k5c2L
         bmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688688618; x=1691280618;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yZ/b7E/Eh4nowMWl8PSAsvQtiy/LoU/GQYU3Xwct544=;
        b=AUMhPL6Z3TuQcdf2dY4IUybfFzuKd60oAq0yxESbChQXpIo1vGCa+hUO/zSL/mReaj
         Nzp7IdMy8XeXB4WsQbBVwC3g4x2sD3GNJB4J+DQAjXPMxP/bgFAgMlwqsH65Z7WnDPjH
         N7QttXUSf1luIY/7sAoBkfu8Ojmw8Vq3yashuF1KHQQfhEvOJQiKSJ2JExz/d+NN8l+L
         rmLKhT3fPEfN44uQxedrhnVfBNR+kWjUepHHiYYzt1LjgWVR/9UqMhWaLPOapN7f9A4d
         ESMzfl/pq7yD5fm0WnxYWpd1H9JMO6emYHQ6LNqwdqfi8SkZv7it3V76NPU8Rv/E3Td7
         94Rg==
X-Gm-Message-State: ABy/qLbLCjcy9a4/3ZpifmZ4LxgUEU1nIz6lfjyR1/Xt2rxpNlAw3KAg
        CDguA5jsk++WHJs/37wo6a4cY5gA9XQa9lED
X-Google-Smtp-Source: APBJJlHUXiOJ5FpbxwvaZwaSGcRELso1WXOC5qxHGKmWyzvWwBJL4NkcPa4GCMG5mk6IByuv3LhTyQ==
X-Received: by 2002:a05:6870:e0d3:b0:1b0:2d25:f5a8 with SMTP id a19-20020a056870e0d300b001b02d25f5a8mr4329563oab.1.1688688618059;
        Thu, 06 Jul 2023 17:10:18 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a004b00b0026309d57724sm350443pjb.39.2023.07.06.17.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 17:10:17 -0700 (PDT)
Message-ID: <5eb57bfe-94a4-136b-497e-deeb31846db1@gmail.com>
Date:   Fri, 7 Jul 2023 07:10:13 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        primalmotion <primalmotion@pm.me>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: unable to boot when monitor is attached
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> 
> In the latest 6.3 and 6.4, it is impossible for me to boot my laptop if my DELL U2720Q monitor is plugged in (USB-C). I have to unplug it, then boot. As soon as the first second of boot went through, I can plug in my monitor and there is no issue afterward. There is no issue waking up after suspend. Only when it boots.
> 
> See the attached pictures of the trace. The trace itself seems random (at least to me :)). I tried several things, like removing any attached USB devices from the monitor built-in USB-hub, but that does not change anything. (there is a keyboard and trackpad attached).

See Bugzilla for the full thread.

Unfortunately, the reporter can only provide photos of kernel trace
(as he doesn't have any other means to extract kernel logs, maybe
connecting over serial helps; see Bugzilla for these attachments).

Anyway, I'm adding it to regzbot so that it doesn't fall through
cracks unnoticed:

#regzbot introduced: v6.1..v6.3 https://bugzilla.kernel.org/show_bug.cgi?id=217637
#regzbot title: unable to boot with Dell U2720Q monitor attached

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217637

-- 
An old man doll... just what I always wanted! - Clara
