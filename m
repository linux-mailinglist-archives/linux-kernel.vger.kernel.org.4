Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BED572380D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjFFGrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjFFGre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A7893;
        Mon,  5 Jun 2023 23:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CB1960F24;
        Tue,  6 Jun 2023 06:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA9BC433D2;
        Tue,  6 Jun 2023 06:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686034052;
        bh=GRbRZYn1eFW4uhI9/dNf+cymOZr1vvX3z+5ugbmHYcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLj/4mY3lpdev0UV+o/6FrGhhELV4RSc644zSZS0U4zccRDAoKPqcee1xeAYnbdLT
         qnd7E4jzmzJyGV7/H8toFy9PgGgGMj5qz+7qJqyizOManFlWl5Dt5YNy5SoHOx61zn
         BeK4drSBfSDPnnhLETwiwfOLDAUr7z3ns6kQL1r8=
Date:   Tue, 6 Jun 2023 08:47:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavan Holla <pholla@chromium.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bleung@chromium.org, pmalani@chromium.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Fix fast_role_swap_current show function
Message-ID: <2023060611-coach-entitle-d4e4@gregkh>
References: <20230605204010.2239676-1-pholla@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605204010.2239676-1-pholla@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 08:40:09PM +0000, Pavan Holla wrote:
> The current implementation mistakenly performs a & operation on
> the output of sysfs_emit. This patch performs the & operation before
> calling sysfs_emit.
> 
> Series-to: LKML <linux-kernel@vger.kernel.org>

What is this line for?

What commit id does this fix?

thanks,

greg k-h
