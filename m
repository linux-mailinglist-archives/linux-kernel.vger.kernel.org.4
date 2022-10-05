Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8ED5F591A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJERZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJERZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:25:53 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F417DF75
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:25:51 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c7so15791797pgt.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=hoatWM9ozoryzp81ugwuVdaw9vFYVzmYTBOT17b7aaI=;
        b=gIFf01eSbK2nZVpULQQ42DWnKsnifrnfUC3C+n75VahsZLw6X4vzvAE2VCPE1j48X0
         IaaNKd/qYL8krO6D3d/aoP9gMlWpx+y3lL7NClxUYU53fEDEEhbfVvZ7aE0aqvAmV4IK
         3y2vFjqYCsjN97+iPd/YqH2yMZej0l7hTXKxgH2VLxsIVo9OOIqo5v/PBf19pcnriVOx
         t/1ieEGtExO1t8rBxYT+5frSnex7m46Hec+pQZzYr1Eu3vJbnWH5zukHNd0QoGHb6DNu
         cBOPZ9XSaw1Li4xEvr8wnq6qlZhHieRk/DcIuLbLP5LbN2Sjnc8DBnkr7+yceNvIu8Nw
         zaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hoatWM9ozoryzp81ugwuVdaw9vFYVzmYTBOT17b7aaI=;
        b=YfgrQw2WWPwYS7vV1HS0N3DB7tdfXFRc9OPWNpsODeSU0MYbCpF5py6HoblsqNCp6Q
         NGDAKWBlFkc+XCNBnFXkBGhwlNIr1pLoOOKft0PwPj+UAD45n4l+akxn0JgeMoc9kApy
         xw9lR0xK8I4vQqRjUhcVkBxxc9a0jrBDszqMWMARQeG4qlBnANNu6/uPd2r378r6bvsi
         aYZEx08Smjc7B69scEXTG+EviDFFZyXoYXGXNRXNWbwfXaEeG6PNE8ISQFzX2WPpa8c+
         JFqAUsvuTftL1xO0aKD8OWwFM7jlC6xhLY+YYpvv/ZSYDUzfAS3250qrDRYEPtmySEpV
         YYdQ==
X-Gm-Message-State: ACrzQf3UmHURXE5J5POsJJokxX1cL+d0CBYmGwDQVCpZPB91K7nTIQsb
        i8meH/ASa2R8cpRgxz57TP9fC5XoUJjfcg==
X-Google-Smtp-Source: AMsMyM4TyVkvtTWOPo0nT5OoEytcoTQ9Csm4KgzKugBBadka1vCy2hdL+79TtN4k8+wmclpr81Shfg==
X-Received: by 2002:a05:6a02:186:b0:439:49a3:479b with SMTP id bj6-20020a056a02018600b0043949a3479bmr733364pgb.171.1664990751147;
        Wed, 05 Oct 2022 10:25:51 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902690700b00176b84eb29asm1777510plk.301.2022.10.05.10.25.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2022 10:25:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v4 2/7] Enable balloon drivers to report inflated memory
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
Date:   Wed, 5 Oct 2022 10:25:47 -0700
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 5, 2022, at 2:01 AM, Alexander Atanasov =
<alexander.atanasov@virtuozzo.com> wrote:

> Add counters to be updated by the balloon drivers.
> Create balloon notifier to propagate changes.

I missed the other patches before (including this one). Sorry, but next
time, please cc me.

I was looking through the series and I did not see actual users of the
notifier. Usually, it is not great to build an API without users.

[snip]=20

> +
> +static int balloon_notify(unsigned long val)
> +{
> +	return srcu_notifier_call_chain(&balloon_chain, val, NULL);

Since you know the inflated_kb value here, why not to use it as an =
argument
to the callback? I think casting to (void *) and back is best. But you =
can
also provide pointer to the value. Doesn=E2=80=99t it sound better than =
having
potentially different notifiers reading different values?

Anyhow, without users (actual notifiers) it=E2=80=99s kind of hard to =
know how
reasonable it all is. For instance, is it balloon_notify() supposed to
prevent further balloon inflating/deflating until the notifier =
completes?
Accordingly, are callers to balloon_notify() expected to relinquish =
locks
before calling balloon_notify() to prevent deadlocks and high latency?

