Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E7C62A99D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiKOWAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiKOWAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:00:12 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104932BB33;
        Tue, 15 Nov 2022 14:00:12 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 28F4437E;
        Tue, 15 Nov 2022 22:00:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 28F4437E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668549611; bh=ubQKfpBspsnDm1OkmKx4B+7Ozk8mMnV3tBoPBx2ELUA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qqtFFqW6h5edJ1JlX6ypc7XJ257Ayg/Vdl7zIvlA+JJl6764ZKWxl65qbLGKvEMgD
         K2MkD7CpqZR4sUUoBN1zn1Kjq+dqDeI6D4oRliz7AWATipabC2KkcxVvZ9fmZVYEo3
         XidZFzcL3KR3e/hri8lOziJIxrCW5ha8YtXnEhygszJFDjl1sQvEBuND0O6oMDRRF0
         T2fu80H9yiQpQKneadYGdDWS7Cas5/xRwlXMb5VBdOTO94I2p0t6cMY3gMa45Kizz/
         IexLQjTSfph1mHFOk8kkZHAxq4fG/CcOG11ZfF/oei/iIDJzK71AcwOMgEkk9VI40U
         yADWw7gaQEz7A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rui Li <me@lirui.org>, Wu XiangCheng <wu.xiangcheng@linux.dev>,
        Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Li <me@lirui.org>
Subject: Re: [PATCH v2] docs/zh_CN: Add userspace-api/accelerators/ocxl
 Chinese translation
In-Reply-To: <20221113071554.476980-1-me@lirui.org>
References: <20221113071554.476980-1-me@lirui.org>
Date:   Tue, 15 Nov 2022 15:00:10 -0700
Message-ID: <878rkbanf9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Li <me@lirui.org> writes:

> Translate the following documents into Chinese:
>
> - userspace-api/accelerators/ocxl.rst
>
> Signed-off-by: Rui Li <me@lirui.org>
> ---
> Changes since v1:
> - Correct translations.
> ---
>  .../zh_CN/userspace-api/accelerators/ocxl.rst | 168 ++++++++++++++++++
>  .../zh_CN/userspace-api/index.rst             |   2 +-
>  2 files changed, 169 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/accelerators/ocxl.rst

Applied, thanks.

jon
