Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C89609B63
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJXHeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJXHeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:34:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A714606BE;
        Mon, 24 Oct 2022 00:33:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBE60B80E23;
        Mon, 24 Oct 2022 07:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8049CC433C1;
        Mon, 24 Oct 2022 07:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666596836;
        bh=lW9CkImmOjeDpQd0nmJdHCnr9mBUnADBhPxZZHuiMUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+Dk9uuqlXHmDoKhplrjG0k2MQlZsfNMYCwXgbzxRehDJ6PQMW153oxo16+WKQeCc
         o5mGB1Qp6E3fTs31/I3RoAOb6r/NlOyOMKxyPIU5IRECMbKh8M+NZrfkJ32+5BjQeS
         83wIQ3wWjooxpWib/5REt4cdQzdah2/0fUH5MbUKrY/wsQ55SAHjAC0fy/Hu30Vq5B
         CDl16aLo5WwwazwIpJolWOlVcgUnREL5Ee0F1DD9ub2oI6burezwTZ1KRkBFPte6kB
         MHMZKxtWuxUVEQKGuIkSYstYPwueyj5/6XJt21iimyPRZMgSFlnWRl8AkvhoXTmn39
         40aaQG+o/YVPw==
Date:   Mon, 24 Oct 2022 08:33:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 4/5] mfd: twl6040: switch to using gpiod API
Message-ID: <Y1Y/3/nVj1iJmTKt@google.com>
References: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
 <20220926054421.1546436-4-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926054421.1546436-4-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2022, Dmitry Torokhov wrote:

> This patch switches the dirver from legacy gpio API to a newer gpiod
> API so that we can eventually drop the former.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/mfd/twl6040.c       | 29 +++++++++++++----------------
>  include/linux/mfd/twl6040.h |  5 +++--
>  2 files changed, 16 insertions(+), 18 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
