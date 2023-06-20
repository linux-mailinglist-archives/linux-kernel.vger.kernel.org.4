Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175B37369C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjFTKrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjFTKrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:47:21 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267F7109;
        Tue, 20 Jun 2023 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687258041; x=1718794041;
  h=message-id:date:mime-version:from:subject:to:
   content-transfer-encoding;
  bh=LiGyIi5cy9gnVhBQtlAYxlUvt+Ow2pTos1J0+GkAM+0=;
  b=dOn+UaXg7j75cDKnDSIk98Om8H6aF1m6WxlGd85hzTcTNa3FYAW12v9+
   yxgkkNkvuhShM2udcGfEMQ3J+imzppgajjeaU5rcgIy2EM2y9xmEqdjAF
   ykY4S4I+SJZNnqHPUv3qmaIoXC99ukHf1YrJvA8d+sTg2GBeVKW7d4HC7
   A=;
X-IronPort-AV: E=Sophos;i="6.00,256,1681171200"; 
   d="scan'208";a="137975961"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:47:19 +0000
Received: from EX19D001EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com (Postfix) with ESMTPS id 36C5C8076B;
        Tue, 20 Jun 2023 10:47:18 +0000 (UTC)
Received: from [192.168.6.72] (10.1.212.33) by EX19D001EUA003.ant.amazon.com
 (10.252.50.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 20 Jun
 2023 10:47:15 +0000
Message-ID: <f8f62216-ffaa-2f4e-ac5f-7dcd86e80a84@amazon.com>
Date:   Tue, 20 Jun 2023 13:47:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From:   "Shenhar, Talel" <talel@amazon.com>
Subject: Inquiring about Debugging Platform Drivers using Crash Utility for
 Kernel Coredump
To:     <linux-debuggers@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.1.212.33]
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D001EUA003.ant.amazon.com (10.252.50.232)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Kernel Community,

I hope this message finds you well.

I'd like to use crash utility for postmortem of my kernel coredump 
analysis.

I was able to collect coredump and able to use various operation from 
within the crash utility such as irq -s,  log, files and others.

I am using: crash-arm64 version: 7.3.0, gdb version: 7.6, kernel version 
4.19.

My specific interest lies in debugging drivers internal state, e.g. 
platform drivers.

For some hands-on experience with crash utility I'd like to start by 
iterating over all the platform drivers and print their names,

However, I am finding it challenging to get started with this process 
and I am uncertain of the best approach to achieve this. I have scoured 
various resources for insights, but the information related to this 
specific usage seems to be scattered and not exhaustive.

Given the collective expertise on this mailing list, I thought it would 
be the best place to seek guidance. Specifically, I would appreciate it 
if you could provide:

Any relevant documentation, guides, or tutorials to debug platform 
drivers using the crash utility for kernel coredump analysis.
Some simple examples of using the crash utility to debug platform 
drivers, if possible.
Any important points or common pitfalls to keep in mind while performing 
this kind of analysis.
Any other tips, best practices, or recommendations to effectively debug 
platform drivers using the crash utility would also be greatly appreciated.

Thank you for your time and assistance. I look forward to hearing from you.

Best regards,
Talel, Shenhar.

