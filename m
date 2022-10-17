Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAF2601343
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJQQRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJQQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:17:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BF96C112;
        Mon, 17 Oct 2022 09:17:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s20so18265655lfi.11;
        Mon, 17 Oct 2022 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rak2jXyVCxsu9w36iXtNJY2CyxL6z5W907r16DRdiwI=;
        b=qj3B3/oU2nQdqq2/EcGkEys8V2zPRYKApYztZr1sDPMYN5/CrNBtG7eB/6Ji3jIBBZ
         gIwmtUxbvubxV6rNRe66HkTwWZHR/5tGnjaB4VssHYmLTanlCxnY+c2+D14TEexwHjfs
         oqP1Z56YT0KnmfPy/0V2VoRxK4ljmlWedjGvrg/DQVrbKRMX8UPqSJzUfFqWls1Cwzuh
         2ICcU7flL1ktzlxt+Pn3BgCrK93edMP4Z0xs/de9TkUZqQg5nrKxRrPyuIudn93F0ilU
         xr7gvfQ/0CgO3WwdLQ0wXuaDMJCtOp9nATXbbwxWuoH0omfnDm2D7ko6sOp5bettvNO4
         LhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rak2jXyVCxsu9w36iXtNJY2CyxL6z5W907r16DRdiwI=;
        b=MFvQyhnn9Ya3y4OOqxRhGS/r25e35YtV9cuZ6ReEAjhmLXd7R6/t6tS8RynQF7r8Js
         5QF2cni+I8hoVtWRT1hMWStAHqwsDVj4cDzA/1rbTloM4e6m0WmVSQwaozmKHnH1G5aW
         7pHL5AbA9KGOMZ9arZVtwZ7OqEIR0QBSvkeO19nrf+fltIsNsQxHBQWqt8nYgk8uexgg
         o1L/NkKoQ8Ml+BfIH1tFQHBA1yLdhfCXj4ctMuOQLF+SwUd2nn4zVmiUQ+YYhOE7j3BD
         TG0WyGcmAIYBzfuXuWNzVDPi0RvvrteB0tHaKu5DVRYv6ehaaFPBJatOax/OftOwLXoU
         wgnQ==
X-Gm-Message-State: ACrzQf1iVXHEYeeY95bjV0Oe8/jBBhB4znvZO2YeCCqOf1O/6XmdgmTl
        qUoeBB0BgzVAozP2ovZvgmA=
X-Google-Smtp-Source: AMsMyM7rH16sORrYUdovJN8ltutGjWM1TqM0J/X0Vt6B0RjtC0AlAtQyoO0LT81uFeRNEmMZRtvaYQ==
X-Received: by 2002:a05:6512:3247:b0:4a2:8dc4:3889 with SMTP id c7-20020a056512324700b004a28dc43889mr3983880lfr.410.1666023419345;
        Mon, 17 Oct 2022 09:16:59 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id w6-20020a05651204c600b0049ae3ed42e8sm1482468lfq.180.2022.10.17.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:16:58 -0700 (PDT)
Date:   Mon, 17 Oct 2022 19:16:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] nvme-hwmon: Kmalloc the NVME SMART log buffer
Message-ID: <20221017161656.hzmsgqpuvqpmriqs@mobilestation>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-3-Sergey.Semin@baikalelectronics.ru>
 <20221017071832.GB30661@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017071832.GB30661@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph

On Mon, Oct 17, 2022 at 09:18:32AM +0200, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-6.1.

Please note the applied patch doesn't comply with the Keith' notes
Link: https://lore.kernel.org/linux-nvme/YzxueNRODpry8L0%2F@kbusch-mbp.dhcp.thefacebook.com/
Meanwhile without patch #1 (having only the accepted by you patch
applied) the NVME hwmon init now seems contradicting: it ignores one
kmalloc failure (returns zero) but fails on another one (returns
-ENOMEM). I asked you to have a look at the patches #1 and #2 of the
series
Link: https://lore.kernel.org/linux-nvme/20221007100134.faaekmuqyd5vy34m@mobilestation/
and give your opinion whether the re-spin was required: take the
Keith' notes or keep the patches as is. Could you please clarify the
situation?

-Sergey
