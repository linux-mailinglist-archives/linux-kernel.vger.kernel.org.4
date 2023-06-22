Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD50373966A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjFVE3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjFVE3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:29:00 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A32FE7E;
        Wed, 21 Jun 2023 21:28:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-543ae6ce8d1so5322543a12.2;
        Wed, 21 Jun 2023 21:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687408138; x=1690000138;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OK+CXuyFLwF44/27I2as5mqeWxwcMg3WlGZonvd6nV8=;
        b=dNVx5yrY4KXXoJs8JhWWjAXhtEzg4NDMHTx+5nrRRMVRfRcs80NPvNdVi74BL84Fyu
         OcmdhgjKLsW0tq3RH1ohPk3iTOkMq/tPRs3EK/oyuddmncwO0ByNSIsJtnOu+UNQRI2I
         lKGr8VSTyD3va6S5APUyLLC5tIGhzGUYjw9DUjyYaqjoF9xukBi5XDIQgQQoCn+GOIwL
         EYKfAr84RzMTOIrZ6dZmQUn6Ypk3LuKycSoPurmh9qDFAxuFEZwwGNcQwgGbbxTgXefv
         m7+2WCjrJMVz+L9TDdXt8/cJShXYc7WpYsta4Tdz8uaK62azgBM9w/jGj3dT9dpXgv0r
         m78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687408138; x=1690000138;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OK+CXuyFLwF44/27I2as5mqeWxwcMg3WlGZonvd6nV8=;
        b=mD7AMcG/pE5nLepdo9mMFMczjwIDX1F4ogKHJWRZMss/slY3L9i41uemtVD0l12lL8
         P194BSrQM6QAwL5jckHw85dtdKMuO56ae2uYbVAJxJ6axhJiS85OsVPxRU2ihYzfPiMU
         Ac2MVc5X/5W7dSEtFfDkdgpqL4goD+asp/af2glPdA9fCU31JRWWZP+FNXX4ls9q+TwD
         GBauLiaQY1oic4VsnRsEAuZr3Ls1T5UdP6WHux069XvM0bLPeE9mejSlzcqb6ir50fLB
         ZxqlE8jVyJHKlwW8CmLjexPbmjGK4muwoZd4Gsr+7MVkG7GcDfE9iPS89jBfDW8zbNM3
         gVvA==
X-Gm-Message-State: AC+VfDw8u/b+2raml37IEnbZ0mCecvfw3wlNguSYzaWSpx8i+kQkMnEN
        MBv8sWuCeeTZtROCIJR7PFsZbC9GUIM=
X-Google-Smtp-Source: ACHHUZ4+ZMoJr7SnY11jKCs2czSTRYO57d2qFyw6J6x2UuheAlVyskFDDBj2KxGUrXVcomI0QhCtBA==
X-Received: by 2002:a05:6a20:3d92:b0:11d:38ea:7586 with SMTP id s18-20020a056a203d9200b0011d38ea7586mr22888787pzi.9.1687408138593;
        Wed, 21 Jun 2023 21:28:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a17-20020aa780d1000000b00666e2dac482sm3605318pfn.124.2023.06.21.21.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 21:28:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2205ef1e-9bb6-fb1e-9ca3-367c1afe12ac@roeck-us.net>
Date:   Wed, 21 Jun 2023 21:28:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-15-hch@lst.de>
 <8c1992bc-110a-4dad-8643-766c14bf6fd4@roeck-us.net>
 <20230622035149.GA4667@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 14/24] init: clear root_wait on all invalid root= strings
In-Reply-To: <20230622035149.GA4667@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 20:51, Christoph Hellwig wrote:
> On Wed, Jun 21, 2023 at 02:07:13PM -0700, Guenter Roeck wrote:
>> On Tue, May 23, 2023 at 09:45:25AM +0200, Christoph Hellwig wrote:
>>> Instead of only clearing root_wait in devt_from_partuuid when the UUID
>>> format was invalid, do that in parse_root_device for all strings that
>>> failed to parse.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> In linux-next, almost all of my boot tests from usb drives as well
>> as a few others fail with "Disabling rootwait; root= is invalid."
>> in the log. Bisect points to this patch.
> 
> Can you send such a log, and the command line you've used?
> 


There are lots of logs at https://kerneltests.org/builders, in the 'next'
column of qemu tests. One example is
https://kerneltests.org/builders/qemu-arm-v7-next/builds/511/steps/qemubuildcommand/logs/stdio

Sample command line:

qemu-system-arm -M mcimx7d-sabre \
      -kernel arch/arm/boot/zImage -no-reboot -snapshot \
      -usb -device usb-storage,drive=d0,bus=usb-bus.1 \
      -drive file=rootfs-armv7a.ext2,if=none,id=d0,format=raw \
      -m 256 -nic user -display none \
      --append "root=/dev/sda rootwait earlycon=ec_imx6q,mmio,0x30860000,115200n8 console=ttymxc0,115200" \
      -dtb arch/arm/boot/dts/imx7d-sdb.dtb \
      -nographic -monitor null -serial stdio

This is with a modified imx_v6_v7_defconfig and root file system from
https://github.com/groeck/linux-build-test/blob/master/rootfs/arm-v7/rootfs-armv7a.ext2.gz

The -EINVAL return value is from

	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')

in devt_from_devname().

Guenter

