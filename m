Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16606640BB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbjAJMn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238475AbjAJMnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:43:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98D14FD40
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:43:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 651E2616E1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5E3C433EF;
        Tue, 10 Jan 2023 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673354610;
        bh=s/aWfw6F6utOlNW98zzsWSGXN0pMygbpLEd7zwTYZzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZntC778miNdS45a668aQZNAPX2xLJj9sRb7K1MM6+HAwLmH7bWwMKTARNrSyRkOj5
         raZFhvc3a+VksTzzcxR40f+kPHREL7cLGODZygPskfaa/IbV2CMXg1qA7HO5fnolKw
         UyLCxSFLD9HdiL37337iMBO1VC1C0DH9c/sLLimQ=
Date:   Tue, 10 Jan 2023 13:43:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] driver core: make bus_get_device_klist() static
Message-ID: <Y71dbbbIV1+Erh3u@kroah.com>
References: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
 <CAJZ5v0j7mbvcRWy=Ek00rbfNpsaRb6oGKqC3OaZ+OcASRZt8bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j7mbvcRWy=Ek00rbfNpsaRb6oGKqC3OaZ+OcASRZt8bg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:33:48PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 9, 2023 at 6:58 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > No one calls this function outside of drivers/base/bus.c so make it
> > static so it does not need to be exported anymore.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks for the reviews!
