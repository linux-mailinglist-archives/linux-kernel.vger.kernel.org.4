Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB734700AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbjELPFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241729AbjELPFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:05:24 -0400
X-Greylist: delayed 377 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 08:05:13 PDT
Received: from albireo.enyo.de (albireo.enyo.de [37.24.231.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110913A86;
        Fri, 12 May 2023 08:05:12 -0700 (PDT)
Received: from [172.17.203.2] (port=46215 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1pxUE3-001oE5-JK; Fri, 12 May 2023 14:58:31 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.96)
        (envelope-from <fw@deneb.enyo.de>)
        id 1pxUE3-000Bf6-1Y;
        Fri, 12 May 2023 16:58:31 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Retire IA64/Itanium support
References: <20230215100008.2565237-1-ardb@kernel.org>
        <87y1nvng1s.fsf@mid.deneb.enyo.de>
        <CAMj1kXGXCFFQQObtkGje=Hym0GuEgR3h85MX8d1_hBb=b3Fxdg@mail.gmail.com>
Date:   Fri, 12 May 2023 16:58:31 +0200
In-Reply-To: <CAMj1kXGXCFFQQObtkGje=Hym0GuEgR3h85MX8d1_hBb=b3Fxdg@mail.gmail.com>
        (Ard Biesheuvel's message of "Fri, 12 May 2023 16:45:55 +0200")
Message-ID: <873541ha08.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ard Biesheuvel:

> I brought this up again [0] in the context of GRUB (which has similar
> issues related to EFI the the kernel has) and Adrian suggested to
> raise this discussion more widely, perhaps on the distributions
> mailing list, among other places.
>
> Do you have any recommendations for a venue where we might find the
> right mix of people who can drive this to a conclusion one way or the
> other?

> [0] https://lists.gnu.org/archive/html/grub-devel/2023-05/msg00068.html

I think Adrian's list of lists to concat looks reasonable.
