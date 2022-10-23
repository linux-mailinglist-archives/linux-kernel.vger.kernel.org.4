Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B709A6092C7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJWMlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJWMlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:41:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C06AEB7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 05:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 585AAB80D96
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948D5C433D7;
        Sun, 23 Oct 2022 12:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666528846;
        bh=zeujhYE1bMPLUIcjMh+dFlDPihy8eHXhNHEOtixIc3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzT9dsBVcEod7iC1wfTcwQAnNUvMKbsiPOFsnSoOqmGm/+TMYVFU4ZUTlznCEM9pO
         +aIW6koCs4aIBW+jHIC7X/3N8YliFEHQNbd6fqRVsNPlhS7bTucqxV7QBN+L/o03+G
         T/VYnilixK2ANUqLI7j/DoHxJgn3pblyRFxpjzlc=
Date:   Sun, 23 Oct 2022 14:40:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Subject: Re: [RFC PATCH 1/3] drivers/accel: add new kconfig and update
 MAINTAINERS
Message-ID: <Y1U2Sy3hHmYfveaD@kroah.com>
References: <20221022214622.18042-1-ogabbay@kernel.org>
 <20221022214622.18042-2-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022214622.18042-2-ogabbay@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 12:46:20AM +0300, Oded Gabbay wrote:
> Add a new Kconfig for the accel subsystem. The Kconfig currently
> contains only the basic CONFIG_ACCEL option that will be used to
> decide whether to compile the accel registration code as part of the
> drm core functionality.
> 
> I have taken the liberty to appropriate the dri-devel mailing list and
> the dri-devel IRC channel for the accel subsystem.
> 
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> ---
>  MAINTAINERS           |  8 ++++++++
>  drivers/Kconfig       |  2 ++
>  drivers/accel/Kconfig | 24 ++++++++++++++++++++++++

YOu never use drivers/accel/ again in this patch series, was that
intentional?

thanks,

greg k-h
