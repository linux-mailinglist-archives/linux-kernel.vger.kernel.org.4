Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B282F673D82
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjASPa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjASPaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:30:15 -0500
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0C981014
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1674142210; x=1705678210;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WvYH3MTuKYqurrQFQNXI1UfCmiwN+JTKO+Dsstj91hU=;
  b=YxTa/jRnhKmg3faelmP4gfW2No2eg4lAjXjowD7OY3Jkv3Vy+o3yChv5
   YXFGsa+RX3KYN9jrNJLHLXk8/VNlJLdkkQSEpjJYx9FAk6IFqe7qOrGyL
   yA2FohW7q9a6wKA8Cjv3Rx8rg+Vpgw6sEqia/XS2GA/tbd3kNSeAQNgcZ
   g=;
X-IronPort-AV: E=Sophos;i="5.97,229,1669075200"; 
   d="scan'208";a="1094187691"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 15:30:08 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id D9ACB161AFB;
        Thu, 19 Jan 2023 15:30:06 +0000 (UTC)
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Thu, 19 Jan 2023 15:30:04 +0000
Received: from freeip.amazon.com (10.43.161.198) by
 EX19D003UWC001.ant.amazon.com (10.13.138.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7;
 Thu, 19 Jan 2023 15:30:03 +0000
Date:   Thu, 19 Jan 2023 09:30:00 -0600
From:   Geoff Blake <blakgeof@amazon.com>
To:     <Robin.Murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/arm-cmn: Add shutdown routine
In-Reply-To: <ab93909a-2c81-302f-9f85-33cf1a745e74@amazon.com>
Message-ID: <adce33d7-4995-3aa6-51bb-1d23600d7abb@amazon.com>
References: <2bb86e97-6cef-700e-70ed-4f303da10fd9@amazon.com> <20221215180039.18035-1-blakgeof@amazon.com> <ab93909a-2c81-302f-9f85-33cf1a745e74@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.43.161.198]
X-ClientProxiedBy: EX13D31UWA002.ant.amazon.com (10.43.160.82) To
 EX19D003UWC001.ant.amazon.com (10.13.138.144)
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin, Will,

Still looking for a follow-up on this patch, would appreciate another 
review cycle. 

-Geoff

