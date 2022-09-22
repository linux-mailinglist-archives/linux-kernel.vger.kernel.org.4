Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D563C5E634A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiIVNLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIVNLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:11:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CE62E6B7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:11:00 -0700 (PDT)
Date:   Thu, 22 Sep 2022 15:10:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663852258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yv6A/76E+tltxES5+4A1FaT9rfH7150YgXq7d8On6NY=;
        b=MyNVPihH/aymFvS1MohwQSopkc8FtfLHdtPC/NQyR7b5ByP+xnCGSlfUegLCAyDnK9VOGa
        bMlLgiteknamuF4QSe8+PgakrfMkjBH9MvDRZQ4MOo+i2Z88AAX3S/ZiwGO1Z9BCaamIEK
        j6Xe4T059kUmqMIBX2sI3baTQGnncDy6oqtyzrYJEtCa/DGPnuDB4F9w76JMuVMxF0OCz0
        OAMSfuDQiparUTH8YSketUOHkyeXzAZtxpUI5qZhHwMQPVIE5BRtcRecmGjzY27D3MtBGI
        0e9b+h3OTF71/8DxoAbhYl429wIqZ1oTF9wRyItzF/czUm5YJVqE6+AqKFCkwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663852258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yv6A/76E+tltxES5+4A1FaT9rfH7150YgXq7d8On6NY=;
        b=hFqacaiX6dVzFYsh811TS2ZA5PfuMC+0RrTEX2Q9nPKdFNB3t4dos4R0hdQ4ubkiH6BVWa
        YeZPL+hDWWzb3UBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        liu3101@purdue.edu, nogikh@google.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com, dvyukov@google.com
Subject: Re: [PATCH -next] kcov: Switch to use list_for_each_entry() helper
Message-ID: <Yyxe4R/FkWdjdwuX@linutronix.de>
References: <20220922105025.119941-1-chenzhongjin@huawei.com>
 <YyxR2ErlHj6wrR6m@linutronix.de>
 <316fc8ae-b96b-1fb6-4a24-b8bcc6f8b948@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <316fc8ae-b96b-1fb6-4a24-b8bcc6f8b948@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-22 20:22:19 [+0800], Chen Zhongjin wrote:
> Oops... will fix that.

Please _never_ again post patches without testing them first.

Sebastian
