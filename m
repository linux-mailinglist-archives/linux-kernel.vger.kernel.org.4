Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C485667C68
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjALRTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjALRSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:18:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540455A8A6;
        Thu, 12 Jan 2023 08:50:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69D2F61FCC;
        Thu, 12 Jan 2023 16:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFEAC433D2;
        Thu, 12 Jan 2023 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673542123;
        bh=GDFXaODgp2a3QGKQdG9AevwWHVtICKR+m7j7hvz6RAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUv5sMv8ihjmXjtFXe4dLOfo6Bu73oRxbuorrSHNoAA53nEnw4y8BYV4aV/fEmyl4
         CQgoMW8blMFi4Zd+dyDH9VasLoJRUeEZn3wnKdZrK7ta8f/ARVQkdsVNO6AWsfoOnc
         iiDMynNkd0NBOQAuD7URjzR9oNQXvTfjQ0PTAqQuwfIVdwmt5aY0Sm9cPFm945yggw
         BN5qLEWjUtKeS0UdTr19Pc2UyFu8Z/c6d0HLxiguH1M5NJJ+aGjsPY4JiHo+VEttGl
         3/07ANEGLOEzPDMidGsfpv3DSmLCi79Wph00D5s66U0QM4MLjtly4JtHDAv2wLZu39
         FdL9IKRaCuDow==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pG0l0-0005Eu-Uz; Thu, 12 Jan 2023 17:48:51 +0100
Date:   Thu, 12 Jan 2023 17:48:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Duke =?utf-8?B?WGluKOi+m+WuieaWhyk=?= <duke_xinanwen@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jerry.meng@quectel.com,
        duke.xin@quectel.com
Subject: Re: [PATCH] USB: serial: option: add Quectel EM05-G modem
Message-ID: <Y8A58iTlKJhAZ+84@hovoldconsulting.com>
References: <20221227095127.117036-1-duke_xinanwen@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221227095127.117036-1-duke_xinanwen@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 01:51:27AM -0800, Duke Xin(辛安文) wrote:
> The EM05-G modem has 2 USB configurations that are configurable via the AT

This is the third (fourth?) patch adding support for "EM05-G". Please
make sure that your patch summaries (Subject) are unique so that it is
possible to tell the patches apart.

I've added GR etc in parenthesis after the model name, but please
remember to do so yourself in the future.

> command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
> the following interfaces, respectively:
> 
> "RMNET" : AT + DIAG + NMEA + Modem + QMI
> "MBIM"  : MBIM + AT + DIAG + NMEA + Modem

Now applied, thanks.

Johan
