Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE76F6EE53E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjDYQHI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Apr 2023 12:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjDYQHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:07:07 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2860A210A;
        Tue, 25 Apr 2023 09:07:04 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id BA1EA1C0016;
        Tue, 25 Apr 2023 16:07:01 +0000 (UTC)
Message-ID: <f82bdf01743b11e92873c5c9937ae253bd1c8bb3.camel@hadess.net>
Subject: Re: [PATCH v3] Add rumble support to latest xbox controllers
From:   Bastien Nocera <hadess@hadess.net>
To:     Edward Matijevic <motolav@gmail.com>
Cc:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        svv@google.com
Date:   Tue, 25 Apr 2023 18:07:00 +0200
In-Reply-To: <254bb806-c5ac-371e-4e25-1cfa5c8ce388@gmail.com>
References: <6faea48203e5fe2f4c95106dd95ffceed8c5f236.camel@hadess.net>
         <254bb806-c5ac-371e-4e25-1cfa5c8ce388@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-04-25 at 10:46 -0500, Edward Matijevic wrote:
> > > +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708    0x02fd
> > > +#define
> > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE        0x0b20
> > The 1708 model uses Bluetooth Classic, not Bluetooth LE.
> 
> The new firmware adds Bluetooth LE support to the 1708 
> and prioritizes BLE over Classic which necessitates the change
> The controllers are broken without the "new firmware" IDs which are
> for BLE

Oh! I completely missed that. So both the 1708 and 1797 used Bluetooth
Classic with the old firmware, and support Bluetooth LE with the new
one. Am I understanding this correctly?

If that's right, looks like I might need to update Wikipedia ;)

Seeing as you will be updating the patch for that comment style
problem, you could probably add a reference to this article in the
commit message, it seems authoritative enough:
https://news.xbox.com/en-us/2021/09/08/xbox-controller-firmware-update-rolling-out-to-insiders-starting-today/
