Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1484727C98
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjFHKSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbjFHKSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:18:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF4C2D4F;
        Thu,  8 Jun 2023 03:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686219479; x=1717755479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wkfUea5iBEpBashTvelasn3tuZ4SoK0LqgduwN/VK8k=;
  b=XOqSjZV0oF7Q0SlANcNd+koEgfi8S8fqLACnvQQBlgWhjdNcMCD8GAy2
   EL7pIhDZ3jxDqQrODTKUOfu85oA0j9k9YVwehHejftCAgqP3mCFTPRREq
   OKbzpaHkuqioto4o+s75IbQtTDAv4Mh9oXw0eJUDUmrPlkJgA86OuImT8
   cpsbRJCMIyc0i/r/I/5uGfZzr7Yc97+mAnT4NLp2KHfMBGHXi0G+mJ/YO
   LcflWLU31QK9KjR/s6eEGbUM4hGtU3ADQUsowQC04Wyf7cem7wHDk5qYY
   n+P7VvwHH8GJ+zXAwj0cQbUik0KdYt+gmHgCFn2bw8aQFIyHoeAeRe7jq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="360603152"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="360603152"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 03:17:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="687331946"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="687331946"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 03:17:56 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 07D11120BE1;
        Thu,  8 Jun 2023 13:17:54 +0300 (EEST)
Date:   Thu, 8 Jun 2023 10:17:53 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-media@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: Assign Shawn Tu's sensor drivers to
 myself
Message-ID: <ZIGq0bXuumhL9R5V@kekkonen.localdomain>
References: <20230608094257.4054914-1-sakari.ailus@linux.intel.com>
 <20230608-blaspheme-goofball-8a11ac2c7118@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608-blaspheme-goofball-8a11ac2c7118@wendy>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Thu, Jun 08, 2023 at 10:55:51AM +0100, Conor Dooley wrote:
> On Thu, Jun 08, 2023 at 12:42:57PM +0300, Sakari Ailus wrote:
> > Shawn Tu's e-mail address is bouncing and he hasn't told he has a new one:
> > 
> >    shawnx.tu@intel.com
> >    Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound;
> >    Recipient not found by SMTP address lookup'
> > 
> > Assign the sensor drivers Shawn maintained to myself.
> 
> Sweet, much better than orphaning stuff, thanks!
> 
> > Reported-by: Conor Dooley <conor@kernel.org>
> 
> Not really important for a reported-by, but if someone gets the chance
> while applying could please you do a
> s/conor@kernel.org/conor.dooley@microchip.com/
> Doesn't really matter if that isn't done though since it is just a
> reported-by, so nw if not.

I've changed that for the patch I'll eventually include in the PR for
Mauro.

-- 
Kind regards,

Sakari Ailus
