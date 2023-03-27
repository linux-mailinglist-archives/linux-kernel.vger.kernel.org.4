Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627396C9CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjC0Hrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjC0Hri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:47:38 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1FBD59E0;
        Mon, 27 Mar 2023 00:47:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 882F48108;
        Mon, 27 Mar 2023 07:46:06 +0000 (UTC)
Date:   Mon, 27 Mar 2023 10:46:05 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        p.zabel@pengutronix.de
Subject: Re: [PATCH -next] bus: ti-sysc: Use list_for_each_entry() helper
Message-ID: <20230327074605.GZ7501@atomide.com>
References: <20220827094604.3325887-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827094604.3325887-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yang Yingliang <yangyingliang@huawei.com> [220827 12:31]:
> Convert list_for_each() to list_for_each_entry() where applicable.

Thanks applying into omap-for-v6.4/ti-sysc.

Tony
