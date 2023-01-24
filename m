Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0900767934C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjAXImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:42:07 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 00:42:03 PST
Received: from smtpdh17-2.aruba.it (smtpdh17-2.aruba.it [62.149.155.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FB413A878
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:42:03 -0800 (PST)
Received: from [172.16.17.150] ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id KEqbpADnBpR5QKErTpIiAt; Tue, 24 Jan 2023 09:41:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1674549660; bh=YMuaKbb9VEx2xrKXPMDRux57oeMlJAlrRukkUuja3Ws=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=DxdPZD7WBXfPYsw/20+a7VGdeYjv8iucbsLFTZzzGgyHRIUuQdh4UOfrIS1jAWHtP
         OIBWpZWBgc9MSIWjptoRA3NGag71maWXYFPfbNpOZQSrm0j73CuEG24USNO/Wz0neE
         YskjxVP6FVWaUAnHa4Vje1vhZ7xbCpylh7ToWGlLHW2PQY59Z4oldMSX8vORQkxZDK
         8OQAJLd0NlxWoRkjV6XzJivXEbyIn36VIattSf5aZdrfEO0xmv674JenaxyGziG0J6
         qdjo5Lje4pcNN8Xpm/ApQuKtOAvqIlwadXbqjUApf+dEn2pVslJsIE8D26P/V9RaLG
         ltmiMiDj9mRRA==
Message-ID: <83d8742d-f772-4244-4af7-58d355916427@brickedbrain.com>
Date:   Tue, 24 Jan 2023 09:40:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] Input: ads7846 - don't report pressure for ads7845
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Luca Ellero <l.ellero@asem.it>, dmitry.torokhov@gmail.com,
        daniel@zonque.org, m.felsch@pengutronix.de,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230120124544.5993-1-l.ellero@asem.it>
 <20230120124544.5993-2-l.ellero@asem.it>
 <Y8qwQM2zLbboTeth@smile.fi.intel.com>
 <74c917ce-a67c-7b4a-023b-2f2f4fb365b5@brickedbrain.com>
 <Y858otTEDM1ugI0k@smile.fi.intel.com>
Content-Language: en-GB
From:   Luca Ellero <luca.ellero@brickedbrain.com>
In-Reply-To: <Y858otTEDM1ugI0k@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFMI8m8x3KhVukXoo9Zin44F91g/057KjWgDH0/RSgvROLQ+iKfBYI+ZUOjoBpDGj/7EehpnUmzaNGEjIoQtykY30cLLhvt1GTXIBmSFY0pT4UGsXQOy
 V5rZ2USd0hz/x5VYFPy+qv/yvn1DseS4guzwBE0z/M7CLDPqA7lik61qLEbwwLGAnHxAUpxpDKPWPA0hh34bUCgwFl57nuHfLusuTKI4eyo2UCclnqCQCkcY
 gr/Gepco//6kqCr4VHZ2xLJS/GVLJAwq9RTLR2PEJfbMWdD7/DiE6PHX9lltCdcxATDyE+jUrup5PfFOdnHxgGQ0DQHrXNm+eWLGHTS5vwZVqnVsPsOlSBTO
 9jOHUpDts/mIBwRx/0Hj4+S80TTcJtt8zf0i16GuiHv3s5GqH8yhNTCt/747ijEwwHVEXXK9Sq0oM+q3iZa5BfSjLUJyoMikGhQjOq8+b/Q0kAvqTrr9KLtR
 D8/H0Z+1vJZnmwLg4fuioLxnxNBkuFP4y4O5haokRYhN14rm0oYwuTfE0H8q1XFGCIvBN5qsHLBXkvUM44mFGAdi0hF5O3otfdWaD1bbAdg2m2XqS8t/g/wN
 59E=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 13:25, Andy Shevchenko wrote:
> The Fixes tag in accordance with the documentation should refer to the commit
> in the Git history which brought the problem (regression).
> 
>> It's more like this driver has never been tested with ADS7845.
>> Maybe the patches should be considered as a new implementation instead than
>> a bug fix?
> If it's indeed from day 1, then the initial commit can be considered as Fixes
> tag, but I leave it to maintainer to decide.

Hi Andy,
thank you for your reply.
OK, I will add the initial commit as Fixes: tag and resend all the series.
Regards
Luca Ellero


