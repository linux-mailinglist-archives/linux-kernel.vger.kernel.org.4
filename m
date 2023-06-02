Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4355371FCED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjFBJBm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Jun 2023 05:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjFBJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:01:13 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054CE51;
        Fri,  2 Jun 2023 02:01:11 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1q50eh-001crI-3l; Fri, 02 Jun 2023 11:01:07 +0200
Received: from ip5b40320d.dynamic.kabel-deutschland.de ([91.64.50.13] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1q50eg-0036yt-To; Fri, 02 Jun 2023 11:01:07 +0200
Message-ID: <1df63fac0075558850331210c28cb8fa534dc116.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v6] sh: avoid using IRQ0 on SH3/4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Date:   Fri, 02 Jun 2023 11:01:06 +0200
In-Reply-To: <71105dbf-cdb0-72e1-f9eb-eeda8e321696@omp.ru>
References: <71105dbf-cdb0-72e1-f9eb-eeda8e321696@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.64.50.13
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey!

On Thu, 2023-06-01 at 23:22 +0300, Sergey Shtylyov wrote:
> IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
> return -EINVAL instead.  However, the kernel code supporting SH3/4 based
> SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
> IRQ #s from 16 instead.
> 
> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> indeed are using IRQ0 for the SMSC911x compatible Ethernet chip...

I don't have time today, but I will look at all current SH patches over the
weekend. Thanks a lot for being so persistent.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
