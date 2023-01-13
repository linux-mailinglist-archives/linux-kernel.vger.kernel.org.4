Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E72668F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjAMHeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbjAMHdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:33:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EAF218F;
        Thu, 12 Jan 2023 23:32:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E86AECE200F;
        Fri, 13 Jan 2023 07:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDC2C433EF;
        Fri, 13 Jan 2023 07:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673595126;
        bh=LxZkO3MH/5E+lbem7/069VzeElFiMiZLduEviJxlDEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWebb+giJmeBq+NiPie9arHyZuV1i+o94dZaFbW19BZELhLpw2dy4pZd93+KUDBUB
         uY7pgbt1WPFGfy9gv4itYxHCZ0aLneJYOOwKfRx26d06sWoU+wPSttBAvPjk+aqHxX
         9Xbx122Mau6ccmjw15IWWfIcWqCizoKwok7UleqTUQNKsdU3DH/kGqa9TbeiXnX/r+
         4iykcDNSijPkvhnwKdkXBPUhrkwR9Y0om6TtSQPkBjGbEM1IvRaxVrGXRgi9Rdo7ZK
         dTIUXyqSLT/zvr2giFHQLcp+6TNcWxvptzB/EO/r6vdv9p8Ufx9KPf+66263/wbfTY
         8OHdgt1HGdB0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pGEXw-0005UW-4d; Fri, 13 Jan 2023 08:32:16 +0100
Date:   Fri, 13 Jan 2023 08:32:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Duke =?utf-8?B?WGluKOi+m+WuieaWhyk=?= <duke_xinanwen@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jerry.meng@quectel.com,
        duke.xin@quectel.com
Subject: Re: [PATCH] USB: serial: option: add Quectel EM05CN modem
Message-ID: <Y8EJAN5hf8a8Bj8H@hovoldconsulting.com>
References: <20230113062739.2970-1-duke_xinanwen@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230113062739.2970-1-duke_xinanwen@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:27:39PM -0800, Duke Xin(辛安文) wrote:
> The EM05CN modem has 2 USB configurations that are configurable via the AT
> command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
> the following interfaces, respectively:
> 
> "MBIM"  : AT + MBIM + DIAG + NMEA  + MODEM
> "RMNET" : AT + DIAG + NMEA + Modem + QMI

Thanks for the update. When sending a new revision of patch, make sure
to include a version number in Subject (e.g. in this case "[PATCH v2]
USB: serial: ...).

Also add short changelog below the --- line (so that it doesn't end up
in the git logs).

You again sent two patches with identical Subject adding different
devices. Please add the variant in parenthesis or similar so that we can
tell them apart (e.g. "EM05CN (SG)").

Can you fix that up in a v3 (for both of these patches)?

> Signed-off-by: Duke Xin(辛安文) <duke_xinanwen@163.com>
> ---

Johan
