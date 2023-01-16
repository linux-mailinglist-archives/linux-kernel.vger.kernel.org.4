Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B9666B875
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjAPHxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjAPHxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:53:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6FD10433;
        Sun, 15 Jan 2023 23:53:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AC41B80D68;
        Mon, 16 Jan 2023 07:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3777C433EF;
        Mon, 16 Jan 2023 07:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673855591;
        bh=8fJTeCgaIyhz3apariHUwPsx0DvhzauvDCZWpNrI0GE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jm0MfEXTfUYs0r05tOmPh6oABd+ZW3mWMra5B/2HhiiW18s9yGIZLSRGygF71bCWc
         0endRI6Iqy3pt3D937emDfQERHQf2Z4MauAcP3x4ajlAwkgd5iXLoZXYwHHCqvP5WF
         bM+G7Fa9yVYtn6rUDRqDyUHppyWNDyR6UVpun/W9USVvV+qKfvU1FNvc9Q3gXyry0+
         Qp2X9h7i36TYSKlskJ/6e1vIoWKUimYv64qvtdKMUECbOcgYkgb9Nmbt5VJ3e5UuWD
         1ivVf3NFLJEJDHVDpFkfmZWIXquloGrh2wcU25yKZDlElJa9EbukoBKDvDLLjRZUnJ
         nvb8Gp9J5TzEA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pHKJ6-0000LU-HY; Mon, 16 Jan 2023 08:53:29 +0100
Date:   Mon, 16 Jan 2023 08:53:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Duke =?utf-8?B?WGluKOi+m+WuieaWhyk=?= <duke_xinanwen@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jerry.meng@quectel.com,
        duke.xin@quectel.com
Subject: Re: [PATCH v3] USB: serial: option: add Quectel EM05CN (SG) modem
Message-ID: <Y8UCeOZovGzr+cK8@hovoldconsulting.com>
References: <20230116020727.19685-1-duke_xinanwen@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116020727.19685-1-duke_xinanwen@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 06:07:27PM -0800, Duke Xin(辛安文) wrote:
> The EM05CN (SG) modem has 2 USB configurations that are configurable via the AT
> command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
> the following interfaces, respectively:
> 
> "MBIM"  : AT + MBIM + DIAG + NMEA  + MODEM
> "RMNET" : AT + DIAG + NMEA + Modem + QMI
> 
> The detailed description of the USB configuration for each mode as follows:

> Signed-off-by: Duke Xin(辛安文) <duke_xinanwen@163.com>
> ---

Thanks for the update. Patch itself looks good, but you forgot to
include a short changelog here below the --- line.

I've applied both v3 patches now so no need to send a v4 for this, but
please try to remember this for your future contributions.

Johan
