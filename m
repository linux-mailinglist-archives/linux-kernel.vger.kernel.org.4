Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C055E5F22
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIVJ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiIVJ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:57:32 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0AED58A3;
        Thu, 22 Sep 2022 02:56:51 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 15B7A2817F1A5;
        Thu, 22 Sep 2022 11:56:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id F27A028CB9; Thu, 22 Sep 2022 11:56:47 +0200 (CEST)
Date:   Thu, 22 Sep 2022 11:56:47 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        giulio.benetti@micronovasrl.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH v3 0/5] serial: 8250: Add rs485 emulation to 8250_dw
Message-ID: <20220922095647.GA8414@wunner.de>
References: <20200517215610.2131618-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517215610.2131618-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 11:56:05PM +0200, Heiko Stuebner wrote:
> This series tries to revive the work of Giulio Benetti from 2018 [0]
> which seemed to have stalled at that time.
> 
> The board I needed that on also had the additional caveat that it
> uses non-standard pins for DE/RE so needed gpio mctrl layer as well
> and even more special needed to control the RE pin manually not as
> part of it being connected to the DE signal as seems to be the standard.
[...]
> Giulio Benetti (2):
>   serial: 8250: Handle implementations not having TEMT interrupt using
>     em485
>   serial: 8250_dw: add em485 support
> 
> Heiko Stuebner (3):
>   serial: 8520_port: Fix function param documentation
>   dt-bindings: serial: Add binding for rs485 receiver enable GPIO
>   serial: 8250: Support separate rs485 rx-enable GPIO

ICYMI, patch [1/5] of this series got accepted back in the day
and patches [4/5] and [5/5] appeared in slightly modified form in v5.19
(commits b54f7a922d33 and 5ff33917faca).

So only patches [2/5] and [3/5] of this series would have to be
upstreamed in case you're still interested in pursuing them.
Note that a related DT property was introduced with 103dcf2ea2df.
Also note that you got some review comments on this series that
may still need to be addressed.

Just thought I'd let you know as I rediscovered this thread today
when flushing out old e-mails from my inbox.

Thanks,

Lukas
