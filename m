Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEE073DF56
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjFZMfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFZMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:35:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE6510A;
        Mon, 26 Jun 2023 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687782922; x=1719318922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2X73gKfRraYZuAhGQlSUD3OziUlK09NRQyEmxmdiB0A=;
  b=AV7X8L9RJ1RoeSbzxjXq+k64BUNDYb5KMhU+LqRZkD+LAPOKgPniz6gH
   9JERp9qJCbcrVjizIkEeKUxcyS2QGjkN+Avn2VZAFsq7W9KOQavqZkOQb
   C8Jv2CPcbEPc+aH4Vrpj/Z2aTqLsVnHMqKzYzM+kVVypcS1aQ4G/3v0VD
   UBuruscQ+paxHwZn4DTtxkbLJLnmvPK+oRpM/Fs658C1M0ZzJaDpNCZAO
   OHOQlSoXKIcpjNWNE+2XeAYnxq0L7SkG26lUqCDuZGCf9QT7RzLRmugPA
   oWRbUwdurZf/CLVQqnVRuqiNDEx09IjSvV9KmzB+i5CVthVPaKdaVf4CU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="391552684"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="391552684"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 05:35:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="829220129"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="829220129"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jun 2023 05:35:11 -0700
Message-ID: <e387d3e1-c5b2-aeb0-b6f5-fb2763cf35e0@linux.intel.com>
Date:   Mon, 26 Jun 2023 15:36:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/2] Avoid re-initializing XHCI HC during removal
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230531222719.14143-1-quic_wcheng@quicinc.com>
 <ae1a7788-acdd-8964-1450-61a741386fbd@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <ae1a7788-acdd-8964-1450-61a741386fbd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.6.2023 22.46, Wesley Cheng wrote:
> Friendly ping to see if there are any review feedback/concerns with this series?
> 

Looks good to me.
Seems that Greg already applied these

-Mathias

