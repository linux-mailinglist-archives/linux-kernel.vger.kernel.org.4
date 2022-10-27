Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1030B60F02D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiJ0Gaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiJ0GaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:30:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3D0A50D0;
        Wed, 26 Oct 2022 23:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04ED8B823FF;
        Thu, 27 Oct 2022 06:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA879C43141;
        Thu, 27 Oct 2022 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666852219;
        bh=8rMlEn2cPIhU9+5+MjcP/zw7A8jQBQSdZW5OQd01JbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuW1FjIgfEGOEZwwb3A8Upi/J/ADdd5wRoBagsnuwzjd4mN/gc3t+Kkd+pZq/GG/B
         5KLXCMuOUzy0nynTGMjoOLX/0Hh2pw3j3HvnYFdM40mPaaMcKbiYG3aIzvkMkjJS50
         CW4/CfM/cKZflNF18Im4yklAXFCin+F2wpJ5MlCU=
Date:   Thu, 27 Oct 2022 08:31:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v1 2/8] LSM: Add an LSM identifier for external use
Message-ID: <Y1olsHWnaEk6+b1L@kroah.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-3-casey@schaufler-ca.com>
 <Y1jMeWl0oV4/2zyE@kroah.com>
 <5396ab1e-9b93-df33-ca49-58dc59459a76@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5396ab1e-9b93-df33-ca49-58dc59459a76@schaufler-ca.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 12:36:34PM -0700, Casey Schaufler wrote:
> >> + *
> >> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> >> + * Copyright (C) Intel Corporation
> > No date for Intel?
> 
> The latest guidance I have received is that Intel does not want a date.

Ok, then I need to have an Intel lawyer sign off on a patch that does
this in order to have that be their official statement.  Otherwise, it
needs a date.

> >> + */
> >> +
> >> +#ifndef _UAPI_LINUX_LSM_H
> >> +#define _UAPI_LINUX_LSM_H
> >> +
> >> +/*
> >> + * ID values to identify security modules.
> >> + * A system may use more than one security module.
> >> + *
> >> + * LSM_ID_XXX values 0 - 31 are reserved for future use
> > Reserved for what?  Why?
> 
> You're not the first person to ask.

And the answer is?

> I'll remove the reserved values for the next version.

Because we asked it will be removed?

confused,

greg k-h
