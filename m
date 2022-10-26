Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0060DA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiJZD4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiJZD4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:56:08 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D389A43E63;
        Tue, 25 Oct 2022 20:56:01 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 6E5CC1E80C80;
        Wed, 26 Oct 2022 11:54:35 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jC5nzn9Ck9y4; Wed, 26 Oct 2022 11:54:33 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id F273B1E80C40;
        Wed, 26 Oct 2022 11:54:32 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     neilb@suse.de
Cc:     bvanassche@acm.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        song@kernel.org, willy@infradead.org
Subject: Re: [PATCH] reiserfs: journal: Increase jl pointer check
Date:   Wed, 26 Oct 2022 11:55:50 +0800
Message-Id: <20221026035551.3437-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <166675351102.12462.1842756348742191725@noble.neil.brown.name>
References: <166675351102.12462.1842756348742191725@noble.neil.brown.name>
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


many thanks for your reply. I think I should do something more meaningful
.

