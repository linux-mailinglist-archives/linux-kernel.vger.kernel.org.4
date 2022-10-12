Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78825FC50D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJLMLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJLMLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:11:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68FD7C75C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:11:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 3so14767914pfw.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c/44PLq9ottI45dU+xSojQBvYZtgg63j1lxcaxZpHro=;
        b=HA0A044wtsaHl4C3G/8JgEkwcZLLpfzXZsVuA/1RNbdpREufwt+N0RtEMnLvszbpJH
         bGRgI9y3zh9YwIwT7RozoHk4xyp3AoO8I27gArvcXlnAyzSdE4U3IcmVRknE54zxWh3E
         cpnMMVNLnAdt0yaTPhj0roin2OieYRHViNCl8jxgFzNp4nMdg0IVYMDaSOKgVDTTwQhn
         2tWaz2lXqrP98joxudrZD+HrQ7AOh9B+yJgdsxzXK1a7x2MSIPUjgR65T7WCIt/NrCEQ
         zAxFAFjPO2U1DAXyJj1jwgGxgHHxvpSj619BqLK5lW1zRklK5EwVQjMzZ7El4M/zT8yd
         Szog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/44PLq9ottI45dU+xSojQBvYZtgg63j1lxcaxZpHro=;
        b=7U+b2kcsBGzqnun5//a9fDz804X2O7597t+f5ucM1TfpqCtfRJmnQdz1nY+WLNTMNc
         orpu6Hy8KlsDLyqNAc3JmFkCU03SwLhLbE5RowpSFXcNizp5TSP9hU8tHQiQfISIM3K/
         LN3xZflz7AIpROPWqi3Msvnn9NjpiV29vA3cz94K27Wb65SSnXdNHDs7i0pJihf//wt4
         KDW4803TaW22ZJ4DkwtgAQQ+7yVQ1HrJuRhsk0tHKt7TkTxejPlGpAUl3m/U1KRiNHjd
         Xsjzi7me8y2faFqnsfwKMbaZ9bRjrEx4G3Zk8NgmcpknhZ3G4XsJOMK/F5GMl5MQLBJK
         FP/g==
X-Gm-Message-State: ACrzQf0Xlyz+Tk+H49ZP7VgrCNA1CJsv3OLCJRop5AhtczSMy+VSGjOT
        j6u4IGT80jU5PzMVN93fQfmjMTKth5IPq/V5CBw=
X-Google-Smtp-Source: AMsMyM6TPIfdD8cL4GfK/GMxJyASqLdDYKyqoyG6kvtVwTfgUCU4qo8IAY//NyZkrYrnsLGddv0aVJoy9AgcYyA07/g=
X-Received: by 2002:a63:2212:0:b0:43b:f03d:856a with SMTP id
 i18-20020a632212000000b0043bf03d856amr25027955pgi.192.1665576688101; Wed, 12
 Oct 2022 05:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221003142400.1177057-1-e.velu@criteo.com> <0d7537b3e1ef68440b72f56cc2739aa3efbe52f9.camel@suse.com>
In-Reply-To: <0d7537b3e1ef68440b72f56cc2739aa3efbe52f9.camel@suse.com>
From:   Erwan Velu <erwanaliasr1@gmail.com>
Date:   Wed, 12 Oct 2022 14:11:16 +0200
Message-ID: <CAL2JzuyvsTtUBB8VpbiuKJ2b6vEU_zLYELeYn-pm3-e82AbB_g@mail.gmail.com>
Subject: Re: [PATCH] firmware/dmi: Print product serial number if any
To:     Jean Delvare <jdelvare@suse.com>
Cc:     "e.velu@criteo.com" <e.velu@criteo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> I see the value of this change. However it raises a privacy concern. So
> far, /sys/devices/virtual/dmi/id/product_serial is only readable by
> root. Writing the same string to the kernel log where everybody can
> read it is thus questionable.
>
> I can think of 2 ways to solve that problem:
> 1* I'm not really sure why the serial numbers stored in the DMI table
> were originally considered a secret. So we could change these sysfs
> attributes to mode 644, and then printing them in the kernel log would
> of course be OK.
> 2* We could make your code dependent on
> CONFIG_SECURITY_DMESG_RESTRICT=y. If dmesg is restricted to root then
> including the serial number there is OK, regardless of the permissions
> of /sys/devices/virtual/dmi/id/product_serial .
>
> For simplicity I'd go with option 1, but if people strongly disagree
> with making serial numbers world-readable, we can go with option 2.


Yeah I don't really see why showing a serial host in a dmesg is a
security problem.
We already expose other serials like disk or mac addresses which could
be considered private in the same way.


> Now from an implementation perspective, you chose to go with
> DMI_PRODUCT_SERIAL. That will work fine for vendor systems, however for
> self-assembled systems, DMI_PRODUCT_SERIAL is typically unset and
> DMI_BOARD_SERIAL would be more relevant. So it may make sense to
> fallback to "BSN: <DMI_BOARD_SERIAL>" if DMI_PRODUCT_SERIAL is unset.
> Unless you think such systems are out of scope for the intended purpose
> anyway, in which case your code is OK.

Note we have already the same issue with DMI_BIOS_VERSION vs DMI_BIOS_RELEASE.
On HPE system, reported the VERSION is useless as it points to the
motherboard type (U30/U32..) while the release field is the 'version'
like 2.56. On ODM systems, that is the opposite. \o/
