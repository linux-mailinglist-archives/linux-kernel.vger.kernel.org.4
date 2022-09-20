Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F615BE05F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiITIjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiITIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:38:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BB612AAC;
        Tue, 20 Sep 2022 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663663080; x=1695199080;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZcHgknwU6+PU9nFSjNiwQAIOwGqaV74C0Z3pW9YWivk=;
  b=IdEdu0ZvUhM1buSIoWTJbt/CC30CayF31alEmGY68VwaqT6SRJptsG/+
   wtxn5g3R7cbs4RfgKCWxXd7yfH5TAt2rtKvWjI67Nofah2EZDwjBSyUo4
   MRpYsVKf2+ciUUyh+abiyX1KJGmUZuf/SrJ2J3HC2YjO3SCctBoeoAjDO
   mKkn8m971FOcmgCDbfNsrUCRR+kAeNfUE9nrmmQSmjjVD1T26TQl6+BDQ
   AT3v1B2/CslH2BwhApHmeUXWutfB5W0X14ESW137W47jQh52lqGoEOf9M
   Jw3Y38+iCeseZtPbLLvtqrCMxfhuy/My3XqY4tqBWM/MX8HPqw50IfIFa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="286684739"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="286684739"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:37:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="761217423"
Received: from bdallmer-mobl.ger.corp.intel.com ([10.252.59.238])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:37:57 -0700
Date:   Tue, 20 Sep 2022 11:37:55 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/10] tty: serial: extract serial_omap_put_char()
 from transmit_chars()
In-Reply-To: <20220920052049.20507-8-jslaby@suse.cz>
Message-ID: <ace61434-40e6-35ba-ebc6-3a4f1f7b0c5@linux.intel.com>
References: <20220920052049.20507-1-jslaby@suse.cz> <20220920052049.20507-8-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1069864626-1663663079=:1766"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1069864626-1663663079=:1766
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 20 Sep 2022, Jiri Slaby wrote:

> This non-trivial code is doubled in transmit_chars(), so it deserves its
> own function. This will make next patches easier.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1069864626-1663663079=:1766--
