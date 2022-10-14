Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D655FE7BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJNDu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiJNDuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:50:22 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F54D10055;
        Thu, 13 Oct 2022 20:50:18 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 9B99B1E80D90;
        Fri, 14 Oct 2022 11:50:12 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a4pEWmYfR3Is; Fri, 14 Oct 2022 11:50:10 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 503A51E80D53;
        Fri, 14 Oct 2022 11:50:09 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     skhan@linuxfoundation.org
Cc:     kunyu@nfschina.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ray.huang@amd.com, shuah@kernel.org,
        trenn@suse.com
Subject: Re: [PATCH] power: cpupower: utils: Optimize print_online_cpus and print_offline_cpus function
Date:   Fri, 14 Oct 2022 11:49:56 +0800
Message-Id: <20221014034957.297865-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <7e2043b9-c7fa-236e-de19-5e290deebbdf@linuxfoundation.org>
References: <7e2043b9-c7fa-236e-de19-5e290deebbdf@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I will make a new patch to determine the malloc memory allocation.

