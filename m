Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3DC743C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjF3Mt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjF3Mt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:49:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B8E77;
        Fri, 30 Jun 2023 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688129365; x=1719665365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EQgfTYNWWiEu5txig1mO+ZDX4Of6hl6CtWMXSGSxmQk=;
  b=czbk0QO6yXdjNwi3xhEBDPft4vSsgonZtfH85yqPALLE+lOxTnrnRKqT
   FR2chzEK/jq2DOM7Gg5oLMoJDKWY58E8JrqfsVk+M3hEnHRhwMr4+7GtF
   mzYrXOAcfvAwnzMwdPuCexv+0Qk+ms7MLD6lKXzyz5ELeggjaTccsbDMy
   DLAZ65dcjjRVOEm4DuZnz5U+6chP1XCv6o+lZwoXg1UIdQV/3g63EaLmb
   AMtjPvzI37hc45rHeVhZB7NFQCZU6rO/t6a6bbh+Ji0JB2v23627y2BE8
   tbsk887wGaqH+uqE4yA+foyctejNZyE9wdkSf/86cTw0/EH/63q2KUXI8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="347166287"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="347166287"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 05:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="862281313"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="862281313"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Jun 2023 05:49:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Jun 2023 15:49:20 +0300
Date:   Fri, 30 Jun 2023 15:49:20 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: move typec_set_mode(TYPEC_STATE_SAFE)
 to ucsi_unregister_partner()
Message-ID: <ZJ7PUDd5152Tr1nD@kuha.fi.intel.com>
References: <20230626-topic-sm8550-usb-c-audio-fixup-v1-1-bc72fddf3f42@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626-topic-sm8550-usb-c-audio-fixup-v1-1-bc72fddf3f42@linaro.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 06:52:00PM +0200, Neil Armstrong wrote:
> It's better to set TYPEC_STATE_SAFE mode from ucsi_unregister_partner()
> instead of ucsi_partner_change(), ucsi_unregister_partner() is always
> when the partner disconnects.
> 
> Fixes: 25a2bc21c863 ("usb: typec: ucsi: call typec_set_mode on non-altmode partner change")
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki
