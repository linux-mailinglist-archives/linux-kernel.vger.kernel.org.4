Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969236A3315
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBZRIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBZRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:08:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D72761A0;
        Sun, 26 Feb 2023 09:08:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1803260C0A;
        Sun, 26 Feb 2023 17:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C097C433EF;
        Sun, 26 Feb 2023 17:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677431285;
        bh=kt7SYli4I5Uy4alKcNgAN4fdF28DfOUOSCsc/4Osc6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k6HAM2B+4vb38HQNrZwGwwcOmSKqLkTgDfNZ1pBoESpdImahIVshVONYuhzGe8fk9
         dKLfHX3fOlVNdAWK09LFSnANf0UGOOhA466NHIHYIMx7oInqJ2nDmWIT73cQUZR9bM
         ysT/Wcv7nkWU6VZ1B9KniU1USk0ZQ21o0B2Uf6d3Th1q/QC0ub7ehEiPLgmh4+be5m
         FwJezH7t7DSy6bYYPxI0yOA4YdVvmyRwdqYOkxvfczgN6wprjkCZZO39EjKyMVeUxb
         Hm8BK6JRag4L9QXdJTLUOAziqpxgJil6U6iplvq2nnnG/LKeuA8gtrtUotj9VLlwkv
         HNyRuR9xmPb0Q==
Date:   Sun, 26 Feb 2023 17:22:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: Improce kernel docs
Message-ID: <20230226172228.2ad4e281@jic23-huawei>
In-Reply-To: <cover.1677331779.git.mazziesaccount@gmail.com>
References: <cover.1677331779.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 15:53:22 +0200
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

Not sure I'll get to these today, so just a quick: typo in cover letter typo
in case I forget.  Improve


> 
> Patches 2 and 3 were added as a result of discussion followed by the
> RFC.
> 
> Revision history:
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
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c

