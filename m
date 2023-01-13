Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FF4669D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjAMQDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjAMQCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:02:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF09BC351;
        Fri, 13 Jan 2023 07:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673625162; x=1705161162;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rVAuAq0BfESy5E3fTHeb28N28gn8YJ95tDzKu9Kp8Ik=;
  b=F6RRLtpsBrWcSmaAEP2j3RiYetPh1Yep1EZUBgHn1J2z6ONrxlUaMvKZ
   bg7EGmYmuReLSKZ9UQwnzWIOJDGIzi6cJ1Yx6e4JfetZ/vpuOEoqdCJb3
   qQCMiCqJDzFldZDiKBEgNuXn6gfxnxdQDD1SpkXy5ySADhF67agLBZmgL
   13lY2GYv/DFBcEntOlvmTqTiLDv9NO+ccqZUGrehAbZcp+PGUMZjO6XBo
   5aPTdpdY595e+z2tnxd1exqMC9/gwk8w5XJDXJk3lrMnmtW9kOIKCFjaZ
   no5iTpwMkJF3/eawU3XP+Y9AMlnIqOkM9AgA7j48hGHxCsEdAZkjt0ipI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="325279470"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="325279470"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 07:52:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="800627291"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="800627291"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2023 07:52:38 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        John Ogness <john.ogness@linutronix.de>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH rcu v2 05/20] drivers/hwtracing/stm: Remove "select SRCU"
In-Reply-To: <20230113001132.3375334-5-paulmck@kernel.org>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
 <20230113001132.3375334-5-paulmck@kernel.org>
Date:   Fri, 13 Jan 2023 17:52:37 +0200
Message-ID: <871qnysa7u.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.

Accidentally acked the previous version. This appears to be the same.

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Regards,
--
Alex
