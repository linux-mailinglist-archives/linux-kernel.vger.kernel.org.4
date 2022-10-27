Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA960F383
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiJ0JTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiJ0JTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:19:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252A62194
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCA24B8255A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5E9C433C1;
        Thu, 27 Oct 2022 09:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666862375;
        bh=im+XU/mgani7pOFdGDjd1Gw/FnAy4a4DtoQPGlW2bRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8mBdx9gPcbUfEKkYnxSi1QlegWqSBGPhE8Vor2kLZ1z4n5D795B5TIY6dZXTsePE
         Qgdbg9v5tX5zfYsz/+hpCsJYWQUDPtMvIC/aVRi37/fYEFREvdWcIzCX+ugoZjizxm
         +fA4jl13KeIuwR356COCRAJA3A/WnQRwY8xIZ9TM=
Date:   Thu, 27 Oct 2022 11:19:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v5 2/6] staging: vt6655: refactor code in
 s_uGetRTSCTSDuration
Message-ID: <Y1pNJMvl89jgq9qz@kroah.com>
References: <cover.1666849707.git.tanjubrunostar0@gmail.com>
 <0e6a307052d3a354a850a502e509f46baccdbe1e.1666849707.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6a307052d3a354a850a502e509f46baccdbe1e.1666849707.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 08:59:04AM +0000, Tanjuate Brunostar wrote:
> refactor long lines of code in the function: s_uGetRTSCTSDuration

Please write full sentences.

Also please read the in-kernel documentation for how to write good
changelog text.  Specifically look at the section entitled "The
canonical patch format" in the kernel file,
Documentation/SubmittingPatches for a description of how to do this
properly.

Do this for all of the patches in this series.

thanks,

greg k-h
