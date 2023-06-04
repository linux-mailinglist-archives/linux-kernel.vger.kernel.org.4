Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C057219A9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 22:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjFDUTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 16:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDUTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 16:19:21 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E4ECA;
        Sun,  4 Jun 2023 13:19:20 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f7f73e90f9so36837661cf.2;
        Sun, 04 Jun 2023 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685909959; x=1688501959;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j+oBLDtdK4BN/9zbs7Zl5vxVBNHYX58rbUl4UduvXQ=;
        b=noneqbGZvGf7kWMFEP3GSCjQQ/prSj+IAzJ/e+cnrbptRrDztGmQKPB05r0JiheRJq
         /hxPU4CScVCBv3V+j3op35gamqdpZ21JPipEF7ni618ixHhxWGinrMJ1IG80lR/wTHsg
         7hR1L0GycD9Aeorczm2KdLzOXg9Wfj1Msx1c2U29/vQw2hltYPABE03hOkVXa75tp6OL
         Dqrii/VB3CBBNWWsW+iRRAhizpYZbYZn4LZ22XMalFTipd5tNva5ZpEDNqDtX4+03J4z
         I/U/7iobaEssZg0pZZ15WX/Om8t6JLN9IvJeYZEToWlum/T+RPeI3T90WQFyJZu+LLRY
         tT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685909959; x=1688501959;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5j+oBLDtdK4BN/9zbs7Zl5vxVBNHYX58rbUl4UduvXQ=;
        b=auJ+GSX/mR39uoXM6OBgboGf6jYFDBuQYa3W7sdsJWoeTvHvm/djW59ST2KGIXgTFQ
         mH+2/djnJufg8GrMqGik88n1QPuq9xiBUVUvV+FhFlDinC7wMi2b9P56/hROODagCM21
         AYAqoVZP22NFLly5U07ed8PIQU0cWYh3qjfCdMj7ZkPglgvmSnn2oFUIequuTGrmijhh
         9CvcraE7RayJePu8WdahpTCv0AEk+8J6PXXvrBbW86YtHLcxvDy5FjqYUbdDnzPoQxtT
         h0hDre78vd7nvsSsct4Qu/Tdt8yGa7Iv6izBIGAARwhecx7lfHTGeADgxnflLraOVzo6
         Q/ng==
X-Gm-Message-State: AC+VfDxjIRqdU6cedLE7jtEn01yATUiqPF7XENFPd1SZ/MulggwUzUh3
        ArFiWfpXw4J6pdxGH/lv4gwMGas/4w==
X-Google-Smtp-Source: ACHHUZ6mbYS2e7NA2EYCjSZfRyqe4+0XcgKq+uRfDlIl4Jn9EW7XXkl/pMArcAPx1gOk2FWLkwzOFA==
X-Received: by 2002:ac8:7fce:0:b0:3f6:820e:5e8e with SMTP id b14-20020ac87fce000000b003f6820e5e8emr4915411qtk.9.1685909959034;
        Sun, 04 Jun 2023 13:19:19 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id v22-20020ac87296000000b003bf9f9f1844sm3580485qto.71.2023.06.04.13.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 13:19:18 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:40d3:18db:d1d3:341e])
        by serve.minyard.net (Postfix) with ESMTPSA id 5B7A81800C3;
        Sun,  4 Jun 2023 20:19:17 +0000 (UTC)
Date:   Sun, 4 Jun 2023 15:19:16 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] USB: serial: return errors from break handling
Message-ID: <ZHzxxOvUvTfl1ATL@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230604123505.4661-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604123505.4661-1-johan@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 02:35:02PM +0200, Johan Hovold wrote:
> This series starts returning errors from break handling and also uses
> that mechanism to report to user space when break signalling is not
> supported (e.g. when device or driver support is missing).
> 
> Note that the tty layer currently returns early but without reporting
> errors when a tty driver does not support break signalling. The intent
> expressed in commit 9e98966c7bb9 ("tty: rework break handling") from
> 2008 appears to be to allow missing support to be reported to user
> space however.

This worked as expected for me.

Tested-by: Corey Minyard <cminyard@mvista.com>

> 
> Johan
> 
> 
> Changes in v2
>  - fix return of potentially uninitialised status variable in
>    io_edgeport as reported by kernel test robot <lkp@intel.com> and Dan
>    Carpenter:
> 
>    https://lore.kernel.org/all/202306031014.qzAY3uQ6-lkp@intel.com/
> 
> 
> Johan Hovold (3):
>   USB: serial: return errors from break handling
>   USB: serial: cp210x: disable break signalling on CP2105 SCI
>   USB: serial: report unsupported break signalling
> 
>  drivers/usb/serial/ark3116.c          |  7 +++--
>  drivers/usb/serial/belkin_sa.c        | 12 ++++++---
>  drivers/usb/serial/ch341.c            | 37 +++++++++++++++++----------
>  drivers/usb/serial/cp210x.c           | 14 +++++++---
>  drivers/usb/serial/digi_acceleport.c  |  7 ++---
>  drivers/usb/serial/f81232.c           |  4 ++-
>  drivers/usb/serial/f81534.c           |  4 ++-
>  drivers/usb/serial/ftdi_sio.c         | 10 +++++---
>  drivers/usb/serial/io_edgeport.c      |  6 +++--
>  drivers/usb/serial/io_ti.c            |  9 +++++--
>  drivers/usb/serial/keyspan.c          |  5 +++-
>  drivers/usb/serial/keyspan_pda.c      |  8 ++++--
>  drivers/usb/serial/mct_u232.c         |  6 ++---
>  drivers/usb/serial/mos7720.c          |  9 ++++---
>  drivers/usb/serial/mos7840.c          |  7 ++---
>  drivers/usb/serial/mxuport.c          |  6 ++---
>  drivers/usb/serial/pl2303.c           | 14 ++++++----
>  drivers/usb/serial/quatech2.c         |  8 ++++--
>  drivers/usb/serial/ti_usb_3410_5052.c | 10 +++++---
>  drivers/usb/serial/upd78f0730.c       |  7 +++--
>  drivers/usb/serial/usb-serial.c       |  4 +--
>  drivers/usb/serial/usb_debug.c        | 13 +++++++---
>  drivers/usb/serial/whiteheat.c        |  7 ++---
>  drivers/usb/serial/xr_serial.c        |  4 +--
>  include/linux/usb/serial.h            |  2 +-
>  25 files changed, 147 insertions(+), 73 deletions(-)
> 
> -- 
> 2.39.3
> 
