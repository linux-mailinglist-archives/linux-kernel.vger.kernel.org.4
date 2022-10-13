Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E87B5FD316
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 04:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJMCCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 22:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJMCCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 22:02:02 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31E8A11C6CB;
        Wed, 12 Oct 2022 19:02:01 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 8135D1E80D9D;
        Thu, 13 Oct 2022 10:02:05 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mgpnUz1xtQkV; Thu, 13 Oct 2022 10:02:02 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 6BC2B1E80D9C;
        Thu, 13 Oct 2022 10:02:02 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     skhan@linuxfoundation.org
Cc:     kunyu@nfschina.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ray.huang@amd.com, shuah@kernel.org,
        trenn@suse.com
Subject: Re: [PATCH] power: cpupower: utils: Optimize print_online_cpus and print_offline_cpus function
Date:   Thu, 13 Oct 2022 10:01:20 +0800
Message-Id: <20221013020121.2874-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <14d690a4-d2d5-01db-b2a2-e3c87b4a6394@linuxfoundation.org>
References: <14d690a4-d2d5-01db-b2a2-e3c87b4a6394@linuxfoundation.org>
Reply-To: "Re:[PATCH]"@lists.nfsmail.com,
          "power:cpupower:utils:Optimize"@lists.nfsmail.com,
          print_online_cpus@lists.nfsmail.com, and@lists.nfsmail.com,
          print_offline_cpus@lists.nfsmail.com, function@lists.nfsmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm glad to get your reply. In previous tests, it was found that variable initialization and assignment use mov related instructions. Therefore, when I analyze the code and find that removing some variable initialization and assignment does not affect the function and security, I will try to remove variable initialization.

Find the malloc function and find that its return value is void * type, so it does not need to cast.

thanks,
kunyu

