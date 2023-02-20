Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5CD69C79F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjBTJYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBTJYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:24:08 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD710A8A;
        Mon, 20 Feb 2023 01:24:03 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 974A6100FC0C8;
        Mon, 20 Feb 2023 10:24:02 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 711B936BBC; Mon, 20 Feb 2023 10:24:02 +0100 (CET)
Date:   Mon, 20 Feb 2023 10:24:02 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v2 4/5] apple-gmux: support MMIO gmux on T2 Macs
Message-ID: <20230220092402.GB25532@wunner.de>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
 <20230216122342.5918-5-orlandoch.dev@gmail.com>
 <cd6beabe-3026-d84e-63fd-3833948ecc1f@redhat.com>
 <20230217110531.6d3c07a1@redecorated-mbp>
 <20230219133956.GA4946@wunner.de>
 <8f2cdd8e-70a5-e2fa-6b63-45ca029e39be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2cdd8e-70a5-e2fa-6b63-45ca029e39be@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 09:44:54AM +0100, Hans de Goede wrote:
> On 2/19/23 14:39, Lukas Wunner wrote:
> > I believe the Mac Pro (the trashcan one) also contains a gmux and
> > an APP000B device in DSDT.  I recall seeing a bug report due to a
> > splat in the gmux driver on that machine.  Back then I confirmed
> > in the schematics that it does contain a gmux, though I think it's
> > only used for brightness, not GPU switching.
> 
> Erm, the Mac Pro (the trashcan one) does not have an internal LCD
> panel, right?  So I don't think the gmux will be used for brightness
> control there ...

Right.  I see now that I even added a comment to apple-gmux.c on that
Mac Pro, I couldn't figure out back then what the gmux was for:

 * (The MacPro6,1 2013 also has a gmux, however it is unclear why since it has
 * dual GPUs but no built-in display.)

Thanks,

Lukas
