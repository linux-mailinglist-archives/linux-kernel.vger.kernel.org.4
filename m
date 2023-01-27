Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876C567E988
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjA0Pd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjA0Pdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:33:54 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA17180009;
        Fri, 27 Jan 2023 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674833630; x=1706369630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TM1hjHi+eDRW+VgPVGPxBuNkCyVsgYLZD5xZEXIA5fc=;
  b=R9p+TXoIVAz56edl6z90CbqrhlJlK3WLXgedw/U9tIUoBMFFFmeLIg42
   n6ILt1/k4g42UkPbu9N2Z+/1c78qFustNck99DCZIGZGDFbzOnUKLNIU2
   mSSexXkPuJT7razt71Qh6xjubyCw2Kh0buv0E9qsj56Q7yz4baZX6BpAD
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jan 2023 07:33:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 07:33:50 -0800
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 27 Jan 2023 07:33:47 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <rdunlap@infradead.org>
CC:     <corbet@lwn.net>, <juri.lelli@redhat.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>
Subject: Re: [PATCH 24/35] Documentation: scheduler: correct spelling
Date:   Fri, 27 Jan 2023 21:03:29 +0530
Message-ID: <1674833609-11434-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20230127064005.1558-25-rdunlap@infradead.org>
References: <20230127064005.1558-25-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Correct spelling problems for Documentation/scheduler/ as reported
>by codespell.
>
>Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>Cc: Ingo Molnar <mingo@redhat.com>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: Juri Lelli <juri.lelli@redhat.com>
>Cc: Vincent Guittot <vincent.guittot@linaro.org>
>Cc: Jonathan Corbet <corbet@lwn.net>
>Cc: linux-doc@vger.kernel.org

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
