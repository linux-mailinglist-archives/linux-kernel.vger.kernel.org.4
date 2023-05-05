Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3376C6F843C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjEENk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjEENkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:40:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B54203F9
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:40:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so1220039f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1683294021; x=1685886021;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4FanM4o2uM5el5CxuMhWsVKBSn5kagBvJULfEwuOnuQ=;
        b=YLbCpjzK6cMNG74LCoKCtdGlOP2jnpt1wMFGhzesPsF4VXoaHVhGGJYCbTZIIr7ZWK
         BWELmOv2DZ+FvVC+tF5YJnncwBFB0yiLD5AALWHY+GiIeHx0Vmp1AY5zfSygfaP4nPhw
         zY9Riyo6J224ooL5tZye7BXLtAkIys0BjMQauhWjLjMqQKB8mkr3P3neHc8N4sFQWuIv
         hbtyoWcvla5onI5lDFcKGCQbzFbozblPUB9PAlFum6yVf34N1OBd1YUzaeflrCVfPw7y
         BvPO/+u54OQmZ6HCBDlOsjDaNMo2pQsp2HA+mUHKA6LdD5vRHffvhQLE2/xwhVfkb770
         aLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683294021; x=1685886021;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FanM4o2uM5el5CxuMhWsVKBSn5kagBvJULfEwuOnuQ=;
        b=Cat3k9TbkUnmGbHiQ5YH6t541H70ZMSZstPb+t6y17xTXclHwe26sPae5gM0FsYq5y
         klmdaBLnCLKSrbAWkwIWK0yU7UNdsUAh5fPOk+9+k3m4yI6V4DQOlUe16nrB5uP0yNcY
         RO4wKR+e2GJq285W1iVadgGTN5kWsBSVfIrBE8AxzSI7jLYFPlVClV5D15pktONgFiL6
         lc9vI9JggvZAX9nm5VVnMwOzF8T3DwHfjC6mb0/Spb5Gd0d5FJyY+udBKQQoVuJNueDt
         MZfFlwN1uw7n0ONbH40X573VKgErWsLcLHv828OxGGPLLYZ0wyFlWbMWOc7yjrlv8BiP
         W4ew==
X-Gm-Message-State: AC+VfDw3pLiddP0YIxKpOqZ+YEwNR4Mg9pPTDRYSRpoz23iDFICfP42C
        YW333sdnTwwULP38CAic+A8crg==
X-Google-Smtp-Source: ACHHUZ62LZNSsbbUj8sflnqDnuLqmKSa82SkcfQwmRmvAg6tsGvVlu6r5IUFVab9hGl4E38Wg7x8UQ==
X-Received: by 2002:adf:dbc2:0:b0:306:3814:e323 with SMTP id e2-20020adfdbc2000000b003063814e323mr1303552wrj.56.1683294021330;
        Fri, 05 May 2023 06:40:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:91e:3457:e7c8:8f10? ([2a01:e0a:b41:c160:91e:3457:e7c8:8f10])
        by smtp.gmail.com with ESMTPSA id y15-20020adfe6cf000000b0030633152664sm2431032wrm.87.2023.05.05.06.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 06:40:19 -0700 (PDT)
Message-ID: <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
Date:   Fri, 5 May 2023 15:40:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20230202232517.8695-9-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/02/2023 à 00:25, Mike Christie a écrit :
> For vhost workers we use the kthread API which inherit's its values from
> and checks against the kthreadd thread. This results in the wrong RLIMITs
> being checked, so while tools like libvirt try to control the number of
> threads based on the nproc rlimit setting we can end up creating more
> threads than the user wanted.
> 
> This patch has us use the vhost_task helpers which will inherit its
> values/checks from the thread that owns the device similar to if we did
> a clone in userspace. The vhost threads will now be counted in the nproc
> rlimits. And we get features like cgroups and mm sharing automatically,
> so we can remove those calls.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

I have a question about (a side effect of?) this patch. The output of the 'ps'
command has changed. Here is an example:

Before:
$ ps
    PID TTY          TIME CMD
    598 ttyS0    00:00:00 login
    640 ttyS0    00:00:00 bash
   8880 ttyS0    00:00:06 example:2
   9389 ttyS0    00:00:00 ps
$ ps a
    PID TTY      STAT   TIME COMMAND
    598 ttyS0    Ss     0:00 /bin/login -p --
    602 tty1     Ss+    0:00 /sbin/agetty -o -p -- \u --noclear tty1 linux
    640 ttyS0    S      0:00 /bin/bash -li
   8880 ttyS0    SLl    0:10 /usr/bin/example
   9396 ttyS0    R+     0:00 ps a
$ pgrep -f example
8880

After:
$ ps
    PID TTY          TIME CMD
    538 ttyS0    00:00:00 login
    574 ttyS0    00:00:00 bash
   8275 ttyS0    00:03:28 example:2
   8285 ttyS0    00:00:00 vhost-8275
   8295 ttyS0    00:00:00 vhost-8275
   8299 ttyS0    00:00:00 vhost-8275
   9054 ttyS0    00:00:00 ps
$ ps a
    PID TTY      STAT   TIME COMMAND
    538 ttyS0    Ss     0:00 /bin/login -p --
    540 tty1     Ss+    0:00 /sbin/agetty -o -p -- \u --noclear tty1 linux
    574 ttyS0    S      0:00 /bin/bash -li
   8275 ttyS0    SLl    3:28 /usr/bin/example
   8285 ttyS0    SL     0:00 /usr/bin/example
   8295 ttyS0    SL     0:00 /usr/bin/example
   8299 ttyS0    SL     0:00 /usr/bin/example
   9055 ttyS0    R+     0:00 ps a
$ pgrep -f example
8275
8285
8295
8299

Is this an intended behavior?
This breaks some of our scripts.


Regards,
Nicolas
