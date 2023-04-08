Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E881B6DB9E2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 11:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDHJeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 05:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjDHJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 05:34:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0EBD307;
        Sat,  8 Apr 2023 02:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C254F612BC;
        Sat,  8 Apr 2023 09:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2FEC433EF;
        Sat,  8 Apr 2023 09:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680946463;
        bh=mgnnpPs+zBxUnMqnn4j6QunZO36sjCNHfxBatEKORik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TL8lbZPLxcsSYRxXuunkUy1S823biVJdrjBRStPe4fpRxkIbBQ9QO1PSp37Ul7zqi
         nCJi1w/6dUBUa3d6fkCaUHO7AkRHrZ1kYChL1psm0nyG9f8sqTsXjLu3j4NUIlG+bX
         jyuoD3Lod9Tf+yXgICKEGQYczQiihU31YCmZFeGb6nnIJEf1wQEnfVO0DAS6vbLVgi
         gWDp/Yjcwlmvrm0qvBhOoYa1AIHYYs0YLtksPZhY3nKdHBLMUi3PkUVD2JpduT4PT+
         oZ6wpP3qEitcqwxiWzsqd6t4oInbBucJSFznMBlV/oV2xDBZ/pO1tF/k80R8JNrhKg
         JcurP2XQJkueg==
Date:   Sat, 8 Apr 2023 10:49:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagath Jog J <jagathjog1996@gmail.com>
Subject: Re: [RESEND PATCH v2 0/3] Improve kernel docs
Message-ID: <20230408104938.74a36f7a@jic23-huawei>
In-Reply-To: <cover.1680610554.git.mazziesaccount@gmail.com>
References: <cover.1680610554.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 15:24:15 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> IIO has very nice facilities for efficiently providing data from a
> device to user (and probably also vice-versa - but I've not used that
> direction). Getting started with IIO may not be so simple though - some
> of the concepts like triggers and buffers are quite unique.
> 
> This series tries to make it easier for a newcomer to write his/her first
> IIO driver by adding some documentation to used enums. Series does not
> provide extensive documentation but just documents those few entries I
> have become familiar with - but it still aims to be a starting point for
> others to add missing bits and pieces.
> 
> This series is marked as v2 because the patch 1 was previously sent as a
> stan-alone RFC to collect the missing channel units. RFC can be seen
> here:
> https://lore.kernel.org/all/10a855f9adc1d710150b7f647500c3c6a769f9ca.1677243698.git.mazziesaccount@gmail.com/
> 
> Patches 2 and 3 were added as a result of discussion followed by the
> RFC.

Something odd happened on this resend. Patch 1 didn't make it to me
or patchwork.  I'll reply to previous posting instead.

Jonathan

> 
> Revision history:
> v2 resend:
>     - rebased on v6.3-rc2
> RFCv1 => v2:
>     - added patches 2 and 3
>     - added missing channel type docs provided by Jonathan
>     - added @in front of member names and fix typos pointed by Andy
>     - dropped TODOs as Jonathan clarified the units
> 
> ---
> 
> Matti Vaittinen (3):
>   iio: Add some kerneldoc for channel types
>   iio: add documentation for iio_chan_info_enum
>   doc: Make sysfs-bus-iio doc more exact
> 
>  Documentation/ABI/testing/sysfs-bus-iio |  11 +-
>  include/linux/iio/types.h               |  46 +++++++-
>  include/uapi/linux/iio/types.h          | 134 ++++++++++++++++++++++++
>  3 files changed, 185 insertions(+), 6 deletions(-)
> 
> 
> base-commit: eeac8ede17557680855031c6f305ece2378af326

