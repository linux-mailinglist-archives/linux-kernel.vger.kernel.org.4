Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF29965D7A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjADPzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjADPzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:55:37 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CCC3B908
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 07:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1672847738; x=1704383738;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WYhYIKsG/EQ8XSj8zcmkkOWi49eDMFsQFhDMX1Vcb1Q=;
  b=lBzQkqZ7zohSAHTPj4wlug1WPj6LFlONWUf6pmS8hxJ6qw/OX+rq6nJI
   qwStI3i9J+I3WAvlzAaz2DOjhpcbt5Vc7y5K/3lgxVQ48YbMJn/B52M6D
   03v+4bn+0TUI8Xp9HfRrB/bqO03x9B0Dq3enkEdRYPGKvlpwNEsSv6qmj
   s=;
X-IronPort-AV: E=Sophos;i="5.96,300,1665446400"; 
   d="scan'208";a="167744843"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 15:55:37 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id 7A6A2A3026;
        Wed,  4 Jan 2023 15:55:34 +0000 (UTC)
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 4 Jan 2023 15:55:33 +0000
Received: from freeip.amazon.com (10.43.162.56) by
 EX19D003UWC001.ant.amazon.com (10.13.138.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7;
 Wed, 4 Jan 2023 15:55:32 +0000
Date:   Wed, 4 Jan 2023 09:55:10 -0600
From:   Geoff Blake <blakgeof@amazon.com>
To:     <Robin.Murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/arm-cmn: Add shutdown routine
In-Reply-To: <20221215180039.18035-1-blakgeof@amazon.com>
Message-ID: <ab93909a-2c81-302f-9f85-33cf1a745e74@amazon.com>
References: <2bb86e97-6cef-700e-70ed-4f303da10fd9@amazon.com> <20221215180039.18035-1-blakgeof@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.43.162.56]
X-ClientProxiedBy: EX13D40UWA002.ant.amazon.com (10.43.160.149) To
 EX19D003UWC001.ant.amazon.com (10.13.138.144)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin, Will,

Happy new year!  Hope I can get some attention back on this patch.  
Only difference from Robin's is it will do limited logging if spurious 
interrupts still happen to occur on current or future CMN implementations.

Thanks,
Geoff

