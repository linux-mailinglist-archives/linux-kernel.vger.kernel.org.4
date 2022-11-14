Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30D1627A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiKNKLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbiKNKJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:09:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4161F2EE;
        Mon, 14 Nov 2022 02:09:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0910C60FB5;
        Mon, 14 Nov 2022 10:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A904C433D6;
        Mon, 14 Nov 2022 10:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668420555;
        bh=jWQkzrzEHBtTNOGM5l+RElQaev9hEMU5V7XbVXjmqM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qjj99Y7S2QmHjq+3RQfpzc40SRg/ZArOulfuP6gdyGI3m1ne2tjRYEKc6rSMzOgi4
         hNg9fDP8RGYWT02tEoe8MZaqCFI4jaI8wZ0cXnsmrAbujPTE4oWXRfr+yeR/CVKY4h
         1jsDph3a11z4Gcbjq0H7pWcG+qKldq/EZsnpY5L3IEKNn39F1abncrtUkN0exPfuxd
         K922FPqt2kW+NujKxRtq58mlOH4+IoNKAziX5jVy+P/rWvrhW2t1NLzauSwCCK6aGF
         w2K36xoCmrD4ySVu07v49qx484xUEkkIkZrm+mA8IgrkRdvlbu82PqQgimd58q5civ
         1Kcm/Voz8Lh6g==
Date:   Mon, 14 Nov 2022 10:09:08 +0000
From:   Lee Jones <lee@kernel.org>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Larry Lai <larry.lai@yunjingtech.com>,
        chengwei <foxfly.lai.tw@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "GaryWang@aaeon.com.tw" <GaryWang@aaeon.com.tw>,
        Musa Lin <musa.lin@yunjingtech.com>,
        Jack Chang <jack.chang@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [PATCH 1/5] mfd: Add
 support for UP board CPLD/FPGA
Message-ID: <Y3ITxA+rkl2ma3Lg@google.com>
References: <20221019022450.16851-1-larry.lai@yunjingtech.com>
 <20221019022450.16851-2-larry.lai@yunjingtech.com>
 <Y1/ik4XGNWsOg5KH@google.com>
 <SG2PR06MB3742D3714B6A255914DC73E4F93F9@SG2PR06MB3742.apcprd06.prod.outlook.com>
 <Y2qQ5fq1kJBdlUYi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2qQ5fq1kJBdlUYi@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2022, gregkh@linuxfoundation.org wrote:

> On Tue, Nov 08, 2022 at 04:31:17PM +0000, Larry Lai wrote:
> > Send again with Text only.
> 
> Sorry, was in HTML format :(

Not sure what Greg is replying to here, but it's not in my inbox.

-- 
Lee Jones [李琼斯]
