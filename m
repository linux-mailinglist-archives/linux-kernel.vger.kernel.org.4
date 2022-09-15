Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3F5B95A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiIOHpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIOHpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:45:16 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7744B24BDD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:44:58 -0700 (PDT)
Received: from localhost (unknown [185.122.133.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0597477D;
        Thu, 15 Sep 2022 07:44:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0597477D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663227892; bh=cRUlwF+s0iJ7JuhPvZh6GgbN8BxpSN3iwOamz7holVk=;
        h=From:To:Cc:Subject:Date:From;
        b=LnCRZcuRboCJy88Js1WALxuTtdXpvkfPqHQUk1H1MMlC39l3k/3M9BoEZMZCFpFFM
         tFXLBnF3ZG0TE+doFD0+VAAmgPw/MbgK0Dvj51+fOdukwPmOddWxnHJl8UKz4otr4I
         X8NzoeZR60PF/f3kr9S9gdl7DE1H4q/qQqiqbZPfI8GhJKc2x/nneLmMwTxxl8wf2Q
         U7B/Vi1rbyiHo0zbPFqSfPIqPxWwIviFGsBmjxjNqMcb3KT5qDgGoMMdWChQDqk/l0
         TEdPM+ImpMLIB2bm/0s1fiZ+5jjO/q/jl7G4OX7JyuQ7LYnQPfPVfbJy5dTPp6MRqn
         7B9vtgco71U3w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Cc:     tab-elections@lists.linuxfoundation.org,
        tech-board@lists.linuxfoundation.org
Subject: Results from the 2022 LF TAB election
Date:   Thu, 15 Sep 2022 01:44:49 -0600
Message-ID: <87h71984jy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were 960 eligible voters for the 2022 Linux Foundation Technical
Advisory Board election, of whom 267 cast ballots.  The results were:

1. Kees Cook
2. Christian Brauner
3. Jakub Kicinski
4. Dan Williams
5. Dave Hansen
---
6. Chris Mason
7. KP Singh

The top five candidates will serve two-year terms on the TAB.  Thanks to
all who participated in this years election; please reach out to
tab-elections@lists.linuxfoundation.org if you have any questions.

jon

P.S. On a personal note: a special "thank you" to Chris Mason, who has
     led the TAB well for many years.

