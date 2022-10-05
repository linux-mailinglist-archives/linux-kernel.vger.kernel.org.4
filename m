Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720DF5F55CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJENrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJENrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:47:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C17B1E1;
        Wed,  5 Oct 2022 06:47:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so35583797ejc.4;
        Wed, 05 Oct 2022 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=t8n7n36Kq5Brs/8Mow/eHX7rdlAPc/jLPoyLOzMuk0Q=;
        b=Yphn6C+OuEPc7v1h/Mf9UdeJdhbnOsGh0l5ZUqHmS9NyqUwasPvAPpCoJNzAVNtN6/
         9KGPPgHRos/usDauZZCQo+oLYD3HNRdeUXpaW5Bod6PFTDTk7esaPDqYMvziLOMrZGXI
         gx3G66nypxHhMUuLqe8erT/ZEqoUXITuT9eomiGjVuH7s6B8uR45AU3eeTrinYFxyLSj
         egh9EBqiBSCODbWzIT9Iip48ALqt9gTxY+bCuOUT0RpiS0Jj/+xxLjzkDWzYEwNu0Pa2
         MYMa1eJLi5yiGs0LPxTXFFF7ZIQUXYH55cjBIRHmxHhEgWkTbug3xqVBVlB8jZevjKOj
         XXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=t8n7n36Kq5Brs/8Mow/eHX7rdlAPc/jLPoyLOzMuk0Q=;
        b=3Oph9KD0LodaVbLNmCw2OGIbQzTpoLFnUve2guFB40y3rrBmeBy80rKEOjAiU16RDO
         9xwbgmzOB7neK+MAU9I0dplvEfSjXtLKrVbhrwM52ZOOQK5Eo1JqZkTyqVKc+B7karRC
         uo6gCZNv9wpwZqyqvsp2K2OUR5aTwPjzEqbmH6D0HI9Dg08FUv7I2xb5pszc6Kd77c8B
         UlKLxUy+XhCZDxIv2+ZQc1B8xlvPPvGXzSJNYWpVQV0hsyA+JdUO/gZwfjrpmd5JK9vm
         OadZ7lzANr5KZcA2/8hj/tZl9b1bwDmN+ujEB4Ke3faehcKqRnORar6NX5BqGOQZ3QJL
         LWyA==
X-Gm-Message-State: ACrzQf0GOOQ/B7+5Z6Q5uLzym8i4fhxoVVcoY+6WzheyMze932GJyRj8
        FCTe2bue9DnWbh13D6hrrkymzJ75wURkLk5Yh3S2aVMrzPfK3g==
X-Google-Smtp-Source: AMsMyM6sZ2BRptEFNx+KYPKXMJj47cW2JGeopeGukS9BIJU4qUczYOC7uN25M1bo8dRM9FGdj69V7IHVRorkrpt7h6E=
X-Received: by 2002:a17:907:60c6:b0:787:af55:87c2 with SMTP id
 hv6-20020a17090760c600b00787af5587c2mr23730051ejc.52.1664977669745; Wed, 05
 Oct 2022 06:47:49 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?0JLRj9GH0LXRgdC70LDQsiDQodCw0LvRjNC90LjQutC+0LI=?= 
        <snordicstr16@gmail.com>
Date:   Wed, 5 Oct 2022 19:47:39 +0600
Message-ID: <CACzz7ux8mGT-d5YPWdkvTw5vg4-LKXUUsunL8sJySOeuYd0G1w@mail.gmail.com>
Subject: MTU does not change
To:     linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi.

I apologize if I wrote in the wrong mail list. I have not found
linux-netdev for questions

I switched from kernel versions 4.9 to 5.15 and found that the MTU on
the interfaces in the bridge does not change.
For example:
I have the following bridge:
bridge      interface
br0          sw1
               sw2
               sw3

And I change with ifconfig MTU.
I see that br0 sw1..sw3 has changed MTU from 1500 -> 1982.

But if i send a ping through these interfaces, I get 1500(I added
prints for output)
I investigated the code and found the reason:
The following commit came in the new kernel:
https://github.com/torvalds/linux/commit/ac6627a28dbfb5d96736544a00c3938fa7ea6dfb

And the behavior of the MTU setting has changed:
>
> Kernel 4.9:
> if (net->ipv4.sysctl_ip_fwd_use_pmtu ||
>    ip_mtu_locked(dst) ||
>    !forwarding)  <--- True
> return dst_mtu(dst) <--- 1982
>
>
> / 'forwarding = true' case should always honour route mtu /
> mtu = dst_metric_raw(dst, RTAX_MTU);
> if (mtu)
> return mtu;



Kernel 5.15:
>
> if (READ_ONCE(net->ipv4.sysctl_ip_fwd_use_pmtu) ||
>    ip_mtu_locked(dst) ||
>    !forwarding) { <--- True
> mtu = rt->rt_pmtu;  <--- 0
> if (mtu && time_before(jiffies, rt->dst.expires)) <-- False
> goto out;
> }
>
> / 'forwarding = true' case should always honour route mtu /
> mtu = dst_metric_raw(dst, RTAX_MTU); <---- 1500
> if (mtu) <--- True
> goto out;


Why is rt_pmtu now used instead of dst_mtu?
Why is forwarding = False called with dst_metric_raw?
Maybe we should add processing when mtu = rt->rt_pmtu == 0?
Could this be an error?

Best regards,
Slava.
