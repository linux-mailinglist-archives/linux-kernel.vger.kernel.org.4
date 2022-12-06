Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E66643FD6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiLFJ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiLFJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:28:57 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390A35F58
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:28:56 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gh17so4717885ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 01:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aQpGqNHxYw+bSAB9c50lX21tcNWSxpddd/mG7+lfCjo=;
        b=FCgNoG35K9sAxR/tLD67EP+lONqVLi8q61xA185kswkEDyhCajPpZEiqXlmi/gU87w
         horZWF3KCDTIMwnEsr6kZ6aruINGqqKZDoqVkHdGepsKG4ZxCL5M1OMgtT8D8rFm14T/
         +FwLXz0rlaem9ccHSkxv/QEBZJEDRHpIVdzT6nWVpYjSBeVyzyioiEg7uC2dMGJ3KUyk
         tO/ifYmrKCCB2M1bmWbwlMgiQ4QZbkjh5n4Fc9py+Fogzn7Bx5RJt+yulv1Y05G1z7fl
         WOglQS8aT/Q5ViFEWPgvNmtgkRPawyRByXccPz5uuBN6Jsn9DZ08wCUbSVZukANpC9UZ
         RZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQpGqNHxYw+bSAB9c50lX21tcNWSxpddd/mG7+lfCjo=;
        b=VEMCT1twmRtJkJFhLHUrl0yvZKUyhs1p8NXEfGQdJ6oT8k5nSVUytzITZHRCA68fpw
         a2JrC1g6b9KtfWr9y2ky2fQ08FVxqT80OCGxrvVzJbQYEzlibYQcNXYN7WmgSdfIIyuz
         ijmF+mfCzxPPpG738RG2YW2x9Or8XOqldtxTi7BKEWl0MRUI/tSVYSP7GJ/fvEkM81/J
         BHr7IrEHfuN8XWT7W5tsPXI2M3KKuUUhMGBGmeDkCEGmORMdkmpWT1K1YHD0IrxRYpIU
         fO1tY8Lz3MdiGnFc0X2sJUVHK0P6/Rlgo9p73QJvGn8/tyhnBb0meuwRrWnMOYoWDzx/
         x5LA==
X-Gm-Message-State: ANoB5plKaUR5839eITV08oRWUvAmsj57svm56EEL53lCTG6WRdiWgceN
        aji1BoqL9/PMyRUuoJiWJzhG1fCrmUhWJrXdebBI
X-Google-Smtp-Source: AA0mqf7bFn8mlIFjmkewjijupe7DsEy2gYiJs5/i4Rk34h6r8MkXUvhRYtU7Q2hy2fGoctsvrcHfBxoU4N5liU6N380=
X-Received: by 2002:a17:906:9bc4:b0:7c0:e310:3193 with SMTP id
 de4-20020a1709069bc400b007c0e3103193mr9513930ejc.653.1670318934770; Tue, 06
 Dec 2022 01:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-2-xieyongji@bytedance.com>
 <20221206081847.GA8771@lst.de> <CACycT3sXHGQt_V=rgwvEv4v8+oUaAOu1T=tWrKePdybMHagzng@mail.gmail.com>
 <20221206084736.GA9507@lst.de>
In-Reply-To: <20221206084736.GA9507@lst.de>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 6 Dec 2022 17:28:43 +0800
Message-ID: <CACycT3uk4FCswFj8VqqPDgdEM73iqMnYSL8j6DYxCiy1FNSvHQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export irq_create_affinity_masks()
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 4:47 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Dec 06, 2022 at 04:40:37PM +0800, Yongji Xie wrote:
> > With the vDPA framework, some drivers (vduse, vdpa-sim) can create
> > software-defined virtio devices and attach them to the virtio bus.
> > This kind of virtio device is not a pci device or a platform device.
> > So it would be needed to export this function if we want to implement
> > the automatic affinity management for the virtio device driver which
> > is binded to this device.
>
> Why are these devices even using interrupts?

They don't use interrupt. But they use a bound workqueue to run the
interrupt callback. So the driver needs an algorithm to choose which
cpu to run the interrupt callback. Then we found the existing
interrupt affinity spreading mechanism is very suitable for this
scenario, so we try to export this function to reuse it.

> The whjole vdpa thing
> is a mess, I also still need to fix up the horrible abuse of the DMA
> API for something that isn't even DMA, and this just seems to spread
> that same mistake even further.

We just want to reuse this algorithm. And it is completely independent
of the IRQ subsystem. I guess it would not mess things up.

Thanks,
Yongji
