Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0DD5E8BA4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIXLAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIXLAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:00:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A7F12762
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53C34B80E07
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 11:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31C4C433C1;
        Sat, 24 Sep 2022 11:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664017240;
        bh=0cgQjrAHRa4yNdePpc3uDLv+zyZLOOX2AQU5LSWA6Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bupviSbQ1r+IZBfJGpRRfzuWRy0Q1QWbJdAei6hRL/4UJc8eLzLvsiDm9E5mnYGDu
         +TYOvqlNb26xnRXAkmVxTghPLLuvoAgAVWUx+vKZtDV/f14CzInJjaWuSDp6aVzg6z
         kKCT/wzGSxdYwkkpaCkmeY4SJoA/HvcwEwKQ1ess=
Date:   Sat, 24 Sep 2022 13:00:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: fix CamelCase variables
Message-ID: <Yy7jVe8BrobRZNfl@kroah.com>
References: <20220918113041.3805576-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918113041.3805576-1-vvidic@valentin-vidic.from.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 01:30:41PM +0200, Valentin Vidic wrote:
> Fix checkpatch warnings for variables: LinkCtrlReg, DeviceID,
> RevisionID, IrqLine.
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_pci.c | 26 ++++++++++-----------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Does not apply to my tree :(
