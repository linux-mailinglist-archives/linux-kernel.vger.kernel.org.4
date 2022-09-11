Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4855B5008
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiIKQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiIKQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:29:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9462E686;
        Sun, 11 Sep 2022 09:28:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 9so7013348ljr.2;
        Sun, 11 Sep 2022 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7SSYiogdPwy5AgzgPl2zf3eDXRMfkA0ZYbT+p4MLVEs=;
        b=YfbaiPM2c0SQ88+hOjCzIUtdHE9Ib6zAL1KQnXLN/8bjSuRNK9YpRj6KcNxGljUbwj
         mWrbVhBr1Evz8nwZxWcOFR/bEpT2ZS+WnX5olxlxfvBq3iGI01zYlrg2/+XSJd+J79EB
         3TdsWh5qY3c7RkJF82zYUuatGsnc4Aczj523odKFdkpGBElAalXWuWVxk670UpBOSMpo
         A7BtpbXAVhgjCu/pDicsPhmcn5J+k66yykPXWcz8ciEM2D1sBzopAfwoFKpcRVkIbT4r
         MVpyYm0bQ2A4b6sh5d2tBcnlyuXBSHmIxSWg0iFdgs6UIJaYYHRPzT/Zzo9oKhQ2796Y
         m+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7SSYiogdPwy5AgzgPl2zf3eDXRMfkA0ZYbT+p4MLVEs=;
        b=M8DOoSs8wrdr22n4p0BW2zi/99U+8pZH5xHBubpKOe6HJkeaJdHVmvGg4NY83dJZTb
         B0coWa3zB8ssI2LCcs8U2cAxtfEdchLxoL+LszE0yGc+Xr9oJkPya9YF6j64YJjtg4Dz
         XMFZaLBOtI/bdWbm4zfS4SGpB9QPBRzfcwON8iNVRwc5dzV10LkQyEWCWUF0XDBtD4tx
         2jVj2Sg2GckjLHY9h1bp43PychWYoQrY7PlDIXhKdCw9WsEXEPUNRBWf0SGVEBu5us/B
         ey/3s0Kgsn966BY2JsMpixYWfmel+EcsdWlb1wVU+6rMyl760N3PnWhEEF6Ij/u3RJ7H
         DjXA==
X-Gm-Message-State: ACgBeo2z4I4oxvfGXrACD+T4ShnDhWqDT81FQOCjALr5QBd+s51wlnQI
        9QNmTwni4ECU7Vhv7X3gdy/H5+Uxu7AcwQ==
X-Google-Smtp-Source: AA6agR4Zi+innVbGnXfYvPwkXVoV8gF6dyCBDra6YdCBc01e/sbcUiiqLusPVyrZiraGkKfsgQJcqw==
X-Received: by 2002:a2e:890f:0:b0:26b:ddca:863e with SMTP id d15-20020a2e890f000000b0026bddca863emr4819481lji.30.1662913737349;
        Sun, 11 Sep 2022 09:28:57 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id n26-20020a05651203fa00b0049876c2befasm453542lfq.289.2022.09.11.09.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:28:56 -0700 (PDT)
Date:   Sun, 11 Sep 2022 19:28:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Rafael Antognolli <Rafael.Antognolli@intel.com>,
        Scott Bauer <scott.bauer@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: sed-opal: Cache-line-align the cmd/resp
 buffers
Message-ID: <20220911162854.ivoeyzilpboplldw@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-3-Sergey.Semin@baikalelectronics.ru>
 <20220910053203.GB23052@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910053203.GB23052@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph

On Sat, Sep 10, 2022 at 07:32:03AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 09, 2022 at 10:19:16PM +0300, Serge Semin wrote:
> > In accordance with [1] the DMA-able memory buffers must be
> > cacheline-aligned otherwise the cache writing-back and invalidation
> > performed during the mapping may cause the adjacent data being lost. It's
> > specifically required for the DMA-noncoherent platforms. Seeing the
> > opal_dev.{cmd,resp} buffers are used for DMAs in the NVME and SCSI/SD
> > drivers in framework of the nvme_sec_submit() and sd_sec_submit() methods
> > respectively we must make sure the passed buffers are cacheline-aligned to
> > prevent the denoted problem.
>
 
> Same comment as for the previous one, this should work, but I think
> separate allocations for the DMAable buffers would document the intent
> much better.  Given that the opal initialization isn't a fast path
> I don't think that the overhead should matter either.

Thanks for the comment. I see your point. Let's hear the subsystem
maintainers out for their opinion regarding the most suitable solution
in this case. If they get to agree with you I'll resend the series
with altered fixes.

-Sergey
