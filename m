Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9519609FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJXLEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJXLDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393B92F3BA;
        Mon, 24 Oct 2022 04:01:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 168FF611D8;
        Mon, 24 Oct 2022 11:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC90CC433D6;
        Mon, 24 Oct 2022 11:01:45 +0000 (UTC)
Message-ID: <05bba2ef-b47a-fe00-fe0b-8a6e375ab586@xs4all.nl>
Date:   Mon, 24 Oct 2022 13:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 13/14] staging: media: remove davinci vpfe_capture driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20221019152947.3857217-1-arnd@kernel.org>
 <20221019152947.3857217-14-arnd@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20221019152947.3857217-14-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 10/19/22 17:29, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver was for the davinci dm644x and dm3xx platforms that are
> now removed from the kernel, so there are no more users.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

As discussed on irc, it is best if you merge this to due dependencies on
arch/arm/mach-davinci/davinci.h.

Note that there is one more reference to vpfe_capture.h:

Documentation/userspace-api/ioctl/ioctl-number.rst:'V'   C0     media/davinci/vpfe_capture.h                            conflict!

Feel free to fold that in this patch, or make a separate patch removing it.
If you make a separate patch, then you can add my Acked-by for that change.

Regards,

	Hans
