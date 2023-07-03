Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C07464B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGCVMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGCVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:12:05 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A22BE5B;
        Mon,  3 Jul 2023 14:12:05 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-78360b822abso196709239f.2;
        Mon, 03 Jul 2023 14:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688418724; x=1691010724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0EoX2DheebN94bt0rFrXPITU8dcwd8m1uYfEeNrV7c=;
        b=iQLJZVNh9bIwOw+2iuKcGUN+cTi274XOHrQU3XI/VjN9FtcxsrB9c66omYyrugnM+E
         pTqi8Url9RRsPDe5Fg31A5Lc5FhwOLeTNWTLBVO6cqp9e9WqK7nydfA8qzeWKo4ZNROl
         io/fmExXuRCxn5swlIEDksXN9mAN2ATKZXnOiNbxnsWEUjiLX1Rr2ov6dbxxpActNidI
         SNF+EpGIzLxllvqmDSqjADEO8X0oYtzWjhWX+OvnN/O9OkUBHlx4tLhx2tcLnA0kMpu1
         YSphP5SZNVGcEPhHs3ICrHlGmVau3nOv5q/MCck0itkB5FdI/aaQd/+S0KKwmGbzMgrU
         n2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688418724; x=1691010724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0EoX2DheebN94bt0rFrXPITU8dcwd8m1uYfEeNrV7c=;
        b=TPzcGV3H/epyID6lFO45pMCWb/JcdYfCqWroGvk7YMu0c3fs0SAcUAPpYwMo3azizj
         BMBqx71hX1GUmhnLA77QorLRLS1QLP9YxEVteo//JpAxnmBGViEdLbwqR+V8MtIo7Z/8
         PHdFq3svUIcbUrfSoeHxVyPnUjf4M2wO7+gQ3Id/ahbako56xxDgk6qpMwzDJoPM628r
         gu1Ur8vee4vVnzO+vY44fQVV8IIza4FJv2C/4/TOGSABvinxddbJbK1dmfSBK/Z4oXE+
         kPJr5Rtkm9awvsM4n6FsoilJaCoFBaPETUQKZ/CszPo/voGoI+QFq39kkrsp0ArAd6VB
         Q4bQ==
X-Gm-Message-State: AC+VfDxt9eiPE5Rz+btnMq0VoVhwOoDFafI7XaBz9ZXvK+wHMMZtDhRP
        Atx3iXrlRlqHokzsdDuHkMo=
X-Google-Smtp-Source: ACHHUZ4OqUrXPGmlKw5P+m0ozv+5LfI/SNPwoveeJPyyu2Ucgkj95xvoM5BFIb0YyAE1aRLVqMlivw==
X-Received: by 2002:a5e:a911:0:b0:77e:3d2f:d1f4 with SMTP id c17-20020a5ea911000000b0077e3d2fd1f4mr11268010iod.15.1688418724252;
        Mon, 03 Jul 2023 14:12:04 -0700 (PDT)
Received: from rivendell ([2a01:4f9:c010:5d73::1])
        by smtp.gmail.com with ESMTPSA id g9-20020a0566380c4900b0042b068d921esm3197911jal.16.2023.07.03.14.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:12:03 -0700 (PDT)
Date:   Mon, 3 Jul 2023 23:11:57 +0200
From:   Enrico Mioso <mrkiko.rs@gmail.com>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Joseph Tartaro <joseph.tartaro@ioactive.com>
Subject: Re: [PATCH] USB: disable all RNDIS protocol drivers
Message-ID: <ZKM5nbDnKnFZLOlY@rivendell>
References: <20221123124620.1387499-1-gregkh@linuxfoundation.org>
 <n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!!

I think the rndis_host USB driver might emit a warning in the dmesg, but disabling the driver wouldn't be a good idea.
The TP-Link MR6400 V1 LTE modem and also some ZTE modems integrated in routers do use this protocol.

We may also distinguish between these cases and devices you might plug in - as they pose different risk levels.

Enrico
